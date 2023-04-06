



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;	Description:  Main entry point to C code.
;                 Setup runtime for C and call main.
;   
;                 this file is included for legacy purposes
;                 
; 
;  
;----------------------------------------------------------------------



	include "omrmodebits.h"
	section		rtlib

	XREF	F_stack_addr
	org	p:

	
	GLOBAL FSTART_

	SUBROUTINE "FSTART_",FSTART_,FSTARTEND-FSTART_

FSTART_:

;
; setup the OMr with the values required by C
;
	bfset	#NL_MODE,omr		; ensure NL=1  (enables nsted DO loops)
	nop
	nop
	bfclr	#(CM_MODE|XP_MODE|R_MODE|SA_MODE),omr		; ensure CM=0  (optional for C)
														; ensure XP=0 to enable harvard architecture
														; ensure R=0  (required for C)
														; ensure SA=0 (required for C)

; Setup the m01 register for linear addressing
	move.w	#-1,x0
	moveu.w	x0,m01			; Set the m register to linear addressing
				
	moveu.w	hws,la			; Clear the hardware stack
	moveu.w	hws,la
	nop
	nop


CALLMAIN:			; Initialize compiler environment

;=======================OLD=============================
; Note:  This was the old stack intialization sequence.  We now use F_Lstack_addr which is set in the linker
;        command file/
;	bftsth	#$0001,x:>F_stack_addr
;	bcc		noincOLD
;	inc.w		x:>F_stack_addr
;noincOLD:
;	moveu.w	x:>>F_stack_addr,r0		; Get Stack start address
;	nop
;=======================OLD=============================

;Initialize the Stack
	move.l #>>F_Lstack_addr,r0
	bftsth #$0001,r0
	bcc noinc
	adda #1,r0
noinc:
	tfra	r0,sp				; set stack pointer too
	move.w	#0,r1
	nop
	move.w	r1,x:(sp)
	adda	#1,sp	
	
	jsr		F__init_sections
; Call main()
	move.w	#0,y0				; Pass parameters to main()
	move.w	#0,R2
	move.w	#0,R3

	jsr	 	Fmain				; Call the Users program
;
;   The fflush calls where removed because they added code
;   growth in cases where the user is not using any debugger IO.
;   Users should now make these calls at the end of main if they use debugger IO
;
;	move.w	#0,r2
;	jsr  	Ffflush 			; Flush File IO
;	jsr  	Ffflush_console 	; Flush Console IO	

;	end of program; halt CPU	
	debughlt
	rts
FSTARTEND:

	endsec