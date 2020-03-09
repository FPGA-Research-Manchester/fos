#!/usr/bin/env python3
import argparse, jinja2, json, os, subprocess, shutil
from pathlib import Path

# paths used by autohls
source_path = Path(os.path.dirname(os.path.realpath(__file__)))
current_path = Path(os.getcwd())

def compile(project, solution, top, part, files, out_path, no_legacy, use_existing):

  # Generate path to the project and solution
  project_path = out_path / project
  solution_path = project_path / solution

  # Files in the solution
  solution_files = []

  # Create project and solution directory
  if not use_existing:
    os.makedirs(solution_path, exist_ok=True)

    # Generate files paths within solution and copy existing files there
    for design_file in files:
      new_path = str(solution_path / os.path.basename(design_file))
      solution_files.append(new_path)
      shutil.copyfile(design_file, new_path)

  # Generate the Vivado HLS TCL script
  loader = jinja2.FileSystemLoader(searchpath=str(source_path))
  env = jinja2.Environment(loader=loader)
  template = env.get_template("autohls.tcl.j2")
  output = template.render(project=project, solution=solution, top=top, part=part,
      files=" ".join(solution_files), existing=use_existing)

  # Write script to file
  script_file = project_path / f"{project}.tcl"
  script = open(script_file, "w")
  script.write(output)
  script.close()

  # Run Vivado HLS
  viv_flags = "-f" if no_legacy else ""
  subprocess.run(f"vivado_hls {viv_flags} {script_file}", shell=True, check=True, cwd=out_path)


if __name__ == "__main__":
  # Parse program arguments
  parser = argparse.ArgumentParser(description="Synthesis and export Vivado HLS design")
  parser.add_argument("project", help="Name of the project")
  parser.add_argument("solution", help="Name of the solution")
  parser.add_argument("top", help="Name of the top function (ignored if using existing)")
  parser.add_argument("part", help="Name of the target device (ignored if using existing)")
  parser.add_argument("files", nargs="+", 
      help="C/C++/OpenCL files with design (ignored if using existing)")
  parser.add_argument("--no-legacy", help="Run vivado_hls without -f flag", action="store_true")
  parser.add_argument("--use-existing", help="Use existing project and solution", action="store_true")
  parser.add_argument("-o", help="Output location")

  args = parser.parse_args()

  output_path = Path(args.o) if args.o is not None else Path(source_path) / "output"
  output_path = output_path.resolve()

  compile(args.project, args.solution, args.top, args.part,
      args.files, output_path, args.no_legacy, args.use_existing)
