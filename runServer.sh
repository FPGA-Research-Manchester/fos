#!/bin/bash

if [ ! -f /dev/udmabuf0 ]; then
  sudo ./udmalib/setupUdma.sh
fi

cd build
sudo ./daemon_bin
