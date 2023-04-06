



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.






	section		rtlib

	GLOBAL Fexit_halt
	org	p:

	SUBROUTINE "Fexit_halt",Fexit_halt,Fexit_haltEND-Fexit_halt

Fexit_halt:
	move.w	#0,r2
	jsr	    Ffflush				; flush file IO
	jsr  	Ffflush_console 	; flush console IO	
	jsr     Fexit_hsst_hostio   ; close hsst-hostio channel, if hsst-hostio used	
	debughlt
	rts	
Fexit_haltEND:

	endsec
