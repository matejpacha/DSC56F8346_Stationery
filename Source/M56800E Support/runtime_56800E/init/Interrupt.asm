



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




; 	Routines
; 	--------
;
;		These are the interrupt vectors for the DSP56800E
; 

	include	"asmdef.h"

	section		rtlib
	org	p:

	SUBROUTINE "IntRoutine",IntRoutine,IntRoutineEND-IntRoutine
IntRoutine:
	nop
	rti
IntRoutineEND:

	endsec
	
	section interrupt
	global	FIntVec

FIntVec:

	jmp FSTART_						;	($00) 
	jmp IntRoutine					;	($02)
	jmp IntRoutine					;	($04)
	jmp IntRoutine					;	($06)
	jmp IntRoutine					;	($08)
	jmp IntRoutine					;   ($0A)
	jmp IntRoutine					;	($0C)
	jmp IntRoutine					;	($0E)
	jmp IntRoutine					;	($10)
	jmp IntRoutine					;	($12)
	jmp IntRoutine					;	($14)
	jmp IntRoutine					;	($16)
	jmp IntRoutine					;	($18)
	jmp IntRoutine					;	($1A)
	jmp IntRoutine					;	($1C)
	jmp IntRoutine					;	($1E)
	jmp IntRoutine					;	($20)
	jmp IntRoutine					;	($22)
	jmp IntRoutine					;	($24)
	jmp IntRoutine					;	($26)
	jmp IntRoutine					;	($28)
	jmp IntRoutine					;	($2A)
	jmp IntRoutine					;	($2C)
	jmp IntRoutine					;	($2E)
	jmp IntRoutine					;	($30)
	jmp IntRoutine					;	($32)
	jmp IntRoutine					;	($34)
	jmp IntRoutine					;	($36)
	jmp IntRoutine					;	($38)
	jmp IntRoutine					;	($3A)
	jmp IntRoutine					;	($3C)
	jmp IntRoutine					;	($3E)
	jmp IntRoutine					;	($40)
	jmp IntRoutine					;	($42)
	jmp IntRoutine					;	($44)
	jmp IntRoutine					;	($46)
	jmp IntRoutine					;	($48)
	jmp IntRoutine					;	($4a)
	jmp IntRoutine					;	($4c)
	jmp IntRoutine					;	($4e)
	jmp IntRoutine					;	($50)
	jmp IntRoutine					;	($52)
	jmp IntRoutine					;	($54)
	jmp IntRoutine					;	($56)
	jmp IntRoutine					;	($58)
	jmp IntRoutine					;	($5a)
	jmp IntRoutine					;	($5c)
	jmp IntRoutine					;	($5e)
	jmp IntRoutine					;	($60)
	jmp IntRoutine					;	($62)
	jmp IntRoutine					;	($64)
	jmp IntRoutine					;	($66)
	jmp IntRoutine					;	($68)
	jmp IntRoutine					;	($6a)
	jmp IntRoutine					;	($6c)
	jmp IntRoutine					;	($6e)
	jmp IntRoutine					;	($70)
	jmp IntRoutine					;	($72)
	jmp IntRoutine					;	($74)
	jmp IntRoutine					;	($76)
	jmp IntRoutine					;	($78)
	jmp IntRoutine					;	($7a)
	jmp IntRoutine					;	($7c)
	jmp IntRoutine					;	($7e)
	jmp IntRoutine					;	($80)

	endsec	



	end






