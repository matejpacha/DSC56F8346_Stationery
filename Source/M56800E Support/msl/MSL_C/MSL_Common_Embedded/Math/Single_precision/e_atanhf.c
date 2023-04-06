/* e_atanhf.c -- float version of e_atanh.c.
 * Conversion to float by Ian Lance Taylor, Cygnus Support, ian@cygnus.com.
 */

/*
 * ====================================================
 * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
 *
 * Developed at SunPro, a Sun Microsystems, Inc. business.
 * Permission to use, copy, modify, and distribute this
 * software is freely granted, provided that this notice 
 * is preserved.
 * ====================================================
 */

#if defined(__MWERKS__)
#include "fdlibm.h"
#else
#include <sys/cdefs.h>
#include "math.h"
#include "math_private.h"
#endif

#if _MSL_FLOATING_POINT
#if _MSL_C99 || _MSL_C99_MATH_LEAK

#if defined(LIBM_SCCS) && !defined(lint)
__RCSID("$NetBSD: e_atanhf.c,v 1.5 1997/10/09 11:28:46 lukem Exp $");
#endif


#ifdef __STDC__
static const float one = 1.0, huge = 1e30;
#else
static float one = 1.0, huge = 1e30;
#endif

#ifdef __STDC__
static const float zero = 0.0;
#else
static float zero = 0.0;
#endif

#ifdef __STDC__
	float __ieee754_atanhf(float x)
#else
	float __ieee754_atanhf(x)
	float x;
#endif
{
	float t;
	int32_t hx,ix;
	GET_FLOAT_WORD(hx,x);
	ix = hx&0x7fffffff;
	if (ix>0x3f800000) 		/* |x|>1 */
	{
#ifdef __STDC__
		errno=EDOM ;	
#endif   
#ifdef __MWERKS__
	    return NAN;
#else
	    return (x-x)/(x-x);
#endif
	}
	if(ix==0x3f800000) 
	{
#ifdef __MWERKS__
		/* +/- 1 / 0.0 is +/- INF */
		/* this change avoids calls to software emulation and a warning message */
	    return copysignf(INFINITY,x);
#else
	    return x/zero;
#endif
	}
	if(ix<0x31800000&&(huge+x)>zero) return x;	/* x<2**-28 */
	SET_FLOAT_WORD(x,ix);
	if(ix<0x3f000000) {		/* x < 0.5 */
	    t = x+x;
	    t = (float)0.5*log1pf(t+t*x/(one-x));
	} else 
	    t = (float)0.5*log1pf((x+x)/(one-x));
	if(hx>=0) return t; else return -t;
}
#endif /* _MSL_C99 */
#endif /* _MSL_FLOATING_POINT  */
