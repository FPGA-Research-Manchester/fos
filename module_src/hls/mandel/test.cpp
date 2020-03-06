#include <iostream>

#include "mandelbrot.h"

#include "cynq/cynq.h"
#include "udmalib/udma.h"

#define max32    (0xffffffff)
#define top32(x) (x >> 32 & max32)
#define bot32(x) (x & max32)

int main(int argc, char **argv) {
  std::cout << "Running mandelbrot test" << std::endl;

  unsigned int MaxIterations = 50;
  int zoom = 1;
  fixed_point_t zoom_ratio = floatToFixed((double)0.01 / zoom);
  
  unsigned int ImageWidth = 300;
  unsigned int ImageHeight = 300;

  // attach to udma buffer device
  UdmaRepo repo;
  UdmaDevice *device = repo.device(0);
  char *display = device->map();
  uint64_t bufaddr = device->phys_addr;
  
  fixed_point_t cRe = floatToFixed(-1.25);
  fixed_point_t cIm = floatToFixed(-0.18);

  for(int i = 0; i < ImageWidth; i++)
    for(int j = 0; j < ImageHeight; j++)
      display[i + j*ImageWidth] = 'a';

  //mandelbrot(ImageWidth, ImageHeight,
  //     MaxIterations, cRe, cIm,
  //     zoom_ratio, &display);


  PRManager prmanager;
  //prmanager.fpgaLoadShell("Ultra96_100MHz_2");
  prmanager.fpgaLoadShell(prmanager.shells.begin()->first);
  paramlist params;
  params["ImageWidth"]     = ImageWidth;
  params["ImageHeight"]    = ImageHeight;
  params["MaxIterations"]  = MaxIterations;
  params["cRe_1"]          = bot32(cRe);
  params["cRe_2"]          = top32(cRe);
  params["cIm_1"]          = bot32(cIm);
  params["cIm_2"]          = top32(cIm);
  params["zoom_1"]         = bot32(zoom_ratio);
  params["zoom_2"]         = top32(zoom_ratio);
  params["display_1"]      = bot32(bufaddr);
  params["display_2"]      = top32(bufaddr);
  AccelInst inst = prmanager.fpgaRun("Partial_mandelbrot", params);
  inst.wait();

  for(int i = 0; i < ImageHeight; i++) {
    for(int j = 0; j < ImageWidth; j++) {
      if(display[j + i*ImageWidth] == (char)-1)
        std::cout << "*";
      else
        std::cout << " ";
    } // for
    std::cout << std::endl;
  } // for
} // main()
