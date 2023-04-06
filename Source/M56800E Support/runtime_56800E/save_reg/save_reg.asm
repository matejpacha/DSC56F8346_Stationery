



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;	save_reg.asm
;	
;
; 	Routines
; 	--------
;
;	SL 	7/16/2001 	Save and restore 56800E registers
;	US 	11/12/2001	Put in core technology center suggestions. 
;  
;----------------------------------------------------------------------

	include "omrmodebits.h"

	
	section		rtlib
	global		INTERRUPT_SAVEALL
	global		INTERRUPT_RESTOREALL

	org	p:
	
	SUBROUTINE	"INTERRUPT_SAVEALL",INTERRUPT_SAVEALL,INTERRUPT_SAVEALL_END-INTERRUPT_SAVEALL

INTERRUPT_SAVEALL:
;  The SR and OMR register must be stored before storing HWS
	adda	#<2,sp	; SP is always long aligned and point to last frame, move away from it first
	move.l  n,x:(sp)+
	move.l  r0,x:(sp)+
	move.l  r1,x:(sp)+
	move.l  r2,x:(sp)+
	move.l  r3,x:(sp)+
	move.l  r4,x:(sp)+
	move.l  r5,x:(sp)+
	move.l  lc2,x:(sp)+		;save LC2/LA2 first, to make sure they got restore last
	move.l  la2,x:(sp)+		;write LC2 after writing LC as it is affected by write to LC
	move.l  lc,x:(sp)+
	move.l  la,x:(sp)+
	move.l  a2,x:(sp)+
	move.l  omr,x:(sp)+
	move.l  a10,x:(sp)+
	move.l  b2,x:(sp)+
	move.l  sr,x:(sp)+
	move.l  b10,x:(sp)+
	move.l  c2,x:(sp)+
	move.l  m01,x:(sp)+
	move.l  c10,x:(sp)+
	move.l  d2,x:(sp)+
	move.l  n3,x:(sp)+
	move.l  d10,x:(sp)+
	move.l  hws,x:(sp)+
	move.l  hws,x:(sp)+
	move.l  x0,x:(sp)+         
	move.l  y,x:(sp)+
	bfclr	#(CM_MODE|XP_MODE|R_MODE|SA_MODE),omr		; ensure CM=0  (optional for C)
														; ensure XP=0 to enable harvard architecture
														; ensure R=0  (required for C)
														; ensure SA=0 (required for C)
	move.l  x:(sp-56),a	; copy return address to return stack for RTS
	move.l  a10,x:(sp)
	bfset	#$ffff,m01			; Setup the m01 register for linear addressing
	rts
INTERRUPT_SAVEALL_END:

	SUBROUTINE	"INTERRUPT_RESTOREALL",INTERRUPT_RESTOREALL,INTERRUPT_RESTOREALL_END-INTERRUPT_RESTOREALL
	
INTERRUPT_RESTOREALL:
;  The LC register must be loaded before LC2, because
;    every time LC is written, the old value of LC gets loaded in LC2
	move.l  x:(sp),a
	move.l  a10,x:(sp-56)	; copy return address to return stack for RTS
	suba	#2,sp			; compensate change of SP in JSR that call this function
	move.l  x:(sp)-,y
	move.l  x:(sp)-,x0
	move.l  x:(sp)-,hws
	move.l  x:(sp)-,hws
	move.l  x:(sp)-,d
	move.l  x:(sp)-,n3
	move.l  x:(sp)-,d2
	move.l  x:(sp)-,c
	move.l  x:(sp)-,m01
	move.l  x:(sp)-,c2
	move.l  x:(sp)-,b
	move.l  x:(sp)-,sr
	move.l  x:(sp)-,b2
	move.l  x:(sp)-,a
	move.l  x:(sp)-,omr
	move.l  x:(sp)-,a2
	move.l  x:(sp)-,la
	move.l  x:(sp)-,lc
	move.l  x:(sp)-,la2
	move.l  x:(sp)-,lc2		;write LC2 after writing LC as it is affected by write to LC
	move.l  x:(sp)-,r5
	move.l  x:(sp)-,r4
	move.l  x:(sp)-,r3
	move.l  x:(sp)-,r2
	move.l  x:(sp)-,r1
	move.l  x:(sp)-,r0
	move.l  x:(sp)-,n
	rts
INTERRUPT_RESTOREALL_END:

	endsec