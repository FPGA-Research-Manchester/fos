#include "cynq/cynq.h"
#include "udmalib/udma.h"

#define max32    (0xffffffff)
#define top32(x) (x >> 32 & max32)
#define bot32(x) (x & max32)

int main(int argc, char **argv) {
  
  UdmaRepo repo;
  UdmaDevice *device = repo.device(0);
  char *udmabuf = device->map();
  
  int count = 32;
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
    buffer2[i] = -1;
  }


  PRManager prmanager;

  //StaticAccelInst vecadd = prmanager.fpgaLoadStatic("Full_vecadd");

  prmanager.fpgaLoadShell("Ultra96_100MHz_2");
  AccelInst vecadd = prmanager.fpgaLoad("Partial_vadd");

  paramlist params({
    {"group_id_x", 0},
    {"group_id_y", 0},
    {"group_id_z", 0},
    {"global_offset_x", 0},
    {"global_offset_y", 0},
    {"global_offset_z", 0},
    {"ina_1", bot32(buf0addr)},
    {"ina_2", top32(buf0addr)},
    {"inb_1", bot32(buf1addr)},
    {"inb_2", top32(buf1addr)},
    {"out_r_1", bot32(buf2addr)},
    {"out_r_2", top32(buf2addr)},
  });


  vecadd.programAccel(params);
  vecadd.runAccel();
  vecadd.wait();
  
  for (int i = 0; i < count; i++) {
    std::cout << i << ": " << buffer2[i] << std::endl;
  }
 
  
}
