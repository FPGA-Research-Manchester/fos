# Daemon

The daemon manages the physical memory buffer and FPGA allocation between multiple users/process which want to use the FPGA for 
hardware acceleration. It accepts requests for hardware acceleration via gRPC, which states the accelerator names and its parameters. 
Details on how to fire acceleration requests to the daemon can be found in [clients directory](../clients). 

## How to launch the daemon
1. Allocate udma buffers for the clients to operate on:
```bash
  sudo ../udmalib/setupUdma.sh
```
2. Given that daemon is built using the [makefile](../makefile), simply run the following: 
```bash
  sudo ./cserv
```
