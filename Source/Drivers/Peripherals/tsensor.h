/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  tsensor.h
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.19.0$
*
* Description: Header file for the Temperature Sensor driver
*
*******************************************************************************/

#ifndef __TSENSOR_H
#define __TSENSOR_H

/* qs.h is a master header file, which must be included */
#if !defined(__ARCH_H) || !defined(__PERIPH_H) || !defined(__APPCONFIG_H)
#error Please include qs.h before tsensor.h
#endif

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************************************
*
*                      General Interface Description
*
* A temperature sensor module is intended to operate in conjunction with
* on on-chip Analog-Digital (A/D). The module is composed of a custom analog block
* and a simple IPBus interface. Temperature readings may be taken through
* the A/D converter. Some MC A/D modules, notably those for the motor control
* families, include the ability to continuously monitor an input and issue
* an interrupt when a limit is exceeded. This provides the ability to easily
* implement an over-temperature alert.
* 
* For best accuracy, this module will need calibration. Therefore, it is best
* suited for devices with the capability to store calibration devices in on-chip
* Flash memory. A diode-based temperature sensor is assumed for the purposes
* of this specification, although the design team is free to use any circuit
* configuration yielding similar or better sensitivity and predictability.
* 
* For more information, please refer to the user manual for the particular chip
* that you are using, such as the MC56F8300 Peripheral Manual, for a description
* of the TSENSOR system.
*
* The TSENSOR device driver interface uses "ioctl" call to control specific
* TSENSOR functions during operation. For details see "ioctl" call.
*
******************************************************************************/

/************************************************************
* TSENSOR module identifiers, correspond to module base address
*************************************************************/

#define TSENSOR  (&ArchIO.TSensor)

/****************************************************
* Configurable items, i.e. defines, for appconfig.h
*****************************************************

  #define  TSENSOR_CNTL_INIT        0x0000 

*/

/*****************************************************************
* ioctl() commands
*
*  Word16 ioctl( TSENSOR_module_identifier, Command_name, Parameter );
*
******************************************************************

 COMMAND NAME                             PARAMETERS, COMMENTS
------------------------------------------------------------------ */
#define TSENSOR_INIT                      /* NULL */
#define TSENSOR_DEVICE                    /* TSENSOR_POWER_ON / TSENSOR_POWER_OFF  */
#define TSENSOR_IS_POWERED_ON             /* NULL , returns UWord16 */

/****************************************************************************
* TSENSOR constants and type declarations use in the ioctl functions
*****************************************************************************/

#define TSENSOR_POWER_ON      1
#define TSENSOR_POWER_OFF     0

/****************************************************************************/

/*****************************************************************
* TSENSOR Register Bits Defines, used in ioct command implementation
******************************************************************/

/* Temperature Sonsor Control Register CNTL */
#define TSENSOR_CNTL_PWR    0x0001   /* Power On Bit */  

/***********************************************************************
* TSENSOR init
***********************************************************************/

void tsensorInit(arch_sTSensor *pTSensorBase);
#define ioctlTSENSOR_INIT(pTSensorBase,param) tsensorInit(pTSensorBase)
 
/* Temperature Sonsor Control Register */

#define ioctlTSENSOR_DEVICE(pTSensorBase, param) \
  if (param) periphBitSet(TSENSOR_CNTL_PWR, &((pTSensorBase)->ctrl)); \
  else periphBitClear(TSENSOR_CNTL_PWR, &((pTSensorBase)->ctrl))

#define ioctlTSENSOR_IS_POWERED_ON(pTSensorBase, param) \
  periphBitTest(TSENSOR_CNTL_PWR, &((pTSensorBase)->ctrl))

#ifdef __cplusplus
}
#endif

#endif
