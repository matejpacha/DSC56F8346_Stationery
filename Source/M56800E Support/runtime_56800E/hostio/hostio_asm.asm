

; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.

   
;  
;  LDM == denotes code that Large Data Model will affect 
;


 
;
;  void __debugger_file_write(void)	

;  void __debugger_con_write(void)	

;  int __debugger_open(const char* name, 
;                      __file_modes mode)

;  int __debugger_close(int handle)

;  int __debugger_seek(int handle)

;  int __debugger_read(int handle, 
;                      unsigned char *buffer,  
;                      size_t *count);

;  int __put_char_dbg_console(int c)

;  void __flush_console(void)

;  int __debugger_read(int handle, 
;                	   unsigned char *buffer,  
;                	   size_t *count);


; --------------------------------------
 



consolebufsiz	equ 256
newln			equ $0A
lnfeed			equ $0D
stdoutHandle	equ 1

SVC_WRITE		equ 1
SVC_READ  		equ 2
SVC_OPEN		equ 3
SVC_CLOSE		equ 4
SVC_SEEK 		equ 5
	
	section rtlib
	org x:
	
STDOUTBufferCount: 	dc	0
FileBuffersize:		dc 	1
	
	org xl:
STDOUTBuffer:		ds	consolebufsiz
	
	org p:

	global F__debugger_file_write
	global F__debugger_con_write
	global F__debugger_open
	global F__debugger_close
	global F__debugger_seek
	global F__debugger_read
	global F__put_char_dbg_console
	global F__flush_console
	global Fexit_hsst_hostio  




	
 ; ----------------------------------------------------------

 ; void exit_hsst_hostio(void)	
 ; not used in bp-hostio but defined since referenced
 ; inside exit_halt() in exit_dsp.asm	

 ;---------------------------------------------------------- 
	SUBROUTINE "Fexit_hsst_hostio",Fexit_hsst_hostio,Fexit_hsst_hostioEND-Fexit_hsst_hostio
Fexit_hsst_hostio:
	rts
Fexit_hsst_hostioEND:	






 ; ----------------------------------------------------------
  
 ; void __debugger_file_write(void)	
  
 ;  Y0 == 16-bit handle	 				
 ;	R2 == SDM 16-bit or LDM 24-bit buffer address
 ;	R3 == SDM 16-bit or LDM 24-bit count address
  				
  															
 ; debugger uses:									
 ;   R0 == 16-bit fileHandle
 ;	 R2 == SDM 16-bit or LDM 24-bit buffer address
 ;	 R3 == SDM 16-bit or LDM 24-bit count address
 
 ;   symbol __dbg_io_ready == SVC_WRITE
  
  
 ; returned from the debugger after debug instruction:	 								
 ;    no return
 
 ;---------------------------------------------------------- 
 
	SUBROUTINE "F__debugger_file_write",F__debugger_file_write,F__debugger_file_writeEND-F__debugger_file_write
F__debugger_file_write:
	move.w  Y0,R0	                ; move Y0 handle to R0
	move.w  #SVC_WRITE,R1  	 		; setup our service message
	move.w  R1,x:F__dbg_io_ready	; stash service message LDM
	nop
 	debughlt					    ; debugger does hostio file write
	move.w  #0,x:F__dbg_io_ready  	; reset debugger signal	LDM	
	nop
	rts
F__debugger_file_writeEND:	





 ; ----------------------------------------------------------
  
 ; void __debugger_con_write(void)	
  
 ; inputs:		   								
 ;   X0 == 16-bit count hawk2-specific
 ;   R2 == 16- or 24-bit address of buffer
  						
  															
 ; debugger uses:									
 ;   R0 == 16-bit file handle: 1=stdio or file handle
 ;   R2 == SDM 16-bit or LDM 24-bit buffer address								
 ;   R3 == 16-bit count
 
 ;   symbol __dbg_io_ready == SVC_WRITE
  
  
 ; returned from the debugger after debug instruction:	 								
 ;   no return
 
 ;---------------------------------------------------------- 

	SUBROUTINE "F__debugger_con_write",F__debugger_con_write,F__debugger_con_writeEND-F__debugger_con_write
F__debugger_con_write:
	move.l  #>>stdoutHandle,R0		; tell debugger we are printf
	move.w  X0,R3				    ; move x0 to r3	
	moveu.w #SVC_WRITE,R1  			; setup our service message
	move.w  R1,x:F__dbg_io_ready	; stash it	LDM
	nop
 	debughlt						; debugger does hostio write or std out
	move.w  #0,x:F__dbg_io_ready	; reset debugger signal	LDM	
	clr.w   x:STDOUTBufferCount		; clear buffer count LDM

	nop
	rts
F__debugger_con_writeEND:	





;  ----------------------------------------------------------
  
;  int __debugger_open(const char* name, 
;                      __file_modes mode)
  
;  inputs:		   								
;    A1 == 16-bit file mode	(hawk2)			
;    R2 == 16-bit or LDM 24-bit file name address			
    		
    				 															
;  debugger uses:						
;    R2 == 16-bit or LDM 24-bit file name address			
;    R1 == 16-bit file mode	
					
;    symbol __dbg_io_ready == SVC_OPEN					
    			
    																				
;  returned from the debugger after debug instruction:	 								
;    Y0 == 16-bit file handle or 0 if error	
  															  															
; ---------------------------------------------------------- 

	SUBROUTINE "F__debugger_open",F__debugger_open,F__debugger_openEND-F__debugger_open
F__debugger_open:	
	move.w	#SVC_OPEN,R1		    	; setup our debugger signal	
	move.w	R1,x:F__dbg_io_ready   		; stash it LDM
	move.w  A1, R1
	nop                             
 	debughlt                         	; call debugger
	move.w	#0,x:F__dbg_io_ready		; reset debugger signal	LDM	
	rts
F__debugger_openEND:




;  ----------------------------------------------------------
															
;  int __debugger_close(int handle)
  	  															
;  input:				    								
;    Y0 == 16-bit file handle	 				
			
															
;  debugger uses:								
;    R0 == 16-bit file handle		
				
;    symbol __dbg_io_ready == SVC_CLOSE					
  				
  															
;  returned from the debugger after debug instruction:	 								
;    Y0 == 16-bit result value	
																		
; ---------------------------------------------------------- 

	SUBROUTINE "F__debugger_close",F__debugger_close,F__debugger_closeEND-F__debugger_close
F__debugger_close:
	move.w  Y0,R0  			      		; set R0 to file handle			
	move.w #SVC_CLOSE,R1		      	; setup our debugger signal
	move.w  R1,x:F__dbg_io_ready	  	; stash it LDM
	nop
 	debughlt                       		; call debugger
	move.w  #0,x:F__dbg_io_ready		; reset debugger signal	LDM	
	
	rts
F__debugger_closeEND:




;  ----------------------------------------------------------
															
;  int __debugger_seek(int handle)
  	
  															
;  input:				    								
;    Y0 == 16-bit file handle 				
;	 Y1 == 16-bit mode
;	 R2 == SDM 16-bit or LDM 24-bit address of long position
		
															
;  debugger uses:
;    R0 == 16-bit file handle
;    R1 == 16-bit mode								
;    R2 == SDM 16-bit or LDM 24-bit address of long position

;    __dbg_io_ready == SVC_SEEK				
  		
  															
;  returned from the debugger after debug instruction:	 								
;    Y0 == result value						
  															
; ---------------------------------------------------------- 

	SUBROUTINE "F__debugger_seek",F__debugger_seek,F__debugger_seekEND-F__debugger_seek
F__debugger_seek:	
	move.w  Y0,R0  			     		; set R0 to be file handle		
	move.w #SVC_SEEK,R1		     	    ; setup our debugger signal
	move.w  R1,x:F__dbg_io_ready	 	; stash it LDM
	move.w  Y1,R1                  		; set R1 to be seek mode
 	debughlt                      		; call debugger
	nop
	nop
	move.w  #0,x:F__dbg_io_ready     	; reset debugger signal	LDM	
	rts
F__debugger_seekEND





;  ----------------------------------------------------------
															
;  int __debugger_read(int handle, 
;                      unsigned char *buffer,  
;                      size_t *count);
  																
;  input:				    								
;    Y0 == 16-bit handle	 				
;	 R2 == SDM 16-bit or LDM 24-bit buffer address 
;	 R3 == SDM 16-bit or LDM 24-bit count address
			
															
;  debugger uses:								
;    R0 == 16-bit fileHandle
;	 R2 == SDM 16-bit or LDM 24-bit buffer address 
;	 R3 == SDM 16-bit or LDM 24-bit count address

;    symbol __dbg_io_ready == SVC_READ				
  									
  															
;  returned from the debugger after debug instruction:	 								
;    Y0 == 16-bit result					
  															
; ---------------------------------------------------------- 

	SUBROUTINE "F__debugger_read",F__debugger_read,F__debugger_readEND-F__debugger_read
F__debugger_read:               	 
	move.w  Y0,R0  			     	; for consistent interface		
	move.w  #SVC_READ,R1		    ; setup our debugger signal
	move.w  R1,x:F__dbg_io_ready	; stash it  LDM
	nop
 	debughlt                      	; call debugger
	move.w  #0,x:F__dbg_io_ready	; reset debugger signal	LDM	
	rts
F__debugger_readEND:





;-------------------------------------------

; int __put_char_dbg_console(int c)
 
; input:   
;   Y0 == 16-bit character
 
; output
;    Y0 == 16-bit return

;-------------------------------------------
	SUBROUTINE "F__put_char_dbg_console",F__put_char_dbg_console,F__put_char_dbg_consoleEND-F__put_char_dbg_console
F__put_char_dbg_console:
	cmp.w	#newln,y0				; is char a '\n'
	bne		not_newln				; if no, skip conversion
	move.w	#lnfeed,y0				; if yes, convert it to a line feed
not_newln:
	move.l	#>>STDOUTBuffer,r2
	move.w	x:STDOUTBufferCount,x0	; get # words in buffer LDM
	move.w	x0,n					; get # words in buffer
	nop
	move.w	y0,x:(r2+n)				; store char
	
	move.w	n,x0
	
	inc.w	x0		 				; increment word count
	
	cmp.w	#lnfeed,y0				; is char a '\r'
	jeq		flush_console1		    	; if yes, flush
	
	cmp.w	#consolebufsiz,x0		; is buffer full?
	
	blt		putc_branch1
flush_console1:
	jsr	    F__debugger_con_write	; R2 == 16-bit buffer address
	clr.w	x0						; X0 == 16-bit count 
putc_branch1:
	move.w	x0,x:STDOUTBufferCount	; LDM
	rts
F__put_char_dbg_consoleEND:





 
;-------------------------------------------
;  void __flush_console(void)
 
 
;  output to _debugger_write:

;    X0 == 16-bit count (16-bit limit okay for console)
;    R2 == SDM 16-bit or LDM 24-bit buffer address
;    R0 == 16-bit "stdout file handle" which is 1

;-------------------------------------------

	SUBROUTINE "F__flush_console",F__flush_console,F__flush_consoleEND-F__flush_console
F__flush_console:
	move.w	x:STDOUTBufferCount,X0	; move the count to X0 LDM
	
	cmp.w	#0,x0					; if no zero count
	
	beq     _allDone                ; then all done
    move.l	#>>STDOUTBuffer,R2		; now stash the buffer address in R2	
	jsr		F__debugger_con_write   ; then jump to our console write
_allDone:
	rts		
F__flush_consoleEND:	

	endsec
	
	end