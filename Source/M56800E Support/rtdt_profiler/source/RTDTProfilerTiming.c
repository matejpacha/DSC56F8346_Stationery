

#include "RTDTProfiler.h"
#include "RTDTProfilerInt.h"


// TMR_BASE defined in the prefix file for the target

#define TMR_3_COMSCR (volatile unsigned short  *)(TMR_BASE + 0x3A)
#define TMR_3_CMPLD2 (volatile unsigned short  *)(TMR_BASE + 0x39)
#define TMR_3_CMPLD1 (volatile unsigned short  *)(TMR_BASE + 0x38)
#define TMR_3_SCR    (volatile unsigned short  *)(TMR_BASE + 0x37)
#define TMR_3_CTRL   (volatile unsigned short  *)(TMR_BASE + 0x36)
#define TMR_3_CNTR   (volatile unsigned short  *)(TMR_BASE + 0x35)
#define TMR_3_HOLD   (volatile unsigned short  *)(TMR_BASE + 0x34)
#define TMR_3_LOAD   (volatile unsigned short  *)(TMR_BASE + 0x33)
#define TMR_3_CAP    (volatile unsigned short  *)(TMR_BASE + 0x32)
#define TMR_3_CMP2   (volatile unsigned short  *)(TMR_BASE + 0x31)
#define TMR_3_CMP1   (volatile unsigned short  *)(TMR_BASE + 0x30)

#define TMR_2_COMSCR (volatile unsigned short  *)(TMR_BASE + 0x2A)
#define TMR_2_CMPLD2 (volatile unsigned short  *)(TMR_BASE + 0x29)
#define TMR_2_CMPLD1 (volatile unsigned short  *)(TMR_BASE + 0x28)
#define TMR_2_SCR    (volatile unsigned short  *)(TMR_BASE + 0x27)
#define TMR_2_CTRL   (volatile unsigned short  *)(TMR_BASE + 0x26)
#define TMR_2_CNTR   (volatile unsigned short  *)(TMR_BASE + 0x25)
#define TMR_2_HOLD   (volatile unsigned short  *)(TMR_BASE + 0x24)
#define TMR_2_LOAD   (volatile unsigned short  *)(TMR_BASE + 0x23)
#define TMR_2_CAP    (volatile unsigned short  *)(TMR_BASE + 0x22)
#define TMR_2_CMP2   (volatile unsigned short  *)(TMR_BASE + 0x21)
#define TMR_2_CMP1   (volatile unsigned short  *)(TMR_BASE + 0x20)

#define TMR_1_COMSCR (volatile unsigned short  *)(TMR_BASE + 0x1A)
#define TMR_1_CMPLD2 (volatile unsigned short  *)(TMR_BASE + 0x19)
#define TMR_1_CMPLD1 (volatile unsigned short  *)(TMR_BASE + 0x18)
#define TMR_1_SCR    (volatile unsigned short  *)(TMR_BASE + 0x17)
#define TMR_1_CTRL   (volatile unsigned short  *)(TMR_BASE + 0x16)
#define TMR_1_CNTR   (volatile unsigned short  *)(TMR_BASE + 0x15)
#define TMR_1_HOLD   (volatile unsigned short  *)(TMR_BASE + 0x14)
#define TMR_1_LOAD   (volatile unsigned short  *)(TMR_BASE + 0x13)
#define TMR_1_CAP    (volatile unsigned short  *)(TMR_BASE + 0x12)
#define TMR_1_CMP2   (volatile unsigned short  *)(TMR_BASE + 0x11)
#define TMR_1_CMP1   (volatile unsigned short  *)(TMR_BASE + 0x10)

#define TMR_0_COMSCR (volatile unsigned short  *)(TMR_BASE + 0xA)
#define TMR_0_CMPLD2 (volatile unsigned short  *)(TMR_BASE + 0x9)
#define TMR_0_CMPLD1 (volatile unsigned short  *)(TMR_BASE + 0x8)
#define TMR_0_SCR    (volatile unsigned short  *)(TMR_BASE + 0x7)
#define TMR_0_CTRL   (volatile unsigned short  *)(TMR_BASE + 0x6)
#define TMR_0_CNTR   (volatile unsigned short  *)(TMR_BASE + 0x5)
#define TMR_0_HOLD   (volatile unsigned short  *)(TMR_BASE + 0x4)
#define TMR_0_LOAD   (volatile unsigned short  *)(TMR_BASE + 0x3)
#define TMR_0_CAP    (volatile unsigned short  *)(TMR_BASE + 0x2)
#define TMR_0_CMP2   (volatile unsigned short  *)(TMR_BASE + 0x1)
#define TMR_0_CMP1   (volatile unsigned short  *)(TMR_BASE + 0x0)


TimeInterval gRTDTProfLastReadTime;



void RTDT_ProfilerStartTimeBase(void)
{
	// setup quad timer for 64-bit cascaded operation
	
	*TMR_0_SCR  = 0x0000;
    *TMR_0_LOAD = 0x0000;
    *TMR_0_CMP1 = 0x0000;
    *TMR_0_CMP2 = 0x0000;
    *TMR_0_CTRL = 0xEA03; // Cascade from TMR_1 rollover, toggle OFLAG on compare
    *TMR_0_CNTR = 0x0000;
    
    *TMR_1_SCR  = 0x0000;
    *TMR_1_LOAD = 0x0000;
    *TMR_1_CMP1 = 0x0000;
    *TMR_1_CMP2 = 0x0000;
    *TMR_1_CTRL = 0xEC03; // Cascade from TMR_2 rollover, toggle OFLAG on compare
    *TMR_1_CNTR = 0x0000;
    
    *TMR_2_SCR  = 0x0000;
    *TMR_2_LOAD = 0x0000;
    *TMR_2_CMP1 = 0x0000;
    *TMR_2_CMP2 = 0x0000;
    *TMR_2_CTRL = 0xEE03; // Cascade from TMR_3 rollover, toggle OFLAG on compare
    *TMR_2_CNTR = 0x0000;
    
    *TMR_3_SCR  = 0x0000;
    *TMR_3_LOAD = 0x0000;
    *TMR_3_CMP1 = 0x0000;
    *TMR_3_CMP2 = 0x0000;
    *TMR_3_CTRL = 0x3006; // count input clock cycles
    *TMR_3_CNTR = 0x0000;
}

void RTDT_ProfilerGetTime(void)
{
	gRTDTProfLastReadTime.lo = (*TMR_2_CNTR);
	gRTDTProfLastReadTime.lo <<= 16;
	gRTDTProfLastReadTime.lo += (*TMR_3_HOLD);
	gRTDTProfLastReadTime.hi = (*TMR_0_HOLD);
	gRTDTProfLastReadTime.hi <<= 16;
	gRTDTProfLastReadTime.hi += (*TMR_1_HOLD);
}

