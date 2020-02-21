typedef unsigned int u32;
typedef unsigned char u8;

typedef u32 bus_t;

// Load BGR for OpenCV
#define get_red(x)   ((x) & 0xFF)
#define get_green(x) ((x >> 8) & 0xFF)
#define get_blue(x)  ((x >> 16) & 0xFF)

#define set_red(x, val)   (x = (x & ~0x0000FF) | val)
#define set_green(x, val) (x = (x & ~0x00FF00) | val >> 8)
#define set_blue(x, val)  (x = (x & ~0xFF0000) | val >> 16)

__kernel
__attribute__((reqd_work_group_size(1,1,1)))
void shrek(global bus_t* in_pixels, global bus_t* out_pixels,
                 int image_width, int image_height)
{

  int pixelcount = image_height * image_width;
  int offset = 0;
  #pragma HLS PIPELINE
  for(int i = 0; i < pixelcount; i++, offset += 3) {

    global u32 *inpixelptr = (global u32*)((global u8*)in_pixels + offset);
	global u32 *outpixelptr = (global u32*)((global u8*)out_pixels + offset);
    u32 pixel = *inpixelptr;
    u8 red   = get_red(pixel);
    u8 green = get_green(pixel);
    u8 blue  = get_blue(pixel);

    u32 tmp_pixel_g = green + 15;
    u32 tmp_pixel_b = blue + 15;

    if(((red > 95) & (green > 40) & (blue > 20))
        & ((red > tmp_pixel_g) & (red > tmp_pixel_b) & (green > blue))
        | ((red > tmp_pixel_g) & (red > blue) & (blue > green))) {
      set_red(pixel, red/2);
      set_blue(pixel, (blue+red)/2);
      set_green(pixel, blue/2);
    }
    *outpixelptr = pixel;
  }
}
