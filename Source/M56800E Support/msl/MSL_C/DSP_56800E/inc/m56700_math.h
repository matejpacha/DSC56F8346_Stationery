/* MSL
 * Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2011/05/02 10:25:39 $
 * $Revision: 1.19 $
 */

#ifndef _MSL_MATH_m56700_H
#define _MSL_MATH_m56700_H

#ifndef _MSL_CMATH
#error This header may only be included from <cmath>
#endif

#define __SET_ERRNO__
#ifdef __SET_ERRNO__
	#include <cerrno>
#endif

/* 	FLT_EVAL_METHOD represents the internal precision and range of
	operations using the float and double types.  For method 0,
	operations are performed just to the precision/range of the
	given floating point type.  For method 1, float and double
	operations are performed in double precision/range, and long
	double operations are performed in long double precision/range.
	For method 2, all floating operations are performed in long
	double precision/range.  Method -1 is indeterminable, which I take
	to mean inconsistent, given the specific code compiled. */

#define FLT_EVAL_METHOD  _MSL_FLT_EVAL_METHOD

_MSL_BEGIN_NAMESPACE_STD

	typedef float float_t;
	typedef double double_t;

_MSL_END_NAMESPACE_STD

_MSL_BEGIN_EXTERN_C

	/* private functions */

	_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL gamma(double);

_MSL_END_EXTERN_C

_MSL_BEGIN_NAMESPACE_STD
_MSL_BEGIN_EXTERN_C

/* Added Single_precision functions support */
#define _MSL_USES_SUN_SP_MATH_LIB 	1	/* fdlibm.h: single precision ieee style elementary functions declarations. */

	#if _MSL_USE_INLINE

#if _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS
#if _MSL_LONGLONG == 0 /* Added Single_precision functions support */
	_MSL_INLINE double _MSL_MATH_CDECL
		acos(double x) _MSL_CANT_THROW { return (double)(acosf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		asin(double x) _MSL_CANT_THROW { return (double)(asinf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		atan(double x) _MSL_CANT_THROW { return (double)(atanf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		atan2(double y, double x) _MSL_CANT_THROW { return (double)(atan2f)((float)(y), (float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		ceil(double x) _MSL_CANT_THROW { return (double)(ceilf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		cos(double x) _MSL_CANT_THROW { return (double)(cosf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		cosh(double x) _MSL_CANT_THROW { return (double)(coshf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		floor(double x) _MSL_CANT_THROW { return (double)(floorf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		fmod(double x, double y) _MSL_CANT_THROW { return (double)(fmodf)((float)(x), (float)(y)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		sin(double x) _MSL_CANT_THROW { return (double)(sinf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		sinh(double x) _MSL_CANT_THROW { return (double)(sinhf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		sqrt(double x) _MSL_CANT_THROW { return (double)(sqrtf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		tan(double x) _MSL_CANT_THROW { return (double)(tanf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		tanh(double x) _MSL_CANT_THROW { return (double)(tanhf)((float)(x)); }
#else
	_MSL_INLINE float _MSL_MATH_CDECL
		acosf(float x) _MSL_CANT_THROW { return (float)(acos)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		asinf(float x) _MSL_CANT_THROW { return (float)(asin)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		atanf(float x) _MSL_CANT_THROW { return (float)(atan)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		atan2f(float y, float x) _MSL_CANT_THROW { return (float)(atan2)((double)(y), (double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		ceilf(float x) _MSL_CANT_THROW { return (float)(ceil)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		cosf(float x) _MSL_CANT_THROW { return (float)(cos)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		coshf(float x) _MSL_CANT_THROW { return (float)(cosh)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		floorf(float x) _MSL_CANT_THROW { return (float)(floor)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		fmodf(float x, float y) _MSL_CANT_THROW { return (float)(fmod)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		sinf(float x) _MSL_CANT_THROW { return (float)(sin)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		sinhf(float x) _MSL_CANT_THROW { return (float)(sinh)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		sqrtf(float x) _MSL_CANT_THROW { return (float)(sqrt)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		tanf(float x) _MSL_CANT_THROW { return (float)(tan)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		tanhf(float x) _MSL_CANT_THROW { return (float)(tanh)((double)(x)); }
#endif /* #if _MSL_LONGLONG == 0 */
	_MSL_INLINE long double _MSL_MATH_CDECL
		acosl(long double x) _MSL_CANT_THROW { return (long double)(acos)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		asinl(long double x) _MSL_CANT_THROW { return (long double)(asin)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		atanl(long double x) _MSL_CANT_THROW { return (long double)(atan)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		atan2l(long double y, long double x) _MSL_CANT_THROW { return (long double)(atan2)((double)(y), (double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		ceill(long double x) _MSL_CANT_THROW { return (long double)(ceil)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		cosl(long double x) _MSL_CANT_THROW { return (long double)(cos)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		coshl(long double x) _MSL_CANT_THROW { return (long double)(cosh)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		expf(float x) _MSL_CANT_THROW { return (float)(exp)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		expl(long double x) _MSL_CANT_THROW { return (long double)(exp)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		fabsf(float x) _MSL_CANT_THROW { return (float)(fabs)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		fabsl(long double x) _MSL_CANT_THROW { return (long double)(fabs)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		floorl(long double x) _MSL_CANT_THROW { return (long double)(floor)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		fmodl(long double x, long double y) _MSL_CANT_THROW { return (long double)(fmod)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		frexpf(float x, int* y) _MSL_CANT_THROW { return (float)(frexp)((double)(x), (y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		frexpl(long double x, int* y) _MSL_CANT_THROW { return (long double)(frexp)((double)(x), (y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		ldexpf(float x, int y) _MSL_CANT_THROW { return (float)(ldexp)((double)(x), (y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		ldexpl(long double x, int y) _MSL_CANT_THROW { return (long double)(ldexp)((double)(x), (y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		logf(float x) _MSL_CANT_THROW { return (float)(log)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		logl(long double x) _MSL_CANT_THROW { return (long double)(log)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		log10f(float x) _MSL_CANT_THROW { return (float)(log10)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		log10l(long double x) _MSL_CANT_THROW { return (long double)(log10)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		modff(float x, float* iptr) _MSL_CANT_THROW {
		  double iptrd;
		  float result = (float)modf((double)x, &iptrd);
		  *iptr = (float)iptrd;
		  return result;
		}
	_MSL_INLINE long double _MSL_MATH_CDECL
		modfl(long double x, long double* iptr) _MSL_CANT_THROW {
		  double iptrd;
		  long double result = (long double)modf((double)x, &iptrd);
		  *iptr = (long double)iptrd;
		  return result;
		}
	_MSL_INLINE float _MSL_MATH_CDECL
		powf(float x, float y) _MSL_CANT_THROW { return (float)(pow)((double)(x), (double)(y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		powl(long double x, long double y) _MSL_CANT_THROW { return (long double)(pow)((double)(x), (double)(y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		sinl(long double x) _MSL_CANT_THROW { return (long double)(sin)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		sinhl(long double x) _MSL_CANT_THROW { return (long double)(sinh)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		sqrtl(long double x) _MSL_CANT_THROW { return (long double)(sqrt)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		tanl(long double x) _MSL_CANT_THROW { return (long double)(tan)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		tanhl(long double x) _MSL_CANT_THROW { return (long double)(tanh)((double)(x)); }


#endif /* _MSL_C99 || _MSL_C_HAS_CPP_EXTENSIONS */

#if _MSL_C99 || _MSL_C99_MATH_LEAK
#if _MSL_LONGLONG == 0 /* Added Single_precision functions support */
	_MSL_INLINE double _MSL_MATH_CDECL
		acosh(double x) _MSL_CANT_THROW { return (double)(acoshf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		asinh(double x) _MSL_CANT_THROW { return (double)(asinhf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		atanh(double x) _MSL_CANT_THROW { return (double)(atanhf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		cbrt(double x) { return (double)(cbrtf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		copysign(double x, double y) _MSL_CANT_THROW { return (double)(copysignf)((float)(x), (float)(y)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		expm1(double x) _MSL_CANT_THROW { return (double)(expm1f)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		fdim(double x, double y) _MSL_CANT_THROW { return (double)(fdimf)((float)(x), (float)(y)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		fmax(double x, double y) _MSL_CANT_THROW { return (double)(fmaxf)((float)(x), (float)(y)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		fmin(double x, double y) _MSL_CANT_THROW { return (double)(fminf)((float)(x), (float)(y)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		hypot(double x, double y) _MSL_CANT_THROW { return (double)(hypotf)((float)(x), (float)(y)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		log1p(double x) _MSL_CANT_THROW { return (double)(log1pf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		logb(double x) _MSL_CANT_THROW { return (double)(logbf)((float)(x)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		remainder(double x, double y) _MSL_CANT_THROW { return (double)(remainderf)((float)(x), (float)(y)); }
	_MSL_INLINE double _MSL_MATH_CDECL
		rint(double x) _MSL_CANT_THROW { return (double)(rintf)((float)(x)); }
#else
	_MSL_INLINE float _MSL_MATH_CDECL
		acoshf(float x) _MSL_CANT_THROW { return (float)(acosh)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		asinhf(float x) _MSL_CANT_THROW { return (float)(asinh)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		atanhf(float x) _MSL_CANT_THROW { return (float)(atanh)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		copysignf(float x, float y) _MSL_CANT_THROW { return (float)(copysign)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		expm1f(float x) _MSL_CANT_THROW { return (float)(expm1)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		fdimf(float x, float y) _MSL_CANT_THROW { return (float)(fdim)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		fmaxf(float x, float y) _MSL_CANT_THROW { return (float)(fmax)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		fminf(float x, float y) _MSL_CANT_THROW { return (float)(fmin)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		hypotf(float x, float y) _MSL_CANT_THROW { return (float)(hypot)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		log1pf(float x) _MSL_CANT_THROW { return (float)(log1p)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		logbf(float x) _MSL_CANT_THROW { return (float)(logb)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		remainderf(float x, float y) _MSL_CANT_THROW { return (float)(remainder)((double)(x), (double)(y)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		rintf(float x) _MSL_CANT_THROW { return (float)(rint)((double)(x)); }
#endif /* #if _MSL_LONGLONG == 0 */
	_MSL_INLINE long double _MSL_MATH_CDECL
		acoshl(long double x) _MSL_CANT_THROW { return (long double)(acosh)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		asinhl(long double x) _MSL_CANT_THROW { return (long double)(asinh)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		atanhl(long double x) _MSL_CANT_THROW { return (long double)(atanh)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		cbrtl(long double x) { return (long double)(cbrt)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		copysignl(long double x, long double y) _MSL_CANT_THROW { return (long double)(copysign)((double)(x), (double)(y)); }
#if !__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C
	_MSL_INLINE float _MSL_MATH_CDECL
		erfcf(float x) _MSL_CANT_THROW { return (float)(erfc)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		erfcl(long double x) _MSL_CANT_THROW { return (long double)(erfc)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		erff(float x) _MSL_CANT_THROW { return (float)(erf)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		erfl(long double x) _MSL_CANT_THROW { return (long double)(erf)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		exp2f(float x) _MSL_CANT_THROW { return (float)(exp2)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		exp2l(long double x) _MSL_CANT_THROW { return (long double)(exp2)((double)(x)); }
#endif	/*!__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C*/
	_MSL_INLINE long double _MSL_MATH_CDECL
		expm1l(long double x) _MSL_CANT_THROW { return (long double)(expm1)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		fdiml(long double x, long double y) _MSL_CANT_THROW { return (long double)(fdim)((double)(x), (double)(y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		fmaxl(long double x, long double y) _MSL_CANT_THROW { return (long double)(fmax)((double)(x), (double)(y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		fminl(long double x, long double y) _MSL_CANT_THROW { return (long double)(fmin)((double)(x), (double)(y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		hypotl(long double x, long double y) _MSL_CANT_THROW { return (long double)(hypot)((double)(x), (double)(y)); }
#if _MSL_USES_SUN_MATH_LIB
#if _MSL_LONGLONG == 0 /* Added Single_precision functions support */
	_MSL_INLINE int _MSL_MATH_CDECL
		ilogb(double x) { return (ilogbf)((float)(x)); }
#else
	_MSL_INLINE int _MSL_MATH_CDECL
		ilogbf(float x) { return (ilogb)((double)(x)); }
#endif /* #if _MSL_LONGLONG == 0 */
	_MSL_INLINE int _MSL_MATH_CDECL
		ilogbl(long double x) { return (ilogb)((double)(x)); }
#endif /* _MSL_USES_SUN_MATH_LIB */


#if !__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C
	_MSL_INLINE float _MSL_MATH_CDECL
		lgammaf(float x) _MSL_CANT_THROW { return (float)(lgamma)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		lgammal(long double x) _MSL_CANT_THROW { return (long double)(lgamma)((double)(x)); }
#endif	/*!__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C*/
#if _MSL_LONGLONG
	_MSL_INLINE long long _MSL_MATH_CDECL
		llrintf(float x) _MSL_CANT_THROW { return (llrint)((double)(x)); }
	_MSL_INLINE long long _MSL_MATH_CDECL
		llrintl(long double x) _MSL_CANT_THROW { return (llrint)((double)(x)); }
#endif /* _MSL_LONGLONG */
#if _MSL_LONGLONG && !_MSL_USES_SUN_MATH_LIB
	_MSL_INLINE long long _MSL_MATH_CDECL
		llroundf(float x) _MSL_CANT_THROW { return (llround)((double)(x)); }
	_MSL_INLINE long long _MSL_MATH_CDECL
		llroundl(long double x) _MSL_CANT_THROW { return (llround)((double)(x)); }
#endif /* _MSL_LONGLONG && !_MSL_USES_SUN_MATH_LIB */
	_MSL_INLINE long double _MSL_MATH_CDECL
		log1pl(long double x) _MSL_CANT_THROW { return (long double)(log1p)((double)(x)); }
	_MSL_INLINE float _MSL_MATH_CDECL
		log2f(float x) _MSL_CANT_THROW { return (float)(log2)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		log2l(long double x) _MSL_CANT_THROW { return (long double)(log2)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		logbl(long double x) _MSL_CANT_THROW { return (long double)(logb)((double)(x)); }
#if !_MSL_USES_SUN_MATH_LIB
	_MSL_INLINE long _MSL_MATH_CDECL
		lrintf(float x) _MSL_CANT_THROW { return (lrint)((double)(x)); }
	_MSL_INLINE long _MSL_MATH_CDECL
		lrintl(long double x) _MSL_CANT_THROW { return (lrint)((double)(x)); }
	_MSL_INLINE long _MSL_MATH_CDECL
		lroundf(float x) _MSL_CANT_THROW { return (lround)((double)(x)); }
	_MSL_INLINE long _MSL_MATH_CDECL
		lroundl(long double x) _MSL_CANT_THROW { return (lround)((double)(x)); }
#endif /*!_MSL_USES_SUN_MATH_LIB*/
#if !__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C
	_MSL_INLINE float _MSL_MATH_CDECL
		nanf(const char* x) _MSL_CANT_THROW { return (float)(nan)((x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		nanl(const char* x) _MSL_CANT_THROW { return (long double)(nan)((x)); }
#endif	/*!__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C*/
#if !_MSL_USES_SUN_MATH_LIB
	_MSL_INLINE float _MSL_MATH_CDECL
		nearbyintf(float x) _MSL_CANT_THROW { return (float)(nearbyint)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		nearbyintl(long double x) _MSL_CANT_THROW { return (long double)(nearbyint)((double)(x)); }
#endif /*!_MSL_USES_SUN_MATH_LIB*/
#if !__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C
	_MSL_INLINE float _MSL_MATH_CDECL
		nextafterf(float x, float y) _MSL_CANT_THROW { return (float)(nextafter)((double)(x), (double)(y)); }
#endif	/*!__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C*/
	_MSL_INLINE long double _MSL_MATH_CDECL
		nextafterl(long double x, long double y) _MSL_CANT_THROW { return (long double)(nextafter)((double)(x), (double)(y)); }
#if !__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C
	_MSL_INLINE float _MSL_MATH_CDECL
		nexttowardf(float x, long double y) _MSL_CANT_THROW { return (float)(nexttoward)((double)(x), (y)); }
#endif	/*!__MSL__ < 0x00010000 && defined(_MSL_HAS_MATH_C) && !_MSL_HAS_MATH_C*/
	_MSL_INLINE long double _MSL_MATH_CDECL
		nexttowardl(long double x, long double y) _MSL_CANT_THROW { return (long double)(nexttoward)((double)(x), (y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		remainderl(long double x, long double y) _MSL_CANT_THROW { return (long double)(remainder)((double)(x), (double)(y)); }
#if !_MSL_USES_SUN_MATH_LIB
	_MSL_INLINE float _MSL_MATH_CDECL
		remquof(float x, float y, int* z) _MSL_CANT_THROW { return (float)(remquo)((double)(x), (double)(y), (z)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		remquol(long double x, long double y, int* z) _MSL_CANT_THROW { return (long double)(remquo)((double)(x), (double)(y), (z)); }
#endif /*!_MSL_USES_SUN_MATH_LIB*/
	_MSL_INLINE long double _MSL_MATH_CDECL
		rintl(long double x) _MSL_CANT_THROW { return (long double)(rint)((double)(x)); }
#if !_MSL_USES_SUN_MATH_LIB
	_MSL_INLINE float _MSL_MATH_CDECL
		roundf(float x) _MSL_CANT_THROW { return (float)(round)((double)(x)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		roundl(long double x) _MSL_CANT_THROW { return (long double)(round)((double)(x)); }
#endif /*!_MSL_USES_SUN_MATH_LIB*/
	_MSL_INLINE float _MSL_MATH_CDECL
		scalblnf(float x, long int y) _MSL_CANT_THROW { return (float)(scalbln)((double)(x), (y)); }
	_MSL_INLINE long double _MSL_MATH_CDECL
		scalblnl(long double x, long int y) _MSL_CANT_THROW { return (long double)(scalbln)((double)(x), (y)); }
		_MSL_INLINE float _MSL_MATH_CDECL
		scalbnf(float x, int y) _MSL_CANT_THROW { return (float)(scalbn)((double)(x), (y)); }
#if !_MSL_USES_SUN_MATH_LIB
		_MSL_INLINE long double _MSL_MATH_CDECL
		scalbnl(long double x, int y) _MSL_CANT_THROW { return (long double)(scalbn)((double)(x), (y)); }
		_MSL_INLINE float _MSL_MATH_CDECL
	truncf(float x) _MSL_CANT_THROW { return (float)(trunc)((double)(x)); }
		_MSL_INLINE long double _MSL_MATH_CDECL
	truncl(long double x) _MSL_CANT_THROW { return (long double)(trunc)((double)(x)); }
#endif /*!_MSL_USES_SUN_MATH_LIB*/
#endif /*_MSL_C99*/


	#endif /* _MSL_USE_INLINE */

_MSL_END_EXTERN_C
_MSL_END_NAMESPACE_STD

#endif /* _MSL_MATH_m56700_H */

/* Change record:
 * cc  020805 Added typedefs for float_t and double_t
 * cc  020819 Added define for nan
 * cc  020904 Made math.h for dsp a standard templ. and modified for dsp
 * JWW 030224 Changed __MSL_LONGLONG_SUPPORT__ flag into the new more configurable _MSL_LONGLONG
 * cc  031106 Removed unneeded dest_os checks and if 0 checks
 */