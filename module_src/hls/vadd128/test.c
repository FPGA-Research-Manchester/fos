#include <stdio.h>


int main() {
	int elements = 4096;

	int ina[elements];
	int inb[elements];
	int out[elements];
    int i = 0;
	for (i = 0; i < elements; i++) {
		ina[i] = i;
		inb[i] = i;
	}

	hls_run_kernel("vadd", ina, 4096, inb, 4096, out, 4096);

	int errors = 0;
	for (i = 0; i < elements; i++) {
		printf("buf[%d] = %d\n", i, out[i]);
		if (ina[i] + inb[i] != out[i])
			errors++;
	}

	if (errors > 0)
		printf("Completed with %d errors\n", errors);
	else
		printf("Completed with no errors\n");
}
