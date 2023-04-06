



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;	rtdiv32.asm
;	
;
; 	Routines
; 	--------
; 	32 bit signed and unsigned integer divide
;
;	RSJ 3/17/00 Changed calling sequence from 56800 to Hawk II.
;	US 10/14/00 Removed uses of C. This is because the C and D
;				registers are expected (by the caller) to be 
;				preserved across this call.
;	US 01/17/02	Added sign extensions on input accumulators for
;				correct operation of the ABS instructions.
;	JR 02/06/04 Allows ARTDIVS32UZ_2 to be defined as the this
;				runtime call. 		
;  
;----------------------------------------------------------------------
 
	section	rtlib
	include	"asmdef.h"

    global  ARTDIVS32UZ

    org p:
    
    ; Defining F__CW_NOT_USING_FAST_DIV_RT (in prefix file)will allow either
    ; ARTDIVS32UZ_2 or ARTDIVS32UZ to call this function, so that
    ; this function is called regardless of the optimize for speed
    ; setting.
    ;
	IF @DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global ARTDIVS32UZ_2
ARTDIVS32UZ_2:
	ENDIF
	
ARTDIVS32UZ:
	
	adda	#2,sp
    sxt.l	B
    sxt.l	A
	move.w	b1,y1			; save the sign bit in a temp
	abs		B
	eor.w	a,y1			; get result sign
	move.w	y1,x:(sp)		; save it in on the stack					;US - use stack insted of C
	abs		A				; dividend

	jsr		ARTDIVU32UZ		; call the unsigned version
	
	tst.w	x:(sp)			; Fix the result  --> RSJ  Change MR0 to C1
	bge		Done
	neg		A
Done:
	suba	#2,sp
    rts
    
    endsec
 
    end
