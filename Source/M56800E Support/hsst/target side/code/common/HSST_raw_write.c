/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/




#include "HSST.h"
#include "HSST_errno.h"
#include "HSST_internal.h"
#include <string.h>

static int prev_size = 0;

size_t HSST_raw_write ( void *ptr, size_t length, HSST_STREAM *rs )
{	
	size_t written;
	packet_header write_header;	
	short *write_header_ptr = (short *)&write_header;			

	/* neccessary validations */
	
	if ( NULL == ptr || 0 >= length )
	{
		rs->_flag |= _HSSTERR;
		return (size_t) 0;	
	}
	
	/* assemble packet header */
	
	write_header_ptr[_HSST_PACKET_CMD_FIELD] = HSST_WRITE;
	write_header_ptr[_HSST_PACKET_DES_FIELD] = rs->_stream;
	write_header_ptr[_HSST_PACKET_SIZE_FIELD] = 1;
	write_header_ptr[_HSST_PACKET_NMEMB_FIELD] = length;
	
	/* unbuffered mode, or if message too big. write directly to hardware */
	
	if ( ( rs->_flag & HSSTNBUF ) || 
		  ( ( length > ( rs->_bufsiz - rs->_cnt ) ) && ( prev_size == 0 ) ) 
	   )
	{		
		/* send HSST_WRITE header */
			
		if ( sizeof(write_header) != _HSST_send ( &write_header, sizeof(write_header) ) )
		{
			return (size_t) 0;
		}	
			
		/* send data */
			
		if ( length != ( written = _HSST_send ( ptr, length ) ) )
		{
			rs->_flag |= _HSSTERR;
			return (size_t) 0;
		}			
		
		return written;		
	}
	
	else	/* buffered mode */
	{		
		if ( prev_size == 0 )	/* start of buffering. buffer header also */
		{
			memcpy ( rs->_buffer, write_header, sizeof(write_header) );
			rs->_ptr += sizeof(write_header);
			rs->_cnt += sizeof(write_header);			
			prev_size = 1;			
			memcpy ( rs->_ptr, ptr, length );
			rs->_ptr += length;
			rs->_cnt += length;
		}

		else	/* buffer data */
		{
			/* if size different from that of previous message, or if not enough space to buffer, 
			   flush the channel and restart buffering */
			
			if ( ( prev_size != 1 ) || ( length > (int)(rs->_bufsiz - rs->_cnt) ) ) 			 
			{
				HSST_flush ( rs );
				prev_size = 0;
				return HSST_raw_write ( ptr, length, rs );
			}
						
			memcpy ( rs->_ptr, ptr, length );
			( (short *) rs->_buffer )[_HSST_PACKET_NMEMB_FIELD] += length;	
			rs->_ptr += length;
			rs->_cnt += length;
		}

		return length;
	}
					

}
