#include "fpga_rpc_c.h"

#include <grpc++/grpc++.h>

void createOCLJobs(Job& injob, std::vector<Job>& outjobs,
    int xdim, int xsize, int ydim, int ysize, int zdim, int zsize) {
  if (xdim % xsize != 0 || ydim % ysize != 0 || zdim % zsize != 0)
    throw std::runtime_error("Dimensions not multiple of wg size");
  Job job = injob;
  xdim /= xsize;
  ydim /= ysize;
  zdim /= zsize;
  for (int z = 0; z < zdim; z++) {
    job.params["group_id_z"] = z;
    for (int y = 0; y < ydim; y++) {
      job.params["group_id_y"] = y;
      for (int x = 0; x < xdim; x++) {
        job.params["group_id_x"] = x;
        outjobs.push_back(job);
      }
    }
  }
}



FPGARPCClient::FPGARPCClient(const std::string &address) :
      stub_(FPGARPC::NewStub(grpc::CreateChannel(address, grpc::InsecureChannelCredentials()))) {}

FPGARPCClient::FPGARPCClient() : FPGARPCClient("localhost:50051") {}

// Takes a batch of jobs and sands them to the server
void FPGARPCClient::Run(std::vector<Job> &jobs) {
  RunMessage request;
  for (Job &job : jobs) {
    AccJob *accjob = request.add_jobs();
    accjob->set_accname(job.accname);
    accjob->set_pername(job.accname);
    accjob->mutable_parameters()->insert(job.params.begin(), job.params.end());
  }

  RunReturn reply;
  grpc::ClientContext context;
  grpc::Status status = stub_->Run(&context, request, &reply);

  if (!status.ok())
    throw std::runtime_error("Run RPC Failed");
  if (!reply.success())
    throw std::runtime_error("Daemon failed to execute jobs");
}

int FPGARPCClient::Alloc() {
  AllocMessage request;
  AllocReturn reply;
  grpc::ClientContext context;
  grpc::Status status = stub_->Alloc(&context, request, &reply);
  if (!status.ok())
    throw std::runtime_error("Alloc RPC Failed");
  return reply.bufno();
}

void FPGARPCClient::Free(int bufno) {
  FreeMessage request;
  request.set_bufno(bufno);
  FreeReturn reply;
  grpc::ClientContext context;
  grpc::Status status = stub_->Free(&context, request, &reply);
  if (!status.ok())
    throw std::runtime_error("Free RPC Failed");
}
