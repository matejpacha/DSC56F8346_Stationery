



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;       ARTREMS16Z.asm
;       
;
;       Routines
;       --------
;       16 bit signed integer modulus (No REPs used)
;       INPUTS:
;         y0 dividend
;         y1 divisor
;       OUTPUT:
;         y0 <--- REM      (16-bit signed remainder)
;         y1               (changes)
;       Register Used:
;         B     B1 is assigned the value of the remainder
;
;       NOTE:
;         div - this instruction requires 36-bit correctly signed
;               positive dividend, and divisor must be 16-bit signed
;       
;
;  History:
;    2/2001     ef      conversion from V1 to V2 and optimization
;                       detection of divided by -1 is removed
;    2/2002     ef      remove divisor as 1
;                       unroll rep #8 into 8 DIV's
;                       use signed information on Y0
;                       make use on delay instruction RTSD
;                       avoid NOP debug padding by rearranging DIVs
;----------------------------------------------------------------------
;
       section         rtlib
       global          ARTREMS16Z

       org             p:
        
 ARTREMS16Z:
                  
;;;;;;;;;;;;;;;;; 16-bit Signed Divide ;;;;;;;;;;;;;;;;;;;;;
       asr16           y0,b            ; Copy dividend to b0 with sign extension
 
       abs             b               ; make dividend positive
       tst             b               ; Required carry bit is cleard! 
                                       
       
;;;;;;;;;;;;;;;; 4-bit division ;;;;;;;;;;;;;;;; 
       div             y1,b            ; form quotient in b0
       div             y1,b
       div             y1,b
       div             y1,b
;;;;;;;;;;;;;;;; 4-bit division ;;;;;;;;;;;;;;;; 
       div             y1,b            ; form quotient in b0                     
       div             y1,b                                 
       div             y1,b
       div             y1,b                                 
;;;;;;;;;;;;;;;; 4-bit division ;;;;;;;;;;;;;;;; 
       div             y1,b            ; form quotient in b0
       div             y1,b
       div             y1,b
       div             y1,b
;;;;;;;;;;;;;;;; 4-bit division ;;;;;;;;;;;;;;;; 
       div             y1,b            ; form quotient in b0
       div             y1,b
       div             y1,b
       div             y1,b
 
;;;;;;;;;;;;;;;; check sign of quotient and adjust accordingly   
       tst             b               ; Result sign in N bit of SR
       bge             Positive_rem    ; if remainder is positive, ok
       
Fix_required_remainder:
       abs             y1              ; remainder is y1-b
       add             y1,b            ; restored remainder, b is negative
       
Positive_rem:
       tst.w           y0              ; REM sign needs to be like dividend
       bge             Dividend_pos    ; if dividend positive, done
       clr.w           b0              ; prevent unwanted carry from quotient
       neg             b               ; quot negative, change the sign 
       
Dividend_pos:
       rtsd                            ; delay return after nxt 3 instr
       move.w          b1,y0           ; move REM value into return register
       nop                             ; filler
       nop                             ; filler

    endsec

    end
