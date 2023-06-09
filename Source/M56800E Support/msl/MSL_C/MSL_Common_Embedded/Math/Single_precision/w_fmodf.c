/* w_fmodf.c -- float version of w_fmod.c.
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
__RCSID("$NetBSD: w_fmodf.c,v 1.4 1997/10/09 11:34:45 lukem Exp $");
#endif

/* 
 * wrapper fmodf(x,y)
 */



#ifdef __STDC__
	float fmodf(float x, float y)	/* wrapper fmodf */
#else
	float fmodf(x,y)		/* wrapper fmodf */
	float x,y;
#endif
{
#ifdef _IEEE_LIBM
	return __ieee754_fmodf(x,y);
#else
	float z;
	z = __ieee754_fmodf(x,y);
	if(_LIB_VERSION == _IEEE_ ||isnanf(y)||isnanf(x)) return z;
	if(y==(float)0.0) {
		/* fmodf(x,0) */
	        return (float)__kernel_standard((double)x,(double)y,127);
	} else
	    return z;
#endif
}
#endif /* _MSL_FLOATING_POINT  */
