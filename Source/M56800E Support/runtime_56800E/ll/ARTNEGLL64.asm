


; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.





; SECTION: the long long code
	SECTION	ll_engine
	
	OPT	CC
	GLOBAL	ARTNEGLL64
	GLOBAL	FARTNEGLL64
	
	
;===============================================================================
; FUNCTION: ARTNEGLL64
; DESCRIPTION: long long neg.
;
; INPUT: a = x
; OUTPUT: a = -x
;

ARTNEGLL64:
FARTNEGLL64:
              adda       #<2,SP
;
;    7:     ca = (unsigned long *)(&a); 
;    8:  
;
              adda        #-7,SP,R0
              move.w      R0,X:(SP)
;
;    9:     *(ca+1) = ~(*(ca+1)); 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              adda       #<2,R0
              move.l      X:(R0),A
              neg         A
              dec.l       A
              move.l      A10,X:(R1+>2)
;
;   10:     *(ca) = ~(*(ca)); 
;   11:  
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              move.l      X:(R0),A
              neg         A
              dec.l       A
              move.l      A10,X:(R1)
;
;   12:     a++; 
;   13:  
;
              adda       #<8,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>1,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTADDLL64
              suba        #<8,SP
              move.l      B10,X:(SP-4)
              move.l      A10,X:(SP-6)
;
;   14:     return a; 
;
              move.l      X:(SP-4),B
              move.l      X:(SP-6),A
              suba        #<2,SP
              rts   
end_FARTNEGLL64:

	
	ENDSEC
	
	
	
