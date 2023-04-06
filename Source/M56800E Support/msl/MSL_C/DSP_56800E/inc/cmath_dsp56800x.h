/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2007/07/26 21:16:35 $
 * $Revision: 1.14 $
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

#include <math_api.h>

/************************/
/*						*/
/* 	 Standard Macros	*/
/*						*/
/************************/

#if _MSL_C99 || _MSL_USES_SUN_MATH_LIB
	#define FP_NAN       1  /*   quiet NaN */
	#define FP_INFINITE  2  /*   + or - infinity */
#endif /* _MSL_USES_SUN_MATH_LIB */

#if _MSL_C99 || _MSL_USES_SUN_MATH_LIB || _MSL_C_HAS_CPP_EXTENSIONS
#define FP_ZERO      3  /*   + or - zero          */
#define FP_NORMAL    4  /*   all normal numbers   */
#define FP_SUBNORMAL 5  /*   denormal numbers     */
#endif /* _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS */

#if _MSL_C99 || _MSL_C99_MATH_LEAK
	#ifndef FP_ILOGB0
	#define FP_ILOGB0   INT_MIN
	#endif
	#ifndef FP_ILOGBNAN
	#define FP_ILOGBNAN INT_MAX
#endif

	#ifndef MATH_ERRNO
	#define MATH_ERRNO 		1
	#endif /* MATH_ERRNO */

	#ifndef MATH_ERREXCEPT
	#define MATH_ERREXCEPT	2
	#endif /* MATH_ERREXCEPT */

	#ifndef math_errhandling
	#define math_errhandling _MSL_MATH_ERRHANDLING
	#endif /* math_errhandling */
#endif /* _MSL_C99 */                /*- mm 030716 -*/

_MSL_BEGIN_EXTERN_C

	_MSL_IMP_EXP _INT32 __double_huge[];

	#define HUGE_VAL  (*(double*)     __double_huge)  /* C89 */

_MSL_END_EXTERN_C

#if _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS || _MSL_USES_SUN_MATH_LIB 

_MSL_BEGIN_EXTERN_C

	_MSL_IMP_EXP _INT32 __float_huge[];
		
	#define HUGE_VALF (*(float*)      __float_huge)
	#define INFINITY  (*(float*)      __float_huge)		
	
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __signbitf(float x) _MSL_CANT_THROW; 		/*- cc 040920 -*/
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __signbitd(double x) _MSL_CANT_THROW;		/*- cc 040920 -*/
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __signbit(long double x) _MSL_CANT_THROW;	/*- cc 040920 -*/

_MSL_END_EXTERN_C
 
	#define signbit(x)  \
		 ((sizeof(x) == sizeof(float))  ? __signbitf((float)(x)) \
		: (sizeof(x) == sizeof(double)) ? __signbitd((double)(x)) \
		:                     			  __signbit((long double)(x)) )						/*- cc 040920 -*/					
#endif /* _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS */

#if _MSL_C99 || _MSL_USES_SUN_MATH_LIB

_MSL_BEGIN_EXTERN_C

	_MSL_IMP_EXP _INT32 __float_nan[];

	#define NAN       (*(float*)      __float_nan)
	
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __fpclassifyf(float x) _MSL_CANT_THROW;
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __fpclassifyd(double x) _MSL_CANT_THROW;
	extern _MSL_IMP_EXP_C int _MSL_MATH_CDECL __fpclassifyl(long double x) _MSL_CANT_THROW;

_MSL_END_EXTERN_C

#define fpclassify(x)  \
	 	((sizeof(x) == sizeof(float)) ? __fpclassifyf((float)(x)) : \
	 	(sizeof(x) == sizeof(double)) ? __fpclassifyd((double)(x)) : \
										__fpclassifyl((long double)(x)) )

#endif /* _MSL_C99 || _MSL_USES_SUN_MATH_LIB */

#if _MSL_C99

_MSL_BEGIN_EXTERN_C

	_MSL_IMP_EXP _INT32 __extended_huge[];

	#define HUGE_VALL (*(long double*)__extended_huge)

_MSL_END_EXTERN_C

#endif /* _MSL_C99 */

#if _MSL_C99 || _MSL_USES_SUN_MATH_LIB

#define isnormal(x) (fpclassify(x) == FP_NORMAL)
#define isnan(x)    (fpclassify(x) == FP_NAN)
#define isinf(x)    (fpclassify(x) == FP_INFINITE)
#define isfinite(x) ((fpclassify(x) > FP_INFINITE))

#endif /* _MSL_C99 || _MSL_USES_SUN_MATH_LIB */

#if _MSL_C99 || _MSL_C99_MATH_LEAK

_MSL_BEGIN_EXTERN_C

#if defined(__INTEL__)
	
	#define __EQUAL 0x4000
	#define __GREATERTHAN 0
	#define __LESSTHAN 0x0100
	#define __UNORDERED 0x4500

	#define isgreater(x, y) (!__msl_relation(x, y))
	#define isgreaterequal(x, y) (!((__msl_relation(x, y)>>8) & 1))
	#define isless(x, y) (__msl_relation(x, y) == __LESSTHAN)
	#define islessequal(x, y) ((__msl_relation(x, y)%__UNORDERED) != 0)
	#define islessgreater(x, y) (__msl_relation(x, y) <= __LESSTHAN)
	#define isunordered(x, y) (__msl_relation(x, y) == __UNORDERED)

#elif (_MSL_USES_SUN_MATH_LIB || __dest_os == __mac_os_x)

	short __msl_relation(double x, double y) _MSL_CANT_THROW;

	#define isgreater(x, y) (__msl_relation(x, y) == 0)
	#define isgreaterequal(x, y) (__msl_relation(x, y) % 2 == 0)
	#define isless(x, y) (__msl_relation(x, y) == 1)
	#define islessequal(x, y) ((__msl_relation(x, y)+1)/2 == 1)
	#define islessgreater(x, y) (__msl_relation(x, y) <= 1)
	#define isunordered(x, y) (__msl_relation(x, y) == 3)
	
#endif /* __INTEL__ */ /*- P74451.c Execution passed -*/

_MSL_END_EXTERN_C

#endif /* _MSL_C99 */

#ifndef _MSL_NO_MATH_LIB

/************************/
/*						*/
/* 	Standard functions	*/
/*						*/
/************************/

_MSL_BEGIN_NAMESPACE_STD
_MSL_BEGIN_EXTERN_C


	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL fabs(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL fmod(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL sqrt(double) _MSL_CANT_THROW;

	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL acos(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL asin(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL atan(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL atan2(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL ceil(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL cos(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL cosh(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL exp(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL floor(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL frexp(double, int*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL ldexp(double, int) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log10(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL modf(double, double*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL pow(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL sin(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL sinh(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL tan(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL tanh(double) _MSL_CANT_THROW;
	
#if _MSL_C99 || _MSL_USES_SUN_MATH_LIB
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL copysign(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL expm1(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL rint(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL scalbn(double, int) _MSL_CANT_THROW;
#endif
	
#if _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL acosf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL acosl(long double) _MSL_CANT_THROW;	
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL asinf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL asinl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL atanf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL atanl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL atan2f(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL atan2l(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL ceilf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL ceill(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL cosf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL cosl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL coshf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL coshl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL expf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL expl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fabsf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fabsl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL floorf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL floorl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fmodf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fmodl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL frexpf(float, int*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL frexpl(long double, int*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL ldexpf(float, int) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL ldexpl(long double, int) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL logf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL logl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL log10f(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL log10l(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL modff(float, float*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL modfl(long double, long double*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL powf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL powl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL sinf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL sinl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL sinhf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL sinhl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL sqrtf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL sqrtl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL tanf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL tanl(long double) _MSL_CANT_THROW;	
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL tanhf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL tanhl(long double) _MSL_CANT_THROW;
#endif /* _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS */

#if _MSL_C99 || _MSL_C99_MATH_LEAK		
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL acosh(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL acoshf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL acoshl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL asinh(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL asinhf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL asinhl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL atanh(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL atanhf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL atanhl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL cbrt(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL cbrtf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL cbrtl(long double) _MSL_CANT_THROW;	
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL copysignf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL copysignl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL erf(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL erff(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL erfl(long double) _MSL_CANT_THROW;	
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL erfc(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL erfcf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL erfcl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL exp2(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL exp2f(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL exp2l(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL expm1f(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL expm1l(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL fdim(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fdimf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fdiml(long double, long double) _MSL_CANT_THROW;
	
	_MSL_INLINE _MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fmal(long double, long double, long double) _MSL_CANT_THROW;
	
	#if __has_intrinsic(__builtin_fma)
		#define FAST_FMA 1
		#define FAST_FMAL 1
		
		_MSL_INLINE _MSL_IMP_EXP_C double _MSL_MATH_CDECL fma(double, double, double) _MSL_CANT_THROW;
		_MSL_INLINE _MSL_IMP_EXP_C double _MSL_MATH_CDECL fma(double x, double y, double z) _MSL_CANT_THROW
		{
			return __builtin_fma(x, y, z);
		}
	#else
		_MSL_IMP_EXP_C double _MSL_MATH_CDECL fma(double, double, double) _MSL_CANT_THROW;
	#endif /* __has_intrinsic(__builtin_fma) */
	
	#if __has_intrinsic(__builtin_fmaf)
		#define FAST_FMAF 1
		
		_MSL_INLINE _MSL_IMP_EXP_C float _MSL_MATH_CDECL fmaf(float, float, float) _MSL_CANT_THROW;
		_MSL_INLINE _MSL_IMP_EXP_C float _MSL_MATH_CDECL fmaf(float x, float y, float z) _MSL_CANT_THROW
		{
			return __builtin_fmaf(x, y, z);
		}
	#else
		_MSL_IMP_EXP_C float _MSL_MATH_CDECL fmaf(float, float, float) _MSL_CANT_THROW;
	#endif /* __has_intrinsic(__builtin_fmaf) */
	
	_MSL_INLINE _MSL_IMP_EXP_C long double _MSL_MATH_CDECL fmal(long double x, long double y, long double z) _MSL_CANT_THROW
	{
		return fma((double) x, (double) y, (double) z);
	}

	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL fmax(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fmaxf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fmaxl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL fmin(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL fminf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL fminl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL hypot(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL hypotf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL hypotl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  int         _MSL_MATH_CDECL ilogb(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  int         _MSL_MATH_CDECL ilogbf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  int         _MSL_MATH_CDECL ilogbl(long double) _MSL_CANT_THROW;	
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL lgamma(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL lgammaf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL lgammal(long double) _MSL_CANT_THROW;		
	#if _MSL_LONGLONG
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llrint(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llrintf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llrintl(long double) _MSL_CANT_THROW;	
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llround(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llroundf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long long   _MSL_MATH_CDECL llroundl(long double) _MSL_CANT_THROW;
	#endif /* _MSL_LONGLONG */
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log1p(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL log1pf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL log1pl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log2(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL log2f(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL log2l(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL logb(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL logbf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL logbl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long        _MSL_MATH_CDECL lrint(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long        _MSL_MATH_CDECL lrintf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long        _MSL_MATH_CDECL lrintl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long        _MSL_MATH_CDECL lround(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long        _MSL_MATH_CDECL lroundf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long        _MSL_MATH_CDECL lroundl(long double) _MSL_CANT_THROW;	
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nan(const char*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL nanf(const char*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL nanl(const char*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nearbyint(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL nearbyintf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL nearbyintl(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nextafter(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL nextafterf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL nextafterl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nexttoward(double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL nexttowardf(float, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL nexttowardl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL remainder(double, double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL remainderf(float, float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL remainderl(long double, long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL remquo(double, double, int*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL remquof(float, float, int*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL remquol(long double, long double, int*) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL rintf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL rintl(long double) _MSL_CANT_THROW;	

	#if __has_intrinsic(__builtin_round)
		_MSL_INLINE _MSL_IMP_EXP_C  short      _MSL_MATH_CDECL round(long) _MSL_CANT_THROW;
	#else
		_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL round(double) _MSL_CANT_THROW;
	#endif /* __has_intrinsic(__builtin_round) */
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL roundf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL roundl(long double) _MSL_CANT_THROW;
	_MSL_INLINE double scalbln(double x, long int n)
			{return ldexp(x, (int)n);}
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL scalblnf(float, long int) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL scalblnl(long double, long int) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL scalbn(double, int);
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL scalbnf(float, int) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL scalbnl(long double, int) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL tgamma(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL tgammaf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL tgammal(long double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL trunc(double) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  float       _MSL_MATH_CDECL truncf(float) _MSL_CANT_THROW;
	_MSL_IMP_EXP_C  long double _MSL_MATH_CDECL truncl(long double) _MSL_CANT_THROW;
#endif /* _MSL_C99 */

	#undef _MSL_USING

_MSL_END_EXTERN_C
_MSL_END_NAMESPACE_STD

#ifdef __cplusplus	/* C++ overloads, as per 26.5 */

	#ifdef __ANSI_OVERLOAD__

	_MSL_BEGIN_NAMESPACE_STD
	
    #if !__COLDFIRE_HW_FPU__
    	
    	#if _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS			
    	__inline  float       _MSL_MATH_CDECL fabs(float f) _MSL_CANT_THROW { return (fabsf)(f); };
    	__inline  long double _MSL_MATH_CDECL fabs(long double f) _MSL_CANT_THROW { return (fabsl)(f); };
    	__inline  float       _MSL_MATH_CDECL fmod(float f, float g) _MSL_CANT_THROW { return (fmodf)(f,g); };
    	__inline  long double _MSL_MATH_CDECL fmod(long double f, long double g) _MSL_CANT_THROW { return (fmodl)(f,g); };
    	__inline  float       _MSL_MATH_CDECL sqrt(float f) _MSL_CANT_THROW { return (sqrtf)(f); };
    	__inline  long double _MSL_MATH_CDECL sqrt(long double f) _MSL_CANT_THROW { return (sqrtl)(f); };
        #endif
 
    #else
	
    	#if _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS			
        /*
        	float fabs(float x)
        	replaces s_fabs.c
        */

        _MSL_INLINE asm float fabs(float x:__FP0)
        {
        	fabs.s fp0
        }

        /*
        	float fabs(float x)
        	replaces s_fabs.c
        */

        _MSL_INLINE asm long double fabs(long double x:__FP0)
        {
        	fabs.d fp0
        }

        /*
        	float sqrt(float x)
        	replaces e_sqrt.c/w_sqrt.c
        */

        _MSL_INLINE asm float sqrt(float x:__FP0)
        {
        	fsqrt.s fp0
        }

        /*
        	long double sqrt(long double x)
        	replaces e_sqrt.c/w_sqrt.c
        */

        _MSL_INLINE asm long double sqrt(long double x:__FP0)
        {
        	fsqrt.d fp0
        }

        /*
        	double fmod(double x, double y)
        	replaces e_fmod.c/w_fmod.c
        */

        _MSL_INLINE asm float fmod(float x:__FP0, float y:__FP1)
        {
    		fmove.d 	fp2,-(sp)
    		fmove.d 	fp0,fp2
    		fdiv.d		fp1,fp0
    		fintrz.d	fp2
    		fmul.d		fp1,fp2
    		fsub.d		fp2,fp0
    		fmove.d 	fp2,(sp)+
        }
        /*
        	float fmod(float x, float y)
        	replaces e_fmod.c/w_fmod.c
        */

        _MSL_INLINE asm long double fmod(long double x:__FP0, long double y:__FP1)
        {
    		fmove.d 	fp2,-(sp)
    		fmove.d 	fp0,fp2
    		fdiv.d		fp1,fp0
    		fintrz.d	fp2
    		fmul.d		fp1,fp2
    		fsub.d		fp2,fp0
    		fmove.d 	fp2,(sp)+
        }

        #endif
    #endif

	#if _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS			
		__inline float _MSL_MATH_CDECL
			acos(float x) _MSL_CANT_THROW  { return (acosf)((x)); }			
		__inline long double _MSL_MATH_CDECL
			acos(long double x) _MSL_CANT_THROW  { return (acosl)((x)); }
		__inline float _MSL_MATH_CDECL
			asin(float x) _MSL_CANT_THROW  { return (asinf)((x)); }
		__inline long double _MSL_MATH_CDECL
			asin(long double x) _MSL_CANT_THROW  { return (asinl)((x)); }			
		__inline float _MSL_MATH_CDECL
			atan(float x) _MSL_CANT_THROW  { return (atanf)((x)); }
		__inline long double _MSL_MATH_CDECL
			atan(long double x) _MSL_CANT_THROW  { return (atanl)((x)); }	
		__inline float _MSL_MATH_CDECL
			atan2(float y, float x) _MSL_CANT_THROW  { return (atan2f)((y), (x)); }
		__inline long double _MSL_MATH_CDECL
			atan2(long double y, long double x) _MSL_CANT_THROW  { return (atan2l)((y), (x)); }	\
		__inline float _MSL_MATH_CDECL
			ceil(float x) _MSL_CANT_THROW  { return (ceilf)((x)); }
		__inline long double _MSL_MATH_CDECL
			ceil(long double x) _MSL_CANT_THROW  { return (ceill)((x)); }	
		__inline float _MSL_MATH_CDECL
			cos(float x) _MSL_CANT_THROW  { return (cosf)((x)); }
		__inline long double _MSL_MATH_CDECL
			cos(long double x) _MSL_CANT_THROW  { return (cosl)((x)); }									
		__inline float _MSL_MATH_CDECL
			cosh(float x) _MSL_CANT_THROW  { return (coshf)((x)); }
		__inline long double _MSL_MATH_CDECL
			cosh(long double x) _MSL_CANT_THROW  { return (coshl)((x)); }
		__inline float _MSL_MATH_CDECL
			exp(float x) _MSL_CANT_THROW  { return (expf)((x)); }
		__inline long double _MSL_MATH_CDECL
			exp(long double x) _MSL_CANT_THROW  { return (expl)((x)); }
		__inline float _MSL_MATH_CDECL
			floor(float x) _MSL_CANT_THROW  { return (floorf)((x)); }
		__inline long double _MSL_MATH_CDECL
			floor(long double x) _MSL_CANT_THROW  { return (floorl)((x)); }	
		__inline float _MSL_MATH_CDECL
			frexp(float x, int* y) _MSL_CANT_THROW  { return (frexpf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			frexp(long double x, int* y) _MSL_CANT_THROW  { return (frexpl)((x), (y)); }	
		__inline float _MSL_MATH_CDECL
			ldexp(float x, int y) _MSL_CANT_THROW  { return (ldexpf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			ldexp(long double x, int y) _MSL_CANT_THROW  { return (ldexpl)((x), (y)); }	
		__inline float _MSL_MATH_CDECL
			log(float x) _MSL_CANT_THROW  { return (logf)((x)); }
		__inline long double _MSL_MATH_CDECL
			log(long double x) _MSL_CANT_THROW  { return (logl)((x)); }
		__inline float _MSL_MATH_CDECL
			log10(float x) _MSL_CANT_THROW  { return (log10f)((x)); }
		__inline long double _MSL_MATH_CDECL
			log10(long double x) _MSL_CANT_THROW  { return (log10l)((x)); }					
		__inline long double _MSL_MATH_CDECL
			modf(long double x, long double* iptr) _MSL_CANT_THROW {
		  double iptrd;
		  long double result = (long double)modf((double)x, &iptrd);
		  *iptr = (long double)iptrd;
		  return result;
		}
		
		__inline float _MSL_MATH_CDECL
			modf(float x, float* iptr) _MSL_CANT_THROW {
		  double iptrd;
		  float result = (float)modf((double)x, &iptrd);
		  *iptr = (float)iptrd;
		  return result;
		}					
			
		__inline float _MSL_MATH_CDECL
			pow(float x, float y) _MSL_CANT_THROW  { return (powf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			pow(long double x, long double y) _MSL_CANT_THROW  { return (powl)((x), (y)); }	
		__inline float _MSL_MATH_CDECL
			sin(float x) _MSL_CANT_THROW  { return (sinf)((x)); }
		__inline long double _MSL_MATH_CDECL
			sin(long double x) _MSL_CANT_THROW  { return (sinl)((x)); }
		__inline float _MSL_MATH_CDECL
			sinh(float x) _MSL_CANT_THROW  { return (sinhf)((x)); }
		__inline long double _MSL_MATH_CDECL
			sinh(long double x) _MSL_CANT_THROW  { return (sinhl)((x)); }
		__inline float _MSL_MATH_CDECL
			tan(float x) _MSL_CANT_THROW  { return (tanf)((x)); }
		__inline long double _MSL_MATH_CDECL
			tan(long double x) _MSL_CANT_THROW  { return (tanl)((x)); }
		__inline float _MSL_MATH_CDECL
			tanh(float x) _MSL_CANT_THROW  { return (tanhf)((x)); }
		__inline long double _MSL_MATH_CDECL
			tanh(long double x) _MSL_CANT_THROW  { return (tanhl)((x)); }
	#endif /* _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS */
				
	#if _MSL_C99 || _MSL_C99_MATH_LEAK			
		__inline float _MSL_MATH_CDECL
			acosh(float x) _MSL_CANT_THROW  { return (acoshf)((x)); }
		__inline long double _MSL_MATH_CDECL
			acosh(long double x) _MSL_CANT_THROW  { return (acoshl)((x)); }
		__inline float _MSL_MATH_CDECL
			asinh(float x) _MSL_CANT_THROW  { return (asinhf)((x)); }
		__inline long double _MSL_MATH_CDECL
			asinh(long double x) _MSL_CANT_THROW  { return (asinhl)((x)); }
		__inline float _MSL_MATH_CDECL
			atanh(float x) _MSL_CANT_THROW  { return (atanhf)((x)); }
		__inline long double _MSL_MATH_CDECL
			atanh(long double x) _MSL_CANT_THROW  { return (atanhl)((x)); }
		__inline float _MSL_MATH_CDECL
			cbrt(float x) _MSL_CANT_THROW  { return (cbrtf)((x)); }
		__inline long double _MSL_MATH_CDECL
			cbrt(long double x) _MSL_CANT_THROW  { return (cbrtl)((x)); }
		__inline long double _MSL_MATH_CDECL
			copysign(long double x, long double y) _MSL_CANT_THROW  { return (copysignl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			copysign(float x,float y) _MSL_CANT_THROW  { return (copysignf)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			erf(float x) _MSL_CANT_THROW  { return (erff)((x)); }
		__inline long double _MSL_MATH_CDECL
			erf(long double x) _MSL_CANT_THROW  { return (erfl)((x)); }
		__inline float _MSL_MATH_CDECL
			erfc(float x) _MSL_CANT_THROW  { return (erfcf)((x)); }
		__inline long double _MSL_MATH_CDECL
			erfc(long double x) _MSL_CANT_THROW  { return (erfcl)((x)); }
		__inline float _MSL_MATH_CDECL
			exp2(float x) _MSL_CANT_THROW  { return (exp2f)((x)); }
		__inline long double _MSL_MATH_CDECL
			exp2(long double x) _MSL_CANT_THROW  { return (exp2l)((x)); }
		__inline float _MSL_MATH_CDECL
			expm1(float x) _MSL_CANT_THROW  { return (expm1f)((x)); }
		__inline long double _MSL_MATH_CDECL
			expm1(long double x) _MSL_CANT_THROW  { return (expm1l)((x)); }
		__inline float _MSL_MATH_CDECL
			fdim(float x, float y) _MSL_CANT_THROW  { return (fdimf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			fdim(long double x, long double y) _MSL_CANT_THROW  { return (fdiml)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			fma(float x, float y, float z) _MSL_CANT_THROW  { return (fmaf)((x), (y), (z)); }
		__inline long double _MSL_MATH_CDECL
			fma(long double x, long double y, long double z) _MSL_CANT_THROW  { return (fmal)((x), (y), (z)); }
		__inline float _MSL_MATH_CDECL
			fmax(float x, float y) _MSL_CANT_THROW  { return (fmaxf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			fmax(long double x, long double y) _MSL_CANT_THROW  { return (fmaxl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			fmin(float x, float y) _MSL_CANT_THROW  { return (fminf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			fmin(long double x, long double y) _MSL_CANT_THROW  { return (fminl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			hypot(float x, float y) _MSL_CANT_THROW  { return (hypotf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			hypot(long double x, long double y) _MSL_CANT_THROW  { return (hypotl)((x), (y)); }
		__inline int _MSL_MATH_CDECL
			ilogb(float x) _MSL_CANT_THROW  { return (ilogbf)((x)); }
		__inline int _MSL_MATH_CDECL
			ilogb(long double x) _MSL_CANT_THROW  { return (ilogbl)((x)); }
		__inline float _MSL_MATH_CDECL
			lgamma(float x) _MSL_CANT_THROW  { return (lgammaf)((x)); }
		__inline long double _MSL_MATH_CDECL
			lgamma(long double x) _MSL_CANT_THROW  { return (lgammal)((x)); }
		#if _MSL_LONGLONG
		__inline long long _MSL_MATH_CDECL
			llrint(float x) _MSL_CANT_THROW  { return (llrintf)((x)); }
		__inline long long _MSL_MATH_CDECL
			llrint(long double x) _MSL_CANT_THROW  { return (llrintl)((x)); }
		__inline long long _MSL_MATH_CDECL
			llround(float x) _MSL_CANT_THROW  { return (llroundf)((x)); }
		__inline long long _MSL_MATH_CDECL
			llround(long double x) _MSL_CANT_THROW  { return (llroundl)((x)); }
		#endif /* _MSL_LONGLONG */
		__inline float _MSL_MATH_CDECL
			log1p(float x) _MSL_CANT_THROW  { return (log1pf)((x)); }
		__inline long double _MSL_MATH_CDECL
			log1p(long double x) _MSL_CANT_THROW  { return (log1pl)((x)); }
		__inline float _MSL_MATH_CDECL
			log2(float x) _MSL_CANT_THROW  { return (log2f)((x)); }
		__inline long double _MSL_MATH_CDECL
			log2(long double x) _MSL_CANT_THROW  { return (log2l)((x)); }
		__inline float _MSL_MATH_CDECL
			logb(float x) _MSL_CANT_THROW  { return (logbf)((x)); }
		__inline long double _MSL_MATH_CDECL
			logb(long double x) _MSL_CANT_THROW  { return (logbl)((x)); }
		__inline long _MSL_MATH_CDECL
			lrint(float x) _MSL_CANT_THROW  { return (lrintf)((x)); }
		__inline long _MSL_MATH_CDECL
			lrint(long double x) _MSL_CANT_THROW  { return (lrintl)((x)); }
		__inline long _MSL_MATH_CDECL
			lround(float x) _MSL_CANT_THROW  { return (lroundf)((x)); }
		__inline long _MSL_MATH_CDECL
			lround(long double x) _MSL_CANT_THROW  { return (lroundl)((x)); }
		__inline float _MSL_MATH_CDECL
			nearbyint(float x) _MSL_CANT_THROW  { return (nearbyintf)((x)); }
		__inline long double _MSL_MATH_CDECL
			nearbyint(long double x) _MSL_CANT_THROW  { return (nearbyintl)((x)); }
		__inline float _MSL_MATH_CDECL
			nextafter(float x, float y) _MSL_CANT_THROW  { return (nextafterf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			nextafter(long double x, long double y) _MSL_CANT_THROW  { return (nextafterl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			nexttoward(float x, long double y) _MSL_CANT_THROW  { return (nexttowardf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			nexttoward(long double x, long double y) _MSL_CANT_THROW  { return (nexttowardl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			remainder(float x, float y) _MSL_CANT_THROW  { return (remainderf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			remainder(long double x, long double y) _MSL_CANT_THROW  { return (remainderl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			remquo(float x, float y, int* z) _MSL_CANT_THROW  { return (remquof)((x), (y), (z)); }
		__inline long double _MSL_MATH_CDECL
			remquo(long double x, long double y, int* z) _MSL_CANT_THROW  { return (remquol)((x), (y), (z)); }
		__inline float _MSL_MATH_CDECL
			rint(float x) _MSL_CANT_THROW  { return (rintf)((x)); }
		__inline long double _MSL_MATH_CDECL
			rint(long double x) _MSL_CANT_THROW  { return (rintl)((x)); }
		__inline float _MSL_MATH_CDECL
			round(float x) _MSL_CANT_THROW  { return (roundf)((x)); }
		__inline long double _MSL_MATH_CDECL
			round(long double x) _MSL_CANT_THROW  { return (roundl)((x)); }
		__inline float _MSL_MATH_CDECL
			scalbln(float x, long int y) _MSL_CANT_THROW  { return (scalblnf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			scalbln(long double x, long int y) _MSL_CANT_THROW  { return (scalblnl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			scalbn(float x, int y) _MSL_CANT_THROW  { return (scalbnf)((x), (y)); }
		__inline long double _MSL_MATH_CDECL
			scalbn(long double x, int y) _MSL_CANT_THROW  { return (scalbnl)((x), (y)); }
		__inline float _MSL_MATH_CDECL
			tgamma(float x) _MSL_CANT_THROW  { return (tgammaf)((x)); }
		__inline long double _MSL_MATH_CDECL
			tgamma(long double x) _MSL_CANT_THROW  { return (tgammal)((x)); }
		__inline float _MSL_MATH_CDECL
			trunc(float x) _MSL_CANT_THROW  { return (truncf)((x)); }
		__inline long double _MSL_MATH_CDECL
			trunc(long double x) _MSL_CANT_THROW  { return (truncl)((x)); }
	#endif /* _MSL_C99 */
	
_MSL_END_NAMESPACE_STD

	#endif /*__ANSI_OVERLOAD__*/

	#ifdef _MSL_INTEGRAL_MATH
		#include "math_integral.h"
	#endif /* _MSL_INTEGRAL_MATH */

	#ifdef __ANSI_OVERLOAD__

	_MSL_BEGIN_NAMESPACE_STD

		/* special pow() overloads */
		__inline float _MSL_MATH_CDECL
		pow(float x, int y)  _MSL_CANT_THROW { return (powf)((x), (float)(y)); }
		__inline double _MSL_MATH_CDECL
		pow(double x, int y)  _MSL_CANT_THROW { return (pow)((x), (double)(y)); }
		__inline long double _MSL_MATH_CDECL
		pow(long double x, int y)  _MSL_CANT_THROW { return (powl)((x), (long double)(y)); }

		/* special abs() functions */
		__inline float _MSL_MATH_CDECL
		abs(float x) _MSL_CANT_THROW { return (fabsf)((x)); }
		__inline double _MSL_MATH_CDECL
		abs(double x) _MSL_CANT_THROW { return (fabs)((x)); }
		__inline long double _MSL_MATH_CDECL
		abs(long double x) _MSL_CANT_THROW { return (fabsl)((x)); }
		
	_MSL_END_NAMESPACE_STD

	#endif /*__ANSI_OVERLOAD__*/

#endif /*__cplusplus*/

/*	Include target math functions */
#include <math_config.h>

#endif /* _MSL_NO_MATH_LIB */

#endif /* _MSL_CMATH_DSP_56800 */

/* Change record:
 * cc  020805 Added dolphin cmath header
 * JWW 030224 Changed __MSL_LONGLONG_SUPPORT__ flag into the new more configurable _MSL_LONGLONG
 * cc  031106 Removed unneeded dest_os checks and if 0 checks
 */