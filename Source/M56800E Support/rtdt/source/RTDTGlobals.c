#include "RTDT.h"

#define IPR1_ADDR 0xF1A1

unsigned long gTxBuffer[64];
unsigned long *gTxCurrPtr = gTxBuffer;
unsigned long *gTxLastPtr = gTxBuffer;
unsigned int gTxBufferCount = 0;
unsigned int *gIPR1 = (unsigned int*)IPR1_ADDR;
unsigned int gTxReady = 1;
unsigned int gRxInProgress = 0;
void (*gRxHandler) () = 0;


void RTDT_Enable()
{
	*((volatile unsigned short *)(0xFFFFFD)) = 0xC;
	*((volatile unsigned short *)(IPR1_ADDR)) |= 0x30;
}