/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:09:41 $
 * $Revision: 1.13 $
 */

 /*
  * This header file is a portable cmath header for all CodeWarrior compilers/targets - except
  * for the traditional Mac OS.  The Mac OS is unique in that it is currently the only
  * platform where CodeWarrior does not provide the math portion of the C standard library.
  * We simply hook into the library provided by Apple as part of the Mac OS.
  */

#ifndef _MSL_CMATH_DSP_56800
#define _MSL_CMATH_DSP_56800

#define _MSL_CMATH_DEFINED_MATH_ITEMS

/* common macro definitions */
#define FP_NAN       1  /*   quiet NaN (signaling Nan supported on MAC but nowhere else. */
#define FP_INFINITE  2  /*   + or - infinity      */
#define FP_ZERO      3  /*   + or - zero          */
#define FP_NORMAL    4  /*   all normal numbers   */
#define FP_SUBNORMAL 5  /*   denormal numbers     */

#define DECIMAL_DIG 17

#include <msl_t.h>

#if __option(little_endian)
	#define __HI(x) ( sizeof(x)==8 ? *(1+(_INT32*)&x) : (*(_INT32*)&x))
	#define __LO(x) (*(_INT32*)&x)
	#define __UHI(x) ( sizeof(x)==8 ? *(1+(_UINT32*)&x) : (*(_UINT32*)&x))
	#define __ULO(x) (*(_UINT32*)&x)
#else
	#define __LO(x) ( sizeof(x)==8 ? *(1+(_INT32*)&x) : (*(_INT32*)&x))
	#define __HI(x) (*(_INT32*)&x)
	#define __ULO(x) ( sizeof(x)==8 ? *(1+(_UINT32*)&x) : (*(_UINT32*)&x))
	#define __UHI(x) (*(_UINT32*)&x)
#endif

_MSL_BEGIN_EXTERN_C

	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __fpclassifyf(float x);
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __fpclassifyd(double x);
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __fpclassifyl(long double x);

#if _MSL_USE_INLINE

	_MSL_INLINE int _MSL_MATH_CDECL __fpclassifyf(float x)
	{
	 switch( (*(_INT32*)&x)&0x7f800000 )
	  {
	  case 0x7f800000:
	   {
	    if((*(_INT32*)&x)&0x007fffff) return FP_NAN;
	    else return FP_INFINITE;
	    break;
	   }
	  case 0:
	   {
	    if((*(_INT32*)&x)&0x007fffff) return FP_SUBNORMAL;
	    else return FP_ZERO; 
	    break; 
	   }
	  }
	  return FP_NORMAL;
	}  


	_MSL_INLINE int _MSL_MATH_CDECL __fpclassifyd(double x) 
	{
	 switch(__HI(x)&0x7ff00000 )
	  {
	   case 0x7ff00000:
	   {
	    if((__HI(x)&0x000fffff) || (__LO(x)&0xffffffff)) return FP_NAN;
	    else return FP_INFINITE;
	    break;
	   }
	  case 0:
	  {
	    if((__HI(x)&0x000fffff) || (__LO(x)&0xffffffff)) return FP_SUBNORMAL;
	    else return FP_ZERO; 
	    break; 
	  }
	  
	  }
	  return FP_NORMAL;
	} 
 
#endif /* _MSL_USE_INLINE */

_MSL_END_EXTERN_C
 
#define signbit(x)((int)(__HI(x)&0x80000000))


/* 7.7 Defines */	

/* moved to target header  */


/* 7.7.3  Classification macros */

#define fpclassify(x)  \
	 	((sizeof(x) == sizeof(float)) ? __fpclassifyf((float)(x)) : \
	 	(sizeof(x) == sizeof(double)) ? __fpclassifyd((double)(x)) : \
										__fpclassifyl((long double)(x)) )

_MSL_BEGIN_EXTERN_C

	_MSL_IMP_EXP _INT32 __float_huge[];
	_MSL_IMP_EXP _INT32 __float_nan[];
	_MSL_IMP_EXP _INT32 __double_huge[];
	_MSL_IMP_EXP _INT32 __extended_huge[];

	/*  special number macros */

	#define HUGE_VAL  (*(double*)     __double_huge)
	#define INFINITY  (*(float*)      __float_huge)
	#define NAN       (*(float*)      __float_nan)
	#define HUGE_VALF (*(float*)      __float_huge)
	#define HUGE_VALL (*(long double*)__extended_huge)

_MSL_END_EXTERN_C

#define isnormal(x) (fpclassify(x) == FP_NORMAL)
#define isnan(x)    (fpclassify(x) == FP_NAN)
#define isinf(x)    (fpclassify(x) == FP_INFINITE)
#define isfinite(x) ((fpclassify(x) > FP_INFINITE))


/* 7.7.14 	Comparison macros */

_MSL_BEGIN_EXTERN_C

	_MSL_IMP_EXP_C	int _MSL_MATH_CDECL isgreater(double x, double y);
	_MSL_IMP_EXP_C	int _MSL_MATH_CDECL isgreaterequal(double x, double y);
	_MSL_IMP_EXP_C	int _MSL_MATH_CDECL isless(double x, double y);
	_MSL_IMP_EXP_C	int _MSL_MATH_CDECL islessequal(double x, double y);
	_MSL_IMP_EXP_C	int _MSL_MATH_CDECL islessgreater(double x, double y);
	_MSL_IMP_EXP_C	int _MSL_MATH_CDECL isunordered(double x, double y);

_MSL_END_EXTERN_C

#if !defined(_MSL_NO_MATH_LIB)

/*	Standard functions */

_MSL_BEGIN_NAMESPACE_STD
_MSL_BEGIN_EXTERN_C

	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL erf(double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL erfc(double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL erfcf(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL erfcl(long double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL erff(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL erfl(long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL exp(double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL expf(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL expl(long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL fabs(double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fabsf(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fabsl(long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL fma(double, double, double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fmaf(float, float, float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fmal(long double, long double, long double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fmodf(float, float);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL frexp(double, int*);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL frexpf(float, int*);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL frexpl(long double, int*);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL ldexp(double, int);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL ldexpf(float, int);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL ldexpl(long double, int);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL lgamma(double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL lgammaf(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL lgammal(long double);
#if _MSL_LONGLONG
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llrint(double);
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llrintf(float);
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llrintl(long double);
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llround(double);
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llroundf(float);
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llroundl(long double);
#endif
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log(double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log10(double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL log10f(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL log10l(long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log2(double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL log2f(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL log2l(long double);	
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL logf(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL logl(long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL modf(double, double*);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL modff(float, float*);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL modfl(long double, long double*);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nan(const char*);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL nanf(const char*);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL nanl(const char*);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nextafter(double, double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL nextafterf(float, float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL nextafterl(long double, long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nexttoward(double, long double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL nexttowardf(float, long double);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL nexttowardl(long double, long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL pow(double, double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL powf(float, float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL powl(long double, long double);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL scalbn(double, int);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL scalbnf(float, int);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL scalbnl(long double, int);
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL tgamma(double);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL tgammaf(float);
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL tgammal(long double);

	#undef _MSL_USING

_MSL_END_EXTERN_C
_MSL_END_NAMESPACE_STD

#include <math_config.h>

#endif /* !defined(_MSL_NO_MATH_LIB) */

#endif /* _MSL_CMATH_DSP_56800 */

/* Change record:
 * cc  020805 Made dsp its own cmath file 
 * JWW 030224 Changed __MSL_LONGLONG_SUPPORT__ flag into the new more configurable _MSL_LONGLONG
 */