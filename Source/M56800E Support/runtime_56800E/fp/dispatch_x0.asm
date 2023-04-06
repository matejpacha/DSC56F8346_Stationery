



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




; SECTION: the floating point code
	SECTION	fp_engine
	OPT	CC
	GLOBAL	ARTdispatch_x0
	

; used in floating point library jump tables
	
ARTdispatch_x0:
	; TRICK: Avoid mysterious "add x0,x:(sp-1)", which
	; seems to malfunction.  It trashes x0 anyway (!)
	; and fools the debugger when stepping.
	add.w	x:(sp-1),x0
	move.w	x0,x:(sp-1)
	rts

	
	ENDSEC