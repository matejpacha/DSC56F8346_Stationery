;* MSL
;* Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;*
;* $Date: 2005/12/09 02:02:26 $
;* $Revision: 1.9 $

;*	
;*	Routines
;*	--------
;*		frexp
;*
;*/
	section rtlib
	org p:

	include "asmdef.h"
	
	global	Ffrexp

Ffrexp:
	adda	#10,SP
	move.l	A10,X:(SP)
	IF !@DEF(F__CW_M56800E_LMM)
		move.w	R2,X:(SP-2)
	ELSE
		move.l	r2,x:(sp-2)
	ENDIF
	move.w	#0,X:(SP-4)
	tst     A
	jeq     frexpdone

ispowpos:		
	clr     B
	move.w  #16256,B1
	move.l	B10,X:(SP-6)
	move.l	X:(SP),A
	jsr     ARTCMPF32
	bge     powispos
	clr     B
	move.w  #-16512,B
	move.l	B10,X:(SP-6)	
	move.l	X:(SP),A
	jsr     ARTCMPF32
	bgt     ispowneg
powispos:
	inc.w	X:(SP-4)
	clr     B
	move.w  #16128,B1
	move.l	B10,X:(SP-6)
	move.l	X:(SP),A
	jsr     ARTMPYF32U
	move.l	A10,X:(SP)
	bra		ispowpos

ispowneg:		
	tst.w	X:(SP-4)
	bgt		frexpdone
powisneg:
	clr     B
	move.w  #16128,B1
	move.l	B10,X:(SP-6)
	move.l	X:(SP),A
	jsr     ARTCMPF32
	bge     frexpdone
	clr     B
	move.w  #-16640,B
	move.l	B10,X:(SP-6)
	move.l	X:(SP),A
	jsr     ARTCMPF32
	ble     frexpdone

	dec.w	X:(SP-4)
    move.l	X:(SP),A
    clr		B
    move.w	#16384,B1
    
	jsr     ARTMPYF32U
	move.l	A10,X:(SP)
	bra		powisneg
				
frexpdone:
	move.l	X:(SP),A
	
	IF !@DEF(F__CW_M56800E_LMM)
		moveu.w	X:(SP-2),R0
	ELSE
		move.l	x:(sp-2),r0
	ENDIF
	
	move.w	X:(SP-4),X0
	move.w	X0,X:(R0)
	suba	#10,SP
	rts     

	endsec