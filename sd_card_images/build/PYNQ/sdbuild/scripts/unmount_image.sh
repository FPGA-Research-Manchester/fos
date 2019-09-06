#!/bin/bash
# set -x
set -e

target=$1
image_file=$2

echo "Umounting $image_file from $target"
sudo umount $target/boot
sleep 1
sudo umount $target
sleep 1
sudo kpartx -d $image_file
