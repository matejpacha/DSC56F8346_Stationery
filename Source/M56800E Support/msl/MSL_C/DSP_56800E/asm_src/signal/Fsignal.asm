;----------------------------------------------------------------------
; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:02:37 $
; $Revision: 1.14 $
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
; 09/06/2001	JR	May need modification for large data mem model
; 06/25/2002	ID	Support needed for different PC extensions. Now uses
;					2nd dimension of signal_funcs to put the extension in
;					a mask, ready to be or'd with the SR that is to be saved
;----------------------------------------------------------------------

	section	rtlib
	include	"asmdef.h"
	org p:

	global	Fsignal
	
Fsignal:

	IF !@DEF(F__CW_M56800E_LMM)
	    tst.w   y0              ; Make sure signal is in range (0 < y0 <= 6). 
	    ble     <SignalFail
	    cmp.w   #signal_max,y0
	    nop
	    bgt     <SignalFail
	    
	    add.w	#1,y0						; (signal-1) + 2
	    moveu.w	#>Fsignal_funcs,r0
	    moveu.w	y0,N
		nop
		nop
		adda	N,N
		nop
		nop
	    move.w	x:(r0+N),y0				; old_signal_func = signal_funcs[signal-1]
	    move.w	r2,x:(r0+N)				; signal_funcs[signal-1] = signal_func
		adda	#1,N
		clr.w	x:(r0+N)				; clear SR mask (extension bits will be 0x00)
	    moveu.w	y0,r2
		rts
	
SignalFail:
		move.l	#>>F__sig_err,r2			;work for SPM/LPM
		move.w	#>ESIGPARM,x:>Ferrno
		rts
	ELSE
	    tst.w   y0              ; Make sure signal is in range (0 < y0 <= 6). 
	    ble     <SignalFail
	    cmp.w   #signal_max,y0
	    nop
	    bgt     <SignalFail
	    
	    add.w	#1,y0						; (signal-1) + 2
	    move.l	#>>Fsignal_funcs,r0			; LMM
	    moveu.w	y0,N
		move.l	r2,a					; get address for handler function
		asll.w	#10,a					; move extension bits into bits 10:14 (create SR mask)
		adda	N,N
		nop
		nop
	    move.w	x:(r0+N),y0				; old_signal_func = signal_funcs[signal-1]
	    move.w	r2,x:(r0+N)				; signal_funcs[signal-1] = signal_func
		adda	#1,N
		move.w	a,x:(r0+N)				; store SR mask
	    moveu.w	y0,r2
		rts
	
SignalFail:
		move.l	#>>F__sig_err,r2			;LMM
		move.w	#>ESIGPARM,x:>>Ferrno		;LMM
		rts
	ENDIF
	
	endsec

	end
