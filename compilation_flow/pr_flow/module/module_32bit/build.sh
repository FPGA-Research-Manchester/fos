#!/bin/bash

set -ex

# check arguments
if [ $# -eq 0 ]; then
  echo "No arguments supplied"
  echo "Usage: $0 module_name"
  exit -1
fi

module_name=${1/\.bit/}
shell_name="Ultra96v1_32bit_v2"
merge_name="Merge_${module_name}_${shell_name}"

#### synth design into DCP
# load verilog into vivado
# write checkpoint out

#### run p&r for design in shell

cat >$module_name.s2.tcl <<- EOF
  set top_module $module_name
  source pr_module_1_slot.tcl
EOF
vivado -mode batch -journal logs/vivado.jou -log logs/vivado.log -source $module_name.s2.tcl

#### merge shell and module
../bitman_linux -m 21 0 99 59 ./bins/${module_name}_full.bit ./${shell_name}.bit -F ./bins/${merge_name}.bit

#### chop module from shell
../bitman_linux -x 21 0 99 59 ./bins/${merge_name}.bit -M 21 0 ./bins/Partial_${module_name}_slot_0.bit

#### create bins from bits
./bit2bin.sh ./bins/${module_name}_full.bit
./bit2bin.sh ./bins/${merge_name}.bit
./bit2bin.sh ./bins/Partial_${module_name}_slot_0.bit
