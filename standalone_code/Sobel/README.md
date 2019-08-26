# Using the Sobel HLS Module on your FPGA
## Introduction
From here on out we document how to use the HLS modules that are created using
[the following tutorial](../../compilation_flow/hls/README.md).

In this tutorial, I detail how I use the Sobel module I created using the tutorial linked above. I will go over how to load the bitstream onto the FPGA and how to create a driver file to use the hardware.

This tutorial assumes that you have a correct bitstream ready to be used and that you have Udmabuf installed and ready-to-use. For details of how to install Udmabuf, check the [github page](https://github.com/ikwzm/udmabuf).

## Contents
  - [Set Up](#set-up)
  - [Driver File](#driver-file)
  - [Compilation and Running](#compilation-and-running)

## Set Up
Listed below are the tools and pieces of information that I used to create the driver file.
  - [Udmabuf](https://github.com/ikwzm/udmabuf)
  - OpenCV, C++
  - Base address of the module in memory
  - Module register offsets
  
**N.B.** Where to find the addresses will be detailed below

## Driver File
In this section I document how to correctly write the driver file, such that we can manipulate the static bitstream we have created.

### Preprocessor Directives
This will include header files, define statements etc. 

I will only talk about non-std libraries as I think they will need the most explaining:

#### <mman.h>
This is the driver file that we need to use the mmap() function, and consequently the munmap() function as well. I will talk about this in a later section but we need them to be able to access the modules registers through `/dev/mem`

#### <fcntl.h>
This header file is mainly used to provide the O_SYNC and O_RDWR status flags when we use the open() function

#### <unistd.h>
This header file is used for the \_SC\_PAGE\_SIZE constant value when we use sysconf to find the page size of the OS we are using *i.e.* Ubuntu 16

#### Best of the Rest
I haven't spoken about some of the header files as I feel that they are self-explanatory *e.g.* opencv, std libs *etc.*

#### control_reg
This is the base value of the module registers in hardware. This can be found in Vivado. 
  1. Open Vivado and navigate to the module's project.
  2. Open the block design for the project
  3. On the same seciton of the window that contains the block design, there is a tab called **Address Editor**. Here you can find the base address

We will use this address when we want to access the modules registers. 

#### buffer_offset
This is used in connection with the Udmabuf and will be explained further down. 

#### Best of the Rest
The rest of the preprocessor directives are devoted to running module in a software context. This was mainly done so that we could see the speed-up between software and hardware. It should be noted that I have copied and pasted the Sobel OpenCL code from the [github page](https://github.com/Xilinx/SDAccel_Examples/blob/1e273f6ef01073f878a4c2b5ca4d6ad5aec7e616/vision/edge_detection/src/krnl_sobelfilter.cl) and just removed the OpenCL specific code in order to run it as a standard C/C++ function. 

### Buffers
### Accessing Virtual & Physical Memory
### Code Breakdown

## Compilation and Running
