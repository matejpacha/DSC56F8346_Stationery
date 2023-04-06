/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:11:33 $
 * $Revision: 1.7 $
 */

/*  Single precision hyperbolic functions tanh,sinh,cosh
    NOTE: these are just temporary implementations which will be rewritten.
*/
    
#include <math.h>

#if !__BUILD_FDLIBM

#if _MSL_C99 || defined(_MSL_USES_SP_MATH_LIB)

_MSL_IMP_EXP_C float _MSL_MATH_CDECL sinhf(float x)
{
  return .5f*(expf(x) -expf(-x));
}


_MSL_IMP_EXP_C float _MSL_MATH_CDECL coshf(float x)
{
return .5f*(expf(x) + expf(-x));
}

_MSL_IMP_EXP_C float _MSL_MATH_CDECL tanhf(float x)
{
  return (1.0f - expf(-2.0f*x))/(1.0f + expf(-2.0f*x));
}

#endif

#endif /* !__BUILD_FDLIBM */