


; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.





; SECTION: the long long code
	SECTION	ll_engine
	
	OPT	CC
	GLOBAL	ARTSHLLL64
	GLOBAL	FARTSHLLL64
	
	GLOBAL	ARTSHRLL64
	GLOBAL	FARTSHRLL64	

	GLOBAL	ARTSHRULL64
	GLOBAL	FARTSHRULL64
	
;===============================================================================
; FUNCTION: ARTSHLLL64
; DESCRIPTION: long long left shift
;
; INPUT: x
; OUTPUT:x = x << 1;
;

ARTSHLLL64:
FARTSHLLL64:
Fmy_shl:
              adda       #<2,SP
              move.l      C10,X:(SP)
              bfclr       #$ffc0,Y0
              cmp.w       #32,Y0
              adda        #-7,SP,R0
              bcs         <_L16_0	; *+10
              nop         
              move.l      X:(R0),A
              add.w       #-32,Y0
              asll.l      Y0,A
              move.l      A10,X:(R0+>2)
              clr.l       X:(R0)
              bra         <_L16_1	; *+21
_L16_0:
              move.w      #<32,Y1
              sub         Y0,Y1
              move.l      #<1,A
              asll.l      Y1,A
              move.l      #<-1,B
              add.l       #-1,A
              clr.w       B2
              sub         A,B
              move.l      X:(R0),C
              and.l       C,B
              move.l      X:(R0+>2),A
              lsrr.l      Y1,B
              asll.l      Y0,A
              asll.l      Y0,C
              add         A,B
              move.l      B10,X:(R0+>2)
              move.l      C10,X:(R0)
_L16_1:
              move.l      X:(SP-4),B
              move.l      X:(SP-6),A
              move.l      X:(SP)-,C
              rts         
end_FARTSHLLL64:



;===============================================================================
; FUNCTION: ARTSHRLL64
; DESCRIPTION: long long right shift
;
; INPUT: x
; OUTPUT:x = x >> 1;
;


ARTSHRLL64:
FARTSHRLL64:
              bfclr       #$ffc0,Y0
              cmp.w       #32,Y0
              adda        #-5,SP,R0
              bcs         <_L11_0	; *+17
              move.l      X:(R0+>2),A
              add.w       #-32,Y0
              asrr.l      Y0,A
              tst.l       A
              move.l      A10,X:(R0)
              blt         <_L11_1	; *+4
              nop         
              move.l      #<0,A
              bra         <_L11_2	; *+3
_L11_1:
              move.l      #<-1,A
              clr.w       A2
_L11_2:
              move.l      A10,X:(R0+>2)
              bra         <_L11_3	; *+20
_L11_0:
              move.l      #<1,B
              asll.l      Y0,B
              move.w      #<32,Y1
              move.l      X:(R0+>2),A
              add.l       #-1,B
              and.l       A,B
              sub         Y0,Y1
              move.l      X:(R0),A
              asll.l      Y1,B
              lsrr.l      Y0,A
              add         B,A
              move.l      A10,X:(R0)
              move.l      X:(R0+>2),A
              asrr.l      Y0,A
              move.l      A10,X:(R0+>2)
_L11_3:
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
              rts         
end_FARTSHRLL64:



;===============================================================================
; FUNCTION: ARTSHRULL64
; DESCRIPTION: unsigned long long right shift
;
; INPUT: x
; OUTPUT:x = x >> 1;
;

ARTSHRULL64:
FARTSHRULL64:
              adda        #<2,SP
              move.l      C10,X:(SP)
              bfclr       #$ffc0,Y0
              cmp.w       #32,Y0
              adda        #-7,SP,R0
              bcs         <_L6_0	; *+10
              move.l      X:(R0+>2),A
              add.w       #-32,Y0
              lsrr.l      Y0,A
              move.l      A10,X:(R0)
              clr.l       X:(R0+>2)
              bra         <_L6_1	; *+18
_L6_0:
              move.l      #<1,B
              asll.l      Y0,B
              move.w      #<32,Y1
              move.l      X:(R0+>2),C
              add.l       #-1,B
              and.l       C,B
              sub         Y0,Y1
              move.l      X:(R0),A
              lsrr.l      Y0,C
              asll.l      Y1,B
              lsrr.l      Y0,A
              add         B,A
              move.l      C10,X:(R0+>2)
              move.l      A10,X:(R0)
_L6_1:
              move.l      X:(SP-4),B
              move.l      X:(SP-6),A
              move.l      X:(SP)-,C
              rts         

end_FARTSHRULL64:
	
	ENDSEC
	
	
	
