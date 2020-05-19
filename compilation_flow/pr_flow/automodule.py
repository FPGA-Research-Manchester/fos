#!/usr/bin/env python3
import json, sys, os, subprocess, shutil, re, argparse
from pathlib import Path

# config files/shells are relative to this python file,store path in root_path
root_path = Path(os.path.realpath(__file__)).parent

# Info needed to compile a module for a shell
class WidthParameters:
  def __init__(self, width, region, stubs, area, buildscript):
    self.width = width
    self.region = region
    self.stubs = stubs
    self.area = area
    self.buildscript = buildscript

class ShellParameters:
  def __init__(self, location, bitstream, chip_name, slot_offset, axis_addr_width, axim_data_width):
    self.location = location
    self.bitstream = bitstream
    self.chip_name = chip_name
    self.slot_offset = slot_offset
    self.axis_addr_width = axis_addr_width
    self.axim_data_width = axim_data_width
    self.widths = []

  def addWidth(self, width, region, stubs, area, build_script):
    self.widths.append(WidthParameters(width, region, stubs, area, build_script))
    

# shells currently accessible
shells = {}
shells["u96_32"] = ShellParameters("static/ultra96v1_32bit", "Ultra96_100MHz.bit", "xczu3eg-sbva484-1-e", "21 0", 7, 32)
shells["u96_32"].addWidth(1, "u96-32-pr0", [                          ], "21 0 99 59",  "pr_module_1_slot.tcl")
shells["u96_32"].addWidth(2, "u96-32-pr0", ["u96-32-pr1"              ], "21 0 99 119", "pr_module_2_slots.tcl")
shells["u96_32"].addWidth(3, "u96-32-pr0", ["u96-32-pr1", "u96-32-pr2"], "21 0 99 179", "pr_module_3_slots.tcl")

shells["u96_128"] = ShellParameters("static/ultra96v1_128bit", "Ultra96v1_100MHz.bit", "xczu3eg-sbva484-1-e", "21 0", 7, 128)
shells["u96_128"].addWidth(1, "u96-128-pr0", [                            ], "21 0 99 59",  "pr_module_1_slot.tcl")
shells["u96_128"].addWidth(2, "u96-128-pr0", ["u96-128-pr1",              ], "21 0 99 119", "pr_module_2_slots.tcl")
shells["u96_128"].addWidth(3, "u96-128-pr0", ["u96-128-pr1", "u96-128-pr2"], "21 0 99 179", "pr_module_3_slots.tcl")

shells["zucl_stc"] = ShellParameters("static/zcu_32bit", "zucl_stc.bit", "xczu9eg-ffvb1156-2-e", "0 180", 7, 32)
shells["zucl_stc"].addWidth(1, "zucl0", [], "0 180 138 239", "blocker_module_1_slot_0.tcl")
shells["zucl_stc"].addWidth(2, "zucl0", [], "0 180 138 299", "blocker_module_2_slots_0.tcl")
shells["zucl_stc"].addWidth(4, "zucl0", [], "0 180 138 419", "blocker_module_4_slots_0.tcl")

# JSON Util
def loadJSON(filename):
  with open(filename, "r") as file:
    data = json.load(file)
  return data

def saveJSON(data, filename, indent=2):
  with open(filename, "w") as file:
    json.dump(data, file, indent=indent)

# run cmdline in shell and throw if errors detected
def shellRun(cmdline, cwd=root_path):
  if quiet:
    subprocess.run(cmdline, cwd=cwd, shell=True, check=True, stdout=subprocess.DEVNULL)
  else:
    print(f"==> {cmdline}")
    subprocess.run(cmdline, cwd=cwd, shell=True, check=True)


# sanity check json file for common errors
def sanityCheck(hls_json, shell):
  if hls_json["Interfaces"]["s_axi_control"]["addr_bits"] != str(shell.axis_addr_width):
    raise Exception("AXI Slave address interface width is not " + str(shell.axis_addr_width))
  if hls_json["Interfaces"]["m_axi_gmem"]["data_width"] != str(shell.axim_data_width):
    raise Exception("AXI Master data interface width is not " + str(shell.axim_data_width))

def performSourceFileTweaks(hls_root_path, hls_json):
  main_source = "/" + hls_json['RtlTop'] + ".v"
  for source in hls_json["Files"]["Verilog"]:
    if source.endswith(main_source):
      source_path = hls_root_path + "/" + source
      contents = open(source_path).read()
      detect = r"^\s*parameter\s+C_S_AXI_CONTROL_ADDR_WIDTH\s*=\s*[0-7]\s*;\s*$"
      replace = "parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 7;"
      new_contents, count = re.subn(detect, replace, contents, 1, re.MULTILINE)
      if count != 1:
        raise Exception("Could not locate valid axi address width parameter")
      open(source_path, "w").write(new_contents)
      return
  raise Exception("Could not find main verilog source file")

# create a module json description and save it
def generateBitstreamJSON(hls_json, modname, buildparams, outfile):
  # define bistream name and region information
  newdata = {
    "name": f"Partial_{modname}",
    "bitfiles": [{
      "name": f"Partial_{modname}_slot_0.bin",
      "region": buildparams.region,
      "stubregions": buildparams.stubs
    }],
    "registers": [{
      "name": register["name"], "offset": register["offset"]
    } for register in hls_json["Interfaces"]["s_axi_control"]["registers"]]
  }
  
  # convert reg name CTRL to control
  for reg in newdata["registers"]:
    if reg["name"] == "CTRL":
      reg["name"] = "control"

  # save data
  saveJSON(newdata, outfile)


# generates vivado tcl to synthesise a completed vivado hls module
def generateStage1VivadoTCL(hls_json, hls_root_path, chip_name, dcp_path, tcl_path):
  # Create filter for Verilog files  
  verilog_matcher = re.compile(r'.*\.v')
  
  # Decide whether to use file or stdout for the result
  stream = sys.stdout if tcl_path == "-" else open(tcl_path, "w")
  
  # Create in memory project, so DSP scripts can be sourced
  stream.write("create_project -in_memory\n")
  
  # Source DSP configuration if available
  if "Subcore" in hls_json["Files"]:
    for subcoreip in hls_json["Files"]["Subcore"]:
      stream.write(f"source {hls_root_path}/{subcoreip}\n")
  
  # Read HDL files with the design
  for vlogfile in filter(verilog_matcher.match, hls_json["Files"]["Verilog"]):
    stream.write(f"read_verilog {hls_root_path}/{vlogfile}\n")
  
  # Synthesize the design
  stream.write("synth_design -mode out_of_context -flatten_hierarchy rebuilt")
  stream.write(f" -part {chip_name} -top {hls_json['RtlTop']}\n")
  
  # Create a checkpoint
  stream.write(f"write_checkpoint -force {dcp_path}\n")


# generates vivado tcl to call another tcl script 
def generateStage2VivadoTCL(modname, out_dir, script, outfile):
  stream = open(outfile, "w")
  stream.write(f"set top_module {modname}\n")
  stream.write(f"set out_dir {out_dir}\n")
  stream.write(f"source {script}\n")


# runs vivado against the module
def runVivadoBatch(script, cwd):
  logpath = root_path / "logs"
  os.makedirs(logpath, exist_ok=True)
  shellcmd = f"vivado -journal {logpath/'vivado.jou'} -log {logpath/'vivado.log'}"
  shellcmd += f" -mode batch -source {script}"
  shellRun(shellcmd, cwd)


# uses bootgen to convert a .bit file to a .bin file
bit_matcher = re.compile(r"\.bit$")
def bit2bin(bitfile):
  bitfile = str(bitfile)
  biffile = bit_matcher.sub(".bif", bitfile)
  binfile = bit_matcher.sub(".bin", bitfile)
  with open(biffile, "w") as bif:
    bif.write(f"all:\n{{\n\t{bitfile}\n}}\n")
  shellRun(f"bootgen -image {biffile} -arch zynqmp -o {binfile} -w")
  os.remove(biffile)


# uses bitman to perform bitstream manipulation
bitmanloc = root_path
bitmanfile = bitmanloc / "bitman_linux"
def bitmanMerge(coords, inside, outside, output):
  shellRun(f"{bitmanfile} -m {coords} {inside} {outside} -F {output}")

def bitmanExtract(extractcoords, infile, movecoords, output):
  shellRun(f"{bitmanfile} -x {extractcoords} {infile} -M {movecoords} {output}")


# builds module from vivado hls json 
def synthesizeModule(json_path, shell_name, out_directory, min_slot_width):
  # extract some hls data
  hls_json_path = os.path.abspath(json_path)
  hls_root_path = os.path.dirname(hls_json_path)
  hls_json = loadJSON(hls_json_path)
  hls_mod_name = hls_json["Top"]

  print(f"Automodule.py building {hls_mod_name} module for {shell_name} shell")

  shell = shells[shell_name]
  if not shell:
    raise Exception(f"Specified shell ({shellname}) does not exist")
  
  out_dir = out_directory if out_directory else root_path / "output" / hls_mod_name / shell_name
  os.makedirs(out_dir, exist_ok=True)
  print(f"Output dir is: {out_dir}")
  print(f"Configuration dir is: {root_path}")
  
  print("Stage 0: sanity checking")
  #sanityCheck(hls_json, shell)
  performSourceFileTweaks(hls_root_path, hls_json)

  print("Stage 1: initial module synthesis")
  s1_tcl = out_dir / "stage1.tcl"
  s1_dcp = out_dir / "stage1.dcp"
  generateStage1VivadoTCL(hls_json, hls_root_path, shell.chip_name, s1_dcp, s1_tcl)
  runVivadoBatch(s1_tcl, root_path / shell.location)

  print("Stage 2: shell integration synthesis & module routing")
  s2_tcl = out_dir / "stage2.tcl"
  max_width = len(shell.widths)
  success = False
  for width in range(min_slot_width, max_width+1):
    print(f"Stage 2.{width-min_slot_width+1}: Building {width} wide module (out of {max_width})")
    buildparams = shell.widths[width-1]
    script = buildparams.buildscript
    generateStage2VivadoTCL(hls_mod_name, out_dir, script, s2_tcl)
    try:
      runVivadoBatch(s2_tcl, root_path / shell.location)
      success = True
      break
    except subprocess.CalledProcessError:
      pass
  if not success:
    print("Failed to generate stage 2 bitstream ")
    sys.exit(-1)

  print("Stage 3: bitstream manipulation")
  s3_bit_full = out_dir / f"Full_{hls_mod_name}.bit"
  s3_bit_merged = out_dir / f"Merged_{hls_mod_name}.bit"
  s3_bit_partial = out_dir / f"Partial_{hls_mod_name}_slot_0.bit"
  bitmanMerge(buildparams.area, s3_bit_full, root_path / shell.location / shell.bitstream, s3_bit_merged)
  bitmanExtract(buildparams.area, s3_bit_merged, shell.slot_offset, s3_bit_partial)

  print("Stage 4: bit to bin conversion")
  bit2bin(s3_bit_partial)

  print("Stage 5: generating register description")
  generateBitstreamJSON(hls_json, hls_mod_name, buildparams, out_dir / f"Partial_{hls_mod_name}.json")
  


if __name__ == "__main__":
  # check arguments
  parser = argparse.ArgumentParser(description="Build FOS Module from HLS Source")
  parser.add_argument("json", help="Vivado HLS solution JSON file")
  parser.add_argument("shell", help="Name of the shell")
  parser.add_argument("dir", nargs='?', default=None, help="Directory to place build files")
  parser.add_argument("--min-width", help="Starting width for stage 2 integration", default=1)
  parser.add_argument("--loud", help="Don't suppress output from programs", action="store_true")
  
  args = parser.parse_args()
  quiet = not args.loud
  
  synthesizeModule(args.json, args.shell, args.dir, args.min_width)




