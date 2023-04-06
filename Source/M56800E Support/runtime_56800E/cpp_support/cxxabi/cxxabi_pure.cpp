/* CodeWarrior Runtime Library
 * Copyright ©2012 Freescale Semiconductor, Inc.  All rights reserved.
 *
 * Purpose:  Implementation of the portable Itanium C++ ABI
 *           see http://www.codesourcery.com/cxx-abi/
 *
 * $Date: 2013/02/19 12:03:59 $
 * $Revision: 1.2 $
 */

#include <cxxabi.h>
#include <exception>

extern "C" void __cxa_pure_virtual()
{
	std::terminate();
}
