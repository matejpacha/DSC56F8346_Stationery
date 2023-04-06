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

	GLOBAL F_idiv_ls_canoverflow
	GLOBAL FF_idiv_ls_canoverflow

;------------------------------------------------------------------------------
;
; The routine computes the signed integer division of 32-bit by 16-bit
; numbers.
; 
; NOTE:
;   The routine does not take care about overflow. The result is valid
;   ONLY if no overflow ocurrs.

; A  = numl (32-bit)
; Y0 = dens (16-bit)

F_idiv_ls_canoverflow:
FF_idiv_ls_canoverflow:

	move.w	A1,X0
	eor.w	Y0,X0		; X0=sign

	abs		A			; positive values

	; Denominator is short (0..7FFF)
DenShort:
	
	tst		A			; Carry=0, req by div
	;do		#8,DenShort_Loop2End
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
	div		Y0,A
	div		Y0,A
	rol.l	A			; A=A<<1 <- Carry ()

SignAdj:
	; Sign adjustment
	tfr		A,B
	neg		B			; B=-quo
	tst.w	X0			; X0-0? (sign test)
	nop
	tlt		B,A			; A=sign<0?-quo:quo

DenShort_Return:
	rtsd				; Return
	move.w	A0,Y0
	nop
	nop

	ENDSEC
