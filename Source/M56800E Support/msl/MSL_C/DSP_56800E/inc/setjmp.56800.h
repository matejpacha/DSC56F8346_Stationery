/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:06:16 $
 * $Revision: 1.8 $
 */

#ifndef _MSL_SETJMP_56800_H
#define _MSL_SETJMP_56800_H

#pragma options align=native

_MSL_BEGIN_NAMESPACE_STD
_MSL_BEGIN_EXTERN_C

	#if defined(__m56800E_lmm__)
		typedef unsigned int jmp_buf[64];
	#else
		typedef unsigned int jmp_buf[37];
	#endif

_MSL_END_EXTERN_C
_MSL_END_NAMESPACE_STD

#pragma options align=reset

#endif /* _MSL_SETJMP_56800_H */

/* Change record:
 * JWW 011101 New file to make setjmp information platform independent
 * jr  020912 Fix for wb1-30083 - Now saves and restores N3. Update 
 *            jmp_buf array to account for addtiional register save
 */