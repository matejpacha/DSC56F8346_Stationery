/* w_acoshf.c -- float version of w_acosh.c.
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
 *
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
__RCSID("$NetBSD: w_acoshf.c,v 1.4 1997/10/09 11:33:58 lukem Exp $");
#endif

/* 
 * wrapper acoshf(x)
 */


#ifdef __STDC__
	float acoshf(float x)		/* wrapper acoshf */
#else
	float acoshf(x)			/* wrapper acoshf */
	float x;
#endif
{
#ifdef _IEEE_LIBM
	return __ieee754_acoshf(x);
#else
	float z;
	z = __ieee754_acoshf(x);
	if(_LIB_VERSION == _IEEE_ || isnanf(x)) return z;
	if(x<(float)1.0) {
		/* acosh(x<1) */
	        return (float)__kernel_standard((double)x,(double)x,129);
	} else
	    return z;
#endif
}
#endif /* _MSL_C99 */
#endif /* _MSL_FLOATING_POINT  */
