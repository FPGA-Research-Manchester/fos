# C++ FPGA manager

## Usage (dynamic)
1. Initialise pr manager
```
PRManager prmanager;
```
2. Load a shell
```
prmanager.fpgaLoadShell("Ultra96_100MHz_2");
```
3. Load and program an accelerator
```
paramlist params({
  {"in_pixels",      bot32(buf0addr)},
  {"in_pixels_msb",  top32(buf0addr)},
  {"out_pixels",     bot32(buf1addr)},
  {"out_pixels_msb", top32(buf1addr)},
  {"im_width",       width},
  {"im_height",      height} 
});
AccelInst inst = prmanager.fpgaRun("Partial_sobel", params);
inst.wait();
```


## Usage (static)
1. Initialise pr manager
```
PRManager prmanager;
```
2. Load and program an accelerator
```
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
