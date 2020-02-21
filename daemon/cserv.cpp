#include <iostream>
#include <map>
#include <chrono>
#include <thread>

#include "cynq/cynq.h"
#include "udmalib/udma.h"

#include "blockqueue.h"
#include "ansi.h"

#include <grpc/grpc.h>
#include <grpc++/server.h>
#include <grpc++/server_builder.h>
#include <grpc++/server_context.h>
#include <grpc++/security/server_credentials.h>
#include "proto/fpga_rpc.pb.h"
#include "proto/fpga_rpc.grpc.pb.h"

// magical value definitions
constexpr int history_ticks = 80;         // amount of history elements to keep
constexpr int printout_interval = 300;    // ms between status printouts
constexpr int history_interval = 10;      // ms between history elements
constexpr int logmessage_count = 10;      // amount of log items to display


// class in charge of managing udma buffers
class BufAllocator {
public:
  UdmaRepo repo;
  int bufcount;
  bool *alloced;
  BufAllocator() {
    bufcount = repo.count();
    alloced = new bool[bufcount];
    for (int i = 0; i < bufcount; i++)
      alloced[i] = false;
  }

  ~BufAllocator() {
    delete[] alloced;
  }

  int allocBuf() {
    for (int i = 0; i < bufcount; i++) {
      if (!alloced[i]) {
        alloced[i] = true;
        return i;
      }
    }
    return -1;
  }

  void freeBuf(int bufno) {
    if (bufno >= bufcount) return;
    alloced[bufno] = false;
  }
};

// represents a job to be completed
enum JobState {WAITING, RUNNING, DONE};
class Job {
public:
  std::string accname, peer;
  paramlist params;
  JobState state = WAITING;
  bool error = false;
  int jobno = -1;
  Job(AccJob accjob, std::string peer) {
    accname = accjob.accname();
    this->peer = peer;
    for (auto &param : accjob.parameters())
      params[param.first] = param.second;
  }
  Job() {}
};

class User {
public:
  std::deque<Job*> jobs;
  std::string peername;
};

// round robin access to jobs
class JobManager {
public:
  std::deque<User*> users;
  void addJob(Job* job) {
    for (User *user : users) {
      if (user->peername == job->peer) {
        user->jobs.push_back(job);
        return;
      }
    }
    User *user = new User();
    user->peername = job->peer;
    user->jobs.push_back(job);
    users.push_back(user);
  }
  Job* peekJob() {
    return users.front()->jobs.front();
  }
  Job* popJob() {
    User* user = users.front();
    Job* job = user->jobs.front();

    user->jobs.pop_front();
    users.pop_front();

    if (user->jobs.size() == 0) {
      delete user;
    } else {
      users.push_back(user);
    }

    return job;
  }
  bool hasJobs() {
    return users.size() > 0;
  }
};

// implements the daemon
class DaemonImpl final : public FPGARPC::Service {
  BufAllocator allocator;                             // manager of udma buffers

  PRManager prmanager;                                // manager of fpga

  MQueue<Job*> jobqueue;                              // synchronised queue of incoming jobs
  JobManager jobmanager;


  // std::deque<Job*> jobdeque;                          // queue of jobs waiting for loading
  std::map<Region*, Job*> regionmap;                  // map of jobs on each region
  std::map<Job*, AccelInst> runningjobs;              // map of running jobs and their instances

  std::map<Region*, std::array<int, history_ticks>> jobHistory;  // map of history per region

  // takes runmessage, converts to jobs, passes jobs off to executor queue
  bool runJobs(const RunMessage *runmessage, std::string peer) {
    int jobcount = runmessage->jobs_size();
    addLogMessage("Recieved " + std::to_string(jobcount) + " jobs from " + peer);
    Job **jobs = new Job*[jobcount];

    // build list of jobs from protobuf object
    for (int jobno = 0; jobno < jobcount; jobno++) {
      Job *job = new Job(runmessage->jobs(jobno), peer);
      jobs[jobno] = job;
    }

    for (int jobno = 0; jobno < jobcount; jobno++)
      jobqueue.push(jobs[jobno]);

    // wait for each job to finish
    for (int jobno = 0; jobno < jobcount; jobno++)
      while (jobs[jobno]->state != DONE)
        //std::this_thread::yield();
        std::this_thread::sleep_for(std::chrono::milliseconds(0));
        //std::this_thread::sleep_for(std::chrono::milliseconds(1));

    bool success = true;
    for (int jobno = 0; jobno < jobcount; jobno++)
      if (jobs[jobno]->error)
	success = false;

    // free job memory
    for (int jobno = 0; jobno < jobcount; jobno++)
      delete jobs[jobno];
    delete[] jobs;
    return success;
  }

  void addJobHistory(Region* region, int job) {
    std::array<int, history_ticks> &history = jobHistory[region];
    std::rotate(history.begin(), history.begin() + 1, history.end());
    history[history_ticks-1] = job;
  }

  std::array<std::string, logmessage_count> logMessages;
  void addLogMessage(std::string message) {
    std::rotate(logMessages.begin(), logMessages.begin() + 1, logMessages.end());
    logMessages[logmessage_count-1] = message;
  }

  void executor() {
    auto lastPrintoutTime = std::chrono::high_resolution_clock::now();
    auto lastRecordTime = lastPrintoutTime;
    int jobnumber = 0;
    while(1) {
      // was any action performed this loop?
      bool didthing = false;

      // unload accelerators
      for (auto &jobpair : runningjobs) {
        AccelInst &accel = jobpair.second;
        if (!accel.running()) {
          didthing = true;
          // std::cout << "did unload" << std::endl;
          Job &job = *jobpair.first;
          Region &region = *accel.region;
          prmanager.fpgaUnloadRegions(accel);
          runningjobs.erase(&job);
          regionmap.erase(&region);
          for (auto region : accel.bitstream->stubRegions)
            regionmap.erase(&prmanager.regions.at(region));
          job.state = DONE;
        }
      }

      // pop from queue & load accelerators
      while (!jobqueue.empty()) {
        Job *job = jobqueue.peek();
        jobmanager.addJob(job);
        jobqueue.pop();
      }

      // pop from queue & load accelerators
      while (jobmanager.hasJobs()) {
        didthing = true;
        Job* job = jobmanager.peekJob();
        AccelInst accel;
        try {
          accel = prmanager.fpgaRun(job->accname, job->params);
        } catch (FPGAFullException a) {
          break;
        } catch (std::exception& e) {
	  addLogMessage("Failed to add job " + std::to_string(job->jobno) + "(" + job->accname + ")");
	  addLogMessage("Error was: " + std::string(e.what()));
	  jobmanager.popJob();
	  job->error = true;
	  job->state = DONE;
	  break;
	}
        job->jobno = jobnumber++;
        addLogMessage("Loaded job number " + std::to_string(job->jobno));
        runningjobs[job] = accel;
        regionmap[accel.region] = job;
        for (auto region : accel.bitstream->stubRegions)
          regionmap[&prmanager.regions.at(region)] = job;
        jobmanager.popJob();
      }


      // record region utilisation for top-like output
      auto timenow = std::chrono::high_resolution_clock::now();
      auto timediff = timenow - lastRecordTime;
      long timediffMillis = std::chrono::duration_cast<std::chrono::milliseconds>(timediff).count();
      if (timediffMillis > history_interval) {
        lastRecordTime = timenow;
        for (auto &regionpair : prmanager.regions) {
          Region &region = regionpair.second;
          if (region.locked) {
            Job *job = regionmap[&region];
            int base_index = std::hash<std::string>{}(job->peer) % simple_pallete_size;
	    // colour calculation hoes here
	    int colour = calcshade(simple_pallete[base_index], job->jobno % 16);
            addJobHistory(&region, colour);
          } else {
            addJobHistory(&region, 0);
          }
        }
      }

      // print top-like output
      timenow = std::chrono::high_resolution_clock::now();
      timediff = timenow - lastPrintoutTime;
      timediffMillis = std::chrono::duration_cast<std::chrono::milliseconds>(timediff).count();
      if (!quiet && timediffMillis > printout_interval) {
        lastPrintoutTime = timenow;
        std::cout << "\033[2J\033[1;1H";
        std::cout << ansi4colour(5) << "Buffers Allocated: " << ansi4colour(-1) << std::endl << "   ";
        for (int i = 0; i < allocator.bufcount; i++) {
          if(allocator.alloced[i]) {
            std::cout << ansi4colour(9) << "[" << i << " u] ";
          } else {
            std::cout << ansi4colour(10) << "[" << i << " f] ";
          }
        }
        std::cout << ansi4colour(-1) << std::endl;
        std::cout << ansi4colour(2) << "Jobs Running: " << ansi4colour(-1) << std::endl;
        for (auto &regionpair : prmanager.regions) {
          Region &region = regionpair.second;
          // print current region utilisation
          std::cout << " - " << region.name << ": ";
          if (region.locked) {
            Job *job = regionmap[&region];
            std::cout << job->peer << ": " << job->accname << std::endl;
          } else {
            std::cout << "-" << std::endl;
          }
          // print trace of region history
          std::array<int, history_ticks> &history = jobHistory[&region];
          for (int i = history_ticks - 1; i >= 0; i--) {
            std::cout << ansi24colour(history[i] >> 16, history[i] >> 8, history[i]) << "█";
          }
          std::cout << ansi4colour(-1) << std::endl;
        }
        std::cout << ansi4colour(3) << "Jobs Waiting: " << ansi4colour(-1) << std::endl;
        for (User *user : jobmanager.users) {
          std::cout << " - " << user->peername << std::endl;
          for (Job *job : user->jobs)
            std::cout << "   - " << job->accname << std::endl;
        }

        std::cout << ansi4colour(6) << "Log messages: " << ansi4colour(-1) << std::endl;
        for (std::string &msg : logMessages)
          if (!msg.empty())
            std::cout << " - " << msg << std::endl;
      }

      if (!didthing)
        std::this_thread::yield();
        // std::this_thread::sleep_for(std::chrono::milliseconds(15));
    }
  }


public:
  bool quiet;
  DaemonImpl() {
    prmanager.fpgaLoadShell("Ultra96_100MHz_2");
  }
  std::thread spawn() {
    return std::thread(&DaemonImpl::executor, this);
  }
  grpc::Status Run(grpc::ServerContext *context, const RunMessage *request, RunReturn *response) {
    bool success = runJobs(request, context->peer());
    response->set_success(success);
    return grpc::Status::OK;
  }

  grpc::Status Alloc(grpc::ServerContext *context, const AllocMessage *request, AllocReturn *response) {
    int bufno = allocator.allocBuf();
    response->set_bufno(bufno);
    return grpc::Status::OK;
  }

  grpc::Status Free(grpc::ServerContext *context, const FreeMessage *request, FreeReturn *response) {
    int bufno = request->bufno();
    allocator.freeBuf(bufno);
    return grpc::Status::OK;
  }
};

// main entry point for the daemon
int main(int argv, char **argc) {
  std::cout << "Starting C++ FPGA-PR Driver" << std::endl;

  bool quiet = false;
  for (int i = 1; i < argv; i++) {
    std::string parameter(argc[i]);
    if (parameter == "-q" || parameter == "--quiet")
      quiet = true;
  }

  std::cout << "Starting grpc service" << std::endl;
  DaemonImpl service;
  service.quiet = quiet;
  grpc::ServerBuilder builder;
  builder.AddListeningPort("0.0.0.0:50051", grpc::InsecureServerCredentials());
  builder.RegisterService(&service);
  std::unique_ptr<grpc::Server> server = builder.BuildAndStart();
  std::cout << "Server listening" << std::endl;

  std::cout << "Executor thread starting" << std::endl;
  std::thread execthread = service.spawn();

  std::cout << "Driver running, waiting for threads to exit" << std::endl;
  server->Wait();
  execthread.join();
}
