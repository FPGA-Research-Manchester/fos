#pragma once

#include <string>
#include <fstream>
#include <vector>

class FPGAManager {
  std::string sysfsRoot, sysfsFirm, sysfsFlags;

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
public:
  FPGAManager(int fpga_id) {
    sysfsRoot = "/sys/class/fpga_manager/fpga" + std::to_string(fpga_id);
    sysfsFirm = sysfsRoot + "/firmware";
    sysfsFlags = sysfsRoot + "/flags";
  }

  void loadFull(const std::string &firmware) {
    // if (!firmware)
    setFPGAFlags(0);
    setFPGAFirmware(firmware);
  }

  void loadPartial(const std::string &firmware) {
    setFPGAFlags(1);
    setFPGAFirmware(firmware);
  }
};
