#include <iostream>

#include "udmalib/udma.h"
#include "proto/fpga_rpc_c.h"

#define max32    (0xffffffff)
#define top32(x) (x >> 32 & max32)
#define bot32(x) (x & max32)

// program entry point
int main(int argc, char **argv) {

  // get fpga rpc client instance
  FPGARPCClient fpgaRpc;

  // get free udma buffer from daemon
  UdmaRepo repo;
  int bufno = fpgaRpc.Alloc();
  if (bufno < 0) throw std::runtime_error("Failed to get buffer from daemon");
  UdmaDevice *device = repo.device(bufno);

  // setup buffer pointers
  int elems = 4096;
  int size = elems * sizeof(int);
  int *buf0 = ((int*)device->map()) + 0*elems;
  int *buf1 = ((int*)device->map()) + 1*elems;
  int *buf2 = ((int*)device->map()) + 2*elems;
  uint64_t buf0addr = device->phys_addr + 0*size;
  uint64_t buf1addr = device->phys_addr + 1*size;
  uint64_t buf2addr = device->phys_addr + 2*size;

  // put data into buffer
  for (int i = 0; i < elems; i++) {
    buf0[i] = i;
    buf1[i] = i;
    buf2[i] = -1;
  }

  // build and fire off fpga job
  Job job;
  job.accname = "Partial_vadd";      // set accelerator name
  job.params["global_offset_x"] = 0;
  job.params["global_offset_y"] = 0;
  job.params["global_offset_z"] = 0;
  job.params["ina_lo"] = bot32(buf0addr);
  job.params["ina_hi"] = top32(buf0addr);
  job.params["inb_lo"] = bot32(buf1addr);
  job.params["inb_hi"] = top32(buf1addr);
  job.params["out_lo"] = bot32(buf2addr);
  job.params["out_hi"] = top32(buf2addr);

  std::vector<Job> jobs;                              // create list of jobs
  createOCLJobs(job, jobs, elems, 16, 1, 1, 1, 1);    // generate opencl workgroups
  fpgaRpc.Run(jobs);                                  // send the jobs to the daemon

  int errors = 0;
  for (int i = 0; i < elems; i++) {
    // std::cout << "buf0["  << i << "] = " << buf0[i] << std::endl;
    // std::cout << "buf1["  << i << "] = " << buf1[i] << std::endl;
    std::cout << "buf2["  << i << "] = " << buf2[i] << std::endl;
    if (buf0[i] + buf1[i] != buf2[i]) {
      errors++;
    }
  }

  std::cout << "Completed with " << errors << " errors" << std::endl;

  device->unmap();
  fpgaRpc.Free(bufno);

  return 0;
}
