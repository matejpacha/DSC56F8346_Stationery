/*
 MSL
 Copyright ©1995-2004 Freescale Corporation.  All rights reserved.
*/

#include "HSST.h"
#include "HSST_errno.h"
#include "HSST_internal.h"

extern List* p_open_channels;


int HSST_flush ( HSST_STREAM *rs )
{
	if ( NULL == rs )
	{
		/*	flush all open channels */
		
		list_iterator i = p_open_channels->head;
		
		while ( i )
		{
			/* if the channel is open */
			if ( i->data->_stream != EOF )
			{
				return HSST_flush ( i->data );
			}
			
			/* delete closed channel from the list */
			else
			{	
				erase ( p_open_channels, i->data );
			}
			
			i = i->next;
		}	
			
		return 0;	
	}
		
    /* do not flush a non-buffered channel or a channel without buffer */
    if ( ( rs->_flag & HSSTNBUF ) || ( NULL == rs->_buffer ) )
    {
		return 0;
    }
	
    /* if it is a buffered output channel */

	if ( 0 < rs->_cnt )
	{			
		/* send data */
			
		size_t written;
	
		if ( rs->_cnt != ( written = _HSST_send ( rs->_buffer, rs->_cnt ) ) )
		{
			rs->_flag |= _HSSTERR;			
			rs->_ptr += written;
			rs->_cnt += written;
			return EOF;
		}		
		
	    rs->_ptr = rs->_buffer;
	    rs->_cnt = 0;
	}


    /* successful return */
    return 0;
}

