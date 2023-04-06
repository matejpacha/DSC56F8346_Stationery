
/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/



// This is a file with 56800E specific functionality
// Compile selectively if this target library needs to be ported to other hardware ( eg. HAWK )

#include "HSST.h"
#include <string.h>
#include "hsst_low_56800E.h"

extern int _window_size;

//local prototypes...
size_t _HSST_recv ( void *ptr, size_t to_read ); 

size_t
_HSST_recv ( void *ptr, size_t to_read )
{
	size_t remainder, chunks, tot_reads,read = 0, i = 0;
	unsigned long temp_long;
 	bool done;
 	int cnt;
 	bool adjAlignment=false;
 	bool twoByteAligned=true;
 	
	chunks = (size_t) ( to_read / _window_size );
	remainder = to_read % _window_size;

	//ptr need to point to mem. that is on a 4-byte boundary;
	//if it's not, and exception will occur, so we need to make
	//an adjustment for this later...;ptr should always be a byte
	//pointer in this function
	if ((unsigned long)ptr%4) {
		adjAlignment = true;
		
		//also, check if it's at least 2 byte aligned
		if ((unsigned long)ptr%2) {
			twoByteAligned=false;
		}
	}
	tot_reads = chunks;

	while ( 0 < ( chunks-- ) )
	{
		done = false;
 		
 		while (!done) {
	 		while ( !( OTXRXSR & RECV_FULL_mask) );
 			temp_long =  ORX_long;
 		
 			//work-around for HSST HW 
	 		if (temp_long!=0xFFFFFFFF) {
   				done = true;
   			}
   		}

 		if (!adjAlignment) {
	 		((unsigned long *) ptr)[i++] = temp_long;		
 		}
 		else {
 			if (twoByteAligned) {
	 			*((unsigned short *)(((unsigned long *)ptr+i))) = temp_long;
				*((unsigned short *)(((unsigned long *)ptr+i))+1) = temp_long>>16;
			}
			else { //ptr is on an odd byte address
	 			*((unsigned char *)(((unsigned long *)ptr+i))) = temp_long;
				*((unsigned char *)(((unsigned long *)ptr+i))+1) = temp_long>>8;
				*((unsigned char *)(((unsigned long *)ptr+i))+2) = temp_long>>16;
				*((unsigned char *)(((unsigned long *)ptr+i))+3) = temp_long>>24;
			}
			i++;			
 		}
 		
 		read += _window_size;
	}	
	
	if ( 0 != remainder )
	{
		unsigned long buffer = 0;

		while ( !( OTXRXSR & RECV_FULL_mask ) );
		buffer = ORX_long;		

		//work-around for HSST HW 		
		if (buffer==0xFFFFFFFF) {
			while ( !( OTXRXSR & RECV_FULL_mask ) );
			buffer = ORX_long;				
		}
		
		ptr = (char *) ptr + read;
		memcpy ( ptr, &buffer, remainder );
		read += remainder;
	}

	return read;
}


