/* $Id: fminmaxdimf.c,v 1.2 2009/04/15 09:50:03 marka4 Exp $ */

#include "fdlibm.h"
#if _MSL_FLOATING_POINT
#if _MSL_C99 || _MSL_C99_MATH_LEAK

#include <math.h>
_MSL_IMP_EXP_C float _MSL_MATH_CDECL fmaxf ( float x, float y ) _MSL_CANT_THROW
 {
	if(isnan(x)) return y;
	else if (isnan(y)) return x;

	if(x >= y) return x;
	else return y;
 }
_MSL_IMP_EXP_C float _MSL_MATH_CDECL fminf ( float x, float y ) _MSL_CANT_THROW
 {
	if(isnan(x)) return y;
	else if (isnan(y)) return x;

	if(x >= y) return y;
	else return x;
 }
_MSL_IMP_EXP_C float _MSL_MATH_CDECL fdimf ( float x, float y ) _MSL_CANT_THROW
{
 if(x > y) return (x-y);
 else if(x <= y) return 0.0f;
 else
 {
 if(isnan(x)) return x;
 else return y;
 }
}
#endif /* _MSL_C99 */
#endif /* _MSL_FLOATING_POINT */
