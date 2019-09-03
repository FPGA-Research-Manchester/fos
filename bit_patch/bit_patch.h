#pragma once

int relocate_bitstream_file(const char *infilename, const char *outfilename, int new_location);
void relocate_bitstream(FILE* input, FILE* output, int slot);
