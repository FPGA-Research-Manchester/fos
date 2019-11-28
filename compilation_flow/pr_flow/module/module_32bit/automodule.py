#!/usr/bin/env python3
import json, sys, os, subprocess

def loadJSON(filename):
  with open(filename, "r") as file:
    data = json.load(file)
  return data

# check arguments
if len(sys.argv) != 2:
  print("Invalid arguments, usage is:")
  print("\t" + sys.argv[0] + " <hls solution json>")
  sys.exit(1)

in_json = os.path.abspath(sys.argv[1])
in_hls = os.path.dirname(in_json)


origdata = loadJSON(in_json)
modname = origdata["Top"]

print("Automodule building " + modname + " module")
print("Stage 1: initial synthesis")
ret = subprocess.call("./autotcl.py " + in_json + " - > "+modname+".s1.tcl", shell=True)
ret = subprocess.call("vivado -mode batch -journal logs/vivado.jou -log logs/vivado.log -source "+modname+".s1.tcl", shell=True)
if ret is not 0:
  print("Failed to perform initial synthesis")
  sys.exit(1)

print("Stage 2: module synthesis & p&r")
ret = subprocess.call("./build.sh " + modname, shell=True)
if ret is not 0:
  print("Failed to perform module synthesis & p&r")
  sys.exit(1)

print("Stage 3: register description parsing")
ret = subprocess.call("./autojson.py " + in_json + " Partial_" + modname + ".json", shell=True)
if ret is not 0:
  print("Failed to perform description parsing")
  sys.exit(1)

subprocess.call("cp bins/Partial_" + modname + "_slot_0.bin .", shell=True)
