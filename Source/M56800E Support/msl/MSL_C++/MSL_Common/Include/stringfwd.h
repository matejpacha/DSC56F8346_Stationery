/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:06:11 $
 * $Revision: 1.13 $
 */

// stringfwd.h

// WARNING
//
// stringfwd.h is a non-standard, non-portable header.
//
// WARNING

#ifndef _STRINGFWD_H
#define _STRINGFWD_H

#include <stringfwd>

#ifndef _MSL_NO_CPP_NAMESPACE

	using std::allocator;
	using std::char_traits;
	using std::basic_string;
	using std::string;
#ifndef _MSL_NO_WCHART_CPP_SUPPORT
	using std::wstring;
#endif

#endif  // _MSL_NO_CPP_NAMESPACE

#endif // _STRINGFWD_H

// hh 991114 Created
