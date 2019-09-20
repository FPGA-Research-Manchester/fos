
#include <stdio.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/ioctl.h>


typedef struct
{
    unsigned int size;
    unsigned long long address;
    unsigned int smr;
    unsigned long long new_address;
} mem_ops_t;

#define MEM_OPS_SET_TTBR _IOW('q', 'a', mem_ops_t *)
#define MEM_OPS_CLEAR_CACHE _IOW('q', 'b', mem_ops_t *)
#define MEM_OPS_CLEAR_PG _IOW('q', 'c', mem_ops_t *)
#define MEM_OPS_SET_OS _IOW('q', 'd', mem_ops_t *)
#define MEM_OPS_SET_SMR _IOW('q', 'e', mem_ops_t *)
#define MEM_OPS_SET_PTE_ADDR _IOW('q', 'f', mem_ops_t *)

#define mem_size       1024 * 1024 *  8
uint8_t *kernel_buffer;

char * alloc_workbuf(int size)
{
 char *ptr;

 /* allocate some memory */
 ptr = malloc(size);

 /* return NULL on failure */
 if (ptr == NULL)
  return NULL;

 /* lock this buffer into RAM */
 if (mlock(ptr, size)) {
  free(ptr);
  return NULL;
 }
 return ptr;
}

void free_workbuf(char *ptr, int size)
{
 /* unlock the address range */
 munlock(ptr, size);

 /* free the memory */
 free(ptr);
}

unsigned int *dmaconfig=NULL;


int main(int argc, char **argv)
{
  mem_ops_t map_ops;

  int fd = open("/dev/uio0", O_RDWR);

//int  fd = open("/dev/mem", O_RDWR | O_SYNC);
// dmaconfig = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, phy_addr);

  dmaconfig = (unsigned int *)mmap(NULL,0x100 , PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0x0000000);


  if (fd < 1) {
  	printf("Unable to open map files - maybe run as root or chmod /dev/uio0\n");
  	return 1;
  }

  //copy from temp to temp2 using the cdma
  char * temp;
  char * temp2;
  FILE * fp;
  int errno;


//allocate mem_size for temp and temp2
  if((temp = alloc_workbuf(mem_size)) < 1)
  {
    printf("error");
    return 1;
  }

  if((temp2 = alloc_workbuf(mem_size)) < 1)
  {
    printf("error");
    return 1;
  }

  //write to the file to pass temp to the driver and config the SMR and CB with user space PT



  fp = open("/dev/etx_device",O_RDWR);
  if (fp == NULL) {
    printf ("File not created okay, errno = %d\n", errno);
    return 1;
  }



  printf("\nTemp User Space Viriual address %p \n", temp);


  //reset and config the CDMA to move from temp to temp2
  dmaconfig[0] |= 4;
  while((dmaconfig[0] & ~4) == 4) printf("p");

  printf("\nsetting from lower 0x%x\n from upper 0x%x\n to lower 0x%x\n to upper 0x%x\n",(int)temp, (int)((uint64_t)temp >> 32),(int)temp2,(int)((uint64_t)temp2 >> 32));

  dmaconfig[0x18 / 4] = (int)temp;
  dmaconfig[0x1c / 4] = (int)((uint64_t)temp >> 32);
  dmaconfig[0x20 / 4] = (int)temp2;
  dmaconfig[0x24 / 4] = (int)((uint64_t)temp2 >> 32);

//  fwrite(&temp,sizeof(long long),1,fp);
map_ops.address = (unsigned long long)temp;
map_ops.size = mem_size;
map_ops.smr = 0x80000200;

    //flush_dcache_poc(address,1024 *4);


  if (ioctl(fp, MEM_OPS_SET_SMR, (mem_ops_t *)&map_ops) == -1)
 {
        perror("query_apps ioctl set");
 }



  if (ioctl(fp, MEM_OPS_SET_TTBR, (mem_ops_t *)&map_ops) == -1)
  {
    perror("query_apps ioctl set");
  }



//  if (ioctl(fp, MEM_OPS_CLEAR_CACHE, (mem_ops_t *)&map_ops) == -1)
//  {
//  	perror("query_apps ioctl set");
//  }

if (ioctl(fp, MEM_OPS_SET_OS, (mem_ops_t *)&map_ops) == -1)
{
       perror("query_apps ioctl set");
 }

  if (ioctl(fp, MEM_OPS_CLEAR_PG, (mem_ops_t *)&map_ops) == -1)
  {
        perror("query_apps ioctl set");
  }


  map_ops.address = (unsigned long long)temp2;
  map_ops.size = mem_size;

  if (ioctl(fp, MEM_OPS_SET_OS, (mem_ops_t *)&map_ops) == -1)
  {
         perror("query_apps ioctl set");
  }

    if (ioctl(fp, MEM_OPS_SET_PTE_ADDR, (mem_ops_t *)&map_ops) == -1)
    {
          perror("query_apps ioctl set");
    }


	//point temp2 pte to bram address using ioctl


char testchar = 'a';
while(1){

    int i;

    for(i = 0; i < mem_size; i++){
      temp[i] = testchar + 1;
      temp2[i] = testchar + 2;
    }
if(testchar == 'z')
	testchar = 'a';
else
	testchar++;


 // printf("\nTemp = %llx Temp2 = %llx",temp,temp2);
 // printf("\nfrom lower 0x%x\n from upper 0x%x\n to lower 0x%x\n to upper 0x%x\n",dmaconfig[0x18 / 4], dmaconfig[0x1c / 4],dmaconfig[0x20 / 4],dmaconfig[0x24 / 4] );

  //move 32 bytes
 
 
  printf("\nBefore CDMA\n");
  printf("A[0]: %c \n",temp[0]);
  printf("B[0]: %c \n\n",temp2[0]);
  printf("A[1]: %c \n",temp[16]);
  printf("B[1]: %c \n\n",temp2[16]);
  printf("A[2]: %c \n",temp[31]);
  printf("B[2]: %c \n",temp2[31]);


 printf("\nSTART DMA FROM A TO B char - %c \n",temp[i]);
  getchar();

 dmaconfig[0x28 / 4] = 32;


  printf("\n DMA COMPLETE go View trace 1\n\n Status DMA 0x%x",dmaconfig[0x04 / 4]);
  getchar();




  printf("\nAfter CDMA\n");
  printf("A[0]: %c \n",temp[0]);
  printf("B[0]: %c \n\n",temp2[0]);
  printf("A[1]: %c \n",temp[16]);
  printf("B[1]: %c \n\n",temp2[16]);
  printf("A[2]: %c \n",temp[31]);
  printf("B[2]: %c \n",temp2[31]);
	
  printf("ENDDD\n");
}
  //free memory
  free_workbuf(temp, mem_size);
  free_workbuf(temp2, mem_size);
  printf("\n\nend!\n");
close(fp);
  return 0;
}