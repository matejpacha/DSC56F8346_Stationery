



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.

;----------------------------------------------------------------------
;	rtrem32.asm
;	
;
; 	Routines
; 	--------
; 
;	BETH 4/14/00 Changed calling sequence from 56800 to Hawk II.
;	DB 09/20/05 Allows ARTREMU32Z_2 to be defined as this
;				runtime call. 
;----------------------------------------------------------------------
;
 
	section		rtlib
    global  ARTREMU32Z 
    org p:
 
    include "asmdef.h"

    ; Defining F__CW_NOT_USING_FAST_DIV_RT (in prefix file)will allow either
    ; ARTREMU32Z_2 or ARTREMU32Z to call this function, so that
    ; this function is called regardless of the optimize for speed
    ; setting.
    ;
	IF @DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global ARTREMU32Z_2
ARTREMU32Z_2:
	ENDIF
ARTREMU32Z:
 
    jsr     ARTDIVU32UZ    ; call the unsigned version
    tfr     B,A
    rts

    endsec
 
    end
