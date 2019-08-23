set -e
xhost +
sudo cp sobel.bin /lib/firmware
make sobel_linux 
sudo su -c "echo 'sobel.bin' > /sys/class/fpga_manager/fpga0/firmware"
sudo DISPLAY=:0 ./sobel_linux HW
