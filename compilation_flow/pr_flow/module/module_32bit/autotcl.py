#!/usr/bin/env python3
import argparse
import json
import os
import re
import sys

# Parse program arguments
parser = argparse.ArgumentParser(description="Generate TCL file from JSON " + \
                                 "description.")
parser.add_argument("input", help="input JSON file with design information")
parser.add_argument("output", help="output TCL Vivado file (use \"-\" to " + \
                    "print to stdout)")

args = parser.parse_args()

# Read data from program arguments
in_json = os.path.abspath(sys.argv[1])
in_hls = os.path.dirname(in_json)
out_tcl = sys.argv[2]

# Load JSON file with design information
try:
  origfile = open(in_json, "r")
  origdata = json.load(origfile)
except OSError:
  print("Failed to open JSON file!")
  sys.exit(-1) 
except JSONDecodeError:
  print("Failed to parse JSON file!")
  sys.exit(-1)

# Create filter for Verilog files  
verilog_matcher = re.compile(r'.*\.v')

# Decide whether to use file or stdout for the result
if out_tcl == "-":
  stream = sys.stdout
else:
  try:
    stream = open(out_tcl, "w")
  except OSError:
    print("Failed to open file for writing!")
    sys.exit(-1)

# Create in memory project, so DSP scripts can be sourced
stream.write("create_project -in_memory\n")

# Source DSP configuration if available
if "Subcore" in origdata["Files"]:
  for subcoreip in origdata["Files"]["Subcore"]:
    stream.write("source " + in_hls + "/" + subcoreip + "\n")

# Read HDL files with the design
for vlogfile in filter(verilog_matcher.match, origdata["Files"]["Verilog"]):
  stream.write("read_verilog " + in_hls + "/" + vlogfile + "\n")

# Synthesise the design
stream.write("synth_design -mode out_of_context -flatten_hierarchy rebuilt" + \
             " -part xczu3eg-sbva484-1-e -top " + origdata["RtlTop"] + "\n")

# Create a checkpoint
stream.write("write_checkpoint -force ./Synth/reconfig_modules/" \
             + origdata["Top"] + "\n")

