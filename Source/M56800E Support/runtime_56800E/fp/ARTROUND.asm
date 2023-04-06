



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




; SECTION: the floating point code
	SECTION	fp_engine
	OPT	CC
	GLOBAL	FARTROUND
	GLOBAL	FARTGETFPSCR
	GLOBAL	FARTSETFPSCR
	
	include "Fp56800E.h"


;===============================================================================
; FUNCTION: FARTROUND, ARTSETFPSCR
; DESCRIPTION: Set the rounding mode, according to the code in x; set the fpscr.
; INPUT: y0 = 2-bit code.
; OUTPUT: y0
;
FARTROUND:
	move.w	x:FPE_state,y1	; jrusso LMM
	bfclr	#$03,y1			; remove old mode
	bfclr	#$fffc,y0		; strip extraneous bits
	or.w	y1,y0
FARTSETFPSCR:
	move.w	y0,x:FPE_state 	; jrusso LMM
	rts
	

;===============================================================================
; FUNCTION: FARTGETFPSCR
; DESCRIPTION: Return the fpscr in y0.
; INPUT: none
; OUTPUT: y0 = fpscr
;
FARTGETFPSCR:
	move.w	x:FPE_state,y0 	; jrusso LMM
	rts
	

	ENDSEC