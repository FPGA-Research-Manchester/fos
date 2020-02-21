#include <clc.h>



__kernel void __attribute__((reqd_work_group_size(4, 1, 1)))
//__kernel void
vadd128(
		__global int4 *ina,
		__global int4 *inb,
		__global int4 *out) {
	int i = get_global_id(0);
	out[i] = ina[i] + inb[i];
}
