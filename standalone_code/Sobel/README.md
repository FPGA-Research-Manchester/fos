# Using the Sobel HLS Module on your FPGA
## Introduction
From here on out we document how to use the HLS modules that are created using
[the following tutorial](../../compilation_flow/hls/README.md).

In this tutorial, I detail how I use the Sobel module I created using the tutorial linked above. I will go over how to load the bitstream onto the FPGA and how to create a driver file to use the hardware. 

This tutorial assumes that you have a correct bitstream ready to be used and that you have Udmabuf installed and ready-to-use. For details of how to install Udmabuf, check the [github page](https://github.com/ikwzm/udmabuf).

**Note**: the driver file is found [here](./sobel_linux.cpp)

## Contents
  - [Set Up](#set-up)
  - [Code Breakdown](#code-breakdown)
  - [Compilation and Running](#compilation-and-running)

## Set Up
Listed below are the tools and pieces of information that I used to create the driver file.
  - [Udmabuf](https://github.com/ikwzm/udmabuf)
  - OpenCV, C++
  - Base address of the module in memory
  - Module register offsets
  
**N.B.** Where to find the addresses will be detailed below

## Code Breakdown
In this section I document how to correctly write the driver file, such that we can manipulate the static bitstream we have created.

### Preprocessor Directives
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

### Intialising the Module
In this section of the code, we are seeking to initialise the module's registers so that we can use them later on in the driver file. Due to the nature of an OS, we cannot simply access memory whenever we like, we have to jump through some hoops. In this case, those hoops are defined by the [mmap()](http://man7.org/linux/man-pages/man2/mmap.2.html) function. The mmap() function returns a pointer to an area of memory that we can use to offset from and access the module's registers. 

In this context, we created a function because we need to use mmap() more than once. The only things that are modifed are the type of memory we want to access, physical or virtual, where we want the memory to start, the case of the module this is defined by the base offset of the registers in memory *i.e.* 0xA0000000, and the amount of space we need.

```c++
  volatile int in_pixels = 0x10;
  volatile int out_pixels = 0x18;

  // ==== Set up the module's registers ====
  size_t pagesize = sysconf(_SC_PAGE_SIZE);
  uint8_t* filter_reg = (uint8_t*)set_hw_registers("/dev/mem", (int64_t)control_reg, (int64_t)pagesize);
  printf("filter_reg = %lx\n", filter_reg);
  if (filter_reg== MAP_FAILED)
  {
     perror("Memory mapping failed for image filter registers\n");
     return -1;
  }

  int* filter_control; int* image_in; int* image_out;
  if (strcmp(argv[1], "HW") == 0)
  {
    filter_control = (int*)filter_reg;
    printf("filter_control=%lx\n", filter_control);
    image_in = (int*)(filter_reg + in_pixels);
    printf("image_in=%lx\n", image_in);
    image_out = (int*)(filter_reg + out_pixels);
    printf("image_out=%lx\n", image_out);
  }

void* set_hw_registers(const char* filepath, long offset, long size)
  {
    int fd = open(filepath , O_RDWR | O_SYNC);
    printf("mapping filepath: %s, offset: %ld, size: %ld\n", filepath, offset, size);
    if (fd < 0) {
      perror("Couldn't load file");
      exit(-1);
    }
    return mmap(NULL, size, PROT_WRITE | PROT_READ, MAP_SHARED, fd, offset);
  }
```
The offsets we use are defined for us using the SDK tools:
  1. Once you successfully generated a bitstream, go to **File** > **Export** > **Export Hardware...**. Make sure you select **Include bitstream** and leave the rest as their default values. Then click **OK**. 
  2. Then go to, **File** > **Launch SDK** and select **OK**.
  3. Once SDK has loaded, you can close the window as you won't need SDK for anything else.
  4. The offsets are defined in a file named `x<module-project-name-here>_hw.h`. It can be found in the Vivado project directory: `./<project-name>.sdk/design_1_wrapper_hw_platform_0/drivers/<module-name>_v1_0/src/x<module-name>_hw.h`

### Using Udmabuf
Images need to be in contiguous buffer. This does it.
When software needs to access hardware, we need to use virtual memory, this does it



### Preparing the Module to Run Correctly
Reading the data into memory - doesn't need much explanation, its just basic OpenCV
Storing stuff in registers and saying go.
Checking when the module is done

### Outputting Results


## Compilation and Running
inc. how to copy module onto FPGA
