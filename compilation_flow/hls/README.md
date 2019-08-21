# HLS -> Static Bitstream

## Introduction

Here we provide a step-by-step tutorial on how to generate a static bitstream. We use the Sobel edge detection algorithm as an example to demonstrate the process. However, the steps remain the same for other modules you may to want to create. 
## Contents
  - [Set-up](#set-up) 
  - Creating a Custom Module with Vivado HLS
  - Using Your Custom Module in Vivado
  - List of Files Needed 
  - Known Issues
  
## Set-up
Listed below are the tools that I used to generate the static bitstream of a Sobel algorithm:

Does this flow work with:
  - Vivado 2018.2
  - Ubuntu 18
  
### Tools Used:
  - [Vivado 2018.3](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2018-3.html)
  - Ubuntu 16.04.5 LTS
  - [Avnet Ultra96v1 Development Board](https://www.avnet.com/shop/us/products/avnet-engineering-services/aes-ultra96-g-3074457345634920668/?aka_re=1)
  - OpenCL, OpenCV, C/C++
  - [Sobel OpenCL Code](https://github.com/Xilinx/SDAccel_Examples/tree/1e273f6ef01073f878a4c2b5ca4d6ad5aec7e616/vision/edge_detection)
  
## Creating a Custom Module with Vivado HLS

### Step 1 - Creating a New Project

1.  To create a new project go to **File** > **New Project**
2.  You'll be greeted by this screen:
    ![alt text]()
    Choose a suitable name and location for the project.
3.  Next, enter the name of the main function in the program. In our case, this is krnl_sobel. From here you can import the source file. You can also import the source files later on in the process, I will point this out.
4.  The same applies for the testbench files. 
5.  This screen allows to us to tailor our module to a certain architecture. Click the 3 dots in the 'Part Selection' area of the next window. From this window you can pick a specific FPGA or board. In this tutorial we be selecting a specific board to synthesise our module for. It should be noted that Vivado 2018.3 does not contain an entry for the Ultra96 platform. However, when designing the modules, we found that it works fine by using the ZCU102 platform as they both use the same ZYNQ FPGA. 
![image]()
    We don't need to worry about any of the options in the clock section of the window. Obviously, you can choose a different name for your solution.
6.  The final thing to do is select the **Finish** button.
  
### Step 2 - C Simulation

### Step 3 - Synthesis

### Step 4 - Creating RTL Module

## Using Your Custom Module in Vivado

### Step 1 - Create a New Project 
inc. adding new IP

### Step 2 - Create a Block Diagram

### Step 3 - Generating the Bitstream

## List of Files Neededviv  

### xmodule-name_hw.h
### .bin file

## Known Issues
  - There is a bug in Vivado HLS 2018.3, such that, sometimes, you will have to create a new project in order to see the changes to the interface
  - Found no way to test OpenCL code, using testbenches, on Vivado HLS
