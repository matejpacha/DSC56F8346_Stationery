



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.



;----------------------------------------------------------------------
;
;	rtmpyf32.asm
;	
; 	Routines
; 	--------
; 	32 bit signed fixed point multiplication
;	Algorithm taken from "DSP 56800 Family Manual" pg.3-31
;  
;----------------------------------------------------------------------

	section	rtlib
	
    global  ARTMPYFXS32U
    
    org p:

ARTMPYFXS32U:
    move.w  a0,y0
    andc	#$7fff,y0
    move.w  x:(sp-3),y1
    mpysu	y0,y1,b
    tst.w	a0
    brclr	#$0008,sr,over
    add		y1,b
over:
	lsr16	b				; unsigned shift right

	move.w	a1,x0			; cannot use a1 as signed operand of macsu
	macsu	x0,y0,b
	
	move.w	y0,y1
	move.w	x:(sp-2),y0
	macsu	y0,y1,b
	
	asr16	b				; signed shift right
	mac		x0,y0,b
	
	tfr		b,a        
    rts

    endsec

    end


