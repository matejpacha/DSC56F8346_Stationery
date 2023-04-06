/* s_ldexpf.c -- float version of s_ldexp.c.
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
__RCSID("$NetBSD: s_ldexpf.c,v 1.4 1997/10/09 11:32:37 lukem Exp $");
#endif

#include <errno.h>

#ifdef __STDC__
	float ldexpf(float value, int exp)
#else
	float ldexpf(value, exp)
	float value; int exp;
#endif
{
	if(!finitef(value)||value==(float)0.0) return value;
	value = scalbnf(value,exp);
	if(!finitef(value)||value==(float)0.0) errno = ERANGE;
	return value;
}
#endif /* _MSL_FLOATING_POINT  */
