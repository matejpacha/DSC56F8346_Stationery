;----------------------------------------------------------------------
; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:02:37 $
; $Revision: 1.17 $
;
;	signal.asm
;	
;
; 	Routines
; 	--------
; 	signal and raise
;	(constant definitions taken from MSL/signal.h)
;	#define SIG_DFL signal_funcs[0]
;	#define SIG_IGN signal_funcs[1]
;  
;---------
; Changes:
; 02/25/2001	US	Modified for Hawk2.
; 09/06/2001	JR 	May need modification for large data mem model
; 06/25/2002	ID	Support needed for different PC extensions. Now uses
;					2nd dimension of signal_funcs to put the extension in
;					a mask, ready to be or'd with the SR that is to be saved
;----------------------------------------------------------------------

	section	rtlib
	include	"asmdef.h"
	org p:
	global	Fraise
	
Fraise:
	IF !@DEF(F__CW_M56800E_LMM)
		tst.w	y0						; Make sure signal is in range.       
		ble		<RaiseFail
		cmp.w	#signal_max,y0
		nop
		bgt		<RaiseFail

	    inc.w	y0						; (signal-1) +2
	    move.l	#>>Fsignal_funcs,r0		; works for SPM/LPM
	    moveu.w	y0,N
	    nop
	    nop
		adda	N,N
		nop
		nop
	    move.w	x:(r0+N),x0				; signal_func = signal_funcs[signal-1]
		move.w	x:(r0+2),y1				; if signal_func == SIG_IGN
		cmp.w	x0,y1
		beq		RaiseSucc				; return(0)
		dec.w	y0						; restore original value of signal
		move.w	x:(r0),y1				; else, signal_funcs[signal-1] = SIG_DFL
		move.w	y1,x:(r0+N)
		cmp.w	y1,x0					; if signal_func != SIG_DFL call handler
		bne		callhandler
		cmp.w	#SIGABRT,y0				; else if signal == SIGABRT
		beq		RaiseSucc				; return(0)
		move.w	#0,y0					; else exit(0);
		jsr		Fexit
callhandler:
	
		move.l	#>>RaiseSucc,r1			; works for SPM/LPM
		adda #4,sp						; jrusso - update sp once by even number
		move.w r1,x:(sp-3)				; Save return address
		move.w sr,x:(sp-2)
		move.w x0,x:(sp-1)				; put the handler address on the stack
		move.w sr,x:(sp)				; and do an rts
		rts								; transfer flow to handler            

RaiseSucc:
		move.w	#0,y0		; set the return status code          
		rts
RaiseFail:
		move.w	#-1,y0
		rts
	ELSE
		tst.w	y0						; Make sure signal is in range.       
		ble		<RaiseFail
		cmp.w	#signal_max,y0
		nop
		bgt		<RaiseFail

	    inc.w	y0						; (signal-1) +2
	    move.l	#>>Fsignal_funcs,r0		; LMM
	    moveu.w	y0,N
	    nop
	    nop
		adda	N,N
		nop
		nop
	    move.w	x:(r0+N),x0				; signal_func = signal_funcs[signal-1]
		move.w	x:(r0+2),y1				; if signal_func == SIG_IGN
		cmp.w	x0,y1
		beq		RaiseSucc				; return(0)
		dec.w	y0						; restore original value of signal
		move.w	x:(r0),y1				; else, signal_funcs[signal-1] = SIG_DFL
		move.w	y1,x:(r0+N)
		cmp.w	y1,x0					; if signal_func != SIG_DFL call handler
		bne		callhandler
		cmp.w	#SIGABRT,y0				; else if signal == SIGABRT
		beq		RaiseSucc				; return(0)
		move.w	#0,y0					; else exit(0);
		jsr		Fexit
callhandler:
	
		move.l	#>>RaiseSucc,r1			;LMM
		adda #4,sp						; update sp once by even number
		move.w r1,x:(sp-3)				; Save return address
		move.w sr,x:(sp-2)
		move.w x0,x:(sp-1)				; put the handler address on the stack
		move.w	sr,a
		bfclr	#$0c00,a	; mask out PC extension bits
		adda	#1,N
		move.w	x:(r0+N),b	; load SR mask with the new extension bits
		or.w	a,b			; put in new bits
		move.w	b,x:(sp)	; save as SR
		rts					; transfer flow to handler            
RaiseSucc:
		move.w	#0,y0		; set the return status code          
		rts
RaiseFail:
		move.w	#-1,y0
		rts
	ENDIF	
	endsec

	end
