/**
* @file exalloc_lib.h
* @brief this header file will contain all required
* definitions and basic utilities functions to use the pgtest driver.
*
* @author Paraskevas Kyriakos
*
* @date 10/18/2018
*/

#ifndef _EXALLOC_LIB_H
#define _EXALLOC_LIB_H
#include <stdint.h>

/*********************************************Memory Segment size definition***********************************************/
#define mem_size 1024 * 1024 * 8

/*********************************************IOCTL operations Definitons supported by the driver***********************************************/

#define MEM_OPS_SET_TTBR _IOW('q', 'a', mem_ops_t *)
#define MEM_OPS_CLEAR_CACHE _IOW('q', 'b', mem_ops_t *)
#define MEM_OPS_CLEAR_PG _IOW('q', 'c', mem_ops_t *)
#define MEM_OPS_SET_OS _IOW('q', 'd', mem_ops_t *)
#define MEM_OPS_SET_SMR _IOW('q', 'e', mem_ops_t *)
#define MEM_OPS_SET_PTE_ADDR _IOW('q', 'f', mem_ops_t *)





/*********************************************Basic struct definition for page table memory segment data***********************************************/

typedef struct mem_ops_t //total of 24 bytes
{
    unsigned int size;
    unsigned long long address;
    unsigned int smr;
    unsigned long long new_address;
} mem_ops_t;




/**
 * One time initialization of the smmu page table driver
 *
 *  
 *@param handle: The handle provided by the user. The handle
 *fields such as SMR and size needs to be initialized by the
 *user before the function is called
 *
 *  
 *@return: 0 on success, error on -1
 *
 */ 

extern int init_driver(mem_ops_t handle);


/**
 * Simple function to close the file descriptor opened by the 
 * driver_init
 *  

 *@return: 0 on success, error on -1
 *
 */ 

int close_driver();




/**
 * Allocates space and pins it into ram.
 *
 *  
 *@param handle: The handle provided by the user. After malloc
 *the handle.address will be updated with the pointer
 *
 *@param size: The memory size to be allocated.
 *  
 *@return: 0 on success, error on -1
 *
 */ 


extern int exa_malloc(struct mem_ops_t handle);



/**
 *Changes the SMMU smr register mapping, according to user input
 *
 *  
 *@param handle: The handle provided by the user that contains the smr mapping
 *
 *@return: 0 on success, -1 on failure
 *
 */ 

extern int change_smr_mapping(struct mem_ops_t handle);




/**
 * Frees space and unpins it from ram.
 *
 * 
 *@param handle: The handle provided by the user that contains the segment address and size
 *  
 *@return: NULL
 *
 */ 


void exa_free(struct mem_ops_t handle);


/**
 * Manual change of the PTE address
 *
 * 
 *@param handle: The handle provided by the user that contains the new PTE address
 *  
 *@return: 0 on success, -1 otherwise
 *
 */ 

int change_pte_address(struct mem_ops_t handle, unsigned long long new_address);




#endif
