


; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.





; SECTION: the long long code
	SECTION	ll_engine
	
	OPT	CC
	GLOBAL	ARTDIVLL64
	GLOBAL	FARTDIVLL64
	
	GLOBAL	ARTDIVULL64
	GLOBAL	FARTDIVULL64
	
	GLOBAL	ARTMODLL64
	GLOBAL	FARTMODLL64
	
	GLOBAL	ARTMODULL64
	GLOBAL	FARTMODULL64

	ORG	P:
		subroutine "FARTCLB",FARTCLB,end_FARTCLB-FARTCLB
FARTCLB:
              adda        #<2,SP
              move.l      C10,X:(SP)+
              move.l      D10,X:(SP)
              adda        #<10,SP
;
;   18: 	count = 0; 
;
              clr.w       X:(SP+>0)
;
;   19: 	mask = (unsigned long long)0x8000000000000000LL; 
;
              move.l      #>>0,B
              move.l      #$80000000,A
              move.l      A10,X:(SP-2)
              move.l      B10,X:(SP-4)
;
;   20: 	for(i = 0; i < 64; i++) 
;   21: 	{ 
;
              clr.w       X:(SP->1)
              bra         <_L6_0	; *+45
;
;   22: 		y = x & mask; 
;
_L6_2:
              move.l      X:(SP-$10),D
              move.l      X:(SP-$12),C
              move.l      X:(SP-2),A
              move.l      X:(SP-4),B
              and.l       C,B
              and.l       D,A
              move.l      A10,X:(SP-6)
              move.l      B10,X:(SP-8)
;
;   23: 		if(y == 0) 
;   24: 		{ 
;
              adda        #<8,SP
              move.l      X:(SP-14),A
              move.l      X:(SP-$10),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L6_1	; *+23
              nop         
;
;   25: 			count++; 
;   26: 		} 
;   27: 		else 
;   28: 			break; 
;   29:  
;
              move.w      X:(SP),A
              add.w       #<1,A
              move.w      A1,X:(SP)
;
;   30: 		x = x << 1; 
;
              adda        #<4,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      B10,X:(SP-$10)
              move.l      A10,X:(SP-$12)
;
;   31: 	} 
;   32:  
;
              move.w      X:(SP-1),A
              add.w       #<1,A
              move.w      A1,X:(SP-1)
_L6_0:
              move.w      X:(SP-1),A
              cmp.w       #64,A
              blt         <_L6_2	; *-47
_L6_1:
              nop         
;
;   33: 	return count; 
;
              move.w      X:(SP),Y0
;
;   34: } 
              suba        #<10,SP
              move.l      X:(SP)-,D
              move.l      X:(SP)-,C
              rts         
end_FARTCLB:
	
	
;===============================================================================
; FUNCTION: ARTDIVLL64
; DESCRIPTION: long long division.
;
; INPUT: a = x, b = y
; OUTPUT: a = x/y
;

ARTDIVULL64:
FARTDIVULL64:
 
              adda        #<2,SP
              move.l      C10,X:(SP)+
              move.l      D10,X:(SP)
              adda        #$18,SP,SP
;
;   48: 	(q) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   49: 	(r) = 0; 
;   50:  
;   51:  
;   52: 	//asm("  push sr"); 
;   53: 	//asm("  bmclr #$4,sr.l"); 
;   54:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;   55: 	if(y == 0) 
;   56: 	{ 
;
              adda        #<8,SP
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L12_0	; *+21
;
;   57: 		(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;   58: 		(q) = 0; 
;   59: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   60: 		return q; 
;   61: 	} 
;   62:  
;
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
              bra         >_L12_1	; *+299
;
;   63: 	 if(y > x) 
;   64: 	 { 
;
_L12_0:
              adda        #<8,SP
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTGTULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L12_2	; *+18
              nop         
;
;   65: 		 (r) = x; 
;
              move.l      X:(SP-$1e),A
              move.l      X:(SP-$20),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;   66: 		 (q) = 0; 
;   67: 		 //asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   68: 		 return q; 
;   69: 	 } 
;   70:  
;
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
              bra         >_L12_1	; *+268
;
;   71:  	 if(x == y) 
;   72:  	 { 
;
_L12_2:
              adda        #<8,SP
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L12_3	; *+21
;
;   73:  	 	(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;   74:  	 	(q) = 1; 
;   75:  	 	//asm("  pop sr"); 
;
              move.l      #>>1,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   76:  	 	return q; 
;   77:  	 } 
;   78:  
;
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
              bra         >_L12_1	; *+234
;
;   79: 	 No = ARTCLB(y) - ARTCLB(x) + 1; 
;   80:  
;
_L12_3:
              adda        #<4,SP
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >FARTCLB
              suba        #<4,SP
              move.w      Y0,X:(SP)
              adda        #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >FARTCLB
              suba        #<4,SP
              move.w      Y0,A
              move.w      X:(SP),Y0
              sub         A,Y0
              move.w      Y0,X:(SP)
              move.w      X:(SP),A
              add.w       #<1,A
              move.w      A1,X:(SP)
              move.w      X:(SP),A
              move.w      A1,X:(SP-1)
;
;   81: 	 (r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;   82: 	 for (i = 0; i < (64-No); i++) { 
;
              clr.w       X:(SP->3)
              bra         <_L12_4	; *+49
;
;   83: 	 	(r) = ((r)<<1) | ((x & (long long)0x8000000000000000LL) >> 63); 
;
_L12_5:
              adda        #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-6)
              adda        #<4,SP
              move.l      X:(SP-$22),C
              move.l      X:(SP-$24),D
              move.l      #>>0,B
              move.l      #$80000000,A
              and.l       D,B
              and.l       C,A
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<63,Y0
              jsr         >ARTSHRULL64
              suba        #<4,SP
              move.l      X:(SP-8),C
              or.l        C,A
              move.l      X:(SP-6),C
              or.l        C,B
              move.l      B10,X:(SP-$14)
              move.l      A10,X:(SP-$16)
;
;   84: 	 	x = x << 1; 
;
              adda        #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      B10,X:(SP-$1e)
              move.l      A10,X:(SP-$20)
;
;   85: 	 } 
;
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L12_4:
              move.w      #64,A
              sub.w       X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         <_L12_5	; *-52
;
;   86: 	 (q) = 0; 
;   87:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   88: 	 for (i = 0; i<No; i++) 
;   89: 	 { 
;
              clr.w       X:(SP->3)
              bra         >_L12_6	; *+125
;
;   90: 		(r) = ((r)<<1) | ((x & 0x8000000000000000LL) >> 63); 
;
_L12_10:
              adda        #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-10)
              move.l      B10,X:(SP-4)
              adda        #<4,SP
              move.l      X:(SP-$22),C
              move.l      X:(SP-$24),D
              move.l      #>>0,B
              move.l      #$80000000,A
              and.l       D,B
              and.l       C,A
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<63,Y0
              jsr         >ARTSHRULL64
              suba        #<4,SP
              move.l      X:(SP-10),C
              or.l        C,A
              move.l      X:(SP-4),C
              or.l        C,B
              move.l      B10,X:(SP-$14)
              move.l      A10,X:(SP-$16)
;
;   91: 		x = x << 1; 
;   92:  
;
              adda        #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      B10,X:(SP-$1e)
              move.l      A10,X:(SP-$20)
;
;   93: 	 	t = (r) - y; 
;
              adda        #<8,SP
              move.l      X:(SP-$1c),A
              move.l      X:(SP-$1e),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTSUBLL64
              suba        #<8,SP
              move.l      B10,X:(SP-12)
              move.l      A10,X:(SP-14)
;
;   94: 		dt = (t & 0x8000000000000000LL) > 0 ? 1:0; 
;
              adda        #<8,SP
              move.l      X:(SP-$14),C
              move.l      X:(SP-$16),D
              move.l      #>>0,B
              move.l      #$80000000,A
              and.l       D,B
              and.l       C,A
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTNEULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L12_7	; *+4
              nop         
              move.w      #<1,A
              bra         <_L12_8	; *+2
_L12_7:
              move.w      #<0,A
_L12_8:
              move.w      A1,X:(SP-2)
;
;   95: 		(q) = (q) << 1; 
;
              adda        #<4,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      B10,X:(SP-$10)
              move.l      A10,X:(SP-$12)
;
;   96: 		if (!dt) 
;   97: 		{ 
;
              tst.w       X:(SP-2)
              bne         <_L12_9	; *+18
              nop         
;
;   98: 			(q) = (q) | 1; 
;
              move.l      X:(SP-$10),C
              move.l      X:(SP-$12),D
              move.l      #>>1,B
              move.l      #>>0,A
              or.l        D,B
              or.l        C,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   99: 			(r) = t; 
;  100: 		} 
;
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  101: 	 } 
;  102:  
;  103: 	 //asm("  pop sr"); 
;  104:  
;
_L12_9:
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L12_6:
              move.w      X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         >_L12_10	; *-125
              nop         
;
;  105: 	 return q; 
;
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
;
;  106: } 
_L12_1:
              suba        #<24,SP
              move.l      X:(SP)-,D
              move.l      X:(SP)-,C
              rts         
end_FARTDIVULL64:


;===============================================================================
; FUNCTION: ARTDIVLL64
; DESCRIPTION: unsigned long long division.
;
; INPUT: a = x, b = y
; OUTPUT: a = x/y
;

ARTDIVLL64:
FARTDIVLL64:
              adda        #<6,SP
;
;  188: 	if(y == 0) 
;  189: 	{ 
;
              adda        #<8,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L24_0	; *+13
;
;  190: 		q = 0; 
;  191: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-2)
              move.l      B10,X:(SP-4)
;
;  192: 		return q; 
;  193: 	} 
;  194: 	 
;
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
              bra         >_L24_1	; *+172
;
;  195: 	signq = 1; 
;
_L24_0:
              move.w      #1,X:(SP)
;
;  196: 	if( (x >= 0) && (y < 0) ) 
;
              adda        #<8,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTGELL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L24_2	; *+22
              nop         
              adda        #<8,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLTLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L24_2	; *+3
;
;  197: 		signq = -1; 
;
              move.w      #-1,X:(SP)
;
;  198: 	if( (x < 0) && (y > 0) ) 
;
_L24_2:
              adda        #<8,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLTLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L24_3	; *+22
              nop         
              adda        #<8,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTGTLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L24_3	; *+3
;
;  199: 		signq = -1; 
;  200: 	 
;
              move.w      #-1,X:(SP)
;
;  201: 	if(x < 0) 
;  202: 	{ 
;
_L24_3:
              adda        #<8,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLTLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L24_4	; *+12
              nop         
;
;  203: 		x = -x; 
;  204: 	} 
;  205: 	 
;
              adda        #<4,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-8)
              move.l      A10,X:(SP-10)
;
;  206: 	if(y < 0) 
;  207: 	{ 
;
_L24_4:
              adda        #<8,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLTLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L24_5	; *+12
              nop         
;
;  208: 		y = -y; 
;  209: 	} 
;  210: 	 
;
              adda        #<4,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-12)
              move.l      A10,X:(SP-14)
;
;  211: 	q = myUdiv(x, y); 
;
_L24_5:
              adda        #<8,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTDIVULL64
              suba        #<8,SP
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP-4)
;
;  212: 	q = q * signq; 
;  213: 	 
;  214: 	 //asm("  pop sr"); 
;  215:  
;
              adda        #<8,SP
              move.l      X:(SP-10),A
              move.l      X:(SP-12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      X:(SP-8),A
              asr16       A,B
              tfr         B,A
              asrr.l      #<$1f,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTMULLL64
              suba        #<8,SP
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP-4)
;
;  216: 	 return q; 
;
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
;
;  217: } 
_L24_1:
              suba        #<6,SP
              rts              
end_FARTDIVLL64:



ARTMODULL64:
FARTMODULL64:
              adda        #<2,SP
              move.l      C10,X:(SP)+
              move.l      D10,X:(SP)
              adda        #$18,SP,SP
;
;  120: 	(q) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  121: 	(r) = 0; 
;  122:  
;  123:  
;  124: 	//asm("  push sr"); 
;  125: 	//asm("  bmclr #$4,sr.l"); 
;  126:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  127: 	if(y == 0) 
;  128: 	{ 
;
              adda        #<8,SP
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L18_0	; *+21
;
;  129: 		(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  130: 		(q) = 0; 
;  131: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  132: 		return r; 
;  133: 	} 
;  134:  
;
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
              bra         >_L18_1	; *+299
;
;  135: 	 if(y > x) 
;  136: 	 { 
;
_L18_0:
              adda        #<8,SP
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTGTULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L18_2	; *+18
              nop         
;
;  137: 		 (r) = x; 
;
              move.l      X:(SP-$1e),A
              move.l      X:(SP-$20),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  138: 		 (q) = 0; 
;  139: 		 //asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  140: 		 return r; 
;  141: 	 } 
;  142:  
;
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
              bra         >_L18_1	; *+268
;
;  143:  	 if(x == y) 
;  144:  	 { 
;
_L18_2:
              adda        #<8,SP
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L18_3	; *+21
;
;  145:  	 	(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  146:  	 	(q) = 1; 
;  147:  	 	//asm("  pop sr"); 
;
              move.l      #>>1,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  148:  	 	return r; 
;  149:  	 } 
;  150:  
;
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
              bra         >_L18_1	; *+234
;
;  151: 	 No = ARTCLB(y) - ARTCLB(x) + 1; 
;  152:  
;
_L18_3:
              adda        #<4,SP
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >FARTCLB
              suba        #<4,SP
              move.w      Y0,X:(SP)
              adda        #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >FARTCLB
              suba        #<4,SP
              move.w      Y0,A
              move.w      X:(SP),Y0
              sub         A,Y0
              move.w      Y0,X:(SP)
              move.w      X:(SP),A
              add.w       #<1,A
              move.w      A1,X:(SP)
              move.w      X:(SP),A
              move.w      A1,X:(SP-1)
;
;  153: 	 (r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  154: 	 for (i = 0; i < (64-No); i++) { 
;
              clr.w       X:(SP->3)
              bra         <_L18_4	; *+49
;
;  155: 	 	(r) = ((r)<<1) | ((x & (long long)0x8000000000000000LL) >> 63); 
;
_L18_5:
              adda        #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-6)
              adda        #<4,SP
              move.l      X:(SP-$22),C
              move.l      X:(SP-$24),D
              move.l      #>>0,B
              move.l      #$80000000,A
              and.l       D,B
              and.l       C,A
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<63,Y0
              jsr         >ARTSHRULL64
              suba        #<4,SP
              move.l      X:(SP-8),C
              or.l        C,A
              move.l      X:(SP-6),C
              or.l        C,B
              move.l      B10,X:(SP-$14)
              move.l      A10,X:(SP-$16)
;
;  156: 	 	x = x << 1; 
;
              adda        #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      B10,X:(SP-$1e)
              move.l      A10,X:(SP-$20)
;
;  157: 	 } 
;
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L18_4:
              move.w      #64,A
              sub.w       X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         <_L18_5	; *-52
;
;  158: 	 (q) = 0; 
;  159:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  160: 	 for (i = 0; i<No; i++) 
;  161: 	 { 
;
              clr.w       X:(SP->3)
              bra         >_L18_6	; *+125
;
;  162: 		(r) = ((r)<<1) | ((x & 0x8000000000000000LL) >> 63); 
;
_L18_10:
              adda        #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-10)
              move.l      B10,X:(SP-4)
              adda        #<4,SP
              move.l      X:(SP-$22),C
              move.l      X:(SP-$24),D
              move.l      #>>0,B
              move.l      #$80000000,A
              and.l       D,B
              and.l       C,A
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<63,Y0
              jsr         >ARTSHRULL64
              suba        #<4,SP
              move.l      X:(SP-10),C
              or.l        C,A
              move.l      X:(SP-4),C
              or.l        C,B
              move.l      B10,X:(SP-$14)
              move.l      A10,X:(SP-$16)
;
;  163: 		x = x << 1; 
;  164:  
;
              adda        #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      B10,X:(SP-$1e)
              move.l      A10,X:(SP-$20)
;
;  165: 	 	t = (r) - y; 
;
              adda        #<8,SP
              move.l      X:(SP-$1c),A
              move.l      X:(SP-$1e),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$2a),A
              move.l      X:(SP-$2c),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTSUBLL64
              suba        #<8,SP
              move.l      B10,X:(SP-12)
              move.l      A10,X:(SP-14)
;
;  166: 		dt = (t & 0x8000000000000000LL) > 0 ? 1:0; 
;
              adda        #<8,SP
              move.l      X:(SP-$14),C
              move.l      X:(SP-$16),D
              move.l      #>>0,B
              move.l      #$80000000,A
              and.l       D,B
              and.l       C,A
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTNEULL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L18_7	; *+4
              nop         
              move.w      #<1,A
              bra         <_L18_8	; *+2
_L18_7:
              move.w      #<0,A
_L18_8:
              move.w      A1,X:(SP-2)
;
;  167: 		(q) = (q) << 1; 
;
              adda        #<4,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      B10,X:(SP-$10)
              move.l      A10,X:(SP-$12)
;
;  168: 		if (!dt) 
;  169: 		{ 
;
              tst.w       X:(SP-2)
              bne         <_L18_9	; *+18
              nop         
;
;  170: 			(q) = (q) | 1; 
;
              move.l      X:(SP-$10),C
              move.l      X:(SP-$12),D
              move.l      #>>1,B
              move.l      #>>0,A
              or.l        D,B
              or.l        C,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  171: 			(r) = t; 
;  172: 		} 
;
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  173: 	 } 
;  174:  
;  175: 	 //asm("  pop sr"); 
;  176:  
;
_L18_9:
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L18_6:
              move.w      X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         >_L18_10	; *-125
              nop         
;
;  177: 	 return r; 
;
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
;
;  178: } 
_L18_1:
              suba        #<24,SP
              move.l      X:(SP)-,D
              move.l      X:(SP)-,C
              rts           
end_FARTMODULL64:

ARTMODLL64:
FARTMODLL64:

              adda        #<6,SP
;
;  230: 	if(y == 0) 
;  231: 	{ 
;
              adda        #<8,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L30_0	; *+13
;
;  232: 		r = 0; 
;  233: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-2)
              move.l      B10,X:(SP-4)
;
;  234: 		return r; 
;  235: 	} 
;  236: 	 
;
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
              bra         >_L30_1	; *+113
;
;  237: 	signr = x >= 0 ? 1:-1; 
;  238: 	 
;
_L30_0:
              adda        #<8,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTGELL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L30_2	; *+4
              nop         
              move.w      #<1,A
              bra         <_L30_3	; *+2
_L30_2:
              move.w      #<-1,A
_L30_3:
              move.w      A1,X:(SP)
;
;  239: 	if(x < 0) 
;  240: 	{ 
;
              adda        #<8,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLTLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L30_4	; *+12
              nop         
;
;  241: 		x = -x; 
;  242: 	} 
;  243: 	 
;
              adda        #<4,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-8)
              move.l      A10,X:(SP-10)
;
;  244: 	if(y < 0) 
;  245: 	{ 
;
_L30_4:
              adda        #<8,SP
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLTLL64
              suba        #<8,SP
              tst.w       Y0
              beq         <_L30_5	; *+12
              nop         
;
;  246: 		y = -y; 
;  247: 	} 
;  248: 	 
;
              adda        #<4,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-12)
              move.l      A10,X:(SP-14)
;
;  249: 	r = myUmod(x, y); 
;  250:  
;
_L30_5:
              adda        #<8,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$14),A
              move.l      X:(SP-$16),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTMODULL64
              suba        #<8,SP
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP-4)
;
;  251: 	if( signr == -1) 
;
              move.w      #<-1,A
              cmp.w       X:(SP),A
              bne         <_L30_6	; *+12
              nop         
;
;  252: 		r = -r; 
;  253: 	 
;  254: 	 //asm("  pop sr"); 
;  255:  
;
              adda        #<4,SP
              move.l      X:(SP-6),A
              move.l      X:(SP-8),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP-4)
;
;  256: 	 return r; 
;
_L30_6:
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
;
;  257: } 
;
_L30_1:
              suba        #<6,SP
              rts         
end_FARTMODLL64:

	
	ENDSEC
	
	
	
