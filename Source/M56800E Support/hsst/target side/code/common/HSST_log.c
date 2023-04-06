

/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/




#include "HSST.h"
#include "HSST_Internal.h"
#include <string.h>


int 
HSST_set_log_dir ( HSST_STREAM *stream, char *dir_name )
{
	packet_header log_header;
	short *log_header_ptr = (short *)&log_header;
	Uint32 result_arr[2];	/* need to read an integral of WINDOW_SIZE */
	
	log_header_ptr[_HSST_PACKET_CMD_FIELD] = HSST_LOG_DIRECTORY;
	log_header_ptr[_HSST_PACKET_DES_FIELD] = stream->_stream; 
	log_header_ptr[_HSST_PACKET_SIZE_FIELD] = 1;
	
	if ( dir_name ) 
	{
		log_header_ptr [_HSST_PACKET_NMEMB_FIELD] = strlen(dir_name)+1; /* include null char terminator */
	}
	else 
	{
		log_header_ptr [_HSST_PACKET_NMEMB_FIELD] = 0;	
	}

	if ( sizeof(log_header) != _HSST_send ( &log_header, sizeof(log_header) ) )
	{
		return EOF;
	}	
	
	/* send data */
	
	if (!dir_name) {
		return 0;
	}
	
	if ( log_header_ptr [_HSST_PACKET_NMEMB_FIELD] != 
			  _HSST_send(dir_name, log_header [_HSST_PACKET_NMEMB_FIELD]) )
	{
		return EOF;
	}		
	
	/* Get the return value. */
	
	if ( sizeof(result_arr) != _HSST_recv ( result_arr, sizeof(result_arr) ) )
	{
		return EOF;
	}		

	return ( result_arr[0] == true ? EOF : 0 );	
}

