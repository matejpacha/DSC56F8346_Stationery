/* MSL
 * Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2012/06/21 14:03:26 $
 * $Revision: 1.31 $
 */

/*  intrinsics_56800E.h	- Intrinsics functions for the Motorola DSP56800E Core Family.
 *
 */

#include <div_int.h>
#ifndef _INTRINSICS_56800E_H
#define _INTRINSICS_56800E_H

#define Intrinsic_Word16 short
#define Intrinsic_Word32 long
#define Word16 Intrinsic_Word16
#define Word32 Intrinsic_Word32
#define CW__builtin_isintconst(a)	__builtin_isintconst(a)

#pragma mark <<<< Macros & Utilities >>>>
#pragma mark <<<<<< Macros >>>>>>

//#pragma mark abs_s
#define abs_s(a) 				__abs_s(a)

//#pragma mark L_abs
#define L_abs(a)				__L_abs(a)

//#pragma mark negate
#define negate(a) 				__negate(a)

//#pragma mark L_negate
#define L_negate(a)				__L_negate(a)

//#pragma mark add
#define add(a,b) 				__add(a,b)

//#pragma mark sub
#define sub(a,b) 				__sub(a,b)

//#pragma mark L_add
#define L_add(a,b)				__L_add(a,b)

//#pragma mark L_sub
#define L_sub(a,b)				__L_sub(a,b)


//#pragma mark round
#define round(a) 				__builtin_round(a)

//#pragma mark round_int
#define round_int(a) 			__round_int(a)


//#pragma mark shl
#define shl(a,b)	(CW__builtin_isintconst(b) != 0				\
					?	/* b is int const */					\
						(										\
							((b<=-16)							\
							? (__shl_bigneg(a))					\
							: /* b is >-16 */					\
							 	(								\
							 		((b>-16 && b<=-1)			\
							 		? (__shrtNs(a,-(b)))		\
							 		: /* b is >=0 */			\
							 			(						\
							 				((b>0)				\
							 				? (__shlfts(a,b))	\
							 				: (a)				\
							 				)					\
							 			)						\
							 		)							\
								)								\
							)									\
						)										\
					:	(__shl(a,b))							\
					)


//#pragma mark L_shl
#define L_shl(a,b)	(CW__builtin_isintconst(b) != 0				\
					?	/* b is int const */					\
						(										\
							((b<=-32)							\
							? (__L_shl_bigneg(a))				\
							: /* b is >-16 */					\
							 	(								\
							 		((b>-32 && b<=-1)			\
							 		? (__L_shrtNs(a,-(b)))		\
							 		: /* b is >=0 */			\
							 			(						\
							 				((b>0)				\
							 				? (__L_shlfts(a,b))	\
							 				: (a)				\
							 				)					\
							 			)						\
							 		)							\
								)								\
							)									\
						)										\
					:	(__L_shl(a,b))							\
					)


//#pragma mark shr
#define shr(a,b)	(CW__builtin_isintconst(b) != 0						\
					?	/* Is int const */								\
						(												\
							((b<=-16)									\
							? (__shr_bigneg(a))							\
							: /* b is >-16 */							\
							 	(										\
							 		((b>-16 && b<=-1)					\
							 		? (__shlfts(a,-(b)))				\
							 		: /* b is >=0 */					\
							 			(								\
							 				((b>=15)					\
							 				? (__shr_bigpos(a))			\
							 				: /* b is < 15 */			\
							 					(						\
							 						((b>0)				\
							 						? (shrtNs(a,b))		\
							 						: (a)				\
							 						)					\
							 					)						\
							 				)							\
							 			)								\
							 		)									\
								)										\
							)											\
						)												\
					:	(__shr(a,b))									\
					)


//#pragma mark shr_r
#define shr_r(a,b)	(CW__builtin_isintconst(b) != 0						\
					?	/* Is int const */								\
						(												\
							((b<=-16)									\
							? (__shr_r_bigneg(a))						\
							: /* b is >-16 */							\
							 	(										\
							 		((b>-16 && b<=-1)					\
							 		? (__shlfts(a,-(b)))				\
							 		: /* b is >=0 */					\
							 			(								\
							 				((b>=15)					\
							 				? (__shr_r_bigpos(a))		\
							 				: /* b is < 15 */			\
							 					(						\
							 						((b>0)				\
							 						? (__shr_r_nonzeroposshftamt(a,b))		\
							 						: (a)				\
							 						)					\
							 					)						\
							 				)							\
							 			)								\
							 		)									\
								)										\
							)											\
						)												\
					:	(__shr_r(a,b))									\
					)


//#pragma mark L_shr
#define L_shr(a,b)	(CW__builtin_isintconst(b) != 0						\
					?	/* Is int const */								\
						(												\
							((b<=-32)									\
							? (__L_shr_bigneg(a))						\
							: /* b is >-16 */							\
							 	(										\
							 		((b>-32 && b<=-1)					\
							 		? (__L_shlfts(a,-(b)))				\
							 		: /* b is >=0 */					\
							 			(								\
							 				((b>=31)					\
							 				? (__L_shr_bigpos(a))		\
							 				: /* b is < 15 */			\
							 					(						\
							 						((b>0)				\
							 						? (L_shrtNs(a,b))	\
							 						: (a)				\
							 						)					\
							 					)						\
							 				)							\
							 			)								\
							 		)									\
								)										\
							)											\
						)												\
					:	(__L_shr(a,b))									\
					)


//#pragma mark L_shr_r
#define L_shr_r(a,b) (CW__builtin_isintconst(b) != 0					\
					?	/* Is int const */								\
						(												\
							((b<=-32)									\
							? (__L_shr_r_bigneg(a))						\
							: /* b is >-32 */							\
							 	(										\
							 		((b>-32 && b<=-1)					\
							 		? (__L_shlfts(a,-(b)))				\
							 		: /* b is >=0 */					\
							 			(								\
							 				((b>31)						\
							 				? (0)						\
							 				: /* b is <=31  */			\
								 				(						\
								 					((b>0)				\
								 					? (__L_shr_r_nonzeroposshftamt(a,b))	\
								 					: (a)				\
								 					)					\
								 				)						\
							 				)							\
							 			)								\
							 		)									\
								)										\
							)											\
						)												\
					:	(__L_shr_r(a,b))								\
					)


//#pragma mark shlftNs
#define shlftNs(a,b)			__shlftNs(a,b)

//#pragma mark shrtNs
#define shrtNs(a,b)				__shrtNs(a,b)

//#pragma mark L_shlftNs
#define L_shlftNs(a,b)			__L_shlftNs(a,b)

//#pragma mark L_shrtNs
#define L_shrtNs(a,b)			__L_shrtNs(a,b)

//#pragma mark shlfts
#define shlfts(a,b)				__shlfts(a,b)

//#pragma mark L_shlfts
#define L_shlfts(a,b)			__L_shlfts(a,b)

//#pragma mark L_mac
#define L_mac(a,b,c)			__L_mac(a,b,c)

//#pragma mark L_mac_int
#define L_mac_int(a,b,c)		__L_mac_int(a,b,c)

//#pragma mark mac_r
#define mac_r(a,b,c)			__mac_r(a,b,c)

//#pragma mark mac_r_int
#define mac_r_int(a,b,c)		__mac_r_int(a,b,c)

//#pragma mark L_msu
#define L_msu(a,b,c)			__L_msu(a,b,c)

//#pragma mark L_msu_int
#define L_msu_int(a,b,c)		__L_msu_int(a,b,c)

//#pragma mark msu_r_int
#define msu_r_int(a,b,c)		__msu_r_int(a,b,c)

//#pragma mark msu_r
#define msu_r(a,b,c)			__msu_r(a,b,c)

//#pragma mark mult
#define mult(a,b)				__mult(a,b)

//#pragma mark mult_int
#define mult_int(a,b)			__mult_int(a,b)

//#pragma mark L_mult
#define L_mult(a,b)				__L_mult(a,b)

//#pragma mark L_mult_int
#define L_mult_int(a,b)			__L_mult_int(a,b)

//#pragma mark mult_r
#define mult_r(a,b)				__mult_r(a,b)

//#pragma mark mult_r_int
#define mult_r_int(a,b)			__mult_r_int(a,b)



//#pragma mark L_mult_ls
#define L_mult_ls(a,b)			__L_mult_ls(a,b)

//#pragma mark L_mult_ls_int
#define L_mult_ls_int(a,b)		__L_mult_ls_int(a,b)

//#pragma mark norm_s
#define norm_s(a)				__norm_s(a)

//#pragma mark norm_l
#define norm_l(a)				__norm_l(a)

//#pragma mark ffs_s
#define ffs_s(a)				__ffs_s(a)

//#pragma mark ffs_l
#define ffs_l(a)				__ffs_l(a)

//#pragma mark div_s
#define div_s(a,b)				__div_s(b,a)

//#pragma mark div_s_int
#define div_s_int(a,b)			__div_s_int(b,a)

//#pragma mark div_ls_int
#define div_ls_int(a,b)			__div_ls_int(a,b)

//#pragma mark div_ls
#define div_ls(a,b)				__div_ls(b,a)

//#pragma mark div_s4q
#define div_s4q(a,b)			__div_s4q(a,b)

//#pragma mark div_s4q_int
#define div_s4q_int(a,b)		__div_s4q_int(a,b)

//#pragma mark div_ls4q
#define div_ls4q(a,b)			__div_ls4q(a,b)

//#pragma mark div_ls4q_int
#define div_ls4q_int(a,b)		__div_ls4q_int(a,b)

//#pragma mark L_deposit_h
#define L_deposit_h(a)			__L_deposit_h(a)

//#pragma mark L_deposit_l
#define L_deposit_l(a)			__L_deposit_l(a)

//#pragma mark extract_h
#define extract_h(a)			__extract_h(a)

//#pragma mark extract_l
#define extract_l(a)			__extract_l(a)

//#pragma mark stop
#define stop()					__stop()

//#pragma mark wait
#define wait()					__wait()

//#pragma mark turn_on_conv_rndg
#define turn_on_conv_rndg()		__turn_on_conv_rndg()

//#pragma mark turn_off_conv_rndg
#define turn_off_conv_rndg()	__turn_off_conv_rndg()

//#pragma mark turn_on_sat
#define turn_on_sat()			__turn_on_sat()

//#pragma mark turn_off_sat
#define turn_off_sat()			__turn_off_sat()

#pragma mark <<<<<< Utilities >>>>>>

inline Word16 __shl_bigneg(register Word16 sval2shft)
{
	asm(.optimize_iasm on);
	asm(asrr.w #15,sval2shft);
	asm(.optimize_iasm off);
	return sval2shft;
}

inline Word32 __L_shl_bigneg(register Word32 lval2shft)
{
	asm(.optimize_iasm on);
	asm(asrr.l #31,lval2shft);
	asm(.optimize_iasm off);
	return lval2shft;
}

inline Word16 __shr_bigneg(register Word16 sval2shft)
{
	asm(.optimize_iasm on);
	asm(tst.w	sval2shft);
	asm(move.w	#-32768,sval2shft);			// 0x8000
	asm(blt		shr_bigneg_done);
	asm(neg		sval2shft);
	asm(shr_bigneg_done:);
	asm(.optimize_iasm off);
	return sval2shft;
}


inline Word32 __L_shr_bigneg(register Word32 lval2shft)
{
	asm(.optimize_iasm on);
	asm(tst.l	lval2shft);
	asm(move.l	#-2147483648,lval2shft);	// 0x80000000
	asm(blt		done);
	asm(neg		lval2shft);
	asm(done:);
	asm(.optimize_iasm off);
	return lval2shft;
}

inline Word16 __shr_r_nonzeroposshftamt(register Word16 s_val2shft, register Word16 s_shftamount)
{
   register Word32 l;
 	asm(.optimize_iasm on);
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w	s_val2shft,l;
		.iasm_sideeffects on; .iasm_reg2regsetcopyflag on;);
   asm(asrr.l	s_shftamount,l);
   asm(rnd	l);                  // Note: sval2shft must be in FF!
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w l.1,s_val2shft;            // zeros out FF0 portion
	   .iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );
   asm(.optimize_iasm off);
   return s_val2shft;
}

inline Word32 __L_shr_r_nonzeroposshftamt(register Word32 lval2shft, register Word16 s_shftamount)
{
   asm(.optimize_iasm on);
   asm(dec.w s_shftamount);
   asm(asrr.l	s_shftamount,lval2shft);
   asm(asr lval2shft);
   asm(bcc done_lshrr);
   asm(add.l #1,lval2shft);
   asm(done_lshrr:);
   asm(.optimize_iasm off);
   return lval2shft;

}

inline Word16 __shr_r_bigpos(register Word16 sval2shft)
{
	asm(.optimize_iasm on);
	asm(move.w #0,sval2shft);
	asm(.optimize_iasm off);
	return sval2shft;
}

#define __shr_bigpos(a)		__shl_bigneg(a)
#define __shr_r_bigneg(a) 	__shr_bigneg(a)
#define __L_shr_bigpos(a)	__L_shl_bigneg(a)
#define __L_shr_r_bigneg(a) __L_shr_bigneg(a)

#pragma mark -
#pragma mark <<<< Abs/Negate >>>>

	/* ABS_S */
inline Word16 __abs_s(register Word16 svar1)
{
/*
 *   Defn: Absolute value of a 16-bit integer or fractional value
 *         returning a 16-bit result.
 *         Returns $7fff for an input of $8000
 *   
 *   Hawk V2 instruction syntax:  abs FFF
 *             Allowed src regs:  FFF
 *             Allowed dst regs:  (same)
 *   
 *   Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 */
   asm(.optimize_iasm on);
   asm(abs svar1);
   asm(.optimize_iasm off);
   return svar1;
}



	/* L_ABS */
inline Word32 __L_abs(register Word32 lvar1)
{
/*
 *   Defn: Absolute value of a 32-bit integer or fractional value
 *         returning a 32-bit result.
 *         Returns $7fffffff for an input of $80000000
 *   
 *   Hawk V2 instruction syntax:  abs FFF
 *             Allowed src regs:  fff
 *             Allowed dst regs:  (same)
 *   
 *   Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                (i.e. saturation on data alu results enabled)
 */
   asm(.optimize_iasm on);
   asm(.iasm_sideeffects off; abs lvar1; .iasm_sideeffects on;);
   asm(.optimize_iasm off);
   return lvar1;
}



	/* NEGATE */
inline Word16 __negate(register Word16 svar1)
{
/*    Defn: Negates a 16-bit integer or fractional value
 *           returning a 16-bit result.
 *           Returns $7fff for an input of $8000
 *     
 *     Hawk V2 instruction syntax:  neg FFF
 *               Allowed src regs:  FFF
 *               Allowed dst regs:  (same)
 *     
 *     Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. saturation on data alu results enabled)
 */
	asm(.optimize_iasm on);
	asm(neg svar1);
	asm(.optimize_iasm off);
	return svar1;
}



	/* L_NEGATE */
inline Word32 __L_negate(register Word32 lvar1)
{
/*    Defn: Negates a 32-bit integer or fractional value
 *           returning a 32-bit result.
 *           Returns $7fffffff for an input of $80000000
 *     
 *     Hawk V2 instruction syntax:  neg FFF
 *               Allowed src regs:  fff
 *               Allowed dst regs:  (same)
 *     
 *     Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. saturation on data alu results enabled)
 */
	asm(.optimize_iasm on);
	asm(neg lvar1);
	asm(.optimize_iasm off);
	return lvar1;
}




#pragma mark -
#pragma mark <<<< Add/Sub >>>>

	/* ADD */
inline Word16 __add(register Word16 src_dst, register Word16 src2)
{
/*    Defn: Addition of two 16-bit integer or fractional values,
 *           returning a 16-bit result.
 *     
 *     Hawk V2 instruction syntax:  add FFF,FFF
 *               Allowed src regs:  FFF
 *               Allowed dst regs:  FFF
 *     
 *     Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. saturation on data alu results enabled)
 */ 
	asm(.optimize_iasm on);
	asm(add src2,src_dst);
	asm(.optimize_iasm off);
	return src_dst;
}



	/* SUB */
inline Word16 __sub(register Word16 src_dst, register Word16 src2)
{
/*    Defn: Subtraction of two 16-bit integer or fractional values,
 *           returning a 16-bit result.
 *     
 *     Hawk V2 instruction syntax:  sub FFF,FFF
 *               Allowed src regs:  FFF
 *               Allowed dst regs:  FFF
 *     
 *     Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. saturation on data alu results enabled)
 */ 
	asm(.optimize_iasm on);
	asm(sub src2,src_dst);
	asm(.optimize_iasm off);
	return src_dst;
}



	/* L_ADD */
inline Word32 __L_add(register Word32 src_dst, register Word32 src2)
{
/*    Defn: Addition of two 32-bit integer or fractional values,
 *           returning a 32-bit result.
 *     
 *     Hawk V2 instruction syntax:  add FFF,FFF
 *               Allowed src regs:  fff
 *               Allowed dst regs:  fff
 *     
 *     Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. saturation on data alu results enabled)
 */ 
	asm(.optimize_iasm on);
	asm(add src2,src_dst);
	asm(.optimize_iasm off);
	return src_dst;
}



	/* L_SUB */
inline Word32 __L_sub(register Word32 src_dst, register Word32 src2)
{
/*    Defn: Subtraction of two 32-bit integer or fractional values,
 *           returning a 32-bit result.
 *     
 *     Hawk V2 instruction syntax:  sub FFF,FFF
 *               Allowed src regs:  fff
 *               Allowed dst regs:  fff
 *     
 *     Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. saturation on data alu results enabled)
 */ 
	asm(.optimize_iasm on);
	asm(sub src2,src_dst);
	asm(.optimize_iasm off);
	return src_dst;
}



#pragma mark -
#pragma mark <<<< Rounding >>>>

#pragma warn_implicitconv off
	/* ROUND */
inline Word16 __builtin_round(register Word32 lvar1)
{
/*    Defn: Rounds a 32-bit fractional value into a 16-bit result.
 *           When an accumulator is the destination, zeroes out the LSP portion.
 *     
 *     Hawk V2 instruction syntax:  rnd fff
 *               Allowed src regs:  fff
 *               Allowed dst regs:  (same)
 *     
 *     Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. saturation on data alu results enabled)
 *     Assumptions: OMR's R  bit was set to 1 at least 3 cycles before this code.
 *                  (i.e. 2's complement rounding, not convergent rounding)
 */
	asm(.optimize_iasm on);
	asm(rnd lvar1);
	asm(.iasm_use__LSR16_STOL_IASM02 on;
		lsr16 lvar1,lvar1;
		.iasm_use__LSR16_STOL_IASM02 off;);	
	asm(.optimize_iasm off);
	return lvar1;
}
#pragma warn_implicitconv reset



#pragma mark -
#pragma mark <<<< Shift >>>>

	/* SHLFTNS */
inline Word16 __shlftNs(register Word16 sval2shft, register Word16 s_shftamount)
{
/*    Defn: Arithmetic shift of 16-bit value by a specified shift amount.
 *           If the shift count is positive, a left shift is performed.
 *           Otherwise, a right shift is performed.
 *           Saturation DOES NOT occur during a left shift.
 *           When an accumulator is the destination, zeroes out the LSP portion.
 *     
 *     Hawk V2 instruction syntax:  asll.l EEE,FFF
 *               Allowed src regs:  FFF (value to shift) and EEE (shift amount)
 *               Allowed dst regs:  FFF
 *    
 *     Note: "asll.w" is not bidirectional, so "asll.l" is used instead.
 *   
 *   Note: Ignores upper N-5 bits of s_shftamount (except the sign bit (MSB)).
 */
	asm(.optimize_iasm on);
	asm(asll.l s_shftamount,sval2shft);
	asm(	/*	.iasm_sideeffects off;*/ .iasm_reg2regsetcopyflag off;
		move.w sval2shft,sval2shft;            // zeros out FF0 portion
			/*.iasm_sideeffects on; */.iasm_reg2regsetcopyflag on;);
	asm(.optimize_iasm off);
	return sval2shft;
}



	/* SHRTNS */
inline Word16 __shrtNs(register Word16 sval2shft, register Word16 s_shftamount)
{
/*    Defn: Arithmetic shift of 16-bit value by a specified shift amount.
 *           If the shift count is positive, a right shift is performed.
 *           Otherwise, a left shift is performed.
 *           Saturation DOES NOT occur during a left shift.
 *           When an accumulator is the destination, zeroes out the LSP portion.
 *     
 *     Hawk V2 instruction syntax:  asrr.l EEE,FFF
 *               Allowed src regs:  FFF (value to shift) and EEE (shift amount)
 *               Allowed dst regs:  FFF
 *    
 *     Note: "asrr.w" is not bidirectional, so "asrr.l" is used instead.
 *   
 *   Note: Ignores upper N-5 bits of s_shftamount (except the sign bit (MSB)).
 */
	asm(.optimize_iasm on);
	asm(asrr.l s_shftamount,sval2shft);
	asm(	/*	.iasm_sideeffects off;*/ .iasm_reg2regsetcopyflag off;
		move.w sval2shft,sval2shft;            // zeros out FF0 portion
			/*.iasm_sideeffects on; */.iasm_reg2regsetcopyflag on;);
	asm(.optimize_iasm off);
	return sval2shft;
}



	/* L_SHLFTNS */
inline Word32 __L_shlftNs(register Word32 lval2shft, register Word16 s_shftamount)
{
/*  Defn: Arithmetic shift of 32-bit value by a specified shift amount.
 *        If the shift count is positive, a left shift is performed.
 *        Otherwise, a right shift is performed.
 *        Saturation DOES NOT occur during a left shift.
 *  
 *  Hawk V2 instruction syntax:  asll.l EEE,FFF
 *            Allowed src regs:  fff (value to shift) and EEE (shift amount)
 *            Allowed dst regs:  fff
 */ 
	asm(.optimize_iasm on);
	asm(asll.l s_shftamount,lval2shft);
	asm(.optimize_iasm off);
	return lval2shft;
}



	/* L_SHRTNS */
inline Word32 __L_shrtNs(register Word32 lval2shft, register Word16 s_shftamount)
{
/*  Defn: Arithmetic shift of 32-bit value by a specified shift amount.
 *        If the shift count is positive, a right shift is performed.
 *        Otherwise, a left shift is performed.
 *        Saturation DOES NOT occur during a left shift.
 *  
 *  Hawk V2 instruction syntax:  asrr.l EEE,FFF
 *            Allowed src regs:  fff (value to shift) and EEE (shift amount)
 *            Allowed dst regs:  fff
 */
   asm(.optimize_iasm on);
   asm(asrr.l s_shftamount,lval2shft);
   asm(.optimize_iasm off);
   return lval2shft;
}


	/* SHL */
inline Word16 __shl(register Word16 sval2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic shift of 16-bit value by a specified shift amount.
   //       If the shift count is positive, a left shift is performed.
   //       Otherwise, a right shift is performed.
   //       Saturation may occur during a left shift.
   //       When an accumulator is the destination, zeroes out the LSP portion.
   //
   // NOTE: This operation is NOT optimal on the DSP56800E because of the
   //       saturation requirements and the bidirectional capability.
   //       See the intrinsic "shlftNs" or "shlfts" which are more optimal.
   //
   // NOTE: If s_shftamount is a constant, the Compiler should do the following:
   //          - if (s_shftamount == 0)
   //               emit no code for this routine        - Complexity Weight: 0
   //          - if (0 < s_shftamount)
   //               emit code for shlfts routine instead - Complexity Wt: 8, 12
   //          - if (-16 < s_shftamount <= -1)
   //               emit code for shrtNs routine instead - Complexity Weight: 3
   //          - if (MAX_NEG < s_shftamount <= -16)
   //               emit the following code:
   //                  "asrr.w #15,sval2shft"            - Complexity Weight: 1
   //
   //       >>>>>>  If s_shftamount is NOT a constant, only then
   //       >>>>>>  should the Compiler use the code below!
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed s_shftamount regs:  EEE
   //           Allowed sval2shft    regs:  EEE
   // 
   // Complexity Weight:            8 when left  shift, normal shift occurs
   //                              17 when left  shift, value out of range
   //                              17 when left  shift, saturation occurs
   //                              23 when right shift, normal shift occurs
   //                              24 when right shift, value out of range
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)
   //
   // Note: Comments located in test file.

   register Word16 nbr_ldg_bits;
   register Word32 l;

   asm(.optimize_iasm on);
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w sval2shft,l;
		.iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );
   asm(clb	l,nbr_ldg_bits);
   asm(cmp.w	s_shftamount,nbr_ldg_bits);
   asm(bhs	<lft_nosat_shl1);
   asm(nop);
   asm(nop);
   asm(bge	<isneg_shl1);
   asm(asll.w	nbr_ldg_bits,l);
   asm(nop);
//   asm(brad	<done_shl1);
   asm(asl	l);
   asm(	/*	.iasm_sideeffects off;*/ .iasm_reg2regsetcopyflag off;
	   move.w	l.1,l;
		/*.iasm_sideeffects on; */.iasm_reg2regsetcopyflag on;);
   asm(bra	<done_shl1); // 
   asm(isneg_shl1:);
   asm(cmp.w	#-15,s_shftamount);
   asm(blt	<big_rt_shl1);
   asm(neg	s_shftamount);
   asm(nop);
//   asm(brad	<done_shl1);
   asm(asrr.w	s_shftamount,l);
   asm(neg	s_shftamount);
   asm(bra	<done_shl1); // 
   asm(big_rt_shl1:);
   asm(asrr.w	#15,l);
   asm(bra	<done_shl1);
   asm(lft_nosat_shl1:);
   asm(asll.w	s_shftamount,l);
   asm(done_shl1:);
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w l.1,sval2shft;            // zeros out FF0 portion
	   .iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );
   asm(.optimize_iasm off);
   return sval2shft;
}



	/* SHR */
inline Word16 __shr(register Word16 sval2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic shift of 16-bit value by a specified shift amount.
   //       If the shift count is positive, a right shift is performed.
   //       Otherwise, a left shift is performed.
   //       Saturation may occur during a left shift.
   //       When an accumulator is the destination, zeroes out the LSP portion.
   //
   // NOTE: This operation is NOT optimal on the DSP56800E because of the
   //       saturation requirements and the bidirectional capability.
   //       See the intrinsic "shrtNs" which is more optimal.
   //
   // NOTE: If s_shftamount is a constant, the Compiler should do the following:
   //          - if (s_shftamount == 0)
   //               emit no code for this routine        - Complexity Weight: 0
   //          - if (0 < s_shftamount < 15)
   //               emit code for shrtNs routine instead - Complexity Weight: 3
   //          - if (15 <= s_shftamount <= MAX_POS)
   //               emit the following code:
   //                  "asrr.w #15,sval2shft"            - Complexity Weight: 1
   //          - if (-16 < s_shftamount <= -1)
   //               emit code for shlfts routine instead - Complexity Wt: 8, 12
   //          - if (MAX_NEG < s_shftamount <= -16)
   //               emit the following code:
   //                  asm(tst.w	sval2shft);
   //                  asm(move.w	#$8000,sval2shft);
   //                  asm(blt		done);
   //                  asm(neg		sval2shft);
   //                  asm(done:);                         -Complexity Wt: 8, 7
   //
   //       >>>>>>  If s_shftamount is NOT a constant, only then
   //       >>>>>>  should the Compiler use the code below!
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed s_shftamount regs:  EEE
   //           Allowed sval2shft    regs:  EEE
   // 
   // Complexity Weight:            7 when right shift, normal shift occurs
   //                              13 when right shift, value out of range
   //                              22 when left  shift, normal shift occurs
   //                              24 when left  shift, value out of range
   //                              24 when left  shift, saturation occurs
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)
   //
   // Note: Comments located in test file.

   register Word16 nbr_ldg_bits;
   register Word32 l;

   asm(.optimize_iasm on);
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w sval2shft,l;
		.iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );
   asm(cmp.w	#15,s_shftamount);
   asm(bls	<is_shr);
   asm(nop);
   asm(nop);
   asm(bgt	<bigpos_shr);
   asm(clb	l,nbr_ldg_bits);
   asm(neg	s_shftamount);
   asm(cmp.w	s_shftamount,nbr_ldg_bits);
   asm(blt	<sat_shr);
   asm(asll.w	s_shftamount,l);
   asm(neg	s_shftamount);
   asm(bra	<done_shr);
sat_shr:
   asm(asll.w	nbr_ldg_bits,l);
   asm(neg	s_shftamount);
//   asm(brad	<done_shr);
   asm(asl	l);
   asm(	/*	.iasm_sideeffects off;*/ .iasm_reg2regsetcopyflag off;
		move.w l.1,sval2shft;            // zeros out FF0 portion
			/*.iasm_sideeffects on; */.iasm_reg2regsetcopyflag on;);
   asm(bra	<done_shr);
bigpos_shr:
   asm(asrr.w	#15,l);
   asm(bra	<done_shr);
is_shr:
   asm(asrr.w	s_shftamount,l);
done_shr:
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w l.1,sval2shft;            // zeros out FF0 portion
	   .iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );
   asm(.optimize_iasm off);
   return sval2shft;
}


	/* SHR_R */
inline Word16 __shr_r(register Word16 s_val2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic shift of 16-bit value by a specified shift amount.
   //       If the shift count is positive, a right shift is performed.
   //       Otherwise, a left shift is performed.
   //       If a right shift is performed, then rounding performed on result.
   //       Saturation may occur during a left shift.
   //       When an accumulator is the destination, zeroes out the LSP portion.
   //
   // NOTE: This operation is NOT optimal on the DSP56800E because of the
   //       saturation requirements and the bidirectional capability.
   //       See the intrinsic "shrtNs" which is more optimal.
   //
   // NOTE: If s_shftamount is a constant, the Compiler should do the following:
   //          - if (s_shftamount == 0)
   //               emit no code for this routine        - Complexity Weight: 0
   //          - if (0 < s_shftamount < 15)
   //               emit code for shrtNs routine instead - Complexity Weight: 3
   //          - if (15 <= s_shftamount <= MAX_POS)
   //               emit the following code:
   //                  "move.w #0,sval2shft"            - Complexity Weight: 1
   //          - if (-16 < s_shftamount <= -1)
   //               emit code for shlfts routine instead - Complexity Wt: 8, 12
   //          - if (MAX_NEG < s_shftamount <= -16)
   //               emit the following code:
   //                  asm(tst.w	sval2shft);
   //                  asm(move.w	#$8000,sval2shft);
   //                  asm(blt		done);
   //                  asm(neg		sval2shft);
   //                  asm(done:);                         -Complexity Wt: 8, 7
   //
   //       >>>>>>  If s_shftamount is NOT a constant, only then
   //       >>>>>>  should the Compiler use the code below!
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed s_shftamount regs:  EEE
   //           Allowed sval2shft    regs:  FF   <<<<<< NOTE !!!!!!!!!
   // 
   // Complexity Weight:            9 when right shift, normal shift occurs
   //                              15 when right shift, value out of range
   //                              22 when left  shift, normal shift occurs
   //                              24 when left  shift, value out of range
   //                              24 when left  shift, saturation occurs
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)
   //
   // Note: Comments located in test file.

   register Word16 nbr_ldg_bits;
   register Word32 l;
   

   asm(.optimize_iasm on);
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w s_val2shft,l;
		.iasm_sideeffects on; .iasm_reg2regsetcopyflag on;);
   asm(cmp.w	#15,s_shftamount);
   asm(bls	<is_shrr);
   asm(nop);
   asm(nop);
   asm(bgt	<bigpos_shrr);
   asm(clb	l,nbr_ldg_bits);
   asm(neg	s_shftamount);
   asm(cmp.w	s_shftamount,nbr_ldg_bits);
   asm(blt	<sat_shrr);
   asm(asll.w	s_shftamount,l);
   asm(neg	s_shftamount);
   asm(bra	<done_shrr);
   asm(sat_shrr:);
   asm(asll.w	nbr_ldg_bits,l);
   asm(neg	s_shftamount);
//US   asm(brad	<done_shrr);
   asm(asl l);
   asm(	/*	.iasm_sideeffects off;*/ .iasm_reg2regsetcopyflag off;
		move.w l.1,l;            // zeros out FF0 portion
			/*.iasm_sideeffects on; */.iasm_reg2regsetcopyflag on;);
   asm(bra	<done_shrr); //US
   asm(bigpos_shrr:);
   asm(move.w	#0,l);
   asm(bra done_shrr);
   asm(is_shrr:);
   asm(asrr.l	s_shftamount,l);
   
   asm(rnd	l);                  // Note: sval2shft must be in FF!
   asm(done_shrr:);
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w l.1,s_val2shft;            // zeros out FF0 portion
	   .iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );

   asm(.optimize_iasm off);
   return s_val2shft;
}


	/* L_SHL */
inline Word32 __L_shl(register Word32 lval2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic shift of 32-bit value by a specified shift amount.
   //       If the shift count is positive, a left shift is performed.
   //       Otherwise, a right shift is performed.
   //       Saturation may occur during a left shift.
   //       When an accumulator is the destination, zeroes out the LSP portion.
   //
   // NOTE: This operation is NOT optimal on the DSP56800E because of the
   //       saturation requirements and the bidirectional capability.
   //       See the intrinsic "L_shlftNs" or "L_shlfts" which are more optimal.
   //
   // NOTE: If s_shftamount is a constant, the Compiler should do the following:
   //          - if (s_shftamount == 0)
   //               emit no code for this routine          -Complexity Wt: 0
   //          - if (0 < s_shftamount)
   //               emit code for L_shlfts routine instead -Complexity Wt: 9, 13
   //          - if (-32 < s_shftamount <= -1)
   //               emit code for L_shrtNs routine instead -Complexity Wt: 2
   //          - if (MAX_NEG < s_shftamount <= -32)
   //               emit the following code:
   //                  "asrr.l #31,sval2shft"              -Complexity Wt: 2
   //
   //       >>>>>>  If s_shftamount is NOT a constant, only then
   //       >>>>>>  should the Compiler use the code below!
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed src regs:  _______
   //           Allowed dst regs:  _______
   // 
   // Complexity Weight:            9 when left  shift, normal shift occurs
   //                              18 when left  shift, value out of range
   //                              18 when left  shift, saturation occurs
   //                              24 when right shift, normal shift occurs
   //                              25 when right shift, value out of range
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)
   //
   // Note: Comments located in test file.

   register Word16 nbr_ldg_bits;

   asm(.optimize_iasm on);
   asm(clb	lval2shft,nbr_ldg_bits);
   asm(cmp.w	s_shftamount,nbr_ldg_bits);
   asm(bhs	<lft_nosat_Lshl1);
   asm(nop);
   asm(nop);
   asm(bge	<isneg_Lshl1);
   asm(asll.l	nbr_ldg_bits,lval2shft);
   asm(asl	lval2shft);
   asm(bra	<done_Lshl1);
   asm(isneg_Lshl1:);
   asm(cmp.w	#-31,s_shftamount);
   asm(blt	<big_rt_Lshl1);
   asm(neg	s_shftamount);
   asm(nop);
//   asm(brad	<done_Lshl1);
   asm(asrr.l	s_shftamount,lval2shft);
   asm(neg	s_shftamount);
   asm(bra	<done_Lshl1); // 
   asm(big_rt_Lshl1:);
   asm(asrr.l	#31,lval2shft);
   asm(bra	<done_Lshl1);
   asm(lft_nosat_Lshl1:);
   asm(asll.l	s_shftamount,lval2shft);
   asm(done_Lshl1:);
   asm(.optimize_iasm off);
   return lval2shft;
}



	/* L_SHR */
inline Word32 __L_shr(register Word32 lval2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic shift of 32-bit value by a specified shift amount.
   //       If the shift count is positive, a right shift is performed.
   //       Otherwise, a left shift is performed.
   //       Saturation may occur during a left shift.
   //       When an accumulator is the destination, zeroes out the LSP portion.
   //
   // NOTE: This operation is NOT optimal on the DSP56800E because of the
   //       saturation requirements and the bidirectional capability.
   //       See the intrinsic "L_shrtNs" which is more optimal.
   //
   // NOTE: If s_shftamount is a constant, the Compiler should do the following:
   //          - if (s_shftamount == 0)
   //               emit no code for this routine          -Complexity Wt: 0
   //          - if (0 < s_shftamount < 31)
   //               emit code for L_shrtNs routine instead -Complexity Wt: 2
   //          - if (31 <= s_shftamount <= MAX_POS)
   //               emit the following code:
   //                  "asrr.l #31,sval2shft"              -Complexity Wt: 2
   //          - if (-32 < s_shftamount <= -1)
   //               emit code for L_shlfts routine instead -Complexity Wt: 9, 13
   //          - if (MAX_NEG < s_shftamount <= -32)
   //               emit the following code:
   //                  asm(tst.l	lval2shft);
   //                  asm(move.l	#$80000000,lval2shft);
   //                  asm(blt		done);
   //                  asm(neg		lval2shft);
   //                  asm(done:);                         -Complexity Wt: 9, 8
   //
   //       >>>>>>  If s_shftamount is NOT a constant, only then
   //       >>>>>>  should the Compiler use the code below!
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed src regs:  _______
   //           Allowed dst regs:  _______
   // 
   // Complexity Weight:            8 when right shift, normal shift occurs
   //                              14 when right shift, value out of range
   //                              23 when left  shift, normal shift occurs
   //                              24 when left  shift, value out of range
   //                              24 when left  shift, saturation occurs
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)
   //
   // Note: Comments located in test file.

   register Word16 nbr_ldg_bits;

   asm(.optimize_iasm on);
   asm(cmp.w	#31,s_shftamount);
   asm(bls	<is_Lshr1);
   asm(nop);
   asm(nop);
   asm(bgt	<bigpos_Lshr1);
   asm(clb	lval2shft,nbr_ldg_bits);
   asm(neg	s_shftamount);
   asm(cmp.w	s_shftamount,nbr_ldg_bits);
   asm(blt	<sat_Lshr1	);
   asm(asll.l	s_shftamount,lval2shft);
   asm(neg	s_shftamount);
   asm(bra	<done_Lshr1);
   asm(sat_Lshr1:);
   asm(asll.l	nbr_ldg_bits,lval2shft);
//   asm(brad	<done_Lshr1);
   asm(neg	s_shftamount);
   asm(asl	lval2shft);
   asm(bra	<done_Lshr1); // 
   asm(bigpos_Lshr1:);
   asm(asrr.l	#31,lval2shft);
   asm(is_Lshr1:);
   asm(asrr.l	s_shftamount,lval2shft);
   asm(done_Lshr1:);
   asm(.optimize_iasm off);
   return lval2shft;
}


	/* L_SHR_R */
inline Word32 __L_shr_r(register Word32 lval2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic shift of 32-bit value by a specified shift amount.
   //       If the shift count is positive, a right shift is performed.
   //       Otherwise, a left shift is performed.
   //       If a right shift is performed, then rounding performed on result.
   //       Saturation may occur during a left shift.
   //
   // NOTE: This operation is NOT optimal on the DSP56800E because of the
   //       saturation requirements and the bidirectional capability.
   //       See the intrinsic "L_shrtNs" which is more optimal.
   //
   // NOTE: If lshftamount is a constant, the Compiler should do the following:`
   //          - if (s_shftamount == 0)
   //               emit no code for this routine			- Complexity Weight: 0
   //          - if (0 < s_shftamount < 31)
   //               emit code for this routine				- Complexity Weight:
   //          - if (15 <= s_shftamount <= MAX_POS)
   //               emit the following code:
   //                  "asrr.l #31,lval2shft"            	- Complexity Weight: 2
   //          - if (-16 < s_shftamount <= -1)
   //               emit code for L_shlfts routine instead	- Complexity Wt: 9, 13
   //          - if (MAX_NEG < s_shftamount <= -16)
   //               emit the following code:
   //                  asm(tst.l	lval2shft);
   //                  asm(move.l	#$80000000,lval2shft);
   //                  asm(blt		done);
   //                  asm(neg		lval2shft);
   //                  asm(done:);							-Complexity Wt: 9, 8
   //
   //       >>>>>>  If s_shftamount is NOT a constant, then
   //       >>>>>>  the Compiler should use the code below!
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed s_shftamount regs:  EEE
   //           Allowed sval2shft    regs:  FF   <<<<<< NOTE !!!!!!!!!
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)
   //
   // Note: Comments located in test file.

   register Word16 nbr_ldg_bits;
   register Word32 l;
   #pragma unused(l)
   
   asm(.optimize_iasm on);
   asm(cmp.w	#31,s_shftamount);
   asm(bls	<is_lshrr);
   asm(nop);
   asm(nop);
   asm(bgt	<bigpos_lshrr);
   asm(clb	lval2shft,nbr_ldg_bits);
   asm(neg	s_shftamount);
   asm(cmp.w	s_shftamount,nbr_ldg_bits);
   asm(blt	<sat_lshrr);
   asm(asll.l	s_shftamount,lval2shft);
   asm(neg	s_shftamount);
   asm(bra	<done_lshrr);
   asm(sat_lshrr:);
   asm(asll.l	nbr_ldg_bits,lval2shft);
   asm(neg	s_shftamount);
//US   asm(brad	<done_shrr);
   asm(asl lval2shft);
   asm(bra	<done_lshrr); //US
   asm(bigpos_lshrr:);
   asm(move.w	#0,lval2shft);
   asm(bra <done_lshrr);
   asm(is_lshrr:);
   asm(tst.w s_shftamount);
   asm(beq	<done_lshrr);
   asm(dec.w s_shftamount);
   asm(asrr.l	s_shftamount,lval2shft);
   asm(asr lval2shft);
   asm(bcc done_lshrr);
   asm(add.l #1,lval2shft);
   asm(done_lshrr:);
   asm(.optimize_iasm off);
   return lval2shft;
}


	/* SHLFTS */
inline Word16 __shlfts(register Word16 sval2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic left shift of 16-bit value by a specified shift amount.
   //       Saturation DOES occur during a left shift if required.
   //       When an accumulator is the destination, zeroes out the LSP portion.
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed src regs:  FFF (value to shift) and EEE (shift amount)
   //           Allowed dst regs:  FFF
   // 
   // Complexity Weight:            8 when no saturation occurs
   //                              12 when saturation occurs
   //
   // Note: This is NOT a bidirectional shift.
   // 
   // Assumptions: Assumed s_shftamount is positive.
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)

   register Word16 nbr_ldg;
   register Word32 l;

   asm(.optimize_iasm on);
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w sval2shft,l;
		.iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );
   asm(clb l,nbr_ldg);
   asm(cmp.w s_shftamount,nbr_ldg);
//   asm(bge <*+6);
   asm(bge shlfts_label1);
   asm(asll.w nbr_ldg,l);
   asm(asl l);
//   asm(brad <*+4);
   asm(	/*	.iasm_sideeffects off;*/ .iasm_reg2regsetcopyflag off;
	   move.w	l.1,l;
		/*.iasm_sideeffects on; */.iasm_reg2regsetcopyflag on;);
   asm(nop);
   asm(bra shlfts_label2);
shlfts_label1:
   asm(asll.w s_shftamount,l);
shlfts_label2:
   asm(	.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w l.1,sval2shft;            // zeros out FF0 portion
	   .iasm_sideeffects on; .iasm_reg2regsetcopyflag on;
	  );
   asm(.optimize_iasm off);
   return sval2shft;
}



	/* L_SHLFTS */
inline Word32 __L_shlfts(register Word32 lval2shft, register Word16 s_shftamount)
{
   // Defn: Arithmetic left shift of 32-bit value by a specified shift amount.
   //       Saturation DOES occur during a left shift if required.
   // 
   // Hawk V2 instruction syntax:  
   //           Allowed src regs:  FFF (value to shift) and EEE (shift amount)
   //           Allowed dst regs:  FFF
   // 
   // Complexity Weight:            9 when no saturation occurs
   //                              13 when saturation occurs
   //
   // Note: This is NOT a bidirectional shift.
   // 
   // Assumptions: Assumed s_shftamount is positive.
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)

   register Word16 nbr_ldg;

   asm(.optimize_iasm on);
   asm(clb lval2shft,nbr_ldg);
   asm(cmp.w s_shftamount,nbr_ldg);
   asm(bge L_shlfts_label1);
   asm(asll.l nbr_ldg,lval2shft);
   asm(asl lval2shft);
   asm(bra L_shlfts_label2);
L_shlfts_label1:
   asm(asll.l s_shftamount,lval2shft);
L_shlfts_label2:
   asm(.optimize_iasm off);
   return lval2shft;
}



#pragma mark -
#pragma mark <<<< Multiply/MAC >>>>

	/* L_MAC */
inline Word32 __L_mac(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*  Defn: Multiply two 16-bit fractional values and add to 32-bit
 *        fractional value, generating a 32-bit result,
 *        saturating if necessary.
 *  
 *  Hawk V2 instruction syntax:  mac FFF1,FFF1,FFF
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  fff
 *  
 * Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *            (i.e. saturation on data alu results enabled)
 */
   asm(.optimize_iasm on);
   asm(.iasm_sideeffects off; mac sinp1,sinp2,laccum; .iasm_sideeffects on;);
   asm(.optimize_iasm off);
   return laccum;
}



#pragma warn_implicitconv off
	/* MAC_R */
inline Word16 __mac_r(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*  Defn: Multiply two 16-bit fractional values and add to 32-bit
 *        fractional value.
 *        Round into a 16-bit result, saturating if necessary.
 *        When an accumulator is the destination, zeroes out the LSP portion.
 *  
 *  Hawk V2 instruction syntax:  macr FFF1,FFF1,FFF
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  FFF
 *  
 *  Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *               (i.e. saturation on data alu results enabled)
 *  Assumptions: OMR's R  bit was set to 1 at least 3 cycles before this code.
 *               (i.e. 2's complement rounding, not convergent rounding)
 */
	asm(.optimize_iasm on);
	asm(macr sinp1,sinp2,laccum);
	asm(.iasm_use__LSR16_STOL_IASM02 on;
		lsr16 laccum,laccum;
		.iasm_use__LSR16_STOL_IASM02 off;);	
	asm(.optimize_iasm off);
	return laccum;
}
#pragma warn_implicitconv reset



	/* L_MSU */

inline Word32 __L_msu(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*  Defn: Multiply two 16-bit fractional values and subtract this product
 *        from a 32-bit fractional value, saturating if necessary.
 *        Generates a 32-bit result.
 *  
 *  Hawk V2 instruction syntax:  mac -FFF1,FFF1,FFF
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  fff
 *  
 *  Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *               (i.e. saturation on data alu results enabled)
 */ 
	asm(.optimize_iasm on);
	asm(.iasm_sideeffects off; mac -sinp1,sinp2,laccum; .iasm_sideeffects on;);
	asm(.optimize_iasm off);
	return laccum;
}



#pragma warn_implicitconv off
	/* MSU_R */
inline Word16 __msu_r(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*  Defn: Multiply two 16-bit fractional values and subtract this product
 *        from a 32-bit fractional value.
 *        Round into a 16-bit result, saturating if necessary.
 *        When an accumulator is the destination, zeroes out the LSP portion.
 *  
 *  Hawk V2 instruction syntax:  macr -FFF1,FFF1,FFF
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  FFF
 *  
 *  Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *               (i.e. saturation on data alu results enabled)
 */ 
	asm(.optimize_iasm on);
	asm(macr -sinp1,sinp2,laccum);
	asm(.iasm_use__LSR16_STOL_IASM02 on;
		lsr16 laccum,laccum;
		.iasm_use__LSR16_STOL_IASM02 off;);
	asm(.optimize_iasm off);
	return laccum;
}
#pragma warn_implicitconv reset



	/* MULT */
inline Word16 __mult(register Word16 sinp1, register Word16 sinp2)
{
/*  Defn: Multiply two 16-bit fractional values and
 *        truncate into a 16-bit fractional result.
 *        Saturates only for the case of $8000 x $8000.
 *        When an accumulator is the destination, zeroes out the LSP portion.
 *  
 *  Hawk V2 instruction syntax:  mpy FFF1,FFF1,FFF
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  FFF
 *  
 *  Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *               (i.e. saturation on data alu results enabled)
 */ 
	register Word16 sresult;
	asm(.optimize_iasm on);
	asm(mpy sinp1,sinp2,sresult);
	asm(	/*	.iasm_sideeffects off;*/ .iasm_reg2regsetcopyflag off;
		move.w sresult,sresult;            // extra instruction zeroes LSP
			/*.iasm_sideeffects on; */.iasm_reg2regsetcopyflag on;);
	asm(.optimize_iasm off);
	return sresult;
}



	/* L_MULT */
inline Word32 __L_mult(register Word16 sinp1, register Word16 sinp2)
{
/*  Defn: Multiply two 16-bit fractional values 
 *        generating a signed 32-bit fractional result.
 *        Saturates only for the case of $8000 x $8000.
 *  
 *  Hawk V2 instruction syntax:  mpy FFF1,FFF1,FFF
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  fff
 *  
 *  Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *               (i.e. saturation on data alu results enabled)
 */ 
	register Word32 laccum;
	asm(.optimize_iasm on);
    asm(.iasm_sideeffects off; mpy sinp1,sinp2,laccum; .iasm_sideeffects on;);
	asm(.optimize_iasm off);
	return laccum;
}



	/* MULT_R */
inline Word16 __mult_r(register Word16 sinp1, register Word16 sinp2)
{
/*  Defn: Multiply two 16-bit fractional values,
 *        round into a 16-bit fractional result.
 *        Saturates only for the case of $8000 x $8000.
 *        When an accumulator is the destination, zeroes out the LSP portion.
 *  
 *  Hawk V2 instruction syntax:  mpyr FFF1,FFF1,FFF
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  FFF
 *  
 *  Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
 *               (i.e. saturation on data alu results enabled)
 *  Assumptions: OMR's R  bit was set to 1 at least 3 cycles before this code.
 *               (i.e. 2's complement rounding, not convergent rounding)
 */
	register Word16 sresult;
	asm(.optimize_iasm on);
	asm(mpyr sinp1,sinp2,sresult);
	asm(.optimize_iasm off);
	return sresult;
}


	/* L_MULT_LS */
inline Word32 __L_mult_ls(register Word32 linp1, register Word16 sinp2)
{
   // Defn: Multiply one 32-bit and one 16-bit fractional value,
   //       generating a signed 32-bit fractional result.
   //       Saturates only for the case of $8000:0000 x $8000.
   // 
   // Hawk V2 instruction syntax:    (see below sequence)
   //           Allowed linp1 regs:  Y  only      <========== NOTE!
   //           Allowed sinp2 regs:  X0 only      <========== NOTE!
   //           Allowed dst   regs:  FF
   // 
   // Assumptions: OMR's SA bit was set to 1 at least 3 cycles before this code.
   //              (i.e. saturation on data alu results enabled)

	register Word32 ldst;
	asm(.optimize_iasm on);
	asm(.iasm_sideeffects off;	/*.iasm_reg2regsetcopyflag off*/;
		move.w sinp2,x0;
		.iasm_sideeffects on;	/*.iasm_reg2regsetcopyflag on;*/);
	asm(/*.iasm_sideeffects off;*/	.iasm_reg2regsetcopyflag off;
		tfr linp1,y;
		/*.iasm_sideeffects on;*/	.iasm_reg2regsetcopyflag on;);
	asm(mpysu x0,y0,ldst);
	asm(asr16 ldst,ldst);
	asm(mac   x0,y1,ldst);
	asm(.optimize_iasm off);
	return ldst;
}


#pragma mark -
#pragma mark <<<< Normalization >>>>

	/* NORM_S */
inline Word16 __norm_s(register Word16 ssrc)
{
/*  Defn: Computes the number of left shifts required to normalize
 *        a 16-bit value, returning a 16-bit result.
 *        Returns a shift count of 0 for an input of $0000.
 *  
 *  Hawk V2 instruction syntax:  clb FFF,EEE
 *            Allowed src regs:  FFF
 *            Allowed dst regs:  EEE
 *  
 *  Note: Does not actually normalize the value!
 * 
 *  NOTE: This operation is NOT optimal on the DSP56800E because of the
 *        case of returning 0 for an input of $0000.
 *        See the intrinsic "ffs_s" which is more optimal but generates
 *       a different value for the case where the input == $0000.
 *
 *  Note: The temporary variable (tmp16) used in the assembly code below
 *        can be (and should be) any of the 7 general data alu registers.
 *  
 *  Algorithm for correct operation (due to case where value = $0000):
 *        tmp16 = -31;                // correction for case of value = $0000
 *        if (ssrc != 0)
 *           tmp16 = 0;               // i.e., no correction required
 *        sdst = use_DSP56800E_CLB_instruction();
 *        sdst += tmp16;              // apply correction here
 */ 
	register Word16 tmp16;
	register Word16 sdst;
	asm(.optimize_iasm on);
	asm(move.w -31,tmp16);			/* temp variable (any of FFF1) holds -31	*/
	asm(tst.w ssrc);				/*      if (ssrc != 0)						*/
	asm(beq norm_s_label1);			/*      { tmp16 = 0;						*/
	asm(clr.w tmp16);				/*      }									*/
norm_s_label1:
	asm(clb ssrc,sdst);				/* Correct for all cases except ssrc == 0x0	*/
	asm(add tmp16,sdst);			/* Now correct for all cases				*/
	asm(.optimize_iasm off);
	return sdst;
}



	/* NORM_L */
inline Word16 __norm_l(register Word32 lsrc)
{
/*  Defn: Computes the number of left shifts required to normalize
 *        a 32-bit value, returning a 16-bit result.
 *        Returns a shift count of 0 for an input of $00000000.
 *  
 *  Hawk V2 instruction syntax:  clb FFF,EEE
 *            Allowed src regs:  FFF
 *            Allowed dst regs:  EEE
 *  
 *  Note: Does not actually normalize the value!
 * 
 *  NOTE: This operation is NOT optimal on the DSP56800E because of the
 *        case of returning 0 for an input of $00000000.
 *        See the intrinsic "ffs_l" which is more optimal but generates
 *        a different value for the case where the input == $0000.
 * 
 *  Note: The temporary variable (tmp16) used in the assembly code below
 *        can be (and should be) any of the 7 general data alu registers.
 *  
 *  Algorithm for correct operation (due to case where value = $00000000):
 *        tmp16 = -31;                // correction for case of value = $0
 *        if (ssrc != 0)
 *           tmp16 = 0;               // i.e., no correction required
 *        sdst = use_DSP56800E_CLB_instruction();
 *        sdst += tmp16;              // apply correction here
 */
	register Word16 tmp16;
	register Word16 sdst;
	asm(.optimize_iasm on);
	asm(move.w -31,tmp16);			/* temp variable (any of FFF1) holds -31	*/
	asm(tst.l lsrc);				/*      if (lsrc != 0)						*/
	asm(beq norm_l_label1);			/*      { tmp16 = 0;						*/
	asm(clr.w tmp16);				/*      }									*/
norm_l_label1:
	asm(clb lsrc,sdst);				/* Correct for all cases except lsrc == 0x0	*/
	asm(add tmp16,sdst);			/* Now correct for all cases				*/
	asm(.optimize_iasm off);
	return sdst;
}



	/* FFS_S */
inline Word16 __ffs_s(register Word16 ssrc)
{
/*  Defn: Computes the number of left shifts required to normalize
 *        a 16-bit value, returning a 16-bit result (finds 1st sign bit).
 *        Returns a shift count of 31 for an input of $0000.
 *  
 *  Hawk V2 instruction syntax:  clb FFF,EEE
 *            Allowed src regs:  FFF
 *            Allowed dst regs:  EEE
 *  
 *  Note: Does not actually normalize the value!
 * 
 *  NOTE: Also see the intrinsic "norm_s" which handles the case
 *        where the input == $0000 differently.
 */
 	register Word16 sdst;
	asm(.optimize_iasm on);
	asm(clb ssrc,sdst);		/* Same as norm_s for all cases except ssrc == 0x0 */
	asm(.optimize_iasm off);
	return sdst;
}



	/* FFS_L */
inline Word16 __ffs_l(register Word32 lsrc)
{
/*  Defn: Computes the number of left shifts required to normalize
 *        a 32-bit value, returning a 16-bit result (finds 1st sign bit).
 *        Returns a shift count of 31 for an input of $00000000.
 *  
 *  Hawk V2 instruction syntax:  clb FFF,EEE
 *            Allowed src regs:  FFF
 *            Allowed dst regs:  EEE
 *  
 *  Note: Does not actually normalize the value!
 * 
 *  NOTE: Also see the intrinsic "norm_l" which handles the case
 *        where the input == $0000 differently.
 */	
 	register Word16 sdst;
	asm(.optimize_iasm on);
	asm(clb lsrc,sdst);		/* Same as norm_l for all cases except lsrc == 0x0 */
	asm(.optimize_iasm off);
	return sdst;
}



#pragma mark -
#pragma mark <<<< Division >>>>

	/* DIV_S */
inline Word16 __div_s(register Word16 s_denominator, register Word16 s_numerator)
{
   // Defn: Single quadrant division (i.e. both operands positive) of
   //       two 16-bit fractional values, returning a 16-bit result.
   //       If both operands are equal, returns $7FFF (occurs naturally).
   // 
   // Hawk V2 instruction syntax:  div FFF1,fff   --looped on this instruction
   //           Allowed regs for s_numerator:    fff
   //           Allowed regs for s_denominator:  FFF1
   // 
   // Note: Does not check for division overflow cases.
   // 
   // Note: Does not check for divide by zero cases.

	register Word32 l;
	asm(.optimize_iasm on);
	asm(tst a);						// LEAVE INSTRUCTION AS IS - DO NOT CHG THIS!
									// (also: must not affect register allocator)
									// (this instruction simply clears the C bit)
	asm(	.iasm_sideeffects off;	.iasm_reg2regsetcopyflag off;
			move.w s_numerator,l;	// ensures correctly sign extended
			.iasm_sideeffects on;	.iasm_reg2regsetcopyflag on
		);
	asm(rep 8);						// Note: Repeat loop broken into 2 loops.
	asm(div s_denominator,l);
	asm(rep 8);						// (done to reduce interrupt latency)
	asm(div s_denominator,l);
	asm(asl16 l,s_numerator);		// move result from FF0 portion to FF1
	asm(move.w s_numerator,s_numerator);	// correct sign extension
											// Example Usage:   move.w A1,A
	asm(.optimize_iasm off);
	return s_numerator;
}



	/* DIV_LS */
inline Word16 __div_ls(register Word16 s_denominator, register Word32 l_numerator)
{
   // Defn: Single quadrant division (i.e. both operands positive) of
   //       a 32-bit fractional dividend and a 16-bit fractional divisor,
   //       returning a 16-bit result.
   //       If both operands are equal, returns $7FFF (occurs naturally).
   // 
   // Hawk V2 instruction syntax:  div FFF1,fff   (looped on this instruction)
   //           Allowed regs for s_numerator:    fff
   //           Allowed regs for s_denominator:  FFF1
   // 
   // Note: Does not check for division overflow cases.
   // 
   // Note: Does not check for divide by zero cases.

	register Word16 rls;
	asm(.optimize_iasm on);
	asm(tst a);					// LEAVE INSTRUCTION AS IS - DO NOT CHG THIS!
								// (also: must not affect register allocator)
								// (this instruction simply clears the C bit)
	asm(rep 8);					// Note: Repeat loop broken into 2 loops.
	asm(div s_denominator,l_numerator);
	asm(rep 8);					// (done to reduce interrupt latency)
	asm(div s_denominator,l_numerator);
	asm(asl16 l_numerator,rls);		// move result from FF0 portion to FF1
	asm(move.w rls,rls);				// correct sign extension
									// Example Usage:   move.w A1,A
	asm(.optimize_iasm off);
	return rls;
}



	/* div_s_4q */
inline Word16 __div_s4q(register Word16 s_numerator, register Word16 s_denominator)
{

	register Word16 numer_sign;
	register Word16 rls;
	register Word32 l;
	#pragma unused(rls)

	asm(.optimize_iasm on);
	/*-=-=-=-=-=-=-= Setup =-=-=-=-=-=-=-*/
	asm(.iasm_sideeffects off;	 .iasm_reg2regsetcopyflag off;
		move.w s_numerator,l;		/* ensures correctly sign extended	*/
		.iasm_sideeffects on;	.iasm_reg2regsetcopyflag on	
		);
	asm(.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w l,numer_sign;  			/* Save Sign Bit of dividend (B1) in MSB of Y1 */
		.iasm_sideeffects on;  .iasm_reg2regsetcopyflag on
		);

	asm(abs l); 	/* Force dividend positive						*/
	asm(tst a);		/*  LEAVE INSTRUCTION AS IS - DO NOT CHG THIS!	*/
					/* (also: must not affect register allocator)	*/
					/* (this instruction simply clears the C bit)	*/
	asm(eor.w s_denominator,numer_sign);/* Save sign bit of quotient in N bit of SR */
	
	/*-=-=-=-=-=-=-= Division =-=-=-=-=-=-=-*/
	asm(rep 8);               			/* Note: Repeat loop broken into 2 loops.	*/
	asm(div s_denominator,l);
	asm(rep 8);               			/* (done to reduce interrupt latency)		*/
	asm(div s_denominator,l);
	asm(bge div_s_done1);
	asm(neg l);
div_s_done1:
	/* (At this point, the correctly signed quotient	*/ 
	/* is in B0 but the remainder is not correct)		*/
   asm(asl16 l,s_numerator);			/* move result from FF0 portion to FF1	*/
   asm(move.w s_numerator,s_numerator);	/* correct sign extension				*/
										/* Example Usage:   move.w A1,A			*/
   asm(.optimize_iasm off);
   return s_numerator;
}



	/* div_ls_4q */
inline Word16 __div_ls4q(register Word32 l_numerator, register Word16 s_denominator)
{

	register Word16 numer_sign;
	register Word16 rls;

	asm(.optimize_iasm on);
	/*-=-=-=-=-=-=-= Setup =-=-=-=-=-=-=-*/
	asm(.iasm_sideeffects off; .iasm_reg2regsetcopyflag off;
		move.w l_numerator,numer_sign;	/* Save Sign Bit of dividend (B1) in MSB of Y1 */
		.iasm_sideeffects on;  .iasm_reg2regsetcopyflag on
		);

	asm(abs l_numerator); 				/* Force dividend positive						*/
	asm(tst a);							/* LEAVE INSTRUCTION AS IS - DO NOT CHG THIS!	*/
										/* (also: must not affect register allocator)	*/
										/* (this instruction simply clears the C bit)	*/
	asm(eor.w s_denominator,numer_sign);/* Save sign bit of quotient in N bit of SR		*/
	
	/*-=-=-=-=-=-=-= Division =-=-=-=-=-=-=-*/
	asm(rep 8);							/* Note: Repeat loop broken into 2 loops.	*/
	asm(div s_denominator,l_numerator);
	asm(rep 8);							/* (done to reduce interrupt latency)		*/
	asm(div s_denominator,l_numerator);
	asm(bge div_ls_done1);
	asm(neg l_numerator);
div_ls_done1:
	/*; (At this point, the correctly signed		*/
	/*; quotient is in B0 but the remainder is not	*/
	/*; correct)									*/
   asm(asl16 l_numerator,rls);    		/* move result from FF0 portion to FF1	*/
   asm(move.w rls,rls);    		  		/* correct sign extension				*/
                                  		/* Example Usage:   move.w A1,A			*/
   asm(.optimize_iasm off);
   return rls;
}



#pragma mark -
#pragma mark <<<< Deposit/Extract >>>>

	/* L_DEPOSIT_H */
inline Word32 __L_deposit_h(register Word16 ssrc)
{
/*  Defn: Deposits the 16-bit integer or fractional value
 *        into the upper 16-bits of a 32 bit value, and
 *        zeros out the lower 16-bits of a 32-bit value.
 *  
 *  Hawk V2 instruction syntax:  move.w FFF1,fff
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  fff
 *  
 *  Example -   Correct Usage:   move.w A1,C
 *  Example - Incorrect Usage:   move.w A,C    // may incorrectly saturate!
 */ 
	register Word32 ldst;
	asm(.optimize_iasm on);
	asm(/*	.iasm_sideeffects off;*/.iasm_reg2regsetcopyflag off;
		move.w ssrc,ldst;
		/*.iasm_sideeffects on; */	.iasm_reg2regsetcopyflag on);
	asm(.optimize_iasm off);
	return ldst;
}



	/* L_DEPOSIT_L */

inline Word32 __L_deposit_l(register Word16 ssrc)
{
/*  Defn: Deposits the 16-bit integer or fractional value
 *        into the lower 16-bits of a 32 bit value, and
 *        sign extends the upper 16-bits of a 32-bit value.
 *  
 *  Hawk V2 instruction syntax:  asr16 FFF,fff
 *            Allowed src regs:  FFF1
 *            Allowed dst regs:  fff
 *  
 */
	register Word32 ldst;
	asm(.optimize_iasm on);
	asm(/*	.iasm_sideeffects off;*/.iasm_reg2regsetcopyflag off;
		move.w ssrc,ldst;
		/*.iasm_sideeffects on; */	.iasm_reg2regsetcopyflag on);
	asm(asr16 ldst,ldst);
	asm(.optimize_iasm off);
	return ldst;
}



	/* EXTRACT_H */
inline Word16 __extract_h(register Word32 lsrc)
{
/*  Defn: Extracts the 16 MSBs of a 32-bit integer or fractional value.
 *        Returns a 16-bit value.  Will not perform saturation.
 *        When an accumulator is the destination, zeroes out the LSP portion.
 *        Corresponds to "truncation" when applied to fractional values.
 *  
 *  Hawk V2 instruction syntax:  move.w FFF1,FFF
 *            Allowed src regs:  fff
 *            Allowed dst regs:  FFF
 *  
 *  Example -   Correct Usage:   move.w A1,C
 *  Example - Incorrect Usage:   move.w A,C    // may incorrectly saturate! 
 */
 	register Word16 sdst;
	asm(.optimize_iasm on);
	asm(/*	.iasm_sideeffects off;*/.iasm_reg2regsetcopyflag off;
		move.w lsrc.1,sdst;
		/*.iasm_sideeffects on; */	.iasm_reg2regsetcopyflag on);
   asm(.optimize_iasm off);
   return sdst;
}



	/* EXTRACT_L */
inline Word16 __extract_l(register Word32 lsrc)
{
/*  Defn: Extracts the 16 LSBs of a 32-bit integer or fractional value.
 *        Returns a 16-bit value.  Will not perform saturation.
 *        When an accumulator is the destination, zeroes out the LSP portion.
 *  
 *  Hawk V2 instruction syntax:  asl16  fff,FFF
 *            Allowed src regs:  _______
 *            Allowed dst regs:  _______
 *  
 *  ######## Must verify - does asl16 saturate when SA is set?  ----NO.
 */ 
	register Word16 sdst;
	asm(.optimize_iasm on);
	asm(asl16 lsrc,sdst);
	asm(/*	.iasm_sideeffects off;*/.iasm_reg2regsetcopyflag off;
			move.w sdst,sdst;		/* ensures correctly sign extended */
		/*.iasm_sideeffects on; */	.iasm_reg2regsetcopyflag on);
	asm(.optimize_iasm off);
	return sdst;
}



#pragma mark -
#pragma mark <<<< Control >>>>

	/* STOP */
inline void  __stop(void)
{
/*  Defn: Generates a STOP instruction which places the processor in
 *        the low power STOP mode.
 *  
 *  Hawk V2 instruction syntax:  stop
 *            Allowed src regs:  (none used by this function)
 *            Allowed dst regs:  (none used by this function)
 */
	asm(.optimize_iasm on);
	asm(stop);
	asm(.optimize_iasm off);
}



	/* WAIT */
inline void  __wait(void)
{
/*  Defn: Generates a WAIT instruction which places the processor in
 *        the low power WAIT mode.
 *  
 *  Hawk V2 instruction syntax:  wait
 *            Allowed src regs:  (none used by this function)
 *            Allowed dst regs:  (none used by this function)
 */
   asm(.optimize_iasm on);
   asm(wait);
   asm(.optimize_iasm off);
}


	/* TURN ON CONVERGENT ROUNDING */
inline void  __turn_on_conv_rndg(void)
{
   // Defn: Generates a sequence for enabling convergent rounding
   //       by clearing the R   bit in the OMR register and waiting
   //       for the enabling to take effect.
   // 
   // Hawk V2 instruction syntax:  bfclr  #MASK,OMR
   //           Allowed src regs:  (none used by this function)
   //           Allowed dst regs:  (none used by this function)
   // 
   // Complexity Weight:           4

   asm(.optimize_iasm on);
   asm(bfclr #$0020,OMR);
   asm(nop);                 // 2 NOPs added to ensure no dependencies
   asm(nop);
   asm(.optimize_iasm off);
}



	/* TURN OFF CONVERGENT ROUNDING */
inline void  __turn_off_conv_rndg(void)
{
   // Defn: Generates a sequence for disabling convergent rounding
   //       by setting  the R   bit in the OMR register and waiting
   //       for the enabling to take effect.
   // 
   // Note: When convergent rounding is disabled, 2's complement rounding
   //       is then used when rounding is performed.
   // 
   // Hawk V2 instruction syntax:  bfset  #MASK,OMR
   //           Allowed src regs:  (none used by this function)
   //           Allowed dst regs:  (none used by this function)
   // 
   // Complexity Weight:           4

   asm(.optimize_iasm on);
   asm(bfset #$0020,OMR);
   asm(nop);                 // 2 NOPs added to ensure no dependencies
   asm(nop);
   asm(.optimize_iasm off);
}



	/* TURN ON SATURATION */
inline void  __turn_on_sat(void)
{
   // Defn: Generates a sequence for enabling automatic saturation in the
   //       MAC Output Limiter by setting  the SA  bit in the OMR register
   //       and waiting for the enabling to take effect.
   // 
   // Hawk V2 instruction syntax:  bfset  #MASK,OMR
   //           Allowed src regs:  (none used by this function)
   //           Allowed dst regs:  (none used by this function)
   // 
   // Complexity Weight:           4

   asm(.optimize_iasm on);
   asm(bfset #$0010,OMR);
   asm(nop);                 // 2 NOPs added to ensure no dependencies
   asm(nop);
   asm(.optimize_iasm off);
}



	/* TURN OFF SATURATION */
inline void  __turn_off_sat(void)
{
   // Defn: Generates a sequence for disabling automatic saturation in the
   //       MAC Output Limiter by clearing the SA  bit in the OMR register
   //       and waiting for the enabling to take effect.
   // 
   // Hawk V2 instruction syntax:  bfclr  #MASK,OMR
   //           Allowed src regs:  (none used by this function)
   //           Allowed dst regs:  (none used by this function)
   // 
   // Complexity Weight:           4

   asm(.optimize_iasm on);
   asm(bfclr #$0010,OMR);
   asm(nop);                 // 2 NOPs added to ensure no dependencies
   asm(nop);
   asm(.optimize_iasm off);
}


#pragma mark -
#pragma mark <<<< Integer Intrinsics >>>>


/********************************************************************************
 *							INTRINSICS FOR INTEGERS								*
 ********************************************************************************
 */


#pragma mark < Rounding >

/* ROUND_INT */
inline Word16 __round_int(register Word32 lvar1)
{
/*    Defn: Rounds a 32-bit integer value into a 16-bit result.
 *           When an accumulator is the destination, zeroes out the LSP portion.
 *     
 *     Hawk V2 instruction syntax:  rnd fff
 *               Allowed src regs:  fff
 *               Allowed dst regs:  (same)     
 */
	asm(.optimize_iasm on);
	asm(rnd lvar1);
	asm(.iasm_use__LSR16_STOL_IASM02 on;
		lsr16 lvar1,lvar1;
		.iasm_use__LSR16_STOL_IASM02 off;);	
	asm(.optimize_iasm off);
	return (int)lvar1;
}

#pragma mark < Multiplication >

/* MULTIPLICATION */


/* L_mac_int */

inline Word32 __L_mac_int(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*	Defn:	Multiply two 16-bit integer values and add to 32-bit
 *			integer value, generating a 32-bit result.
 *
 *	Hawk V2 instruction syntax:	imac.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 */
   asm(.optimize_iasm on);
   asm(.iasm_sideeffects off; imac.l sinp1,sinp2,laccum; .iasm_sideeffects on;);
   asm(.optimize_iasm off);
   return laccum;
}




/* mac_r_int */

inline Word16 __mac_r_int(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*	Defn:	Multiply two 16-bit integer values and add to 32-bit
 *			integer value. Round into a 16-bit result.
 *
 *	Hawk V2 instruction syntax:	imac.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 *								rnd	fff
 */
	asm(.optimize_iasm on);
	asm(imac.l sinp1,sinp2,laccum);
	asm(rnd laccum);
	asm(.iasm_use__LSR16_STOL_IASM02 on;
		lsr16 laccum,laccum;
		.iasm_use__LSR16_STOL_IASM02 off;);
	asm(.optimize_iasm off);
	return (int)laccum;
}




/* L_msu_int */

inline Word32 __L_msu_int(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*	Defn:	Multiply two 16-bit integer values and substract this product
 *			from a 32-bit integer value. Generates a 32-bit result.
 *	Hawk V2 instruction syntax:	imac.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 *								nega Rn
 */
	asm(.optimize_iasm on);
	
	asm(move.w sinp1, r2);
	asm(nega r2);
	asm(move.w r2, sinp1);
	
	asm(.iasm_sideeffects off; imac.l sinp1,sinp2,laccum; .iasm_sideeffects on;);
	
	asm(.optimize_iasm off);
	return laccum;
}



/* msu_r_int */

inline Word16 __msu_r_int(register Word32 laccum,
                      register Word16 sinp1, register Word16 sinp2)
{
/*	Defn:	Multiply two 16-bit integer values and substract this product
 *			from a 32-bit integer value. Round into a 16-bit result.
 *	Hawk V2 instruction syntax:	imac.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 *								nega Rn
 *								rnd	fff
 */
	asm(.optimize_iasm on);
	
	asm(move.w sinp1, r2);
	asm(nega r2);
	asm(move.w r2, sinp1);
	
	asm(.iasm_sideeffects off; imac.l sinp1,sinp2,laccum; .iasm_sideeffects on;);
	
	asm(rnd laccum);
	asm(.iasm_use__LSR16_STOL_IASM02 on;
		lsr16 laccum,laccum;
		.iasm_use__LSR16_STOL_IASM02 off;);
	asm(.optimize_iasm off);
	return (int)laccum;
}




/* mult_int */

inline Word16 __mult_int(register Word16 sinp1, register Word16 sinp2)
{
/*	Defn:	Multiply two 16-bit integer values and
 *			truncate into a 16-bit integer result.
 *	Hawk V2 instruction syntax:	impy.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 */
	register Word32 sresult;
	register Word16 small_result;
	
	asm(.optimize_iasm on);
	asm(.iasm_sideeffects off;
		impy.l sinp1,sinp2,sresult;
		.iasm_sideeffects on;);
	asm(move.w sresult, small_result);
	asm(.optimize_iasm off);
	return small_result;
}




/* L_mult_int */

inline Word32 __L_mult_int(register Word16 sinp1, register Word16 sinp2)
{
/*	Defn:	Multiply two 16-bit integer values generating
 *			a 32-bit integer result.
 *	Hawk V2 instruction syntax:	impy.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 */
	register Word32 laccum;
	asm(.optimize_iasm on);
    asm(.iasm_sideeffects off; impy.l sinp1,sinp2,laccum; .iasm_sideeffects on;);
	asm(.optimize_iasm off);
	return laccum;
}




/* mult_r_int */

inline Word16 __mult_r_int(register Word16 sinp1, register Word16 sinp2)
{
/*	Defn:	Multiply two 16-bit integer values and
 *			round into a 16-bit integer result.
 *	Hawk V2 instruction syntax:	impy.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 *								rnd	fff
 */
	register Word32 sresult;
	asm(.optimize_iasm on);
	
	asm(.iasm_sideeffects off;
		impy.l sinp1,sinp2,sresult;
		.iasm_sideeffects on;);
	
	asm(rnd sresult);
	asm(.iasm_use__LSR16_STOL_IASM02 on;
		lsr16 sresult,sresult;
		.iasm_use__LSR16_STOL_IASM02 off;);
	asm(.optimize_iasm off);
	return (int)sresult;
}




/* L_mult_ls_int */

inline Word32 __L_mult_ls_int(register Word32 linp1, register Word16 sinp2)
{
/*	Defn:	Multiply one 32-bit and one 16-bit fractional value,
 *			generating a signed 32-bit integer result.
 *	Hawk V2 instruction syntax:	impysu	A1,A0,Y
 *										A1,B0,Y
 *										A1,C0,Y
 *										A1,D0,Y
 *										B1,C0,Y
 *										B1,D0,Y
 *										C1,C0,Y
 *										C1,D0,Y
 *			Allowed src regs:	A0,A1,B0,B1,C0,C1,D0
 *			Allowed dst regs:	Y
 *								imac.l	FFF1,FFF1,fff
 *			Allowed src regs:	FFF1
 *			Allowed dst regs:	fff
 */
	register Word32 ldst;
	asm(.optimize_iasm on);
	asm(.iasm_reg2regsetcopyflag off;
		tfr linp1, b
		.iasm_reg2regsetcopyflag on;);
	asm(.iasm_sideeffects off;
		move.w sinp2, a1
		.iasm_sideeffects on;);
	asm(impysu a1,b0,Y);
	asm(tfr Y,ldst);
	asm(asr16 ldst,ldst);
	asm(imac.l a1,b1,ldst);
	asm(.optimize_iasm off);
	return ldst;
}

/* ******************************************************************************* */

#pragma mark < Division >

/* DIVISION */



/* div_s */
inline Word16 __div_s_int(register Word16 s_denominator, register Word16 s_numerator)
{
/* Defn: Single quadrant division (i.e. both operands positive) of
 *       two 16-bit integer values, returning a 16-bit result.
 *       If both operands are equal, returns $7FFF (occurs naturally).
 */ 
 	register Word16 result;
	result = ARTDIVU16UZ(s_denominator, s_numerator);
	return result;
}



/* div_ls */
inline Word16 __div_ls_int(register Word16 s_denominator, register Word32 l_numerator)
{
/* Defn: Single quadrant division (i.e. both operands positive) of
 *      a 32-bit integer dividend and a 16-bit integer divisor,
 *      returning a 16-bit result.
 *      If both operands are equal, returns $7FFF (occurs naturally).
 */
 	register Word16 result;
	result = F_idiv_uls_canoverflow(s_denominator, l_numerator);
	return result;
}




/* div_s_4q */
inline Word16 __div_s4q_int(register Word16 s_numerator, register Word16 s_denominator)
{
/*	Defn:	Four quadrant division of a 16-bit integer divident and a
 *			16-bit integer divisor, returning a 16-bit result.
 */
	register Word16 result;
	result = ARTDIVS16UZ(s_denominator, s_numerator);
	return result;
}


/* div_ls_4q */
inline Word16 __div_ls4q_int(register Word16 s_denominator, register Word32 l_numerator)
{
/* Defn: Four quadrant division of a 32-bit integer dividend and a
 *		 16-bit integer divisor, returning a 16-bit result.
 */
 	register Word16 result;
	result = F_idiv_ls_canoverflow(s_denominator, l_numerator);
	return result;

}




#undef Word16
#undef Word32
#endif


/********************************************************************************	
 Intrinsics for the DSP56800E Core Family

 Revision History:
1.	12/18/2000   JPG   Initially Written
2.	02/02/2001   JPG   Modified as follows:
                          - src and src_dst were in wrong order for:
                               - add, sub, L_add, L_sub
                          - changed names to match StarCore intrinsics:
                               ==> Removed all leading underscore chars!
                               abs  => abs_s
                               labs => L_abs
                               div  => div_s
                          - added comments about OMR's SA bit
                          - added comments about OMR's R bit for "round"
                          - added "Allowed src regs:" into comments
                          - added "Allowed dst regs:" into comments
                          - removed "sat" instruction from almost all
                          - changed "short" to "Word16"
                          - changed "long"  to "Word32"
                          - redid generated code sequence for norm_s, norm_l
                       Added New Intrinsics:
                          - ffs_s
                          - ffs_l
                          - X_sat     ............................
                          - shlftNs
                          - shrtNs
                          - L_shlftNs
                          - L_shrtNs
                          - L_mult_ls
                          - L_mult_ll
                       Not Yet Completed:
                          - shl
                          - shr
                          - shr_r
                          - L_shl
                          - L_shr
                       Unsure of the need for:
                          - L_MAC0
                          - L_MULT0
                          - L_macNs
                          - L_msuNs
		
3.	02/05/2001   JPG   Modified as follows:
                         - L_sat changed to X_sat
                         - Added "Complexity Weights"
                         - Removed from list - unsure of need for these:
                              - L_MAC0
                              - L_MULT0
                              - L_macNs
                              - L_msuNs
                         - Removed the destination from the input args
                           for the following instrinsics.  Now instead
                           declared as a local variable.
                              - mult
                              - L_mult
                              - mult_r
                              - L_mult_ls
                              - L_mult_ll
                              - L_deposit_h
                              - L_deposit_l
                              - extract_h
                              - extract_l
                         - Corrected the return value for div_s, div_ls:
                              OLD:   return i;
                              NEW:   return s_numerator;

4.	02/07/2001   US	 * 	shlftNs
    					shrtNs
						mult
							:- added iasm directives

					 *	round
						mac_r
						msu_r
							:- added LSR16 to counter implicit long to short 
							   type conversion.
					 *	shl
						shr
						shr_r
						L_shl
						L_shr
						L_sat
							:- Commented out.

					 *	mult
						L_mult
						mult_r
						norm_s
						norm_l
						ffs_s
						ffs_l
						L_deposit_h
						L_deposit_l
						extract_h
						extract_l
							:- changed function header so the the destination
							   does not need to be passed in as an argument.

					 *	div_s
						div_l
							:- Changed from Single Quadrant Division to
							   4-quadrant Fractional Division w/out Remainder

5.	03/01/2001   JPG   Added New Intrinsics:
                         - shlfts
                         - L_shlfts
                         - shl
                         - shr
                         - shr_r      >>> Restrictions on registers
                         - L_shr
                         - L_shl
                         - turn_on_conv_rndg    --enable  convergent rounding
                         - turn_off_conv_rndg   --disable convergent rounding
                         - turn_on_sat          --enable  auto saturation
                         - turn_off_sat         --disable auto saturation
                                                  
6.	03/01/2001	US	 *	Changed all comments from C++ to C-style comments in 
						an attempt to compile this file using ansi-strict mode.
						Soon realized that inline assembly is not be supported
						under ansi-strict mode in the first place. Doh!
						
					 *	Moved unused code to bottom of file.
					 
					 *	div_s and div_ls are now single quadrant division 
					 	intrinsics (i.e. both operands positive), again.
					 	The 4 quadrant division intrinsics are div_s4q and 
					 	div_ls4q
					 
					 *	Changed intrinsic names and added macros so they can 
					 	be called using the correct names. This is provides an 
					 	easy way to change the intrinsic calling name by 
					 	changing the macro. For example, the C standard 
					 	library has a round() function. If the name of the 
					 	round inline function was round(), there would be 
					 	a conflict. Using macros, the intrinsic will be given 
					 	preference; and if we want access to both round()s, we 
					 	can simply change the name of the intrinsic to 
					 	something else by changing the macro name.

7.	03/06/2001	US	*	Revised the following intrinsics to work with the 
						inline assembler:
						 	- shlfts
						 	- L_shlfts
						 	- shr
						 	- shr_r
						 	- L_shr
						 	- L_shl
						 	- turn_on_conv_rndg
						 	- turn_off_conv_rndg
						 	- turn_on_sat
						 	- turn_off_sat
						 	
						 Note:	Special handling of intrinsics according to the 
						 		assigned complexity weights is not working yet.
						 		
					*	Added '#pragma mark's to group intrinsics based on 
						loosely defined functionalities.
	
8.	03/06/2001	JPG   Clarifications and corrections:
							- fixed SHL to use variable names, not registers
							- added comments on registers and L_mult_ll

9.	03/10/2001	US	*	Fixed up SHL:
							- nbr_ldg_bits is a register variable.
							- Added inline assembly directives.
							- changed BRAD to BRA.
							- Added missing return statement.
						 		
					*	Moved change log to end of file.
					
10.	03/29/2001	US	*	Switched argument order in div_s and div_ls macros so 
						the numerator is the first argument and the denominator 
						is the second. This is to keep compatibility with 56800.
						
11.	04/04/2001	US	*	Changed shl, shr, shr_r, and shlfts to use a long 
						temporary throughout the computations (as oposed to the
						short argument). This is done so that the ASL 
						instructioncan be used when needed to ensure saturation 
						(when enabled). Fixed typo in L_shlfts; now uses ASL.
					*	Added branch instructions in shr and shr_r to branch to 
						the end after special case (shifting by 15).
						
12.	04/18/2001	US	*	Switched argument order in __div_s and __div_ls macros 
						so the numerator is the first argument and the 
						denominator is the second. Changed order of the macros 
						for these back to what they were before entry 10.
					*	Added version number to this file (intrinsics_56800E.h).

13.	04/19/2001	US	*	Fixed shr_r case when shifting by >15.

14. 04/24/2001	US	*	Improved shl intrinsic to have smaller code size if the 
						shift amount is a constant. This requires compier build 
						b0055 or greater.
						
15. 04/25/2001	US	*	Added a move.w in __L_deposit_l to ensure correct sign 
						extension. Also the SA bit is no longer required to be 
						set for this intrinsic.

16. 04/26/2001	US	*	Improved shr, shr_r, L_shr, L_shl intrinsics to have 
						smaller code size if the  shift amount is a constant. 
						This requires compier build b0055 or greater.
						
17. 06/03/2001	US	*	Added L_mult_ls and L_shr_r. Needs build >= b0056.

18. 07/26/2001	US	*	Disabled registercopy for move from short argument to 
						long temp in shl, shr, shr_r, shlfts, div_s, div_s4q.

19. 08/17/2001	US	*	Fixed shr_r comments. Also fixed shr_r() case where the
						shift amout is >= 15.

20. 08/24/2001	US	*	Fixed shr_r() case where the shift amount is a constant
						> 0 and < 15. Also fixed case for L_shr and L_shar_r 
						when shift amout is a constant < -31.

21. 10/05/2001	US	*	Fixed L_shr_r() case where the shift amount is a constant
						> 31.

22. 02/18/2002	US	*	Cleaned up some unused code and comments.

22. 09/29/2002	US	*	Turned implicit arithmetic conversion warnings off for 
						__round(), __mac_r() and __msu_r() because the impicit
						coversions are expected in these routines.

23. 07/18/2003	US	*	Added optimize_iasm inline assembly directives to all 
						intrinsics to allow the compiler to always optimize 
						them.
********************************************************************************/
#pragma mark -
#pragma mark <<<< Changes >>>>

