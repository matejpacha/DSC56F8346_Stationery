/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2005/12/09 02:02:55 $
 *  $Revision: 1.5 $
 */

#ifndef _MSL_STDARG_56800E_H
#define _MSL_STDARG_56800E_H

_MSL_BEGIN_EXTERN_C

	#define __va_start(parm) (__std(va_list))(&parm)					    /*- mm 981014 -*/
	#define va_start(ap, parm) (void)(ap = (va_list)&parm)				/*- US 011402 -*/
	
	#define va_arg(ap, type) 																\
	(__builtin_vargtype(type) == 1 																\
	? 	/* Float or Long Aligned Types */																	\
		(*(type *) (((((unsigned int)((ap)))>>1)&1) == 1 ? ((ap)-=(sizeof(type) +2)) : ((ap)-=sizeof(type)))) 			\
	: 	/* Everything else */																\
	 	(*(type *) ((ap) -=((sizeof(type) <= 2) ? 2:sizeof(type))))							\
	)
	
	#define va_end(ap) ((void) 0)  											/*- mm 981014 -*/

_MSL_END_EXTERN_C

#endif /* _MSL_STDARG_56800E_H */

/* Change record:
 * JWW 011101 New file to make stdarg information platform independent
 */