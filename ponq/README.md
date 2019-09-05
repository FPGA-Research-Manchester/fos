# PONQ

## Python library to drive FPGAs and accelerators
PONQ is an api to drive an FPGA through the FPGA manager api, as well as accelerators loaded onto the FPGAs.

An example application of mandelbrot viewer with *FPGA acceleration using Ponq* can be found in [bufblit.py](./bufblit.py).

## Usage: Static full bitstream
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
3. Load accelerator onto FPGA
```Python
manager = Ponq(repository="./bitstreams")
acc = manager.load("Full_vecadd")
```
4. Drive accelerator
```Python
acc.writeReg("ocl_sx", 1)
acc.writeReg("ocl_sy", 1)
acc.writeReg("ocl_sz", 1)
acc.writeReg("size", items)
acc.writeReg("in_a", buf0addr)
acc.writeReg("in_b", buf1addr)
acc.writeReg("out", buf2addr)
acc.run()
acc.wait()
```
5. Unload accelerator
```Python
acc.unload()
```

## Usage: Dynamic partial bitstream (manual)
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
  "name": "Partial_mandelbrot",
  "bitfiles": [
    {"name": "Partial_mandelbrot_slot_0.bin", "region": "pr0"},
    {"name": "Partial_mandelbrot_slot_1.bin", "region": "pr1"},
    {"name": "Partial_mandelbrot_slot_2.bin", "region": "pr2"}
  ],
  "registers": [
    {"name": "control", "offset": "0x0"},
    {"name": "imageWidth", "offset": "0x10"},
    {"name": "imageHeight", "offset": "0x18"},
    {"name": "maxIterations", "offset": "0x20"},
    {"name": "centreRealLow", "offset": "0x28"},
    {"name": "centreRealHi", "offset": "0x2c"},
    {"name": "centreImagLow", "offset": "0x34"},
    {"name": "centreImagHi", "offset": "0x38"},
    {"name": "zoomLow", "offset": "0x40"},
    {"name": "zoomHi", "offset": "0x44"},
    {"name": "framebufferLow", "offset": "0x4c"},
    {"name": "framebufferHi", "offset": "0x50"}
  ]
}
```
5. Load shell onto FPGA
```Python
manager = Ponq(repository="./bitstreams")
manager.loadShell("Ultra96_100MHz_2")
```
6. Load accelerator onto FPGA
```Python
acc = manager.load("Partial_mandelbrot")
```
7. Drive accelerator
```Python
acc.setRegs({
  "imageWidth":     width,
  "imageHeight":    height,
  "maxIterations":  256,
  "centreRealLow":  bot32(float2fix(cre)),
  "centreRealHi":   top32(float2fix(cre)),
  "centreImagLow":  bot32(float2fix(cim)),
  "centreImagHi":   top32(float2fix(cim)),
  "zoomLow":        bot32(float2fix(zoom)),
  "zoomHi":         top32(float2fix(zoom)),
  "framebufferLow": bot32(udma_addy),
  "framebufferHi":  top32(udma_addy)
})
acc.run()
acc.wait()
```
8. Unload accelerator
```Python
acc.unload()
```

## Usage: Dynamic partial bitstream (automatic)
1. Create shell for the bitstream
2. Write JSON description of the shell
3. Create bitstream of the accelerator
4. Write JSON description of the accelerator
5. Load shell onto FPGA
```Python
manager = Ponq(repository="./bitstreams")
manager.loadShell("Ultra96_100MHz_2")
```
6. Run accelerator
```Python
manager.run("Partial_mandelbrot", {
  "imageWidth":     width,
  "imageHeight":    height,
  "maxIterations":  256,
  "centreRealLow":  bot32(float2fix(cre)),
  "centreRealHi":   top32(float2fix(cre)),
  "centreImagLow":  bot32(float2fix(cim)),
  "centreImagHi":   top32(float2fix(cim)),
  "zoomLow":        bot32(float2fix(zoom)),
  "zoomHi":         top32(float2fix(zoom)),
  "framebufferLow": bot32(udma_addy),
  "framebufferHi":  top32(udma_addy)
})
```
