
/*
 MSL
 Copyright ©1995-2004 Freescale Corporation.  All rights reserved.
*/




/*--- the protocol----------------|

HSST_OPEN:
send:		HSST_OPEN, descriptor, filename_size
send:		filename	

HSST_CLOSE:		
send:		HSST_CLOSE, descriptor

HSST_READ		
send:		HSST_READ, descriptor, data size to read
recv:		HSST_READ, descriptor, data size to expect
recv:		data

HSST_WRITE		
send:		HSST_WRITE, descriptor, data size
send:		data

|--------------------------------*/

#if ! defined __RTX_LOW
#define __RTX_LOW

 
extern unsigned int RTX_ERRNO;
 

// SC140/8101 specific section
// EOnCE ETRSMT register address definitions etc.

extern int _window_size;

  
#define OTXRXSR	   *OTXRXSR_p
#define OTX_long   *OTX_long_p
#define ORX_long   *ORX_long_p

 
// Masks. Refer 11.5.1 of the Hawk 2 family spec 

#define TRSMT_FULL_mask  (1<<1)
#define RECV_FULL_mask    (1)

#define _EOnce_Reg_BASE	0xFF0000
  
#define OTXRXSR_p ((volatile unsigned short *)(_EOnce_Reg_BASE+0xFFFD))
#define OTX_long_p ((volatile unsigned long *)(_EOnce_Reg_BASE+0xFFFE))
#define ORX_long_p ((volatile unsigned long *)(_EOnce_Reg_BASE+0xFFFE))

 
// end SC140/8101 specific section


#endif

