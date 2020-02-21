#include <float.h>
#include <iostream>
#include <thread>

#include "udmalib/udma.h"
#include "proto/fpga_rpc_c.h"

#define max32       (0xffffffff)
#define top32(x)    (x >> 32 & max32)
#define bot32(x)    (x & max32)

// program config
int spamthreads = 8; // number of concurrent rpc connections
int spamrequest = 8; // number of concurrent requests per connection
int inflight = spamthreads * spamrequest; // max inflight requests

// hardware config
std::string hardware_name = "Partial_mandelbrot";
int width = 640, height = 480, iters = 255;
double cre = -0.36, cim = 0.641, zoom = 0.01;
int fixpbits = 29;
double fixpfactor = 1 << fixpbits;
uint64_t float2fix(double a) {
  return (uint64_t)(int64_t) (a * fixpfactor);
}

// thread status management
bool shutdownRequested = false;
bool threadError = false;

// sets up the parameters for the hardware unit
void initParams(int width, int height, double cre, double cim, double zoom, int iters, uint64_t buffer, std::map<std::string, uint32_t> &params) {
  params["ImageWidth"]     = width;
  params["ImageHeight"]    = height;
  params["MaxIterations"]  = iters;
  params["cRe_1"]          = bot32(float2fix(cre));
  params["cRe_2"]          = top32(float2fix(cre));
  params["cIm_1"]          = bot32(float2fix(cim));
  params["cIm_2"]          = top32(float2fix(cim));
  params["zoom_1"]         = bot32(float2fix(zoom));
  params["zoom_2"]         = top32(float2fix(zoom));
  params["display_1"]      = bot32(buffer);
  params["display_2"]      = top32(buffer);
}

// client to constantly request same jobs over and over
void spamClient(int cno) {
  std::cout << "Starting spam client thread no " << cno << std::endl;

  // get fpga rpc client instance
  FPGARPCClient fpgaRpc;
  
  // get free udma buffer from daemon
  UdmaRepo repo;
  int bufno = fpgaRpc.Alloc();
  if (bufno < 0) throw std::runtime_error("Failed to get buffer from daemon");
  UdmaDevice *device = repo.device(bufno);
  uint64_t bufferPhy = device->phys_addr;
  int chunksize = width * height;
  
  // build joblist for submission
  std::vector<Job> jobs;
  for (int i = 0; i < spamrequest; i++) {
    uint64_t phyaddr = bufferPhy + chunksize * i;
    Job& job = jobs.emplace_back();
    job.accname = "Partial_mandelbrot";
    initParams(width, height, cre, cim, zoom, iters, phyaddr, job.params);
  }

  while (!shutdownRequested && !threadError)
    fpgaRpc.Run(jobs);
  
  device->unmap();
  fpgaRpc.Free(bufno);
  std::cout << "Closing spam client thread no " << cno << std::endl;
}

int main(int argc, char **argv) {
  std::cout << "Starting client spammer" << std::endl;


  std::vector<std::thread> threads;

  for (int cno = 0; cno < spamthreads; cno++) {
    threads.emplace_back(spamClient, cno);
  }

  for (std::thread& thread : threads)
    thread.join();

  
  return 0;
}
