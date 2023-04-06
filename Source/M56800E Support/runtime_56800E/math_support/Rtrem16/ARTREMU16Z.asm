



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;       ARTREMU16Z.asm
;       
;
;       Routines
;       --------
;       16 bit unsigned integer modulus (No REPs used)
;       INPUTS:
;         y0 dividend
;         y1 divisor
;       OUTPUT:
;         y0 <--- REM      (16-bit unsigned remainder)
;         y1               (no changes)
;       Register Used:
;         B     B1 is assigned the value of the remainder
;
;       NOTE:
;         div - this instruction requires 36-bit correctly signed
;               positive dividend, and divisor must be 16-bit signed.
;
;               When bit 15 of divisor is ON, no div's are necessary.
;               Bit 15 of divisor must be checked since it is an
;               unsigned number even when this bit is on. An alternate
;               route is used when bit 15 is 1, (High_bit_present)
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
       global          ARTREMU16Z

       org             p:

 ARTREMU16Z:
 
;;;;;;;;;;;;;;;;; 16-bit Unsigned Divide ;;;;;;;;;;;;;;;;;;;;;
       tst.w           y1              ; Check on high bit, should be zero
                                       ; Required carry bit is cleard too!
       blt             High_bit_present ; If bit 15 on, result is either 1 or 0
 
       lsr16           y0,b            ; Copy dividend to b0 no sign extension

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
       add             y1,b            ; restored remainder, b is negative
                                       ; y1-b
Positive_rem:       
       rtsd                            ; delay return after nxt 3 instr
       move.w          b1,y0           ; move result value into return register
       nop                             ; filler
       nop                             ; filler
       
;;;;;;;;;;;;;;; Quotient result is either be 1 (REM = y0-y1) or 0 (REM = y0)
High_bit_present:
       move.w          y0,b            ; set REM to dividend, y0, for quotient = 0 
       sub             y1,y0           ; REM valid if y0 >= y1 (quotient = 1)
       tcc             y0,b            ; if quotient = 1, REM = y0-y1
       
       rtsd                            ; delay return after nxt 3 instr
       move.w          b1,y0           ; move REM value into return register
       nop                             ; filler
       nop                             ; filler
       
    endsec

    end
