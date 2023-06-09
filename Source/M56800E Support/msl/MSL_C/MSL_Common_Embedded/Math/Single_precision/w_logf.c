/* w_logf.c -- float version of w_log.c.
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
__RCSID("$NetBSD: w_logf.c,v 1.4 1997/10/09 11:35:45 lukem Exp $");
#endif

/*
 * wrapper logf(x)
 */



#ifdef __STDC__
	float logf(float x)		/* wrapper logf */
#else
	float logf(x)			/* wrapper logf */
	float x;
#endif
{
#ifdef _IEEE_LIBM
	return __ieee754_logf(x);
#else
	float z;
	z = __ieee754_logf(x);
	if(_LIB_VERSION == _IEEE_ || isnanf(x) || x > (float)0.0) return z;
	if(x==(float)0.0)
	    /* logf(0) */
	    return (float)__kernel_standard((double)x,(double)x,116);
	else 
	    /* logf(x<0) */
	    return (float)__kernel_standard((double)x,(double)x,117);
#endif
}
#endif /* _MSL_FLOATING_POINT  */
