; MSL
; Copyright ©2005 Freescale Corporation.  All rights reserved.

	SECTION rtlib

	ORG X:


	ENDSEC


	SECTION rtlib


	ORG P:

	global	ARTDIVU32UZ_2
    IF !@DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global	ARTREMU32Z_2
ARTREMU32Z_2:
	ENDIF

;------------------------------------------------------------------------------
; A = numul
; B = denul

; The routine calculates the remainder basing on the correct
; quotient calculated by division routine.

	adda	#2,SP
	move.l	C10,X:(SP)+

	jsr ARTDIVU32UZ_2
	
	; A contains the correct quotient
	; B contains the denumerator
	; Y contains the numerator
	 
	move.l	Y,X:(SP)
	; A*B = den*quo
	impyuu	A1,B0,Y
	imacuu	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*quo
	move.l	X:(SP)-,Y

	sub		C,Y				; Y=num - den*quo=rem
	move.l      X:(SP)-,C
	
	; Free stack
	rtsd
	tfr		Y,A
	nop
	nop

	ENDSEC
	
	end

