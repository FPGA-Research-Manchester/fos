#!/usr/bin/env python3
import sys
sys.path.append("../..")
sys.path.append("..")

import udmalib.udma as udma
from ponq import Ponq
import cv2, numpy as np

# bit hacking functions for driving unit
fixpfactor = 1 << 29
int32max = (1 << 32) - 1
def float2fix(value): return int(value * fixpfactor)
def top32(data): return int((data >> 32) & int32max)
def bot32(data): return int(data & int32max)

# load udma buffer for hardware use
udmarepo = udma.udmas()
udmadev = udmarepo.getDevice(0)
ubuf = udmadev.map()
  
# hardware module parameters
udma_addy = udmadev.phys_addr
width = 640
height = 480
cre = -1.2582
cim = 0.3819
zoom = 0.01

# initialise ponq
manager = Ponq("../../bitstreams", "../../build/bit_patch_bin")

# run unit
# for i in range(1):
#  manager.run("Partial_mandelbrot", {
#    "imageWidth":     width,
#    "imageHeight":    height,
#    "maxIterations":  256,
#    "centreRealLow":  bot32(float2fix(cre)),
#    "centreRealHi":   top32(float2fix(cre)),
#    "centreImagLow":  bot32(float2fix(cim)),
#    "centreImagHi":   top32(float2fix(cim)),
#    "zoomLow":        bot32(float2fix(zoom)),
#    "zoomHi":         top32(float2fix(zoom)),
#    "framebufferLow": bot32(udma_addy),
#    "framebufferHi":  top32(udma_addy)
#  })

manager.loadShell("Ultra96_100MHz_2")

acc0 = manager.load("Partial_mandelbrot")
acc0.unload()

acc1 = manager.load("Partial_mandelbrot")
acc2 = manager.load("Partial_mandelbrot")
acc2.unload()
acc1.unload()

acc3 = manager.load("Partial_mandelbrot")
acc4 = manager.load("Partial_mandelbrot")
acc5 = manager.load("Partial_mandelbrot")
acc5.unload()
acc4.unload()
acc3.unload()


output = np.zeros((height, width), dtype=np.uint8)
for y in range(height):
  for x in range(width):
    output[y, x] = ubuf[y*width+x]
cv2.imwrite("mandelbrot.jpg", output)

