#!/usr/bin/env python3
import argparse
import jinja2
import json
import os
import subprocess
import shutil

# Parse program arguments
parser = argparse.ArgumentParser(description="Synthesis and export Vivado HLS design")
parser.add_argument("project", help="Name of the project")
parser.add_argument("top", help="Name of the top function")
parser.add_argument("part", help="Name of the target device")
parser.add_argument("files", nargs="+", help="C/C++/OpenCL files with design")

args = parser.parse_args()

# Generate path to the solution
solution_path = args.project + "/" + args.project

# Create project and solution directory
os.makedirs(solution_path, exist_ok=True)

# Files in the solution
solution_files = []

# Generate files paths within solution and copy existing files there
for design_file in args.files:
  new_path = solution_path + "/" + os.path.basename(design_file)
  solution_files.append(new_path)
  shutil.copyfile(design_file, new_path)

# Generate the Vivado HLS TCL script
loader = jinja2.FileSystemLoader(searchpath="./")
env = jinja2.Environment(loader=loader)
template = env.get_template("autohls.tcl.j2")
output = template.render(project=args.project, top=args.top,
                         part=args.part, files=" ".join(solution_files))

# Write script to file
script_file = args.project + ".tcl"
script = open(script_file, "w")
script.write(output)
script.close()

# Run Vivado HLS
subprocess.run("vivado_hls " + script_file, shell=True, check=True)

