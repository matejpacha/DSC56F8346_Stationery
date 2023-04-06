



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.


;----------------------------------------------------------------------
;
;       ARTDIVS8UZ.asm
;       
;
;       Routines
;       --------
;       8 bit signed integer divide (No REPs used)
;       INPUTS:
;         y0 dividend
;         y1 divisor
;       OUTPUT:
;         y0 <--- y0/y1    (8-bit signed result)
;         y1               (no changes)
;       Register Used:
;         B     assigned the value of the dividend
;
;       NOTE:
;         div - This instruction requires 36-bit correctly signed
;               positive dividend, and divisor must be 16-bit signed.
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
;    6/2002     imd     check for divide-by-zero case (return 0x7FFF)
;----------------------------------------------------------------------
;
       section         rtlib
       global          ARTDIVS8UZ

       org             p:
        
 ARTDIVS8UZ:
;;;;;;;;;;;;;;;;; test for divide-by-zero ;;;;;;;;;;;;;;;;;;;;;
       tst.w           y1
       beq             divide_by_zero

;;;;;;;;;;;;;;;;; 8-bit Signed Divide ;;;;;;;;;;;;;;;;;;;;;
       asr16           y0,b            ; Copy dividend to b0 with sign extension
 
       abs             b               ; make dividend positive
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
                           
;;;;;;;;;;;;;;;; check sign of result ;;;;;;;;;;;;;;;; 
       eor.w           y1,y0           ; Result sign in N bit of SR
       bge             Quotient_pos    ; if quotient is positive, done 
 
Quotient_neg:
       div             y1,b            ; form quot in b0, 7th division
       rtsd                            ; return to caller after 3 instr
       div             y1,b            ; form quot in b0, 8th division                     
       neg             b               ; quot negative, change the sign 
       move.w          b0,y0           ; move return value into return register
 
Quotient_pos:
       rtsd                            ; return to caller after 3 instr
       div             y1,b            ; form quot in b0, 7th division                     
       div             y1,b            ; form quot in b0, 8th division                     
       move.w          b0,y0           ; move return value into return register

divide_by_zero:
       move.w          #$7fff,y0       ; set y0 to int divide-by-zero value
       rts

    endsec

    end
