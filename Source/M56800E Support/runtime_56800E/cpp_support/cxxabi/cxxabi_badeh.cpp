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
#include <typeinfo>

//	Raise a bad_cast exception (lib.bad.cast, 18.5.2).
//	Does not return (normally), and implementations may note this fact, e.g. with pragmas.
extern "C" void __cxa_bad_cast ()
{
	std::bad_cast();
}


//	Raise a bad_typeid exception (lib.bad.typeid, 18.5.3).
//	Does not return (normally), and implementations may note this fact, e.g. with pragmas.
extern "C" void __cxa_bad_typeid ()
{
	std::bad_typeid();
}
