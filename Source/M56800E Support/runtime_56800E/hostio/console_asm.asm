
; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.

;
; 	Routines
; 	--------
; 		F__console_write
;		Ffflush_console
;		F__dbg_put_char
; 
;   020624 now uses __dbg_io_ready



bufsiz		equ	80	; size of output buffer
newln		equ	$0A	; ASCII for '\n'
lnfeed		equ $0D ; ASCII for '\r'
SVC_WRITE		equ 1



	section		rtlib
	org	x:

STDOUTBufferCount: 	dc	0

	org	xl:
STDOUTBuffer:		ds	bufsiz
STDINBuffer:		ds	bufsiz
 	
	org p:
 	
 ;-------------------------------------------------------------------
 ; F_console_write - When the console buffer is flushed
 ;                   this routine will be called. From here, we will
 ;					hault the process and print the buffer to the
 ;					debugger window
 ;
 ; inputs:		   								
 ;   X0 == 16-bit count hawk2-specific
 ;   R2 == 16- or 24-bit address of buffer
  						
  															
 ; debugger uses:									
 ;   R0 == 16-bit file handle: 1=stdio or file handle
 ;   R2 == SDM 16-bit or LDM 24-bit buffer address								
 ;   R3 == 16-bit count
 
 ;   symbol __dbg_io_ready == SVC_WRITE
 
 ;--------------------------------------------------------------------

	global F__console_write
	SUBROUTINE "F__console_write",F__console_write,F__console_writeEND-F__console_write
 F__console_write:
	move.l  #>>1,R0		            ; tell debugger we are printf
	move.w	X0,R3
	moveu.w #SVC_WRITE,R1  			; setup our service message
	move.w	R1,x:F__dbg_io_ready	; LMM
	nop
 	debughlt
	move.w  #0,x:F__dbg_io_ready	; reset debugger signal	LDM	
	nop

 	rts
 F__console_writeEND:
 
 
 
 
;-------------------------------------------------------------------
; fflush_console( ) - move the output buffer to the console
;
; Parameters:
;	none
;-------------------------------------------------------------------
	global	Ffflush_console
	SUBROUTINE "Ffflush_console",Ffflush_console,Ffflush_consoleEND-Ffflush_console
Ffflush_console:
	move.l	#STDOUTBuffer,r2		;LMM
	move.w	x:STDOUTBufferCount,x0	;LMM number of characters in buffer
	cmp.w	#0,x0
	bgt		flush_buf
	nop
	rts
Ffflush_consoleEND:





;-------------------------------------------------------------------
; F__dbg_put_char( int c )  - print a character to stdout
;
; Parameters:
;  c		passed in y0
;
;-------------------------------------------------------------------
	global	F__dbg_put_char
	SUBROUTINE "F__dbg_put_char",F__dbg_put_char,F__dbg_put_charEND-F__dbg_put_char
F__dbg_put_char:
	cmp.w	#newln,y0				; is char a '\n'
	bne		not_newln				; if no, skip conversion
	move.w	#$0d,y0					; if yes, convert it to a line feed
not_newln:
	move.l	#STDOUTBuffer,r2		; LMM
	move.w	x:STDOUTBufferCount,x0	; LMM get # words in buffer
	move.w	x0,n
	move.w	y0,x:(r2+n)				; store char
	move.w	n,x0
	inc.w	x0		 				; increment word count
	cmp.w	#lnfeed,y0				; is char a '\r'
	beq		flush_buf				; if yes, flush
	cmp.w	#bufsiz,x0				; is buffer full?
	blt		putc_branch1
flush_buf:
									; address of buffer in r2
									; Count in X0
	jsr	F__console_write			; output via debugger interface
	move.w 	#0,x0					; clear buffer count	
putc_branch1:
	move.w	x0,x:STDOUTBufferCount	; LMM
	rts 	
F__dbg_put_charEND:	
	
	
 	
 	endsec