/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:06:12 $
 * $Revision: 1.22 $
 */

// strstream.h

#ifndef _STRSTREAM_H
#define _STRSTREAM_H

#include <strstream>

#ifndef _MSL_NO_CPP_NAMESPACE
#ifndef _MSL_NO_IO
	using std::strstreambuf;
	using std::istrstream;
	using std::ostrstream;
	using std::strstream;
#endif  // _MSL_NO_IO
#endif  // _MSL_NO_CPP_NAMESPACE

#endif  // _STRSTREAM_H

// hh 990120 changed name of MSIPL flags
