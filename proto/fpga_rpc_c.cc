#include "fpga_rpc_c.h"

#include <grpc++/grpc++.h>

FPGARPCClient::FPGARPCClient(const std::string &address) :
      stub_(FPGARPC::NewStub(grpc::CreateChannel(address, grpc::InsecureChannelCredentials()))) {}

FPGARPCClient::FPGARPCClient() : FPGARPCClient("localhost:50051") {}

// Takes a batch of jobs and sands them to the server
bool FPGARPCClient::Run(std::vector<Job> &jobs) {
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
  return reply.success();
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
