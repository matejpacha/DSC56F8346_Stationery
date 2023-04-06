/************************************************************************
 *                                                                      *
 * Motorola, Inc.                                                       *
 * (c) Copyright 2002-2005 Motorola, Inc.                               *
 * ALL RIGHTS RESERVED                                                  *
 *                                                                      *
 ************************************************************************
 *                                                                      *
 * File name    : mclib_basic.h                                         *
 *                                                                      *
 ************************************************************************/
#ifndef _MCLIB_BASIC_H_
#define _MCLIB_BASIC_H_

#include "mclib_rand.h"       /* include random function prototype      */

#define TABLE_LENGTH 8  /* length of sine table - 2^8+1 samples         */

/* prototypes of the basic math functions                               */
extern Frac16 MCLIB_Sin             (register Frac16 val);
extern Frac16 MCLIB_Cos             (register Frac16 val);
extern Frac16 MCLIB_Tan             (register Frac16 val);
extern Frac16 MCLIB_Asin            (register Frac16 val);
extern Frac16 MCLIB_Acos            (register Frac16 val);
extern Frac16 MCLIB_Atan            (register Frac16 val);
extern Frac16 MCLIB_Sqrt            (register Frac32 val);
extern Frac16 MCLIB_AtanYX           (register Frac16 yval, register Frac16 xval);
extern void   MCLIB_InitAtanYXShifted(Frac16 ky, Frac16 kx, Frac16 ny, Frac16 nx, Frac16 thetaAdj);
extern Frac16 MCLIB_AtanYXShifted    (register Frac16 yval, register Frac16 xval);
/* inlined functions
inline Frac16 MCLIB_Sin2 (register Frac16 xval)
inline Frac16 MCLIB_Cos2(register Frac16 xval)
*/

extern const short MCLIB_sin_q1itp256_positptbl[];

/************************************************************************
 * Auxiliary functions                                                  *
 ************************************************************************/
inline Frac32 MCLIB_sin_q1reduction(register Frac16 xval)
{
	register Frac32 acc;

	asm(move.w xval, acc);
	asm(lsl.w acc);
	asm(asrr.l #1, acc);
	asm(abs acc);
	
	return acc;
}


inline Frac16 MCLIB_negabs_tcc (register Frac16 val)
{
	register Frac32 acc;

	asm(move.w val, acc);
	asm(abs acc);
	asm(neg acc);
	asm(cmp.w acc,val);
	asm(tlt val, acc);
	
	return __extract_h(acc);
	
}

inline Frac16 MCLIB_negabs_bcc (register Frac16 val)
{
	asm(tst.w val);
	asm(blt negabs_bcc_negval);
	asm(neg val);
	asm(negabs_bcc_negval:);

	return val;
}

inline Frac16 MCLIB_unevencheckneg_bcc (register Frac16 val)
{
	register Frac16 aux;
	
	asm(cmp.w #0,val);
	asm(move.w #0xC000, aux);
	asm(bge unevencheckneg_bcc_posval);
	asm(nop);
	asm(neg aux);
	asm( unevencheckneg_bcc_posval:);

	return aux;
}

inline Frac32 MCLIB_sin_q1itp256_core(register Frac32 Acc1)
{
	register Frac16 Aux;
	register Frac16* pAux;
	const register Frac16* pValTbl;
	register Frac16 xnorm;
	register Frac32 Acc2;
	
	pValTbl = (MCLIB_sin_q1itp256_positptbl);
	asm(move.w Acc1.1, pAux);
	asm(adda pValTbl, pAux);
	asm(asl16 Acc1, xnorm);
	asm(move.w X:( pAux)+, Acc2);
	asm(lsr.w xnorm);
	asm(mac - Acc2.1, xnorm, Acc2);
	asm(move.w X:( pAux)+, Aux);
	asm(macr Aux, xnorm, Acc2);
	return Acc2;
}

/************************************************************************ 
 *                                                                      *
 * Module: Frac16 MCLIB_Sin2 (register Frac16 val)                      *
 *                                                                      *
 * Description: The MCLIB_Sin2 function calculates sin(pi*x) using      *
 *              lookup table.                                           *
 *                                                                      *
 * Returns: The function returns result of sin(pi*x). The output data   *
 *          value is in the range of [-1,1). It means that the function *
 *          value of 0.5, which corresponds to pi/2, will be 0x7FFF and *
 *          of -0.5, which corresponds to -pi/2, will be 0x8000.        *  
 *                                                                      *
 * Global Data: none                                                    *
 *                                                                      *
 * Arguments:                                                           *
 *     val - The input data value is in the range of [-1,1), which      *
 *           corresponds to the angle in the range of [-pi,pi).         *  
 *                                                                      *
 * Defines: none                                                        *  
 *                                                                      *
 * Range Issues: none                                                   *
 *                                                                      *
 * Special Issues: The function requires the saturation mode to be set. *                                                                      
 *                                                                      *    
 ************************************************************************/
inline Frac16 MCLIB_Sin2 (register Frac16 xval)
{
	register Frac16 Aux;
	register Frac16 CUneven;
	register Frac32 Acc1;
	register Frac32 Acc2;
	
	CUneven = MCLIB_unevencheckneg_bcc (xval);
	Acc1 = MCLIB_sin_q1reduction (xval);
	asm(asrr.l #( 6),Acc1);
	Acc2 = MCLIB_sin_q1itp256_core (Acc1);
	asm(nop);
	asm(mpy Acc2.1,CUneven,Acc1);
	asm(add Acc1,Acc1);
	asm(move.w Acc1.1,Aux);

	return Aux;
	
}
/************************************************************************
 *                                                                      *
 * Module: Frac16 MCLIB_Cos2 (register Frac16 val)                      *
 *                                                                      *
 * Description: The MCLIB_Cos2 function computes the cos(pi*x) using    *
 *              sine calculation. The sine calculation is made with use *
 *              of lookup table.                                        *
 *                                                                      *
 * Returns: The function returns cos(pi*x). The output data value is in *
 *          the range [-1,1). It means that the function value of 0,    *
 *          which corresponds to 0*pi=0, will be 0x7FFF and of 1, which *
 *          corresponds to pi, will be 0x8000.                          *  
 *                                                                      *
 * Global Data: none                                                    *
 *                                                                      *
 * Arguments:                                                           *
 *     val - The input data value is in the range of [-1,1), which      *
 *           corresponds to the angle in the range of [-pi,pi).         *                                             *  
 *                                                                      *
 * Defines: none                                                        *
 *                                                                      *
 * Range Issues: none                                                   *
 *                                                                      *
 * Special Issues: The function requires the saturation mode to be set. *                                                                      
 *                                                                      *    
 ************************************************************************/
inline Frac16 MCLIB_Cos2(register Frac16 xval)
{
	register Frac16 yval;
	
	xval = MCLIB_negabs_bcc (xval);
	asm(add.w 0x4000 ,xval);
	yval = MCLIB_Sin2 (xval);
	return yval;
}

#endif /* _MCLIB_BASIC_H_ */
