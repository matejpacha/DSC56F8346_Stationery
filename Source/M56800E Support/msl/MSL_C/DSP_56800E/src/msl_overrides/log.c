/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2005/12/09 02:06:06 $
 *  $Revision: 1.5 $
 */


/*;----------------------------------------------------------------------
;
;	log.c
;	
; 	Routines
; 	--------
; 	log
;	log10
;  
;----------------------------------------------------------------------
*/



#include "math.h"
#include "errno.h"

#define A0    -0.64124943423745581147e+2
#define A1     0.16383943563021534222e+2
#define A2    -0.78956112887491257267e+0
#define B0    -0.76949932108494879777e+3
#define B1     0.31203222091924532844e+3
#define B2    -0.35667977739034646171e+2

#define SQRTHF 0.70710678118654752440
#define C1     0.693359375 
#define C2    -2.121944400546905827679e-4
#define M_LN10	2.30258509299404568402
#define M_LN10_RECIP	0.43429448190325182765

    double
log(x)
    double x;
{
    int     n;
    double	y;
    double  almost;
    double  nd;

    if (x == 0.0) {
		errno = ERANGE;
		return (-HUGE_VAL);
    } else if (x < 0.0) {
		errno = EDOM;
		return (-HUGE_VAL);
    }

    x = frexp(x, &n);

    if (x < SQRTHF) {
 		n--;
 		y = 0.5;
 	} else {
 		y = 1.0;
 	}

    x = (x - y)/(x + y);
    x += x;
    y = x * x;

    almost = x + (x * (((A2*y+A1)*y+A0)*y) / (((y+B2)*y+B1)*y+B0) );

    nd = (double) n;
    return((nd * C2 + almost) + (nd * C1));

}


double log10(double x) {
     if (x <= 0) {
        return (log(x));
    } else {
/*        return (log(x)/M_LN10);*/
        return (log(x)*M_LN10_RECIP);
    }
}