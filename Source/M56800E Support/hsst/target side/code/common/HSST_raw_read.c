

/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/




#include "HSST.h"
#include "HSST_errno.h"
#include "HSST_internal.h"

size_t HSST_raw_read ( void *ptr, size_t length, HSST_STREAM *rs )
{
	size_t to_read, read;
	packet_header read_header;
	short *read_header_ptr = (short *)&read_header;
	
	/* necessary validations */
	
	if ( NULL == ptr || 0 >= length )
	{
		rs->_flag |= _HSSTERR;
		return (size_t) 0;	
	}
	
	/* send HSST_READ header */

	read_header_ptr[_HSST_PACKET_CMD_FIELD] = HSST_RAW_READ;
	read_header_ptr[_HSST_PACKET_DES_FIELD] = rs->_stream;
	read_header_ptr[_HSST_PACKET_SIZE_FIELD] = 1;
	read_header_ptr[_HSST_PACKET_NMEMB_FIELD] = length;

	if ( sizeof(read_header) != _HSST_send ((void *)&read_header, sizeof(read_header) ) )
	{
		return (size_t) 0;
	}	

	/* receive HSST_READ header from host for the amount data to expect
	   ( in terms of bytes ) */	

	if ( sizeof(read_header) == _HSST_recv ((void *)&read_header, sizeof(read_header) ) )
	{
		
		if ( ( read_header_ptr[_HSST_PACKET_CMD_FIELD] != ENOHSSTERR ) ||
			 ( read_header_ptr[_HSST_PACKET_DES_FIELD] != rs->_stream ) ||
			 ( 0 >= (size_t)( read_header_ptr[_HSST_PACKET_NMEMB_FIELD] * read_header_ptr[_HSST_PACKET_SIZE_FIELD]) ) )
		{
			/* hosed */
			return (size_t) 0;
		}
		
		else
		{
			to_read = (size_t)( read_header_ptr[_HSST_PACKET_NMEMB_FIELD] * read_header_ptr[_HSST_PACKET_SIZE_FIELD] ) ;
			
			/* receive data */
	
			if ( to_read != ( read = _HSST_recv ( ptr, to_read ) ) )
			{
				return (size_t) 0;
			}		
		}
		
		HSST_ERRNO = read_header_ptr[_HSST_PACKET_CMD_FIELD];	// reusing cmd field for errno
					
		return (size_t) ( read );
	}
	
	else	/* error reading packet header */
	{
		return (size_t) 0;
	}	
}
