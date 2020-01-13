#include <string.h>
#include <unistd.h>

#include "cynq/cynq.h"
#include "udmalib/udma.h"

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#define max32    (0xffffffff)
#define top32(x) (x >> 32 & max32)
#define bot32(x) (x & max32)

int main(int argc, char **argv) {
  
  // parse arguments
  if (argc != 3) {
    std::cout << "Invalid arguments" << std::endl;
    std::cout << "\tUsage: " << argv[0] << " input output" << std::endl;
    return -1;
  }

  UdmaRepo repo;
  UdmaDevice *device = repo.device(0);
  memset(device->map(), 0, device->size);
  
  // load image file
  cv::Mat input = cv::imread(argv[1]);
  int height = input.rows;
  int width = input.cols;
  int size = height*width*3;

  // setup buffer pointers
  char *buf0 = device->map();
  char *buf1 = device->map() + size;
  uint64_t buf0addr = device->phys_addr;
  uint64_t buf1addr = device->phys_addr + size;
  
  // copy data into buffer
  int offset = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      buf0[offset+0] = input.at<cv::Vec3b>(y,x)[2];
      buf0[offset+1] = input.at<cv::Vec3b>(y,x)[1];
      buf0[offset+2] = input.at<cv::Vec3b>(y,x)[0];
      offset += 3; 
    }
  }

  // load and run hardware unit
  PRManager prmanager;
  std::cout << "Using pr method" << std::endl;
  prmanager.fpgaLoadShell("Ultra96_100MHz_2");
  paramlist params({
    {"in_pixels_1",  bot32(buf0addr)},
    {"in_pixels_2",  top32(buf0addr)},
    {"out_pixels_1", bot32(buf1addr)},
    {"out_pixels_1", top32(buf1addr)},
    {"image_width",  width},
    {"image_height", height}
  });
  AccelInst inst = prmanager.fpgaRun("Partial_shrek", params);
  inst.wait(); 
  //sleep(1);

  // write generated data to file
  cv::Mat output(height, width, input.type());
  memcpy(output.data, buf1, size);
  cv::imwrite(argv[2], output);

  device->unmap();
}

