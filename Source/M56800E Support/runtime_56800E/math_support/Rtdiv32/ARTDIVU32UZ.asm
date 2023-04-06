


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
;   LT  5/18/01 Changed to Hawk II instructions.
;               Hawk II rol.l can rotate 32-bit, so no need to save
;				dividend (which is in register A) to Y and perform 
;				16-bit rotate twice. 
;   JG  EF  8/02/01 Updated to Hawk II instruction set.
;	DB 09/20/05 Allows ARTDIVU32UZ_2 to be defined as this
;				runtime call. 	
;----------------------------------------------------------------------
 
 	section	rtlib
       include	"asmdef.h"

    global  ARTDIVU32UZ

    org p:

    ; Defining F__CW_NOT_USING_FAST_DIV_RT (in prefix file)will allow either
    ; ARTDIVU32UZ_2 or ARTDIVU32UZ to call this function, so that
    ; this function is called regardless of the optimize for speed
    ; setting.
    ;
	IF @DEF(F__CW_NOT_USING_FAST_DIV_RT)
	global ARTDIVU32UZ_2
ARTDIVU32UZ_2:
	ENDIF
    
ARTDIVU32UZ:
        adda    #2,sp
        move.w  x0,x:(sp)       ; save reg
        clr.w   x0              ; clear reg - stores last valid REM[MSP] 
        clr.w   y1              ; clear pre-shift count
        tst.l   a               ; test if MSB of dividend is on
        blt     SkipPreShift    ; branch if true, otherwise do pre-shift
        clb     A,y1            ; find first non-zero
        inc.w   y1              ; correct the pre-shift count
        asll.l  y1,a            ; do pre-shift on dividend (numerator)
        
SkipPreShift:
        move.w  #32,y0          ; begin with possible 32 shifts
        sub     y1,y0           ; discard pre-shift from max
        moveu.w y0,lc           ; define loop count
        
        tfr     b,y             ; copy divisor (denominator) 
        clr     b               ; clear register for resulting quotient
        tst     b               ; clear the carry bit       
        rol.l   a
        rol.l   b
        doslc   endloop
        sub     y,b             ; If carry is clear, sub was OK.
        sxt.l 	b				; wb1-39012
        bcc     nottoobig       ; otherwise, restore B
        add     y,b
nottoobig:
        move.w  b1,x0           ; store REM[MSP] - use last value
        rol.l   a
        rol.l   b
        bfchg   #1,a0           ; reverse cc bit shifted to bit 0 of A
endloop:

        sxt.l   a               ; correct sign extension on result
        ror.l   b               ; reverse last rotation on remainder
        move.w  x0,b1           ; correct value in REM[MSP]
        move.w  x:(sp),x0       ; restore reg
        suba    #2,sp

	rts
    
    endsec
 
    end
