/************************************************************************
 *                                                                      *
 * Freescale Inc.                                                       *
 * (c) Copyright 2004 Freescale, Inc.                                   *
 * ALL RIGHTS RESERVED.                                                 *
 *                                                                      *
 ************************************************************************
 *                                                                      *
 * File Name: mclib_controller.h                                              *
 *                                                                      *
 ************************************************************************/
#ifndef _MCLIB_CONTROLLER_H_
#define _MCLIB_CONTROLLER_H_

/* Data type defintion(s)                                               */
typedef struct
{
   Frac16 propGain;
   Frac16 integGain;
   Frac32 integPartK_1;
   Frac16 posPiLimit;
   Frac16 negPiLimit;
   Word16 propGainSc;
   Word16 integGainSc;
   Word16 satFlag;
}MC_PiParams;

/* External function prototype(s)                                       */
extern asm Frac16 MCLIB_ControllerPI  (Frac16 desiredValue, Frac16 measuredValue, \
                                       MC_PiParams *pParams);
extern asm Frac16 MCLIB_ControllerPI2 (Frac16 desiredValue, Frac16 measuredValue, \
                                       MC_PiParams *pParams);                                    
#endif /* _MCLIB_CONTROLLER_H_ */
