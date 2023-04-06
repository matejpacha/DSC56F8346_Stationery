

;* MSL
;* Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;*
;* $Date: 2005/12/09 02:02:28 $
;* $Revision: 1.10 $


;*	math.asm
;*	
;*	Routines
;*	--------
;*		fmodf
;*
;*
;*/

	section rtlib
	org p:

	include "asmdef.h"
	
	global	Fmodf

Fmodf:
	adda	#10,SP
	IF !@DEF(F__CW_M56800E_LMM)
		move.w	R2,X:(SP)
	ELSE
		move.l	r2,x:(sp)
	ENDIF
	move.l	A10,X:(SP-2)
	jsr     ARTF32_TO_S16U
	jsr     ARTS16_TO_F32
	IF !@DEF(F__CW_M56800E_LMM)
		moveu.w	X:(SP),R0
	ELSE
		move.l	x:(sp),r0
	ENDIF
	tfr		A,B
	nop
	move.w  A0,X:(R0)
	move.w  A1,X:(R0+1)
	move.l	X:(SP-2),A
	
	jsr     ARTSUBF32U
	suba	#10,SP
	rts

	endsec