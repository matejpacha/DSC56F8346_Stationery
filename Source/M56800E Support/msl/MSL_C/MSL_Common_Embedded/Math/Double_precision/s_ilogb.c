/* @(#)s_ilogb.c 1.2 95/01/04 */
/* $Id: s_ilogb.c,v 1.7 2007/07/26 21:16:30 cgalvan Exp $ */
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

/* ilogb(double x)
 * return the binary exponent of non-zero x
 * ilogb(0) = 0x80000001
 * ilogb(inf/NaN) = 0x7fffffff (no signal is raised)
 */

#include "fdlibm.h"

#if _MSL_FLOATING_POINT
#if _MSL_C99 || _MSL_C99_MATH_LEAK

#ifdef __STDC__
	int ilogb(double x)
#else
	int ilogb(x)
	double x;
#endif
{
	_INT32 hx,lx,ix;

	hx  = (__HI(x))&0x7fffffff;	/* high word of x */
	if(hx<0x00100000) {
	    lx = __LO(x);
	    if((hx|lx)==0) 
		return 0x80000001;	/* ilogb(0) = 0x80000001 */
	    else			/* subnormal x */
		if(hx==0) {
		    for (ix = -1043; lx>0; lx<<=1) ix -=1;
		} else {
		    for (ix = -1022,hx<<=11; hx>0; hx<<=1) ix -=1;
		}
	    return ix;
	}
	else if (hx<0x7ff00000) return (hx>>20)-1023;
	else return 0x7fffffff;
}
#endif /* _MSL_C99 */
#endif /* _MSL_FLOATING_POINT  */
