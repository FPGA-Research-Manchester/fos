#!/bin/bash

image_file=$1
image_dir=$2

echo "Loop Mounting $image_file"

script_dir=$(dirname ${BASH_SOURCE[0]})
mount_points=( $(sudo kpartx -av $image_file | cut -d ' ' -f 3) )

root_part=/dev/mapper/${mount_points[1]}
boot_part=/dev/mapper/${mount_points[0]}

echo "Mounting $root_part to $image_dir"
echo "Mounting $root_part to $image_dir/boot"

sleep 5
mkdir -p $image_dir

sudo mount $root_part $image_dir
sleep 1
sudo mount $boot_part $image_dir/boot

sudo chroot / chmod a+w $image_dir
