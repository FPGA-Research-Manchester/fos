#!/usr/bin/env python3
import sys
sys.path.append("../..")

import cv2
import numpy as np
import udma
import proto.fpga_rpc_c as fpga_rpc_client

# bit hacking functions for driving unit
int32max = (1 << 32) - 1
def top32(data): return int((data >> 32) & int32max)
def bot32(data): return int(data & int32max)

if len(sys.argv) != 3:
  print("Invalid arguments")
  print("\tUsage: " + sys.argv[0] + " input output")
  sys.exit(-1)

# allocate a buffer
ubuffers = udma.udmas()
fpga_rpc = fpga_rpc_client.Client()
bufno = fpga_rpc.Alloc()
if (bufno < 0): raise "could not allocate buffers"
ubuffer = ubuffers.getDevice(bufno)
buffer = ubuffer.map()

# read in images
input = cv2.imread(sys.argv[1], cv2.IMREAD_GRAYSCALE)
height = input.shape[0]
width = input.shape[1]
size = width*height

# calculate pointers
buf0addr = ubuffer.phys_addr
buf1addr = ubuffer.phys_addr + size

for y in range(height):
  for x in range(width):
    buffer[y*width+x] = input[y, x]

# run hardware unit
fpga_rpc.Run([{
  "name": "Partial_sobel",
  "params": {
    "in_pixels":      bot32(buf0addr),
    "in_pixels_msb":  top32(buf0addr),
    "out_pixels":     bot32(buf1addr),
    "out_pixels_msb": top32(buf1addr),
    "im_width":       width,
    "im_height":      height
  }
}])

# write output to file
output = np.zeros(input.shape, dtype=input.dtype)
for y in range(height):
  for x in range(width):
    output[y, x] = buffer[size + y*width+x]
cv2.imwrite(sys.argv[2], output)

fpga_rpc.Free(bufno)
