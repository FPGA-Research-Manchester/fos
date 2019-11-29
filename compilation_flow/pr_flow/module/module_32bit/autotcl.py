#!/usr/bin/env python3
import json, sys, os

def loadJSON(filename):
  with open(filename, "r") as file:
    data = json.load(file)
  return data

# check arguments
if len(sys.argv) != 3:
  print("Invalid arguments, usage is:")
  print("\t" + sys.argv[0] + " <input> <output>")
  sys.exit(1)

in_json = os.path.abspath(sys.argv[1])
in_hls = os.path.dirname(in_json)
out_tcl = sys.argv[2]

# load hls json
origdata = loadJSON(in_json)

# write tcl output
if out_tcl == "-":
  print("create_project -in_memory")
  if "Subcore" in origdata["Files"]:
    for subcoreip in origdata["Files"]["Subcore"]:
      print("source " + in_hls + "/" + subcoreip)
  for vlogfile in origdata["Files"]["Verilog"]:
    print("read_verilog " + in_hls + "/" + vlogfile)
  print("synth_design -mode out_of_context -flatten_hierarchy rebuilt -part xczu3eg-sbva484-1-e -top " + origdata["RtlTop"])
  print("write_checkpoint -force ./Synth/reconfig_modules/" + origdata["Top"])
else:
  with open(out_tcl, "w") as file:
    file.write("create_project -in_memory\n")
    if "Subcore" in origdata["Files"]:
      for subcoreip in origdata["Files"]["Subcore"]:
        file.write("source " + in_hls + "/" + subcoreip + "\n")
    for vlogfile in origdata["Files"]["Verilog"]:
      file.write("read_verilog " + in_hls + "/" + vlogfile + "\n")
    file.write("synth_design -mode out_of_context -flatten_hierarchy rebuilt -part xczu3eg-sbva484-1-e -top " + origdata["RtlTop"] + "\n")
    file.write("write_checkpoint -force ./Synth/reconfig_modules/" + origdata["Top"] + "\n")
