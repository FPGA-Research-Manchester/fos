#!/usr/bin/env python3
import json, sys, subprocess

f = open(sys.argv[1], "r")
data = json.load(f)
regs = {reg["name"]: int(reg["offset"], 0) for reg in  data["registers"]}
base = int("0x81000000", 0)

vals = []

for reg in regs:
  addr = base + regs[reg]
  data = int(subprocess.check_output(f"busybox devmem {hex(addr)}", shell=True), 0)
  vals.append((f"{reg} ({hex(regs[reg])})", hex(data)))

#print(vals)
#regmax = max([len(row[0]) for row in vals]) + 1
#datmax = max([len(row[1]) for row in vals]) + 1

#print("maxes: ", regmax, datmax)

for val in vals:
  print(f"{val[0]+':':20} {val[1]:20}")
