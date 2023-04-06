

;* MSL
;* Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;*
;* $Date: 2005/12/09 02:02:27 $
;* $Revision: 1.12 $


;*	math.asm
;*	
;*	Routines
;*	--------
;*		ldexp
;*
;*
;*

	section rtlib
	org p:

	include "asmdef.h"
	
	global	Fldexp

DBL_MAX		equ		3.4028235e+38
DBL_MIN		equ		5.8774717e-39

Fldexp:
	adda	#10,SP
	tst		A
	jeq		inputzero
	tst.w	Y0
	jeq		inputzero
	move.w	Y0,X:(SP)
	move.l	A10,X:(SP-2)
	blt		negpower		; still the CC from the tstw Y0

pospower:
	move.w  #32511,B1
	move.w  #-1,B0
	move.l	B10,X:(SP-4)
	move.l	X:(SP-2),A
	bfclr	#$8000,A1	
	jsr     ARTCMPF32
	bgt     rangerror
	move.w  #32,B
	move.l	B10,X:(SP-4)
	move.l	X:(SP-2),A
	bfclr	#$8000,A1
	jsr     ARTCMPF32
	bge     ok

rangerror:
	move.w  #>ERANGE,X:Ferrno
	move.w  #32639,A1
	move.w  #-1,A0
	bra     done
ok:
	move.l	X:(SP-2),B
	move.l	B10,X:(SP-4)
	clr     A
	move.w  #16384,A1
	jsr     ARTMPYF32U
	move.l	A10,X:(SP-2)

	dec.w   X:(SP)
	tst.w   X:(SP)
	bgt     pospower
	bra     done
negpower:
	clr     B
	move.w  #16128,B1
	move.l	B10,X:(SP-4)

	jsr     ARTMPYF32U
	
	inc.w   X:(SP)					; RPN: Was X:<mr8
	tst.w   X:(SP)
	blt     negpower

done:
inputzero:
	suba	#10,SP
	rts     

	endsec