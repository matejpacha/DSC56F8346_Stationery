/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2007/01/29 18:10:54 $
 * $Revision: 1.6 $
 */

/* $Id: fenv.cf.c,v 1.6 2007/01/29 18:10:54 cgalvan Exp $ */

#include <fenv.h>

#if _MSL_C99 || _MSL_C99_MATH_LEAK

#include <signal.h>

_MSL_BEGIN_EXTERN_C


/* 	
FERAISEEXCEPT 
DESCRIPTION:The feraiseexcept function raises the supported floating-point 
            exceptions represented by the argument. The order in which these 
            floating-point exceptions are raised is unspecified, except as 
            stated in ISO/IEC 9899:1999 F.7.6.  Whether the feraiseexcept 
            function additionally raises the "inexact" floating-point
            exception whenever it raise the "overflow" or "underflow" 
            floating-point exception is implementation-defined. 
*/

int feraiseexcept(int excepts)
{
    if (excepts & FE_ALL_EXCEPT) raise(SIGFPE);
}


/*
 * Rounding functions.
 */

/* 
FEGETROUND 
DESCRIPTION:The fegetround function returns the value of the rounding direction 
            macro representing the current rounding direction or a negative 
            number if there is no such rounding macro or the current rounding
            direction is not determinable.
*/  
int fegetround(void)
{
    return 0;

}


_MSL_END_EXTERN_C

#endif /*_MSL_C99*/
