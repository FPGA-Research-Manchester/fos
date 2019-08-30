#include "mmio.h"

#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

// map a udma buffer
mapped_device mmioGetMmap(std::string dev, long addr, long size) {
  mapped_device mmio;
  mmio.size = size;
  mmio.addr = addr;
  if ((mmio.fd  = open(dev.c_str(), O_SYNC|O_RDWR)) != -1)
    mmio.mmap = (char*) mmap(NULL, mmio.size, PROT_READ|PROT_WRITE, MAP_SHARED, mmio.fd, mmio.addr);
  return mmio;
}

// free a mapped buffer
void mmioFreeMmap(mapped_device to_free) {
  munmap(to_free.mmap, to_free.size);
  close(to_free.fd);
}
