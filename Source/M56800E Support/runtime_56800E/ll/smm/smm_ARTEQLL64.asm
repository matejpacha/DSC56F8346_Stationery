


; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.





; SECTION: the long long code
	SECTION ll_engine
	
	OPT	CC
	GLOBAL	ARTEQLL64
	GLOBAL	FEQLL64
	GLOBAL	ARTEQULL64
	GLOBAL	FARTEQULL64	

	GLOBAL	ARTNELL64
	GLOBAL	FARTNELL64
	GLOBAL	ARTNEULL64
	GLOBAL	FARTNEULL64	
	
	GLOBAL	ARTGTLL64
	GLOBAL	FARTGTLL64
	GLOBAL	ARTGTULL64
	GLOBAL	FARTGTULL64

	GLOBAL	ARTGELL64
	GLOBAL	FARTGELL64
	GLOBAL	ARTGEULL64
	GLOBAL	FARTGEULL64

	GLOBAL	ARTLELL64
	GLOBAL	FARTLELL64
	GLOBAL	ARTLEULL64
	GLOBAL	FARTLEULL64

	GLOBAL	ARTLTLL64
	GLOBAL	FARTLTLL64
	GLOBAL	ARTLTULL64
	GLOBAL	FARTLTULL64	
	
;===============================================================================
; FUNCTION: ARTEQLL64
; DESCRIPTION: long long equal.
;
; INPUT: a = x, b = y
; OUTPUT: a == b 
;

ARTEQULL64:
FARTEQULL64:
               adda        #<2,SP
;
;    8:     ca = (unsigned long *)(&a); 
;
              adda        #-7,SP,R0
              move.w      R0,X:(SP)
;
;    9:     cb = (unsigned long *)(&b); 
;   10:  
;
              adda        #-11,SP,R0
              move.w      R0,X:(SP-1)
;
;   11:     if( *ca != *cb ) 
;
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              move.l      X:(R0),A
              cmp.l       B,A
              beq         <_L6_0	; *+4
              nop         
;
;   12:     	return 0; 
;   13:  
;   14:     /* means *ca == *cb */ 
;
              move.w      #<0,Y0
              bra         <_L6_1	; *+13
;
;   15:     if( *(ca+1) != *(cb+1) ) 
;
_L6_0:
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              beq         <_L6_2	; *+4
              nop         
;
;   16:     	return 0; 
;   17:  
;
              move.w      #<0,Y0
              bra         <_L6_1	; *+2
;
;   18: 	return 1; 
;
_L6_2:
              move.w      #<1,Y0
;
;   19: } 
_L6_1:
              suba        #<2,SP
              rts         
end_FARTEQULL64:


ARTEQLL64:
FARTEQLL64:
              adda        #<12,SP
;
;   28:     ca = (long *)(&a); 
;
              adda        #-17,SP,R0
              move.w      R0,X:(SP)
;
;   29:     cb = (long *)(&b); 
;   30:  
;
              adda        #-21,SP,R0
              move.w      R0,X:(SP-1)
;
;   31:     ua = (unsigned long long)a; 
;
              move.l      X:(SP-14),A
              move.l      X:(SP-$10),B
              move.l      A10,X:(SP-4)
              move.l      B10,X:(SP-6)
;
;   32:     ub = (unsigned long long)b; 
;   33:  
;   34:  
;
              move.l      X:(SP-$12),A
              move.l      X:(SP-$14),B
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-10)
;
;   35:     if( *(ca+1) >= 0 ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L11_0	; *+4
;
;   36:     	signa = 1; 
;   37:     else 
;
              move.w      #1,X:(SP-2)
              bra         <_L11_1	; *+3
;
;   38:     	signa = -1; 
;   39:  
;
_L11_0:
              move.w      #-1,X:(SP-2)
;
;   40:     if( *(cb+1) >= 0) 
;
_L11_1:
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L11_2	; *+4
;
;   41:     	signb = 1; 
;   42:     else 
;
              move.w      #1,X:(SP-3)
              bra         <_L11_3	; *+3
;
;   43:     	signb = -1; 
;   44:  
;
_L11_2:
              move.w      #-1,X:(SP-3)
;
;   45:     if(signa != signb) 
;
_L11_3:
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              beq         <_L11_4	; *+4
              nop         
;
;   46:     	return 0; 
;   47:  
;
              move.w      #<0,Y0
              bra         <_L11_5	; *+13
;
;   48:     return myARTUEQLL64(ua, ub); 
;
_L11_4:
              adda        #<8,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTEQULL64
              suba        #<8,SP
;
;   49: } 
_L11_5:
              suba        #<12,SP
              rts         
end_FARTEQLL64:              
          
ARTNEULL64:
FARTNEULL64:
              adda        #<2,SP
;
;   57:     ca = (unsigned long *)(&a); 
;
              adda        #-7,SP,R0
              move.w      R0,X:(SP)
;
;   58:     cb = (unsigned long *)(&b); 
;   59:  
;
              adda        #-11,SP,R0
              move.w      R0,X:(SP-1)
;
;   60:     if( *ca != *cb ) 
;
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              move.l      X:(R0),A
              cmp.l       B,A
              beq         <_L17_0	; *+4
              nop         
;
;   61:     	return 1; 
;   62:  
;   63:     /* means *ca == *cb */ 
;
              move.w      #<1,Y0
              bra         <_L17_1	; *+13
;
;   64:     if( *(ca+1) != *(cb+1) ) 
;
_L17_0:
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              beq         <_L17_2	; *+4
              nop         
;
;   65:     	return 1; 
;   66:  
;
              move.w      #<1,Y0
              bra         <_L17_1	; *+2
;
;   67: 	return 0; 
;
_L17_2:
              move.w      #<0,Y0
;
;   68: } 
_L17_1:
              suba        #<2,SP
              rts         
end_FARTNEULL64:


ARTNELL64:
FARTNELL64:
              adda        #<12,SP
;
;   78:     ca = (long *)(&a); 
;
              adda        #-17,SP,R0
              move.w      R0,X:(SP)
;
;   79:     cb = (long *)(&b); 
;   80:  
;
              adda        #-21,SP,R0
              move.w      R0,X:(SP-1)
;
;   81:     ua = (unsigned long long)a; 
;
              move.l      X:(SP-14),A
              move.l      X:(SP-$10),B
              move.l      A10,X:(SP-4)
              move.l      B10,X:(SP-6)
;
;   82:     ub = (unsigned long long)b; 
;   83:  
;   84:  
;
              move.l      X:(SP-$12),A
              move.l      X:(SP-$14),B
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-10)
;
;   85:     if( *(ca+1) >= 0 ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L22_0	; *+4
;
;   86:     	signa = 1; 
;   87:     else 
;
              move.w      #1,X:(SP-2)
              bra         <_L22_1	; *+3
;
;   88:     	signa = -1; 
;   89:  
;
_L22_0:
              move.w      #-1,X:(SP-2)
;
;   90:     if( *(cb+1) >= 0) 
;
_L22_1:
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L22_2	; *+4
;
;   91:     	signb = 1; 
;   92:     else 
;
              move.w      #1,X:(SP-3)
              bra         <_L22_3	; *+3
;
;   93:     	signb = -1; 
;   94:  
;
_L22_2:
              move.w      #-1,X:(SP-3)
;
;   95:     if(signa != signb) 
;
_L22_3:
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              beq         <_L22_4	; *+4
              nop         
;
;   96:     	return 1; 
;   97:  
;
              move.w      #<1,Y0
              bra         <_L22_5	; *+13
;
;   98:     return myARTUNELL64(ua, ub); 
;
_L22_4:
              adda        #<8,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTNEULL64
              suba        #<8,SP
;
;   99: } 
_L22_5:
              suba        #<12,SP
              rts         
end_FARTNELL64:

ARTGTULL64:
FARTGTULL64:
              adda        #<2,SP
;
;  106:     ca = (unsigned long *)(&a); 
;
              adda        #-7,SP,R0
              move.w      R0,X:(SP)
;
;  107:     cb = (unsigned long *)(&b); 
;  108:  
;
              adda        #-11,SP,R0
              move.w      R0,X:(SP-1)
;
;  109:     if( *(ca+1) > *(cb+1) ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bcc         <_L28_0	; *+4
              nop         
;
;  110:     	return 1; 
;  111:  
;
              move.w      #<1,Y0
              bra         <_L28_1	; *+22
;
;  112:     if( *(ca+1) < *(cb+1) ) 
;
_L28_0:
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bls         <_L28_2	; *+4
              nop         
;
;  113:     	return 0; 
;  114:  
;  115:     /* means *ca == *cb */ 
;
              move.w      #<0,Y0
              bra         <_L28_1	; *+11
;
;  116:     if( *(ca) > *(cb) ) 
;
_L28_2:
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              move.l      X:(R0),A
              cmp.l       B,A
              bcc         <_L28_3	; *+4
              nop         
;
;  117:     	return 1; 
;  118:  
;
              move.w      #<1,Y0
              bra         <_L28_1	; *+2
;
;  119: 	return 0; 
;
_L28_3:
              move.w      #<0,Y0
;
;  120: } 
_L28_1:
              suba        #<2,SP
              rts         
 
end_FARTGTULL64:

ARTGTLL64:
FARTGTLL64:
              adda        #<12,SP
;
;  130:     ca = (long *)(&a); 
;
              adda        #-17,SP,R0
              move.w      R0,X:(SP)
;
;  131:     cb = (long *)(&b); 
;  132:  
;
              adda        #-21,SP,R0
              move.w      R0,X:(SP-1)
;
;  133:     ua = (unsigned long long)a; 
;
              move.l      X:(SP-14),A
              move.l      X:(SP-$10),B
              move.l      A10,X:(SP-4)
              move.l      B10,X:(SP-6)
;
;  134:     ub = (unsigned long long)b; 
;  135:  
;  136:  
;
              move.l      X:(SP-$12),A
              move.l      X:(SP-$14),B
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-10)
;
;  137:     if( *(ca+1) >= 0 ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L33_0	; *+4
;
;  138:     	signa = 1; 
;  139:     else 
;
              move.w      #1,X:(SP-2)
              bra         <_L33_1	; *+3
;
;  140:     	signa = -1; 
;  141:  
;
_L33_0:
              move.w      #-1,X:(SP-2)
;
;  142:     if( *(cb+1) >= 0) 
;
_L33_1:
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L33_2	; *+4
;
;  143:     	signb = 1; 
;  144:     else 
;
              move.w      #1,X:(SP-3)
              bra         <_L33_3	; *+3
;
;  145:     	signb = -1; 
;  146:  
;
_L33_2:
              move.w      #-1,X:(SP-3)
;
;  147:     if(signa != signb) 
;
_L33_3:
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              beq         <_L33_4	; *+13
              nop         
;
;  148:     	return (signa > signb); 
;  149:  
;
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              clr.w       Y0
              bge         <_L33_5	; *+3
              nop         
              move.w      #<1,Y0
_L33_5:
              clr.w       Y0
              bge         <_L33_6	; *+3
              nop         
              move.w      #<1,Y0
_L33_6:
              bra         <_L33_7	; *+13
;
;  150:     return myARTUGTLL64(ua, ub); 
;
_L33_4:
              adda        #<8,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTGTULL64
              suba        #<8,SP
;
;  151: } 
_L33_7:
              suba        #<12,SP
              rts         
end_FARTGTLL64:



ARTGEULL64:
FARTGEULL64:
              adda        #<2,SP
;
;  159:     ca = (unsigned long *)(&a); 
;
              adda        #-7,SP,R0
              move.w      R0,X:(SP)
;
;  160:     cb = (unsigned long *)(&b); 
;  161:  
;
              adda        #-11,SP,R0
              move.w      R0,X:(SP-1)
;
;  162:     if( *(ca+1) > *(cb+1) ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bcc         <_L39_0	; *+4
              nop         
;
;  163:     	return 1; 
;  164:  
;
              move.w      #<1,Y0
              bra         <_L39_1	; *+22
;
;  165:     if( *(ca+1) < *(cb+1) ) 
;
_L39_0:
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bls         <_L39_2	; *+4
              nop         
;
;  166:     	return 0; 
;  167:  
;  168:     /* means *ca == *cb */ 
;
              move.w      #<0,Y0
              bra         <_L39_1	; *+11
;
;  169:     if( *(ca) >= *(cb) ) 
;
_L39_2:
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              move.l      X:(R0),A
              cmp.l       B,A
              bhi         <_L39_3	; *+4
              nop         
;
;  170:     	return 1; 
;  171:  
;
              move.w      #<1,Y0
              bra         <_L39_1	; *+2
;
;  172: 	return 0; 
;
_L39_3:
              move.w      #<0,Y0
;
;  173: } 
_L39_1:
              suba        #<2,SP
              rts         
end_FARTGEULL64:


ARTGELL64:
FARTGELL64:
              adda        #<12,SP
;
;  183:     ca = (long *)(&a); 
;
              adda        #-17,SP,R0
              move.w      R0,X:(SP)
;
;  184:     cb = (long *)(&b); 
;  185:  
;
              adda        #-21,SP,R0
              move.w      R0,X:(SP-1)
;
;  186:     ua = (unsigned long long)a; 
;
              move.l      X:(SP-14),A
              move.l      X:(SP-$10),B
              move.l      A10,X:(SP-4)
              move.l      B10,X:(SP-6)
;
;  187:     ub = (unsigned long long)b; 
;  188:  
;  189:  
;
              move.l      X:(SP-$12),A
              move.l      X:(SP-$14),B
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-10)
;
;  190:     if( *(ca+1) >= 0 ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L44_0	; *+4
;
;  191:     	signa = 1; 
;  192:     else 
;
              move.w      #1,X:(SP-2)
              bra         <_L44_1	; *+3
;
;  193:     	signa = -1; 
;  194:  
;
_L44_0:
              move.w      #-1,X:(SP-2)
;
;  195:     if( *(cb+1) >= 0) 
;
_L44_1:
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L44_2	; *+4
;
;  196:     	signb = 1; 
;  197:     else 
;
              move.w      #1,X:(SP-3)
              bra         <_L44_3	; *+3
;
;  198:     	signb = -1; 
;  199:  
;
_L44_2:
              move.w      #-1,X:(SP-3)
;
;  200:     if(signa != signb) 
;
_L44_3:
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              beq         <_L44_4	; *+13
              nop         
;
;  201:     	return (signa > signb); 
;  202:  
;
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              clr.w       Y0
              bge         <_L44_5	; *+3
              nop         
              move.w      #<1,Y0
_L44_5:
              clr.w       Y0
              bge         <_L44_6	; *+3
              nop         
              move.w      #<1,Y0
_L44_6:
              bra         <_L44_7	; *+13
;
;  203:     return myARTUGELL64(ua, ub); 
;
_L44_4:
              adda        #<8,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTGEULL64
              suba        #<8,SP
;
;  204: } 
_L44_7:
              suba        #<12,SP
              rts         
end_FARTGELL64:

ARTLTULL64:
FARTLTULL64:
              adda        #<2,SP
;
;  211:     ca = (unsigned long *)(&a); 
;
              adda        #-7,SP,R0
              move.w      R0,X:(SP)
;
;  212:     cb = (unsigned long *)(&b); 
;  213:  
;
              adda        #-11,SP,R0
              move.w      R0,X:(SP-1)
;
;  214:     if( *(ca+1) < *(cb+1) ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bls         <_L50_0	; *+4
              nop         
;
;  215:     	return 1; 
;  216:  
;
              move.w      #<1,Y0
              bra         <_L50_1	; *+22
;
;  217:     if( *(ca+1) > *(cb+1) ) 
;
_L50_0:
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bcc         <_L50_2	; *+4
              nop         
;
;  218:     	return 0; 
;  219:  
;  220:     /* means *ca == *cb */ 
;
              move.w      #<0,Y0
              bra         <_L50_1	; *+11
;
;  221:     if( *(ca) >= *(cb) ) 
;
_L50_2:
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              move.l      X:(R0),A
              cmp.l       B,A
              bhi         <_L50_3	; *+4
              nop         
;
;  222:     	return 0; 
;  223:  
;
              move.w      #<0,Y0
              bra         <_L50_1	; *+2
;
;  224: 	return 1; 
;
_L50_3:
              move.w      #<1,Y0
;
;  225: } 
_L50_1:
              suba        #<2,SP
              rts         
end_FARTULTLL64:

ARTLTLL64:
FARTLTLL64:
              adda        #<12,SP
;
;  235:     ca = (long *)(&a); 
;
              adda        #-17,SP,R0
              move.w      R0,X:(SP)
;
;  236:     cb = (long *)(&b); 
;  237:  
;
              adda        #-21,SP,R0
              move.w      R0,X:(SP-1)
;
;  238:     ua = (unsigned long long)a; 
;
              move.l      X:(SP-14),A
              move.l      X:(SP-$10),B
              move.l      A10,X:(SP-4)
              move.l      B10,X:(SP-6)
;
;  239:     ub = (unsigned long long)b; 
;  240:  
;  241:  
;
              move.l      X:(SP-$12),A
              move.l      X:(SP-$14),B
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-10)
;
;  242:     if( *(ca+1) >= 0 ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L55_0	; *+4
;
;  243:     	signa = 1; 
;  244:     else 
;
              move.w      #1,X:(SP-2)
              bra         <_L55_1	; *+3
;
;  245:     	signa = -1; 
;  246:  
;
_L55_0:
              move.w      #-1,X:(SP-2)
;
;  247:     if( *(cb+1) >= 0) 
;
_L55_1:
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L55_2	; *+4
;
;  248:     	signb = 1; 
;  249:     else 
;
              move.w      #1,X:(SP-3)
              bra         <_L55_3	; *+3
;
;  250:     	signb = -1; 
;  251:  
;
_L55_2:
              move.w      #-1,X:(SP-3)
;
;  252:     if(signa < signb) 
;
_L55_3:
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              ble         <_L55_3b	; *+4
              nop         
;
;  253:     	return 1; 
;  254:  
;
              move.w      #<1,Y0
              bra         <_L55_5	; *+13
              
              
;           if(signa > signb) 

_L55_3b:	  move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              bge         <_L55_4	; *+4
              nop 

; 			    return 0;

			  move.w      #<0,Y0
              bra         <_L55_5	; *+13
              
              
;
;  255:     return myARTULTLL64(ua, ub); 
;
_L55_4:
              adda        #<8,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLTULL64
              suba        #<8,SP
;
;  256: } 
_L55_5:
              suba        #<12,SP
              rts         
end_FARTLTLL64:

ARTLEULL64:
FARTLEULL64:
              adda        #<2,SP
;
;  263:     ca = (unsigned long *)(&a); 
;
              adda        #-7,SP,R0
              move.w      R0,X:(SP)
;
;  264:     cb = (unsigned long *)(&b); 
;  265:  
;
              adda        #-11,SP,R0
              move.w      R0,X:(SP-1)
;
;  266:     if( *(ca+1) < *(cb+1) ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bls         <_L61_0	; *+4
              nop         
;
;  267:     	return 1; 
;  268:  
;
              move.w      #<1,Y0
              bra         <_L61_1	; *+22
;
;  269:     if( *(ca+1) > *(cb+1) ) 
;
_L61_0:
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              cmp.l       B,A
              bcc         <_L61_2	; *+4
              nop         
;
;  270:     	return 0; 
;  271:  
;  272:     /* means *ca == *cb */ 
;
              move.w      #<0,Y0
              bra         <_L61_1	; *+11
;
;  273:     if( *(ca) <= *(cb) ) 
;
_L61_2:
              moveu.w     X:(SP),R0
              move.l      X:(R0),B
              moveu.w     X:(SP-1),R0
              move.l      X:(R0),A
              cmp.l       B,A
              bcs         <_L61_3	; *+4
              nop         
;
;  274:     	return 1; 
;  275:  
;
              move.w      #<1,Y0
              bra         <_L61_1	; *+2
;
;  276: 	return 0; 
;
_L61_3:
              move.w      #<0,Y0
;
;  277: } 
_L61_1:
              suba        #<2,SP
              rts         
end_FARTLEULL64:

ARTLELL64:
FARTLELL64:
              adda        #<12,SP
;
;  287:     ca = (long *)(&a); 
;
              adda        #-17,SP,R0
              move.w      R0,X:(SP)
;
;  288:     cb = (long *)(&b); 
;  289:  
;
              adda        #-21,SP,R0
              move.w      R0,X:(SP-1)
;
;  290:     ua = (unsigned long long)a; 
;
              move.l      X:(SP-14),A
              move.l      X:(SP-$10),B
              move.l      A10,X:(SP-4)
              move.l      B10,X:(SP-6)
;
;  291:     ub = (unsigned long long)b; 
;  292:  
;  293:  
;
              move.l      X:(SP-$12),A
              move.l      X:(SP-$14),B
              move.l      A10,X:(SP-8)
              move.l      B10,X:(SP-10)
;
;  294:     if( *(ca+1) >= 0 ) 
;
              moveu.w     X:(SP),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L66_0	; *+4
;
;  295:     	signa = 1; 
;  296:     else 
;
              move.w      #1,X:(SP-2)
              bra         <_L66_1	; *+3
;
;  297:     	signa = -1; 
;  298:  
;
_L66_0:
              move.w      #-1,X:(SP-2)
;
;  299:     if( *(cb+1) >= 0) 
;
_L66_1:
              moveu.w     X:(SP-1),R0
              adda        #<2,R0
              move.l      X:(R0),A
              tst.l       A
              blt         <_L66_2	; *+4
;
;  300:     	signb = 1; 
;  301:     else 
;
              move.w      #1,X:(SP-3)
              bra         <_L66_3	; *+3
;
;  302:     	signb = -1; 
;  303:  
;
_L66_2:
              move.w      #-1,X:(SP-3)
;
;  304:     if(signa < signb) 
;
_L66_3:
              move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              ble         <_L66_3b	; *+4
              nop         
;
;  305:     	return 1; 
;  306:  
;
              move.w      #<1,Y0
              bra         <_L66_5	; *+13

;  307:		if(signa > signb) 

 _L66_3b:     move.w      X:(SP-3),A
              cmp.w       X:(SP-2),A
              bge         <_L66_4	; *+4
              nop         
;
;  308:     	return 0; 
;  309:  
;
              move.w      #<0,Y0
              bra         <_L66_5	; *+13
;
;  310:     return myARTULELL64(ua, ub); 
;
_L66_4:
              adda        #<8,SP
              move.l      X:(SP-12),A
              move.l      X:(SP-14),B
              move.l      B10,X:(SP-2)
              move.l      A10,X:(SP)
              move.l      X:(SP-$10),A
              move.l      X:(SP-$12),B
              move.l      B10,X:(SP-6)
              move.l      A10,X:(SP-4)
              jsr         >ARTLEULL64
              suba        #<8,SP
;
;  311: } 
;
_L66_5:
              suba        #<12,SP
              rts         

end_FARTLELL64:

	ENDSEC