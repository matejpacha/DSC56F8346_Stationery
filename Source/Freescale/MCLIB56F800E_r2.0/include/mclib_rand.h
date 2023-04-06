/************************************************************************
 *                                                                      *
 * Motorola, Inc.                                                       *
 * (c) Copyright 2002 Motorola, Inc.                                    *
 * ALL RIGHTS RESERVED                                                  *
 *                                                                      *
 ************************************************************************
 *                                                                      *
 * File name    : mclib_rand.h                                                *
 *                                                                      *
 ************************************************************************/
#ifndef _MCLIB_RAND_H_
#define _MCLIB_RAND_H_

/* External function prototype(s)                                       */
extern Frac16 MCLIB_Rand16              (void);
extern void   MCLIB_SetRandSeed16       (Frac16 x);
extern bool   MCLIB_GetSetSaturationMode(bool saturationMode);

#endif /* _MCLIB_RAND_H_ */
