/* e_remainderf.c -- float version of e_remainder.c.
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
__RCSID("$NetBSD: e_remainderf.c,v 1.5 1997/10/09 11:29:51 lukem Exp $");
#endif


#ifdef __STDC__
static const float zero = 0.0;
#else
static float zero = 0.0;
#endif


#ifdef __STDC__
	float __ieee754_remainderf(float x, float p)
#else
	float __ieee754_remainderf(x,p)
	float x,p;
#endif
{
	int32_t hx,hp;
	u_int32_t sx;
	float p_half;

	GET_FLOAT_WORD(hx,x);
	GET_FLOAT_WORD(hp,p);
	sx = hx&0x80000000;
	hp &= 0x7fffffff;
	hx &= 0x7fffffff;

    /* purge off exception values */
	if(hp==0) return (x*p)/(x*p);	 	/* p = 0 */
	if((hx>=0x7f800000)||			/* x not finite */
	  ((hp>0x7f800000)))			/* p is NaN */
	    return (x*p)/(x*p);


	if (hp<=0x7effffff) x = __ieee754_fmodf(x,p+p);	/* now x < 2p */
	if ((hx-hp)==0) return zero*x;
	x  = fabsf(x);
	p  = fabsf(p);
	if (hp<0x01000000) {
	    if(x+x>p) {
		x-=p;
		if(x+x>=p) x -= p;
	    }
	} else {
	    p_half = (float)0.5*p;
	    if(x>p_half) {
		x-=p;
		if(x>=p_half) x -= p;
	    }
	}
	GET_FLOAT_WORD(hx,x);
	SET_FLOAT_WORD(x,hx^sx);
	return x;
}
#endif /* _MSL_C99 */
#endif /* _MSL_FLOATING_POINT  */
