# Compilation Flow

The image below shows the application compilation flow for HLS accelerators.

![compilation flow](./pr_flow/images/fig-flow.png)

In order to create the RTL description from your software follow the Phase 1 of [HLS tutorial](./hls/). Once you have the RTL description of your accelerator you can create a partial bitstream for it using the [tutorial PR flow](./pr_flow/) or continue with Phase 2 of [HLS tutorial](./hls/) for a static accelerator bitstream. 


## How to use your own shell with FOS

To use your own shell with FOS libs (Cynq or Ponq) or FOS Daemon:

1. Create a static system and corresponding module compilation path

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
3. Compile accelerator module for each partial region of your shell and write a JSON description for them
```JSON
{
  "name": "Partial_sobel",
  "bitfiles": [
    {"name": "Partial_sobel_slot_0.bin", "region": "pr0"}
    {"name": "Partial_sobel_slot_1.bin", "region": "pr1"}
    {"name": "Partial_sobel_slot_2.bin", "region": "pr2"}
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
3. Register the JSON descriptions into repo.json
```json
{
  "shell": "<shell name>",
  "accelerators": [
    "<accelerator name>",
    "<accelerator name>",
    "<accelerator name>"
  ]
}
```
4. Use the daemon or FOS libs as usual
