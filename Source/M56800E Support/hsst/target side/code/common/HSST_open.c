

/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/




#include "HSST.h"
#include "HSST_errno.h"
#include "HSST_internal.h"
#include <stdlib.h>
#include <string.h>


extern List* p_open_channels;

void _HSST_cleanup ( void );

bool _registered_with_atexit_p = false;

/* clean up function to be registered with atexit ( ) */

void _HSST_cleanup ( void )
{
#pragma noinline
	
	list_iterator i;
	
	/* free up all buffers and close open channels */
	
	i = p_open_channels->head;		

	while ( i )
	{
		/* if the channel is open, close it */
		if ( i->data->_stream != EOF )
		{
			HSST_close ( i->data );
		}
			
		i = i->next;
	}	
	
	/* free up the open channel list */
	
	destroy_list ( &p_open_channels );			
}


HSST_STREAM*
HSST_open( const char* filename )
{
    Uint32 result_arr[2];
  	packet_header open_header;
  	short *open_header_ptr = (short *)&open_header;
	HSST_STREAM *rs = malloc ( sizeof(HSST_STREAM) );
	
	if ( !rs )
	{
		return NULL;
	}
	  
    rs->_flag = 0;
    rs->_flag |= HSSTFBUF;	/* fully-buffered mode by default */
    rs->_flag &= ~HSSTNBUF;
       
	
	/*  send HSST_OPEN header */
	
	open_header_ptr[_HSST_PACKET_CMD_FIELD] = HSST_OPEN;
	open_header_ptr[_HSST_PACKET_NMEMB_FIELD] = strlen ( filename ) + 1;
 	
	if ( sizeof(open_header) != _HSST_send ( &open_header, sizeof(open_header) ) )
	{
		return NULL;
	}
	
	/*	send filename */
	
	if ( open_header_ptr[_HSST_PACKET_NMEMB_FIELD] != _HSST_send ( (void *) filename, (size_t) open_header_ptr[_HSST_PACKET_NMEMB_FIELD] ) )
	{
		return NULL;
	}

	
	/* receive descriptor from the host */
	
	if ( sizeof(result_arr) != _HSST_recv ( result_arr, sizeof(result_arr) ) )
	{
		return NULL;
	}		
	else
	{
		rs->_stream = result_arr[1];

		if ( 0 > rs->_stream )
		{
			HSST_ERRNO = result_arr[0];
			return NULL;
		}
		
		/* everything OK. Store this channel in the open-channel-list */
		
		if ( !p_open_channels )
		{
			p_open_channels = create_list ( );
		}
		
		if ( rs->_flag & HSSTFBUF )
		{
			if (!_registered_with_atexit_p )
			{				
				atexit ( _HSST_cleanup );
				_registered_with_atexit_p = true;
			}
			
			rs->_bufsiz = _HSST_BUFSIZ;
			/* buffer to be two-byte aligned */
			rs->_buffer = malloc ( sizeof(short) * ( (rs->_bufsiz / sizeof(short)) + 1 ) );
			
			if (!rs->_buffer) {
				/* turn off buffering; not enough memory */
				rs->_flag |= HSSTNBUF;
				rs->_flag &= ~HSSTFBUF;
			}
			else {
				rs->_flag |= _HSSTABUF;
				rs->_ptr = rs->_buffer;
				rs->_cnt = 0;
			}
		}

		/* add channel to the list of open channels and return status */
				
 		if ( push_front ( p_open_channels, rs ) )
 		{
			return rs;
		}
		else 
		{
			return NULL;
		}
	}
}
