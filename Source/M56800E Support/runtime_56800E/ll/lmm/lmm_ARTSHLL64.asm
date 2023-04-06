


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
               adda        #<10,SP
              move.w      Y0,X:(SP)
;
;   66: 	unsigned long* a = (unsigned long*)&nr; 
;   67: 	unsigned long t, mask; 
;
              adda        #-15,SP,R0
              move.l      R0,X:(SP-2)
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
              move.l      A10,X:(SP-8)
;
;   77: 	n = n%64;	 
;   78: 	 
;
              move.w      X:(SP),B
              move.w      #<63,A
              and.w       B,A
              move.w      A1,X:(SP)
;
;   79: 	if ( n >= 32 ) 
;   80: 	{ 
;
              move.w      #<32,A
              cmp.w       X:(SP),A
              bhi         <_L16_0	; *+14
              nop         
;
;   81: 		a[1]  = a[0] << (n - 32); 
;
              move.l      X:(SP-2),R1
              move.l      X:(SP-2),R0
              move.l      X:(R0),A
              move.w      X:(SP),B
              sub.b       #32,B
              asll.l      B,A
              move.l      A10,X:(R1+>2)
;
;   82: 		a[0] = 0; 
;
              move.l      X:(SP-2),R0
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
              tst.w       X:(SP)
              beq         <_L16_1	; *+38
              nop         
;
;   86: 		v = (v<<(32-n)) - 1; 
;
              move.l      X:(SP-8),A
              move.w      #<32,B
              sub.w       X:(SP),B
              asll.l      B,A
              sub.l       #1,A
              move.l      A10,X:(SP-8)
;
;   87: 		mask = 0xffffffff - v; 
;
              move.l      X:(SP-8),B
              move.l      #<-1,A
              clr.w       A2
              sub         B,A
              move.l      A10,X:(SP-6)
;
;   88: 		t = (a[0] & mask) >> (32 - n); 
;
              move.l      X:(SP-2),R0
              move.l      X:(R0),B
              move.l      X:(SP-6),A
              and.l       B,A
              move.w      #<32,B
              sub.w       X:(SP),B
              lsrr.l      B,A
              move.l      A10,X:(SP-4)
;
;   89: 		a[0] = a[0] << n; 
;
              move.l      X:(SP-2),R1
              move.l      X:(SP-2),R0
              move.l      X:(R0),A
              move.w      X:(SP),B
              asll.l      B,A
              move.l      A10,X:(R1)
;
;   90: 		a[1] = (a[1] << n) + t; 
;   91: 	} 
;   92: 	 
;
              move.l      X:(SP-2),R1
              move.l      X:(SP-2),R0
              adda        #<2,R0
              move.l      X:(R0),B
              move.w      X:(SP),A
              asll.l      A,B
              move.l      X:(SP-4),A
              add         B,A
              move.l      A10,X:(R1+>2)
;
;   93: 	return nr; 
;   94:  
;
_L16_1:
              move.l      X:(SP-12),B
              move.l      X:(SP-14),A
;
;   95: } 
;
              suba        #<10,SP
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
              adda        #<12,SP
              move.w      Y0,X:(SP)
;
;   35: 	unsigned long* a = (unsigned long*)&nr; 
;
              adda        #-17,SP,R0
              move.l      R0,X:(SP-2)
;
;   36: 	long* b = (long*)&nr; 
;   37: 	unsigned long t, mask; 
;
              adda        #-17,SP,R0
              move.l      R0,X:(SP-4)
;
;   38: 	unsigned long v = 1; 
;   39:  
;   40: 	//n = ((unsigned int*)&x)[0]; 
;   41: 	//n = x; 
;   42: 	 
;
              move.l      #<1,A
              move.l      A10,X:(SP-10)
;
;   43: 	n = n%64;	 
;   44: 	 
;
              move.w      X:(SP),B
              move.w      #<63,A
              and.w       B,A
              move.w      A1,X:(SP)
;
;   45: 	if ( n >= 32 ) 
;   46: 	{ 
;
              move.w      #<32,A
              cmp.w       X:(SP),A
              bhi         <_L11_0	; *+24
              nop         
;
;   47: 		b[0]  = b[1] >> (n - 32); 
;
              move.l      X:(SP-4),R1
              move.l      X:(SP-4),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP),B
              sub.b       #32,B
              asrr.l      B,A
              move.l      A10,X:(R1)
;
;   48: 		b[1] = (b[0] >= 0) ? 0 :0xFFFFFFFF; 
;
              move.l      X:(SP-4),R0
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
              move.l      X:(SP-4),R0
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
              tst.w       X:(SP)
              beq         <_L11_3	; *+33
              nop         
;
;   52: 		mask = (v << n) - v; 
;
              move.l      X:(SP-10),B
              move.w      X:(SP),A
              asll.l      A,B
              move.l      X:(SP-10),A
              sub         A,B
              move.l      B10,X:(SP-8)
;
;   53: 		t = (a[1] & mask) << (32 - n); 
;
              move.l      X:(SP-2),R0
              adda        #<2,R0
              move.l      X:(R0),B
              move.l      X:(SP-8),A
              and.l       B,A
              move.w      #<32,B
              sub.w       X:(SP),B
              asll.l      B,A
              move.l      A10,X:(SP-6)
;
;   54: 		a[0] = (a[0] >> n) + t; 
;
              move.l      X:(SP-2),R1
              move.l      X:(SP-2),R0
              move.l      X:(R0),B
              move.w      X:(SP),A
              lsrr.l      A,B
              move.l      X:(SP-6),A
              add         B,A
              move.l      A10,X:(R1)
;
;   55: 		b[1] = b[1] >> n; 
;   56: 	} 
;   57: 	 
;
              move.l      X:(SP-4),R1
              move.l      X:(SP-4),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP),B
              asrr.l      B,A
              move.l      A10,X:(R1+>2)
;
;   58: 	return nr; 
;   59:  
;
_L11_3:
              move.l      X:(SP-14),B
              move.l      X:(SP-$10),A
;
;   60: } 
              suba        #<12,SP
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
              adda        #<10,SP
              move.w      Y0,X:(SP)
;
;    6: 	unsigned long* a = (unsigned long*)&nr; 
;    7: 	unsigned long t, mask; 
;
              adda        #-15,SP,R0
              move.l      R0,X:(SP-2)
;
;    8: 	unsigned long v = 1; 
;    9:  
;   10: 	//n = x; 
;   11: 	 
;
              move.l      #<1,A
              move.l      A10,X:(SP-8)
;
;   12: 	n = n%64;	 
;   13: 	 
;
              move.w      X:(SP),B
              move.w      #<63,A
              and.w       B,A
              move.w      A1,X:(SP)
;
;   14: 	if ( n >= 32 ) 
;   15: 	{ 
;
              move.w      #<32,A
              cmp.w       X:(SP),A
              bhi         <_L6_0	; *+15
              nop         
;
;   16: 		a[0]  = a[1] >> (n - 32); 
;
              move.l      X:(SP-2),R1
              move.l      X:(SP-2),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP),B
              sub.b       #32,B
              lsrr.l      B,A
              move.l      A10,X:(R1)
;
;   17: 		a[1] = 0; 
;
              move.l      X:(SP-2),R0
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
              tst.w       X:(SP)
              beq         <_L6_1	; *+33
              nop         
;
;   21: 		mask = (v << n) - v; 
;
              move.l      X:(SP-8),B
              move.w      X:(SP),A
              asll.l      A,B
              move.l      X:(SP-8),A
              sub         A,B
              move.l      B10,X:(SP-6)
;
;   22: 		t = (a[1] & mask) << (32 - n); 
;
              move.l      X:(SP-2),R0
              adda        #<2,R0
              move.l      X:(R0),B
              move.l      X:(SP-6),A
              and.l       B,A
              move.w      #<32,B
              sub.w       X:(SP),B
              asll.l      B,A
              move.l      A10,X:(SP-4)
;
;   23: 		a[0] = (a[0] >> n) + t; 
;
              move.l      X:(SP-2),R1
              move.l      X:(SP-2),R0
              move.l      X:(R0),B
              move.w      X:(SP),A
              lsrr.l      A,B
              move.l      X:(SP-4),A
              add         B,A
              move.l      A10,X:(R1)
;
;   24: 		a[1] = a[1] >> n; 
;   25: 	} 
;   26: 	 
;
              move.l      X:(SP-2),R1
              move.l      X:(SP-2),R0
              adda        #<2,R0
              move.l      X:(R0),A
              move.w      X:(SP),B
              lsrr.l      B,A
              move.l      A10,X:(R1+>2)
;
;   27: 	return nr; 
;   28:  
;
_L6_1:
              move.l      X:(SP-12),B
              move.l      X:(SP-14),A
;
;   29: } 
              suba        #<10,SP
              rts      

end_FARTSHRULL64:
	
	ENDSEC
	
	
	
