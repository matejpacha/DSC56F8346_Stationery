#include "version.h"

#define TARGET_LDM                  /* Large Data Model */
#define TARGET_CODE_EXTRAM          /* Code located in external pRAM */
#define TARGET_CONSTDATA_EXTRAM     /* Constants and const variables located in external xRAM */
#define TARGET_INITDATA_EXTRAM      /* Initialized global variables located in external RAM */
#define TARGET_DATA_EXTRAM          /* Variables located in external RAM */

#pragma define_section fardata "fardata.data" "fardata.bss" RW  /* can be used to put far data (after 0x10000) */
#pragma define_section pramcode "pramcode.text" RWX  /* can be used to put code to program ram */

#if 0	/*
#
# This is quite tricky here. We are using this file as BOTH linker command 
# file AND the C-preprocessor prefix file for selected target.
#
# In C prefix file, we define a set of macros to enable conditional compilation 
# based on target settings. For example, you can disable compilation of memory 
# initialization using Rom_to_Ram features when such is not used. 
#
# */

# memory use for this LCF: 
#
# interrupt vectors --> ext pRAM starting at zero, reset vectors also at bootlocation (in RAM)
#      program code --> ext pRAM
#         constants --> ext xRAM
#      dynamic data --> ext xRAM 
#         variables --> ext xRAM
#

# DSP56800E Target settings:
#
#   Large Data Model (LDM) - can be used in SDM too
#   x memory: EX=0 (OMR)
#   p memory: EXTBOOT=1; EMI_MODE=0/1
#
#   Monza Controller Board
#     J4 on   (EMI_MODE=0)          16bit external address bus
#     J5 off  (EXTBOOT=1 (MA=1))    External boot (boot location at 0x0)
#     
#     J25 1-2 (/PS(CS0))            
#     J26 1-2 (/DS(CS1))
#     J27 1-2 (/CS2)

MEMORY 
{
# for the case EMI_MODE=1:
#   .p_external_RAM       (RWX) : ORIGIN = 0x00000,  LENGTH = 0x200000
#   .p_bootlocation_RAM   (RWX) : ORIGIN = 0x20000,  LENGTH = 0
    
# for the case EMI_MODE=0:
    .p_external_RAM       (RWX) : ORIGIN = 0x00000,  LENGTH = 0x10000 
    .p_flash_ROM          (RX)  : ORIGIN = 0x10000,  LENGTH = 0x10000
    .p_flash2_ROM         (RX)  : ORIGIN = 0x20000,  LENGTH = 0x1000 
    
    .x_internal_RAM       (RW)  : ORIGIN =   0x0001, LENGTH = 0x0FFF
    .x_flash_ROM          (R)   : ORIGIN =   0x1000, LENGTH = 0x1000   
    .x_external_RAM       (RW)  : ORIGIN =   0x2000, LENGTH = 0xD000
    .x_onchip_peripherals (RW)  : ORIGIN =   0xF000, LENGTH = 0x1000
    .x_external2_RAM      (RW)  : ORIGIN =  0x10000, LENGTH = 0xFEFF00
    .x_EOnCE              (R)   : ORIGIN = 0xFFFF00, LENGTH = 0x0100
}

# we ensure the interrupt vector section is not deadstripped here

KEEP_SECTION{ interrupt_vectors.text }
# KEEP_SECTION{ boot_jump.text }

SECTIONS 
{
	# bounds for internal RAM checking (define before .x_internal_RAM is used!)
	F_Linternal_RAM_addr = ADDR(.x_internal_RAM);
	F_Linternal_RAM_size = SIZEOF(.x_internal_RAM)/2;
	
	# Our interrupt table is put to 0x0000 in external RAM
	# VBA (vectors base) register is set to 0x0000 in startup code

  # .boot_jump :
  # {
  # 	* (boot_jump.text)  
  #    
  # } > .p_bootlocation_RAM

    .interrupt_vectors :
    {
    	* (interrupt_vectors.text)  
       
    } > .p_external_RAM

    # interrupt table address
    F_Linterrupt_vectors_addr = ADDR(.interrupt_vectors);
	
    .executing_code :
    {
        # .text sections
        
        * (.text)
        * (rtlib.text)
        * (fp_engine.text)
        * (user.text)    
		* (pramcode.text)
		
    } >> .p_external_RAM

    .pmemdata :
    {
        # __pmem .data sections
        
    	* (.const.data.char.pmem)
    	* (.const.data.pmem)
    	* (.data.char.pmem)
    	* (.data.pmem)
        . = . + .%2;
        
        # __pmem .bss section
        
        _BSSP_START = .;
    	* (.bss.char.pmem)
    	* (.bss.pmem)
        . = . + .%2;
        _BSSP_END = .;
        
    } >> .p_external_RAM

    .data :
    {    
        # .data sections
        
        * (.const.data.char)
        * (.const.data)
        * (fp_state.data)
        * (rtlib.data)
        * (.data.char)
        * (.data)
        . = . + .%2;

        # .bss section
        
        _BSS_START = .;
        * (rtlib.bss.lo)
        * (rtlib.bss)
        * (.bss.char)
        * (.bss)
        . = . + .%2;
        _BSS_END   = .;

		##################################################################
        # Note: move the following lines to the .fardata section to cause
        #       the HEAP and/or STACK to be allocated in extended memory

        # setup the heap address
        
        . = ALIGN(4);
        _HEAP_ADDR = .;
        _HEAP_SIZE = 0x100;
        _HEAP_END = _HEAP_ADDR + _HEAP_SIZE; 
        . = _HEAP_END;

        # setup the stack address 
        
        _min_stack_size = 0x200;
        _stack_addr = _HEAP_END;
        _stack_end  = _stack_addr + _min_stack_size;
        . = _stack_end;
        
    } > .x_external_RAM    

    .fardata :
    {    
        # far .data sections
        
        * (fardata.data.char)
        * (fardata.data)
        . = . + .%2;

        # far .bss section
        
        _BSS2_START = .;
        * (fardata.bss.char)
        * (fardata.bss)
        . = . + .%2;
        _BSS2_END   = .;
        
    } > .x_external2_RAM    

	# used by MSL 
	    
	F_heap_addr   = _HEAP_ADDR;
	F_heap_end    = _HEAP_END;

	# stationery init code uses these globals:

	F_Lstack_addr   = _stack_addr;

	# BSS addresses used in init code

	F_Lbss_start   = _BSS_START;
	F_Lbss_end     = _BSS_END;
	F_Lbss_size    = _BSS_END - _BSS_START;
	
	F_Lbss2_start  = _BSS2_START;
	F_Lbss2_end    = _BSS2_END;
	F_Lbss2_size   = _BSS2_END - _BSS2_START;
	
	F_Lbssp_start  = _BSSP_START;
	F_Lbssp_end    = _BSSP_END;
	F_Lbssp_size   = _BSSP_END - _BSSP_START;
	
	# peripheral registers
	FArchIO = ADDR(.x_onchip_peripherals);
}


#endif	/* end of code excluded by C-preprocessor */
