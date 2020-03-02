#include "mandelbrot.h"

void main()
{
  printf("\n\r");
  printf("Hello World! \n\r");

  unsigned int MaxIterations = 50;
  int zoom = 1;
  fixed_point_t zoom_ratio = floatToFixed((double)0.01 / zoom);
  
  unsigned int ImageWidth = 300;
  unsigned int ImageHeight = 300;

  char display[ImageWidth * ImageHeight];
  
  fixed_point_t cRe = floatToFixed(-1.25);
  fixed_point_t cIm = floatToFixed(-0.18);

//  double cRe = -1.25;
//  double cIm = -0.18;

  int i= 0, j = 0;
  for(i = 0; i < ImageWidth; i++)
   	for(j = 0; j < ImageHeight; j++)
   		*(display + i + j*ImageWidth) = 'a';

  mandelbrot(ImageWidth, ImageHeight,
		  	 MaxIterations, cRe, cIm,
             zoom_ratio, &display);
  
//  printf("%d\n", (int)display[90200]);

  for(i = 0; i < ImageHeight; i++)
  {
    for(j = 0; j < ImageWidth; j++)
    {
    	if(display[j + i*ImageWidth] == (char)-1)
    		printf("*");
    	else
    		printf(" ");
    } // for
    printf("\n\r");
  } // for
  
} // main()
