#include "/home/kyriakos/Petalinux/pgtest/project-spec/meta-user/recipes-apps/ttbruser/files/exalloc_lib.h"


#define mem_size 1024 * 1024 * 8


int fd;

/***************************************/


int close_driver(){

	close(fd);
	return 0;		
}


/***************************************/


int change_smr_mapping(struct mem_ops_t handle){

	int fp = open("/dev/etx_device",O_RDWR);
	if (fp < 0) {
		printf ("change_smr_mapping: fopen error\n\r");
   		return -1;
  	}
	if (ioctl(fp, MEM_OPS_SET_SMR, (mem_ops_t *)&handle) == -1)
	{ 
	        perror("change_smr_mapping: query_apps ioctl set");
		return -1;
	}
	close(fp);
	return 0;
}





/***************************************/

void exa_free(struct mem_ops_t handle)
{
	unsigned int size = (unsigned int)handle.size;
	unsigned int addr = (unsigned int)handle.address;
	/* unlock the address range */
	munlock((const void*)addr, size);
 
	/* free the memory */
	free((void*)addr);
	return;
}



/***************************************/


int init_driver(mem_ops_t handle){
	fd = open("/dev/uio0", O_RDWR);
	int fp = open("/dev/etx_device",O_RDWR);
	if (fp < 0) {
		printf ("inoit_driver: fopen error\n\r");
   		return -1;
  	}	
	if (ioctl(fp, MEM_OPS_SET_TTBR, (mem_ops_t *)&handle) == -1){
		perror("exa_malloc: query_apps ioctl set");
		return -1;
	}
	if (ioctl(fp, MEM_OPS_SET_SMR, (mem_ops_t *)&handle) == -1)
	{ 
	        perror("change_smr_mapping: query_apps ioctl set");
		return -1;
	}
	close(fp);
	return 0;		
}




/***************************************/


int exa_malloc(struct mem_ops_t handle){
	if(handle.size <= 0){
	        printf("exa_malloc: malloc size should not be 0\n");
		return -1;
	}
	char * ptr = malloc(handle.size);
	printf("exa_malloc: ptr value: %x\n",ptr);
	printf("exa_malloc: handle->address value before: %d\n",handle.address);
	handle.address = (unsigned long long)ptr;
	printf("exa_malloc: handle->address value after: %d\n",handle.address);
	if (mlock(ptr, handle.size)) { //trying to lock(pin) this buffer into ram, fail otherwise
		free(ptr);
		return -1;
 	}
	int fp = open("/dev/etx_device",O_RDWR);
	if (fp < 0) {
		printf ("exa_malloc: fopen error\n\r");
   		return -1;
  	}

	if(!ptr){
	        printf("exa_malloc: MALLOC FAILED\n");
		return -1;
	}

	if (ioctl(fp, MEM_OPS_SET_OS, (mem_ops_t *)&handle) == -1){
		perror("exa_malloc: query_apps ioctl set");
		return -1;
	}

	if (ioctl(fp, MEM_OPS_CLEAR_PG, (mem_ops_t *)&handle) == -1)
  	{
	        perror("exa_malloc: query_apps ioctl set2");
		return -1;	
	}
	close(fp);
	return 0;
}


int main(){

mem_ops_t handle1;

mem_ops_t handle2;
printf("\nhandle: handles created succesfully\n\r");
handle1.smr = 0x80000200;
handle1.size = mem_size;

init_driver(handle1);

exa_malloc(handle1);

printf("\nhandle1: exa_malloc success with address value = %x\n\r",handle1.address);

handle2.smr = 0x80000200;
handle2.size = mem_size;
printf("\nhandle1: smr: %x ::: size: %x = %x\n\r",handle1.smr, handle1.size);

exa_malloc(handle2);
printf("\nhandle2: exa_malloc success with address value = %x\n\r",handle2.address);

exa_free(handle1);
exa_free(handle2);

close_driver();
return 0;




}
