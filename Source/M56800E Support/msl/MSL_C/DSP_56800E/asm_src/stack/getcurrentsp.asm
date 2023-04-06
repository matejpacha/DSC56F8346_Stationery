

;----------------------------------------------------------------------
; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:02:38 $
; $Revision: 1.8 $
;----------------------------------------------------------------------


; This is what it looks like in stdmaloc.c, if ASM_IS_IMPLEMENTED

;short *GetCurrentSP()        /* Defined at the end to prevent inlining */
;{
;  asm ("move sp,r2");
;}

	section rtlib
	
	org		p:
	global	FGetCurrentSP
FGetCurrentSP:
		adda #-2,sp,r2	; the sp we want is as it was before the call to this routine
	rts

	endsec
