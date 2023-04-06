;----------------------------------------------------------------------
;  CodeWarrior Embedded Runtime Support 1998 May 
;
;	setjmp.asm
;	
; 		Copyright © 1995-2007 Freescale Corporation.
; 		All rights reserved.
;
; 	Routines
; 	--------
; 	setjmp and longjmp
;  
;----------------------------------------------------------------------
;

	section	rtlib
	global	Flongjmp

    include "asmdef.h"
	org	p:

;************************************************************************
; int longjmp( jmp_buf env, int val)
;
; Parameters:
;  env		Pointer to a place to restore state from (r2)
;  val		A return value, that should not be zero  (y0)
;
; Effect:
;	We return to the place that the state block suggests.
;
;*********
; Changes:
; 02/25/2001	US	Modified for Hawk2.
;************************************************************************
Flongjmp:
	bfset	#$0200,sr		; disable interrupts
        ;
        ; Note that we can not restore the SR register since it includes
        ; the setjmp 3 msb''s of the PC. This may be different than the 
        ; current bits. Restoring the SR may potentially cause an unwanted 
        ; change of flow !!!
        ;
    ;*** Small Data Memory Model
	IF !@DEF(F__CW_M56800E_LMM)
		bfset	#1,r2			; LT align r2 for long instructions

		move.w	x:(r2)+,x0		; [0] get the SR value
	    moveu.w x:(r2)+,sp      ; [1] restore the sp
	    
 	    move.w  x:(r2)+,y1      ; [2] restore the msb 
  		nop
 	    move.w  y1,x:(sp)      ; set the msb of the return address
 	    move.w  x:(r2)+,y1      ; [3] restore the lsb      
 	    move.w  y1,x:(sp-1)      ; set the lsb of the return address
	                                                          
		moveu.w	hws,la			; make sure the hw stack is empty
		moveu.w	hws,la	
	    moveu.w x:(r2)+,la      ; [4] restore the la
	    moveu.w x:(r2)+,lc      ; [5] restore the lc
	                                                             
		move.w	x:(r2)+,y1		; [6] get the OMR value

		brclr	#$8000,x0,LFClear	; if LF bit clear, nothing to restore 
		nop
		nop
		brclr	#$8000,y1,NLClear	; if NL bit clear, only one entry
		adda	#1,r2			; we need to restore the second word first
	    moveu.w x:(r2)-,hws     ; [8] restore the second hw stack loc   
NLClear:
		moveu.w	x:(r2)+,hws		; [7] restore the first entry
		moveu.w	y1,omr			; restore the omr regiser
		adda	#1,r2
	    nop
		bra		doneincing
LFClear:
		adda	#2,r2			; Skip the next two words
doneincing:
		move.l	x:(r2)+,a
		adda	#1,r2
		move.w	x:(r2)+,a2
		move.l	x:(r2)+,b
		adda	#1,r2
		move.w	x:(r2)+,b2

	    move.w	y0,x0			; Save y0 - return value

		move.l  x:(r2)+,c

		adda	#6,sp			; LT restore c2
		move.l	x:(r2)+,y
		move.l	y,x:(sp)
		move.l	x:(sp)-,c2
	    
	    move.l	x:(r2)+,d
	    
	    move.l	x:(r2)+,y		; LT restore d2
	    move.l	y,x:(sp)
	    move.l	x:(sp)-,d2
	    suba	#2,sp
	       
	    move.w	x0,y0			; Restore return value
	    
	    move.w  x:(r2)+,x0
	    move.w  x:(r2)+,y1
	    moveu.w x:(r2)+,r0
	    moveu.w x:(r2)+,r1      
	    moveu.w x:(r2)+,r3
	    moveu.w x:(r2)+,r4      
	    moveu.w x:(r2)+,r5
	                           
	    moveu.w x:(r2)+,m01
	    moveu.w x:(r2)+,n
	    moveu.w x:(r2)+,n3		; wb1-30083

		tst.w	y0
		bne		Done
	    move.w  #1,y0            ; Can't return zero as status 
Done:
	    rti     
	
	ELSE
	;*** Large Data Memory Model
		; bfset above clears upper 8 bits of 24bit r reg--use this method
		brset	#1,r2,done_align	; Already odd word align
		adda	#1,r2				; align to odd word
done_align:
		adda	#3,r2				; skip saved n reg for now

		move.w	x:(r2)+,x0			; [0] get the SR value
	
    								; [1] restore the sp
	    adda #1,r2					; for alignment
	    move.l	x:(r2)+,n			; use n as a scratch reg
	    tfra	n,sp
	    move.l	x:(r2-6),n			; restore real value of n now
	    
	    move.w  x:(r2)+,y1      	; [2] restore the msb   
 		nop
     	move.w  y1,x:(sp)      		; set the msb of the return address
     	move.w  x:(r2)+,y1     		; [3] restore the lsb      
    	move.w  y1,x:(sp-1)      	; set the lsb of the return address
    
    	adda	#1,r2				; r2 xfer'd sp, which must be odd
    	tfra	sp,r0				; save sp, use r0 as scratch reg
    	tfra	r2,sp
    	moveu.w	hws,la				; make sure the hw stack is empty
		moveu.w	hws,la	
	    move.l	x:(sp)-,la     		; [4] restore the la
	    adda	#2,r2				; manually update r2
	    tfra	r0,sp				; restore orig sp
	    moveu.w x:(r2)+,lc      	; [5] restore the lc
                                                             
		move.w	x:(r2)+,y1			; [6] get the OMR value
	

		brclr	#$8000,x0,LFClear	; if LF bit clear, nothing to restore  
		nop
		nop
		brclr	#$8000,y1,NLClear	; if NL bit clear, only one entry
		adda	#2,r2				; we need to restore the second word first
		tfra	sp,r0				; use r0 as a scratch reg
		tfra	r2,sp
	    move.l	x:(sp)-,hws     	; [8] restore the second hw stack loc
	    tfra	r0,sp				; restore orig sp
	    adda	#-2,r2				; update r2  
NLClear:
		tfra	sp,r0				; use r0 as a scratch register
		tfra	r2,sp
		move.l	x:(sp)-,hws			; [7] restore the first entry
		tfra	r0,sp				; restore orig sp
		adda	#2,r2				; update r2
		moveu.w	y1,omr				; restore the omr regiser
		adda	#2,r2
	    nop
		bra		doneincing
LFClear:
		adda	#4,r2				; Skip the next four words
doneincing:
		tfra	sp,r0				; wb1-30083
		tfra	r2,sp				; wb1-30083
		move.l	x:(sp)-,n3			; wb1-30083 restore n3
		tfra	r0,sp				; wb1-30083
		adda	#1,r2				; get r2 even again
		move.l	x:(r2)+,a
		adda	#1,r2
		move.w	x:(r2)+,a2
		move.l	x:(r2)+,b
		adda	#1,r2
		move.w	x:(r2)+,b2

    	move.w	y0,x0				; Save y0 - return value

		move.l  x:(r2)+,c

		adda	#6,sp				; LT restore c2
		move.l	x:(r2)+,y
		move.l	y,x:(sp)
		move.l	x:(sp)-,c2
    
    	move.l	x:(r2)+,d
    
    	move.l	x:(r2)+,y			; LT restore d2
    	move.l	y,x:(sp)
    	move.l	x:(sp)-,d2
    	suba	#2,sp
       
    	move.w	x0,y0				; Restore return value
    
    	move.w  x:(r2)+,x0
    	move.w  x:(r2)+,y1
    
	    move.l x:(r2)+,r0
	    move.l x:(r2)+,r1      
	    move.l x:(r2)+,r3
	    move.l x:(r2)+,r4      
	    move.l x:(r2)+,r5  
                           
		moveu.w x:(r2)+,m01
		
		; n restored above
    
		tst.w	y0
		bne		Done
   		move.w  #1,y0            	; Can't return zero as status 
Done:
    	rti    
    ENDIF 

	endsec

	end
	