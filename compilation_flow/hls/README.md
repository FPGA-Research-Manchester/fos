# HLS -> Static Bitstream

## Introduction

Here we provide a step-by-step tutorial on how to generate a static bitstream. We use the Sobel edge detection algorithm as an example to demonstrate the process. However, the steps remain the same for other modules you may to want to create. 
## Contents
  - [Set-up](#set-up) 
  - [Creating a Custom Module with Vivado HLS](#creating-a-custom-module-with-vivado-hls)
  - [Using Your Custom Module in Vivado](#using-your-custom-module-in-vivado)
  - [List of Files Needed](#list-of-files-needed)
  - [Misc](#misc)
  - [Known Issues](#known-issues)
  
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

**N.B.** 

### Step 1 - Creating a New Project

1.  To create a new project go to **File** > **New Project**
2.  You'll be greeted by this screen:
    ![Step_1.2]()
    Choose a suitable name and location for the project.
3.  Next, enter the name of the main function in the program. In our case, this is krnl_sobel. From here you can import the source file. You can also import the source files later on in the process, I will point this out. ![Step_1.3]()
4.  The same applies for the testbench files. ![Step_1.4]()
5.  This screen allows to us to tailor our module to a certain architecture. Click the 3 dots in the 'Part Selection' area of the next window. From this window you can pick a specific FPGA or board. In this tutorial we be selecting a specific board to synthesise our module for. It should be noted that Vivado 2018.3 does not contain an entry for the Ultra96 platform. However, when designing the modules, we found that it works fine by using the ZCU102 platform as they both use the same ZYNQ FPGA. 
![Step_1.5]()
    We don't need to worry about any of the options in the clock section of the window. Obviously, you can choose a different name for your solution.
6.  The final thing to do is select the **Finish** button.
7.  From here right-click on source in the **Explorer** menu and select **New File...**. From here you navigate to the directory that contains the source files you want to import. The same goes for 'Test Bench' in the same **Explorer** menu. It should be noted that you should include any header files or test data that the module needs to be tested.
![Step_1.7]()
8.  You can view and modify the source code by opening the file from the **Source** directory. For the purposes of the tutorial, the source code will synthesise without modification. The ['Misc'](#misc) section contains modifications that we made to source code, such that it would be compatible with the larger project. 
  
### Step 2 - C Simulation

### Step 3 - Synthesis & Creating the RTL Module

1.  The button to start synthesis is  the green triangle. [Step_3.1]()
2.  If synthesis was successful, this tab should appear: [Step_3.2]()
    This tab contains information about the interface that was generated. For example, bus widths for the slave and master AXI ports
3.  To create the RTL module to use in the Vivado block diagram, you just simply press the 'Export RTL' button. [Step_3.3]()
4.  This menu appears: [Step_3.4]()
    For this tutorial, you can leave these options as the defaults.

## Using Your Custom Module in Vivado

### Step 1 - Create a New Project 
1.  To create a new project, go to **File** > **Project** > **New...**
2.  Navigate to the following screen by pressing next: ![Step_1.2]()
    Choose a suitable name and location for the new project before continuing
3.  For this tutorial select **RTL Project** option in the next menu
4.  The sources can be added in this next window: ![Step_1.4]()
    For the purposes of this tutorial, we use a different method. However, both are equal
5.  We will not be adding any constraints in this tutorial
6.  For the default part menu, we will be going to **Boards** and selecting the Ultra96v1 Evaluation Platform
    ![Step_1.6]()
7.  If all is well, you can click the **Finish** button and get started with a block diagram
8.  From this next window, you can add your sobel module. Just go to **Tools** > **Settings...** > **IP** > **Repository**
    ![Step_1.8]()
    From here, go to **Add** and then navigate to where you stored your sobel module. Note, only the folder needs to be selected, Vivado will automatically detect the IP inside. Once this is done, click **Apply** and **OK**
### Step 2 - Creating the Block Design

1.  From the Flow Navigator menu of the Vivado window, you can select the **Create Block Design** option to get started
    ![Step_2.1]()
    Keep everything the same except the design name, which can be changed at your discretion. 
2.  From the **Diagram** section of the Vivado window you can click the **+**, or press **CTRL + I**, to add new IP to the diagram
3.  Start by getting the block that represents your processing system, PS. For this tutorial, we use the Zynq Ultrascale+ MPSoC PS. Then click the 'Run Block Automation' link from the pop up that appears. Make sure the PS is selected and click **OK** ![Step2.3]()
4.  The next thing we want to set up is a slave and master AXI port to connect our PS to the Sobel module we created. To do this, double click on the PS block. Then go to, **PS-PL Configuration** > **PS-PL Interfaces** > **Master Interface** and select one of the options. Then go to **Slave Interface** > **AXI HP** and select one of the options
![Step_2.4]()
5. Now we add the Sobel module we created. To do so navigate to the menu you would normally select the IP you want and search for the name of top function that you specified in Vivado HLS. In our case, this is Krnl_sobel. Add this to the block design.
![Step_2.5]()
6. Click the 'Run Connection Automation' link from the pop-up that appears. This will add in the neccessary connection blocks that we need to be able to use the Sobel module. Make sure all the boxes are checked before pressing **OK**.
![Step_2.6]()
7. The block design should now look as such:
![Step_2.7]()

### Step 3 - Generating the Bitstream

## List of Files Needed

### xmodule-name_hw.h
### .bin file

## Misc 

## Known Issues
  - There is a bug in Vivado HLS 2018.3, such that, sometimes, you will have to create a new project in order to see the changes to the interface
  - Found no way to test OpenCL code, using testbenches, on Vivado HLS
