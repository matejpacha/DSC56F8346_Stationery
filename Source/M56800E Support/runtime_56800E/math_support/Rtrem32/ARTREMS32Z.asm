



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;	rtrem32.asm
;	
;
; 	Routines
; 	--------
; 
;	RSJ 3/17/00 Changed calling convetions from Hawk to Hawk2
;	US 10/14/00 Removed uses of C.
;	US 01/17/02	Added sign extensions on input accumulators for
;				correct operation of the ABS instructions.			
;	DB 09/20/05 Allows ARTREMS32Z_2 to be defined as this
;				runtime call. 
;  
;----------------------------------------------------------------------
;
 
	section		rtlib
    global  ARTREMS32Z
    org p:
 
    include "asmdef.h"


    ; Defining F__CW_NOT_USING_FAST_DIV_RT (in prefix file)will allow either
    ; ARTREMS32Z_2 or ARTREMS32Z to call this function, so that
    ; this function is called regardless of the optimize for speed
    ; setting.
    ;
	IF @DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global ARTREMS32Z_2
ARTREMS32Z_2:
	ENDIF
ARTREMS32Z: 
	adda	#2,sp
    sxt.l	A
    sxt.l	B
    move.w  a1,x:(sp)        ; save dividend sign in mr1
 
    abs     A            ; dividend
    abs     B
 
    jsr     ARTDIVU32UZ    ; call the unsigned version
        
	tfr		B,A
    tst.w   x:(sp)          ; Fix the result
    bge     Done
    neg		A
Done:   
	suba	#2,sp
    rts
 
    endsec
 
    end
