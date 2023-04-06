/************************************************************************
 *                                                                      *
 * Freescale, Inc.                                                      *
 * (c) Copyright 2004 Freescale, Inc.                                   *
 * ALL RIGHTS RESERVED                                                  *
 *                                                                      *
 ************************************************************************
 *                                                                      *
 * File name    : mclib_transform.h                                     *
 *                                                                      *
 ************************************************************************/
#ifndef _MCLIB_TRANSFORM_H_
#define _MCLIB_TRANSFORM_H_

/* External function prototype(s)                                       */
extern void MCLIB_ClarkTrfm    (MC_2PhSyst *pAlphaBeta, MC_3PhSyst *p_abc);
extern void MCLIB_ClarkTrfmInv (MC_3PhSyst *p_abc, MC_2PhSyst *pAlphaBeta);
extern void MCLIB_ParkTrfm     (MC_DqSyst *pDQ, MC_2PhSyst *pAlphaBeta, MC_Angle *pSinCos);
extern void MCLIB_ParkTrfmInv  (MC_2PhSyst *pAlphaBeta, MC_DqSyst *pDQ, MC_Angle *pSinCos);

#endif /* _MCLIB_TRANSFORM_H_ */

