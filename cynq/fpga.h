#pragma once

#include <string>
#include <fstream>
#include <vector>

constexpr int FPGA_RB_IGNORE_BYTES_CONTROL = 48;
constexpr int FPGA_RB_IGNORE_BYTES_DATA = 44;

enum {
  FPGA_WR_FLAG_FULL_BS = 0,
  FPGA_WR_FLAG_PARTIAL_BS = 1
};

enum {
  FPGA_RB_FLAG_TYPE_CONTROL = 0,
  FPGA_RB_FLAG_TYPE_DATA = 1
};

class FPGAManager {
  std::string sysfsFirm, sysfsFlags, sysfsRBImage, sysfsRBFlags;

  void setFPGAFlags(int flags) {
    std::ofstream flagfile(sysfsFlags);
    flagfile << flags;
    flagfile.close();
    if (!flagfile)
      throw std::runtime_error("Could not write fpga flags");
  }

  void setFPGAFirmware(const std::string &firmware) {
    std::ofstream firmfile(sysfsFirm);
    firmfile << firmware;
    firmfile.close();
    if (!firmfile)
      throw std::runtime_error("Could not write fpga firmware");
  }

  void setFPGAReadbackFlags(int flags) {
    std::ofstream flagfile(sysfsRBFlags);
    flagfile << flags;
    flagfile.close();
    if (!flagfile)
      throw std::runtime_error("Could not write readback flags");
  }

  std::vector<char> performFPGAReadback(int seekoffset) {
    std::ifstream readbackfile(sysfsRBImage, std::ios::binary);
    readbackfile.ignore(seekoffset); 
    std::vector<char> filedata((std::istreambuf_iterator<char>(readbackfile)),
                               std::istreambuf_iterator<char>());
    readbackfile.close();
    if (!readbackfile)
      throw std::runtime_error("Could not open readback file");
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
    setFPGAReadbackFlags(FPGA_RB_FLAG_TYPE_DATA);
    return performFPGAReadback(FPGA_RB_IGNORE_BYTES_DATA);
  }

  std::vector<char> readbackConfig() {
    setFPGAReadbackFlags(FPGA_RB_FLAG_TYPE_CONTROL);
    return performFPGAReadback(FPGA_RB_IGNORE_BYTES_CONTROL);
  }

  void loadFull(const std::string &firmware) {
    setFPGAFlags(FPGA_WR_FLAG_FULL_BS);
    setFPGAFirmware(firmware);
  }

  void loadPartial(const std::string &firmware) {
    setFPGAFlags(FPGA_WR_FLAG_PARTIAL_BS);
    setFPGAFirmware(firmware);
  }
};
