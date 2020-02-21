#include <stdio.h>
#include <stdlib.h>

// Fixed-point Format: 4.29 (32-bit)
typedef long fixed_point_t;

#define NORM_BITS 29
#define NORM_FACT ((fixed_point_t)1 << NORM_BITS)
// Converts 4.29 to double format
#define fixedToFloat(input) ((input + ((fixed_point_t)1 << NORM_BITS-1)) \
                              >> NORM_BITS)
// Converts double to 4.29 format
#define floatToFixed(input) (fixed_point_t)(input * (NORM_FACT))
//// multiply fixed point integers
#define multFixed(a,b) ((a * b) >> NORM_BITS)

#define fixedPointFour floatToFixed(4)

#define MaxImageWidth 1000
#define MaxImageHeight 1000
