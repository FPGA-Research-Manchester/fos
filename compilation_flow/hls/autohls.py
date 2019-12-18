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
parser.add_argument("solution", help="Name of the solution")
parser.add_argument("top", help="Name of the top function (ignored if using existing)")
parser.add_argument("part", help="Name of the target device (ignored if using existing)")
parser.add_argument("files", nargs="+", help="C/C++/OpenCL files with design (ignored " \
                                             "if using existing)")
parser.add_argument("--no-legacy", help="Run vivado_hls without -f flag",
                    action="store_true")
parser.add_argument("--use-existing", help="Use existing project and solution",
                    action="store_true")

args = parser.parse_args()

# Generate path to the solution
solution_path = args.project + "/" + args.solution

# Files in the solution
solution_files = []

# Create project and solution directory
if not args.use_existing:
  os.makedirs(solution_path, exist_ok=True)

  # Generate files paths within solution and copy existing files there
  for design_file in args.files:
    new_path = solution_path + "/" + os.path.basename(design_file)
    solution_files.append(new_path)
    shutil.copyfile(design_file, new_path)

# Generate the Vivado HLS TCL script
loader = jinja2.FileSystemLoader(searchpath="./")
env = jinja2.Environment(loader=loader)
template = env.get_template("autohls.tcl.j2")
output = template.render(project=args.project, solution=args.solution, top=args.top,
                         part=args.part, files=" ".join(solution_files),
                         existing=args.use_existing)

# Write script to file
script_file = args.project + ".tcl"
script = open(script_file, "w")
script.write(output)
script.close()

# Run Vivado HLS
if args.no_legacy:
  subprocess.run("vivado_hls " + script_file, shell=True, check=True)
else:
  subprocess.run("vivado_hls -f " + script_file, shell=True, check=True)

