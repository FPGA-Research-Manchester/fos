# Getting Started with Partial Reconfiguration on UltraZed

## Introduction
This document provides a short tutorial of how to create partially reconfigurable (PR) modules and, also, how to launch them at runtime using Xilinx Vivado 2018.2 and PetaLinux 2018.2. The board we target for this tutoral is the UltraZed. Furthermore, we assume that Vivado SDx and Petalinux 2018.2 are already installed.

### Useful Links
  - [Examples, drivers and datafiles](https://www.dropbox.com/sh/qsg5m7jp1sn4saj/AABAzSGOa91K0Kvtlz_0LuRta?dl=0)
  - [Petalinux 2018.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools/archive.html)
  - [Vivado 2018.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html)
  
## Generating PR Accelerators
### Synthesise the Module Out-Of-Context
We start the process by synthesising the module's RTL code which was generated, using Vivado HLS, to be an out-of-context module. In our current flowm the use of the VHDL code is essential for compatibility.

1.  Create a Vivado project with the sources
2.  In Vivado, use the following TCL comments:
    - *read_vhdl* {**list of all the contents in the vhdl folder**}
    - *synth_design -mode out_of_context -flatten_hierachy rebuilt -part xczu3eg-sfva625-1-i -top* {**module's top name**}
    - *write_checkpoint -force ./Synth/reconfig_modules/*{**module's top name**}
    - *close_design*
    - *close_proect*

### Implement the PR Module Using Blocker Templates
In this step, we are going to physically implement the module nased on provided blocker templates. We have templates for modules occupying 1, 2 or 3 slots. The AXI interfaces between the module and the static system is pre-placed and pre-routed in clock row Y0.

For this tutorial, we are using a 32-bit AXI Lite slave port and 126-bit AXI full master port.  

1.  Based on the module synthesis report, choose how many slots are needed. The available resources per slot can be found in the following table:

    | Available Resources | Numbers |
    |---------------------|---------|
    | CLB LUTs            | 17760   |
    | RAMB36/FIFO         | 60      |
    | RAMB18              | 120     |
    | DSPs                | 96      |
    
2.  According to the neccesary resources, choose to run: *pr_module_1_slot.tcl, pr_module_2_slots.tcl,* or *pr_module_3_slots.tcl*.
    - Change the top module to the module name: **set top_module xx**
    - *source ./pr_module_xx.tcl*

Thsi will run the entire logic synthesis, as well as the physical implementation all the way to a (full) bitstream. The implementation scripts will use blocker macros (provided as DCPs) that constrain the routing of the module in strict bounding boxes.

The physical implementation results are as the following figure:

![alt tag](./images/Untitled.png)

### Merge the PR Module into the Given Static Design Bitstream
Now, we start mering the PR module to the static design at bitstream level. The static design is as the following figure:

![alt tag](./images/static_ultra_zed.png)

The tool BitMan is used to conduct this step:
1.  Merging the PR module which is allocated in Slot 0 to the static:
    - *bitman_linux-m 21 0 99 59 ./{module’s top name}_full.bit ./HTV_STC.bit -F ./Merge_{module’s top name}_HTV_STC.bit*
2.  Merging the PR module which is allocated in either Slot 0 or 1 to the static: 
    - *bitman_linux-m 21 0 99 119 ./{module’s top name}_full.bit ./HTV_STC.bit -F ./Merge_{module’s top name}_HTV_STC.bit*
3.  Merging the PR module which is allocated in either Slot 0, 1 or 2 to the static:
    - *bitman_linux-m 21 0 99 179 ./{module’s top name}_full.bit ./HTV_STC.bit -F ./Merge_{module’s top name}_HTV_STC.bit*
    
The three commands are essentially the same and only differ in the number of slots that are cut out from the (full) module configuration bitstream that is then merged into the fulls tatic bitstream (*HTV_STC.bit*). This process is carried out in a way that will not touch the routing information of the global clock resources.

### Create Partial Bitstreams from the Merged Full Bitstream
The partial bitstreams can be extracted from the aforementioned merged bitstream by the following BitMan commands: 

1.  In order to cut out the module and place it in one of the three slots, use one of the following lines. This will generate the corresponding partial bitstreams:
    - *bitman_linux -x 21 0 99 59 ./Merge_{module’s top name}_HTV_STC.bit –M 21 0 ./Partial_{module’s top name}_Slot_0.bit*
    - *bitman_linux -x 21 0 99 59 ./Merge_{module’s top name}_HTV_STC.bit –M 21 60 ./Partial_{module’s top name}_Slot_1.bit*
    - *bitman_linux -x 21 0 99 59 ./Merge_{module’s top name}_HTV_STC.bit –M 21 120 ./Partial_{module’s top name}_Slot_2.bit*
2. To perform the same for placing a two-slot module use:
    - *bitman_linux -x 21 0 99 119 ./Merge_{module’s top name}_HTV_STC.bit–M 21 0 ./Partial_{module’s top name}_Slot_0_1.bit*
    - *bitman_linux -x 21 0 99 119 ./Merge_{module’s top name}_HTV_STC.bit–M 21 60 ./Partial_{module’s top name}_Slot_1_2.bit*
    
3.  To perform the same for place a three-slots module use:
    - *bitman_linux -x21 0 99 179./Merge_{module’s top name}_HTV_STC.bit–M 21 0 ./Partial_{module’s top name}_Slot_0_1_2.bit*
      
These are all Xilinx-compatible partial bitstreams. However, in order to use PCACP to load those partial bitstreams onto an FPGA at runtime, we need to convert them to another Xilinx format. This step is automatically done by the Xilinx SDK tool (installed with Vivado Design Suite). We follow the following steps:
1.  Put the below command into the XSCT console:
```
bootgen -image Bitstream.bif -arch zynqmp -o ./{module's top name}_Slot.bin -w
```
2. The Bitstream.bif file contains:
```
all:
{
    {Bitstream file name}.bit
}
```
## Misc
When you synthesise the module out-of-context you may want to use the following instruction instead of using the 1st instruction:
*Copy the VHDL folder from your Vivado HLS project to the ./Sources folder*
