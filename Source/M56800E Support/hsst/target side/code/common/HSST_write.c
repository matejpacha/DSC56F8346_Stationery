

/*
 MSL
 Copyright ©1995-2004 Freescale Corporation.  All rights reserved.
*/




#include "HSST.h"
#include "HSST_errno.h"
#include "HSST_internal.h"
#include <string.h>

static int prev_size = 0;

size_t
HSST_write ( void* ptr, size_t size, size_t nmemb, HSST_STREAM* rs )
{	
	size_t written, to_write;
	packet_header write_header;	
	short *write_header_ptr = (short *)&write_header;			

	/* neccessary validations */
	
	if ( NULL == ptr || 0 >= size || 0 >= nmemb )
	{
		rs->_flag |= _HSSTERR;
		return (size_t) 0;	
	}
	
	to_write = ( size * nmemb );

	/* assemble packet header */
	
	write_header_ptr[_HSST_PACKET_CMD_FIELD] = HSST_WRITE;
	write_header_ptr[_HSST_PACKET_DES_FIELD] = rs->_stream;
	write_header_ptr[_HSST_PACKET_SIZE_FIELD] = size;
	write_header_ptr[_HSST_PACKET_NMEMB_FIELD] = nmemb;
	
	/* unbuffered mode, or if message too big. write directly to hardware */
	
	if ( ( rs->_flag & HSSTNBUF ) || 
		  ( ( ( to_write + sizeof(write_header) ) > ( rs->_bufsiz - rs->_cnt ) ) &&
		    ( prev_size == 0 ) 
		  ) 
	   )
	{		
		/* send HSST_WRITE header */
			
		if ( sizeof(write_header) != _HSST_send ( &write_header, sizeof(write_header) ) )
		{
			return (size_t) 0;
		}	
			
		/* send data */
			
		if ( to_write != ( written = _HSST_send ( ptr, to_write ) ) )
		{
			rs->_flag |= _HSSTERR;
			return (size_t) 0;
		}			
		
		return (size_t) ( written / size );		
	}
	
	else	/* buffered mode */
	{		
		if ( prev_size == 0 || rs->_buffer == rs->_ptr )	/* start of buffering. buffer header also */
		{
			memcpy ( rs->_buffer, write_header, sizeof(write_header) );
			rs->_ptr += sizeof(write_header);
			rs->_cnt += sizeof(write_header);			
			prev_size = size;			
			memcpy ( rs->_ptr, ptr, to_write );
			rs->_ptr += to_write;
			rs->_cnt += to_write;
		}

		else	/* buffer data */
		{
			/* if size different from that of previous message, or if not enough space to buffer, 
			   flush the channel and restart buffering */
			
			if ( ( prev_size != size ) || ( to_write > (int)(rs->_bufsiz - rs->_cnt) ) ) 			 
			{
				HSST_flush ( rs );
				prev_size = 0;
				return HSST_write ( ptr, size, nmemb, rs );
			}
						
			memcpy ( rs->_ptr, ptr, to_write );
			( (short *) rs->_buffer )[_HSST_PACKET_NMEMB_FIELD] += nmemb;	
			rs->_ptr += to_write;
			rs->_cnt += to_write;
		}

		return (size_t) ( to_write / size );
	}
					
}	



