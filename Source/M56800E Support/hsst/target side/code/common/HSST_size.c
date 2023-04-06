/*
 MSL
 Copyright ©1995-2004 Freescale Corporation.  All rights reserved.
*/




#include "HSST.h"
#include "HSST_internal.h"
#include "HSST_errno.h"

size_t
HSST_size ( HSST_STREAM *rs )
{	
	packet_header size_header;
	short *size_header_ptr = (short *)&size_header;
    Uint32 result_arr[2];	
	
    if ( NULL == rs || EOF == rs->_stream )
    {
		return 0;
    }

	size_header_ptr[_HSST_PACKET_CMD_FIELD] = HSST_SIZE;
	size_header_ptr[_HSST_PACKET_DES_FIELD] = rs->_stream;
	
	/* send size request to host */
	
	if ( sizeof(size_header) != _HSST_send ( size_header, sizeof(size_header) ) )
	{
	    HSST_ERRNO = ECOMMERR;
		return 0;
	}

	/* receive status from the host */
	
	if ( sizeof(result_arr) != _HSST_recv ( result_arr, sizeof(result_arr) ) )
	{
	    HSST_ERRNO = ECOMMERR;
		return 0;
	}		

	if ( result_arr[0] == -1 )
	{
		HSST_ERRNO = result_arr[1];	/* error */
		return 0;
	}
	
	/* return number of bytes 'in' stream rs */
	
	return (size_t) result_arr[0];
}
