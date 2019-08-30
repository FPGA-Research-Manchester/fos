#pragma once

#include <string>
#include <vector>

// provides access to the udma buffer data and address
class UdmaDevice {
  std::string sysfsPath, devfsPath;
  bool mapped;
  int fd;
public:
  char *buffer;
  const uint64_t phys_addr;
  const uint64_t size;

  UdmaDevice(const std::string &devname);
  ~UdmaDevice();

  char *map();
  void unmap();
};

// finds udma buffers
class UdmaRepo {
  std::vector<UdmaDevice> devices;
public:
  UdmaRepo();

  int count();
  UdmaDevice *device(int index);
};
