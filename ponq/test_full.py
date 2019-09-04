#!/usr/bin/env python3
import sys
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

items = 1024
size = items*4

print(type(ubuf))
buf0addr = udmadev.phys_addr
buf1addr = udmadev.phys_addr + size
buf2addr = udmadev.phys_addr + 2*size


for i in range(items):
  byte_val = int(i).to_bytes(4, byteorder=sys.byteorder)
  for b in range(4):
    ubuf[i*4 + b] = byte_val[b]
    ubuf[size + i*4 + b] = byte_val[b]

# initialise ponq
manager = Ponq(repository="../bitstreams")
acc0 = manager.load("Full_vecadd")
acc0.writeReg("ocl_sx", 1)
acc0.writeReg("ocl_sy", 1)
acc0.writeReg("ocl_sz", 1)
acc0.writeReg("size", items)
acc0.writeReg("in_a", buf0addr)
acc0.writeReg("in_b", buf1addr)
acc0.writeReg("out", buf2addr)
acc0.run()
acc0.wait()
acc0.unload()

for i in range(items):
  byte_val = ubuf[2*size + i*4:2*size + (i+1)*4]
  int_val = int.from_bytes(byte_val, byteorder=sys.byteorder)
  print(str(i) + ": " + str(int_val))


