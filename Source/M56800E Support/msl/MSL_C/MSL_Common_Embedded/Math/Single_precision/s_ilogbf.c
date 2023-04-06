/* s_ilogbf.c -- float version of s_ilogb.c.
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
#include <limits.h>

#if _MSL_FLOATING_POINT
#if _MSL_C99 || _MSL_C99_MATH_LEAK

#if defined(LIBM_SCCS) && !defined(lint)
__RCSID("$NetBSD: s_ilogbf.c,v 1.5 1997/10/09 11:32:16 lukem Exp $");
#endif


#ifdef __STDC__
	int ilogbf(float x)
#else
	int ilogbf(x)
	float x;
#endif
{
	int32_t hx,ix;

	GET_FLOAT_WORD(hx,x);
	hx &= 0x7fffffff;
	if(hx<0x00800000) {
	    if(hx==0) 
		return FP_ILOGB0;
	    else			/* subnormal x */
	        for (ix = -126,hx<<=8; hx>0; hx<<=1) ix -=1;
	    return ix;
	}
	else if (hx<0x7f800000) return (hx>>23)-127;
	else if (hx>0x7f800000) return FP_ILOGBNAN;
	else return INT_MAX;
}
#endif /* _MSL_C99 */
#endif /* _MSL_FLOATING_POINT  */
