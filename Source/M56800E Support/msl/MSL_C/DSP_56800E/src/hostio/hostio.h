/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2005/12/12 23:05:27 $
 *  $Revision: 1.10 $
 */


/*
    
    DSP56800E-specific
    
    style notes:
      tab = 4 spaces
      two lines between prototypes
      seven lines between functions
    
   --------------------------------------
 */

 
//---------------------------------------------------------------------
// $Log: hostio.h,v $
// Revision 1.10  2005/12/12 23:05:27  cgalvan
// Changing Copyright to Freescale Corp.
//
// Revision 1.9  2005/12/09 02:06:01  cgalvan
// Changing Copyright to Freescal Corp.
//
// Revision 1.8  2004/01/26 21:32:52  ceciliar
// Updating 2003 Copyright to 2004 in MSL 10
//
// Revision 1.7  2003/04/03 18:42:27  ceciliar
// added changes from msl_core_2
//
// Revision 1.6  2003/01/13 15:24:10  ceciliar
// updated Copyright © 1995-200
//
// Revision 1.5  2002/08/05 20:01:55  ceciliar
// added from msl_core_1 version 1.1.2.4
//
// Revision 1.4  2002/07/09 18:32:52  ceciliar
// added version 1.1.2.3  from the msl_core_1 Branch
//
// Revision 1.1.2.3  2002/07/08 21:50:02  arden
// R2 b2024: updated copyright and MW info per MSL specs
//
// Revision 1.1.2.2  2002/06/28 16:20:54  arden
// R2 b2019: formatting and extra comment changes
//
// Revision 1.1  2001/04/04 20:26:09  arden
// dsp56800E_msl_update_010404 prep: added
//
//	
//---------------------------------------------------------------------
 
 

#include <size_t.h>
#include <stdio.h>



// macros
#define	consolebufsiz	256		// size of output buffer
#define	newln	        0x0A	// ASCII for '\n'	
#define	lnfeed	        0x0D 	// ASCII for '\r'	
#define stdoutHandle 1
#define stderrHandle 2

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




// prototypes 
// functions required from MSL 

int	__open_file(const char * name, 
                __file_modes mode, 
                __file_handle *handle);


int	__close_file(__file_handle handle);


int __write_file(__file_handle handle, 
                 unsigned char * buffer,  
                 size_t *count, 
                 __idle_proc idle_proc);


int __read_file(__file_handle handle, 
                unsigned char *buffer,  
                size_t *count, 
                __idle_proc idle_proc);


int	__position_file(__file_handle handle, 
                    fpos_t *position, 
                    int mode, 
                    __idle_proc idle_proc);


void __flush_console(void);
void __console_write(void);





// debugger interface 

extern int __debugger_open(const char* name,
                           __file_modes mode);


extern int __debugger_close(int handle);


extern int __debugger_read(int handle, 
                           unsigned char *buffer,  
                           size_t *count);


extern int __debugger_seek(int handle, 
                           unsigned long *position, 
                           int mode);


extern void __debugger_file_write(int handle, 
                	 	          unsigned char *buffer,  
                	 	          size_t *count);
                	 	   





