#include <clc.h>



__kernel void __attribute__((reqd_work_group_size(16, 1, 1)))
//__kernel void
vadd(
		__global int *ina,
		__global int *inb,
		__global int *out) {
	int i = get_global_id(0);
	out[i] = ina[i] + inb[i];
}
