



/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/





#include <hsst_hostio.h>  




short hsst_STDOUTBuffer[consolebufsiz];  // STDOUT buffer
int hsst_STDOUTBufferCount = 0;          // STDOUT count -- 16-bit limit okay for console
long hostIO_service_request;
HSST_STREAM *hsst_hostio_stream =NULL;




	
// -------------------------------------------------------------
// HSST housekeeping


void ensureHSSTChannel()
{
	int result;
	
    if(hsst_hostio_stream==NULL)
    {
        hsst_hostio_stream = HSST_open ("hsst_hostio"); 
   
        
// options (otherwise, default is buffering with 256-byte buffer
        
// make a larger buffer -- be sure heap size is set appropriately
//        result = HSST_setvbuf( hsst_hostio_stream, NULL, HSSTFBUF, 0x1000 );

// set for no buffering
//        result = HSST_setvbuf( hsst_hostio_stream, NULL, HSSTNBUF, 0 );
    }
}




// channel closing at program end --
// this can be executed inside 56800E init code end

void exit_hsst_hostio()
{
	int result;
	
    if(hsst_hostio_stream != NULL)
    {
        result = HSST_flush (hsst_hostio_stream ); 
        result = HSST_close (hsst_hostio_stream ); 
    }
}




void sendHostIOServiceRequest(long service_request)
{
    int theCount;
    size_t numElements;
    size_t elementSize;
    int result;
    
    // make service request into new function later
    // we use conventional hostIO service defines
    // we factor out numElements and elementSize for sanity check
    // and uniform HSST calls
    
    hostIO_service_request = service_request;
    numElements = 1;
    elementSize = sizeof(hostIO_service_request);
    
    // send the service request
    theCount = HSST_write(&hostIO_service_request,  // the buffer
                          elementSize,              // number of 
                          numElements,  
                          hsst_hostio_stream);
                          
    result = HSST_flush(hsst_hostio_stream);
}




// this is called higher up in MSL's __write_file
// count is returned in count address
 
void __debugger_file_write(int handle, 
                           unsigned char *buffer,  
                           size_t *count)
{ 
    int result;
    size_t numElements;
    size_t elementSize;
    long hsst_write_count;
    long target_file_handle;
    
    ensureHSSTChannel();
    sendHostIOServiceRequest(SVC_WRITE);
   

    // send the filehandle 
    target_file_handle = handle;    
    numElements =1;
    elementSize = sizeof(target_file_handle);

    result = HSST_write(&target_file_handle,    // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
  
    result = HSST_flush(hsst_hostio_stream);
      
    // send the  count
    numElements =1;
    elementSize = sizeof(hsst_write_count);     // generalize to header file later
    hsst_write_count= *count;                   // get the count
          
    result = HSST_write(&hsst_write_count,      // the buffer with the count
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
    
    result = HSST_flush(hsst_hostio_stream);
   
    
    // send the data
    numElements = hsst_write_count;
    elementSize = sizeof(char);                 // hawk2 send is always in bytes
          
   
    result = HSST_write(buffer,                 // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
                          
    result = HSST_flush(hsst_hostio_stream);
    
    
    
    // get the returned count                   // later make size from common header
    elementSize = sizeof(long);                 // expected hsst return is long   
    numElements = 1;
    
    result = HSST_read((void*)count,          // the address to receive count 
                       elementSize,           
                       numElements, 
                       hsst_hostio_stream);

 
}




// NOTES on __debugger_con_write
// this is called inside runtime hsst hostio's inline assembly routines
// __put_char_dbg_console and __flush_console
// therefore we access the hsst_STDOUTBuffer count & address directly
// rather than accessing them by the assigned registers

void __debugger_con_write(unsigned char *buffer,  
                          size_t *count)
{

    int result;
    size_t numElements;
    size_t elementSize;
    long hsst_write_count;
    long target_file_handle;
    
    ensureHSSTChannel();
    sendHostIOServiceRequest(SVC_WRITE);
   
  
    // send the filehandle 
    target_file_handle = stdoutHandle;
    
    
    // factored out for continuity
    numElements =1;
    elementSize = sizeof(target_file_handle);

    result = HSST_write(&target_file_handle,    // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
  
    result = HSST_flush(hsst_hostio_stream);
   
      
    // send the console count
    numElements =1;
    elementSize = sizeof(hsst_write_count);
    hsst_write_count = hsst_STDOUTBufferCount;
          
    result = HSST_write(&hsst_write_count,      // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
    
    result = HSST_flush(hsst_hostio_stream);
   
    
    // send the console text
    numElements = hsst_STDOUTBufferCount;
    elementSize = sizeof(short);
          
   
    result = HSST_write(&hsst_STDOUTBuffer[0],  // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
                          
    result = HSST_flush(hsst_hostio_stream);
 
 
     // clear buffer count 
    hsst_STDOUTBufferCount = 0; 
}





int __debugger_open(const char *name,
                    __file_modes mode)
{
    int result;
    size_t numElements;
    size_t elementSize;
    long target_file_handle;
    long target_filename_count;
    
    ensureHSSTChannel();
    sendHostIOServiceRequest(SVC_OPEN);


    // we have to send the count so the host client 
    // will know how much to ask for... otherwise, it will just wait
    // send the count
    target_filename_count = strlen(name)+1;
    elementSize = sizeof(target_filename_count);
    numElements = 1;      
   
    result = HSST_write(&target_filename_count, // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements             
                        hsst_hostio_stream);    // pointer to channel info
   
    result = HSST_flush(hsst_hostio_stream);
       
     // send the filename
    numElements = target_filename_count;
    elementSize = sizeof(char);
          
   
    result = HSST_write((void*)name,            // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
             
    result = HSST_flush(hsst_hostio_stream);
                          
    // send the file mode
    numElements = 1;
    elementSize = sizeof(mode);
          
    
    result = HSST_write(&mode,                 // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
                             
    
    result = HSST_flush(hsst_hostio_stream);
   

    // get the returned handle                  
    elementSize = sizeof(target_file_handle);      
    numElements = 1;
    
    result = HSST_read(&target_file_handle,     // the address to receive handle 
                        elementSize,           
                        numElements, 
         
                        hsst_hostio_stream);
                        
    return((int)target_file_handle);

}




int __debugger_close(int handle)
{
                            // later version may more closely map but for now
    long theFileHandle;     // we like to transfer longs for HSST
    long closeResult;       // we like factored out names, too, for readability
    size_t numElements;
    size_t elementSize;
    int result;
    
    ensureHSSTChannel();
    sendHostIOServiceRequest(SVC_CLOSE);
    
    // factored out for continuity
    numElements = 1;
    elementSize = sizeof(theFileHandle);
    theFileHandle = handle;
          
    
    result = HSST_write(&theFileHandle,         // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
                             
    
    result = HSST_flush(hsst_hostio_stream);
   

    // defensive programing; reduce as need be                
    numElements = 1;
    elementSize = sizeof(closeResult);      
    
    result = HSST_read(&closeResult,     // the address to receive handle 
                       elementSize,           
                       numElements, 
                       hsst_hostio_stream);
                        
    return((int)closeResult);
    
}





int __debugger_seek(int handle, 
                    unsigned long *position, 
                    int mode)
{
    int result;
    size_t numElements;
    size_t elementSize;
    long target_file_handle;
    long target_seek_position;
    long target_seek_mode;
    long file_result;
    
    ensureHSSTChannel();
    sendHostIOServiceRequest(SVC_SEEK);
    
    
    // factored out for continuity and readability
    // we prefer to transfer longs with this version of hsst hostio
    target_file_handle =handle;
    target_seek_position = *position;
    target_seek_mode = mode;
    
    
    // order is important
    // later we may bundle these parameters in a struct
    // and send as a package but now for verification...
   
    // send the filehandle 
    target_file_handle = handle;    
    numElements =1;
    elementSize = sizeof(target_file_handle);

    result = HSST_write(&target_file_handle,    // the buffer
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
  
    result = HSST_flush(hsst_hostio_stream);
      
      
      
    // later we may send all this as a struct aka package
    // for now, for verification purposes, let's send each one
      
    // send the  position
    numElements =1;
    elementSize = sizeof(target_seek_position); 
          
    result = HSST_write(&target_seek_position,  // the buffer with the count
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
    
    result = HSST_flush(hsst_hostio_stream);
      
      
    
    // send the  mode
    numElements =1;
    elementSize = sizeof(target_seek_mode);     
          
    result = HSST_write(&target_seek_mode,      // the buffer with the count
                        elementSize,            // size of element
                        numElements,            // number of elements
                        hsst_hostio_stream);    // pointer to channel info
    
    result = HSST_flush(hsst_hostio_stream);



    // get the returned count                   
    numElements = 1;
    elementSize = sizeof(file_result);            
    
    result = HSST_read(&file_result,             // buffer for receive
                       elementSize,             // sizeof element
                       numElements,             // number of elements
                       hsst_hostio_stream);     // pointer to channel info

    return((int)file_result);
    
}




int __debugger_read(int handle, 
                   unsigned char *buffer,  
                   size_t *count)
{
    int result;
    size_t numElements;
    size_t elementSize;
    long hsst_read_count;
    long target_file_handle;
    long target_read_return;
    
    
    ensureHSSTChannel();
    sendHostIOServiceRequest(SVC_READ);
   
   
    // factor all this out later
    
    // send the filehandle 
    target_file_handle = handle;    
    numElements =1;
    elementSize = sizeof(target_file_handle);

    result = HSST_write(&target_file_handle,     // the buffer
                        elementSize,             // size of element
                        numElements,             // number of elements
                        hsst_hostio_stream);     // pointer to channel info
  
    result = HSST_flush(hsst_hostio_stream);
      
      
      
    // send the  count
    numElements =1;
    elementSize = sizeof(hsst_read_count);       // generalize to header file later
    hsst_read_count= *count;                     // stash the count
          
    result = HSST_write(&hsst_read_count,        // the buffer with the count
                        elementSize,             // size of element
                        numElements,             // number of elements
                        hsst_hostio_stream);     // pointer to channel info
    
    result = HSST_flush(hsst_hostio_stream);
   
    
    // get the data                            
    numElements = hsst_read_count;
    elementSize = sizeof(char);                  // hawk2 reads are in bytes  
    
    result = HSST_read((void*)buffer,            // the address to receive count 
                       elementSize,              // size of elements       
                       numElements,              // number of elements
                       hsst_hostio_stream);

    
    // get the returned count                   
    elementSize = sizeof(target_read_return);    
    numElements = 1;
    
    result = HSST_read(&target_read_return,      // the address to receive count 
                       elementSize,           
                       numElements, 
                       hsst_hostio_stream);
                       
    return((int)target_read_return);

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
int __put_char_dbg_console(int c);

asm int __put_char_dbg_console(int c)
{
	cmp.w	#newln,y0				// is char a '\n'
	bne		not_newln				// if no, skip conversion
	move.w	#lnfeed,y0				// if yes, convert it to a line feed
not_newln:
	move.l	#>>hsst_STDOUTBuffer,r2
	move.w	hsst_STDOUTBufferCount,x0	// get # words in buffer LMM
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
	move.w	x0,hsst_STDOUTBufferCount	// LMM
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

void __flush_console();

asm void __flush_console()
{
	move.w	hsst_STDOUTBufferCount,X0	// move the count to X0 LMM
	
	cmp.w	#0,x0					    // if no zero count
	
	beq     _allDone                    // then all done
    move.l	#>>hsst_STDOUTBuffer,R2		// now stash the buffer address in R2	
	jsr		__debugger_con_write        // then jump to our console write
_allDone:
	rts		
}