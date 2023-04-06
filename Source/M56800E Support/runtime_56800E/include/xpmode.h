



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.



;----------------------------------------------------------------------
;
;	xpmode.h

; 	Routines
; 	--------
; 	macros and defines for entering and exiting data memory execution
;  
;----------------------------------------------------------------------
;

DATA_19_PROLOGUE	MACRO	xmem_target
	bfset	#$0300,sr	; disable interrupts
	nop					; wait for interrupts to be disabled
	nop
	nop
	nop
	nop
	bfset	#$0080,omr	; enable data mem instr fetches
	nop					; wait for mode to switch
	nop
	jmp		>xmem_target
	nop
	nop
	nop
	org	p:,x:
	ENTRXP
xmem_target
	bfclr	#$0300,sr	; enable interrupts
	nop					; wait for interrupts to be enabled
	nop
	nop
	nop
	nop
	ENDM

DATA_19_EPILOGUE	MACRO	pmem_target
	bfset	#$0300,sr	; disable interrupts
	nop					; wait for interrupts to be disabled
	nop
	nop
	nop
	nop
	bfclr	#$0080,omr	; enable program mem instr fetches
	nop					; wait for mode to switch
	nop
	jmp		>pmem_target
	nop
	nop
	nop
	org	p:
	EXITXP
pmem_target
	bfclr	#$0300,sr	; enable interrupts
	nop					; wait for interrupts to be enabled
	nop
	nop
	nop
	nop
	ENDM

DATA_21_PROLOGUE	MACRO	xmem_target
	bfset	#$0300,sr	; disable interrupts
	nop					; wait for interrupts to be disabled
	nop
	nop
	nop
	nop
	bfset	#$0080,omr	; enable data mem instr fetches
	nop					; wait for mode to switch
	jmp		>>xmem_target
	nop
	nop
	nop
	org	p:,x:
	ENTRXP
xmem_target
	bfclr	#$0300,sr	; enable interrupts
	nop					; wait for interrupts to be enabled
	nop
	nop
	nop
	nop
	ENDM

DATA_21_EPILOGUE	MACRO	pmem_target
	bfset	#$0300,sr	; disable interrupts
	nop					; wait for interrupts to be disabled
	nop
	nop
	nop
	nop
	bfclr	#$0080,omr	; enable program mem instr fetches
	nop					; wait for mode to switch
	jmp		>>pmem_target
	nop
	nop
	nop
	org	p:
	EXITXP
pmem_target
	bfclr	#$0300,sr	; enable interrupts
	nop					; wait for interrupts to be enabled
	nop
	nop
	nop
	nop
	ENDM