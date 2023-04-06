/* MSL
 * Copyright � 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:06:18 $
 * $Revision: 1.25 $
 */

#ifndef _MSL_SIGNAL_H
#define _MSL_SIGNAL_H

#include <ansi_parms.h>

#if !_MSL_USING_MW_C_HEADERS
	#error You must have the non-MSL C header file access path before the MSL access path
#else

#include <csignal>

#if defined(__cplusplus) && defined(_MSL_USING_NAMESPACE)
	using std::sig_atomic_t;
	using std::raise;
	using std::signal;
#endif /* defined(__cplusplus) && defined(_MSL_USING_NAMESPACE) */

#endif /* _MSL_USING_MW_C_HEADERS */

#endif /* _MSL_SIGNAL_H */

/* Change record:
 * hh  971206 Created.
 * hh  991112 Fixed using bug.
 * JWW 001208 Added case for targeting Mach-O
 * JWW 011027 Use _MSL_USING_MW_C_HEADERS as generic header test instead of specific Mach-O test
 */