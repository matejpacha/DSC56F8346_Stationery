



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;       ARTDIVU8UZ.asm
;       

;       Routines
;       --------
;       8 bit unsigned integer divide (No REPs used)
;       INPUTS:
;         y0 dividend
;         y1 divisor
;       OUTPUT:
;         y0 <--- y0/y1    (8-bit signed result)
;         y1               (upper byte forced to zero)
;       Register Used:
;         B     assigned the value of the dividend
;
;       NOTE:
;         div - This instruction requires 36-bit correctly signed
;               positive dividend, and divisor must be 16-bit signed.
;               The upper bytes of both dividend and divisor are
;               forced to zero, to correctly signed extend as a positive
;               value. This is required when one of the values is loaded
;               as a signed negative byte, but still the unsigned divide
;               is selected.
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
;                       bypass upper bytes, (save 8cycles)
;----------------------------------------------------------------------
;
       section         rtlib
       global          ARTDIVU8UZ

       org             p:
        
 ARTDIVU8UZ:
                  
;;;;;;;;;;;;;;;;; 8-bit Unsigned Divide ;;;;;;;;;;;;;;;;;;;;;
       zxt.b           y0              ; dividend upper byte forced to zero 
       zxt.b           y1              ; divisor  upper byte forced to zero 
                                       ; correct sign extension on upper bytes
       lsr16           y0,b            ; Copy dividend to b0 with zero extension
 
       asl             b               ; Required for INTEGER Division 
                                       ; Required carry bit is cleard too!
       
       asll.l          #8,b            ; bypass zero portion
 
;;;;;;;;;;;;;;;; 4-bit division ;;;;;;;;;;;;;;;; 
       div             y1,b            ; form quotient in b0                     
       div             y1,b                                 
       div             y1,b
       div             y1,b                                 
;;;;;;;;;;;;;;;; 2-bit division ;;;;;;;;;;;;;;;; 
       div             y1,b            ; form quot in b0, 5th division                     
       div             y1,b            ; form quot in b0, 6th division                     

Quotient_pos_always:       
       rtsd                            ; return to caller after 3 instr
       div             y1,b            ; form quot in b0, 7th division                     
       div             y1,b            ; form quot in b0, 8th division                     
       move.w          b0,y0           ; move return value into return register

    endsec

    end
