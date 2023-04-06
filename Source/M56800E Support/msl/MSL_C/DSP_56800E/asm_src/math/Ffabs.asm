

;* MSL
;* Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;*
;* $Date: 2005/12/09 02:02:24 $
;* $Revision: 1.6 $

;*	math.asm
;*	
;*	Routines
;*	--------
;*		fabs
;*
;*
;*

	section rtlib
	org p:

	include "asmdef.h"
	
	global	Ffabs

Ffabs:
	bfclr    #$8000,A1
	rts

	endsec