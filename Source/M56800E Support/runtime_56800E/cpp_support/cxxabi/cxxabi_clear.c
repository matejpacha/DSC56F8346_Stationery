/* CodeWarrior Runtime Library
 * Copyright ©2012 Freescale Semiconductor, Inc.  All rights reserved.
 *
 * Purpose:  Implementation of the portable Itanium C++ ABI
 *           see http://www.codesourcery.com/cxx-abi/
 *
 * $Date: 2013/02/19 12:12:27 $
 * $Revision: 1.3 $
 */

#include <stddef.h>

extern void *__clear(void *ptr,size_t size);
extern void *__clear(void *ptr,size_t size)
{
	char *cptr;

	if((cptr=(char *)ptr)!=NULL)
	{
		for(; size!=0; --size, ++cptr)
		{
			*cptr=0;
		}
	}
	return ptr;
}
