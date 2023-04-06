



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




; SECTION: the floating point code
	SECTION	fp_engine
	OPT	CC
	GLOBAL	ARTDIVF32UZ
	
	include "Fp56800E.h"

	
;===============================================================================
; TERMINAL: f_divide_by_zero
; DESCRIPTION: Signal divbyzero and return INF
; INPUT: rsign = sign of result.
;
f_divide_by_zero:
	; Get here dividing finite / 0.
	SetDivByZero
	jmp	ARTf_result_is_INF	

; Get to utilities the long way.
go_f_result_is_zero:
	jmp	ARTf_result_is_zero
go_f_result_is_Invalid:
	jmp	ARTf_result_is_Invalid
go_f_result_is_INF:
	jmp	ARTf_result_is_INF
go_div_f_x_is_NaN:
	jmp	ARTf_x_is_NaN
go_f_y_is_NaN:
	jmp	ARTf_y_is_NaN
go_f_x_and_y_are_NaN:
	jmp	ARTf_x_and_y_are_NaN
	
;===============================================================================
; FUNCTION: ARTDIVF32UZ
; DESCRIPTION: Float divide.
; INPUT: a=x, b=y, floats
; OUTPUT: a = result
;
ARTDIVF32UZ:
	; Compute (-1)^x.sign * 2^x.exp-bias * 1.xxxx divided by
	; (-1)^y.sign * 2^y.exp-bias * 1.yyyy --->
	; result.sign		= xor of x and y signs
	; result.exp (biased)	= x.exp - y.exp + bias
	; result.bits		= w.zzzzz before normalization, rounding, etc.
	; If the leading w bit is 0, then must decrement the exponent by 1
	; and realign.
	adda	#SIZE_TEMPS,sp
	NORMALIZE_OMR
	jsr		ARTf_unpack2z		; return with <x,y> flags in x0
	lsl.w	x0	;mutiplies dispatch address by 2 (since bra is 2 words instead of 1 in 56800)
	move.w	r0,x:(sp-rsign)		; stuff xor
	
	; jsr	ARTdispatch_x0
	; TRICK: dispatch table must be next.
	
	CALC_DISPATCH x0,cmp_dispatch_top
cmp_dispatch_top:
	bra	>f_div_numbers		; x is a number, y is number
	bra	>f_divide_by_zero	; 	y is zero
	bra	>go_f_result_is_zero	; 	y is INF
	bra	>go_f_y_is_NaN		; 	y is NaN

	bra	>go_f_result_is_zero	; x is zero, y is number
	bra	>go_f_result_is_Invalid	; 	y is zero
	bra	>go_f_result_is_zero	;	y is INF
	bra	>go_f_y_is_NaN		;	y is NaN

	bra	>go_f_result_is_INF	; x is INF, y is number
	bra	>go_f_result_is_INF	; 	y is zero
	bra	>go_f_result_is_Invalid	; 	y is INF
	bra	>go_f_y_is_NaN		;	y is NaN

	bra	>go_div_f_x_is_NaN	; x is NaN, y is number
	bra	>go_div_f_x_is_NaN	;	y is zero
	bra	>go_div_f_x_is_NaN	;	y is INF
	bra	>go_f_x_and_y_are_NaN	;	y is NaN

f_div_numbers:
	; In this typical case, compute exp = x.exp - y.exp + bias.
	; This presumes alignment as though the leading significant
	; bit will be 1.  If it's zero, we'll left shift and decrement
	; the exponenet.
	
	; Have to divide dyb into dxb.  It's "just" two steps of
	; 64/32 --> 32 quo + 32 rem.
	; In terms of 32-bit digits, the division is just
	;
	;            X Y
	;       --------
	;  A B | C D 0 0.
	;
	; Knuth, Vol. 2, explains how it goes.  First, A is normalized
	; because its leading bit is one.  To ensure that no bit is
	; needed left of the X-digit above, right-shift CD by 1 bit at
	; the outset.  Then use the div utility to divide CD by A
	; to guess X.  As Knuth shows, even for hideously large integers
	; like these, the guess X is at worst 2 units too high, so we watch
	; and correct the remainder suitably.
	;
	; Guessing Y is more interesting, because the partial remainder
	; is not constrained downward, as X was via preconditioning.
	; After X has been guessed and corrected, the situation is this:
	;
	;            X ?
	;       --------
	;  A B | C D 0 0.
	;        X*A B
	;          E F 0
	;
	; All that's known is that, after X is corrected, AB < EF.
	; It's possible for E to be = A, in which case the guess for Y
	; is the maximum "digit", in this case 0xffffffff.  Correcting Y
	; as before yields an unnormalized quotient (by 0 or 1 bit) and
	; a remainder (that contributes to the sticky bits).
	;
	; Subtract exp's and rebias as though dvd.sig >= dvr.sig.
	; rexp = dvd exp.
	move.w	x:(sp-rexp),y0
	sub		y1,y0
	add.w	#127,y0
	move.w	y0,x:(sp-rexp)
	
	; We'll divide in the form 001xxxxx / 01yyyy to avoid sign,
	; producing a result of the form 0rstttttt, where r|s=1.
	; rsign contains the xor, so xhi and xlo are free for temporaries,
	; as are the r regs. b = dvd bits, a = drv bits.
	asr	b		; align 001xxx
	asr	b
	asr	a		; align as 01yyy
	move.w	a1,x0
	move.w	a0,x:(sp-xlo)	; xlo = dvrlo
	
	; Produce first quotient 0rsttttt.
	bfclr	#1,sr		; clear C to start
	nop
	nop
	IF @def('UseRep')
	rep	#16
	ELSE
	nop
	do	#16,div_1
	ENDIF
	div	x0,b
div_1:
	nop
	nop
	nop
	add		x0,b		; b1 = remainder, b0 = qhi
	move.w	b0,y0		; y0 = qhi
	move.w	#0,b0
	asr		b		; align partial rem as 00rrrrrrrr
	
	; Now set up qhi * dvrlo to compute true remainder, for
	; possible correction by 1 or 2.
	move.w	x:(sp-xlo),y1	; y1 = dvrlo
	mpysu	y0,y1,a
	asr		a		; align as 00sssssss
	
	; True remainder with quotient digit qhi is b-a, adjusted to be
	; nonnegative.
	sub		a,b
	nop
	bcc		f_div_post_1st_fixup
	
	; Must correct qhi downward by 1 or 2.
	move.w	x0,a
	move.w	y1,a0		; a = dvr (right-adjusted)
	sub.w	#1,y0		; --qhi
	add		a,b		; does this fix the deficit?
	bcs		f_div_post_1st_fixup
	sub.w	#1,y0
	add		a,b		; this MUST set carry
	
f_div_post_1st_fixup:
	move.w	y0,x:(sp-xhi)	; xhi = qhi
	; Now compute the 2nd 15-bit quotient "digit".
	bfclr	#1,sr		; clear C to start
	nop
	nop
	IF @def('UseRep')
	rep	#16
	ELSE
	nop
	do	#16,div_2
	ENDIF
	div	x0,b
div_2:
	nop
	nop
	nop
	add		x0,b
	move.w	b0,y0		; y0 = qlo
	move.w	#0,b0
	asr		b		; align partial rem as 00rrrrrrr
	
	; Compute qlo * dvrlo, as before.
	move.w	x:(sp-xlo),y1
	mpysu	y0,y1,a
	asr		a		; align as 00ssssss
	
	; Subtract as before, and adjust by 1 or 2.
	sub		a,b
	nop
	bcc		f_div_post_2nd_fixup
	
	; Set a = dvr to correct qlo.
	move.w	x0,a
	move.w	y1,a0		; a dvr
	sub.w	#1,y0		; --qlo
	add		a,b
	bcs		f_div_post_2nd_fixup
	sub.w	#1,y0
	add		a,b		; MUST set carry
	
f_div_post_2nd_fixup:
	; xhi/y0 = pair of 0xxxxx pieces of quotient
	; b = remainder, nonzero --> sticky
	lsl.w	y0
	; Any sticky bits in b?
	move.w	b0,y1
	or.w	b,y1
	beq		f_div_nonstick
	add.w	#1,y0
f_div_nonstick:
	move.w	x:(sp-rexp),y1
	move.w	x:(sp-xhi),a
	move.w	y0,a0		; have quo = 0rstttt, r|s = 1
	asl		a
	tst.w	a1
	jlt		ARTf_coerce
	asl		a		; must set lead bit
	sub.w	#1,y1
	jmp		ARTf_coerce
	
	
	ENDSEC