# Using the Sobel HLS Module on your FPGA
## Introduction
From here on out we document how to use the HLS modules that are created using
[the following tutorial](../../compilation_flow/hls/README.md).

In this tutorial, I detail how I use the Sobel module I created using the tutorial linked above. I will go over how to load the bitstream onto the FPGA and how to create a driver file to use the hardware.
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
### Header Files
### Buffers
### Accessing Virtual & Physical Memory
### Code Breakdown

## Compilation and Running
