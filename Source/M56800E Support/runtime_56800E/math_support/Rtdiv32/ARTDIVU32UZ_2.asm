; MSL
; Copyright ©2005 Freescale Corporation.  All rights reserved.

	SECTION rtlib

	ORG X:


	ENDSEC


	SECTION rtlib


	ORG P:

    IF !@DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global	ARTDIVU32UZ_2
ARTDIVU32UZ_2:
	ENDIF

	LOCAL	DenHuge
	LOCAL	DenNotHuge
	LOCAL	QuotEq0
	LOCAL	QuotEq1

;------------------------------------------------------------------------------
; A = numul
; B = denul
;
; The routine implements Halley's method adopted to integer arithmetic.
;
; The routine uses the following registers:
; A, B, C, D, X0, Y, N

	sxt.l	B
	tst.l	B
	blt		>DenHuge
DenNotHuge:
	adda	#2,SP
	move.l	C10,X:(SP)+
	move.l	D10,X:(SP)+
	move.l	A10,X:(SP)

	clb		B,X0
	
	tfr		B,D				; D=den, store
	asll.l	X0,B
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
	neg		X0
	
	move.l	X:(SP),A		; A=num, re-store
	move.w	N,A0
	impyuu	A1,A0,Y			; Y=x0, start of iterations
	tfr		D,B				; B=den, re-store
	lsrr.l	X0,Y

	tfr		Y,A				; A=x0
	tfr		A,D				; A=D=x0
	
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
	nop

	; D=x1=x0+(1/den)*(num - den*x0)>>k
	lsrr.l	X0,C
	add		C,D				

	tfr		D,A
	nop
	
	; den*x0
	impyuu	A1,B0,Y
	imacuu	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*x0
	
	move.l	X:(SP),A		; A=num, re-store, free stack
	sub		C,A				; A=num-den*x0
	
	tfr		A,C				; C=A=num-den*x0
	
	move.w	N,Y1			; Y1=(1/den), re-store
	lsr16	Y1,A
	
	; A*C
	; A*C=(1/den)*(num - den*x0)
	impyuu	A1,C0,Y
	imacuu	A0,C1,Y
	impyuu	A0,C0,C
	lsr16	C
	add		Y,C
	nop
	
	; D=x1=x0+(1/den)*(num - den*x0)>>k
	lsrr.l	X0,C
	add		C,D				

	tfr		D,A
	nop
	
	; Value adjustment
	impyuu	A1,B0,Y
	imacuu	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*x0
	move.w	#0,C2			; Correct extension (may be invalid)
	
	move.l	X:(SP),A		; A=num, re-store, free stack
	move.w	#0,A2			; Correct extension (may be invalid)
	sub		C,A				; A=num-den*x0
	
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

	; Houskeeping and return
	move.l		X:(SP)-,Y	; only for irem
	move.l      X:(SP)-,D
	move.l      X:(SP)-,C
	
	rtsd
	nop
	nop
	nop


DenHuge:
	adda	#2,SP
	move.l	A10,X:(SP)
	move.l	#$00000001,Y
	cmp		B,A				; A-B?
	bhs		QuotEq1
QuotEq0:
	move.l	#$00000000,Y
QuotEq1:
	tfr		Y,A
	move.l	X:(SP)-,Y
	rtsd
	nop
	nop
	nop		



	ENDSEC

	end

