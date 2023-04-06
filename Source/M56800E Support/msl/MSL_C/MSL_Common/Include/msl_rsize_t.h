/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:07:40 $
 * $Revision: 1.7 $
 */

#if defined(__STDC_WANT_LIB_EXT1__) && __STDC_WANT_LIB_EXT1__

#ifndef _MSL_RSIZE_T_H
#define _MSL_RSIZE_T_H

#include <size_t.h>

_MSL_BEGIN_NAMESPACE_STD
_MSL_BEGIN_EXTERN_C

	#ifndef _MSL_RSIZE_T_TYPE
		#define _MSL_RSIZE_T_TYPE size_t
	#endif
	
	#ifndef _MSL_RSIZE_T_DEFINED
		#define _MSL_RSIZE_T_DEFINED
		typedef _MSL_RSIZE_T_TYPE rsize_t;
	#endif

_MSL_END_EXTERN_C
_MSL_END_NAMESPACE_STD

#endif /* _MSL_RSIZE_T_H */

#endif /* __STDC_WANT_LIB_EXT1__ */

/* Change record:
 * JWW 041224 Add rsize_t for secure library
 */