

; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.





; SECTION: the long long code
	SECTION	ll_engine
	
	OPT	CC
	GLOBAL	ARTMULLL64
	GLOBAL  ARTMULULL64
	GLOBAL	FARTMULLL64
	GLOBAL  FARTMULULL64
	GLOBAL	V3ARTIMPY64
	GLOBAL	FV3ARTIMPY64
	GLOBAL	V3ARTMPY64
	GLOBAL	FV3ARTMPY64


	
	
	
;===============================================================================
; FUNCTION: ARTMULLL64
; DESCRIPTION: Long long multiplication.
;
; INPUT: a = x, b = y
; OUTPUT: a = result = x * y
;
ARTMULLL64:
FARTMULLL64:
;ARTMULULL64:
;FARTMULULL64:


			adda        #<2,SP
            move.l      C10,X:(SP)+
            move.l      D10,X:(SP)	 
		
	        adda       #<14,SP
	        move.l      X:(SP-22),A		; 1
	        ;move.l      X:(SP-20),C	; 0          	
			move.l      X:(SP-26),B		; 3
			;move.l      X:(SP-24),D	; 2			
			
		
	          	

	        impyuu A0,B0,D
	        impyuu A1,B0,Y
	        move.w B1,B0
	      	impyuu A0,B0,C
	      	add C,Y
	      	move.w Y1,B0
	      	move.w #$0,B1
	      	jcc L1
	      	move.w #$1,B1
	L1:
	      	move.w #$1,X:(SP-2)	; to keep carry flag - clear up part of D	
	      	tfr Y0,Y
	      	add D,Y
	      	tfr Y,D
 	      	jcs L2   
	      	move.w #$0,X:(SP-2)	; to keep carry flag - set up part of D  - used in the end test
	L2: 	
	      	move.l D10,X:(SP-4)	; d5
	      	move.l B10,X:(SP-8)	; d14
	        move.l X:(SP-22),A	; 1          	
	        move.l X:(SP-24),B	; 2				 
	      	impyuu A0,B0,C	; d10
        	move.l X:(SP-20),A	; 0          	
			move.l X:(SP-26),B	; 3				 
          	impyuu B0,A0,D	; d15
          	add C,D ; d15
          	tfr D,Y
			move.l X:(SP-22),A	; 1          	
	        move.l X:(SP-26),B	; 3				 
          	move.w A1,A0
          	imacuu A0,B1,Y
			move.l X:(SP-8),C
          	add C,Y	; d15
          	move.l Y,X:(SP-8)
			move.l X:(SP-22),B		; 1
          	move.l X:(SP-24),A		; 2				 
          	impysu A1,B0,Y
          	imacuu A0,B1,Y
			move.l X:(SP-20),B	; 0          	
			move.l X:(SP-26),A	; 3
			tfr A,C
          	imacuu B0,C1,Y
			move.l X:(SP-26),A	; 3
          	imacus A0,B1,Y
          	asll.l #$10,Y
			move.l X:(SP-8),D
			bfclr #$01,SR
          	add D,Y	; Y = d4
			move.l X:(SP-4),A
			move.w X:(SP-2),B0	
			bftsth #$0001,B0	
          	jcc L3
          	move.l #$1,C
          	add C,Y
L3:
			tfr Y,B
          	sxt.l B
			suba       #<14,SP
			
			move.l      X:(SP)-,D
            move.l      X:(SP)-,C
          	
          	rts 

end_FARTMULLL64:
;end_FARTMULULL64:

;===============================================================================
; FUNCTION: V3ARTIMPY64
; DESCRIPTION: 	56800EX long long multiplication.(56800EX instructions intrinsic functions support)
;		Multiply two 32-bit integer values generating a signed 64-bit integer result.
;		56800EX instruction:	IMPY64 FF1,FF1,FF:Y - Integer Multiply 32x32 = 64 bit; save higher (in Acc), lower (in Y)
;
V3ARTIMPY64:
FV3ARTIMPY64:
	
	adda #<2,SP
	move.l C10,X:(SP)
	
	impy64 A,B,C
	
	adda #<4,SP
	move.l C10,X:(SP)
	move.l Y,X:(SP-2)
	move.l X:(SP),B
	move.l X:(SP-2),A
	suba #4,SP
	
	move.l X:(SP)-,C
	rts
	
end_FV3ARTIMPY64:

;===============================================================================
; FUNCTION: V3ARTMPY64
; DESCRIPTION: 	56800EX long long multiplication.(56800EX instructions intrinsic functions support)
;		Multiply two 32-bit fractional values generating a signed 64-bit fractional result.
;		56800EX instruction:	MPY64 FF1,FF1,FF:Y - Fractional Multiply 32x32 = 64 bit; save higher (in Acc), lower (in Y)
;
V3ARTMPY64:
FV3ARTMPY64:
	
	adda #<2,SP
	move.l C10,X:(SP)
	
	mpy64 A,B,C
	
	adda #<4,SP
	move.l C10,X:(SP)
	move.l Y,X:(SP-2)
	move.l X:(SP),B
	move.l X:(SP-2),A
	suba #4,SP
	
	move.l X:(SP)-,C
	rts
	
end_FV3ARTMPY64:

;===============================================================================
; FUNCTION: ARTMULULL64
; DESCRIPTION: Long long unsigned multiplication.
;
; INPUT: a = x, b = y
; OUTPUT: a = result = x * y
;
ARTMULULL64:
FARTMULULL64:
              
			adda       #<14,SP
	        move.l      X:(SP-18),A		; 1
	        ;move.l      X:(SP-16),C	; 0          	
			move.l      X:(SP-22),B		; 3
			;move.l      X:(SP-20),D	; 2				 
          	

          	impyuu A0,B0,D
          	impyuu A1,B0,Y
          	move.w B1,B0
          	impyuu A0,B0,C
          	add C,Y
          	move.w Y1,B0
          	move.w #$0,B1
          	jcc L4
          	move.w #$1,B1
L4:
          	move.w #$1,X:(SP-2)	; to keep carry flag - clear up part of D 
	      	tfr Y0,Y
	      	add D,Y
	      	tfr Y,D
          	jcs L5   
          	move.w #$0,X:(SP-2)	; to keep carry flag - set up part of D  - used in the end test
L5: 	
          	move.l D10,X:(SP-4)	; d5
          	move.l B10,X:(SP-8)	; d14
	        move.l X:(SP-18),A	; 1          	
	        move.l X:(SP-20),B	; 2				 
          	impyuu A0,B0,C	; d10
            move.l X:(SP-16),A	; 0          	
			move.l X:(SP-22),B	; 3				 
          	impyuu B0,A0,D	; d15
          	add C,D ; d15
          	tfr D,Y
			move.l X:(SP-18),A	; 1          	
	        move.l X:(SP-22),B	; 3				 
          	move.w A1,A0
          	imacuu A0,B1,Y
			move.l X:(SP-8),C
          	add C,Y	; d15
          	move.l Y,X:(SP-8)
			move.l X:(SP-18),B		; 1
          	move.l X:(SP-20),A		; 2				 
          	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;impysu A1,B0,Y
          	impyuu A1,B0,Y
          	imacuu A0,B1,Y
          	move.l X:(SP-16),B	; 0          	
	        move.l X:(SP-22),A	; 3
	        tfr A,C
          	imacuu B0,C1,Y
			move.l X:(SP-22),A	; 3
          	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;imacus A0,B1,Y
          	imacuu A0,B1,Y
          	asll.l #$10,Y
			move.l X:(SP-8),D
			bfclr #$01,SR
          	add D,Y	; Y = d4
			move.l X:(SP-4),A
			move.w X:(SP-2),B0	
			bftsth #$0001,B0	
          	jcc L6
          	move.l #$1,C
          	add C,Y
L6:
			tfr Y,B
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;sxt.l B
          	;zxt.b B,B
			suba       #<14,SP
		
          	rts     
end_FARTMULULL64:
	
	ENDSEC


