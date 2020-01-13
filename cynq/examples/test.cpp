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

  // load and run hardware unit
  PRManager prmanager;
  prmanager.fpgaLoadShell("Ultra96_100MHz_2");
  paramlist params({
    {"in_pixels_1",  bot32(buf0addr)},
    {"in_pixels_2",  top32(buf0addr)},
    {"out_pixels_1", bot32(buf1addr)},
    {"out_pixels_2", top32(buf1addr)},
    {"image_width",  width},
    {"image_height", height}
  });
  AccelInst inst = prmanager.fpgaRun("Partial_sobel", params);
  inst.wait();
  
  // write generated data to file
  cv::Mat output(height, width, input.type());
  memcpy(output.data, buf1, size);
  cv::imwrite(argv[2], output);

  device->unmap();
}
