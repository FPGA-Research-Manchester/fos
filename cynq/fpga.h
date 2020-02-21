#pragma once

#include <string>
#include <fstream>
#include <vector>

enum {
  FPGA_FLAG_WRITE_FULL_BS = 0,
  FPGA_FLAG_WRITE_PARTIAL_BS = 1
};

enum {
  RB_FLAG_TYPE_CONTROL = 0,
  RB_FLAG_TYPE_DATA = 1
};

class FPGAManager {
  std::string sysfsFirm, sysfsFlags, sysfsRBImage, sysfsRBFlags;

  void setFPGAFlags(int flags) {
    std::ofstream flagfile(sysfsFlags);
    if (!flagfile)
      throw std::runtime_error("Could not write fpga flags");
    flagfile << flags;
    flagfile.close();
  }

  void setFPGAFirmware(const std::string &firmware) {
    std::ofstream firmfile(sysfsFirm);
    if (!firmfile)
      throw std::runtime_error("Could not write fpga firmware");
    firmfile << firmware;
    firmfile.close();
  }

  void setFPGAReadbackFlags(int flags) {
    std::ofstream flagfile(sysfsRBFlags);
    if (!flagfile)
      throw std::runtime_error("Could not write readback flags");
    flagfile << flags;
    flagfile.close();
  }

  std::vector<char> performFPGAReadback() {
    std::ifstream readbackfile(sysfsRBImage, std::ios::binary);
    if (!readbackfile)
      throw std::runtime_error("Could not open readback file");
    std::vector<char> filedata((std::istreambuf_iterator<char>(readbackfile)),
                               std::istreambuf_iterator<char>());
    readbackfile.close();
    return filedata;
  }

public:
  FPGAManager(int fpga_id) {
    std::string sysfsRoot = "/sys/class/fpga_manager/fpga" + std::to_string(fpga_id);
    sysfsFirm = sysfsRoot + "/firmware";
    sysfsFlags = sysfsRoot + "/flags";
    sysfsRBImage  = "/sys/kernel/debug/fpga/fpga" + std::to_string(fpga_id) + "/image";
    sysfsRBFlags = "/sys/module/zynqmp_fpga/parameters/readback_type";
  }

  std::vector<char> readbackImage() {
    setFPGAReadbackFlags(RB_FLAG_TYPE_DATA);
    return performFPGAReadback();
  }

  std::vector<char> readbackConfig() {
    setFPGAReadbackFlags(RB_FLAG_TYPE_CONTROL);
    return performFPGAReadback();
  }

  void loadFull(const std::string &firmware) {
    setFPGAFlags(FPGA_FLAG_WRITE_FULL_BS);
    setFPGAFirmware(firmware);
  }

  void loadPartial(const std::string &firmware) {
    setFPGAFlags(FPGA_FLAG_WRITE_PARTIAL_BS);
    setFPGAFirmware(firmware);
  }
};
