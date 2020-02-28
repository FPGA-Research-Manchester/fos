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

items = 1024
size = items*4

buf0addr = udmadev.phys_addr
buf1addr = udmadev.phys_addr + size
buf2addr = udmadev.phys_addr + 2*size


for i in range(items):
  byte_val = int(i).to_bytes(4, byteorder=sys.byteorder)
  null_val = int(1).to_bytes(4, byteorder=sys.byteorder)
  for b in range(4):
    ubuf[0*size + i*4 + b] = byte_val[b]
    ubuf[1*size + i*4 + b] = byte_val[b]
    ubuf[2*size + i*4 + b] = null_val[b]

# initialise ponq
runs = items // 16

manager = Ponq("../../bitstreams", "../../build/bit_patch_bin")
acc0 = manager.load("Full_vadd")
acc0.writeReg("group_id_x", 0)
acc0.writeReg("group_id_y", 0)
acc0.writeReg("group_id_z", 0)
acc0.writeReg("global_offset_x", 0)
acc0.writeReg("global_offset_y", 0)
acc0.writeReg("global_offset_z", 0)
acc0.writeReg("ina_1", bot32(buf0addr))
acc0.writeReg("ina_2", top32(buf0addr))
acc0.writeReg("inb_1", bot32(buf1addr))
acc0.writeReg("inb_2", top32(buf1addr))
acc0.writeReg("out_r_1", bot32(buf2addr))
acc0.writeReg("out_r_2", top32(buf2addr))

for run in range(runs-1):
  acc0.writeReg("group_id_x", run)
  acc0.run()
  acc0.wait()

acc0.unload()

for i in range(items):
  byte_val = ubuf[2*size + i*4:2*size + (i+1)*4]
  int_val = int.from_bytes(byte_val, byteorder=sys.byteorder)
  print(str(i) + ": " + str(int_val))


