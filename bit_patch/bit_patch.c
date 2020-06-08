#include "bit_patch.h"

#include <stddef.h>
#include <stdlib.h>

#include "clk_zu3eg_data.h"
#include "clk_zu9eg_data.h"
//#include "clk_data.c"

#define NO_WORDS_PER_FRAME 93
#define NO_WORDS_FOR_CLK 3

#define FIRST_WORD_OF_CLK ((NO_WORDS_PER_FRAME - NO_WORDS_FOR_CLK)/2 - 1)
#define LAST_WORD_OF_CLK (FIRST_WORD_OF_CLK + NO_WORDS_FOR_CLK)

#define FAR_WRITE_COMMAND 0x30002001
#define FDRI_WRITE_COMMAND 0x30004000
#define DEVICE_ID_COMMAND 0x30018001
#define FAR_RA_MASK 0xFF03FFFF
#define RA_Offset 18
#define END_FAR 0x07FC0000

enum devices{
  ZU3EG,
  ZU9EG
};

int check_FAR_write_command(int word);
int check_FDRI_write_command(int word);
int check_DeviceID_command(int word);
int getDeviceInformation(int DeviceID);

//int test[3][2] = {{0,1},{2,3},{4,5}};
int new_location;

//extern unsigned int Clk_Resources_ZU3EG[3][8049];
int check_FAR_write_command(int word)
{
    if (FAR_WRITE_COMMAND == word) {
//        printf("FAR_WRITE_COMMAND found!\n");
        return 1;
    }

    return 0;
}

int check_FDRI_write_command(int word)
{
    word = word & 0xffffc000;

    if (FDRI_WRITE_COMMAND == word) {
//        printf("FDRI_WRITE_COMMAND found!\n");
        return 1;
    }

    return 0;
}

int check_DeviceID_command(int word)
{
    if (DEVICE_ID_COMMAND == word) {
//        printf("DEVICE_ID_COMMAND found!\n");
        return 1;
    }

    return 0;
}

int getDeviceInformation(int DeviceID)
{
    switch(DeviceID)
    {
        case 0x04A42093:  return ZU3EG;
        case 0x0484A093:  return ZU9EG;
    }
}

int getSlotOffset(int device)
{
    switch(device)
    {
        case ZU3EG: return 0;
        case ZU9EG: return 3;
    }
}

void relocate_bitstream(FILE* input, FILE* output, int slot)
{
  int NextWord = 0;
  int NB = 0;
  int Is_FAR_command = 0;
  int Is_FDRI_command = 0;
  int Is_DeviceID_command = 0;
  int NW = 0;
  int NF = 0;
  int newFAR=0;
  int i, j;
  int device;
  int temp_location = slot;
  int slot_offset;

  /* Seek to the beginning of the file */
  fseek(input, 0, SEEK_SET);

  NB = fread(&NextWord, 4, 1, input);
  if (NB)
    fwrite(&NextWord, 4, 1, output);

  j = 0;
  while (NB)
  {
    Is_FAR_command = check_FAR_write_command(NextWord);

    Is_FDRI_command = check_FDRI_write_command(NextWord);
    if ((Is_FDRI_command) && (NextWord & 0x3ff))
    {
        NW = NextWord & 0x3ff;
        NF = NW/NO_WORDS_PER_FRAME;
        Is_FDRI_command = 0;
    }

    Is_DeviceID_command = check_DeviceID_command(NextWord);
    // Read the next word
    NB = fread(&NextWord, 4, 1, input);

    if (Is_DeviceID_command)
    {
        device = getDeviceInformation(NextWord);
        slot_offset = getSlotOffset(device);
        temp_location += slot_offset;
        printf("Device found %d and targeting slot %d\n", device, temp_location);
    }

    if (Is_FAR_command)
    {
      printf("FAR value 0x%08x\n", NextWord);
      slot = temp_location;
      newFAR = (NextWord & FAR_RA_MASK) | (slot << RA_Offset);
      if (END_FAR != NextWord)
      {
        printf("new FAR value 0x%08x\n", newFAR);
        NextWord = newFAR;
        temp_location++; // to relocate multiple slots
      }
    }

    if (NB)
      fwrite(&NextWord, 4, 1, output);
    if (Is_FDRI_command)
    {
      NW = NextWord & 0x00ffffff;
      NF = NW/NO_WORDS_PER_FRAME;
      Is_FDRI_command = 0;
    }

    while (NF>0)
    {
      for (i = 0; i < NO_WORDS_PER_FRAME; i++)
      {
        NB = fread(&NextWord, 4, 1, input);
        if ((FIRST_WORD_OF_CLK < i) && (LAST_WORD_OF_CLK >= i))
        {
//          printf("0x%08x, ", NextWord);
//            NextWord = Clk_Resources_ZU3EG[slot][j];
            switch(device)
            {
                case ZU3EG: NextWord = Clk_Resources_ZU3EG[slot][j];
                case ZU9EG: NextWord = Clk_Resources_ZU9EG[slot][j];
            }
            j++;
        }
        if (NB)
          fwrite(&NextWord, 4, 1, output);
      }
      NF--;
    }
  }
}

int relocate_bitstream_file(const char *infilename, const char *outfilename, int new_location) {

  FILE *infile  = fopen(infilename, "rb");
  if (infile == NULL) {
    perror("failed to open input file");
    return -1;
  }

  FILE *outfile = fopen(outfilename, "wb+");
  if (outfile == NULL) {
    perror("failed to open output file");
    return -2;
  }

  relocate_bitstream(infile, outfile, new_location);

  fclose(infile);
  fclose(outfile);
  return 0;
}
