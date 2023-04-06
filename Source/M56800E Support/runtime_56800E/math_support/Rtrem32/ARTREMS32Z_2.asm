; MSL
; Copyright ©2005 Freescale Corporation.  All rights reserved.

	SECTION rtlib

	ORG X:


	ENDSEC


	SECTION rtlib


	ORG P:

	global	ARTDIVS32UZ_2
    IF !@DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global	ARTREMS32Z_2
ARTREMS32Z_2:
	ENDIF

;------------------------------------------------------------------------------
; A = numl
; B = denl

; The routine calculates the remainder basing on the correct
; quotient calculated by division routine.


	adda	#2,SP
	move.l	C10,X:(SP)+
	move.l	B10,X:(SP)

	jsr ARTDIVS32UZ_2
	
	move.l	X:(SP),B
	; A contains the correct quotient
	; B contains the denumerator
	; Y contains the numerator
	
	move.l	Y,X:(SP)
	; A*B = den*quo
	impysu	A1,B0,Y
	imacus	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*quo
	move.l	X:(SP)-,Y

	sub		C,Y				; Y=num - den*quo=rem
	
	; Free stack
	move.l      X:(SP)-,C
	
	rtsd
	tfr		Y,A
	nop
	nop

	ENDSEC

	end

