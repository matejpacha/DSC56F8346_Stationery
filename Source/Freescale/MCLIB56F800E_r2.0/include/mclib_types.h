/********************************************************************
 *                                                                  *
 * Freescale Inc.                                                   *
 * (c) Copyright 2004 Freescale, Inc.                               *
 * ALL RIGHTS RESERVED.                                             *
 *                                                                  *
 ********************************************************************
 *                                                                  *
 * File Name: mclib_types.h                                         *
 *                                                                  *
 ********************************************************************/
#ifndef _MCLIB_TYPES_H_
#define _MCLIB_TYPES_H_

#include <intrinsics_56800E.h>

#if (!defined(__TYPES_H) && !defined(__PE_Types_H))
#define __TYPES_H

/* Generic word types for ITU compatibility */
typedef char           Word8;
typedef unsigned char  UWord8;
typedef short          Word16;
typedef unsigned short UWord16;
typedef long           Word32;
typedef unsigned long  UWord32;

typedef char           Int8;
typedef unsigned char  UInt8;
typedef int            Int16;
typedef unsigned int   UInt16;
typedef long           Int32;
typedef unsigned long  UInt32;

/* Fractional data types for portability */
typedef short          Frac16;
typedef long           Frac32;

#ifndef NULL
#define NULL ((void *)0)  /* or for C++ #define NULL 0 */
#endif

/* Miscellaneous types */
#ifndef COMPILER_HAS_BOOL
typedef int            bool;
#endif

#ifndef COMPILER_HAS_BOOL
#define true  1
#define false 0
#endif

#endif /* !__TYPES_H && !__PE_Types_H */

#if !defined(FRAC16)
#define FRAC16(x) ((Frac16)((x) < 0.999969482421875 ? ((x) >= -1 ? (x)*0x8000 : 0x8000) : 0x7FFF))

#endif //!FRAC16

#if !defined(FRAC32)
#define FRAC32(x) ((Frac32)((x) < 1 ? ((x) >= -1 ? (x)*0x80000000 : 0x80000000) : 0x7FFFFFFF))

#endif //!FRAC32

/* Data type defintion(s)                                           */
typedef struct
{
    Frac16 a;
    Frac16 b;
    Frac16 c;
} MC_3PhSyst;


typedef struct
{
    Frac16 alpha;
    Frac16 beta;
} MC_2PhSyst;


typedef struct
{
    Frac16 sin;
    Frac16 cos;
} MC_Angle;


typedef struct
{
    Frac16 d;
    Frac16 q;
} MC_DqSyst;

#endif /* _MCLIB_TYPES_H_ */
