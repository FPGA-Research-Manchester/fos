#pragma once

#include <cstdint>
#include <map>
#include <string>
#include <complex>

void softMandelbrot(int width, int height, double cre, double cim, double zoom, int iters, char *dst) {
  // cim = -cim;
  double zre = cre - width*zoom*0.5;
  double zim = cim - height*zoom*0.5;
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      std::complex<double> coord(zre + w*zoom, zim + h*zoom);
      std::complex<double> accum (0, 0);
      int iter = 0;
      while (std::sqrt(std::norm(accum)) < 2 && iter < iters) {
        accum = accum*accum + coord;
        iter++;
      }
      dst[h*width+w] = iter - 1;
    }
  }
}

void softMandelbrot2(int width, int height, double cre, double cim, double zoomd, int iters, char *dst)
{
  int ImageWidth = width;
  int ImageHeight = height;

  uint32_t MaxIterations = iters;
  double cRe = cre;
  double cIm = cim;
  // uint32_t zoom = zoomd;

  // double Re_factor = 0.01 / zoom;
  // double Im_factor = 0.01 / zoom;

  double Re_factor = zoomd;
  double Im_factor = zoomd;

  double MinRe = cRe - Re_factor*(ImageWidth/2);
  double MinIm = cIm - Im_factor*(ImageHeight/2);

  double MaxRe = MinRe + Re_factor*ImageWidth;
  double MaxIm = MinIm + Im_factor*ImageHeight;

  char* display = (char*) dst;

  for(unsigned y = 0; y < ImageHeight; y++)
  {
    double c_im = MaxIm - y*Im_factor;
    for(unsigned x = 0; x < ImageWidth; x++)
    {
      double c_re = MinRe + x*Re_factor;

      // Calculate whether c belongs to the Mandelbrot set or
      // not and draw a pixel at coordinates (x,y) accordingly
      double Z_re = c_re, Z_im = c_im; // Set Z = c
      bool isInside = true;
      unsigned n = 0;

      display[x + y * ImageWidth] = (char)-1;
      for(n = 0; n < MaxIterations; n++)
      {
        double Z_im2 = Z_im*Z_im;
        double Z_re2 = Z_re*Z_re;

        if(Z_re2 + Z_im2 > 4) // |z| > 2
        {
          isInside = false;
          display[x + y * ImageWidth] = (char) n;
          break;
        }
        /*
          N.B. Z^2 = (a + bi)^2 = (a^2 - b^2) + (2ab)i
        */
        Z_im = 2*Z_re*Z_im + c_im;
        Z_re = Z_re2 - Z_im2 + c_re;
      } // for
    } // for
  } // for
} // mandelbrot()

// mandelbrot unit functions
int fixpbits = 29;
double fixpfactor = 1 << fixpbits;
uint64_t int32bits = ((uint64_t)1 << 32) - 1;
uint32_t top32(uint64_t a) {
  return (a >> 32) & int32bits;
}
uint32_t bot32(uint64_t a) {
  return a & int32bits;
}
uint64_t float2fix(double a) {
  return (uint64_t)(int64_t) (a * fixpfactor);
}

void initParams(int width, int height, double cre, double cim, double zoom, int iters, int buffer, std::map<std::string, uint32_t> &params) {
  params["imageWidth"]     = width;
  params["imageHeight"]    = height;
  params["maxIterations"]  = iters;
  params["centreRealLow"]  = bot32(float2fix(cre));
  params["centreRealHi"]   = top32(float2fix(cre));
  params["centreImagLow"]  = bot32(float2fix(cim));
  params["centreImagHi"]   = top32(float2fix(cim));
  params["zoomLow"]        = bot32(float2fix(zoom));
  params["zoomHi"]         = top32(float2fix(zoom));
  params["framebufferLow"] = bot32(buffer);
  params["framebufferHi"]  = top32(buffer);
}

void multParams(int width, int height, double cre, double cim, double zoom, int iters, int buffer, std::map<std::string, uint32_t> &params, int unit, int units) {
  int nheight = height / units;
  double zim = cim - height*0.5*zoom;
  double ncim = zim + nheight*(units-unit-0.5)*zoom;
  int nbuffer = buffer + nheight*width*unit;

  params["imageHeight"]    = nheight;
  params["centreImagLow"]  = bot32(float2fix(ncim));
  params["centreImagHi"]   = top32(float2fix(ncim));
  params["framebufferLow"] = bot32(nbuffer);
  params["framebufferHi"]  = top32(nbuffer);
}

/* void jej() {

  double cre = -0.36, cim = 0.641, zoom = 0.01;
  int udma_addy = 0x79100000;

  std::map<std::string, uint32_t> periph_params0;
  std::map<std::string, uint32_t> periph_params1;
  std::map<std::string, uint32_t> periph_params2;
  // initParams(640, 480, cre, cim, zoom, 255, udma_addy, periph_params0);
  // initParams(640, 480, cre, cim, zoom, 255, udma_addy, periph_params1);
  // initParams(640, 480, cre, cim, zoom, 255, udma_addy, periph_params2);

  while (1) {
    zoom *= 0.95;
    if (zoom < 1.0e-8)
      zoom = 0.01;
    std::cout << "zoom: " << zoom << std::endl;
    multParams(640, 480, cre, cim, zoom, 255, udma_addy, periph_params0, 0, 3);
    multParams(640, 480, cre, cim, zoom, 255, udma_addy, periph_params1, 1, 3);
    multParams(640, 480, cre, cim, zoom, 255, udma_addy, periph_params2, 2, 3);
    periph_params0["zoomLow"]        = bot32(float2fix(zoom));
    periph_params0["zoomHi"]         = top32(float2fix(zoom));
    periph_params1["zoomLow"]        = bot32(float2fix(zoom));
    periph_params1["zoomHi"]         = top32(float2fix(zoom));
    periph_params2["zoomLow"]        = bot32(float2fix(zoom));
    periph_params2["zoomHi"]         = top32(float2fix(zoom));

  }
} */
