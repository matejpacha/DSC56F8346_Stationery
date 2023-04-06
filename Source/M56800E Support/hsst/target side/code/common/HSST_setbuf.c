/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/




#include "HSST.h"
#include "HSST_errno.h"
#include "HSST_internal.h"

/* 
   This function allows the installation of an external buffer for a stream,
   or provides for resizing the stream buffer.
   Sets the channel to buffered mode if it's not already        
*/

int
HSST_setvbuf( HSST_STREAM *rs, unsigned char *buf, int mode, size_t size )
{
        
   	/* free previously allocated buffers */

	if ( ( rs->_buffer != NULL ) && ( rs->_flag & _HSSTABUF ) )
	{
		rs->_flag &= ~_HSSTABUF;
	    free( rs->_buffer );
	}

	/* disable buffering */
				
	if ( mode & HSSTNBUF )	
	{
		rs->_flag |= HSSTNBUF;
		rs->_flag &= ~HSSTFBUF;
		
		rs->_buffer = rs->_ptr = NULL;
		rs->_bufsiz = rs->_cnt = 0;
		
		return 0;
	}
    
    /* enable buffering */
    
    /* set mode to buffered if not */
    
    rs->_flag |= HSSTFBUF;
    rs->_flag &= ~HSSTNBUF;
    
    
    /* if the buffer is not empty, flush it */

    if ( rs->_cnt )
    {
    	HSST_flush ( rs );
    }
    
	/* if an external buffer is not supplied, allocate it */

	if ( NULL == buf )
	{
		buf = malloc ( size );
		if ( ! buf )
		{		
			return -1;
		}		
		
		rs->_flag |= _HSSTABUF;	/* flag that buffer was allocated by us ... to be destroyed */
	}
	
	rs->_buffer = rs->_ptr = buf;
	rs->_bufsiz = size;
	rs->_cnt = 0;
	
    return 0;
}
