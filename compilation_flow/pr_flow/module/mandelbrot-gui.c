/*
* Copyright (C) 2013 - 2016  Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or (b) that interact
* with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in this
* Software without prior written authorization from Xilinx.
*
*/

#include "mandelbrot-gui.h"

/*#define DEBUG 1*/

// image size
/*#define ImageWidth 500*/
/*#define ImageHeight 500*/

/*
  four core memory pointer and locations: accelerator and pinned memory
*/
volatile int* data_mem;
/*volatile int* mem;*/
off_t phy_data_mem;
/*off_t offset;*/

off_t accel0_phy = (volatile char*)0x0080000000;
off_t accel1_phy = (volatile char*)0x00B0000000;
off_t accel2_phy = (volatile char*)0x00A0000000;

volatile char *accel0;
volatile char *accel1;
volatile char *accel2;

int num_accels;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// GUI logic
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
int buildColor(int red, int green, int blue)
{  
 return(
        (((int)(red)%256)<<16)+
        (((int)(green)%256)<<8)+
        (((int)(blue)%256)));
} 

Display* createDisplay()
{
  //Open Display
  dis = XOpenDisplay(getenv("DISPLAY"));
  if (dis == NULL) {
    perror("Couldn't open display.\n");
    exit(-1);
  }
  return dis;
}

void setWindowCharateristics(int screen, Window ro)
{
  unsigned long black, white;
  
  XMapWindow(dis, win); //Make window visible
  XStoreName(dis, win, "Mandelbrot"); // Set window title
  
  black = BlackPixel(dis, screen),  /* get color black */
  white = WhitePixel(dis, screen);  /* get color white */
  
  /* this routine determines which types of input are allowed in
     the input.  see the appropriate section for details...
  */
  XSelectInput(dis, win, ExposureMask|ButtonPressMask|KeyPressMask);
  
  /* create the Graphics Context */
  gc = XCreateGC(dis, ro, 0, NULL);
  
  /* here is another routine to set the foreground and background
     colors _currently_ in use in the window.
  */
  XSetBackground(dis, gc, white);
/*  XSetForeground(dis, gc, black);*/
  XSetForeground(dis, gc, buildColor(255, 0, 0));
  
  /* clear the window and bring it on top of the other windows */
  XClearWindow(dis, win);
  XMapRaised(dis, win);
}

int createWindow(int width, int height)
{
  unsigned long black, white;
  
  createDisplay();

  //Create Window
  int const x = 0, y = 0, border_width = 1;
  int screen    = DefaultScreen(dis);
  Window ro     = DefaultRootWindow(dis);
  black = BlackPixel(dis,screen),  /* get color black */
  white = WhitePixel(dis, screen);  /* get color white */
  
  win = XCreateSimpleWindow(dis, ro, x, y, width, height, border_width, 
                              black, white);
                              
  setWindowCharateristics(screen, ro);
  return 0;
}

int createMaxWindow()
{
  unsigned long black, white;
  
  createDisplay();

  //Create Window
  int screen    = DefaultScreen(dis);
  int width = XDisplayWidth(dis, screen);
  int height = XDisplayHeight(dis, screen);
/*  int width = height;*/
  
  // making an image square as we need to move the center point 
  // if width is different
  int drawing_size = (width > height)? height : width;
  ImageWidth = drawing_size;
  ImageHeight = drawing_size;
  
  createWindow(width, height);
  return 0;
}

void drawPixel(int x, int y, int color)
{
	XSetForeground(dis, gc, color);
	XDrawPoint(dis, win, gc, x, y);
}

void closeDisplay()
{
  XFreeGC(dis, gc);
	XDestroyWindow(dis, win);
	XCloseDisplay(dis);
	exit(1);
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// software implementation logic
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
int mandelbrot_sw(uint32_t MaxIterations, double cRe, double cIm, uint32_t zoom)
{

  double Re_factor = 0.01 / zoom;
  double Im_factor = 0.01 / zoom;
  
  double MinRe = cRe - Re_factor*(ImageWidth/2);
  double MinIm = cIm - Im_factor*(ImageHeight/2);

  double MaxRe = MinRe + Re_factor*ImageWidth;
  double MaxIm = MinIm + Im_factor*ImageHeight;

  char* display = (char*) data_mem;
  
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Hardware accelerator logic
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
void programAccel(volatile int* mem, char* display_phy,
                  unsigned int MaxIterations,
                  fixed_point_t cRe, fixed_point_t cIm,
                  fixed_point_t zoom_ratio,
					        unsigned int calWidth, unsigned int calHeight)
{
  volatile char *control            = (volatile char*)mem;
  volatile int *ImageWidth_addr     = (volatile int*)(mem + 4);
  volatile int *ImageHeight_addr    = (volatile int*)(mem + 6);
  volatile int *MaxIterations_addr  = (volatile int*)(mem + 8);
  volatile int *cRe_addr            = (volatile int*)(mem + 10);
  volatile int *cRe_addr_upper      = (volatile int*)(mem + 11);
  volatile int *cIm_addr            = (volatile int*)(mem + 13);
  volatile int *cIm_addr_upper      = (volatile int*)(mem + 14);
  volatile int *zoom_addr           = (volatile int*)(mem + 16);
  volatile int *display_addr        = (volatile int*)(mem + 19);
  
  #ifdef DEBUG
    printf("ImageWidth_addr: \t\t %15x \n", ImageWidth_addr);
    printf("ImageHeight_addr: \t\t %15x \n", ImageHeight_addr);
    printf("MaxIterations_addr: \t\t %15x \n", MaxIterations_addr);
    printf("cRe_addr: \t\t %15x \n", cRe_addr);
    printf("cRe_addr_upper: \t\t %15x \n", cRe_addr_upper);
    printf("cIm_addr: \t\t %15x \n", cIm_addr);
    printf("cIm_addr_upper: \t\t %15x \n", cIm_addr_upper);
    printf("zoom_addr: \t\t %15x \n", zoom_addr);
    printf("display_addr: \t\t %15x \n", display_addr);
  #endif     
    
  *ImageWidth_addr = (unsigned int) calWidth;
  *ImageHeight_addr = (unsigned int) calHeight;
  *MaxIterations_addr = (unsigned int) MaxIterations;

	*((volatile int*)cRe_addr) 				   = (unsigned int)(((unsigned long)cRe << 32) >> 32);
	*((volatile int*)(cRe_addr + 1)) 		 = (unsigned int)(((unsigned long)cRe >> 32));
	*((volatile int*)cIm_addr) 				   = (unsigned int)(((unsigned long)cIm << 32) >> 32);
	*((volatile int*)(cIm_addr + 1)) 		 = (unsigned int)(((unsigned long)cIm >> 32));

	*((volatile int*)zoom_addr) 				 = (unsigned int)(((unsigned long)zoom_ratio << 32) >> 32);
	*((volatile int*)(zoom_addr + 1)) 	 = (unsigned int)(((unsigned long)zoom_ratio >> 32));
  *(display_addr)      			           = (unsigned int)display_phy;
  *((volatile int*)(display_addr + 1)) = 0;

  *control = *control | 1; /* start */
  
  #ifdef DEBUG
    printf("ImageWidth_addr: \t\t %15x \n", *ImageWidth_addr);
    printf("ImageHeight_addr: \t\t %15x \n", *ImageHeight_addr);
    printf("*MaxIterations_addr: \t\t %15x \n", *MaxIterations_addr);
    printf("*cRe_addr: \t\t %15x \n", *cRe_addr);
    printf("*cRe_addr_upper: \t\t %15x \n", *cRe_addr_upper);
    printf("*cIm_addr: \t\t %15x \n", *cIm_addr);
    printf("*cIm_addr_upper: \t\t %15x \n", *cIm_addr_upper);
    printf("*zoom_addr: \t\t %15x \n", *zoom_addr);
    printf("*zoom_addr_upper: \t\t %15x \n", *(zoom_addr+1));
    printf("*display_addr: \t\t %15x \n", *display_addr);
    printf("*display_addr_upper: \t\t %15x \n", *(display_addr+1));
  #endif
    
  #ifdef DEBUG
    printf("display_phy: %15x, MaxIterations_val_phy: %15x \n", display_phy,
           *MaxIterations_addr);
  
    printf("Status of control register: \n\r");
    // print status register bits
	  unsigned int con = *control;
	  for (i = 0; i < 8; i ++) {
	    if (con & (1 << i) ) {
		    printf("1");
	    } else {
		    printf("0");
	    }
    }
    printf("\n\r");
    
    printf("Starting HW kernel execution\n\r");
	#endif
	*control = *control | 1; /* start */

  #ifdef DEBUG
    printf("Completed programming kernel\n");
  #endif
} // programAccel

double calImShift(double cIm, int accel, int zoom)
{
	double shift = 0;
	if(num_accels % 2 != 0)
	{
		if(accel > (num_accels/2))
		{
			shift = - ((double)0.01 / zoom) * (accel - num_accels/2)*(ImageHeight/num_accels);
		}
		else if (accel < (num_accels/2))
		{
			shift = + ((double)0.01 / zoom) * (num_accels/2 - accel)*(ImageHeight/num_accels);
		}
	}
	else
	{
		if(accel >= (num_accels/2))
		{
			shift = - ((double)0.01 / zoom) * (accel + 0.5 - num_accels/2)*(ImageHeight/num_accels);
		}
		else // if (accel < (num_accels/2))
		{
			shift = + ((double)0.01 / zoom) * (num_accels/2 - accel - 0.5)*(ImageHeight/num_accels);
		}
		
	}
	return cIm + shift;
}

void programMandelbrot(unsigned int MaxIterations,
                       double cRe, double cIm,
					             unsigned int zoom)
{
	fixed_point_t zoom_ratio = floatToFixed((double)0.01 / zoom);

	volatile char* accelerators[3] = {accel0, accel1, accel2};
  volatile char* display_phy = (volatile char*)phy_data_mem;

	int i;
	for(i = 0; i < num_accels; i++)
	{
		volatile char* accel = accelerators[i];
		double cIm_shifted = calImShift(cIm, i, zoom);

		programAccel(accel, (display_phy + (ImageWidth*(ImageHeight/num_accels))*i),
					 MaxIterations, floatToFixed(cRe), floatToFixed(cIm_shifted), zoom_ratio,
					 ImageWidth, ImageHeight/num_accels);
	}

	/* waiting for hardware to report "done" */
	for(i = 0; i < num_accels; i++)
	{
		volatile char* accel = accelerators[i];
		while (! ((*accel) & 2));
	}
}

int setupHardware()
{
  //---------------------------------------------------------
  //   Pin Accelerators
  //---------------------------------------------------------
  // Truncate offset to a multiple of the page size, or mmap will fail.
  size_t pagesize = sysconf(_SC_PAGE_SIZE);
  #ifdef DEBUG
    printf("accel address: %15x with page size %d: \n", offset, pagesize);
  #endif
  fd = open("/dev/mem", O_RDWR | O_SYNC);
  if (fd < 1) {
		perror("Cannot open /dev/mem");
		return -1;
	}
	
/*  mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, */
/*                  MAP_SHARED, fd, offset);*/
/*  if (mem == MAP_FAILED) */
/*  {*/
/*    perror("Can't map memory");*/
/*    return -1;*/
/*  }*/
  
  accel0 = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, 
                  MAP_SHARED, fd, accel0_phy);
  if (accel0 == MAP_FAILED) 
  {
    perror("Can't map memory");
    return -1;
  }
  
  accel1 = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, 
                  MAP_SHARED, fd, accel1_phy);
  if (accel1 == MAP_FAILED) 
  {
    perror("Can't map memory");
    return -1;
  }
  
  accel2 = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, 
                  MAP_SHARED, fd, accel2_phy);
  if (accel2 == MAP_FAILED) 
  {
    perror("Can't map memory");
    return -1;
  }
  
  //---------------------------------------------------------
  // Pin data buffer
  //---------------------------------------------------------
  int udma = open("/dev/udmabuf0", O_RDWR | O_SYNC);
  if (udma < 1) {
		perror("Cannot open /dev/udmabuf0");
		return -1;
	}
	
	int buf_size_fd;
	unsigned char  attr[1024];
	unsigned int   buf_size;
  if ((buf_size_fd  = open("/sys/class/udmabuf/udmabuf0/size", O_RDONLY)) != -1) 
  {
      read(buf_size_fd, attr, 1024);
      sscanf(attr, "%d", &buf_size);
      close(buf_size_fd);
  }
	
  // Determine how far to seek into memory to find the buffer
  int phy_add_fd;
  if ((phy_add_fd  = open("/sys/class/udmabuf/udmabuf0/phys_addr", O_RDONLY)) != -1) 
  {
      read(phy_add_fd, attr, 1024);
      sscanf(attr, "%x", &phy_data_mem);
      close(phy_add_fd);
  }
	
  data_mem = mmap(NULL, buf_size, PROT_READ | PROT_WRITE, 
                       MAP_SHARED, udma, 0);
  
  if (data_mem == MAP_FAILED)
  {
    perror("Can't map data_memory");
    return -1;
  }
  #ifdef DEBUG 
    printf("Begin programmig the mandelbrot kernel with location: %15x \n", mem);
    printf("data location: %15x \n", data_mem);
  #endif
}

void closeHardware()
{
  size_t pagesize = sysconf(_SC_PAGE_SIZE);
  if (munmap(data_mem, pagesize) == -1
      //|| munmap(mem, pagesize) == -1
      || munmap(accel0, pagesize) == -1
      || munmap(accel1, pagesize) == -1
      || munmap(accel2, pagesize) == -1)
  {
    close(fd);
    perror("Error un-mmapping the file");
    exit(EXIT_FAILURE);
  }
  
  // Un-mmaping doesn't close the file, so we still need to do that.
  close(fd);
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Application
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
double mandelbrot(uint32_t MaxIterations, double cRe, double cIm,  
                  uint32_t zoom, bool hw_mode)
{
  clock_t start, end;
  double cpu_time_used;
  
  
  
  start = clock();
  //---------------------------------------------------------
  if(!hw_mode) // Software mode
  {
    mandelbrot_sw(MaxIterations, cRe, cIm, zoom);
  }
  else
  {
    programMandelbrot(MaxIterations, cRe, cIm, zoom);
  }
  //---------------------------------------------------------
  end = clock();
  
  cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;  // seconds
  #ifdef DEBUG
    printf("Took %lf seconds in hw_mode: %s\n", 
           cpu_time_used, hw_mode? "true" : "false");
  #endif
  
  uint32_t colour_unit = (uint32_t)((1 << 24) / (MaxIterations));
  char* display = (char*) data_mem;
  for(int i = 0; i < ImageHeight; i++)
  {
  	for(int j = 0; j < ImageWidth; j++)
  	{
	    char iteration_count = display[j + i*ImageWidth];
		  if(iteration_count == ((char) -1))
			  drawPixel(j, i, buildColor(0, 0, 0));
		  else
			  drawPixel(j, i, colour_unit * ((int)iteration_count));
    }
  }
  
  return cpu_time_used;
  
} // mandelbrot()

void shiftLeft (char *string, int size, int shiftLength, char newChar)
{

  int i;
  if(shiftLength >= size)
  {
    memset(string, ' ', size);
    return;
  }

  for (i=0; i < size-shiftLength; i++)
  {
    string[i] = string[i + shiftLength];
    string[i + shiftLength] = newChar;
  }
}

int main(int argc, char *argv[]) 
{  
  if (argc < 4) 
  {
    printf("Usage: %s <width> <height> <iterations>\n", argv[0]);
    return 0;
  }

  ImageWidth = strtoul(argv[1], NULL, 0);
  ImageHeight = strtoul(argv[2], NULL, 0);
  unsigned int MaxIterations = strtoul(argv[3], NULL, 0);
  
  setupHardware();
  
  int zoom = 1;
  // recursive coordinates
  //double cRe = -1.25;
  //double cIm = -0.18;
  // valley coordinates
  double cRe = -0.76;
  double cIm = -0.101;
  
  int text_height = 15;
  unsigned int string_height = 10;
  int trace_height = string_height*5;
  
  if(createWindow(ImageWidth, ImageHeight + text_height) != -1)
  {
    #ifdef DEBUG
      printf("created window\n");
    #endif
    XEvent event;		/* the XEvent declaration !!! */
	  KeySym key;		/* a dealie-bob to handle KeyPress Events */	
	  char text[255];		/* a char buffer for KeyPress Events */
    
    bool quit = false;
    bool zoom_on = false;
    bool hw_mode = false;
    num_accels = 1;
    
    unsigned int string_size = 80;
    
    char* cpu_use = malloc (string_size * sizeof(char));
    char* f1_use = malloc (string_size * sizeof(char));
    char* f2_use = malloc (string_size * sizeof(char));
    char* f3_use = malloc (string_size * sizeof(char));
    
    char* trace_cpu = malloc ((string_size - 6) * sizeof(char));
    memset(trace_cpu, ' ', string_size - 6);
    
    char* trace_f1 = malloc ((string_size - 6) * sizeof(char));
    memset(trace_f1, ' ', string_size - 6);
    char* trace_f2 = malloc ((string_size - 6) * sizeof(char));
    memset(trace_f2, ' ', string_size - 6);
    char* trace_f3 = malloc ((string_size - 6) * sizeof(char));
    memset(trace_f3, ' ', string_size - 6);
    
    double step_size = ((double)0.01 / ((ImageHeight/500.0)*zoom));
    unsigned int shift_pixels = (0.1 / step_size);
    
    while (!quit) 
    {
      step_size = ((double)0.01 / ((ImageHeight/500.0)*zoom));
      
      if(XCheckWindowEvent(dis, win, KeyPressMask, &event))
      {
        if(event.type == KeyPress
		       && XLookupString(&event.xkey, text, 255, &key, 0) == 1) 
        {
		      /* use the XLookupString routine to convert the invent
		         KeyPress data into regular text.  Weird but necessary...
		      */
			    if (text[0]=='q') 
				    quit = true;
				    
				  switch(text[0])
				  {
				    // quit
				    case 'q': 
				      quit = true;
				      break;
				    // toggle zoom
				    case 'x': 
				      zoom_on = !zoom_on;
				      break;
				    case 'z': 
				      zoom++;
				      break;
				    // reset
				    case 'r': 
				      zoom = 1;
				      zoom_on = false;
				      hw_mode = false;
				      
				      //cRe = -1.25;
              // cIm = -0.18;
              cRe = -0.76;
              cIm = -0.101;
              num_accels = 1;
				      break;
				    // Compute in software or hardware
				    case ' ': 
		          hw_mode = !hw_mode;
				      break;
				    case '1':
				      num_accels = 1;
				      break;
			      case '2':
			        num_accels = 2;
			        break;
				    case '3':
				      num_accels = 3;
				      break;
				    // Move left, right, up and down  
            case 'a':
              cRe -= shift_pixels * step_size;
              break;
            case 'd':
              cRe += shift_pixels * step_size;
              break;
            case 'w':
              cIm += shift_pixels * step_size;
              break;
            case 's': 
              cIm -= shift_pixels * step_size;
              break;
				      
				    default:
				      break;
				  } // switch
		    } // if key press
      } // if
			
			// continue drawing otherwise
		  double cpu_time_used = mandelbrot(MaxIterations, cRe, cIm, zoom, hw_mode);
		                                    
		  // clear old string
      for(int i = ImageHeight; i < ImageHeight + text_height; i++)
      	for(int j = 0; j < ImageWidth; j++)
			      drawPixel(j, i, buildColor(0, 0, 255));
      
      char* status = (char*)malloc(100 * sizeof(char));
      sprintf(status, "In %s; time: %2.4f Zoom: %d;  cRe: %f; cIm: %f", 
              (hw_mode)? "Hardware" : "Software",
              cpu_time_used,
              zoom, cRe, cIm);
      
      XSetForeground(dis, gc, buildColor(0, 255, 0));
      
      XDrawString(dis, win, gc, 0, ImageHeight + text_height - 2, 
                  status, strlen(status));
		  
      // draw trace
      for(int i = ImageHeight + text_height + trace_height - string_height*5; 
          i < ImageHeight + text_height + trace_height; i++)
      	for(int j = 0; j < ImageWidth; j++)
			      drawPixel(j, i, buildColor(0, 0, 255));
      
      XSetForeground(dis, gc, buildColor(0, 255, 0));
      
      if(hw_mode)
      {
        shiftLeft(trace_f1, string_size-6, 1, '#');
        shiftLeft(trace_cpu, string_size-6, 1, ' ');
        if(num_accels >= 2)
          shiftLeft(trace_f2, string_size-6, 1, '#');
        else
          shiftLeft(trace_f2, string_size-6, 1, ' ');
        if(num_accels >= 3)
          shiftLeft(trace_f3, string_size-6, 1, '#');
        else
          shiftLeft(trace_f3, string_size-6, 1, ' ');
      }
      else
      {
        shiftLeft(trace_cpu, string_size-6, 1, '#');
        shiftLeft(trace_f1, string_size-6, 1, ' ');
        shiftLeft(trace_f2, string_size-6, 1, ' ');
        shiftLeft(trace_f3, string_size-6, 1, ' ');
      }
      
      sprintf(cpu_use, "CPU:  %s", trace_cpu);
      sprintf(f1_use, " F1:  %s", trace_f1);
      sprintf(f2_use, " F2:  %s", trace_f2);
      sprintf(f3_use, " F3:  %s", trace_f3);
      
      XDrawString(dis, win, gc, 0, 
                  ImageHeight + text_height + trace_height - string_height*4 + 2, 
                  cpu_use, string_size);
                  
      XDrawString(dis, win, gc, 0, 
                  ImageHeight + text_height + trace_height - string_height*3 + 2, 
                  f1_use, string_size);
      XDrawString(dis, win, gc, 0, 
                  ImageHeight + text_height + trace_height - string_height*2 + 2, 
                  f2_use, string_size);
      XDrawString(dis, win, gc, 0, 
                  ImageHeight + text_height + trace_height - string_height + 2, 
                  f3_use, string_size);      
      		  
		  // change zoom
		  if(zoom_on)
		    zoom++;
		  
		  if(zoom >= 150) // reset zoom after a point for continous demo
		    zoom = 1;
		  
	  } // while
	  
    closeDisplay();
    closeHardware();
  } // if
  else
  {
    perror("Could not create window. Exiting...");
    exit(-1);
  } // else
} // main()
