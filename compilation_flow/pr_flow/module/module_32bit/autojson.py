#!/usr/bin/env python3
import json, sys

def loadJSON(filename):
  with open(filename, "r") as file:
    data = json.load(file)
  return data

def saveJSON(data, filename):
  with open(filename, "w") as file:
    json.dump(data, file)

# check arguments
if len(sys.argv) != 3:
  print("Invalid arguments, usage is:")
  print("\t" + sys.argv[0] + " <input> <output>")
  sys.exit(1)

in_json = sys.argv[1]
out_json = sys.argv[2]

# load hls json
origdata = loadJSON(in_json)
newdata = {}

# build our json
newdata["name"] = "Partial_" + origdata["Top"]
newdata["bitfiles"] = [{
  "name": "Partial_" + origdata["Top"] + "_slot_0.bin", "region": "pr0"
}]

registers = origdata["Interfaces"]["s_axi_control"]["registers"]
newdata["registers"] = [{
  "name": register["name"], "offset": register["offset"]
} for register in registers]

for reg in newdata["registers"]:
  if reg["name"] == "CTRL":
    reg["name"] = "control"

# write output
saveJSON(newdata, out_json)
