

TX_BUFFER_SIZE	EQU 64
TX_BUFFER_WORD_SIZE EQU 128
OTXRXSR			EQU $FFFFFD
OTX				EQU $FFFFFE
ORX				EQU $FFFFFE

TDF				EQU 2
TIE				EQU 8

TX_REG_IPL		EQU $0C
RX_REG_IPL		EQU $30

TX_ACK			EQU $54784F6B

	section		rtlib
	
	XREF FgTxBuffer
	XREF FgTxCurrPtr
	XREF FgTxLastPtr
	XREF FgTxBufferCount
	XREF FgIPR1
	XREF FgTxReady
	XREF FgRxInProgress
	XREF FgRxHandler
	
	org p:
 	
 	global FRTDT_Send
	global FOnCE_OnRxFull

	SUBROUTINE "FRTDT_Send",FRTDT_Send,FRTDT_SendEND-FRTDT_Send
	SUBROUTINE "FOnCE_OnRxFull",FOnCE_OnRxFull,FOnCE_OnRxFullEND-FOnCE_OnRxFull

 FRTDT_Send:
; R2 has pointer to data
; Y0 has integer count

; save registers
	adda	#14,SP
	move.w 	y0,X:(SP)
	move.w 	y1,X:(SP-1)
	move.l	r0,X:(SP-2)
	move.l 	r1,X:(SP-4)
	move.l 	r2,X:(SP-6)
	move.l	r3,X:(SP-8)
	move.l	A10, X:(SP-10)
	move.l	B10, X:(SP-12)

; check for room in the buffer and wait if not enough space	
	move.w	#TX_BUFFER_SIZE,B
	sub.w	X:(SP),B
check_buff_count:
	move.w	X:FgTxBufferCount,A
	cmp.w	B,A
	bhi		check_buff_count

; disable interrupt
;	bfclr	#TIE,X:>>OTXRXSR
	move.w	X:FgIPR1,Y1
	move.w	Y1,R1
	bfclr	#RX_REG_IPL,X:(R1)
	nop
	nop
	nop
	
; store current buffer count
	move.w	X:FgTxBufferCount,B
	
; copy data to transmit buffer
	add.w	Y0,X:FgTxBufferCount
	move.w	X:FgTxLastPtr,Y1
	move.w	Y1,R1
	move.l	#FgTxBuffer,R3
	adda	#TX_BUFFER_WORD_SIZE,R3
copy_to_buffer:
	move.l	X:(R2)+,A
	move.l	A10,X:(R1)+
	cmpa	R1,R3
	bne		no_wrap
; wrap the pointer
	move.l	#FgTxBuffer,R1	
no_wrap:
	dec.w	Y0
	bne		copy_to_buffer

; update variable
	move.w	R1,X:FgTxLastPtr
	
; if gTxReady is true, start transmitting
	tst.w	X:FgTxReady
	beq		do_not_transmit
	move.w	X:FgTxCurrPtr,Y1
	move.w	Y1,R1
	move.l	X:(R1)+,A
	move.l	#OTX,R0
	move.l	A10,X:(R0)
	cmpa	R1,R3
	bne		no_wrap2
	move.l	#FgTxBuffer,R1
no_wrap2:
	move.w	R1,X:FgTxCurrPtr
	dec.w	X:FgTxBufferCount
	clr.w	X:FgTxReady
	
do_not_transmit:
; enable interrupt
;	bfset	#TIE,X:>>OTXRXSR
	move.w	X:FgIPR1,Y1
	move.w	Y1,R1
	bfset	#RX_REG_IPL,X:(R1)
	
; restore registers
	move.l	X:(SP-12), B
	move.l	X:(SP-10), A
	move.l	X:(SP-8),r3
	move.l	X:(SP-6),r2
	move.l	X:(SP-4),r1
	move.l	X:(SP-2),r0
	move.w	X:(SP-1),y1
	move.w	X:(SP),y0
	suba	#14,SP
 	rts
 	
 FRTDT_SendEND:

 FOnCE_OnRxFull:
	alignsp 
 	adda	#10,SP
 	move.w	y0,X:(SP)
 	move.w	y1,X:(SP-1)
	move.l 	r1,X:(SP-2)
	move.l 	r2,X:(SP-4)
	move.l 	r3,X:(SP-6)
	move.l	A10,X:(SP-8)
	move.l	B10,X:(SP-10)

; disable interrupt
;	bfclr	#TIE,X:>>OTXRXSR
	move.w	X:FgIPR1,Y1
	move.w	Y1,R1
	bfclr	#RX_REG_IPL,X:(R1)
	nop
	nop
	nop

; check if an RTDT feature is receiving data
	tst.w	X:FgRxInProgress
	bne		call_rx_handler
; check for Tx acknowledgement
	move.l	#ORX,R1
	move.l	X:(R1), A
	move.l	#TX_ACK,B
	cmp.l	A,B
	bne		call_rx_handler
; check count
	tst.w	X:FgTxBufferCount
	bne		reload_tx
	move.w	#1,X:FgTxReady
	bra		exit
reload_tx:
; find wrap-around point	
	move.l	#FgTxBuffer,R3
	adda	#TX_BUFFER_WORD_SIZE,R3
; copy long to tx reg
	move.w	X:FgTxCurrPtr,Y1
	move.w	Y1,R1
	move.l	X:(R1)+,A
	move.l	#OTX,R2
	move.l	A10,X:(R2)
	cmpa	R1,R3
	bne		no_wrap3
	move.l	#FgTxBuffer,R1
no_wrap3:
	move.w	R1,X:FgTxCurrPtr
	dec.w	X:FgTxBufferCount
	bra		exit
	
call_rx_handler:
	tst.l	X:FgRxHandler
	beq		exit
	move.l	X:FgRxHandler,R1
	jsr		(R1)

exit:	
; enable interrupt
;	bfset	#TIE,X:>>OTXRXSR
	move.w	X:FgIPR1,Y1
	move.w	Y1,R1
	bfset	#RX_REG_IPL,X:(R1)
	
	move.l	X:(SP-10),B
	move.l	X:(SP-8),A
	move.l	X:(SP-6),r3
	move.l	X:(SP-4),r2
	move.l	X:(SP-2),r1
	move.w	X:(SP-1),y1
	move.w	X:(SP),y0
	suba	#12,SP
	move.l	X:(SP)-,SP	
 	rti
 	
 FOnCE_OnRxFullEND:
 
 	endsec
 	
	end
