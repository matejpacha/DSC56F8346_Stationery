/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  sys.c
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.14.0$
*
* Description: SYS (system reset and support functions) driver
*
*****************************************************************************/

#include "qs.h"
#include "sys.h"

#ifdef __cplusplus
extern "C" {
#endif

/* initialization of SYS (SIM) system support functions */

void sysInit(arch_sSIM *pSimBase)
{
#pragma unused(pSimBase)

	#ifdef SIM_CONROL_INIT
	periphMemWrite(SIM_CONROL_INIT, &pSimBase->sim_control);
	#endif
 
	#ifdef SIM_PUDR_INIT
	periphMemWrite(SIM_PUDR_INIT, &pSimBase->sim_pudr);
	#endif

	#ifdef SIM_CLKOSR_INIT
	periphMemWrite(SIM_CLKOSR_INIT, &pSimBase->sim_clkosr);
	#endif

	#ifdef SIM_GPS_INIT
	periphMemWrite(SIM_GPS_INIT, &pSimBase->sim_gps);
	#endif

	#ifdef SIM_PCE_INIT
	periphMemWrite(SIM_PCE_INIT, &pSimBase->sim_pce);
	#endif

	/* SIM_VERSION_2-only  (see module strucutre and target MCU in arch.h) */
	#ifdef SIM_PCE2_INIT
	periphMemWrite(SIM_PCE2_INIT, &pSimBase->sim_pce2);
	#endif

	/* LVI is initialized here as a part of SYS initialization */	
	#ifdef LVI_CONTROL_INIT
	periphMemWrite(LVI_CONTROL_INIT, &LVI->lvictlr);
	#endif
 
 
	/* Note: SEMI is initialized already in the startup.c code */
}

#ifdef __cplusplus
}
#endif
