
/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/


// prototypes
unsigned long alignPtrToBoundary(void *ptr);
extern int __register_atexit(void (*func)(void));
void hsstTsmtdelay(void);


/* With the current DSP56800E hardware, tis delay is necessary between 
   the reading of the status register and the writing of data to the transmit 
   buffer. The longer the delay, the more likely the data being written
   to the buffer will not overwrite unread data that is already
   in the buffer. You may decrease the delay to improve performance,
   but you risk overwriting data in the transmit buffer. In testing,
   a 1250 cycle delay had no overwrites in 1,200,000 transmits. A 500
   cycle delay averaged 1 overwrite every 11000 transmits.
*/
void hsstTsmtdelay(void)
{
	int i;

#pragma optimization_level 0
	
	for (i=0;i<125;i++) { //approx. 1250 cycles in un-opt. code	
		asm {
			nop
		}		
	}
}
 
unsigned long alignPtrToBoundary(void *ptr)
{
	unsigned char ret[4];
	unsigned char *cPtr;
		
	cPtr = (unsigned char *)ptr;
	
	ret[0] = *cPtr;
	ret[1] = *(cPtr+1);
	ret[2] = *(cPtr+2);
	ret[3] = *(cPtr+3);

	return *((unsigned long *)ret);
}