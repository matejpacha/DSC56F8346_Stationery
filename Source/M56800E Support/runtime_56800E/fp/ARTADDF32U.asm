


; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.





; SECTION: the floating point code
	SECTION	fp_engine
	
	OPT	CC
	GLOBAL	ARTADDF32U
	GLOBAL  ARTSUBF32U
	
	
	include "Fp56800E.h"


;===============================================================================
; FUNCTION: ARTSUBF32U
; DESCRIPTION: Float subtract.
;
; INPUT: a = x, b = y
; OUTPUT: a = result = x - y
;
ARTSUBF32U:
	adda    #SIZE_TEMPS,SP
	NORMALIZE_OMR
	move.w	#$8000,x0		; sign flipper
	move.w	b1,y1		; high part of y
	eor.w	x0,y1			; flip y to look like add
	move.w	y1,b1		; replace operand
	bra		f_add_common
	
;===============================================================================
; TERMINAL: f_flipped_y_is_NaN, f_x_and_flipped_y_are_NaN
; DESCRIPTION: Adjust y, whose sign may have been flipped, and go to terminal.
; INPUT: y on stack, yflip
; OUTPUT: none
;
f_flipped_y_is_NaN:
	move.w	x:(sp-yhi),x0
	move.w	x:(sp-yflip),y0
	eor.w	y0,x0
	move.w	x0,x:(sp-yhi)
	jmp     ARTf_y_is_NaN
	
f_x_and_flipped_y_are_NaN:
	move.w	x:(sp-yhi),x0
	move.w	x:(sp-yflip),y0
	eor.w	y0,x0
	move.w	x0,x:(sp-yhi)
	jmp		ARTf_x_and_y_are_NaN


;===============================================================================
; TERMINAL: f_add_zero_to_zero
; DESCRIPTION: If signs agree, answer is easy, else fall through to subtract
;	magnitude.
; INPUT: 
; OUTPUT: Returns 0.
;
f_add_zero_to_zero:
	; When result is zero, if signs disagree let the rounding mode
	; decide the sign of the result.  The IEEE standard says use +0
	; unless rounding to -INF, in which case use -0.
	tst.w	x:(sp-rsign)	; the xor of operand signs
	bge		>f_result_is_x
	nop
	nop
	; Fall through to f_add_zero_difference.


;===============================================================================
; TERMINAL: f_add_zero_difference
; DESCRIPTION: Deliver zero based on rounding mode. +0, except when round down.
; INPUT: 
; OUTPUT: Returns 0.
;
f_add_zero_difference:
	; TRICK: DOWNWARD = 3, so can use brset...
	brset	#DOWNWARD,x:FPE_state,f_add_neg_zero ; jrusso LMM
	clr		a
	RESTORE_OMR
	suba	#SIZE_TEMPS,sp
	rts
f_add_neg_zero:
	move.w	#$8000,a
	RESTORE_OMR
	suba	#SIZE_TEMPS,sp
	rts
	

;===============================================================================
; FUNCTION: ARTADDF32U
; DESCRIPTION: Float add.
;
; INPUT: a = x, b = y
; OUTPUT: a = x + y
;
ARTADDF32U:
	; Add and subtract share common code.  Subtract is identical to add
	; but with y's sign flipped.
	; SUBTLETY: In subtraction, must track y's original sign in case it's
	; a NaN and need to return y EXACTLY as it was.
	; Use r30 to hold sign flip flag: 0 for add 0x80000000 for subtract.
	; This allows subtract to look like add, but with its operand's sign
	; flipped.  The reason sub(x,y) is not the same as add(x,-y) is that
	; sub(number,NaN) needs to return the NaN with its ORIGINAL sign.
	;
	; Compute (-1)^x.sign * 2^x.exp-bias * 1.xxxx plus/minus
	; (-1)^y.sign * 2^y.exp-bias * 1.yyyy --->
	; result.sign		= sign of larger operand, though in case
	;	of zero result from operands of different signs, the result
	;	sign depends on the rounding mode: + for all except toward -INF
	; result.exp (biased)	= larger of two exps, subject to normalization
	; result.bits		= rounded sum or difference
	;
	; Many SPECIAL CASES apply:
	; Subnorms need not be normalized -- just adjust their exp to 1 and be
	;	sure not to artificially set the implicit bit to 1.
	; Magnitude add is benign. The worst that can happen is a 1-bit carry-out,
	;	and even when the operands are aligned there can be rounding from
	;	the Round (1st) bit.
	; Magnitude subtract when exps are equal can lead to massive cancellation,
	;	but never a rounding error.
	; Magnitude subtract when exps differ by one can lead to massive cancellation,
	;	and possible rounding from Round bit.
	; Magnitude subtract when exps differ by more than one never suffers
	;	cancellation by more than 1 bit, and requires general rounding.
	; Tiny results can arise from the sum or difference of subnormals, or
	;	from the difference of normals.  Must be careful when realigning
	;	after cancellation to be ready to back off to subnormal.  The results
	;	are always exact (i.e. no bit can lie to the right of the LSB of
	;	a subnormal.
	; The benign nature of subnormals (tinies) in add/sub means some care must
	;	be taken in packing the result back up to fudge the exponent
	;	(compare mul/div, where tiny results can be trickier).  At the cost
	;	of a few instructions, tiny results filter through the mul/div
	;	common code.
	adda    #SIZE_TEMPS,SP
	NORMALIZE_OMR
	move.w	#0,x0			; sign flipper
	; Fall through to add/sub common code.
	
f_add_common:
	move.w	x0,x:(sp-yflip) ; save add/sub distinction
	move.w	#$e000,x0		; mark no normalization
	jsr		ARTf_unpack2
	move.w	r0,x:(sp-rsign)		; this is the xor, not result
	bfclr	#$ff00,x0		; clear normalization bits
	lsl.w	x0	;mutiplies dispatch address by 2 (since bra is 2 words instead of 1 in 56800)
	;jsr		ARTdispatch_x0
	; TRICK: table must fall the dispatch jsr.
	
	CALC_DISPATCH x0,cmp_dispatch_top
cmp_dispatch_top:
	bra	>f_add_numbers			; x is a number, y is number
	bra	>f_result_is_x			; 	y is zero (y may be flipped)
	bra	>f_result_is_y			; 	y is INF
	bra	>f_flipped_y_is_NaN		; 	y is NaN

	bra	>f_result_is_y			; x is zero, y is number
	bra	>f_add_zero_to_zero		; 	y is zero
	bra	>f_result_is_y			;	y is INF
	bra	>f_flipped_y_is_NaN		;	y is NaN

	bra	>f_result_is_x			; x is INF, y is number
	bra	>f_result_is_x			; 	y is zero
	bra	>f_add_INF_to_INF		; 	y is INF
	bra	>f_flipped_y_is_NaN		;	y is NaN

	bra	>go_f_x_is_NaN			; x is NaN, y is number
	bra	>go_f_x_is_NaN			;	y is zero
	bra	>go_f_x_is_NaN			;	y is INF
	bra	>f_x_and_flipped_y_are_NaN	;	y is NaN

go_f_x_is_NaN:
	jmp	ARTf_x_is_NaN
	
f_add_numbers:
	; x + y, with y's sign reflecting operation add/sub.
	; b = x bits
	; a = y bits
	; rexp = x.exp
	; y1 = y.exp
	; rsign = r0 = xor signs
	; yflip = 0x8000 if sub, 0 if add (i.e. fix to get original y)
	; Align operands so larger one is in b/rexp, with exp in rexp, sgn in rsign.
	; Smaller operand is in (rexp-yexp) & fyb.
	; SPECIAL CASES:
	;	Exponents match:
	;		Add magnitude: Easy case, at most 1 rounding bit.
	;			May not carry-out (if one operand subnormal).
	;		Sub magnitude: Can have massive cancellation with exact,
	;			possibly zero result.  Can't over/underflow, but
	;			may require subnormalization.
	;	Exponents differ by 1:
	;		Add magnitude: nothing special
	;		Sub magnitude: Only other cancellation case, but may
	;			be inexact only if there's no cancellation.
	;	Exponents differ by 2-8: shift without losing stickies
	;	Exponents differ by 9-15: shift by 8, then 1-7
	;	Exponents differ by 16: shift by a word
	;	Exponents differ by 17-24, shift by a word, then 1-8
	;	Exponents differ by > 24: smaller operand goes to sticky.
	; WARNING: rsign indicates whether to add or sub magnitude,
	;	but result sign is that of larger operand, tentatively xhi
	;
	; First, put xor in yflip, and y's sign in rsign.
	move.w	r0,x:(sp-yflip)
	move.w	x:(sp-yhi),x0
	move.w	x0,x:(sp-rsign)
	; Start checking for various cases.
	move.w	y1,x0			; tentative larger exp
	move.w	x:(sp-rexp),y0
	sub		y0,x0		; y.exp - x.exp = +/- shift
	bne		f_add_unaligned		; go shift in hard case
	
	tst.w	x:(sp-yflip)	; add or sub?
	nop
	blt	f_sub_aligned
f_add_aligned:
	; Two normalized operands will cause Carry -- the typical case,
	; in which rounding and overflow must be checked.  If one or
	; the other is subnormal, the result may not Carry (though it
	; may be normal), and it's ready to be packed.  In order to share
	; code with more typical case, just go through whole coerce routine.
	; Note that in cases of subtract magnitude or of no carry in add
	; magnitude, there's no chance for overflow.
	add		b,a			; add magnitudes
	tst.w	a2
	jeq		ARTf_coerce
	asr		a			; reinstate high bit
	add.w	#1,y1			; bump exp
	jmp		ARTf_coerce
f_sub_aligned:
	; Subtraction may lead to borrow, in which case must negate and flip
	; result sign.  This is the only case of a sign flip.
	sub		b,a
	bhs		f_sub_no_borrow		; C clear if cool subtract
	neg		a
	move.w	x:(sp-rsign),y0
	bfchg	#$8000,y0		; flip result
	move.w	y0,x:(sp-rsign)
f_sub_no_borrow:
	; TRICK: can't depend on Z flag from neg, so test halves and
	; take the chance to speed up the case of massive normalization.
	tst.w	a1			; high half clear
	jlt	ARTf_coerce		; already normal
	nop
	bne	f_sub_renorm		; go shift up to 16
	tst.w	a0			; low half clear
	beq	>f_add_zero_difference
	; Fall through if high half is zero, but low isn't.
	; Do a quick 16-bit shift.
	move.w	a0,a			; clears a0
	sub.w	#<16,y1			; adjust exponent
	tst.w	a1			; check for luck case
	jlt	ARTf_coerce	
	; Fall through to f_sub_renorm
f_sub_renorm:
	; Have exact result which must be normalized.  Ideally, we'd shift
	; only until the biased exponent reaches 1, but it's easier to
	; just go through with it and let the tiny cases get shifted back.
	; They're exact, in any case.
f_sub_renorm_cont:
	dec.w	y1
	asl		a
	tst.w	a1
	bge		f_sub_renorm_cont
	nop
	nop
	jmp		ARTf_coerce

f_add_unaligned:
	; CC from sub x:exp,(y1 in x0) and then bne.
	; If gt, we're OK: y1 has larger exp and x0 has pos diff.
	; If negative, swap operands
	; yflip = xor of signs
	; y is in a, y1, rsign  (bits, exp, sign)
	; x is in b, rexp, xhi
	; xor of signs is in yflip
	; set up larger exponent in rexp and difference in x0
	bgt	f_add_swap_done
f_add_swap:
	move.w	x:(sp-xhi),y0		; get sign
	move.w	y0,x:(sp-rsign)
	move.w	a1,y0			; swap the 2 words of bits
	move.w	b1,a1
	move.w	y0,b1
	
	move.w	a0,y0
	move.w	b0,a0
	move.w	y0,b0
	
	move.w	x:(sp-rexp),y1		; larger exponent
	not.w	x0			; -difference = shift count
	add.w	#1,x0			; poor man's "negw x0"
f_add_swap_done:
	; Shifting up to 8 bits is easy.
	cmp.w	#1,x0
	bgt		f_add_2_plus
	
	; Case 1: shift b by 1 bit.  Add is nothing special,
	; but sub may require serious renormalization.
	asr		b
	tst.w	x:(sp-yflip)	; test xor
	bge		f_add_aligned
f_sub_1:
	; Sub operands shifted by 1 bit.  Can't borrow, but may require
	; significant renormalization.
	sub		b,a
	tst.w	a1			; still normalized
	jlt		ARTf_coerce
	bra		f_sub_renorm_cont

f_add_2_plus:
	cmp.w	#8,x0
	bgt		f_add_9_plus
	
	; Case 2-8: shift b by x0 within itself without fear of bit loss.
	moveu.w	b1,r0
	move.w	b0,y0
	lsrr.w	y0,x0,y0
	nop
	move.w	y0,b0
	move.w	#0,b1
	move.w	r0,y0
	lsrac	y0,x0,b
	bra	f_add_realigned
	
f_add_9_plus:
	cmp.w	#16,x0
	bgt		f_add_17_plus
	nop
	nop
	beq		f_add_16
	
	; Case 9-15: shift in one shot, watching for stickies.
	move.w	b1,r0
	move.w	b0,y0
	clr		b
	lsrac	y0,x0,b		; low bits / stickies
	nop
	tst.w	b0		; any stickies?
	nop
	beq		f_a_9_1
	add.w	#1,b		; bump high half, safely
f_a_9_1:
	move.w	b1,b0
	move.w	#0,b1
	move.w	r0,y0
	lsrac	y0,x0,b		; upper half, shifted and added
	bra		f_add_realigned
	
	; Case 16: shift by a word
f_add_16:
	tst.w	b0
	beq		f_a_16_1
	bfset	#1,b1

f_a_16_1:
	move.w	b1,b0
	move.w	#0,b1
	bra		f_add_realigned
	
f_add_17_plus:
	cmp.w	#24,x0
	bgt		f_add_25_plus
	
	; Case 17-24: shift by a word and then the remainder.
	move.w	b1,y0
	tst.w	b0			; any stickies
	beq		f_add_17_1
	bfset	#1,y0			; force sticky
f_add_17_1:
	sub.w	#16,x0
	clr		b
	lsrac	y0,x0,b			; b1 = low bits, b0 = sticky
	nop
	tst.w	b0
	nop
	beq		f_add_17_3
	bfset	#1,b1
f_add_17_3:
	move.w	b1,b0
	move.w	#0,b1
	bra		f_add_realigned
	
	; Case of huge shift --> all sticky.
f_add_25_plus
	clr		b
	move.w	#1,b0
	; Fall through to f_add_realigned
	
f_add_realigned:
	; Now add b to or subtract it from a.  At worst, there can be
	; a carry-out on add, or a 1-bit renormalization on subtract.
	; Always round and check for overflow, though overflow can't
	; happen on a magnitude subtract.  At the bottom of the range,
	; subtracting two numbers near the smallest normal can lead to
	; a subnormal, but it will be exact.
	tst.w	x:(sp-yflip)	; add or sub?
	bge		f_add_with_sticky
;f_sub_easy:
	sub		b,a			; can't borrow, might need 1-bit shift
	tst.w	a1
	jlt		ARTf_coerce
	asl		a
	sub.w	#1,y1			; adjust exponent
	jmp		ARTf_coerce
f_add_with_sticky:
	; Add operands shifted by bunch o' bits.  Watch for sticky bit.
	add		b,a
	tst.w	a2			; carry out?
	jeq		ARTf_coerce
	add.w	#1,y1			; bump exponent for right shift
	asr		a
	jhs		ARTf_coerce
	bfset	#1,a0			; force sticky
	; Fall through to f_coerce

	jmp ARTf_coerce


;===============================================================================
; TERMINAL: f_add_INF_to_INF
; DESCRIPTION: INF +/- INF can be INF or NaN
; INPUT: x, y, though only signs matter now.
; OUTPUT: Returns INF, with sign, or NaN.
;
f_add_INF_to_INF:
	; If adding magnitude, just deliver x. Otherwise invalid.
	tst.w	x:(sp-rsign)	; has xor of signs
	jlt	ARTf_result_is_Invalid
	; fall through to f_result_is_x...
	
	
	
;===============================================================================
; TERMINAL: f_result_is_x, f_result_is_y
; DESCRIPTION: Return saved arg (even if y has been flipped in sub).
; INPUT: x saved in xhi/xlo, y on stack.
; OUTPUT: a
;
f_result_is_x:
	move.w	x:(sp-xhi),a
	move.w	x:(sp-xlo),a0
	RESTORE_OMR
	suba	#SIZE_TEMPS,sp
	rts
f_result_is_y:
	move.w	x:(sp-yhi),a
	move.w	x:(sp-ylo),a0
	RESTORE_OMR
	suba	#SIZE_TEMPS,sp
	rts


	
	ENDSEC