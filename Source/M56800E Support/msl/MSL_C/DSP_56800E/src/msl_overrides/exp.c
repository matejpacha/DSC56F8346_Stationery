/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2005/12/09 02:06:06 $
 *  $Revision: 1.5 $
 */


/*;----------------------------------------------------------------------
;
;	exp.c
;	
;
; 	Routines
; 	--------
; 	exp - the exponential function
;  
;----------------------------------------------------------------------
*/


#include "math.h"
#include "errno.h"

#define RLN2    1.4426950408889634074
#define C1      0.693359375
#define C2      -2.1219444005469058277e-4

#define P0      0.249999999999999993e+0
#define P1      0.694360001511792852e-2
#define P2      0.165203300268279130e-4
#define Q0      0.500000000000000000e+0
#define Q1      0.555538666969001188e-1
#define Q2      0.495862884905441294e-3

#define MAX_ARG      88.722839

    double
exp(double x)
{
    int    n;
    double g,xn,z;
    double gpz, qz;

    if (x > MAX_ARG) {
		errno = ERANGE;
		return (HUGE_VAL);
    } else if (x < -MAX_ARG) {
		return (0.0);
    }
	n = (int)(fabs(x) * RLN2 + 0.5);
	if (x < 0.0)
		n = -n;
	
    xn = (double)n;
    g = (x - xn * C1) - xn * C2;
    z = g * g;
    gpz = ((P2 * z + P1) * z + P0) * g;
    qz = (Q2 * z + Q1) * z + Q0;
    return(ldexp(0.5 + gpz/(qz - gpz), n + 1));

}
