


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
		subroutine "Fmyclb",Fmyclb,end_Fmyclb-Fmyclb
Fmyclb:
              adda       #<2,SP
              move.l      C10,X:(SP)+
              move.l      D10,X:(SP)
              adda       #<10,SP
;
;   46: int myclb(long long x) 
;   47: { 
;   48: 	int count; 
;   49: 	int i; 
;   50: 	unsigned long long mask; 
;   51: 	long long y; 
;   52:  
;   53: 	count = 0; 
;
              clr.w       X:(SP+>0)
;
;   54: 	mask = (unsigned long long)0x8000000000000000LL; 
;
              move.l      #>>0,B
              move.l      #$80000000,A
              move.l      A10,X:(SP-2)
              move.l      B10,X:(SP-4)
;
;   55: 	for(i = 0; i < 64; i++) 
;   56: 	{ 
;
              clr.w       X:(SP->1)
              bra         <_L11_0	; *+45
;
;   57: 		y = x & mask; 
;
_L11_2:
              move.l      X:(SP-$10),D
              move.l      X:(SP-$12),C
              move.l      X:(SP-2),A
              move.l      X:(SP-4),B
              and.l       C,B
              and.l       D,A
              move.l      A10,X:(SP-6)
              move.l      B10,X:(SP-8)
;
;   58: 		if(y == 0) 
;   59: 		{ 
;
              adda       #<8,SP
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
              beq         <_L11_1	; *+23
              nop         
;
;   60: 			count++; 
;   61: 		} 
;   62: 		else 
;   63: 			break; 
;   64:  
;
              move.w      X:(SP),A
              add.w       #<1,A
              move.w      A1,X:(SP)
;
;   65: 		x = x << 1; 
;
              adda       #<4,SP
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
;   66: 	} 
;   67:  
;
              move.w      X:(SP-1),A
              add.w       #<1,A
              move.w      A1,X:(SP-1)
_L11_0:
              move.w      X:(SP-1),A
              cmp.w       #64,A
              blt         <_L11_2	; *-47
_L11_1:
              nop         
;
;   68: 	return count; 
;   69: } 
              move.w      X:(SP),Y0
              suba        #<10,SP
              move.l      X:(SP)-,D
              move.l      X:(SP)-,C
              rts         
end_Fmyclb:
	
	
;===============================================================================
; FUNCTION: ARTDIVLL64
; DESCRIPTION: long long division.
;
; INPUT: a = x, b = y
; OUTPUT: a = x/y
;

ARTDIVULL64:
FARTDIVULL64:
 
              adda       #<2,SP
              move.l      C10,X:(SP)+
              move.l      D10,X:(SP)
              adda        #$18,SP,SP
;
;   70:  
;   71: unsigned long long myUdiv(unsigned long long x, unsigned long long y) 
;   72: { 
;   73:  
;   74: 	unsigned long long t; 
;   75: 	unsigned long long q; 
;   76: 	unsigned long long r; 
;   77: 	int No; 
;   78: 	int dt; 
;   79: 	int i; 
;   80:  
;   81:  
;   82:  
;   83: 	(q) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   84: 	(r) = 0; 
;   85:  
;   86:  
;   87: 	//asm("  push sr"); 
;   88: 	//asm("  bmclr #$4,sr.l"); 
;   89:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;   90: 	if(y == 0) 
;   91: 	{ 
;
              adda       #<8,SP
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
              beq         <_L17_0	; *+21
;
;   92: 		(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;   93: 		(q) = 0; 
;   94: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;   95: 		return q; 
;   96: 	} 
;   97:  
;
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
              bra         >_L17_1	; *+299
;
;   98: 	 if(y > x) 
;   99: 	 { 
;
_L17_0:
              adda       #<8,SP
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
              beq         <_L17_2	; *+18
              nop         
;
;  100: 		 (r) = x; 
;
              move.l      X:(SP-$1e),A
              move.l      X:(SP-$20),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  101: 		 (q) = 0; 
;  102: 		 //asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  103: 		 return q; 
;  104: 	 } 
;  105:  
;
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
              bra         >_L17_1	; *+268
;
;  106:  	 if(x == y) 
;  107:  	 { 
;
_L17_2:
              adda       #<8,SP
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
              beq         <_L17_3	; *+21
;
;  108:  	 	(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  109:  	 	(q) = 1; 
;  110:  	 	//asm("  pop sr"); 
;
              move.l      #>>1,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  111:  	 	return q; 
;  112:  	 } 
;  113:  
;
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
              bra         >_L17_1	; *+234
;
;  114: 	 No = myclb(y) - myclb(x) + 1; 
;  115:  
;
_L17_3:
              adda       #<4,SP
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >Fmyclb
              suba        #<4,SP
              move.w      Y0,X:(SP)
              adda       #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >Fmyclb
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
;  116: 	 (r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  117: 	 for (i = 0; i < (64-No); i++) { 
;
              clr.w       X:(SP->3)
              bra         <_L17_4	; *+49
;
;  118: 	 	(r) = ((r)<<1) | ((x & (long long)0x8000000000000000LL) >> 63); 
;
_L17_5:
              adda       #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-6)
              adda       #<4,SP
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
;  119: 	 	x = x << 1; 
;
              adda       #<4,SP
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
;  120: 	 } 
;
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L17_4:
              move.w      #64,A
              sub.w       X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         <_L17_5	; *-52
;
;  121: 	 (q) = 0; 
;  122:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  123: 	 for (i = 0; i<No; i++) 
;  124: 	 { 
;
              clr.w       X:(SP->3)
              bra         >_L17_6	; *+125
;
;  125: 		(r) = ((r)<<1) | ((x & 0x8000000000000000LL) >> 63); 
;
_L17_10:
              adda       #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-10)
              move.l      B10,X:(SP-4)
              adda       #<4,SP
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
;  126: 		x = x << 1; 
;  127:  
;
              adda       #<4,SP
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
;  128: 	 	t = (r) - y; 
;
              adda       #<8,SP
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
;  129: 		dt = (t & 0x8000000000000000LL) > 0 ? 1:0; 
;
              adda       #<8,SP
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
              beq         <_L17_7	; *+4
              nop         
              move.w      #<1,A
              bra         <_L17_8	; *+2
_L17_7:
              move.w      #<0,A
_L17_8:
              move.w      A1,X:(SP-2)
;
;  130: 		(q) = (q) << 1; 
;
              adda       #<4,SP
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
;  131: 		if (!dt) 
;  132: 		{ 
;
              tst.w       X:(SP-2)
              bne         <_L17_9	; *+18
              nop         
;
;  133: 			(q) = (q) | 1; 
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
;  134: 			(r) = t; 
;  135: 		} 
;
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  136: 	 } 
;  137:  
;  138: 	 //asm("  pop sr"); 
;  139:  
;
_L17_9:
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L17_6:
              move.w      X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         >_L17_10	; *-125
              nop         
;
;  140: 	 return q; 
;  141: } 
              move.l      X:(SP-$10),B
              move.l      X:(SP-$12),A
_L17_1:
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
 
             adda       #<6,SP
;
;  214:  
;  215: long long myDiv(long long x, long long y) 
;  216: { 
;  217: 	long long q; 
;  218: 	int signq; 
;  219:  
;  220: 	//asm("  push sr"); 
;  221: 	//asm("  bmclr #$4,sr.l"); 
;  222:  
;  223: 	if(y == 0) 
;  224: 	{ 
;
              adda       #<8,SP
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
              beq         <_L29_0	; *+13
;
;  225: 		q = 0; 
;  226: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-2)
              move.l      B10,X:(SP-4)
;
;  227: 		return q; 
;  228: 	} 
;  229: 	 
;
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
              bra         >_L29_1	; *+172
;
;  230: 	signq = 1; 
;
_L29_0:
              move.w      #1,X:(SP)
;
;  231: 	if( (x >= 0) && (y < 0) ) 
;
              adda       #<8,SP
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
              beq         <_L29_2	; *+22
              nop         
              adda       #<8,SP
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
              beq         <_L29_2	; *+3
;
;  232: 		signq = -1; 
;
              move.w      #-1,X:(SP)
;
;  233: 	if( (x < 0) && (y > 0) ) 
;
_L29_2:
              adda       #<8,SP
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
              beq         <_L29_3	; *+22
              nop         
              adda       #<8,SP
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
              beq         <_L29_3	; *+3
;
;  234: 		signq = -1; 
;  235: 	 
;
              move.w      #-1,X:(SP)
;
;  236: 	if(x < 0) 
;  237: 	{ 
;
_L29_3:
              adda       #<8,SP
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
              beq         <_L29_4	; *+12
              nop         
;
;  238: 		x = -x; 
;  239: 	} 
;  240: 	 
;
              adda       #<4,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-8)
              move.l      A10,X:(SP-10)
;
;  241: 	if(y < 0) 
;  242: 	{ 
;
_L29_4:
              adda       #<8,SP
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
              beq         <_L29_5	; *+12
              nop         
;
;  243: 		y = -y; 
;  244: 	} 
;  245: 	 
;
              adda       #<4,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-12)
              move.l      A10,X:(SP-14)
;
;  246: 	q = myUdiv(x, y); 
;
_L29_5:
              adda       #<8,SP
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
;  247: 	q = q * signq; 
;  248: 	 
;  249: 	 //asm("  pop sr"); 
;  250:  
;
              adda       #<8,SP
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
;  251: 	 return q; 
;  252: } 
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
_L29_1:
              suba        #<6,SP
              rts         
end_FARTDIVLL64:



ARTMODULL64:
FARTMODULL64:

              adda       #<2,SP
              move.l      C10,X:(SP)+
              move.l      D10,X:(SP)
              adda        #$18,SP,SP
;
;  142:  
;  143: unsigned long long myUmod(unsigned long long x, unsigned long long y) 
;  144: { 
;  145:  
;  146: 	unsigned long long t; 
;  147: 	unsigned long long q; 
;  148: 	unsigned long long r; 
;  149: 	int No; 
;  150: 	int dt; 
;  151: 	int i; 
;  152:  
;  153:  
;  154:  
;  155: 	(q) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  156: 	(r) = 0; 
;  157:  
;  158:  
;  159: 	//asm("  push sr"); 
;  160: 	//asm("  bmclr #$4,sr.l"); 
;  161:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  162: 	if(y == 0) 
;  163: 	{ 
;
              adda       #<8,SP
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
              beq         <_L23_0	; *+21
;
;  164: 		(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  165: 		(q) = 0; 
;  166: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  167: 		return r; 
;  168: 	} 
;  169:  
;
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
              bra         >_L23_1	; *+299
;
;  170: 	 if(y > x) 
;  171: 	 { 
;
_L23_0:
              adda       #<8,SP
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
              beq         <_L23_2	; *+18
              nop         
;
;  172: 		 (r) = x; 
;
              move.l      X:(SP-$1e),A
              move.l      X:(SP-$20),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  173: 		 (q) = 0; 
;  174: 		 //asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  175: 		 return r; 
;  176: 	 } 
;  177:  
;
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
              bra         >_L23_1	; *+268
;
;  178:  	 if(x == y) 
;  179:  	 { 
;
_L23_2:
              adda       #<8,SP
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
              beq         <_L23_3	; *+21
;
;  180:  	 	(r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  181:  	 	(q) = 1; 
;  182:  	 	//asm("  pop sr"); 
;
              move.l      #>>1,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  183:  	 	return r; 
;  184:  	 } 
;  185:  
;
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
              bra         >_L23_1	; *+234
;
;  186: 	 No = myclb(y) - myclb(x) + 1; 
;  187:  
;
_L23_3:
              adda       #<4,SP
              move.l      X:(SP-$26),A
              move.l      X:(SP-$28),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >Fmyclb
              suba        #<4,SP
              move.w      Y0,X:(SP)
              adda       #<4,SP
              move.l      X:(SP-$22),A
              move.l      X:(SP-$24),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >Fmyclb
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
;  188: 	 (r) = 0; 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  189: 	 for (i = 0; i < (64-No); i++) { 
;
              clr.w       X:(SP->3)
              bra         <_L23_4	; *+49
;
;  190: 	 	(r) = ((r)<<1) | ((x & (long long)0x8000000000000000LL) >> 63); 
;
_L23_5:
              adda       #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-6)
              adda       #<4,SP
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
;  191: 	 	x = x << 1; 
;
              adda       #<4,SP
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
;  192: 	 } 
;
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L23_4:
              move.w      #64,A
              sub.w       X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         <_L23_5	; *-52
;
;  193: 	 (q) = 0; 
;  194:  
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-$10)
              move.l      B10,X:(SP-$12)
;
;  195: 	 for (i = 0; i<No; i++) 
;  196: 	 { 
;
              clr.w       X:(SP->3)
              bra         >_L23_6	; *+125
;
;  197: 		(r) = ((r)<<1) | ((x & 0x8000000000000000LL) >> 63); 
;
_L23_10:
              adda       #<4,SP
              move.l      X:(SP-$18),A
              move.l      X:(SP-$1a),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.w      #<1,Y0
              jsr         >ARTSHLLL64
              suba        #<4,SP
              move.l      A10,X:(SP-10)
              move.l      B10,X:(SP-4)
              adda       #<4,SP
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
;  198: 		x = x << 1; 
;  199:  
;
              adda       #<4,SP
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
;  200: 	 	t = (r) - y; 
;
              adda       #<8,SP
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
;  201: 		dt = (t & 0x8000000000000000LL) > 0 ? 1:0; 
;
              adda       #<8,SP
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
              beq         <_L23_7	; *+4
              nop         
              move.w      #<1,A
              bra         <_L23_8	; *+2
_L23_7:
              move.w      #<0,A
_L23_8:
              move.w      A1,X:(SP-2)
;
;  202: 		(q) = (q) << 1; 
;
              adda       #<4,SP
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
;  203: 		if (!dt) 
;  204: 		{ 
;
              tst.w       X:(SP-2)
              bne         <_L23_9	; *+18
              nop         
;
;  205: 			(q) = (q) | 1; 
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
;  206: 			(r) = t; 
;  207: 		} 
;
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      A10,X:(SP-$14)
              move.l      B10,X:(SP-$16)
;
;  208: 	 } 
;  209:  
;  210: 	 //asm("  pop sr"); 
;  211:  
;
_L23_9:
              move.w      X:(SP-3),A
              add.w       #<1,A
              move.w      A1,X:(SP-3)
_L23_6:
              move.w      X:(SP-1),A
              cmp.w       X:(SP-3),A
              bgt         >_L23_10	; *-125
              nop         
;
;  212: 	 return r; 
;  213: } 
              move.l      X:(SP-$14),B
              move.l      X:(SP-$16),A
_L23_1:
              suba        #<24,SP
              move.l      X:(SP)-,D
              move.l      X:(SP)-,C
              rts         
end_FARTMODULL64:

ARTMODLL64:
FARTMODLL64:

              adda       #<6,SP
;
;  253:  
;  254:  
;  255:  
;  256: long long myMod(long long x, long long y) 
;  257: { 
;  258:  
;  259: 	long long r; 
;  260: 	int signr; 
;  261:  
;  262: 	//asm("  push sr"); 
;  263: 	//asm("  bmclr #$4,sr.l"); 
;  264:  
;  265: 	if(y == 0) 
;  266: 	{ 
;
              adda       #<8,SP
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
              beq         <_L35_0	; *+13
;
;  267: 		r = 0; 
;  268: 		//asm("  pop sr"); 
;
              move.l      #>>0,B
              move.l      #>>0,A
              move.l      A10,X:(SP-2)
              move.l      B10,X:(SP-4)
;
;  269: 		return r; 
;  270: 	} 
;  271: 	 
;
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
              bra         >_L35_1	; *+113
;
;  272: 	signr = x >= 0 ? 1:-1; 
;  273: 	 
;
_L35_0:
              adda       #<8,SP
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
              beq         <_L35_2	; *+4
              nop         
              move.w      #<1,A
              bra         <_L35_3	; *+2
_L35_2:
              move.w      #<-1,A
_L35_3:
              move.w      A1,X:(SP)
;
;  274: 	if(x < 0) 
;  275: 	{ 
;
              adda       #<8,SP
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
              beq         <_L35_4	; *+12
              nop         
;
;  276: 		x = -x; 
;  277: 	} 
;  278: 	 
;
              adda       #<4,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-8)
              move.l      A10,X:(SP-10)
;
;  279: 	if(y < 0) 
;  280: 	{ 
;
_L35_4:
              adda       #<8,SP
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
              beq         <_L35_5	; *+12
              nop         
;
;  281: 		y = -y; 
;  282: 	} 
;  283: 	 
;
              adda       #<4,SP
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-12)
              move.l      A10,X:(SP-14)
;
;  284: 	r = myUmod(x, y); 
;  285:  
;
_L35_5:
              adda       #<8,SP
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
;  286: 	if( signr == -1) 
;
              move.w      #<-1,A
              cmp.w       X:(SP),A
              bne         <_L35_6	; *+12
              nop         
;
;  287: 		r = -r; 
;  288: 	 
;  289: 	 //asm("  pop sr"); 
;  290:  
;
              adda       #<4,SP
              move.l      X:(SP-6),A
              move.l      X:(SP-8),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              jsr         >ARTNEGLL64
              suba        #<4,SP
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP-4)
;
;  291: 	 return r; 
;  292: } 
_L35_6:
              move.l      X:(SP-2),B
              move.l      X:(SP-4),A
_L35_1:
              suba        #<6,SP
              rts         
end_FARTMODLL64:

	
	ENDSEC
	
	
	
