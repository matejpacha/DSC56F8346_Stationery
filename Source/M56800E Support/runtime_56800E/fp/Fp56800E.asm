



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




;RSJ    Cashes crash UseRep	EQU	1
	
;===============================================================================
; GLOBAL DATA: fpe_state -- one word of state per process, indicating the
;	prevailing rouding mode and holding the sticky exception flags.
;
	SECTION	fp_state GLOBAL
	ORG	X:
FPE_state:
	DC	$0000
	ENDSEC

