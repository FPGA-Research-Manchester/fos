# C++ FPGA manager

## Usage (dynamic)
This method is used when an accelerator is to be loaded into a shell
1. Initialise pr manager
```C++
PRManager prmanager;
```
2. Load a shell
```C++
prmanager.fpgaLoadShell("Ultra96_100MHz_2");
```
3. Load and program an accelerator
```C++
paramlist params({
  {"in_pixels",      bot32(buf0addr)},
  {"in_pixels_msb",  top32(buf0addr)},
  {"out_pixels",     bot32(buf1addr)},
  {"out_pixels_msb", top32(buf1addr)},
  {"im_width",       width},
  {"im_height",      height} 
});
AccelInst inst = prmanager.fpgaRun("Partial_sobel", params); // do PR, program accel and run
inst.wait(); // wait for execution to finish
prmanager.fpgaUnloadRegions(inst); // clean up
```


## Usage (static)
This method is used when the accelerator is to be loaded as a single bitstream
1. Initialise pr manager
```C++
PRManager prmanager;
```
2. Load and program an accelerator
```C++
StaticAccelInst vecadd = prmanager.fpgaLoadStatic("Full_vecadd");
paramlist params({
  {"ocl_sx", 1},
  {"ocl_sy", 1},
  {"ocl_sz", 1},
  {"size", count},
  {"in_a", buf0addr},
  {"in_b", buf1addr},
  {"out",  buf2addr}
});
vecadd.programAccel(params);
vecadd.runAccel();
vecadd.wait();
```
