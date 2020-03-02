#include <iostream>

#include "cynq/fpga.h"

bool printConfig = true, saveReadback = true;
std::string readbackFile = "readback.bin";

int main(int argc, char **argv) {
  std::cout << "Beginning readback test" << std::endl;
  FPGAManager fpga(0);

  std::cout << "Beginning config read..." << std::endl;
  std::vector<char> configdata = fpga.readbackConfig();
  std::cout << "Done! Read " << configdata.size() << " bytes" << std::endl;
  if (printConfig) {
    std::cout << "Config data is: " << std::endl;
    std::cout << std::string(configdata.begin(), configdata.end()) << std::endl;
  }

  std::cout << "Beginning image read..." << std::endl;
  std::vector<char> imagedata = fpga.readbackImage();
  std::cout << "Done! Read " << imagedata.size() << " bytes" << std::endl;
  if (saveReadback) {
    std::cout << "Writing readback data to " << readbackFile << std::endl;
    std::ofstream readbackOut(readbackFile);
    std::copy(imagedata.cbegin(), imagedata.cend(),
        std::ostreambuf_iterator<char>(readbackOut));
  }

  std::cout << "Readback test success!!" << std::endl;
  return 0;
}

