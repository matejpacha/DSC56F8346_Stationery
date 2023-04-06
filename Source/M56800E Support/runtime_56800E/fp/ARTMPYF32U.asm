



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




; SECTION: the floating point code
	SECTION	fp_engine
	OPT	CC
	GLOBAL  ARTMPYF32U
	
	include "Fp56800E.h"


;===============================================================================
; FUNCTION: ARTMPYF32U
; DESCRIPTION: float multiply
; INPUT: x in a; y in b
; OUTPUT: product in a
;
ARTMPYF32U:
	adda	#SIZE_TEMPS,sp
	NORMALIZE_OMR
	jsr		ARTf_unpack2z		; return with <x,y> flags in x0
	lsl.w	x0	;mutiplies dispatch address by 2 (since bra is 2 words instead of 1 in 56800)
	move.w	r0,x:(sp-rsign)		; stuff xor
	;jsr		ARTdispatch_x0
	; TRICK: dispatch table must be next.
	
	CALC_DISPATCH x0,cmp_dispatch_top
cmp_dispatch_top:
	; Dispatch table for special cases.
	bra	>f_mul_numbers		; x is a number, y is number
	bra	>go_f_result_is_zero	; 	y is zero
	bra	>go_f_result_is_INF		; 	y is INF
	bra	>go_f_y_is_NaN		; 	y is NaN

	bra	>go_f_result_is_zero	; x is zero, y is number
	bra	>go_f_result_is_zero	; 	y is zero
	bra	>go_f_result_is_Invalid 	;	y is INF
	bra	>go_f_y_is_NaN		;	y is NaN

	bra	>go_f_result_is_INF		; x is INF, y is number
	bra	>go_f_result_is_Invalid	; 	y is zero
	bra	>go_f_result_is_INF		; 	y is INF
	bra	>go_f_y_is_NaN		;	y is NaN

	bra	>go_f_x_is_NaN		; x is NaN, y is number
	bra	>go_f_x_is_NaN		;	y is zero
	bra	>go_f_x_is_NaN		;	y is INF
	bra	>go_f_x_and_y_are_NaN	;	y is NaN
	
go_f_result_is_INF:
	jmp	ARTf_result_is_INF
go_f_result_is_Invalid:
	jmp	ARTf_result_is_Invalid
go_f_result_is_zero:
	jmp	ARTf_result_is_zero
go_div_f_x_is_NaN:
	jmp	ARTf_x_is_NaN
go_f_y_is_NaN:
	jmp	ARTf_y_is_NaN
go_f_x_is_NaN:
	jmp	ARTf_x_is_NaN
go_f_x_and_y_are_NaN:
	jmp	ARTf_x_and_y_are_NaN
	

;===============================================================================
; TERMINAL: f_mul_numbers
; DESCRIPTION: Usual case of 2 finite, nonzero numbers
;
f_mul_numbers:
	add.w	x:(sp-rexp),y1	; sum biased exponents
	sub.w	#126,y1
	move.w	y1,x:(sp-rexp)	; save computed exp
	
	; b = x, a = y, normalized and so pairs of "signed" values.
	; Because the fixed-point multiply shifts left a bit and
	; because the dsp doesn't support unsigned integer-style
	; multiplies, right-shift a bit to have 1+24+7 -bit
	; significands.  The fractional style of dsp arithmetic
	; causes the result of 01xxxx * 01xxxx style arithmetic
	; to be 0zyyyy, where z may be 1 or 0.  If 1, then there's
	; no need for further normalization -- hence the 126 bias
	; adjust.
	; The minimum number of moves is obtained by putting y
	; in x0-y1.
	asr	a
	asr	b
	; Set up <x0, y1> * <b1, b0>.
	move.w	a1,x0		; x0 = yhi
	move.w	a0,y1		; y1 = ylo
	; Set up <x0, y1> * <b1, y0>.
	move.w	b0,y0		; y0 = xlo
	mpysu	y0,y1,a		; a get lowest unsigned product, xlo*ylo
	tst.w	y0		; if "negative" add y1 into high half
	nop
	bge		flolo_nofix
	; Correct for signed y0.  To get unsigned add * 2,
	; shift right and add 4 times.  y1 has trailing 0's.
	lsr.w	y1
	add		y1,a
	add		y1,a
	add		y1,a
	add		y1,a
	lsl.w	y1
flolo_nofix:
	; a0 has just 2 high bits of the product. a2 may have carry
	moveu.w	a0,r0		; save lowest couple of stickies
;	move	a1,b0		; save high part for right shift
;	move	a2,a		; move carry down
;	move	b0,a0		; set up low bits
	asr16	a
	
	; <x0, y1> * <b1, y0> with y1 * y0 aligned in a.
	macsu	x0,y0,a
	; <x0, y1> * <b1, 0>, with <x0, y1> * y0 aligned in a.
	move.w	b1,y0
	macsu	y0,y1,a		; add y1 * <y0, 0> into a
	; <x0, y1> * <y0, 0>
	; a now has a 33-bit result, so shift right with care
	nop
	move.w	a0,y1		; stickies
;	move	a1,a0		; right shift 16 bits
;	move	a2,a1
	lsr16	a
	;move	#0,a2		don't care about junk bits to left
	mac		x0,y0,a
	move.w	r0,y0
	or.w	y0,y1		; any stickies?
	beq		fmn_nostick
	bfset	#1,a0		; force low bit
fmn_nostick:
	; a has leading 0, then 31 bits, including stickies.  If it's
	; normalized then exp is correct. Otherwise, it's unnormalized
	; by 1 bit so shift and decrement exp.
	move.w	x:(sp-rexp),y1	; set up for coerce
	asl		a		; V bit messes up test
	tst.w	a1		; extension bits mess up the CCR in asl
	blt		fmn_noshift
	asl		a
	sub.w	#1,y1
fmn_noshift:
	jmp		ARTf_coerce

	
	ENDSEC