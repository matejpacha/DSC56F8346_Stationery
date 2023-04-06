



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




; SECTION: the floating point code
	SECTION	fp_engine
	OPT	CC
	
	include "Fp56800E.h"
	
	GLOBAL	ARTU16_TO_F32
	GLOBAL	ARTS16_TO_F32
	GLOBAL	ARTU32_TO_F32
	GLOBAL	ARTS32_TO_F32


;===============================================================================
; FUNCTION: ARTU16_TO_F32, ARTU32_TO_F32
; DESCRIPTION: Convert unsigned word to float.
; INPUT: y0 = unsigned word
; OUTPUT: a = float
; OPTIMIZATION: Uses signed conversion, with faked positive sign.
;
ARTU16_TO_F32:
	move.w	y0,a
	move.w	#15,y1
	bra	utoX_common
ARTU32_TO_F32:
	move.w	#31,y1
utoX_common:
	adda	#SIZE_TEMPS,sp
	NORMALIZE_OMR
	move.w	#0,y0
	move.w	y0,x:(sp-rsign)		; positive sign
	bra	wtoX_common

;===============================================================================
; FUNCTION: ARTS16_TO_F32, ARTS32_TO_F32
; DESCRIPTION: Convert signed word to float.
; INPUT: y0 = signed word
; OUTPUT: a = float
; CASES: Zero maps to +0. Large values are rounded according to the current mode.
;
ARTS16_TO_F32:
	move.w	y0,a
	move.w	#15,y1
	bra	itoX_common
ARTS32_TO_F32:
	sxt.l a,a
	move.w	#31,y1
itoX_common:
	adda	#SIZE_TEMPS,sp
	NORMALIZE_OMR
	move.w	a1,x:(sp-rsign)
	abs	a			; ********** check extension ***********
	; fall through to wtoX_common
	
;===============================================================================
; TERMINAL: wtoX_common  (word to floating conversion, common code)
; DESCRIPTION: Normalize integer in a and coerce to destination. If dest
;	is wide (future), be sure to widen the integer operand suitably.
; INPUT: a = unsigned integer, rsign = sign, y1 = unbiased exp
; OUTPUT: Convert to float (or double) destination using coercions.
;
wtoX_common:
	; Normalize the operand in a and set the exponent to the
	; unbiased exp.  Then branch to appropriate coercion routine.
	; SPECIAL CASE: Zero is treated specially.
	add.w	#$7f,y1			; bias exponent
	tst.w	a1			; is high half 0?
	blt		wtoX_done		; already normal
	nop
	nop
	bne		wtoX_leftward		; go shift < 16 bits
	tst.w	a0
	nop
	beq	y_34_rts		; return with 0
	; Fall through with 16+ bits of shift
	move.w	a0,a			; shift and clear low half
	sub.w		#16,y1
	tst.w	a1
	blt		wtoX_done		; exactly 16 bits needed
wtoX_leftward:
	sub.w	#1,y1
	asl		a
	tst.w	a1
	bgt		wtoX_leftward
	nop
	nop
wtoX_done:
	jmp		ARTf_coerce

y_34_rts:
	RESTORE_OMR
	suba	#SIZE_TEMPS,sp
	rts

	
	ENDSEC