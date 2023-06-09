/* w_atan2f.c -- float version of w_atan2.c.
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

#if defined(LIBM_SCCS) && !defined(lint)
__RCSID("$NetBSD: w_atan2f.c,v 1.4 1997/10/09 11:34:10 lukem Exp $");
#endif

/* 
 * wrapper atan2f(y,x)
 */



#ifdef __STDC__
	float atan2f(float y, float x)		/* wrapper atan2f */
#else
	float atan2f(y,x)			/* wrapper atan2 */
	float y,x;
#endif
{
#ifdef _IEEE_LIBM
	return __ieee754_atan2f(y,x);
#else
	float z;
	z = __ieee754_atan2f(y,x);
	if(_LIB_VERSION == _IEEE_||isnanf(x)||isnanf(y)) return z;
	if(x==(float)0.0&&y==(float)0.0) {
		/* atan2f(+-0,+-0) */
	        return (float)__kernel_standard((double)y,(double)x,103);
	} else
	    return z;
#endif
}
#endif /* _MSL_FLOATING_POINT  */
