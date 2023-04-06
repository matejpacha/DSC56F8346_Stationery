

PROFILE_ENTRY_CMD	EQU 1
PROFILE_EXIT_CMD	EQU 2
PROFILE_DUMP_CMD	EQU 3
PROFILE_CLEAR_CMD	EQU 4
PROFILE_FUNC_NAME_CMD EQU 5
TRACE_ADD_CMD		EQU 6
TRACE_CLEAR_CMD		EQU 7

ORX					EQU $FFFFFE

RX_REG_IPL			EQU $30

	section		rtlib
	
	XREF FgRTDTProfLastReadTime
	XREF FgRTDTProfilerStatus
	XREF FgRTDTTraceStatus
	XREF FgRTDTProfilerDone
	XREF FRTDT_ProfilerGetTime
	XREF FRTDT_Send
	XREF FgIPR1
	XREF FgTxReady
	
	org p:
 	
 	global PROFILE_ENTRY
	global PROFILE_EXIT
	global FRTDT_ProfilerDump
	global FRTDT_ProfilerClear
	global FRTDT_TraceClear
	global FRTDT_HandleFuncNameRequest

	SUBROUTINE "PROFILE_ENTRY",PROFILE_ENTRY,PROFILE_ENTRY_END-PROFILE_ENTRY
	SUBROUTINE "PROFILE_EXIT",PROFILE_EXIT,PROFILE_EXIT_END-PROFILE_EXIT
	SUBROUTINE "FRTDT_ProfilerDump",FRTDT_ProfilerDump,FRTDT_ProfilerDump_END-FRTDT_ProfilerDump
	SUBROUTINE "FRTDT_ProfilerClear",FRTDT_ProfilerClear,FRTDT_ProfilerClear_END-FRTDT_ProfilerClear
	SUBROUTINE "FRTDT_TraceClear",FRTDT_TraceClear,FRTDT_TraceClear_END-FRTDT_TraceClear
	SUBROUTINE "FRTDT_HandleFuncNameRequest",FRTDT_HandleFuncNameRequest,FRTDT_HandleFuncNameRequest_END-FRTDT_HandleFuncNameRequest

 PROFILE_ENTRY:
; R2 has pointer to function name

; save registers
	adda	#10,SP
	move.w 	y0,X:(SP)
	move.w 	A2,X:(SP-1)
	move.l 	r1,X:(SP-2)
	move.l	r2,X:(SP-4)
	move.l	A10, X:(SP-6)
	move.l	B10, X:(SP-8)

	jsr		FRTDT_ProfilerGetTime
; check trace status
	move.w	X:FgRTDTTraceStatus,A
	tst.w	A
	beq		profiler_status_check_entry
; get return address and send it to host
	adda	#-11,SP,R1
	adda	#1,SP,R2
	adda	#8,SP
	move.l	#TRACE_ADD_CMD,A
	move.l	A10,X:(R2)
	move.w	X:(R1+1),A1
	lsrr.w	#10,A
	bfclr	#$ffe0,A
	move.w	X:(R1),A0
	sub.l	#6,A
	move.l	A10,X:(R2+2)
	move.l	#FgRTDTProfLastReadTime,R1
	move.l	X:(R1)+,A
	move.l	A10,X:(R2+4)
	move.l	X:(R1),A
	move.l	A10,X:(R2+6)
	move.w	#4,Y0
	jsr		FRTDT_Send
	suba	#8,SP

profiler_status_check_entry:
	move.w	X:FgRTDTProfilerStatus,A
	tst.w	A
	beq		done_entry
; send func name ptr, SP, and curr time to host
	adda	#-12,SP,R1
	adda	#1,SP,R2
	adda	#10,SP
	move.l	#PROFILE_ENTRY_CMD,A
	move.l	A10,X:(R2)
	move.l	X:(SP-14),A
	move.l	A10,X:(R2+2)
	move.l	R1,X:(R2+4)
	move.l	#FgRTDTProfLastReadTime,R1
	move.l	X:(R1)+,A
	move.l	A10,X:(R2+6)
	move.l	X:(R1),A
	move.l	A10,X:(R2+8)
	move.w	#5,Y0
	jsr		FRTDT_Send
	suba	#10,SP
	
done_entry:
; restore registers
	move.l	X:(SP-8), B
	move.l	X:(SP-6), A
	move.l	X:(SP-4),r2
	move.l	X:(SP-2),r1
	move.w	X:(SP-1),A2
	suba	#10,SP
 	rts
 	
 PROFILE_ENTRY_END:


 PROFILE_EXIT:
 ; save registers
	adda	#10,SP
	move.w 	y0,X:(SP)
	move.w 	A2,X:(SP-1)
	move.l 	r1,X:(SP-2)
	move.l	r2,X:(SP-4)
	move.l	A10, X:(SP-6)
	move.l	B10, X:(SP-8)

	jsr		FRTDT_ProfilerGetTime
; check trace status
	move.w	X:FgRTDTTraceStatus,A
	tst.w	A
	beq		profiler_status_check_exit
; get return address and send it to host
	adda	#-11,SP,R1
	adda	#1,SP,R2
	adda	#8,SP
	move.l	#TRACE_ADD_CMD,A
	move.l	A10,X:(R2)
	move.w	X:(R1+1),A
	lsrr.w	#10,A
	bfclr	#$ffe0,A
	move.w	X:(R1),A0
	move.l	A10,X:(R2+2)
	move.l	#FgRTDTProfLastReadTime,R1
	move.l	X:(R1)+,A
	move.l	A10,X:(R2+4)
	move.l	X:(R1),A
	move.l	A10,X:(R2+6)
	move.w	#4,Y0
	jsr		FRTDT_Send
	suba	#8,SP

profiler_status_check_exit:
	move.w	X:FgRTDTProfilerStatus,A
	tst.w	A
	beq		done_exit
; send func name ptr, SP, and curr time to host
	adda	#1,SP,R2
	adda	#6,SP
	move.l	#PROFILE_EXIT_CMD,A
	move.l	A10,X:(R2)
	move.l	#FgRTDTProfLastReadTime,R1
	move.l	X:(R1)+,A
	move.l	A10,X:(R2+2)
	move.l	X:(R1),A
	move.l	A10,X:(R2+4)
	move.w	#3,Y0
	jsr		FRTDT_Send
	suba	#6,SP
	
done_exit:
; restore registers
	move.l	X:(SP-8), B
	move.l	X:(SP-6), A
	move.l	X:(SP-4),r2
	move.l	X:(SP-2),r1
	move.w	X:(SP-1),A2
	suba	#10,SP
 	rts
 PROFILE_EXIT_END:
 
 
 FRTDT_ProfilerDump:
 ; R2 has pointer to file name 
 
 ; save registers
 	adda	#12,SP
	move.w 	y0,X:(SP)
	move.w 	y1,X:(SP-1)
	move.l 	r1,X:(SP-2)
	move.l 	r2,X:(SP-4)
	move.l	r3,X:(SP-6)
	move.l	A10, X:(SP-8)
	move.l	B10, X:(SP-10)
	
	clr.w	X:FgRTDTProfilerDone
 
 	tfra	R2,R1
 	
 ; reserve stack space
	adda	#1,SP,R2
	adda	#4,SP
	
; prepare to copy string
	adda	#4,R2,R3
	clr.w	Y0
	clr		A
dump_strcpy_begin:
	move.bp	X:(R1)+,Y1
	tst.b	Y1
	beq		dump_strcpy_end
	asll.w	#8,Y1
	lsrr.l	#8,A
	or.w	Y1,A
	inc.w	Y0
	bftstl	#3,Y0
	bcc		dump_strcpy_begin
	adda	#2,SP
	move.l	A10,X:(R3)+
	clr		A
	bra		dump_strcpy_begin
	
dump_strcpy_end:
	brclr	#3,Y0,dump_strcpy_done
	lsrr.l	#8,A
	brset	#1,Y0,dump_test_bit_1
	lsrr.l	#8,A
	bra		dump_strcpy_finish
dump_test_bit_1:
	brset	#2,Y0,dump_strcpy_finish
	lsrr.l	#16,A
	
dump_strcpy_finish:
	adda	#2,SP
	move.l	A10,X:(R3)+
	
dump_strcpy_done:
	move.l	#PROFILE_DUMP_CMD,A
	move.l	A10,X:(R2)
	move.w	Y0,X:(R2+2)
	move.w	#0,X:(R2+3)

; calculate buffer size in longs
	add.w	#11,Y0
	lsrr.w	#2,Y0
	
	jsr		FRTDT_Send
	
; restore stack
	adda	#-1,R2,SP
	
; wait for buffer to clear
wait_for_buffer_to_clear:
	tst.w	X:FgTxReady
	beq		wait_for_buffer_to_clear
 
 ; restore registers
 	move.l	X:(SP-10), B
	move.l	X:(SP-8), A
	move.l	X:(SP-6),r3
	move.l	X:(SP-4),r2
	move.l	X:(SP-2),r1
	move.w	X:(SP-1),y1
	move.w	X:(SP),y0
	suba	#12,SP
	rts
 FRTDT_ProfilerDump_END:
 
 
 FRTDT_ProfilerClear:
 ; save registers
	adda	#6,SP
	move.w 	y0,X:(SP)
	move.l	r2,X:(SP-2)
	move.l	A10, X:(SP-4)

	adda	#1,SP,R2
	adda	#2,SP
	move.l	#PROFILE_CLEAR_CMD,A
	move.l	A10,X:(R2)
	move.w	#1,Y0
	jsr		FRTDT_Send
	suba	#2,SP

; restore registers
	move.l	X:(SP-4), A
	move.l	X:(SP-2),r2
	move.w	X:(SP),y0
	suba	#6,SP
	rts
 FRTDT_ProfilerClear_END:
 
 
 FRTDT_TraceClear:
 ; save registers
	adda	#6,SP
	move.w 	y0,X:(SP)
	move.l	r2,X:(SP-2)
	move.l	A10, X:(SP-4)

	adda	#1,SP,R2
	adda	#2,SP
	move.l	#TRACE_CLEAR_CMD,A
	move.l	A10,X:(R2)
	move.w	#1,Y0
	jsr		FRTDT_Send
	suba	#2,SP

; restore registers
	move.l	X:(SP-4), A
	move.l	X:(SP-2),r2
	move.w	X:(SP),y0
	suba	#6,SP
	rts
 FRTDT_TraceClear_END:
 
 
 FRTDT_HandleFuncNameRequest:
	cmp.l	#$FFFFFFFF,A
	bne		get_pointer
	move.w	#1,X:FgRTDTProfilerDone
	rts
; get the pointer from A
get_pointer:
	move.l	A10, R1
	
; reserve stack space
	adda	#1,SP,R2
	adda	#4,SP
	
; prepare to copy string
	adda	#4,R2,R3
	clr.w	Y0
	clr		A
strcpy_begin:
	move.bp	X:(R1)+,Y1
	tst.b	Y1
	beq		strcpy_end
	asll.w	#8,Y1
	lsrr.l	#8,A
	or.w	Y1,A
	inc.w	Y0
	bftstl	#3,Y0
	bcc		strcpy_begin
	adda	#2,SP
	move.l	A10,X:(R3)+
	clr		A
	bra		strcpy_begin
	
strcpy_end:
	brclr	#3,Y0,strcpy_done
	lsrr.l	#8,A
	brset	#1,Y0,test_bit_1
	lsrr.l	#8,A
	bra		strcpy_finish
test_bit_1:
	brset	#2,Y0,strcpy_finish
	lsrr.l	#16,A
	
strcpy_finish:
	adda	#2,SP
	move.l	A10,X:(R3)+
	
strcpy_done:
	move.l	#PROFILE_FUNC_NAME_CMD,A
	move.l	A10,X:(R2)
	move.w	Y0,X:(R2+2)
	move.w	#0,X:(R2+3)

; calculate buffer size in longs
	add.w	#11,Y0
	lsrr.w	#2,Y0
	
	jsr		FRTDT_Send
	
; restore stack
	adda	#-1,R2,SP
	
	rts

 FRTDT_HandleFuncNameRequest_END:
 
 	endsec
 	
	end
