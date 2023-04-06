



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




;===============================================================================
; SECTION: the floating point code
	SECTION	fp_engine
	OPT	CC
	GLOBAL	ARTf_unpack2z
	GLOBAL	ARTf_unpack2
	GLOBAL  ARTf_unpackA
	
	include "Fp56800E.h"
	

;===============================================================================
; UTILITY: ARTf_unpackA, ARTf_unpack2, ARTf_unpack2z
; DESCRIPTION: Unpack 1 or 2 input floats.
;	ARTf_unpackA -- unpacks a
;	ARTf_unpack2 -- unpack 2 operands, eor-ing the signs
;	ARTf_unpack2z -- f_unpack2, with x0 <-- 0, for mul and div
;
; INPUT: x in a; y in b, for 2-operand functions;
;	flags in x0 for f_unpackA and f_unpack2
; OUTPUT:
;	f_unpackA -- a = bits, x0 = flags, y1 = exp
;	f_unpack2, f_unpack2z -- b = x bits, x:rexp = x exp, x:xhi/xlo = x,
;			a = y bits, y1 = y exp, r0 = xor signs, x:yhi/ylo = y
;
;		!_____!
;		|	  |
;		!_____!
;		|	  |
;		!_____!<-- SP at the begining of Caller Routine.
;		|	  |
;		!_____!
;		|rexp |
;		!_____!
;		|rsign|
;		!_____!
;		|yflip|
;		!_____!
;		| ylo |
;		!_____!
;		| yhi |
;		!_____!
;		| xlo |
;		!_____!
;		| xhi |
;		!_____!<-- SP after f_unpack2z or f_unpack2
;		| 	  |
;		!_____!
;		| 	  |
;		!_____!<-- SP at f_unpack2z or f_unpack2
;		| 	  |




ARTf_unpack2z:
	move.w	#<0,x0		; set up flags for normalization
ARTf_unpack2:
	move.w	b1,x:(sp-yhi_unp)	; save y operand for later ref.
	move.w	b0,x:(sp-ylo_unp)
	move.w	b1,y1	; y sign
	eor.w	a,y1
	move.w	y1,r0		; save eor sign for all binary ops
	move.w	a1,x:(sp-xhi_unp)	; save x operand for later ref.
	move.w	a0,x:(sp-xlo_unp)
	jsr		ARTf_unpackA	; a = bits, y1 = exp, x0 = flags
	tfr		a,b		; save x bits
	move.w	y1,x:(sp-rexp_unp)
	lsl.w	x0		; shift flags over two
	lsl.w	x0
	move.w	x:(sp-yhi_unp),a	; set up operand y
	move.w	x:(sp-ylo_unp),a0
	; Fall through to f_unpackA...
ARTf_unpackA:
	move.w	#<8,y0		; shift count
	moveu.w	a1,r1		; save exp field
	move.w	a0,y1		; low bits for right shift into a (from left)
	asll.w	a1,y0,a		; a1 = xbbb bbbb 0000 0000, x = implicit
	lsrac	y1,y0,a		; a1 = xbbb bbbb cccc cccc, a0 = dddd dddd 0000 0000
	move.w	r1,y1		; restore exp in bits seee eeee ebbb bbbb
	lsl.w	y1		; strip sign bit
	lsrr.w	y1,y0,y1	; right-align biased exp
	nop
	beq		unpZerSub	; exit if 0 or subnormal
	cmp.w	#$0ff,y1	; look for max exp
	beq		unpNanInf
	bfset	#$8000,a1	; jam the implicit 1-bit
	move.w	#0,a2		; be sure high bits are Czero
	rts

; Distinguish Nan and Inf by significand, sans implicit bit
unpNanInf:
	add.w	#<2,x0		; 2 for inf, 3 for NaN
	asl		a		; strip implicit bit
	beq		unpSpecDone
unpBump:
	add.w	#<1,x0
	nop
unpSpecDone:
	rts

; Distinguish zero and subnormal by sig, with implicit = 0.
unpZerSub:
	;tst	a		BUGGY INSTRUCTION TESTS HIGH HALF ONLY
	tst.w	a1
	bne		unpNorm
	tst.w	a0
	nop
	beq	unpBump		; go bump x0 by 1 and exit
unpNorm:
	move.w	#<1,y1	; adjust exponent for tiny value
	tst.w	x0		; negative if unnormal
	blt		unpSpecDone
unpNormLoop:
	sub.w	#<1,y1	; dec exp
	asl		a		; sets N and V, so CCR messed up
	tst.w	a1		; check N bit
	bge		unpNormLoop	; >= because only bits might be lowC
	nop				; guaranteed a2 = 0 here
	nop
	rts
	
	ENDSEC