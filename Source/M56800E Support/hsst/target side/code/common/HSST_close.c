/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/

#include "HSST.h"
#include "HSST_errno.h"
#include "HSST_internal.h"


int
HSST_close ( HSST_STREAM *rs )
{    
	packet_header close_header;
	short *close_header_ptr = (short *)&close_header;
	
    Uint32 result_arr[2];	
	
    if ( NULL == rs || EOF == rs->_stream )
    {
		return EOF;
    }

	 close_header_ptr [_HSST_PACKET_CMD_FIELD] = HSST_CLOSE;
	 close_header_ptr [_HSST_PACKET_DES_FIELD] = rs->_stream;
	
	/* flush buffer before closing */
	
    if ( rs->_flag & HSSTFBUF )
    {
    	HSST_flush ( rs );
    	if (rs->_flag & _HSSTABUF) {
			free( rs->_buffer );
		}	
    }
        
	free ( rs );
	
	/* send close request to host */
	
	if ( sizeof(close_header) != _HSST_send ( close_header, sizeof(close_header) ) )
	{
		return EOF;
	}

	/* receive status from the host */
	
	if ( sizeof(result_arr) != _HSST_recv ( result_arr, sizeof(result_arr) ) )
	{
		return EOF;
	}		

	if ( result_arr[1] != 0 )
	{
		HSST_ERRNO = result_arr[0];	/* error */
		return EOF;
	}
    
    /* mark channel closed */
    
    rs->_stream = EOF;
    
    return 0;
}


