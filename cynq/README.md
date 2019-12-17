# C++ FPGA manager

## Usage (dynamic)

1. Create shell for the bitstream
2. Write JSON description of the shell
```JSON
{
  "name": "Ultra96_100MHz_2",
  "bitfile": "Ultra96_100MHz_2.bin",
  "regions": [
    {"name": "pr0", "blank": "Blanking_slot_0.bin", "bridge": "0xa0010000", "addr": "0xa0000000"},
    {"name": "pr1", "blank": "Blanking_slot_1.bin", "bridge": "0xa0020000", "addr": "0xa0001000"},
    {"name": "pr2", "blank": "Blanking_slot_2.bin", "bridge": "0xa0030000", "addr": "0xa0002000"}
  ]
}
```
3. Create bitstream of the accelerator
4. Write JSON description of the accelerator
```JSON
{
  "name": "Partial_sobel",
  "bitfiles": [
    {"name": "Partial_sobel_slot_0.bin", "region": "pr0"}
  ],
  "registers": [
    {"name": "control", "offset": "0x0"},
    {"name": "in_pixels", "offset": "0x10"},
    {"name": "in_pixels_msb", "offset": "0x14"},
    {"name": "out_pixels", "offset": "0x1c"},
    {"name": "out_pixels_msb", "offset": "0x20"},
    {"name": "im_width", "offset": "0x28"},
    {"name": "im_height", "offset": "0x30"}
  ]
}
```
5. Initialise pr manager and load the shell
```C++
PRManager prmanager;
prmanager.fpgaLoadShell("Ultra96_100MHz_2");
```
6. Load and program an accelerator
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

1. Create bitstream of the accelerator
2. Write JSON description of the accelerator
```JSON
{
  "name": "Full_vecadd",
  "address": "0xa0000000",
  "bitfiles": [
    {"name": "Full_vecadd.bin", "region": "full"}
  ],
  "registers": [
    {"name": "control", "offset": "0x0"},
    {"name": "ocl_sx", "offset": "0x10"},
    {"name": "ocl_sy", "offset": "0x18"},
    {"name": "ocl_sz", "offset": "0x20"},
    {"name": "size", "offset": "0x28"},
    {"name": "in_a", "offset": "0x30"},
    {"name": "in_b", "offset": "0x38"},
    {"name": "out", "offset": "0x40"}
  ]
}
```
3. Initialise pr manager
```C++
PRManager prmanager;
```
4. Load and program an accelerator
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
