#include "version.h"

#define TARGET_SDM                  /* Small Data Model */
#define TARGET_CODE_PFLASH          /* Code located in internal flash */
#define TARGET_CONSTDATA_XFLASH     /* Constants and const variables located in xFlash */
#define TARGET_INITDATA_PFLASH      /* Initialization values for global variables located in pFlash */
#define TARGET_DATA_INTRAM          /* Variables located in internal RAM */
 
#pragma define_section fardata "fardata.data" "fardata.bss" RW  /* can be used to put far data (after 0x10000) */
#pragma define_section pramcode "pramcode.text" RWX  /* can be used to put code to program ram */

#if 0   /*
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
# interrupt vectors --> pROM starting at zero, reset vectors also in bootflash
#      program code --> pROM
#         constants --> xROM
#      dynamic data --> pROM copied to internal xRAM
#         variables --> int xRAM
#

# DSP56800E Target settings:
#
#   Small Data Model (SDM)
#   x memory: EX=0 (OMR)
#   p memory: EXTBOOT=0; EMI_MODE=n/a
# 
#   Monza Controller Board
#     J4 on   (EMI_MODE=0)          16bit external address bus
#     J5 on   (EXTBOOT=0 (MA=0))    Internal boot (boot location at 0x020000)
#     
#     J25 1-2 (/PS(CS0))            
#     J26 1-2 (/DS(CS1))
#     J27 1-2 (/CS2) 

MEMORY 
{
    .p_flash_ROM          (RX)  : ORIGIN = 0x00000,   LENGTH = 0x10000
    .p_external_RAM       (RX)  : ORIGIN = 0x10000,   LENGTH = 0x10000
    .p_bootflash_ROM      (RX)  : ORIGIN = 0x20000,   LENGTH = 0x1000
    .p_internal_RAM       (RWX) : ORIGIN = 0x2F800,   LENGTH = 0x800 
    .p_external2_RAM      (RWX) : ORIGIN = 0x30000,   LENGTH = 0x1D0000 

    .x_internal_RAM         (RW)  : ORIGIN =   0x0001, LENGTH = 0x0FFF
    .p_internal_RAM_ximage  (RX)  : ORIGIN =   0x0001, LENGTH = 0x0FFF # x_internal_RAM mirror in program memory (X flag set)
    .x_flash_ROM            (R)   : ORIGIN =   0x1000, LENGTH = 0x0FFF
    .x_flash_ROM_last       (R)   : ORIGIN =   0x1FFF, LENGTH = 0x0001
    .x_external_RAM         (RW)  : ORIGIN =   0x2000, LENGTH = 0xD000
    .p_external_RAM_ximage  (RX)  : ORIGIN =   0x2000, LENGTH = 0xD000 # x_external_RAM mirror in program memory (X flag set)
    .x_onchip_peripherals   (RW)  : ORIGIN =   0xF000, LENGTH = 0x1000
    .x_external2_RAM        (RW)  : ORIGIN =  0x10000, LENGTH = 0xFEFF00
    .p_external2_RAM_ximage (RX)  : ORIGIN =  0x10000, LENGTH = 0xFEFF00 # x_external2_RAM mirror in program memory (X flag set)
    .x_EOnCE                (R)   : ORIGIN = 0xFFFF00, LENGTH = 0x0100
}

# we ensure the interrupt vector section is not deadstripped here

KEEP_SECTION{ interrupt_vectors.text }
KEEP_SECTION{ boot_delay }
KEEP_SECTION{ boot_jump.text }

SECTIONS 
{
    # bounds for internal RAM checking (define before .x_internal_RAM is used!)
    F_Linternal_RAM_addr = ADDR(.x_internal_RAM);
    F_Linternal_RAM_size = SIZEOF(.x_internal_RAM)/2;
    
    # A single "jmp Start" instruction is put on the boot location
    # to run startup code after reset
    
    .boot_jump :
    {
        * (boot_jump.text)  
       
    } > .p_bootflash_ROM

    .boot_delay :
    {
        * (boot_delay)  
       
    } > .x_flash_ROM_last

    # Our interrupt table is put to 0x0000 in internal pFlash
    # VBA (vectors base) register is set to 0x0000 in startup code
    
    .interrupt_vectors :
    {
        * (interrupt_vectors.text)  
       
    } > .p_flash_ROM

    # interrupt table address
    F_Linterrupt_vectors_addr = ADDR(.interrupt_vectors);

    .executing_code :
    {
        # .text sections
        
        * (.text)
        * (rtlib.text)
        * (fp_engine.text)
        * (user.text)    
        
    } >> .p_flash_ROM

    .p_flash_ROM_data :
    {
        # initialized __pmem constants stay in p_flash ROM
        
        * (.const.data.char.pmem)
        * (.const.data.pmem)
        
        # save address where the init data image start in pROM
        _datap_ROM_addr = .;
        
    } >> .p_flash_ROM

    .pmemdata_image :  AT(_datap_ROM_addr)  # data load address is in pFlash
    {
        # __pmem .data sections (init values saved in pROM)
        
        # remember data start so we can copy data later to pRAM
        _datap_RAM_addr = .; 
        
        * (pramcode.text)    # treat pramcode just like initialized __pmem data
        * (.data.char.pmem)
        * (.data.pmem)
        . = . + .%2;

        _datap_RAM_end = .;
        _datap_size = _datap_RAM_end - _datap_RAM_addr;

        # calculate address for next part of pROM data
        _data_ROM_addr = _datap_ROM_addr + _datap_size;
        
    } > .p_internal_RAM
        
    .pmemdata :
    {
        # __pmem .bss section
        
        _BSSP_START = .;
        * (.bss.char.pmem)
        * (.bss.pmem)
        . = . + .%2;
        _BSSP_END = .;
        
    } >> .p_internal_RAM

    .x_flash_ROM_data :
    {
        # initialized constants in flash xROM
        
        * (.const.data.char)  
        * (.const.data)
        . = . + .%2;       
              
    } > .x_flash_ROM

    .data_image : AT(_data_ROM_addr) 
    {                             
        # the data sections (init values saved in pROM)
        
        # remember data start so we can copy data later to xRAM
        _data_RAM_addr = .; 
        
        * (fp_state.data)
        * (rtlib.data)
        * (.data.char)      
        * (.data)       
        . = . + .%2;       
   
        _data_RAM_end = .;
        _data_size = _data_RAM_end - _data_RAM_addr;
        
        # calculate address for next part of pROM data
        _data2_ROM_addr = _data_ROM_addr + _data_size;

    } > .p_internal_RAM_ximage
#   } > .p_external_RAM_ximage

    .data :
    {
        # save space for the pROM data copy 
        . = _data_RAM_end;
            
        # .bss section
        
        _BSS_START = .;
        * (rtlib.bss.lo)
        * (rtlib.bss)
        * (.bss.char)       
        * (.bss)
        . = . + .%2;        
        _BSS_END   = .;

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
        
    } > .x_internal_RAM    # internal RAM for data
#   } > .x_external_RAM    # external RAM for data

    .fardata_image : AT(_data2_ROM_addr) 
    {                             
        # far data sections (init values saved in pROM)
  
        # save data start so we can copy data later to xRAM
        _data2_RAM_addr = .; 
        
        * (fardata.data.char)      
        * (fardata.data)        
        . = . + .%2;       
   
        _data2_RAM_end = .;
        _data2_size = _data2_RAM_end - _data2_RAM_addr;

    } > .p_external2_RAM_ximage

    .fardata :
    {    
        # save space for the pROM data copy 
        . = _data2_RAM_end;
        
        # far .bss sections
        
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
    
    # data ROM to RAM copying used in init code
    
    F_Ldata_ROM_addr = _data_ROM_addr;
    F_Ldata_RAM_addr = _data_RAM_addr;
    F_Ldata_size = _data_size;

    F_Ldata2_ROM_addr = _data2_ROM_addr;
    F_Ldata2_RAM_addr = _data2_RAM_addr;
    F_Ldata2_size = _data2_size;
    
    F_Ldatap_ROM_addr = _datap_ROM_addr;
    F_Ldatap_RAM_addr = _datap_RAM_addr;
    F_Ldatap_size = _datap_size;
    
    # peripheral registers
    FArchIO = ADDR(.x_onchip_peripherals);
}

#endif  /* end of code excluded by C-compiler */
