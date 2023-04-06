;              Copyright by Freescale Inc. Oct 2006
;
; IMPORTANT. Read the following Freescale Software License Agreement
; ("Agreement") completely. By using the product you indicate that you
; accept the terms of this Agreement.
;
; FREESCALE SOFTWARE LICENSE AGREEMENT. This is a legal agreement between you
; (either as an individual or as an authorized representative of your employer)
; and Freescale Semiconductor, Inc. ("Freescale"). It concerns your rights to
; use this file and any accompanying written materials (the "Software"). In
; consideration for Freescale allowing you to access the Software, you are
; agreeing to be bound by the terms of this Agreement. If you do not agree to
; all of the terms of this Agreement, do not download the Software. If you
; change your mind later, stop using the Software and delete all copies of the
; Software in your possession or control. Any copies of the Software that you
; have already distributed, where permitted, and do not destroy will continue to
; be governed by this Agreement. Your prior use will also continue to be
; governed by this Agreement.
;
; LICENSE GRANT. The Software may contain two types of programs: (i) programs
; enabling you to design a system ("System Designs"), and (ii) programs that
; could be executed on your designed system ("System Software"). Your rights in
; these distinct programs differ. With respect to System Designs, Freescale
; grants to you, free of charge, the non-exclusive, non-transferable right to
; use, reproduce, and prepare derivative works of the System Designs for the
; sole purpose of designing systems that contain a programmable processing unit
; obtained directly or indirectly from Freescale ("Freescale System"). You may
; not distribute or sublicense the System Designs to others; however, you may
; sell Freescale Systems designed using the System Design. Freescale does not
; grant to you any rights under its patents to make, use, sell, offer to sell,
; or import systems designed using the System Designs. That is beyond the scope
; of this Agreement. With respect to System Software, Freescale grants to you,
; free of charge, the non-exclusive, non-transferable right use, reproduce,
; prepare derivative works of the System Software, distribute the System
; Software and derivative works thereof in object (machine-readable) form only,
; and to sublicense to others the right to use the distributed System Software
; exclusively with Freescale Systems. You must prohibit your sublicensees from
; translating, reverse engineering, decompiling, or disassembling the System
; Software except to the extent applicable law specifically prohibits such
; restriction. If you violate any of the terms or restrictions of this
; Agreement, Freescale may immediately terminate this Agreement, and require
; that you stop using and delete all copies of the Software in your possession
; or control. You are solely responsible for systems you design using the
; Software.
;
; COPYRIGHT. The  Software  is licensed to you, not sold. Freescale  owns the
; Software, and United States copyright  laws and international treaty
; provisions  protect the Software. Therefore, you must treat the Software like
; any other copyrighted material (e.g.,  a  book or musical recording). You may
; not use or copy the Software for any other purpose than what is described in
; this Agreement. Except as expressly provided herein,  Freescale  does not
; grant to  you  any  express  or implied rights under any Freescale or third
; party patents,   copyrights,   trademarks,   or   trade   secrets.
; Additionally, you must reproduce and apply any copyright or  other proprietary
; rights notices included on or embedded in the Software to any copies or
; derivative works made thereof, in whole or in part, if any.
;
; SUPPORT. Freescale is NOT obligated to provide any support, upgrades or new
; releases of the Software. If you wish, you may contact Freescale and report
; problems and provide suggestions regarding the Software. Freescale has no
; obligation whatsoever to respond in any way to such a problem report or
; suggestion. Freescale may make changes to the Software at any time, without
; any obligation to notify or provide updated versions of the Software to you.
;
; NO WARRANTY. TO THE MAXIMUM EXTENT PERMITTED BY LAW, FREESCALE EXPRESSLY
; DISCLAIMS ANY WARRANTY FOR THE SOFTWARE. THE SOFTWARE IS PROVIDED "AS IS",
; WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT
; LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
; PARTICULAR PURPOSE, OR NON-INFRINGEMENT. YOU ASSUME THE ENTIRE RISK ARISING
; OUT OF THE USE OR PERFORMANCE OF THE SOFTWARE, OR ANY SYSTEMS YOU DESIGN USING
; THE SOFTWARE (IF ANY). NOTHING IN THIS AGREEMENT MAY BE CONSTRUED AS A
; WARRANTY OR REPRESENTATION BY FREESCALE THAT THE SOFTWARE OR ANY DERIVATIVE
; WORK DEVELOPED WITH OR INCORPORATING THE SOFTWARE WILL BE FREE FROM
; INFRINGEMENT OF THE INTELLECTUAL PROPERTY RIGHTS OF THIRD PARTIES.
;

	SECTION rtlib

	ORG X:

	ENDSEC


	SECTION rtlib

	ORG P:

	GLOBAL F_idiv_uls_canoverflow
	GLOBAL FF_idiv_uls_canoverflow

;------------------------------------------------------------------------------
;
; The routine computes the unsigned integer division of 32-bit by 16-bit
; numbers.
; 
; NOTE:
;   The routine does not take care about overflow. The result is valid
;   ONLY if no overflow ocurrs.
;
; A  = num (unsigned 32-bit)
; Y0 = den (unsigned 16-bit)

F_idiv_uls_canoverflow:
FF_idiv_uls_canoverflow:

	tst.w	Y0			; Y0-0?
	bge		>DenShort	; Y0>=0

	; Denominator is long (00008000..0000FFFF)
DenLong:
	adda	#2,SP
	move.l	C10,X:(SP)+
	move.l	D10,X:(SP)+
	move.l	A10,X:(SP)

	lsr16	Y0,B
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

	; Value adjustment
	impyuu	A1,B0,Y
	imacuu	A0,B1,Y
	impyuu	A0,B0,C
	add		Y0,C			; C=den*x0
	move.w	#0,C2			; Correct extension (may be invalid)

	move.l	X:(SP)-,A		; A=num, re-store, free stack
	move.w	#0,A2			; Correct extension (may be invalid)
	sub		C,A				; A=num-den*x0=rem (tentative)

	tfr		A,Y				; Y=rem (tentative)
	tfr		D,A				; A=quo (tentative)
	
	cmp.l	Y,B				; den-rem?
	bhi		DenLong_QuoAdjEnd
	
	add.l	#1,A			; quo=quo+1
	sub		B,Y				; rem=rem-den
	
	; must be correct, fall through
	
	IF 0
	; It seems that the second correction is not necessary
	cmp.l	B,Y	
	bhi		DenLong_QuoAdjEnd
	add.l	#1,A
	sub		B,Y
	ENDIF	
	
DenLong_QuoAdjEnd:
	
	; Houskeeping and return
	move.l	X:(SP)-,D
	move.l	X:(SP)-,C

	rtsd
	move.w	A0,Y0
	nop
	nop

	; Denominator is short (0..7FFF)
DenShort:

	tst		A			; Carry=0, req by div
	div		Y0,A		; 16xdiv
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A
	div		Y0,A

DenShort_Return:
	rtsd				; Return
	div		Y0,A
	rol.l	A			; A=A<<1 <- Carry ()
	move.w A0,Y0

	ENDSEC
