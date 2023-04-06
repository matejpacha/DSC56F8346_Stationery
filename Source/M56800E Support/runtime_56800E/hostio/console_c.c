


/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/


#include "console.h"
#include <stdio.h>


//int __stdout_ready = 0;

unsigned int __consolewrite(const void * ptr, size_t num_memb)
{
	const char *write_ptr;
	unsigned int bytes_to_go;
	
	if (num_memb == 0)
		return(0);
		
	bytes_to_go = num_memb;

	write_ptr = ptr;
	
	while (bytes_to_go)
	{
		if (-1 == __dbg_put_char(*write_ptr++)) {	/* Ran out of room? */
			return(num_memb - bytes_to_go);
		}
		--bytes_to_go;
	}
	return(num_memb);	/* All the way through, must have written all the members */
}		




/*- __CONSOLEWRITE -*/			/*- mm 990325 -*/
void * __ConsoleWrite(void *File, const char * Buffer, size_t NumChars)
{
	return (__consolewrite(Buffer,  NumChars) == NumChars ? (void*)1 : 0);
}



