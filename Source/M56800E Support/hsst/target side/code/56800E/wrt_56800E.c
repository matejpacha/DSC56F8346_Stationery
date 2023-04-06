

/*
 MSL
 Copyright ©1995-2004 Freescale Corporation.  All rights reserved.
*/




// This is a file with SC140/MSC8101 specific functionality
// Compile selectively if this target library needs to be ported to other hardware ( eg. HAWK )

#include "HSST.h"
#include <string.h>
#include "hsst_low_56800E.h"

extern int _window_size;

extern unsigned long alignPtrToBoundary(void *ptr);
extern void hsstTsmtdelay(void);

#define _min(a,b) (((a)<(b))?(a):(b))

//local prototypes...
size_t _HSST_send ( void *ptr, size_t to_write);

size_t
_HSST_send ( void *ptr, size_t to_write)
{
	size_t remainder,chunks, written = 0, i = 0;
 	
	chunks = (size_t) ( to_write / _window_size );
	remainder = to_write % _window_size;
	

	while ( 0 < ( chunks-- ) )
	{

		// Wait for the host to read OTX.
		while ( ( OTXRXSR & TRSMT_FULL_mask ) );

		
		hsstTsmtdelay();

		written += _window_size;
				
 		OTX_long = alignPtrToBoundary(ptr);
 		
 		(char *)ptr +=4;
 		
	}

	if ( 0 != remainder )
	{
		unsigned long buffer = 0;
 		memcpy ( (void *) &buffer, (const char *) ptr, remainder );
		while ( ( OTXRXSR & TRSMT_FULL_mask ) );
	
		hsstTsmtdelay();

		written += remainder;					

		OTX_long = buffer;

	}
	
	return written;
}




