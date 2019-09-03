#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>

#include "bit_patch.h"

int main(int argc, char **argv)
{
    if (argc != 4) {
        printf("ERROR!!! Not enough arguments\n");
        printf("Usage: ./bit_patch input output location\n");
        return -1;
    }

    int new_location;
    sscanf(argv[3], "%d", &new_location);


    printf("Opening input file %s and output file %s\n", argv[1], argv[2]);
    printf("Relocate to %d\n", new_location);

    FILE *in_pt0 = fopen(argv[1],"rb");
    if (in_pt0 == NULL)
    {
      printf("Failed to read input file %s\n", argv[1]);
      return -1;
    }

    FILE *in_pt1 = fopen(argv[2],"wb+");
    if (in_pt1 == NULL)
    {
        fclose(in_pt0);
        printf("Failed to open output file %s\n", argv[2]);
        return -1;
    }

    relocate_bitstream(in_pt0, in_pt1, new_location);

    fclose(in_pt0);
    fclose(in_pt1);
    return 0;
}
