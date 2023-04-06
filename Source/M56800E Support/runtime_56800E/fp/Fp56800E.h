



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




	
			XREF	FPE_state

; xhi/xlo save the x operand (passed in a) in two-op functions, which
;	is handy for NaN handling, etc.
; yhi/ylo save the y operand (passed in b) in two-op functions, which
;	is handy for NaN handling, etc.
; rexp is the result exponent
; rsign is the result sign (compute as xor during unpack)
; yflip is 0 for add, 0x8000 for sub, to indicate a flip of y's sign
xhi	EQU	0
xlo	EQU	1
yhi	EQU	2
ylo	EQU	3
yflip	EQU	4
rsign	EQU	5
rexp	EQU	6
saved_omr EQU 7

SIZE_TEMPS EQU 8

;offsets for the unpack routines.
xhi_unp	EQU	2
xlo_unp	EQU	3
yhi_unp	EQU	4
ylo_unp	EQU	5
yflip_unp	EQU	6
rsign_unp	EQU	7
rexp_unp	EQU	8


INVALID		EQU	$0040
OVERFLOW	EQU	$0010
UNDERFLOW	EQU	$0008
DIVBYZERO	EQU	$0020
INEXACT		EQU	$0004

TONEAREST	EQU	0
TOWARDZERO	EQU	1
UPWARD		EQU	2
DOWNWARD	EQU	3
BITDIRRND	EQU	2
BITDOWNORCHOP		EQU	1

LFPState	MACRO
	move.w	x:FPE_state,x0 ; jrusso LMM- let 16-24bit asm switch handle instr len
	ENDM
	
SetInvalid	MACRO
	bfset	#INVALID,x:FPE_state ; jrusso LMM
	ENDM
	
SetInexact	MACRO
	bfset	#INEXACT,x:FPE_state ; jrusso LMM
	ENDM
	
SetOverflow	MACRO
	bfset	#(OVERFLOW+INEXACT),x:FPE_state  ; jrusso LMM
	ENDM
	
SetUnderflow	MACRO
	bfset	#(UNDERFLOW+INEXACT),x:FPE_state ; jrusso LMM
	ENDM
	
SetDivByZero	MACRO
	bfset	#DIVBYZERO,x:FPE_state ; jrusso LMM
	ENDM
	
StFPState	MACRO
	move.w	x0,x:FPE_state ; jrusso LMM
	ENDM


NORMALIZE_OMR	MACRO

				move.w  OMR,x:(SP-saved_omr)   ; save original OMR state
				bfset	#$0100,OMR             ; set CC bit
				bfclr	#$0030,OMR             ; clear R and SA bits
				
				ENDM

		
RESTORE_OMR		MACRO

				moveu.w	x:(SP-saved_omr),OMR      ; restore original OMR state
				
				ENDM
				
CALC_DISPATCH	MACRO	OFFREG,TABLEADDR
				; load jump table address in N
				move.l #>>TABLEADDR,n
				; increment N to correct address
				rep OFFREG
				adda #1,n
				; do the jump
				jmp (n)
				
				ENDM
