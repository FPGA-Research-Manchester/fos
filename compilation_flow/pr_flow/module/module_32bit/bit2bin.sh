#!/bin/bash

# check arguments
if [ $# -eq 0 ]; then
  echo "No arguments supplied"
  echo "Usage: $0 bitstream.bit"
  exit -1
fi

# setup vars
bitstream=$1
biffile="${bitstream/\.bit/\.bif}"
binfile="${bitstream/\.bit/\.bin}"

echo "$bitstream -> $biffile -> $binfile"

# check input file exists
if [ ! -f $bitstream ]; then
  echo "File $bitstream not found"
  exit -2
fi

# check bif file exists
if [ ! -f $biffile ]; then
  echo "Creating bif"
  echo -e "all:\n{\n\t$bitstream\n}\n" > $biffile
fi

# create bin file
echo "Creating bin"
bootgen -image $biffile -arch zynqmp -o $binfile -w
echo "Done, output at: $binfile"
