/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:08:46 $
 * $Revision: 1.8 $
 */

/*	force definitions to be generated */
#undef _MSL_USE_INLINE
#undef _MSL_INLINE
#undef _MSL_MATH_CDECL

#define _MSL_USE_INLINE 	1
#define _MSL_INLINE 		_MSL_IMP_EXP_C __declspec(weak)

/*	special calling convention for math lib? */
#define _MSL_MATH_CDECL 	_MSL_CDECL

/*	pragmas to control codegen for this library? */

/*	include header and instantiate _MSL_INLINEs as functions */
#include <cmath>

_MSL_BEGIN_NAMESPACE_STD
_MSL_BEGIN_EXTERN_C

_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL log2(double x)
{
	static const unsigned long f[2] = {0x3ff71547, 0x652b82fe};
	return log(x) * *(double*)f;
}

_MSL_IMP_EXP_C  double      _MSL_MATH_CDECL nan(const char* x)
{
	#pragma unused(x)
	return NAN;															/*- hh 010411 -*/		
}

_MSL_END_EXTERN_C
_MSL_END_NAMESPACE_STD

/* Change record: 
 * JWW 030224 Changed __MSL_LONGLONG_SUPPORT__ flag into the new more configurable _MSL_LONGLONG
 */