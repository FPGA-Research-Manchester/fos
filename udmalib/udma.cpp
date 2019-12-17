#include "udma.h"

#include <experimental/filesystem>
#include <fstream>
#include <algorithm>

#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

const std::string sysfsRoot = "/sys/class/udmabuf";
const std::string devfsRoot = "/dev";

// reads hex or dec int from file
uint64_t getIntFromFile(const std::string &path, bool hex) {
  uint64_t phys_addr;
  std::ifstream ifile(path);
  if (hex)
    ifile >> std::hex >> phys_addr;
  else
    ifile >> phys_addr;
  return phys_addr;
}

bool file_exists(const std::string& name) {
  struct stat buffer;
  return (stat(name.c_str(), &buffer) == 0);
}

UdmaDevice::UdmaDevice(const std::string &devname) :
    sysfsPath(sysfsRoot + "/" + devname),
    devfsPath(devfsRoot + "/" + devname),
    mapped(false),
    phys_addr(getIntFromFile(sysfsPath + "/phys_addr", true)),
    size(getIntFromFile(sysfsPath + "/size", false)) {
}

UdmaDevice::~UdmaDevice() {
  unmap();
}

char *UdmaDevice::map() {
  if (mapped)
    return buffer;
  if ((fd  = open(devfsPath.c_str(), O_RDWR|O_SYNC)) != -1) {
    if ((buffer = (char*) mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0)) != MAP_FAILED) {
      mapped = true;
      return buffer;
    }
    close(fd); // mmap failed
  }
  return nullptr; // open failed
}

void UdmaDevice::unmap() {
  if (!mapped)
    return;
  munmap(buffer, size);
  close(fd);
}

// finds loaded udma buffers
UdmaRepo::UdmaRepo () {
  for (int i = 0; ; i++) {
    std::string devname = "udmabuf" + std::to_string(i);
    if (!file_exists(sysfsRoot + "/" + devname)) break;
    devices.emplace_back(devname);
  }
}

int UdmaRepo::count() {
  return devices.size();
}

UdmaDevice *UdmaRepo::device(int index) {
  return &devices[index];
}
