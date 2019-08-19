# FOS - FPGA Operating System Demo

FOS extends the ZUCL framework with linux integration, python libs, C++ runtime management to provide support for: multi-tenancy (concurrent processes with hardware accel.), dynamic offload, GUI, network connection and flexibility.

With FOS, you can develop accelerators in HLS as well as RTL and use them in standard full configuration mode, library mode (single process) for partially reconfigurable accelerators or daemon mode (multiple processes) with dynamic reconfiguration. 

It has in-built support for Vivado HLS accelerators with AXI master and slave interface, and provides uio support to build your own drivers. 

## Getting started

- Download SD Card image
- Set board to SD Card mode and turn it on
- Go to directoy : XYZ
- run ./daemon
- run ./demo_gui

## Tutorials

- How to build HLS accelerators
- How to build RTL accelerators
- How to use Ponq
- How to use Daemon
- How to compile partially reconfigurable modules
- How to build Linux (Pynq / Ubuntu) Image

## Papers

If you found FOS useful please consider citing following papers:

Hardware: 
- ZUCL
- BitMan

Software: 
- Resource elasticity
- Live migration 
- Heterogeneous resource elasticity


## License information



## Get in Touch 

If you would like to ask questions, report bugs or collaborate on research project, please email any of the following: 

- Anuj Vaishnav (anuj.vaishnav@manchester.ac.uk)
- Khoa Dang Pham (khoa.pham@manchester.ac.uk)
- Dirk Koch (dirk.koch@manchester.ac.uk)

Team:
Anuj Vaishnav, Khoa Dang Pham, Joe Powell, Alasdair Olway, Kristiyan Manev, Dirk Koch 

## Acknowledgments

This work is supported by the Xilinx University Program. 

