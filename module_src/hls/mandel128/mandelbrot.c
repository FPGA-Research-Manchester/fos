
#include "mandelbrot.h"

//// multiply fixed point integers
//fixed_point_t multFixed(fixed_point_t a, fixed_point_t b)
//{
//#pragma HLS INLINE
////#pragma HLS ALLOCATION instances=Mul_LUT core
//return ((a * b) >> NORM_BITS);
//}

void mandelbrot128(unsigned int ImageWidth, unsigned int ImageHeight,
    unsigned int MaxIterations, fixed_point_t cRe, fixed_point_t cIm,
    fixed_point_t zoom, bus128bit displayPtr[MaxImageWidth * MaxImageHeight])
{

//#pragma HLS DATAFLOW
#pragma HLS EXPRESSION_BALANCE

#pragma HLS INTERFACE m_axi port=displayPtr offset=slave bundle=gmem

#pragma HLS INTERFACE s_axilite port=ImageWidth bundle=control
#pragma HLS INTERFACE s_axilite port=ImageHeight bundle=control
#pragma HLS INTERFACE s_axilite port=displayPtr bundle=control
#pragma HLS INTERFACE s_axilite port=MaxIterations bundle=control
#pragma HLS INTERFACE s_axilite port=cRe bundle=control
#pragma HLS INTERFACE s_axilite port=cIm bundle=control
#pragma HLS INTERFACE s_axilite port=zoom bundle=control

#pragma HLS INTERFACE s_axilite port=return bundle=control

  char *display = (char*) displayPtr;

  fixed_point_t Re_factor = zoom;
  fixed_point_t Im_factor = zoom;
  
  fixed_point_t MinRe = cRe - multFixed(Re_factor, floatToFixed(ImageWidth/2));
  fixed_point_t MinIm = cIm - multFixed(Im_factor, floatToFixed(ImageHeight/2));

  fixed_point_t MaxRe = MinRe + multFixed(Re_factor, floatToFixed(ImageWidth));
  fixed_point_t MaxIm = MinIm + multFixed(Im_factor, floatToFixed(ImageHeight));
  
  unsigned int x, y;
  mandelbrot_ydim:for(y = 0; y < ImageHeight; y++)
  {
//#pragma HLS UNROLL factor=10
	  fixed_point_t c_im = MaxIm - multFixed(floatToFixed(y), Im_factor);

    mandelbrot_xdim:for(x = 0; x < ImageWidth; x++)
    {
#pragma HLS UNROLL factor=0
      fixed_point_t c_re = MinRe + multFixed(floatToFixed(x), Re_factor);

      // Calculate whether c belongs to the Mandelbrot set or
      // not and draw a pixel at coordinates (x,y) accordingly
      fixed_point_t Z_re = c_re, Z_im = c_im; // Set Z = c
      unsigned int n = 0;
      
      display[x + y * ImageWidth] = (char)-1;
      mandelbrot_core:for(n = 0; n < MaxIterations; n++)
      {
//#pragma HLS ALLOCATION instances=50 function
//#pragma HLS UNROLL
//#pragma HLS PIPELINE
        fixed_point_t Z_im2 = multFixed(Z_im, Z_im);
        fixed_point_t Z_re2 = multFixed(Z_re, Z_re);
        
        if(Z_re2 + Z_im2 > fixedPointFour) // |z| > 2
        {
          display[x + y * ImageWidth] = (char) n;
          break;
        }
        // Z^2 = (a + bi)^2 = (a^2 - b^2) + (2ab)i
        Z_im = multFixed(floatToFixed(2), multFixed(Z_re, Z_im)) + c_im;
        Z_re = Z_re2 - Z_im2 + c_re;
      }
    } // for
  } // for

} // mandelbrot()
