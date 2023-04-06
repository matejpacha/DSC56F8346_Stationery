/* CodeWarrior Runtime Library
 * Copyright ©2012 Freescale Semiconductor, Inc.  All rights reserved.
 *
 * $Date: 2013/02/19 12:11:20 $
 * $Revision: 1.3 $
 */

#include <ansi_parms.h>
#include <CWRuntime.h>

#ifndef _MAX_ATEXIT_FUNCS
	#define _MAX_ATEXIT_FUNCS 64
#endif

static DestructorChain atexit_funcs[_MAX_ATEXIT_FUNCS];
static long	atexit_curr_func = 0;
DestructorChain *__global_destructor_chain = 0;

extern void __destroy_global_chain(void)
{
	DestructorChain	*gdc;

	while((gdc = __global_destructor_chain) != 0) {
		__global_destructor_chain = gdc->next;
		((void(*)(void*))gdc->destructor)(gdc->object);
	}
}

extern void *__register_global_object(void *object,void *destructor,void *regmem)
{
	((DestructorChain *)regmem)->next=__global_destructor_chain;
	((DestructorChain *)regmem)->destructor=destructor;
	((DestructorChain *)regmem)->object=object;
	__global_destructor_chain=(DestructorChain *)regmem;

	return object;
}

extern int __register_atexit(void (*func)(void))
{
	if (atexit_curr_func == _MAX_ATEXIT_FUNCS)
		return -1;
	__register_global_object(0, func, &atexit_funcs[atexit_curr_func++]);
	return 0;
}
