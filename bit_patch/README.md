# Bit Patch

Bit patch takes in a bitstream for one PR region can convert it into a bitstream for another region at runtime. 
It does this by manupilating clock information in the bitstream. 
The compilation flow takes care that wires except the AXI interface do not cross the PR region boundary.

The following function is used by the daemons and libs and can be used by the user to relocate bitstream:

```C
int relocate_bitstream_file(const char *infilename, const char *outfilename, int new_location)
```
