

/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/

/*    
    DSP56800x-specific
    
    style notes:
      tab = 4 spaces
      two lines between prototypes
      seven lines between functions
      
    
   --------------------------------------
 */
 
 
 
#include <size_t.h>
#include <stdio.h>

// macros
#define	consolebufsiz	256		// size of output buffer
#define	newln	        0x0A	// ASCII for '\n'	
#define	lnfeed	        0x0D 	// ASCII for '\r'	
#define stdoutHandle    1


// service codes
#define SVC_WRITE 	1
#define SVC_READ	2
#define SVC_OPEN    3
#define SVC_CLOSE	4
#define SVC_SEEK	5


// beginning of encapsulated r/w housekeeping overhead
// anytime we call a r/w function (like fflush)
// from inside another r/w, we want to preserve info.
// at the moment, we just save the text/binary flag
// later this will be expanded for future scenarios
#define enterRW  savedTxtBinFlag = txtbinFlag;
#define exitRW   txtbinFlag = savedTxtBinFlag;





// debugger interface 


void __debugger_file_write(int handle, 
                	 	   unsigned char *buffer,  
                	 	   size_t *count);
       
void __debugger_con_write(unsigned char *buffer,  
                          size_t *count);
                                                           
int __debugger_open(const char* name, 
                     __file_modes mode);

int __debugger_close(int handle);

int __debugger_seek(int handle, 
                    unsigned long *position, 
                    int mode);

int __debugger_read(int handle, 
                    unsigned char *buffer,  
                    size_t *count);

int __put_char_dbg_console(int c);

void __flush_console(void);

int __debugger_read(int handle, 
                	unsigned char *buffer,  
                	size_t *count);

                	 	   


