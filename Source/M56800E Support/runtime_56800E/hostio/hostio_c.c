/* --------------------------------------
; Copyright ©2001 Freescale Corporation.  All rights reserved.
;  DSP56800E
;
;  console_dbg.asm
; 	
;      
;  style notes:
;    tab = 4 spaces
;    two lines between prototypes
;    seven lines between functions
;  
*/


#include <hostio.h>


extern int __dbg_io_ready;
char STDOUTBuffer[consolebufsiz];   // STDOUT buffer
int STDOUTBufferCount;              // STDOUT count -- 16-bit limit okay for console
extern int txtbinFlag;
extern int savedTxtBinFlag;

	
	
 /* 
 ; ----------------------------------------------------------
  
 ; void __debugger_file_write(void)	
  
 ;  Y0 == 16-bit handle	 				
 ;	R2 == 16-bit pointer to buffer
 ;	R3 == 16-bit pointer to count
  															
 ; debugger uses:									
 ;   R0 == 16-bit fileHandle
 ;   R1 == binary/text flag
 ;	 R2 == 16-bit pointer to buffer
 ;	 R3 == 16-bit pointer to count
 ;   symbol __dbg_io_ready == SVC_WRITE
  
 ; returned from the debugger after debug instruction:	 								
 ;  no return
 ;---------------------------------------------------------- 
 */
 
//asm void __debugger_file_write(int handle, 
//                	 	       unsigned char *buffer,  
//                	 	       size_t *count)
asm void __debugger_file_write()
{  
	move.w  Y0,R0	                // move Y0 handle to R0
	moveu.w #SVC_WRITE,R1  	 		// setup our service message
	move.w  R1,__dbg_io_ready	    // stash service message LMM
	move.w  txtbinFlag,x0	   	    // setup txt/bin tag  	LMM
	move.w  x0,r1	   				// setup txt/bin tag  	
	nop
 	debughlt					    // debugger does hostio write or std out
	move.w  #0,__dbg_io_ready  	    // reset debugger signal	LMM	
	nop
	rts
}	




/*
 ; ----------------------------------------------------------
  
 ; void __debugger_con_write(void)	
  
 ; inputs:		   								
 ;   X0 == 16-bit count hawk2-specific
 ;   R2 == 16-bit address of buffer
  															
 ; debugger uses:									
 ;   R3 == 16-bit count
 ;   R2 == 16-bit pointer to buffer 									
 ;   R0 == 16-bit file handle: 1=stdio or file handle
 ;   symbol __dbg_io_ready == SVC_WRITE
  
 ; returned from the debugger after debug instruction:	 								
 ;   no return
 ;---------------------------------------------------------- 
*/

//asm void __debugger_con_write(unsigned char *buffer,  
//                              size_t *count)
asm void __debugger_con_write()
{
	move.l  #>>stdoutHandle,R0		// tell debugger we are printf
	move.w  X0,R3				    // move x0 to r3	
	moveu.w #SVC_WRITE,R1  			// setup our service message
	move.w  R1,__dbg_io_ready	    // stash it	LMM
	nop
 	debughlt						// debugger does hostio write or std out
	move.w  #0,__dbg_io_ready       // reset debugger signal	LMM	
	move.w  #0,STDOUTBufferCount    // clear buffer count LMM	
	nop
	rts
}





/*
;  ----------------------------------------------------------
  
;  int __debugger_open(const char* name, 
;                      __file_modes mode)
  
;  inputs:		   								
;    A1 == 16-bit file mode	(hawk2)			
;    R2  == 16-bit pointer to file name			
    				 															
;  debugger uses:						
;    R2 == 16-bit pointer to file name			
;    R1 == 16-bit file mode						
;    symbol __dbg_io_ready == SVC_OPEN					
    																				
;  returned from the debugger after debug instruction:	 								
;    Y0 == 16-bit file handle or 0 if error	
  															  															
; ---------------------------------------------------------- 
*/


/*int ___debugger_open(const char* name, void mode);*/

/*int __debugger_open(const char* name, 
                    __file_modes mode)
{
	___debugger_open(name,  mode);
}*/




//asm int __debugger_open(const char* name/*,
//                         __file_modes mode*/)
asm int __debugger_open()
{
	moveu.w	#SVC_OPEN,R1		    // setup our debugger signal	
	move.w	R1,__dbg_io_ready   	// stash it LMM
	move.w  A1, R1
	nop                             
 	debughlt                        // call debugger
	move.w	#0,__dbg_io_ready		// reset debugger signal	LMM	
	rts
}




/*
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
*/

//asm int __debugger_close(int handle)
asm int __debugger_close()
{
	move.w  Y0,R0  			      		// set R0 to file handle			
	moveu.w #SVC_CLOSE,R1		      	// setup our debugger signal
	move.w  R1,__dbg_io_ready	  	// stash it LMM
	nop
 	debughlt                       		// call debugger
	move.w  #0,__dbg_io_ready		// reset debugger signal	LMM	

	rts
}





/*
;  ----------------------------------------------------------
															
;  int __debugger_seek(int handle)
  	
  															
;  input:				    								
;    Y0 == file handle 				
;	Y1 == mode
;	R2 == pointer to long position
															
;  debugger uses:
;    R2 == pointer to long position
;    R1 == mode								
;    R0 == file handle
;    __dbg_io_ready == SVC_SEEK				
  															
;  returned from the debugger after debug instruction:	 								
;    Y0 == result value						
*/
  															
asm int __debugger_seek()
{	
	move.w  Y0,R0  			     		// set R0 to be file handle		
	moveu.w #SVC_SEEK,R1		     	// setup our debugger signal
	move.w  R1,__dbg_io_ready	 	    // stash it LMM
	move.w  Y1,R3                  		// set R1 to be seek mode
	move.w  txtbinFlag,x0	        	// setup txt/bin tag  LMM          
	move.w  X0,R1       				// setup txt/bin tag           
	nop
 	debughlt                      		// call debugger
	move.w  #0,__dbg_io_ready     	    // reset debugger signal	LMM	
	rts
}




/*
;  ----------------------------------------------------------
															
;  int __debugger_read(int handle, 
;                      unsigned char *buffer,  
;                      size_t *count);
  																
;  input:				    								
;    Y0 == 16-bit handle	 				
;	 R2 == 16-bit pointer to buffer
;	 R3 == 16-bit pointer to count
															
;  debugger uses:								
;    R0 == 16-bit fileHandle
;    R1 == binary/text flag
;	 R2 == 16-bit pointer to buffer
;	 R3 == 16-bit pointer to count
;    symbol __dbg_io_ready == SVC_READ				
  															
;  returned from the debugger after debug instruction:	 								
;    Y0 == 16-bit result					
  															
; ---------------------------------------------------------- 
*/


//asm int __debugger_read(int handle, 
//                         unsigned char *buffer,  
//                         size_t *count)
asm int __debugger_read()
{               	 
	move.w  Y0,R0  			     	// for consistent interface		
	moveu.w #SVC_READ,R1		    // setup our debugger signal
	move.w  R1,__dbg_io_ready	    // stash it  LMM
	move.w  txtbinFlag,X0      	    // setup txt/bin tag  LMM	
	move.w  X0,R1			       	// setup txt/bin tag  	
	nop
 	debughlt                      	// call debugger
	move.w  #0,__dbg_io_ready	    // reset debugger signal	LMM	
	rts     
}



/*
;-------------------------------------------

; int __put_char_dbg_console(int c)
 
; input:   
; Y0 == 16-bit character
 
; output
; Y0 == 16-bit return

;-------------------------------------------
*/
asm int __put_char_dbg_console(int c)
{
	cmp.w	#newln,y0				// is char a '\n'
	bne		not_newln				// if no, skip conversion
	move.w	#lnfeed,y0				// if yes, convert it to a line feed
not_newln:
	move.l	#>>STDOUTBuffer,r2
	move.w	STDOUTBufferCount,x0	// get # words in buffer LMM
	move.w	x0,n					// get # words in buffer
	nop
	move.w	y0,x:(r2+n)				// store char
	
	move.w	n,x0
	
	inc.w	x0		 				// increment word count
	
	cmp.w	#lnfeed,y0				// is char a '\r'
	jeq		flush_console1		    // if yes, flush
	
	cmp.w	#consolebufsiz,x0		// is buffer full?
	
	blt		putc_branch1
flush_console1:
	jsr	    __debugger_con_write	// R2 == 16-bit buffer address
	clr.w	x0						// X0 == 16-bit count 
putc_branch1:
	move.w	x0,STDOUTBufferCount	// LMM
	rts
}





/*
;-------------------------------------------
;  void __flush_console(void)
 
;  output to _debugger_write:
;    X0 == 16-bit count (16-bit limit okay for console)
;    R2 == 16-bit pointer to the buffer
;   R0 == 16-bit "stdout file handle" which is 1

;-------------------------------------------
*/

asm void __flush_console()
{
	move.w	STDOUTBufferCount,X0	// move the count to X0 LMM
	
	cmp.w	#0,x0					// if no zero count
	
	beq     _allDone                // then all done
    move.l	#>>STDOUTBuffer,R2		// now stash the buffer address in R2	
	jsr		__debugger_con_write    // then jump to our console write
_allDone:
	rts		
}