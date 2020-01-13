#include <chrono>
#include <iostream>
#include <stdio.h>
#include <math.h>
#include <float.h>

#include "cynq/cynq.h"
#include "udmalib/udma.h"

#define max32       (0xffffffff)
#define intify64(x) (*(uint64_t*)&x)
#define intify32(x) (*(uint32_t*)&x)
#define top32(x)    (intify64(x) >> 32 & max32)
#define bot32(x)    (intify64(x) & max32)

int main(int argc, char **argv) {

  int num_accels = 2;
  int sims = 1024, steps=1024;

  float initPrice = 100;    // -s
  float strikePrice = 110;  // -k
  float rate = 0.05;        // -r
  float volatility = 0.2;   // -v
  float time = 1.0;         // -t
  float callR=6.04, putR=10.65; // taken from makefile
  
  // parse arguments
  if (argc > 2) {
    std::cout << "Invalid arguments" << std::endl;
    std::cout << "\tUsage: " << argv[0] << " [num_accels]" << std::endl;
    return -1;
  }  
  if (argc > 1)
    num_accels = std::stoi(argv[1]);

  // setup buffers
  UdmaRepo repo;
  UdmaDevice *device = repo.device(0);
  int buflen = sizeof(float) * num_accels;
  char *buffer = device->map();
  uint64_t bufferPhy = device->phys_addr;
  float *hCall = (float*) (buffer);
  float *hPut  = (float*) (buffer + buflen);
  uint64_t hCallPhy = (bufferPhy);
  uint64_t hPutPhy  = (bufferPhy + buflen);
  
  // copy data into buffer
  int i = 0;
  for(i=0; i<num_accels; i++){
    hCall[i] = -1; // placeholder value
    hPut[i] = -1;
  }

  // load and run hardware unit
  PRManager prmanager;
  prmanager.fpgaLoadShell("Ultra96_100MHz_2");

  AccelInst inst[3];

  paramlist params({
    {"pCall_1", bot32(hCallPhy)},
    {"pCall_2", top32(hCallPhy)},
    {"pPut_1", bot32(hPutPhy)},
    {"pPut_2", top32(hPutPhy)},
    {"timeT", intify32(time)},
    {"freeRate", intify32(rate)},
    {"volatility", intify32(volatility)},
    {"initPrice", intify32(initPrice)},
    {"strikePrice", intify32(strikePrice)},
    {"steps", steps},
    {"sims", sims},
    {"g_id", 0},
  });

  for (i=0; i<num_accels; i++)
  {
    inst[i] = prmanager.fpgaLoad("Partial_blackEuro");
  }

  auto start = std::chrono::high_resolution_clock::now();

  int num_runs = 16;
  int j = 0;
  while(j < num_runs)
  {
    int launched_accel = 0;
    for(i=0; i<num_accels && j < num_runs; i++){
      params["g_id"] = j;
      inst[i].programAccel(params);
      inst[i].runAccel();
      j++;
      launched_accel++;
    }

    for(i=0; i<launched_accel; i++){
      inst[i].wait();  
    }
  }

  auto stop = std::chrono::high_resolution_clock::now();
  long duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
  
  std::cout << "Processing took: " << duration << "ms" << std::endl;
    
  float pCall=0, pPut=0;
  for(int i=0; i<num_runs; i++){
    pCall+= hCall[i];
    pPut += hPut[i];
  }

  pCall/=num_runs*expf(rate*time);
  pPut/=num_runs*expf(rate*time);

  printf("pCall: %f  pPut: %f\n", pCall, pPut);

  printf("the difference with the reference value is %f%%\n", 
      fabs(pCall/callR-1)*100);

  for (i=0; i<num_accels; i++)
    prmanager.fpgaUnloadRegions(inst[i]);

  device->unmap();
}
