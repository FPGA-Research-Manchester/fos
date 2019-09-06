#include "cynq/cynq.h"
#include "udmalib/udma.h"

int main(int argc, char **argv) {
  
  UdmaRepo repo;
  UdmaDevice *device = repo.device(0);
  char *udmabuf = device->map();
  
  int count = 1024;
  int size = count*4;

  uint32_t *buffer0 = (uint32_t*) udmabuf;
  uint32_t *buffer1 = (uint32_t*) &buffer0[count];
  uint32_t *buffer2 = (uint32_t*) &buffer0[2*count];
  
  long buf0addr = device->phys_addr;
  long buf1addr = device->phys_addr + size;
  long buf2addr = device->phys_addr + 2*size;
  
  for (int i = 0; i < count; i++) {
    buffer0[i] = i;
    buffer1[i] = i;
  }


  PRManager prmanager;
  StaticAccelInst vecadd = prmanager.fpgaLoadStatic("Full_vecadd");
  paramlist params({
    {"ocl_sx", 1},
    {"ocl_sy", 1},
    {"ocl_sz", 1},
    {"size", count},
    {"in_a", buf0addr},
    {"in_b", buf1addr},
    {"out",  buf2addr}
  });
  vecadd.programAccel(params);
  vecadd.runAccel();
  vecadd.wait();
  
  for (int i = 0; i < count; i++) {
    std::cout << i << ": " << buffer2[i] << std::endl;
  }
 
  
}
