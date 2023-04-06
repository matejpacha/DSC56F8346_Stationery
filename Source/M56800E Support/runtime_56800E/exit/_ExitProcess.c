/* CodeWarrior Runtime Library
 * Copyright ©2012 Freescale Semiconductor, Inc.  All rights reserved.
 *
 * $Date: 2012/06/01 16:05:08 $
 * $Revision: 1.1 $
 */

#include <ansi_parms.h>

extern void _ExitProcess(int status) _MSL_WEAK;
extern void _ExitProcess(int status)
{
#if defined(__m56800__)
	exit_dsp568();
#else defined(__m56800E__)
	exit_halt();
#endif /* defined(__m56800__) */
}
