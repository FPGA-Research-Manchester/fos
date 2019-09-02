# Using the Sobel HLS Module on your Zynq FPGA
## Introduction
Here we document how to use the HLS modules that are created using the [HLS tutorial](../../compilation_flow/hls/README.md) on the Linux image provided in this report, without any special libs or daemon.

We will go over how to load the bitstream onto the FPGA and how to create a driver file to use the hardware. 

This tutorial assumes that you have a bitstream ready to be used and that you have Udmabuf installed and ready-to-use. For details of how to install Udmabuf, check the [github page](https://github.com/ikwzm/udmabuf).

**Note**: the source code is found [here](./sobel_linux.cpp), with its corresponding header file found [here](./sobel_linux.h)

## Contents
  - [Set Up](#set-up)
  - [Code Breakdown](#code-breakdown)
  - [Compilation and Running](#compilation-and-running)

## Set Up
Listed below are the tools and pieces of information that we used to create the driver file.
  - [Udmabuf](https://github.com/ikwzm/udmabuf)
  - OpenCV, C++
  - Base address of the module in memory
  - Module register offsets
  
**N.B.** Where to find the addresses will be detailed below.

## Code Breakdown
In this section we document how to correctly write the driver file.

### Preprocessor Directives
#### <mman.h>
This is the driver file that we need to use the mmap() function. We will talk about this in a later section but we need them to be able to access the modules registers through `/dev/mem` and `/dev/udmabuf0`.

#### <fcntl.h>
This header file is mainly used to provide the O_SYNC and O_RDWR status flags when we use the open() function.

#### <unistd.h>
This header file is used for the \_SC\_PAGE\_SIZE constant value that we use with sysconf() to find the page size of the OS we are using *i.e.* Ubuntu 16.

#### #define control_reg
This is the base address of the module's registers in hardware. This can be found in Vivado. 
  1. Open Vivado and navigate to the module's project.
  2. Open the block design for the project.
  3. On the same section of the window that contains the block design, there is a tab called **Address Editor**. Here you can find the base address.

#### #define buffer_offset
This is used in connection with the Udmabuf and will be explained further down. 

#### Best of the Rest
We haven't spoken about some of the header files as we feel that they are self-explanatory *e.g.* opencv, std libs *etc.*

The rest of the preprocessor directives, such as defines or typedefs, are self-explanatory, therefore, we will not be talking about them.

### Intialising the Module
In this section of the code, we are seeking to initialise the module's registers so that we can use them later on in the driver file. We need to map the physical address to the virtual address space of our application. We do this using the [mmap()](http://man7.org/linux/man-pages/man2/mmap.2.html) function. The mmap() function returns a pointer to an area of memory that we can use to offset from and access the module's registers. 

In this context, we created a function because we need to use mmap() more than once. The only things that are modifed are the type of memory we want to access, physical or virtual, where we want the memory block to start, this can be 0 or a specific address *i.e.* 0xA0000000, and the amount of space we need.

```c++
  volatile int in_pixels = 0x10;
  volatile int out_pixels = 0x18;

  // ==== Set up the module's registers ====
  size_t pagesize = sysconf(_SC_PAGE_SIZE);
  uint8_t* filter_reg = (uint8_t*)set_hw_registers("/dev/mem", (int64_t)control_reg, (int64_t)pagesize);
  if (filter_reg== MAP_FAILED)
  {
     perror("Memory mapping failed for image filter registers\n");
     return -1;
  }

  int* filter_control; int* image_in; int* image_out;
  if (strcmp(argv[1], "HW") == 0)
  {
    filter_control = (int*)filter_reg;
    image_in = (int*)(filter_reg + in_pixels);
    image_out = (int*)(filter_reg + out_pixels);
  }

void* set_hw_registers(const char* filepath, long offset, long size)
  {
    int fd = open(filepath , O_RDWR | O_SYNC);
    if (fd < 0) {
      perror("Couldn't load file");
      exit(-1);
    }
    return mmap(NULL, size, PROT_WRITE | PROT_READ, MAP_SHARED, fd, offset);
  }
```
The offsets we use are defined for us using the SDK tools:
  1.  Navigate to the HLS project directory that contains the Sobel module code.
  2.  Now go to: **solution1** > **impl1** > **ip** > **drivers** > **top_function_name** > **src**
  3.  In this directory, you will find a file that ends with "\_hw.h". In here is where you will find the relevant register offsets you will need. Make a note of these

### Using Udmabuf
The github page for the udmabuf says that it is a, `"Linux device driver that allocates contiguous memory blocks in the kernel space as DMA buffers and makes them available from the user space."`. We need a buffer of contiguous memory so that we can store the image data, both input and output, in the right order. It should be noted, that you only need to store arrays of data on the buffer, single values can just be stored in the corresponsing registers.

In this section of code, we are doing exactly the same thing we did with the module registers but with different parameters. However, we will be creating a pointer to the udmabuf buffer and not main memorey. Using this pointer to the base address of the udmabuf buffer in physical memory, we can use offsets to create pointers that define sections of the buffer. In this case, we need one section for the input image data and one for the output image data.

You will also notice, that the offset value for the buffer is 0. This signifies to the mmap() function that we don't care where the buffer starts from.

```c++
  int64_t buffer_size = get_buffer_size();
  if (buffer_size == -1)
  {
    perror("Failed to get the udmabuf size\n");
    return -1;
  }
  
  ...
  
  uint8_t* virtual_src = (uint8_t*)set_hw_registers("/dev/udmabuf0", 0, buffer_size);		
  if (virtual_src == MAP_FAILED)
  {
     perror("Memory mapping failed for input image\n");
     return -1;
  }
  uint8_t* virtual_dst = (virtual_src + buffer_offset);

int64_t get_buffer_size()
{
  int64_t buffer_size;
  char attr[1024];
  int buffer_fd; 
  if ((buffer_fd = open("/sys/class/udmabuf/udmabuf0/size", O_RDONLY)) != -1)
  {
    read(buffer_fd, attr, 1024);
    sscanf(attr, "%ld", &buffer_size);
    close(buffer_fd);		
    return buffer_size;
  } 
  else 
  {
    return -1;
  }
}
```

### Preparing the Module to Run Correctly
This section will be devoted to the preparing the module before running it.

#### Step 1: Preparing the input data
This step is just basic OpenCV. It involves reading the image into a matrix and converting it into greyscale.

The next part to this step involves reading the data from the matrix into the buffer, such that the module will have access to it. We did this using 2 for loops. It involves iterating through the matrix's elements, one-by-one.

```c++
  for (int y = 0; y < src.rows; y++)
  {
    int lineoff = y*src.cols;
    for (int x = 0; x < src.cols; x++)
    {
      virtual_src[lineoff+x] = src.at<char>(y,x);
    }
  }
```

#### Step 2: Pointing the module to the right places
Now that we have the input data on the buffer, and pointers to the individual sections of the buffer, we can begin preparing the module for use.

In this section, it is important to note that the module wants the physical hardware address of the udmabuf buffer, not the virtual addresses. The code to get this address is straightforward and is documented below:
```c++
int64_t get_buffer_addr()
{
  int64_t buffer_phys_addr;
  char attr[1024];
  int buffer_fd; 
  if ((buffer_fd = open("/sys/class/udmabuf/udmabuf0/phys_addr", O_RDONLY)) != -1)
  {
    read(buffer_fd, attr, 1024);
    sscanf(attr, "%lx", &buffer_phys_addr);
    close(buffer_fd);		
    return buffer_phys_addr; 
  } 
  else
  {
    return -1;
  }
}
```
The base physical address and the corresponding offsets of the buffer and the virtual equivalent point to the same thing, so you just need to supply the base physical address and any offsets that may be needed.

With this in mind, here's what you need to do:

  1. In our case, the input image data is stored from the base address. So we just need to supply the base address of the udmabuf buffer to the image_in register.
  2. The output image data is currently empty, but we still need to supply the pointer to the module. This is simply the base address of the buffer + the same offset we used in the buffer.

```c++
*image_in = (buffer_phys_addr);
*image_out = (buffer_phys_addr + buffer_offset);	
```

#### Step 3: Go!
Starting the module is really simple, as you can see in the code below:
```c++
printf("GO!\n");
*filter_control = *filter_control | 1;
while (!((*filter_control) & 2));
printf("Finished\n");
```
To start the module, you need to set bit 0 to 1. **NOTE:** The meaning of each specific control register bit is documented in the  [initialising the module section](#intialising-the-module). We use a while loop to check bit 1 *i.e.* the done bit. This will tell us when the module has finished.

#### Hardware Vs Software
In our version of the driver file, we wanted to see the difference between the code being run on hardware and software. To support this, we copied the sobel code from the [github](https://github.com/Xilinx/SDAccel_Examples/blob/1e273f6ef01073f878a4c2b5ca4d6ad5aec7e616/vision/edge_detection/src/krnl_sobelfilter.cl) directory. All we then need to do is remove the OpenCL specific code and call the code like a normal C++ function. 

We use the software version like a normal C++ function, so we still need pass the sections of the udmabuf buffer as pointers to the function. We, however, do not need to access the registers, as they dont exist. 

### Outputting Results
This is done in two steps: reading data from the buffer into a Mat object, outputting the Mat object to the screen

#### Reading Data from the Buffer
This is done in a similar manner to writing data into the buffer. We did it like this:
```c++
for (int y = 0; y < dst.rows; y++)
{
  int lineoff = y*dst.cols;
  for (int x = 0; x < dst.cols; x++)
  {
    dst.at<char>(y,x) = virtual_dst[lineoff+x];
  }
}
```

#### Outputting the Matrix
This just simple OpenCV: `imshow("Output", dst);`

## Compilation and Running
In this section, we document how we used the driver file. There are two files that we use to complete both of these steps: [makefile](./makefile) and [run.sh](./run.sh).

### Compilation
We achieved this by writing a regulation makefile, remembering to link against the OpenCV libs.

### Running
```bash
set -e
xhost +
sudo cp sobel.bin /lib/firmware
make sobel_linux 
sudo su -c "echo 'sobel.bin' > /sys/class/fpga_manager/fpga0/firmware"
sudo DISPLAY=:0 ./sobel_linux HW
```

#### xhost +
This lines allows us to print to screen that we have connected our FPGA to. It makes sure that anyone can access the X server to output data

#### sudo cp sobel.bin /lib/firmware
This line is how we prepare the bitstream for loading.

#### sudo su -c "echo 'sobel.bin' > /sys/class/fpga_manager/fpga0/firmware"
This line tells the FPGA driver to load sobel.bin onto the FPGA fabric. It should be noted that, everytime we do this, the sobel module will reset

#### sudo DISPLAY=:0 ./sobel_linux HW
This is the line that runs the compiled source code. The command line parameter
can either be HW or SW. This tells the code whether we want to run it in
hardware or software.
