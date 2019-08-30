#pragma once

#include <string>

// struct to manage a mapped buffer
typedef struct mapped_device {
  long size;
  long addr;
  int fd;
  char *mmap;
} mapped_udma;

// map a udma buffer
mapped_device mmioGetMmap(std::string dev, long addr, long size);

// free a mapped buffer
void mmioFreeMmap(mapped_device to_free);
