/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2011/12/12 12:57:35 $
 *  $Revision: 1.8 $
 */

/*----------------------------------------------------------------------
;	pow.c
;
; 	Routines
; 	--------
; 	pow - calculates x**y
;	check for domain errors and then use logarithms to calculate since
;		x**y = exp(y*log(x))
;  
;----------------------------------------------------------------------
*/

#include "math.h"
#include "errno.h"

    double
pow(double x, double y)
{
    int is_negative = 0;
    double tossit;
    double result;

    if (x < 0.0) {
		if (modf(y,&tossit) == 0.0) {
	    	x = -x;
	    	if (((int)y) & 1) {
				is_negative = 1; /* the exponent is odd */
	    	}
        } else {
	    	errno = EDOM;
	    	return (HUGE_VAL);
		}
    } else if (x == 0.0) {
    	if (y < 0.0) {
			errno = EDOM;
			return (HUGE_VAL);
		} else if (y == 0.0) {
			return(1.0);
		} else return(0.0);
    }
		/* save the call to exp() for a few other easy cases */
	if (y == 0.0) return(1.0);
	if (y == 1.0) {
		if (is_negative) {
			return(-x);
		} else {
			return(x);
		}
	}

    result = exp(y*log(x));
    if (is_negative) {
        return(-result);
    } else {
		return(result);
	}
}
