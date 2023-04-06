/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:06:17 $
 * $Revision: 1.9 $
 */

#ifndef _MSL_TIME_56800_H
#define _MSL_TIME_56800_H

#include <ansi_parms.h>

#ifndef RC_INVOKED

#pragma options align=native

_MSL_BEGIN_NAMESPACE_STD
_MSL_BEGIN_EXTERN_C

/*
 *			 !! WARNING !!
 *	Based on 40MHZ crystal, 25 ns cycle, 2 cycles per tick
 *
 *		!! YOUR BOARD MAY BE DIFFERENT !!
 */
 
#if _MSL_CLOCK_T_AVAILABLE
	#define _MSL_CLOCKS_PER_SEC 20000000
	#define _MSL_CLOCK_T unsigned long
#endif	/* _MSL_CLOCK_T_AVAILABLE */

#if _MSL_TIME_T_AVAILABLE	
	#ifndef _MSL_TIME_T_DEFINED
		typedef long time_t;										/*- mm 000127 -*/
		#define _MSL_TIME_T_DEFINED
		
		/* The following macro is old and will disappear in a future version of MSL */
		/* Switch to using _MSL_TIME_T_DEFINED instead */
		#define _TIME_T_DEFINED
	#endif
#endif

#if !_MSL_TIME_T_AVAILABLE	
struct tm
{
	int	tm_sec;
	int	tm_min;
	int	tm_hour;
	int	tm_mday;
	int	tm_mon;
	int	tm_year;
	int	tm_wday;
	int	tm_yday;
	int	tm_isdst;
};
#endif

_MSL_IMP_EXP_C struct tm * _MSL_CDECL	localtime(const time_t *) _MSL_CANT_THROW;		
	
_MSL_END_EXTERN_C	
_MSL_END_NAMESPACE_STD	

#pragma options align=reset

#endif /* RC_INVOKED */

#endif /* _MSL_TIME_56800_H */


/* Change record:
 * cc  041012 Added time support needed for DSP SDK
 */
