# Using the Sobel HLS Module on your FPGA
## Introduction
From here on out we document how to use the HLS modules that are created using
[the following tutorial](../../compilation_flow/hls/README.md).

In this tutorial, we detail how we used the Sobel module we created using the tutorial linked above. We will go over how to load the bitstream onto the FPGA and how to create a driver file to use the hardware. 

This tutorial assumes that you have a correct bitstream ready to be used and that you have Udmabuf installed and ready-to-use. For details of how to install Udmabuf, check the [github page](https://github.com/ikwzm/udmabuf).

**Note**: the driver file is found [here](./sobel_linux.cpp)

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
  
**N.B.** Where to find the addresses will be detailed below

## Code Breakdown
In this section we document how to correctly write the driver file, such that we can manipulate the static bitstream we have created.

### Preprocessor Directives
#### <mman.h>
This is the driver file that we need to use the mmap() function, and consequently the munmap() function as well. We will talk about this in a later section but we need them to be able to access the modules registers through `/dev/mem`

#### <fcntl.h>
This header file is mainly used to provide the O_SYNC and O_RDWR status flags when we use the open() function

#### <unistd.h>
This header file is used for the \_SC\_PAGE\_SIZE constant value when we use sysconf to find the page size of the OS we are using *i.e.* Ubuntu 16

#### Best of the Rest
We haven't spoken about some of the header files as we feel that they are self-explanatory *e.g.* opencv, std libs *etc.*

#### control_reg
This is the base value of the module registers in hardware. This can be found in Vivado. 
  1. Open Vivado and navigate to the module's project.
  2. Open the block design for the project
  3. On the same seciton of the window that contains the block design, there is a tab called **Address Editor**. Here you can find the base address

We will use this address when we want to access the modules registers. 

#### buffer_offset
This is used in connection with the Udmabuf and will be explained further down. 

#### Best of the Rest
The rest of the preprocessor directives are devoted to running module in a software context. This was mainly done so that we could see the speed-up between software and hardware. It should be noted that we have copied and pasted the Sobel OpenCL code from the [github page](https://github.com/Xilinx/SDAccel_Examples/blob/1e273f6ef01073f878a4c2b5ca4d6ad5aec7e616/vision/edge_detection/src/krnl_sobelfilter.cl) and just removed the OpenCL specific code in order to run it as a standard C/C++ function. 

### Intialising the Module
In this section of the code, we are seeking to initialise the module's registers so that we can use them later on in the driver file. Due to the nature of an OS, we cannot simply access memory whenever we like, we have to jump through some hoops. In this case, those hoops are defined by the [mmap()](http://man7.org/linux/man-pages/man2/mmap.2.html) function. The mmap() function returns a pointer to an area of memory that we can use to offset from and access the module's registers. 

In this context, we created a function because we need to use mmap() more than once. The only things that are modifed are the type of memory we want to access, physical or virtual, where we want the memory to start, the case of the module this is defined by the base offset of the registers in memory *i.e.* 0xA0000000, and the amount of space we need.

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
  1. Once you successfully generated a bitstream, go to **File** > **Export** > **Export Hardware...**. Make sure you select **Include bitstream** and leave the rest as their default values. Then click **OK**. 
  2. Then go to, **File** > **Launch SDK** and select **OK**.
  3. Once SDK has loaded, you can close the window as you won't need SDK for anything else.
  4. The offsets are defined in a file named `x<module-project-name-here>_hw.h`. It can be found in the Vivado project directory: `./<project-name>.sdk/design_1_wrapper_hw_platform_0/drivers/<module-name>_v1_0/src/x<module-name>_hw.h`

### Using Udmabuf
The github page describes udmabuf as a, `"Linux device driver that allocates contiguous memory blocks in the kernel space as DMA buffers and makes them available from the user space."` This is exactly how we use it in the driver file. As a general case, this would be used to store any data related to pointers or arrays. Non-pointer variables can just be stored in the relevant registers. In our case, we store the input and output image data on the udmabuf. This allows the data to be stored contiguously, obviously. 

Another reason we use a udmabuf buffer is that we have some software that is trying to store data onto memory. Therefore, we need to go through virtual memory, in order for us to store data from the software side of things.

In this section of code, we are doing exactly the same thing we did with the module registers but with different parameters. Our filepath is now pointing at the udmabuf, not main memory, and the size of the portion of memory is equivalent to the size of the udmabuf buffer, we have already created. Since we now have a pointer to the base address of the udmabuf buffer in physical memory, we can use offsets to create pointers so that we can store at specific locations. In this case, we need one section for the input image data and one for the output image data.

You will also notice, that the offset value for the buffer is 0. This signifies to the mmap() function that we don't care where the buffer starts from. This is obviously not the case when we need to create buffers for module registers.

It should be noted that types do matter in this case. The Sobel module requires that it's input and output data structures are of the short integer type. You could just as easily specify the virtual_src and virtual_dst pointers as unsigned shorts.

Don't worry about the buffer_phys_addr variable, as this will be explained further down.

```c++
  int64_t buffer_size = get_buffer_size();
  if (buffer_size == -1)
  {
    perror("Failed to get the udmabuf size\n");
    return -1;
  }
  int64_t buffer_phys_addr = get_buffer_addr();
  if (buffer_size == -1)
  {
    perror("failed to open udmabuf addr file\n");
    return -1;
  }	
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
Reading the data into memory - doesn't need much explanation, its just basic OpenCV
Storing stuff in registers and saying go.
Checking when the module is done

This section will be devoted to the preparing the module before running it.

#### Step 1: Preparing the input data
This step is just simple OpenCV image manipulation. It involves reading the image into a matrix and converting it into greyscale. Simple.

The next part in this step is a little less self-explanatory. It involves reading the data from the Mat object onto the udmabuf buffer. I'm sure there are other ways of doing this, but we decided to go for nested for-loops: 

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
This involves iterating from left-to-right and top-to-bottom and reading each individual value onto the buffer. As long as you read it back out of the buffer correctly and into the output matrix, you should have no issues. This will be detailed later on however.

#### Step 2: Pointing the module to the right places
Now that we have the input data on the buffer, and pointers to relevant, individual sections of the buffer, we can begin preparing the module for use.

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
The virtual addresses are only there so that the software can access the hardware, the Sobel module doesn't need them. Furthermore, the base physical address of the buffer and the virtual equivalent point to the same thing, so you just need to supply the base physical address + any offsets that may be needed. This will give the module the correct data.

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
To start the module, you need to set the LSB to 1. **NOTE:** The meaning of each specific control register bit is documented in the  [initialising the module section](#intialising-the-module). We then use a while loop to wait for the module to finish. We check the 'done bit' to see when this is the case. This is the 2nd bit of the control register. 

#### Hardware Vs Software
In our version of the driver file, we wanted to see the difference between the code being run on hardware and software. To support this we copied the sobel code from the [github](https://github.com/Xilinx/SDAccel_Examples/blob/1e273f6ef01073f878a4c2b5ca4d6ad5aec7e616/vision/edge_detection/src/krnl_sobelfilter.cl) directory. If we want to see how the code ran in software, all we need to do is remove the OpenCL specific code and call the code as a normal C++ function.

In the software version of the program, the module's registers would not be used, so we simply added an if statement around those lines. The udmabuf buffer still needs to be used, therefore that code will not change. Furthermore, the way that we run the code is done differently. We just do a normal function call and then output the data that is returned. 

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
This is a simple step. We achieved this by writing a normal makefile, remembering to link against the OpenCV libs.

### Running
This is a little more complex than compilation but we created a shell script to do it for us. Below is the code:
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
This line runs the driver. The command line parameter can either be SW or HW. This feature is documented [here](#hardware-vs-software)
