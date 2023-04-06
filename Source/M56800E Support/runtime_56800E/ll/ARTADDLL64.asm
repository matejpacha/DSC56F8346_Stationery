


; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.





; SECTION: the long long code
	SECTION	ll_engine
	
	OPT	CC
	GLOBAL	ARTADDLL64
	GLOBAL  ARTSUBLL64
	GLOBAL	FARTADDLL64
	GLOBAL  FARTSUBLL64
	
	GLOBAL  ARTADDULL64
	GLOBAL  ARTSUBULL64
	GLOBAL  FARTADDULL64
	GLOBAL  FARTSUBULL64
	
	
	
	
;===============================================================================
; FUNCTION: ARTSUBF64U
; DESCRIPTION: Long long subtract.
;
; INPUT: a = x, b = y
; OUTPUT: a = result = x - y
;
ARTSUBLL64:
FARTSUBLL64:
ARTSUBULL64:
FARTSUBULL64:
		; compute -b
              move.l	  X:(SP-8),A
              neg         A
              dec.l       A

              move.l	  X:(SP-6),B
              neg         B
              dec.l       B
			  
              move.l 	 #>>1,Y
              add 		 Y,A
              move.l     #>>0, Y
              adc        Y,B

		; result = a+(-b)
              move.l      X:(SP-4),Y
              add         Y,A
              move.l      X:(SP-2),Y
              adc         Y,B
              
              rts         

;===============================================================================
; FUNCTION: ARTADDLL64
; DESCRIPTION: long long add.
;
; INPUT: a = x, b = y
; OUTPUT: a = x + y
;
ARTADDLL64:
FARTADDLL64:
ARTADDULL64:
FARTADDULL64:
              move.l      X:(SP-4),Y
              move.l      X:(SP-8),A
              add         Y,A
              move.l      X:(SP-2),Y
              move.l      X:(SP-6),B
              adc         Y,B
              rts         
end_FARTADDLL64:

	
	ENDSEC