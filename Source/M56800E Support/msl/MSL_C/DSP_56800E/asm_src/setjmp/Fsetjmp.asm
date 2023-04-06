;----------------------------------------------------------------------
; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:02:32 $
; $Revision: 1.11 $
;
;	setjmp.asm
;
; 	Routines
; 	--------
; 	setjmp and longjmp
;  
;----------------------------------------------------------------------
;

	section	rtlib
	global	Fsetjmp

    include "asmdef.h"
	org	p:
;************************************************************************
; int _setjmp( jmp_buf env)
;
; Parameters:
;  env		Pointer to a place to store state (passed in r2)
;
; Effect:
;	Any state we might possibly need to get back to the call
; site is copied into the state block:
; The return status is placed in y0.
;
; [0] SR (Contains part of the the 3msb of the PC and the LF, loop flag) 
; [1] Stack pointer
; [2-3] PC
; [4] LA
;     LA2
; [5] LC
;     LC2
; [6] OMR (contains the NL, Nested loop, bit)
; [7] HWS 
; [8] HWS
; [9-29]	Machine registers (note that r2 and y0 do not need to be
;			saved as they are used as parameters or to return the result).
; [30-31]   Spare.
;
; The return status is placed in y0.
;
;*********
; Changes:
; 02/25/2001	US	Modified for Hawk2.
; 09/19/2001	JR  Modified for LMM
;
;************************************************************************
Fsetjmp:
	;*** Small Data Memory Model ***
	IF !@DEF(F__CW_M56800E_LMM)	
		bfset	#1,r2			; LT align r2 for long instructions

		move.w	sr,x:(r2)+		; [0] save the sr
		bfset	#$0200,sr		; disable interrupts
		move.w	sp,x:(r2)+		; [1] save the sp

		move.w	x:(sp),y0		; get the msb of the return address
		move.w	y0,x:(r2)+		; [2] save the msb
		move.w	x:(sp-1),y0		; get the lsb of the return address
		move.w	y0,x:(r2)+		; [3] save the lsb

		move.w	la,x:(r2)+		; [4] save the la
		move.w	lc,x:(r2)+		; [5] save the lc

		move.w	omr,x:(r2)+	 	; [6] save the omr 	

		moveu.w	hws,la
		move.w	la,x:(r2)+		; [7] save the first hw stack location 
		moveu.w	hws,lc
		move.w	lc,x:(r2)+		; [8] save the second hw stack location 		

		move.l	a10,x:(r2)+
		adda	#1,r2
		move.w	a2,x:(r2)+
		move.l	b10,x:(r2)+
		adda	#1,r2
		move.w	b2,x:(r2)+
		move.l	c10,x:(r2)+

		adda	#2,sp			; LT save c2
		move.l	c2,x:(sp)+
		move.l	x:(sp-2),c
		move.l	c10,x:(r2)+

		move.l	d10,x:(r2)+
		
		move.l	d2,x:(sp)+		; LT save d2
		move.l	x:(sp-2),d
		move.l	d10,x:(r2)+
		suba	#6,sp
		
	    move.w  x0,x:(r2)+
	    move.w  y1,x:(r2)+
	    move.w  r0,x:(r2)+
	    move.w  r1,x:(r2)+
	    move.w  r3,x:(r2)+
	    move.w  r4,x:(r2)+
	    move.w  r5,x:(r2)+
	 
		move.w  m01,x:(r2)+
		move.w	n,x:(r2)+
		move.w 	n3,x:(r2)+		; wb1-30083

		move.w	#0,y0			; clear the status return result
	    rti						; note that the sr register is restored
								; with the rti instruction.
		
	ELSE
	;*** Large Data Memory Model ***
		; bfset above clears upper 8 bits of 24bit r reg--use this method
		brset	#1,r2,done_align	; Already odd word aligned
		adda	#1,r2				; align to odd word
done_align:		
		adda #1,r2					; for alignment	
		move.l n,x:(r2)+			; save n first so I can use it for a scratch reg below

	
		move.w	sr,x:(r2)+			; [0] save the sr
		bfset	#$0200,sr			; disable interrupts
	

		adda #1,r2					; align & [1] save the sp
		tfra 	sp,n
		move.l	n,x:(r2)+
		move.w	x:(sp),y0			; get the msb of the return address
		move.w	y0,x:(r2)+			; [2] save the msb
		move.w	x:(sp-1),y0			; get the lsb of the return address
		move.w	y0,x:(r2)+			; [3] save the lsb

									; [4] save the la
		adda	#1,r2				; r2 will be xfer'd to sp, which must be odd
		tfra	sp,n				; save sp
		tfra	r2,sp				; current setjmp ptr to sp
		move.l	la,x:(sp)+			; save la (note: no move.l la,x:(sp) instruction)
		tfra	n,sp				; restore sp
		adda	#2,r2				; update setjmp ptr
	
		move.w	lc,x:(r2)+			; [5] save the lc

		move.w	omr,x:(r2)+	 		; [6] save the omr 	
	
		tfra	sp,n
		tfra	r2,sp
		move.l	hws,x:(sp)+			; [7] save the first hw stack location 
		move.l	hws,x:(sp)+			; [8] save the second hw stack location
		move.l  n3,x:(sp)+			; wb1-30083
		tfra	n,sp
		adda	#4,r2
		adda	#1,r2				; get r2 even again

		move.l	a10,x:(r2)+
		adda	#1,r2
		move.w	a2,x:(r2)+
		move.l	b10,x:(r2)+
		adda	#1,r2
		move.w	b2,x:(r2)+
		move.l	c10,x:(r2)+

		adda	#2,sp				; LT save c2
		move.l	c2,x:(sp)+
		move.l	x:(sp-2),c
		move.l	c10,x:(r2)+

		move.l	d10,x:(r2)+
	
		move.l	d2,x:(sp)+			; LT save d2
		move.l	x:(sp-2),d
		move.l	d10,x:(r2)+
		suba	#6,sp
	
	    move.w  x0,x:(r2)+
	    move.w  y1,x:(r2)+
    
	    move.l  r0,x:(r2)+
	    move.l  r1,x:(r2)+
	    move.l  r3,x:(r2)+
	    move.l  r4,x:(r2)+
	    move.l  r5,x:(r2)+
 
		move.w  m01,x:(r2)+
		; n now saved first

		move.w	#0,y0				; clear the status return result
    	rti							; note that the sr register is restored
									; with the rti instruction.
	ENDIF

	endsec

	end
