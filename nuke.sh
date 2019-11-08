#!/bin/bash

echo "Writing filesystem cache to SD"
sudo sync

echo "Loading shell"
sudo su -c "echo 0 > /sys/class/fpga_manager/fpga0/flags"
sudo su -c "echo Ultra96_100MHz_2.bin > /sys/class/fpga_manager/fpga0/firmware"

echo "Loading powerhammering"
sudo su -c "echo 1 > /sys/class/fpga_manager/fpga0/flags"
sudo su -c "echo Malicious_PowerHammering_slot_0.bin > /sys/class/fpga_manager/fpga0/firmware"
