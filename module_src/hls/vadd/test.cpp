#include "cynq/cynq.h"
#include "udmalib/udma.h"

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#define max32    (0xffffffff)
#define top32(x) (x >> 32 & max32)
#define bot32(x) (x & max32)

int main(int argc, char **argv) {
  
  // attach to udma buffer device
  UdmaRepo repo;
  UdmaDevice *device = repo.device(0);
  char *buf = device->map();
  uint64_t bufaddr = device->phys_addr;

  // setup buffer pointers  
  int elements = 4096;
  int buflen = sizeof(int) * elements;
  
  int *ina = (int*) (buf);
  int *inb = (int*) (buf + buflen);
  int *out = (int*) (buf + 2*buflen);
  uint64_t inaaddr = bufaddr;
  uint64_t inbaddr = bufaddr + buflen;
  uint64_t outaddr = bufaddr + 2*buflen;
  
  // fill with test data
  for (int i = 0; i < elements; i++) {
    ina[i] = i;
    inb[i] = i;
    out[i] = -1;
  }

  // caclculate run info
  int runsize = 16;
  int totalruns = elements / runsize;

  // load and run hardware unit
  PRManager prmanager;
  prmanager.fpgaLoadShell("Ultra96_100MHz_2");
  paramlist params({
    {"group_id_x", 0},
    {"group_id_y", 0},
    {"group_id_z", 0},
    {"global_offset_x", 0},
    {"global_offset_y", 0},
    {"global_offset_z", 0},
    {"ina_1", bot32(inaaddr)},
    {"ina_2", top32(inaaddr)},
    {"inb_1", bot32(inbaddr)},
    {"inb_2", top32(inbaddr)},
    {"out_r_1", bot32(outaddr)},
    {"out_r_2", top32(outaddr)}
  });

  for (int run = 0; run < totalruns; run++) {
    params["group_id_x"] = run;
    AccelInst inst = prmanager.fpgaRun("Partial_vadd", params);
    inst.wait();
    prmanager.fpgaUnloadRegions(inst);
  }
  
  // count all the incorrect lines
  int errors = 0;
  for (int i = 0; i < elements; i++)
    if (ina[i] + inb[i] != out[i])
      errors++;

  device->unmap();

  // report errors and quit
  if (errors > 1) {
    printf("Completed with %d errors\n", errors);
    return 1;
  } else {
    printf("Completed with no errors\n");
    return 0;
  }
}
