#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <string>

#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>

#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgcodecs/imgcodecs.hpp>

#define control_reg 0x00A0000000

#define buffer_offset (16*1024*1024)

#define no_images 7

#define FILTER_WIDTH (3)
#define FILTER_HEIGHT (3)

#define B (64)
#define M(x) (((x)-1)/(B) + 1)
#define REG_WIDTH (M(FILTER_WIDTH+B-1)*B)

#define IMAGE_WIDTH 1280
#define IMAGE_HEIGHT 720

#if(B == 64)
typedef uint16_t bus_t;
#elif(B == 32)
typedef uint8 bus_t;
#elif(B == 16)
typedef uint4 bus_t;
#elif(B == 8)
typedef uint2 bus_t;
#elif(B == 4)
typedef uint bus_t;
#elif(B == 2)
typedef u16 bus_t;
#elif(B == 1)
typedef u8 bus_t;
#endif

typedef unsigned char u8;
typedef char s8;
typedef unsigned short u16;
typedef short s16;

typedef union {
    bus_t b;
    u8 a[B];
} bus_to_u8_t;

void* set_hw_registers(const char* filepath, long offset, long size);
int64_t get_buffer_size();
int64_t get_buffer_addr();
std::string type2str(int type);
void bus_to_u8(bus_t in, u8 out[B]);
bus_t u8_to_bus(u8 in[B]);
void sobel(bus_t* in_pixels, bus_t* out_pixels); 

using namespace cv;

int main(int argc, char* argv[])
{
	if (argc == 1)
	{	
		printf("Please enter HW or SW\n");
		return -1;
	}
	printf("Initialise..\n");
	
	volatile int in_pixels = 0x10;
	volatile int out_pixels = 0x18;
	
	// ==== Set up the module's registers ====
	size_t pagesize = sysconf(_SC_PAGE_SIZE);
	uint8_t* filter_reg = (uint8_t*)set_hw_registers("/dev/mem", (int64_t)control_reg, (int64_t)pagesize);
	printf("filter_reg = %lx\n", filter_reg);
	if (filter_reg== MAP_FAILED)
	{
	   perror("Memory mapping failed for image filter registers\n");
	   return -1;
	}
	
	int* filter_control; int* image_in; int* image_out;
	if (strcmp(argv[1], "HW") == 0)
	{
		filter_control = (int*)filter_reg;
		printf("filter_control=%lx\n", filter_control);
		image_in = (int*)(filter_reg + in_pixels);
		printf("image_in=%lx\n", image_in);
		image_out = (int*)(filter_reg + out_pixels);
		printf("image_out=%lx\n", image_out);
	}
	
	// ==== Set up virtual memory locations ====
	int64_t buffer_size = get_buffer_size();
	if (buffer_size == -1)
	{
		perror("Failed to get the udmabuf size\n");
		return -1;
	}
	printf("buffer_size=%ld\n", buffer_size);
	
	int64_t buffer_phys_addr = get_buffer_addr();
	if (buffer_size == -1)
	{
		perror("failed to open udmabuf addr file\n");
		return -1;
	}	
	printf("buffer_phys_addr=%lx\n", buffer_phys_addr);
	
	uint8_t* virtual_src = (uint8_t*)set_hw_registers("/dev/udmabuf0", 0, buffer_size);		
	printf("virtual_src=%lx\n", virtual_src);
	if (virtual_src == MAP_FAILED)
	{
	   perror("Memory mapping failed for input image\n");
	   return -1;
	}
	
	uint8_t* virtual_dst = (virtual_src + buffer_offset);
	printf("virtual_dst=%lx\n", virtual_dst);
	
	// ==== Create matrices to store the before and after images ====
	for (int imageNo = 0; imageNo < no_images; imageNo++)
	{
		std::string image_name = format("./images/image%d.jpg", imageNo);					//"./images/image" + (char)(imageNo + '0')  + ".jpg";
		printf("image_name=%s\n", image_name.c_str());
		
		Mat src = imread(image_name, CV_LOAD_IMAGE_GRAYSCALE);
		if (src.empty()) {
			printf("failed to read image\n");
			return -1;
		}
		Mat dst(src.rows, src.cols, src.type());
		
	//	std::string mat_type;
	//	mat_type = (src.type());
	//	printf("src mat=%s %dx%d\n", mat_type.c_str(), src.cols, src.rows);
	//
	//	mat_type = (dst.type());
	//	printf("dst mat=%s %dx%d\n", mat_type.c_str(), dst.cols, dst.rows);
	
	//  return 0;
	//	printf("virtual_src=%lx\n", virtual_src);
	
		// ==== Store the image data onto the virtual buffer space ====
		for (int y = 0; y < src.rows; y++)
		{
			int lineoff = y*src.cols;
			for (int x = 0; x < src.cols; x++)
			{
				virtual_src[lineoff+x] = src.at<char>(y,x);
			}
		}
	
		// ==== Point the HW to the image memory locations ====
		if (strcmp(argv[1], "HW") == 0)
		{
			*image_in = (buffer_phys_addr);
		//	printf("image_in=%lx\n", *image_in);
		//	printf("%lx, %lx\n", buffer_phys_addr, buffer_offset);
			*image_out = (buffer_phys_addr + buffer_offset);	
		//	printf("image_out=%lx\n", *image_out);
	
			printf("GO!\n");
			*filter_control = *filter_control | 1;
			while (!((*filter_control) & 2));
			printf("Finished\n");
		}
		else
		{
			printf("GO!\n");
			sobel((bus_t*)virtual_src, (bus_t*)virtual_dst);
			printf("Finished!\n");
		}
		 // ==== Write the converted image data into the output matrix ====	
		for (int y = 0; y < dst.rows; y++)
		{
			int lineoff = y*dst.cols;
			for (int x = 0; x < dst.cols; x++)
			{
				dst.at<char>(y,x) = virtual_dst[lineoff+x];
			}
		}

  	namedWindow("Output", WINDOW_AUTOSIZE);

		imshow("Output", dst);
		waitKey(2000);
	}//for
	return 0;
}

void* set_hw_registers(const char* filepath, long offset, long size)
{
	int fd = open(filepath , O_RDWR | O_SYNC);
	printf("mapping filepath: %s, offset: %ld, size: %ld\n", filepath, offset, size);
	if (fd < 0) {
		perror("Couldn't load file");
		exit(-1);
	}
	return mmap(NULL, size, PROT_WRITE | PROT_READ, MAP_SHARED, fd, offset);
}

int64_t get_buffer_size()
{
 	int64_t buffer_size;
	char attr[1024];
	int buffer_fd; 
	if ((buffer_fd = open("/sys/class/udmabuf/udmabuf0/size", O_RDONLY)) != -1)
	{
		read(buffer_fd, attr, 1024);
		sscanf(attr, "%ld", &buffer_size);
		close(buffer_fd);		
		return buffer_size;
	} 
	else 
	{
		return -1;
	}
}

int64_t get_buffer_addr()
{
 	int64_t buffer_phys_addr;
	char attr[1024];
	int buffer_fd; 
	if ((buffer_fd = open("/sys/class/udmabuf/udmabuf0/phys_addr", O_RDONLY)) != -1)
	{
		read(buffer_fd, attr, 1024);
		sscanf(attr, "%lx", &buffer_phys_addr);
		close(buffer_fd);		
		return buffer_phys_addr; 
	} 
	else
	{
		return -1;
	}
}

std::string type2str(int type)
{
	std::string r;
	
	uchar depth = type & CV_MAT_DEPTH_MASK;
	uchar chans = 1 + (type >> CV_CN_SHIFT);

	switch (depth)
	{
		case CV_8U: 	r = "8U"; break;
		case CV_8S: 	r = "8S"; break;
		case CV_16U: 	r = "16U"; break;
		case CV_16S: 	r = "16S"; break;
		case CV_32S: 	r = "32S"; break;
		case CV_32F: 	r = "32F"; break;
		case CV_64F:	r = "64F"; break;
		default: 			r = "User"; break;
	}

	r += "C";
	r += (chans + '0');
  return r;
} 

using namespace std;
void sobel(bus_t* in_pixels, bus_t* out_pixels) {
    /* Pad registers to align line_buf read/write */
    u8 line_reg[FILTER_HEIGHT][REG_WIDTH];
    /* Line buffers to store values */
    u8 line_buf[FILTER_HEIGHT-1][M(IMAGE_WIDTH-REG_WIDTH)*B];

#if (FILTER_HEIGHT == 3) && (FILTER_WIDTH == 3)
   	int const GX[3*3] = {
        -1, 0, 1,
        -2, 0, 2,
        -1, 0, 1
    };

    int const GY[3*3]  = {
         1, 2, 1,
         0, 0, 0,
        -1,-2,-1
    };
#endif

    // loop over height and width and compute min and max gradients
    for(size_t y=0; y < M(IMAGE_HEIGHT*IMAGE_WIDTH); y++) {
        u8 input_buf[B];

        /* Read pixels from the input image */
        bus_to_u8(in_pixels[y], input_buf);

        /* Rotate Buffers */
        for(size_t i = 0; i < FILTER_HEIGHT-1; i++) {
            /* Move the line reg B pixels at a time */
            for(size_t x = 0; x < REG_WIDTH - B; x++) {
                line_reg[i][x] = line_reg[i][x+B];
            }
            /* Add values from line_buf to end of regs */
            for(size_t j = 0; j < B; j++) {
                line_reg[i][(REG_WIDTH - B) + j] = line_buf[i][j + B*(y % (M(IMAGE_WIDTH-REG_WIDTH)))];
            }
            /* Write values from the start of the next line to the line_buf */
            for(size_t j = 0; j < B; j++) {
                line_buf[i][j + B*(y % (M(IMAGE_WIDTH-REG_WIDTH)))] = line_reg[i+1][j];
            }
        }
        /* On last line rotate regs */
        for(size_t x = 0; x < ((M(FILTER_WIDTH+B)-1)*B); x++) {
            line_reg[FILTER_HEIGHT-1][x] = line_reg[FILTER_HEIGHT-1][x+B];
        }
        /* Add the new input data to the end */
        for(size_t j = 0; j < B; j++) {
            line_reg[FILTER_HEIGHT-1][(REG_WIDTH - B) + j] = input_buf[j];
        }

        u8 resbuf[B];

        for(size_t x=0;x<B;x++){
            s16 sumx = 0;
            s16 sumy = 0;

            // Convolution of GX and GY
            for(size_t k = 0; k < FILTER_HEIGHT; k++) {
                for(size_t l = 0; l < FILTER_WIDTH; l++) {
                    const size_t offset = REG_WIDTH - FILTER_WIDTH - B + 1;
                    u8 val = line_reg[k][offset + l + x];

                    sumx  += (s16) GX[k*FILTER_WIDTH + l] * (s16) val;
                    sumy  += (s16) GY[k*FILTER_WIDTH + l] * (s16) val;
                }
            }
            
            // Absolute Value
            u16 asumx = (sumx >= 0) ? sumx : -sumx;
            u16 asumy = (sumy >= 0) ? sumy : -sumy;

            // Sum of Absolute Values
            u16 sum = asumx + asumy;

            u8 res;
            // Clamp on max
            if(sum > 0xFF) {
                res = 0xFF;
            } else {
                res = (u8) sum;
            }

            resbuf[x] = res;
        }

        out_pixels[y] = u8_to_bus(resbuf);
    }
}

void bus_to_u8(bus_t in, u8 out[B]) {
    bus_to_u8_t val;

    val.b = in;

    for(size_t i = 0; i < B; i++) {
        out[i] = val.a[i];
    }
}

bus_t u8_to_bus(u8 in[B]) {
    bus_to_u8_t val;

    for(size_t i = 0; i < B; i++) {
        val.a[i] = in[i];
    }

    return val.b;
}
