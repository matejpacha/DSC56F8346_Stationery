/* MSL
 * Copyright � 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:07:36 $
 * $Revision: 1.4 $
 */
 
#ifndef _MSL_CPP_STD_LOCALE_H
#define _MSL_CPP_STD_LOCALE_H

#ifdef __cplusplus

namespace std {

	using ::lconv;
	using ::localeconv;
	using ::setlocale;

} /* namespace std */

#endif /* __cplusplus */

#endif /* _MSL_CPP_STD_LOCALE_H */

/* Change record: 
 * JWW 050128 Put C items into the std namespace
 */