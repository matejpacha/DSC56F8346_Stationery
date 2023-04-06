
/*  intrinsics_56800EX.h	- Intrinsics functions for DSP56800EX Core.
 *
 */

#include <div_int.h>

#ifndef _INTRINSICS_56800EX_H
#define _INTRINSICS_56800EX_H

#define Intrinsic_Word16 short
#define Intrinsic_Word32 long
#define Word16 Intrinsic_Word16
#define Word32 Intrinsic_Word32


#pragma mark <56800EX instructions intrinsic functions support:  32 x 32 -> 32/64 Multiply and MAC Instructions>


#define V3_L_mult_int(a,b)		__V3_L_mult_int(a,b)
#define V3_L_mac_int(a,b,c)		__V3_L_mac_int(a,b,c)
#define V3_L_mult(a,b)			__V3_L_mult(a,b)
#define V3_L_mac(a,b,c)			__V3_L_mac(a,b,c)


/* V3_L_MULT_INT */
inline Word32 __V3_L_mult_int(register Word32 slinp1, register Word32 slinp2)
{
/*	Defn:	Multiply two 32-bit integer values and truncate into a 32-bit integer result.
 *	56800EX instruction:
 * 			IMPY32 FF1,FF1,FF - Integer Multiply 32x32 = 64 bit; save lower 32 bits.
 *			[Multiply two signed 32-bit source operands and place the lower 32-bits of the product in the destination]
 */
	register Word32 slresult;
	asm(.optimize_iasm on);
	asm(impy32 slinp1,slinp2,slresult;);
	asm(.optimize_iasm off);
	return slresult;
}


/* V3_L_MAC_INT */
inline Word32 __V3_L_mac_int(register Word32 laccum, register Word32 slinp1, register Word32 slinp2)
{
/*  Defn: Multiply two 32-bit integer values and add the lower 32-bits of the product to 32-bit integer value, generating a 32-bit result.
 *	56800EX instruction:
 * 			IMAC32 FF1,FF1,FF - Integer Multiply-Accumulate 32x32 = 64 bit; then accumulate lower 32 bits
 * 			[Multiply two signed 32-bit source operands and add the lower 32-bits of the product to the destination]
 */
	asm(.optimize_iasm on);
	asm(imac32 slinp1,slinp2,laccum);
	asm(.optimize_iasm off);
	return laccum;
}


/* V3_L_MULT */
inline Word32 __V3_L_mult(register Word32 slinp1, register Word32 slinp2)
{
/*  Defn: Multiply two 32-bit fractional values and truncate into a 32-bit fractional result.
 *	56800EX instruction:
 * 			MPY32 FF1,FF1,FF - Fractional Multiply 32x32 = 64 bit; save higher 32 bits
 * 			[Multiply two signed 32-bit source operands and place the higher 32-bits of the product from the destination]
 */
	register Word32 slresult;
	asm(.optimize_iasm on);
	asm(mpy32 slinp1,slinp2,slresult);
	asm(.optimize_iasm off);
	return slresult;
}


/* V3_L_MAC */
inline Word32 __V3_L_mac(register Word32 laccum, register Word32 slinp1, register Word32 slinp2)
{
/*  Defn: Multiply two 32-bit fractional values and add the higher 32-bits of the product to 32-bit fractional value, generating a 32-bit result.
 *	56800EX instruction:
 * 			MAC32 FF1,FF1,FF - Fractional Multiply-Accumulate 32x32 = 64 bit; accumulate higher 32 bits
 * 			[Multiply two signed 32-bit source operands and add or subtract the higher 32-bits of the product from the destination]
 */
	asm(.optimize_iasm on);
	asm(mac32 slinp1,slinp2,laccum);
	asm(.optimize_iasm off);
	return laccum;
}



/*
 * NOTE: To use double precision function versions (to activate and use the 64-bit data types),
 * the " #pragma slld on " to be used to compile the project
 * (and also the SLLD libraries that support long long and double data types to be used.)
 */

#define Intrinsic_Word64 long long
#define Word64 Intrinsic_Word64

#define V3_LL_mult_int(a,b)		__V3_LL_mult_int(a,b)
#define V3_LL_mult(a,b)			__V3_LL_mult(a,b)


/* V3_LL_MULT_INT */
inline Word64 __V3_LL_mult_int(register Word32 slinp1, register Word32 slinp2)
{
/*  Defn: Multiply two 32-bit integer values generating a signed 64-bit integer result.
 *	56800EX instruction:
 * 			IMPY64 FF1,FF1,FF:Y - Integer Multiply 32x32 = 64 bit; save higher (in Acc), lower (in Y)
 * 			[Multiply two signed 32-bit source operands, place the upper 32-bits of the product in the
 *			destination accumulator and place the lower 32-bits of the product in the Y register]
 */
	return V3ARTIMPY64(slinp1, slinp2);
}


/* V3_LL_MULT */
inline Word64 __V3_LL_mult(register Word32 slinp1, register Word32 slinp2)
{
/*  Defn: Multiply two 32-bit fractional values generating a signed 64-bit fractional result.
 *	56800EX instruction:
 * 			MPY64 FF1,FF1,FF:Y - Fractional Multiply 32x32 = 64 bit; save higher (in Acc), lower (in Y)
 * 			[Multiply two signed 32-bit source operands, place the upper 32-bits of the product in the
 * 			destination accumulator and place the lower 32-bits of the product in the Y register]
 */
	return (V3ARTMPY64(slinp1, slinp2));
}



#undef Word16
#undef Word32
#undef Word64

#endif //_INTRINSICS_56800EX_H
