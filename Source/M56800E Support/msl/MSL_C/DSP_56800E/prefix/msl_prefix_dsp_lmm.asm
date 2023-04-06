; MSL
; Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
;
; $Date: 2005/12/09 02:05:12 $
; $Revision: 1.5 $
;


; Asm prefix file for 56800E MSL assembly routines.
; Defines F_cw_large_data_memory_model symbol for conditional
; assembly.
; 
; Define this file as the prefix file when building the
; large data memory model version of the MSL. This is
; done already for building 'MSL C M56800E LMM.lib'.

	IF !@DEF(F__CW_M56800E_LMM)
F__CW_M56800E_LMM equ 1
	ENDIF