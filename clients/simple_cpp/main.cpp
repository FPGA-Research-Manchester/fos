#include <iostream>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#include "udmalib/udma.h"
#include "proto/fpga_rpc_c.h"

#define max32    (0xffffffff)
#define top32(x) (x >> 32 & max32)
#define bot32(x) (x & max32)

// program entry point
int main(int argc, char **argv) {

  // parse arguments
  if (argc != 3) {
    std::cout << "Invalid arguments" << std::endl;
    std::cout << "\tUsage: " << argv[0] << " input output" << std::endl;
    return -1;
  }

  // get fpga rpc client instance
  FPGARPCClient fpgaRpc;

  // get free udma buffer from daemon
  UdmaRepo repo;
  int bufno = fpgaRpc.Alloc();
  if (bufno < 0) throw std::runtime_error("Failed to get buffer from daemon");
  UdmaDevice *device = repo.device(bufno);

  // load image file
  cv::Mat input = cv::imread(argv[1], CV_LOAD_IMAGE_GRAYSCALE);
  int height = input.rows;
  int width = input.cols;
  int size = height*width;

  // setup buffer pointers
  char *buf0 = device->map();
  char *buf1 = device->map() + size;
  uint64_t buf0addr = device->phys_addr;
  uint64_t buf1addr = device->phys_addr + size;

  // copy data into buffer
  memcpy(buf0, input.data, size);

  // build and fire off fpga job
  std::vector<Job> jobs;              // create list of jobs
  Job& job = jobs.emplace_back();     // add job
  job.accname = "Partial_sobel";      // set accelerator name
  job.params["in_pixels"]      = bot32(buf0addr);
  job.params["in_pixels_msb"]  = top32(buf0addr);
  job.params["out_pixels"]     = bot32(buf1addr);
  job.params["out_pixels_msb"] = top32(buf1addr);
  job.params["im_width"]       = width;
  job.params["im_height"]      = height;

  fpgaRpc.Run(jobs);                  // send the jobs to the daemon

  cv::Mat output(height, width, input.type());
  memcpy(output.data, buf1, size);
  cv::imwrite(argv[2], output);

  device->unmap();
  fpgaRpc.Free(bufno);

  return 0;
}
