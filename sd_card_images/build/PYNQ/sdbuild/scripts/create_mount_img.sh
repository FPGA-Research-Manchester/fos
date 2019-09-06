#!/bin/bash
set -e
# set -x

image_file=$1   # sd card image file
image_dir=$2    # mount directory

image_size=12G  # size of whole image (as parsed by truncate)

echo "Creating $image_size image: $image_file"
script_dir=$(dirname ${BASH_SOURCE[0]})
truncate --size $image_size $image_file
$script_dir/create_partitions.sh $image_file
echo "Loop mounting $image_file"
mount_points=( $(sudo kpartx -av $image_file | cut -d ' ' -f 3) )

root_part=/dev/mapper/${mount_points[1]}
boot_part=/dev/mapper/${mount_points[0]}
echo "Mapped root-part:$root_part and boot-part:$boot_part"

sleep 1

# mkfs wasn't on the list of passwordless sudo commands so work around for now
echo "Creating FAT on $boot_part"
sudo chroot / mkfs -t fat $boot_part
echo "Creating ext4 on $root_part"
sudo chroot / mkfs -t ext4 $root_part

echo "Mounting $root_part on $image_dir"
mkdir -p $image_dir
sudo mount $root_part $image_dir
sleep 1

# Neither was mkdir
sudo chroot / mkdir $image_dir/boot
echo "Mounting $boot_part on $image_dir/boot"
sudo mount $boot_part $image_dir/boot
sudo chroot / chmod a+w $image_dir
