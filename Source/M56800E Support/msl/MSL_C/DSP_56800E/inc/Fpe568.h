/* MSL
 * Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2005/12/09 02:02:43 $
 * $Revision: 1.5 $
 */


/*************************************************************************
** FILE: fpe568.H
**
*************************************************************************/
/*
 * Set __SUPPORTS_FPU to 1 if the compiler supports variables of type
 * float and double (and knows how to pass them to functions like those
 * of the fp engine).  Set it to 0 otherwise.
 */
#define __SUPPORTS_FPU 1

/*
 * This file defines the interface to routines providing floating point
 * functionality in software.
 *
 * To simplify experimentation and testing, this code shields the types:
 *		float (and double, long long, and unsigned long long, etc.)
 * with the prefix "sfpe_" and connects compound parts with underscores.
 * It is up to the user to define the types appropriately. The following
 * conditionals support two common cases.
 */
#if __SUPPORTS_FPU
	typedef float sfpe_float;
#else
	typedef	unsigned long sfpe_float;
#endif

/* Use the MIPS constants, because they fit in 16 bits. */
#define FPE_INVALID		0x0040
#define FPE_OVERFLOW	0x0010
#define FPE_UNDERFLOW	0x0008
#define	FPE_DIVBYZERO	0x0020
#define	FPE_INEXACT		0x0004

#define	FPE_TONEAREST	0
#define FPE_TOWARDZERO	1
#define FPE_UPWARD		2
#define	FPE_DOWNWARD	3
#define	FPE_MODE_MASK	0x0003
#define FPE_MODE_SHIFT	0

/*
 * These three functions define the interface to the (software) fpscr
 * of the sfpe. ARTROUND not only sets the rounding mode according
 * the low two bits of its argument, but it also returns those masked
 * two bits. This provides some hope of compatibility with less capable
 * emulators, which support only rounding to nearest. A programmer
 * concerned about getting the rounding mode requested can test the
 * return value from ARTROUND; it will indicate what the current mode is.
 */
int ARTROUND(int);
int ARTGETFPSCR(void);
void ARTSETFPSCR(int);

sfpe_float ARTU16_TO_F32(unsigned int);
sfpe_float ARTS16_TO_F32(int);
sfpe_float ARTU32_TO_F32(unsigned long);
sfpe_float ARTS32_TO_F32(long);

unsigned int ARTF32_TO_U16U(sfpe_float);
int ARTF32_TO_S16U(sfpe_float);
unsigned long ARTF32_TO_U32U(sfpe_float);
long ARTF32_TO_S32U(sfpe_float);


/*
 * The comparison functions ARTCMP[E]F32 compare their two arguments
 * and return one of the four values defined below.
 * The function ARTCMPEF32, in addition to returning
 * the comparison code, also set the invalid flag in the fpscr if
 * the operands are unordered. Two floating point values are unordered
 * when they enjoy no numerical relationship, as is the case when one
 * or both are NaNs.
 *
 * The functions set the condition codes according to the result
 *
 *    | <  =  >  ?  <-- IEEE relation discovered, '?' means 'unordered'
 *  --+------------
 *  C | 1  0  0  0  <-- setting of condition codes on exit from function
 *  Z | 0  1  0  0
 *  N | 1  0  0  0
 *  V | 0  0  0  1
 *
 */
#define FP_EQUAL		0
#define FP_LESS			1
#define FP_GREATER		2
#define FP_UNORDERED	3

int ARTCMPF32(sfpe_float, sfpe_float);
int ARTCMPEF32(sfpe_float, sfpe_float);

sfpe_float ARTNEGF32(sfpe_float);
sfpe_float ARTADDF32U(sfpe_float, sfpe_float);
sfpe_float ARTSUBF32U(sfpe_float, sfpe_float);
sfpe_float ARTMPYF32U(sfpe_float, sfpe_float);
sfpe_float ARTDIVF32UZ(sfpe_float, sfpe_float);

