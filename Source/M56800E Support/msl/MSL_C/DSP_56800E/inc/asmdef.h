;----------------------------------------------------------------------
; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:02:39 $
; $Revision: 1.8 $
;
;
;	asmdef.h
;	
;
; 	Routines
; 	--------
; 	macros and defines for simplifying assembly coding
;  
;----------------------------------------------------------------------
;

TRUE	equ	1
FALSE	equ	0


;************************************************************************
;
; Macro definitions
; 
;************************************************************************
PUSH	MACRO	arg
	lea	(sp)+
	move	arg,x:(sp)
	ENDM

push	MACRO	arg
	lea	(sp)+
	move	arg,x:(sp)
	ENDM


;************************************************************************
;
; Assembly version of errno.h and signal.h
; 
;************************************************************************
signal_max		equ		6
SIGABRT			equ		1
SIGFPE			equ		2
SIGILL			equ		3
SIGINT			equ		4
SIGSEGV			equ		5
SIGTERM			equ		6

ENOERR			equ		0
EDOM			equ		33
ERANGE			equ		34
EFPOS			equ		35
ESIGPARM		equ		36

SIG_DFL_NUM		equ		0	; US 02/25/2001 
SIG_IGN_NUM		equ		1	; US 02/25/2001 
