;----------------------------------------------------------------------
; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:02:33 $
; $Revision: 1.8 $
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
; 02/25/2001	US	Fix. SIG_DFL and SIG_IGN are now really signal_funcs[0]
;					and signal_funcs[1], respectively.
;					NOTE:	We have to be careful the SIG_DFL_NUM and 
;							SIG_IGN_NUM are the same as in csignal.
; 06/25/2002	ID	Increased array to two-dimensional, to store in
;					signal_funcs[n][1] the PC extension to be used in signal()
;					and raise().
;----------------------------------------------------------------------

	section	rtlib
	include	"asmdef.h"
	org p:

	global	F__sig_err
	
F__sig_err:
	rts

	org	x:
	
	global Fsignal_funcs


Fsignal_funcs	dc		SIG_DFL_NUM,0		; for some reason "bsc signal_max" doesn''t work in the assembler
				dc		SIG_IGN_NUM,0
				dc		0,0
				dc		0,0
				dc		0,0
				dc		0,0
				dc		0,0
				dc		0,0

	endsec

	end
