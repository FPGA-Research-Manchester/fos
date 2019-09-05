User level library for the SMMU-Page table driver

Author: Kyriakos Paraskevas
Version: ALPHA!!!

This file contains two folders with: 1) the modified SMMU-page table driver and 2) the user level library in order for the user to use the driver.



1)The driver:The meta-user folder was copied from the petalinux_project/project_spec folder and contains the core SMMU page table drivers as well as some modifications such as adding some device tree entries to use the driver. Desired functionality from the driver is achieved by modifying the page table attributes of the user allocated memory space, and also by pinning a translation into the SMMU Stream Match register.
The driver can be found inside the meta_user/recipes_module/pgtest/files


2) The user level library: The user program may use the functions provided in the exalloc_lib.h file, each one superseded by a brief explanation. The actual implementation is in the corresponding .c file.
Additionaly a user level program "user_example.c" that uses most of these functions is provided, but due to some library integration difficulties in the Petalinux environment, the actual functions are declared on top of this user file.

In order to use the driver, one must create a new petalinux project and copy the meta-data folder into the project_name/project_spec folder. Then, insert the module and user application into the project by running the petalinux-config -c rootfs command. Make sure you also build the module with the petalinux-build command. Lastly, run petalinux-build command. After board bootup, one can run the application by typing /usr/bin/ttbruser
