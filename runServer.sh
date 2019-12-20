#!/bin/bash

cd "$(dirname "$0")"

if [ ! -f /dev/udmabuf0 ]; then
  sudo ./udmalib/setupUdma.sh
fi


cd build
sudo ./daemon_bin $*
