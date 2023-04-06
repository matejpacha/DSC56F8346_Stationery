/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2005/12/09 02:06:05 $
 *  $Revision: 1.6 $
 */

/*
 *	critical_regions.mac.c
 *	
 *	
 *	Routines
 *	--------
 *		__init_critical_regions
 *		__begin_critical_region
 *		__end_critical_region
 *
 *	Implementation
 *	--------------
 *
 *		For the Mac, these routines are mere stubs. The Thread Manager doesn't
 *		support preemptive threads and the ANSI library code will never yield
 *		cooperatively - ever, much less during critical regions. Interrupt-level
 *		exclusion is not addressed because it is too fraught with the danger of
 *		deadlock.
 *
 *
 */


#include "critical_regions.h"

#if _MSL_THREADSAFE

void __init_critical_regions(void)
{
}


void __kill_critical_regions(void)
{
}
#endif /* _MSL_THREADSAFE */

/*  Change Record
 *	16-Oct-95 JFH  First code release
 *  040629  cc Added _MSL_THREADSAFE check
*/