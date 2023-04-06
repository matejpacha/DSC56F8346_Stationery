/* *** Copyright Freescale Semiconductor, Inc, 2005 *** */ 
/* Copyright © 2005 Metrowerks Corporation.  All rights reserved. */

#include <Fltmath.h>

#include <ansi_parms.h>
_MSL_BEGIN_EXTERN_C

#define True  1
#define False 0

/*
--
--   ----------------------------------------------------
--   | S |<----- Exp   ----->|<----- Mantissa --------->|
--   ----------------------------------------------------
--    31     30-23                      22-0
--
*/

#define   Exponent_Mask                0x7f800000
#define   Sign_Mask                    0x80000000
#define   Signaling_NaN_Mask           0x00400000
#define   Mantissa_Mask                0x007fffff
#define   GRS_Mask                     0x00000007
#define   Hidden_One                   0x04000000

#define   No_Of_Mantissa_Bits          26   /* 23+3 bits for GRS bits */
#define   Normalize_Bit                0x00400000
#define   Max_Exponent                 0xff
#define   Min_Exponent                 -0x7f
#define   Exp_Bias                     0x7f

#define   Quiet_Nan                    0x7fffffff
#define   Signaling_Nan                0x7fbfffff

#define   Minus_Zero                   0x80000000
  
#define   IntegerFirst                 0x80000000L
#define   IntegerLast                  0x7fffffffL
  
#define   One                          0x3f800000


#if 0  
#define   ExpOf(x)      ((x & Exponent_Mask)>>23L)
#define   MantissaOf(x) ((x & Mantissa_Mask)<<3)
#define   SignOf(x)     ((x>>31)&1)
  
  

typedef struct {    /* Single precision float internal representation  */
  long  Mantissa;   /* 23 bit mantissa + 3 bits for GRS (Guard,Round   */
                    /* and Sticky bits).                               */
  short Exp;         /* 8 bit exponent biased.                          */
  short Sign;        /* 0 - positive,   1 - negative                    */
  } FloatIR;

int IsNan_Signaling ( SpFloat );
#ifdef _FAR_RUNTIME_CALLS
#pragma far IsNan_Signaling
#endif

int IsZero ( SpFloat );
#ifdef _FAR_RUNTIME_CALLS
#pragma far IsZero
#endif

int IsInf ( SpFloat );
#ifdef _FAR_RUNTIME_CALLS
#pragma far IsInf
#endif

int IsDeNorm ( SpFloat );
#ifdef _FAR_RUNTIME_CALLS
#pragma far IsDeNorm
#endif


void SpFloat2FloatIR ( SpFloat, FloatIR * );
#ifdef _FAR_RUNTIME_CALLS
#pragma far SpFloat2FloatIR
#endif

SpFloat FloatIR2SpFloat ( FloatIR * );
#ifdef _FAR_RUNTIME_CALLS
#pragma far FloatIR2SpFloat
#endif


void OverflowCheck ( FloatIR * );
#ifdef _FAR_RUNTIME_CALLS
#pragma far OverflowCheck
#endif

void UnderflowCheck ( FloatIR * );
#ifdef _FAR_RUNTIME_CALLS
#pragma far UnderflowCheck
#endif

void AddOne ( FloatIR * );
#ifdef _FAR_RUNTIME_CALLS
#pragma far AddOne
#endif

void RoundFloat ( FloatIR * );
#ifdef _FAR_RUNTIME_CALLS
#pragma far RoundFloat
#endif

#endif

_MSL_END_EXTERN_C

