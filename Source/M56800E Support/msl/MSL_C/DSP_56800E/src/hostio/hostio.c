/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2005/12/12 23:05:27 $
 *  $Revision: 1.13 $
 */


/* --------------------------------------

    hostio.c
 	
    DSP56800E-specific
    
    style notes:
      tab = 4 spaces
      two lines between prototypes
      seven lines between functions
    
   --------------------------------------
 */
 
 
//---------------------------------------------------------------------
// $Log: hostio.c,v $
// Revision 1.13  2005/12/12 23:05:27  cgalvan
// Changing Copyright to Freescale Corp.
//
// Revision 1.11.4.1  2005/12/12 20:55:58  cgalvan
// Changing Copyright to Freescale Corp.
//
// Revision 1.11  2004/01/26 21:32:52  ceciliar
// Updating 2003 Copyright to 2004 in MSL 10
//
// Revision 1.10  2003/01/13 15:24:10  ceciliar
// updated Copyright © 1995-2003
//
// Revision 1.9  2002/08/05 20:00:52  ceciliar
// added from msl_core_1 version 1.6.2.3
//
// Revision 1.8  2002/07/09 18:33:11  ceciliar
// added version 1.6.2.2   from the msl_core_1 Branch
//
// Revision 1.6.2.2  2002/07/08 21:50:02  arden
// R2 b2024: updated copyright and MW info per MSL specs
//
// Revision 1.6.2.1  2002/06/28 16:20:54  arden
// R2 b2019: formatting and extra comment changes
//
// Revision 1.6  2001/04/04 20:26:23  arden
// dsp56800E_msl_update_010404 prep: fix for printf overflow
//
// Revision 1.5  2001/03/21 06:45:30  arden
// R1 b1010 prep: removed prototype __debugger_con_write(void);
// (not used in this file)
//
// Revision 1.4  2001/01/30 01:50:09  arden
// dsp56800E_msl_update_010129A: fixed duplicate function name reference
//
// Revision 1.3  2001/01/22 23:58:02  arden
// dsp56800E_msl_update_010122:  more updates for 56800E (56700)
//
// Revision 1.1  2001/01/21 23:54:51  arden
// R1 b1005 prep: first commit to new module
//
// Revision 1.1  2001/01/19 22:52:07  arden
// dsp56800E R1 b1005 prep: first commit for new module
//
// Revision 1.12  2000/11/10 21:20:20  arden
// 4b1 b1010 prep: isolated newline fix and improvements for stdout
//
// Revision 1.10  2000/11/01 22:29:46  arden
// 4b1 1009 prep: some finetuning of read return, removal of unneeded funcs
//
// Revision 1.9  2000/10/31 23:38:53  arden
// 4b1 b1008 prep: improved getchar synthesis for stdio
//
// Revision 1.5  2000/10/19 06:01:03  arden
// 4b1 b1007 prep:  fixed in-document log
//
// Revision 1.4  2000/10/19 05:45:35  arden
// 4b1 b1007 prep: round two of hostio
//
// Revision 1.3  2000/10/09 15:54:55  rstjohn
// Testing of CVS
//
// Revision 1.2  2000/10/09 00:21:51  arden
// 4d1 b1004 prep:additional expansion in anticipation of first-round
// 56800 host i/o work
// 
// Revision 1.1  2000/09/28 19:44:29  rstjohn
// Added file IO
//
//	
//---------------------------------------------------------------------
 
 

#include <hostio.h>


// debugger interface 
// debugger plugin searches 
// for this variable name in the target symbols
// this variable contains the service code

int __dbg_io_ready = 0;


// only MSL knows about these variable
// which holds the text/binary flag & temp saved
// in future versions, we will handle concurrency
// reentrancy, and asynchronous scenarios

int txtbinFlag = 0;
int savedTxtBinFlag;


                	 	   




// ----------------------------------------------------------
// functions

                	 	   


// fwrite distills down to this function
// at this point, we are provided handle, buffer pointer,
// and count of elements 
// for dsp 56800, each element is 16-bits

// count is stashed in passed count address
// return currently implemented as zero return

int __write_file(__file_handle handle, 
                 unsigned char *buffer,  
                 size_t *count, 
                 __idle_proc idle_proc)
{
	unsigned char *write_ptr;
	unsigned int file;
	unsigned int CharCount;
	int i;


	CharCount = *count;


	if (CharCount == 0)
		return(0);


	write_ptr = buffer;
    file = handle;


	if (file==stdoutHandle || file==stderrHandle )
	{
	
		if (CharCount > consolebufsiz)
			return(1);


		for (i=0;i<CharCount;i++)
		{
			__put_char_dbg_console(*write_ptr++);
		}
		
		
		__flush_console();
		
	    return(0);	
	}
	
	else 
    {
       // this doesn't flush the target stdio buffer
       // fflush will do it or fclose does it if buffer is not empty
       
 	    __debugger_file_write(file, 
	                          buffer, 
	                          count);	
	   return(0);
	}	
}	










int	__open_file(const char    *name,   // 16-bit address to name
                __file_modes   mode,   // the file modes
                __file_handle *handle) // 16-bit address of 32-bit file handle
{
	int hndl;                          // 16-bit handle		
	
	hndl = __debugger_open(name,       // call debugger
	                       mode);  
	                                   // 16-bit handle returned	
	if (hndl==0) return 1;             // return an error	
	*handle = hndl;                    // otherwise, stash 16-bit handle
	                                   // to the 32-bit location
	return 0;                          // return no error
}		









int __close_file(__file_handle handle)  // 16-bit file handle passed in 32-bits
{
	int hndl = handle;                  // stash 16-bit handle in 16-bit variable  
	
	if (__debugger_close(hndl) == -1) 
		return __io_error;
	}	                                    
                                       








// fread distills down to this function
// at this point, we are provided handle, buffer pointer, 
// and count of elements to read
// for dsp 56800, each element is 16-bits

// we handle host stdin loop at this function level
// and routine host file reads

int __read_file(__file_handle handle,  // 16-bit file handle passed in 32-bits 
                unsigned char *buffer, // 16-bit address of read buffer  
                size_t *count,         // 16-bit address of 16-bit count
                __idle_proc idle_proc) // no idle proc
{	
    int hndl;
	int dbgReadCount;
	int test; 
	int savetxtbinFlag;                
	                                   // anytime we call r/w routines
	                                   // from inside a r/w, we want to 
	                                   // preserve any current info.
	                                   // fflush(std) will access our flag
	enterRW                            // so we do prep housekeeping   
	fflush(stdout);	                   // flush any leftover stdout stuff
	exitRW                             // restore    
	                                                  
	             
	hndl= handle;                      // stash 16-bit handle in 16-bit variable  
	dbgReadCount = 0;                  // zero count
	
	
	
	// will optimize this for third round -- arden
	if(0==hndl)                        // check for stdin
	{                                  // if stdin, loop until we get something back
	    while(0==dbgReadCount)         // no exit; syntheizes host getchar & gets
	    {                              // optional: counter timeout escape hatch
	         dbgReadCount =
	          __debugger_read(hndl,    // 16-bit handle
	                          buffer,  // 16-bit target buffer address
                              count);  // 16-bit count address
        } 
    }
    else                               // else we are doing a one-shot host read
    {
	     dbgReadCount = 
	     __debugger_read(hndl,   
	                     buffer, 
	                     count);
	} 
	                           
	*count = dbgReadCount;              // stash the count
	
	if(dbgReadCount == 0)               // if no count, didn't read anything
	{
	  return __io_EOF;                  // make it EOF
	}
	
	return __no_io_error;               // otherwise, return no error              
}	







int __position_file(__file_handle handle,    // 32-bit handle 
                    fpos_t *position,        // 16-bit pointer to 32-bit position
                    int mode,                // 16-bit mode
                    __idle_proc idle_proc)   // not used
{
	int theReturn;						     // factored out
	int hndl = handle;					     // save handle as 16-bit
	
 	theReturn = __debugger_seek(hndl,        // call host seek
                                position,    
                                mode); 
                                      
    *position = theReturn;                   // stash the returned position
                                             
	return *position == -1 ? __io_error : __no_io_error;
}




