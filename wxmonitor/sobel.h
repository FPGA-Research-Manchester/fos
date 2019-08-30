#pragma once

#define FILTER_WIDTH (3)
#define FILTER_HEIGHT (3)

#define BITS (4)
#define M(x) (((x)-1)/(BITS) + 1)
#define REG_WIDTH (M(FILTER_WIDTH+BITS-1)*BITS)

#define IMAGE_WIDTH 640 
#define IMAGE_HEIGHT 480

#if(BITS == 64)
typedef uint16_t bus_t;
#elif(BITS == 32)
typedef uint8 bus_t;
#elif(BITS == 16)
typedef uint4 bus_t;
#elif(BITS == 8)
typedef uint2 bus_t;
#elif(BITS == 4)
typedef uint bus_t;
#elif(BITS == 2)
typedef u16 bus_t;
#elif(BITS == 1)
typedef u8 bus_t;
#endif

typedef unsigned char u8;
typedef char s8;
typedef unsigned short u16;
typedef short s16;

typedef union {
    bus_t b;
    u8 a[BITS];
} bus_to_u8_t;

void bus_to_u8(bus_t in, u8 out[BITS]) {
    bus_to_u8_t val;

    val.b = in;

    for(size_t i = 0; i < BITS; i++) {
        out[i] = val.a[i];
    }
}

bus_t u8_to_bus(u8 in[BITS]) {
    bus_to_u8_t val;

    for(size_t i = 0; i < BITS; i++) {
        val.a[i] = in[i];
    }

    return val.b;
}

void soft_sobel(bus_t* in_pixels, bus_t* out_pixels) {
    /* Pad registers to align line_buf read/write */
    u8 line_reg[FILTER_HEIGHT][REG_WIDTH];
    /* Line buffers to store values */
    u8 line_buf[FILTER_HEIGHT-1][M(IMAGE_WIDTH-REG_WIDTH)*BITS];

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
        u8 input_buf[BITS];

        /* Read pixels from the input image */
        bus_to_u8(in_pixels[y], input_buf);

        /* Rotate Buffers */
        for(size_t i = 0; i < FILTER_HEIGHT-1; i++) {
            /* Move the line reg B pixels at a time */
            for(size_t x = 0; x < REG_WIDTH - BITS; x++) {
                line_reg[i][x] = line_reg[i][x+BITS];
            }
            /* Add values from line_buf to end of regs */
            for(size_t j = 0; j < BITS; j++) {
                line_reg[i][(REG_WIDTH - BITS) + j] = line_buf[i][j + BITS*(y % (M(IMAGE_WIDTH-REG_WIDTH)))];
            }
            /* Write values from the start of the next line to the line_buf */
            for(size_t j = 0; j < BITS; j++) {
                line_buf[i][j + BITS*(y % (M(IMAGE_WIDTH-REG_WIDTH)))] = line_reg[i+1][j];
            }
        }
        /* On last line rotate regs */
        for(size_t x = 0; x < ((M(FILTER_WIDTH+BITS)-1)*BITS); x++) {
            line_reg[FILTER_HEIGHT-1][x] = line_reg[FILTER_HEIGHT-1][x+BITS];
        }
        /* Add the new input data to the end */
        for(size_t j = 0; j < BITS; j++) {
            line_reg[FILTER_HEIGHT-1][(REG_WIDTH - BITS) + j] = input_buf[j];
        }

        u8 resbuf[BITS];

        for(size_t x=0;x<BITS;x++){
            s16 sumx = 0;
            s16 sumy = 0;

            // Convolution of GX and GY
            for(size_t k = 0; k < FILTER_HEIGHT; k++) {
                for(size_t l = 0; l < FILTER_WIDTH; l++) {
                    const size_t offset = REG_WIDTH - FILTER_WIDTH - BITS + 1;
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

