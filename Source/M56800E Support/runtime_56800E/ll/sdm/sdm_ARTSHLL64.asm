


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
              adda        #<8,SP
              move.w      Y0,X:(SP-1)
;
;   66: 	unsigned long* a = (unsigned long*)&nr; 
;   67: 	unsigned long t, mask; 
;
              adda        #-13,SP,R0
              move.w      R0,X:(SP)
;
;   68: 	unsigned long v = 1; 
;   69:  
;   70:  
;   71:  
;   72: 	//p = (unsigned int*)&x; 
;   73: 	//n = p[0]; 
;   74: 	//n = x; 
;   75:  
;   76: 	 
;
              move.l      #<1,A
              move.l      A10,X:(SP-6)
;
;   77: 	n = n%64;	 
;   78: 	 
;
              move.w      X:(SP-1),B
              move.w      #<63,A
              and.w       B,A
              move.w      A1,X:(SP-1)
;
;   79: 	if ( n >= 32 ) 
;   80: 	{ 
;
              move.w      #<32,A
              cmp.w       X:(SP-1),A
              bhi         <_L16_0	; *+14
              nop         
;
;   81: 		a[1]  = a[0] << (n - 32); 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              move.l      X:(R0),A
              move.w      X:(SP-1),B
              sub.b       #32,B
              asll.l      B,A
              move.l      A10,X:(R1+>2)
;
;   82: 		a[0] = 0; 
;
              moveu.w     X:(SP),R0
              clr.l       X:(R0)
;
;   83: 	} 
;
              bra         <_L16_1	; *+40
;
;   84: 	else if( n > 0 ) 
;   85: 	{ 
;
_L16_0:
              tst.w       X:(SP-1)
              beq         <_L16_1	; *+38
              nop         
;
;   86: 		v = (v<<(32-n)) - 1; 
;
              move.l      X:(SP-6),A
              move.w      #<32,B
              sub.w       X:(SP-1),B
              asll.l      B,A
              sub.l       #1,A
              move.l      A10,X:(SP-6)
;
;   87: 		mask = 0xffffffff - v; 
;
              move.l      X:(SP-6),B
              move.l      #<-1,A
              clr.w       A2
              sub         B,A
              move.l      A10,X:(SP-4)
;
;   88: 		t = (a[0] & mask) >> (32 - n); 
;
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              move.l      X:(SP-4),A
              and.l       B,A
              move.w      #<32,B
              sub.w       X:(SP-1),B
              lsrr.l      B,A
              move.l      A10,X:(SP-2)
;
;   89: 		a[0] = a[0] << n; 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              move.l      X:(R0),A
              move.w      X:(SP-1),B
              asll.l      B,A
              move.l      A10,X:(R1)
;
;   90: 		a[1] = (a[1] << n) + t; 
;   91: 	} 
;   92: 	 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              move.w      X:(SP-1),A
              asll.l      A,B
              move.l      X:(SP-2),A
              add         B,A
              move.l      A10,X:(R1+>2)
;
;   93: 	return nr; 
;   94:  
;
_L16_1:
              move.l      X:(SP-10),B
              move.l      X:(SP-12),A
;
;   95: } 
;
              suba        #<8,SP
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
              adda        #<10,SP
              move.w      Y0,X:(SP-2)
;
;   35: 	unsigned long* a = (unsigned long*)&nr; 
;
              adda        #-15,SP,R0
              move.w      R0,X:(SP)
;
;   36: 	long* b = (long*)&nr; 
;   37: 	unsigned long t, mask; 
;
              adda        #-15,SP,R0
              move.w      R0,X:(SP-1)
;
;   38: 	unsigned long v = 1; 
;   39:  
;   40: 	//n = ((unsigned int*)&x)[0]; 
;   41: 	//n = x; 
;   42: 	 
;
              move.l      #<1,A
              move.l      A10,X:(SP-8)
;
;   43: 	n = n%64;	 
;   44: 	 
;
              move.w      X:(SP-2),B
              move.w      #<63,A
              and.w       B,A
              move.w      A1,X:(SP-2)
;
;   45: 	if ( n >= 32 ) 
;   46: 	{ 
;
              move.w      #<32,A
              cmp.w       X:(SP-2),A
              bhi         <_L11_0	; *+24
              nop         
;
;   47: 		b[0]  = b[1] >> (n - 32); 
;
              moveu.w     X:(SP-1),R1
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP-2),B
              sub.b       #32,B
              asrr.l      B,A
              move.l      A10,X:(R1)
;
;   48: 		b[1] = (b[0] >= 0) ? 0 :0xFFFFFFFF; 
;
              moveu.w     X:(SP-1),R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L11_1	; *+4
              nop         
              move.l      #<0,A
              bra         <_L11_2	; *+3
_L11_1:
              move.l      #<-1,A
              clr.w       A2
_L11_2:
              moveu.w     X:(SP-1),R0
              move.l      A10,X:(R0+>2)
;
;   49: 	} 
;
              bra         <_L11_3	; *+35
;
;   50: 	else if( n > 0 ) 
;   51: 	{ 
;
_L11_0:
              tst.w       X:(SP-2)
              beq         <_L11_3	; *+33
              nop         
;
;   52: 		mask = (v << n) - v; 
;
              move.l      X:(SP-8),B
              move.w      X:(SP-2),A
              asll.l      A,B
              move.l      X:(SP-8),A
              sub         A,B
              move.l      B10,X:(SP-6)
;
;   53: 		t = (a[1] & mask) << (32 - n); 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              move.l      X:(SP-6),A
              and.l       B,A
              move.w      #<32,B
              sub.w       X:(SP-2),B
              asll.l      B,A
              move.l      A10,X:(SP-4)
;
;   54: 		a[0] = (a[0] >> n) + t; 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              move.w      X:(SP-2),A
              lsrr.l      A,B
              move.l      X:(SP-4),A
              add         B,A
              move.l      A10,X:(R1)
;
;   55: 		b[1] = b[1] >> n; 
;   56: 	} 
;   57: 	 
;
              moveu.w     X:(SP-1),R1
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP-2),B
              asrr.l      B,A
              move.l      A10,X:(R1+>2)
;
;   58: 	return nr; 
;   59:  
;
_L11_3:
              move.l      X:(SP-12),B
              move.l      X:(SP-14),A
;
;   60: } 
              suba        #<10,SP
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
              adda        #<8,SP
              move.w      Y0,X:(SP-1)
;
;    6: 	unsigned long* a = (unsigned long*)&nr; 
;    7: 	unsigned long t, mask; 
;
              adda        #-13,SP,R0
              move.w      R0,X:(SP)
;
;    8: 	unsigned long v = 1; 
;    9:  
;   10: 	//n = x; 
;   11: 	 
;
              move.l      #<1,A
              move.l      A10,X:(SP-6)
;
;   12: 	n = n%64;	 
;   13: 	 
;
              move.w      X:(SP-1),B
              move.w      #<63,A
              and.w       B,A
              move.w      A1,X:(SP-1)
;
;   14: 	if ( n >= 32 ) 
;   15: 	{ 
;
              move.w      #<32,A
              cmp.w       X:(SP-1),A
              bhi         <_L6_0	; *+15
              nop         
;
;   16: 		a[0]  = a[1] >> (n - 32); 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP-1),B
              sub.b       #32,B
              lsrr.l      B,A
              move.l      A10,X:(R1)
;
;   17: 		a[1] = 0; 
;
              moveu.w     X:(SP),R0
              clr.l       X:(R0+>2)
;
;   18: 	} 
;
              bra         <_L6_1	; *+35
;
;   19: 	else if( n > 0 ) 
;   20: 	{ 
;
_L6_0:
              tst.w       X:(SP-1)
              beq         <_L6_1	; *+33
              nop         
;
;   21: 		mask = (v << n) - v; 
;
              move.l      X:(SP-6),B
              move.w      X:(SP-1),A
              asll.l      A,B
              move.l      X:(SP-6),A
              sub         A,B
              move.l      B10,X:(SP-4)
;
;   22: 		t = (a[1] & mask) << (32 - n); 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              move.l      X:(SP-4),A
              and.l       B,A
              move.w      #<32,B
              sub.w       X:(SP-1),B
              asll.l      B,A
              move.l      A10,X:(SP-2)
;
;   23: 		a[0] = (a[0] >> n) + t; 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              move.w      X:(SP-1),A
              lsrr.l      A,B
              move.l      X:(SP-2),A
              add         B,A
              move.l      A10,X:(R1)
;
;   24: 		a[1] = a[1] >> n; 
;   25: 	} 
;   26: 	 
;
              moveu.w     X:(SP),R1
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP-1),B
              lsrr.l      B,A
              move.l      A10,X:(R1+>2)
;
;   27: 	return nr; 
;   28:  
;
_L6_1:
              move.l      X:(SP-10),B
              move.l      X:(SP-12),A
;
;   29: } 
              suba        #<8,SP
              rts               
end_FARTSHRULL64:
	
	ENDSEC
	
	
	
