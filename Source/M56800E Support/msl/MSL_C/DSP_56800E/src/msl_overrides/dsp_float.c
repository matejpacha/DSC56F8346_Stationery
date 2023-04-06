/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2006/01/31 21:10:39 $
 *  $Revision: 1.8 $
 */

/*
 *	float.c
 *	
 *	
 *	Modification History
 *	--------------------
 *
 *	14-July-98 RSJ  First code release.
 */

#include <float.h>
#include <Fltmath.h>


#define MantissaMask 0x007fffff
#define ExponentMask 0x7f800000
#define SignMask	 0x80000000

/*-----------------------------------------------------*/
/* check to see if the float value is a INF            */
/* If the Mantisa is 0 and the exp is 0xFF return TRUE */
/*-----------------------------------------------------*/
int IsInf(double f)
{
	return ((*(long*)&f & ~SignMask) == ExponentMask);
}

#define   NanSignal          0x02000000
#define   MantissaOf(f) ((f & MantissaMask)<<3)


/*---------------------------*/
/*Check is value is NAN	     */
/*---------------------------*/
int IsNan (double f)
{
	return ( ((*(long*)&f & ExponentMask) == ExponentMask) &&
	         (*(long*)&f & MantissaMask)
	       );
}
