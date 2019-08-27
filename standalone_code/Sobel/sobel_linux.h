
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
