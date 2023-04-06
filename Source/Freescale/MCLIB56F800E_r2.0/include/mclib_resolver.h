/************************************************************************
 *                                                                      *
 * Freescale, Inc.                                                      *
 * (c) Copyright 2004 Freescale, Inc.                                   *
 * ALL RIGHTS RESERVED                                                  *
 *                                                                      *
 ************************************************************************
 *                                                                      *
 * File name  : mclib_resolver.h                                              *
 *                                                                      *
 ************************************************************************/
#ifndef _MCLIB_RESOLVER_H_
#define _MCLIB_RESOLVER_H_

    
#include "mclib_types.h"      
    
/* External function prototype(s)                                       */  
extern void   MCLIB_InitTrackObsv     (Frac16 k1_d, Frac16 k2_d, int k1_sc, int k2_sc);
extern void   MCLIB_CalcTrackObsv     (Frac16 sinA, Frac16 cosA);
extern Frac16 MCLIB_GetResPosition    (void);
extern int    MCLIB_GetResRevolutions (void);
extern Frac32 MCLIB_GetResSpeed       (void);
extern void   MCLIB_SetResPosition    (Frac16 newPosition);
extern void   MCLIB_SetResRevolutions (int newRevolutions);

#endif /* _MCLIB_RESOLVER_H_ */
