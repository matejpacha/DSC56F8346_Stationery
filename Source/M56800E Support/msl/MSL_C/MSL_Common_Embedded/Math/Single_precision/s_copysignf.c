/* s_copysignf.c -- float version of s_copysign.c.
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
#if _MSL_C99 || _MSL_USES_SUN_MATH_LIB

#if defined(LIBM_SCCS) && !defined(lint)
__RCSID("$NetBSD: s_copysignf.c,v 1.5 1997/10/09 11:31:24 lukem Exp $");
#endif

/*
 * copysignf(float x, float y)
 * copysignf(x,y) returns a value with the magnitude of x and
 * with the sign bit of y.
 */


#ifdef __STDC__
	float copysignf(float x, float y)
#else
	float copysignf(x,y)
	float x,y;
#endif
{
	u_int32_t ix,iy;
	GET_FLOAT_WORD(ix,x);
	GET_FLOAT_WORD(iy,y);
	SET_FLOAT_WORD(x,(ix&0x7fffffff)|(iy&0x80000000));
        return x;
}
#endif /* _MSL_C99 || _MSL_USES_SUN_MATH_LIB */
#endif /* _MSL_FLOATING_POINT  */
