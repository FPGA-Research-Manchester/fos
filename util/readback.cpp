#include <iostream>

#include "cynq/fpga.h"

int main(int argc, char **argv) {
  std::cout << "Beginning readback test" << std::endl;
  FPGAManager fpga(0);
  std::cout << "Beginning config read..." << std::endl;
  std::vector<char> configdata = fpga.readbackConfig();
  std::cout << "Done! Read " << configdata.size() << " bytes" << std::endl;
  std::cout << "Beginning image read..." << std::endl;
  std::vector<char> imagedata = fpga.readbackImage();
  std::cout << "Done! Read " << imagedata.size() << " bytes" << std::endl;
  std::cout << "Readback test success!!" << std::endl;
  return 0;
}

