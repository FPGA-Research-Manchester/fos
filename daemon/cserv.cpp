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
constexpr int logmessage_count = 20;

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
  Job(AccJob accjob, std::string peer) {
    accname = accjob.accname();
    this->peer = peer;
    state = WAITING;
    for (auto &param : accjob.parameters())
      params[param.first] = param.second;
  }
  Job() {
  }
  std::string accname, peer;
  paramlist params;
  JobState state;
  int jobno = -1;
};

class DaemonImpl final : public FPGARPC::Service {
  BufAllocator allocator;
  PRManager prmanager;

  MQueue<Job*> jobqueue;                              // synchronised queue of incoming jobs
  std::deque<Job*> jobdeque;                          // queue of jobs waiting for loading
  std::map<Region*, Job*> regionmap;                  // map of jobs on each region
  std::map<Job*, AccelInst> runningjobs;              // map of running jobs and their instances

  std::map<Region*, std::array<int, history_ticks>> jobHistory;  // map of history per region

  // takes runmessage, converts to jobs, passes jobs off to executor queue
  bool runJobs(const RunMessage *runmessage, std::string peer) {
    int jobcount = runmessage->jobs_size();
    Job **jobs = new Job*[jobcount];

    for (int jobno = 0; jobno < jobcount; jobno++) {
      Job *job = new Job(runmessage->jobs(jobno), peer);
      jobqueue.push(job);
      jobs[jobno] = job;
    }

    for (int jobno = 0; jobno < jobcount; jobno++)
      while (jobs[jobno]->state != DONE)
        std::this_thread::yield();

    for (int jobno = 0; jobno < jobcount; jobno++)
      delete jobs[jobno];
    delete[] jobs;
    return true;
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
          prmanager.fpgaUnload(accel);
          runningjobs.erase(&job);
          regionmap.erase(&region);
          for (auto region : accel.bitstream->stubRegions)
            regionmap.erase(&prmanager.regions.at(region));
          job.state = DONE;
        }
      }

      // pop from queue & load accelerators
      while (!jobqueue.empty()) {
        jobdeque.push_back(jobqueue.peek());
        jobqueue.pop();
      }

      // pop from queue & load accelerators
      while (!jobdeque.empty()) {
        didthing = true;
        Job* job = jobdeque.front();
        AccelInst accel;
        try {
          accel = prmanager.fpgaRun(job->accname, job->params);
        } catch (std::runtime_error a) {
          break;
        }
        job->jobno = jobnumber++;
        runningjobs[job] = accel;
        regionmap[accel.region] = job;
        for (auto region : accel.bitstream->stubRegions)
          regionmap[&prmanager.regions.at(region)] = job;
        jobdeque.pop_front();
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
            addJobHistory(&region, 1 + (job->jobno % 14));
          } else {
            addJobHistory(&region, 0);
          }
        }
      }

      // print top-like output
      timenow = std::chrono::high_resolution_clock::now();
      timediff = timenow - lastPrintoutTime;
      timediffMillis = std::chrono::duration_cast<std::chrono::milliseconds>(timediff).count();
      if (timediffMillis > printout_interval) {
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
            std::cout << ansi4colour(history[i]) << "█";
          }
          std::cout << ansi4colour(-1) << std::endl;
        }
        std::cout << ansi4colour(3) << "Jobs Waiting: " << ansi4colour(-1) << std::endl;
        for (Job *waiting : jobdeque)
          std::cout << " - " << waiting->accname << ": " << waiting->peer << std::endl;

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

  std::cout << "Starting grpc service" << std::endl;

  DaemonImpl service;
  grpc::ServerBuilder builder;
  builder.AddListeningPort("0.0.0.0:50051", grpc::InsecureServerCredentials());
  builder.RegisterService(&service);
  // return builder.BuildAndStart();
  std::unique_ptr<grpc::Server> server = builder.BuildAndStart();
  std::cout << "Server listening" << std::endl;

  std::cout << "Executor thread starting" << std::endl;
  std::thread execthread = service.spawn();

  std::cout << "Driver running, waiting for threads to exit" << std::endl;
  server->Wait();
  execthread.join();
}
