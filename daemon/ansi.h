#pragma once

#include <string>

#define getChar(x, n) (char)(x >> (8*n))
#define setChar(x, n, v) (x | (int)(v) >> (8*n))

int simple_pallete[] = {
  0x00dfff, 0x1fff00, 0xfff400, 0xffab00, 0xff0000, 0xff00d8, 0x8000ff, 0x0000ff
};
int simple_pallete_size = sizeof(simple_pallete) / sizeof(simple_pallete[0]);

std::string ansi24colour(char red, char green, char blue) {
  std::string escapecode = "\033[38;2;";
  escapecode += std::to_string(red) + ";";
  escapecode += std::to_string(green) + ";";
  escapecode += std::to_string(blue) + "m";
  return escapecode;
}

std::string ansi8colour(int colour) {
  if (colour < 0)
    return "\033[0m";
  std::string escapecode = "\033[38;5;" + std::to_string(colour) + "m";
  return escapecode;
}

std::string ansi4colour(int colour) {
  if (colour < 0)
    return "\033[0m";
  if (colour < 8)
    colour += 30;
  else
    colour += (90 - 8);
  std::string escapecode = "\033[" + std::to_string(colour) + "m";
  return escapecode;
}


// shade must be between 0 and 15
int calcshade(int colour, int ishade) {
  if (ishade > 15) ishade = 15;
  float shade = (5.f + (float)ishade) / 20.f;
  //std::cout << "Shade is " << shade << std::endl;
  char red   = (char)(colour >> 16) * shade;
  char green = (char)(colour >> 8) * shade;
  char blue  = (char)(colour) * shade;
  return red << 16 | green << 8 | blue;
}
