# Udmalib

To allow accelerators to use contiguous physical memory for their computation and I/O, we use [udmabuf](https://github.com/ikwzm/udmabuf). 
This library provides the function to create, use and destroy udma buffers. 
Hence, it acts as a backend for data management offered by the daemon. 

You can use this library to setup and use your own contiguous buffers along with udmabuf module. 
