/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2010 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* $File Name: version.h$
*
* $Date:      Oct-12-2010$
*
* Description: Defines the quick-start version constants 
*
*****************************************************************************/

#ifndef __VERSION_H
#define __VERSION_H

/*****************************************************************************
           RELEASE LIST - HISTORY

release       symbol                                           value
------------------------------------------------------------------------------
0.Beta        DSP56800E_QUICK_START_VERSION_0_BETA             0x0000
1.0           DSP56800E_QUICK_START_VERSION_1_0                0x0100
1.1           DSP56800E_QUICK_START_VERSION_1_1                0x0101
2.0-Beta      DSP56800E_QUICK_START_VERSION_2_0BETA            0x01ff
2.0           DSP56800E_QUICK_START_VERSION_2_0                0x0200
2.1           DSP56800E_QUICK_START_VERSION_2_1                0x0201
2.2           DSP56800E_QUICK_START_VERSION_2_2                0x0202
2.3-Beta      DSP56800E_QUICK_START_VERSION_2_3BETA            0x0203
2.3-Beta2     DSP56800E_QUICK_START_VERSION_2_3BETA2           0x0203
2.3           DSP56800E_QUICK_START_VERSION_2_3                0x0203
2.4-Alpha     DSP56800E_QUICK_START_VERSION_2_4                0x0204
2.4           DSP56800E_QUICK_START_VERSION_2_4                0x0204
2.5-Alfa      DSP56800E_QUICK_START_VERSION_2_5                0x0205
2.5-beta      DSP56800E_QUICK_START_VERSION_2_5BETA            0x0205
2.5-beta2     DSP56800E_QUICK_START_VERSION_2_5BETA2           0x0205
2.5-beta3     DSP56800E_QUICK_START_VERSION_2_5BETA3           0x0205
2.5           DSP56800E_QUICK_START_VERSION_2_5                0x0205
*****************************************************************************/

#define VERSION_MAKE(major,minor) ((major)<<8 | (minor))
#define VERSION_MAJOR(ver) ((ver)>>8)
#define VERSION_MINOR(ver) ((ver)&0xff)

#define DSP56800E_QUICK_START_VERSION 		VERSION_MAKE(2,5)
#define DSP56800E_QUICK_START_MINOR_VERSION	VERSION_MINOR(DSP56800E_QUICK_START_VERSION)
#define DSP56800E_QUICK_START_MAJOR_VERSION	VERSION_MAJOR(DSP56800E_QUICK_START_VERSION)

#define DSP56800E_QUICK_START_VERSION_2_5

#ifndef TARGET_SDM
#define TARGET_SDM                  /* Small Data Model */
#endif

#ifndef TARGET_CODE_PFLASH
#define TARGET_CODE_PFLASH          /* Code located in internal flash */
#endif

#ifndef TARGET_CONSTDATA_XFLASH
#define TARGET_CONSTDATA_XFLASH     /* Constants and const variables located in xFlash */
#endif

#ifndef TARGET_INITDATA_XFLASH
#define TARGET_INITDATA_XFLASH      /* Initialization values for global variables located in xFlash */
#endif

#ifndef TARGET_DATA_INTRAM
#define TARGET_DATA_INTRAM          /* Variables located in internal RAM */
#endif

#pragma define_section fardata "fardata.data" "fardata.bss" RW  /* can be used to put far data (after 0x10000) */
#pragma define_section pramcode "pramcode.text" RWX  /* can be used to put code to program ram */

#endif /* __VERSION_H */
