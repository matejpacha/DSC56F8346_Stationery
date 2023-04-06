

/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/

/*    
    DSP56800x-specific
    
    style notes:
      tab = 4 spaces
      two lines between prototypes
      seven lines between functions
      
    
   --------------------------------------
 */
 
 
 
#include <hostio.h>
#include <HSST.h>



#define host_acknowledged 1


void ensureHSSTChannel();
void sendHostIOServiceRequest(long service_request);
void waitForHostACK();




// for original low-level approach
// left in for continuity

#define TRSMT_FULL_mask  (1<<1)
#define RECV_FULL_mask   (1)

// see EOnCE Memory Map in dsp56852um.pdf

#define _EOnce_Reg_BASE	0xFF0000
  
#define OTXRXSR_p ((volatile unsigned short *)(_EOnce_Reg_BASE+0xFFFD))
#define OTX_long_p ((volatile unsigned long *)(_EOnce_Reg_BASE+0xFFFE))
#define ORX_long_p ((volatile unsigned long *)(_EOnce_Reg_BASE+0xFFFE))
  
  
  
#define OTXRXSR	   *OTXRXSR_p   // (8 bits) Transmit and Receive Status and Control Register
#define OTX_long   *OTX_long_p  // Transmit Register
#define ORX_long   *ORX_long_p  // Receive Register





