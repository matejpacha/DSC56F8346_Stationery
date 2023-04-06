



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;	rtmpy32.asm
;	
;
; 	Routines
; 	--------
; 	32 bit signed and unsigned multiply (they're the same)
;
;	RSJ 3/23/00	Changed from passing parameter on stack to B
;  
;	LT  5/6/01  Algorithm taken from "DSP56800E Core Reference Manual"
;	            pg 5-33
;	US	11/12/01 Introduced changes from DSPD.
;	RSJ	01/14/02 Backed out changes from DSPD after discussion with DSPP
;	US	01/17/02 Removed sxt.l on result as ABI says we shouldn't need it.
;				 Also there are now 2 separate routine signed and unsigned
;				 multiplication. They both now use the RTSD. 
;----------------------------------------------------------------------
;

	section rtlib
	
	global  ARTMPYS32U              ; signed
	global  ARTMPYU32U              ; unsigned
	org p:


ARTMPYU32U:
	impyuu  A1,B0,Y
	rtsd                            ; return after next 3 instr
	imacuu  A0,B1,Y
	impyuu  A0,B0,A
	add     Y0,A

	nop                             ; should not need this but
	                                ; assembler inserts nop
	                                ; file should be splitted

ARTMPYS32U:
	impysu  A1,B0,Y
	rtsd                            ; return after next 3 instr
	imacus  A0,B1,Y
	impyuu  A0,B0,A
	add     Y0,A

	endsec

	end


