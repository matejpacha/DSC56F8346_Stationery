/************************************************************************
 *                                                                      *
 * Freescale, Inc.                                                      *
 * (c) Copyright 2004 Freescale, Inc.                                   *
 * ALL RIGHTS RESERVED                                                  *
 *                                                                      *
 ************************************************************************
 *                                                                      *
 * File name    : mclib_ramp.h                                                *
 *                                                                      *
 ************************************************************************/
#ifndef _MCLIB_RAMP_H_
#define _MCLIB_RAMP_H_

/* External function prototype(s)                                       */
extern Frac32 MCLIB_RampGetValue (Frac32 incrementUp, Frac32 incrementDown, \
                                    const Frac32 *pActualValue, const Frac32 *pRequestedValue);

#endif /* _MCLIB_RAMP_H_ */
