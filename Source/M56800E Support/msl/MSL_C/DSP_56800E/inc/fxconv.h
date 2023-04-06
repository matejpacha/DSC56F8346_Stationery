; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:02:43 $
; $Revision: 1.6 $
;

startmask EQU $4000
m0 EQU $30
m1 EQU $31
m2 EQU $32
m3 EQU $33
m4 EQU $34
m5 EQU $35
m6 EQU $36
m7 EQU $37
startmask_lsl EQU $8000
xlo	EQU $36
xhi	EQU $37
xleading1 EQU $30
exp_mask EQU $7f80
frac_hi_mask EQU $7f
overflow_mask EQU $4000
input_sign	EQU	$39
INVALID		EQU	$0040



SetInvalid	MACRO
	bfset	#INVALID,x:>FPE_state
	ENDM	
