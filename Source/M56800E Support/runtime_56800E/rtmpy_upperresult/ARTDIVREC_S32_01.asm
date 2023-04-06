
 
	section		rtlib
	org p:
 	
	global ARTDIVREC_U32
	global FARTDIVREC_U32

	global ARTDIVREC_S32
	global FARTDIVREC_S32

	global ARTDIVREC_S16
	global FARTDIVREC_S16

	global ARTDIVREC_U16
	global FARTDIVREC_U16




ARTDIVREC_S16:
FARTDIVREC_S16:
		; y0 has signed 16 bit number
		; a contains signed 32 bit magic number
		;
		; 	multiply signed-signed		y0, a1
	
	IMPY.l a1,y0,b
	move.w y0,a1

		; a1 contains signed 16 bit number
		; a0 contains unsigned lower 16bits of 32-bit magic number
		;	
		;	multiply signed-unsigned	a1, a0
	IMPYSU a1,a0,Y
	rtsd
	asr16	y,a
	ADD a,b 		
	move.w b1,y0


ARTDIVREC_U16:
FARTDIVREC_U16:
	move.w y0,b0

		; y0, b0 has unsigned 16 bit number
		; a contains signed 32 bit magic number
		;
		; 	multiply unsigned-unsigned		b0(y0), a1
		; 	multiply unsigned-unsigned		b0(y0), a0

	IMPYUU A1,B0,Y
	IMPYUU A0,B0,B
 	rtsd
	asr16 b,b
	add	   b,y
	move.w y1,y0


ARTDIVREC_S32:
FARTDIVREC_S32:
	adda	#2,sp
	move.l	c10,x:(sp)+
	move.l	d10,x:(sp)
	IMPYUU A0,B0,D	; D2:D1:D0 = unsigned A0 x unsigned B0
	LSR16 D,C		; Align upper word of first product in C
	IMPYSU A1,B0,Y	; Y1:Y0 = signed A1 x unsigned B0
	ADD Y,C			;
	ASL16 X0,Y		; Clears the 32-bit Y register
	IMACUS A0,B1,Y	; Y1:Y0 = unsigned A0 x signed B1 + Y1:Y0
	ADD Y,C			;
	ASL16 C,Y1		; Copy next 16 bits of result to D1
	MOVE.W Y1,D1	;
	ASR16 C,C
	IMAC.L A1,B1,C	; C2:C1:C0 now contain upper result
	TFR C,A

	move.l	x:(sp)-,D
	move.l	x:(sp)-,C
	
 	rts	


ARTDIVREC_U32:
FARTDIVREC_U32:

	adda	#2,sp
	move.l	c10,x:(sp)+
	move.l	d10,x:(sp)

	IMPYUU		A0,B0,D	; D2:D1:D0 = unsigned A0 x unsigned B0
	LSR16		D,C		; Align upper word of first product in C
	impyuu		A1,B0,Y	; Y1:Y0 = unsigned A1 x unsigned B0

	
	tfr A,D	
	ADD			Y,C			;
	IMPYUU	B1,D0,Y
	
	nop

	add	Y,C
	
	tfr	C,A
	ror.l A
	LSRR.L	#15,A
	tfr A,Y
	tfr D,A
		
	lsrr.l		#16,A
	nop
	imacuu		A0,B1,Y	; Y now contains upper result
	TFR			Y,A

	move.l	x:(sp)-,D
	move.l	x:(sp)-,C
	
	rts

 	endsec