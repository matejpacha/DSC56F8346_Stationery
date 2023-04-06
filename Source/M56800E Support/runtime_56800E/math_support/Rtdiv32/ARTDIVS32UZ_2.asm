; MSL
; Copyright ©2005 Freescale Corporation.  All rights reserved.

	SECTION rtlib

	ORG X:


	ENDSEC


	SECTION rtlib


	ORG P:

    IF !@DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global	ARTDIVS32UZ_2
ARTDIVS32UZ_2:
	ENDIF

;------------------------------------------------------------------------------
; A = numl
; B = denl
;
; The routine implements Halley's method adopted to integer arithmetic.
;
; The routine uses the following registers:
; A, B, C, D, X0, Y, N, R0

	adda	#2,SP
	move.l	D10,X:(SP)+
	move.l	C10,X:(SP)+
	move.l	A10,X:(SP)+		; store original num

	move.w	A1,Y0
	eor.w	B,Y0			; compute sign

	move.w	Y0,R0			; store sign

	sxt.l	A
	sxt.l	B
	abs		A				; A=abs(num)
	abs		B				; B=abs(den)

	move.l	A10,X:(SP)		; store modified num

	; Initial guess
	clb		B,X0
	tfr		B,D				; D=den, store
	asll.l	X0,B			; B=norm(den)

	move.w #$2000,A
	tst		A
	div		B1,A
	div		B1,A
	div		B1,A
	div		B1,A

	div		B1,A
	div		B1,A
	div		B1,A
	div		B1,A

	div		B1,A
	div		B1,A
	div		B1,A
	div		B1,A

	div		B1,A
	div		B1,A
	div		B1,A
	div		B1,A

	sub.l	#1,A			; Avoid overflow in computations
	moveu.w	A0,N			; N=guess, store

	sub.w	#28,X0
	neg	X0

	move.l	X:(SP),A		; A=num, re-store
	move.w	N,A0
	impyuu	A1,A0,Y			; Y=x0, start of iterations
	tfr	D,B					; B=den, re-store
	lsrr.l	X0,Y			; Adjust position

	tfr	Y,A					; A=x0
	tfr	A,D					; A=D=x0

	; First iteration
	; den*x0
	impyuu	A1,B0,Y
	imacuu	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*x0

	move.l	X:(SP),A		; A=num, re-store
	sub		C,A				; A=num-den*x0

	tfr		A,C				; C=A=num-den*x0

	move.w	N,Y1			; Y1=(1/den), re-store
	lsr16	Y1,A

	; A*C=(1/den)*(num - den*x0)
	impyuu	A1,C0,Y
	imacuu	A0,C1,Y
	impyuu	A0,C0,C
	lsr16	C
	add		Y,C
	nop						; Required by pipeline

	; D=x1=x0+(1/den)*(num - den*x0)>>k
	lsrr.l	X0,C
	add		C,D				

	tfr		D,A
	nop						; Required by pipeline

	; The second iteration
	; den*x0
	impyuu	A1,B0,Y
	imacuu	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*x1

	move.l	X:(SP),A		; A=num, re-store, free stack
	sub		C,A				; A=num-den*x1

	tfr		A,C				; C=A=num-den*x1

	move.w	N,Y1			; Y1=(1/den), re-store
	lsr16	Y1,A

	; A*C=(1/den)*(num - den*x1)
	impyuu	A1,C0,Y
	imacuu	A0,C1,Y
	impyuu	A0,C0,C
	lsr16	C
	add		Y,C
	nop						; Required by pipeline

	;D=x2=x1+(1/den)*(num - den*x1)>>k
	lsrr.l	X0,C
	add		C,D
	tfr		D,A
	nop

	; Value adjustment
	impyuu	A1,B0,Y
	imacuu	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*x2
	move.w	#0,C2			; Correct extension (may be invalid)

	move.l	X:(SP)-,A		; A=num, re-store, free stack
	move.w	#0,A2			; Correct extension (may be invalid)
	sub		C,A				; A=num-den*x2

	tfr		A,C
	move.w	#1,X0
	clr		A
	sub		B,C
	tge		X0,A
	sub		B,C
	move.w	#2,X0
	tge		X0,A
	sub		B,C
	move.w	#3,X0
	tge		X0,A
	sub		B,C
	move.w	#4,X0
	tge		X0,A
	
	lsr16	A1,A
	add		D,A

	; Sign adjustment
	; NOTE: the denominator is lost!
	tfr		A,B
	neg		B
	tst.w	R0
	tlt		B,A

	; Houskeeping and return
	move.l	X:(SP)-,Y	; only for irem, store the original num
	move.l  X:(SP)-,C	; re-store C
	move.l	X:(SP)-,D	; re-store D

	rtsd
	nop
	nop
	nop

	ENDSEC

	end
