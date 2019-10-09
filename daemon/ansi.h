#pragma once

#include <string>

int simple_pallete[] = {
  0x00dfff, 0x1fff00, 0xfff400, 0xffab00, 0xff0000, 0xff00d8, 0x8000ff, 0x0000ff
};

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
