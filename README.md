# FOS - FPGA Operating System Demo

FOS extends the ZUCL framework with linux integration, python libs, C++ runtime management to provide support for: multi-tenancy (concurrent processes with hardware accel.), dynamic offload, GUI, network connection and flexibility.

With FOS, you can develop accelerators in HLS as well as RTL and use them in standard full configuration mode, library mode (single process) for partially reconfigurable accelerators or daemon mode (multiple processes) with dynamic reconfiguration. 

It has in-built support for Vivado HLS accelerators with AXI master and slave interface and provides uio support to build your own drivers. 

Target platform for the demo is Ultra96 board but the code can be easily ported to UltraZed and ZCU102 boards. 

## Features

- Dynamic partial reconfiguration
- Runtime for concurrent hardware accelerators
- Ponq and Cynq libs to make hardware acceleration easy 
- Decoupling shell development from accelerator development (can be update individually)
- Relocatable bitstreams
- Compile bitstreams on board with EFCAD tool flow
- On board Linux backend for all software development needs
- I/O support via ARM cores

## Quick Getting Started

- Download SD Card image
- Set board to SD Card mode and turn it on
- Go to directoy : XYZ
- run ./daemon
- run ./demo_gui

## Tutorials

- How to write HLS accelerators
- How to use Ponq
  - How to use HLS accelerators
  - How to use RTL accelerators
- How to use Daemon
  - How to use HLS accelerators
- How to compile partially reconfigurable modules
- How to build Linux (Pynq / Ubuntu) Image

## Compatibility

The source code presented has been tested with following tool versions:
- Vivado and Vivado HLS 2016.2, 2017.3, 2018.2 and 2018.3.
- PetaLinux kernel 2018.2.
- Rootfs: Pynq, PetaLinux, Ubuntu 18, Ubuntu 14, Debian, Linaro u96.
- GRPC version: 

## Papers

If you found FOS useful please consider citing following paper:

- A. Vaishnav, K.D. Pham, K. Manev and D. Koch, "**FOS (FPGA Operating System) Demo**", FPL, 2019. 

If you would like to learn more about how the system works or what it can do in detail, you can read the following papers.

Hardware: 
- K.D. Pham, A. Vaishnav, M. Vesper and D. Koch, "**ZUCL: A ZYNQ UltraScale+ Framework for OpenCL HLS Applications**", 5th FSP, 2018.
- K.D. Pham, E. Horta and D. Koch, "**BITMAN: A tool and API for FPGA bitstream manipulations**", DATE, 2017.

Software: 
- A. Vaishnav, K.D. Pham, D. Koch and J. Garside, "**Resource Elastic Virtualization for FPGAs using OpenCL**", 28th FPL, 2018.
- A. Vaishnav, K.D. Pham and D. Koch, "**Live Migration for OpenCL FPGA Accelerators**", FPT, 2018. 
- A. Vaishnav, K.D. Pham and D. Koch, "**Heterogeneous Resource-Elastic Scheduling for CPU+FPGA Architectures**", 10th HEART, 2019.


## License information



## Get in Touch 

If you would like to ask questions, report bugs or collaborate on research project, please email any of the following: 

- Anuj Vaishnav (<anuj.vaishnav@manchester.ac.uk>)
- Khoa Dang Pham (<khoa.pham@manchester.ac.uk>)
- Dirk Koch (<dirk.koch@manchester.ac.uk>)

## Contributors:
Anuj Vaishnav, Khoa Dang Pham, Joe Powell, Alasdair Olway, Kristiyan Manev, Dirk Koch 

## Acknowledgments
- This work was produced at the University of Manchester as part of PhD and MPhil Projects. 
- This work is supported by the Xilinx University Program. 

