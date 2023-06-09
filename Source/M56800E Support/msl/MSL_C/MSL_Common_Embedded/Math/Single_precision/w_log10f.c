/* w_log10f.c -- float version of w_log10.c.
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
__RCSID("$NetBSD: w_log10f.c,v 1.4 1997/10/09 11:35:42 lukem Exp $");
#endif

/* 
 * wrapper log10f(X)
 */



#ifdef __STDC__
	float log10f(float x)		/* wrapper log10f */
#else
	float log10f(x)			/* wrapper log10f */
	float x;
#endif
{
#ifdef _IEEE_LIBM
	return __ieee754_log10f(x);
#else
	float z;
	z = __ieee754_log10f(x);
	if(_LIB_VERSION == _IEEE_ || isnanf(x)) return z;
	if(x<=(float)0.0) {
	    if(x==(float)0.0)
	        /* log10(0) */
	        return (float)__kernel_standard((double)x,(double)x,118);
	    else 
	        /* log10(x<0) */
	        return (float)__kernel_standard((double)x,(double)x,119);
	} else
	    return z;
#endif
}
#endif /* _MSL_FLOATING_POINT  */
