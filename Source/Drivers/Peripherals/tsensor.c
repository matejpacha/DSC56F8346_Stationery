/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  tsensor.c
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.12.0$
*
* Description: Source file for the TSENSOR Driver
*
*******************************************************************************/

#include "qs.h"
#include "tsensor.h"

#ifdef __cplusplus
extern "C" {
#endif

/* initialization of Temperature Sensor module */

void tsensorInit(arch_sTSensor *pTSensorBase)
{
#pragma unused(pTSensorBase)

	#ifdef TSENSOR_CNTL_INIT
	periphMemWrite(TSENSOR_CNTL_INIT, &pTSensorBase->ctrl);
	#endif
}

#ifdef __cplusplus
}
#endif
