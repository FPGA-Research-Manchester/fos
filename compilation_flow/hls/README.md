# HLS -> Static Bitstream

## Introduction

Here we provide a step-by-step tutorial on how to generate a static bitstream. We use the Sobel edge detection algorithm as an example to demonstrate the process. However, the steps remain the same for other modules you may to want to create. The only exceptions to this are the specific register offsets of the hardware module.

## Contents
  - [Set-up](#set-up) 
  - Creating a Custom Module with Vivado HLS
  - Using Your Custom Module in Vivado
  - List of Files Needed 
  - Known Issues
  
## Set-up
Listed below are the tools that I used to generate the static bitstream:

Does this flow work with:
  - Vivado 2018.2
  - Ubuntu 18
### Tools Used:
  - [Vivado 2018.3](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2018-3.html)
  - Ubuntu 16.04.5 LTS
  - [Avnet Ultra96v1 Development Board](https://www.avnet.com/shop/us/products/avnet-engineering-services/aes-ultra96-g-3074457345634920668/?aka_re=1)
  - OpenCL, OpenCV, C/C++
  
## Creating a Custom Module with Vivado HLS

### Step 1 - Creating a New Project

### Step 2 - C Simulation

### Step 3 - Synthesis

### Step 4 - Creating RTL Module

## Using Your Custom Module in Vivado

### Step 1 - Create a New Project 
inc. adding new IP

### Step 2 - Create a Block Diagram

### Step 3 - Generating the Bitstream

## List of Files Needed

### xmodule-name_hw.h
### .bin file

## Known Issues
  - There is a bug in Vivado HLS 2018.3, such that, sometimes, you will have to create a new project in order to see the changes to the interface
