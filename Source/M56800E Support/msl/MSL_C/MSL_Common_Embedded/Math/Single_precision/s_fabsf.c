/* s_fabsf.c -- float version of s_fabs.c.
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
__RCSID("$NetBSD: s_fabsf.c,v 1.5 1997/10/09 11:31:51 lukem Exp $");
#endif

/*
 * fabsf(x) returns the absolute value of x.
 */


#ifdef __STDC__
	float fabsf(float x)
#else
	float fabsf(x)
	float x;
#endif
{
	u_int32_t ix;
	GET_FLOAT_WORD(ix,x);
	SET_FLOAT_WORD(x,ix&0x7fffffff);
        return x;
}
#endif /* _MSL_FLOATING_POINT  */
