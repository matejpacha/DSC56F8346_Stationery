/* DSP56800E EOnCE Library
 Copyright ©2002 Freescale Corporation.  All rights reserved.
*/
 
#include "eonceLib.h"
 
 
/* globals */
void *_eonce_baseAddr = 0;
unsigned int _eonce_units = 0;
char _eonce_inUse = 0;
char _eonce_traceBufferFull = 0;
 
 
/* defines */
#define OCLSR_OFFSET		0xFC
#define OCR_OFFSET			0xA0
#define OSCNTR_OFFSET		0x9E
#define OSR_OFFSET			0x9D
#define OTBCR_OFFSET		0x9B
#define OTBPR_OFFSET		0x9A
#define OTB_OFFSET			0x98
#define OBCR_OFFSET			0x96
#define OBAR1_OFFSET		0x94
#define OBAR2_OFFSET		0x92
#define OBMSK_OFFSET		0x90
#define OBCNTR_OFFSET		0x8E
#define OB1CR_OFFSET		0x86
#define OB1AR1_OFFSET		0x84
#define OB1AR2_OFFSET		0x82
#define OB1MSK_OFFSET		0x80
#define OB1CNTR_OFFSET		0x7E

#define OB_UNIT_REG_OFFSET	0xA

#define OCLSR_ERLO			0x01
#define OCLSR_CLU			0x02

#define OCR_LTE				0x08
#define OCR_DEVEN			0x10
#define OCR_PWU				0x20

#define OSR_CZ				0x0004
#define OSR_CS				0x0008
#define OSR_TBFL			0x1000

#define OTBCR_TBH			0x04
 
 
/* macro to check if initialized */
#define _EONCE_RETURN_IF_NOT_INITIALIZED()			\
		if (_eonce_units == 0) return EONCE_ERR_NOT_INITIALIZED;

/* macro to check if EOnCE is locked out */
#define _EONCE_DECLARE_OCLSR	unsigned int *oclsr = (unsigned int *)_eonce_baseAddr + OCLSR_OFFSET;
#define _EONCE_RETURN_IF_LOCKED_OUT()				\
		if (*oclsr & OCLSR_ERLO) return EONCE_ERR_LOCKED_OUT; \
		if (!(*oclsr & OCLSR_CLU)) { *oclsr = 0xA; *oclsr = 0x5; }

#define _EONCE_RETURN_IF_UNIT_OUT_OF_RANGE(unit)	\
		if (unit >= _eonce_units) return EONCE_ERR_UNIT_OUT_OF_RANGE;

#define _EONCE_DO_CHECKS()		\
		_EONCE_DECLARE_OCLSR	\
		_EONCE_RETURN_IF_NOT_INITIALIZED() \
		_EONCE_RETURN_IF_LOCKED_OUT()
		
#define _EONCE_DO_CHECKS_WITH_UNIT(unit)	\
		_EONCE_DECLARE_OCLSR	\
		_EONCE_RETURN_IF_NOT_INITIALIZED() \
		_EONCE_RETURN_IF_UNIT_OUT_OF_RANGE(unit) \
		_EONCE_RETURN_IF_LOCKED_OUT()
		


void _eonce_Initialize(	unsigned long baseAddr,
						unsigned int units)
{
	_eonce_baseAddr = (void *)baseAddr;
	_eonce_units = units;
}


int _eonce_SetTrigger(	unsigned int unit,
						unsigned long options,
						unsigned long value1,
						unsigned long value2,
						unsigned long mask,
						unsigned int counter)
{
	unsigned long *obcr, *obar1, *obar2, *obmsk;
	unsigned int *obcntr, *ocr;
	unsigned int unitOffset;
	_EONCE_DO_CHECKS_WITH_UNIT(unit)
	
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	if (unit == 0)
	{
		obcr = (unsigned long *)_eonce_baseAddr + OBCR_OFFSET;
		obar1 = (unsigned long *)_eonce_baseAddr + OBAR1_OFFSET;
		obar2 = (unsigned long *)_eonce_baseAddr + OBAR2_OFFSET;
		obmsk = (unsigned long *)_eonce_baseAddr + OBMSK_OFFSET;
		obcntr = (unsigned int *)_eonce_baseAddr + OBCNTR_OFFSET;
	}
	else
	{
		unitOffset = (unit - 1) * OB_UNIT_REG_OFFSET;
		obcr = (unsigned long *)_eonce_baseAddr + OB1CR_OFFSET - unitOffset;
		obar1 = (unsigned long *)_eonce_baseAddr + OB1AR1_OFFSET - unitOffset;
		obar2 = (unsigned long *)_eonce_baseAddr + OB1AR2_OFFSET - unitOffset;
		obmsk = (unsigned long *)_eonce_baseAddr + OB1MSK_OFFSET - unitOffset;
		obcntr = (unsigned int *)_eonce_baseAddr + OB1CNTR_OFFSET - unitOffset;
	}
	
	*ocr &= ~OCR_PWU;
	
	*obcr = options;
	*obar1 = value1;
	*obar2 = value2;
	*obmsk = mask;
	
	if (counter == 0)
		counter = 1;
	*obcntr = counter - 1;
	
	*ocr |= OCR_PWU;
	
	_eonce_inUse = 1;
	
	return EONCE_ERR_NONE;
}


int _eonce_SetCounterTrigger(	unsigned int unit,
								unsigned long options,
								unsigned long value1,
								unsigned long value2,
								unsigned long mask,
								unsigned int counter,
								unsigned long counter2)
{
	unsigned long *obcr, *obar1, *obar2, *obmsk, *oscntr;
	unsigned int *obcntr, *ocr;
	unsigned int unitOffset;
	_EONCE_DO_CHECKS_WITH_UNIT(unit)
	
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	oscntr = (unsigned long *)_eonce_baseAddr + OSCNTR_OFFSET;
	
	if (unit == 0)
	{
		obcr = (unsigned long *)_eonce_baseAddr + OBCR_OFFSET;
		obar1 = (unsigned long *)_eonce_baseAddr + OBAR1_OFFSET;
		obar2 = (unsigned long *)_eonce_baseAddr + OBAR2_OFFSET;
		obmsk = (unsigned long *)_eonce_baseAddr + OBMSK_OFFSET;
		obcntr = (unsigned int *)_eonce_baseAddr + OBCNTR_OFFSET;
	}
	else
	{
		unitOffset = (unit - 1) * OB_UNIT_REG_OFFSET;
		obcr = (unsigned long *)_eonce_baseAddr + OB1CR_OFFSET - unitOffset;
		obar1 = (unsigned long *)_eonce_baseAddr + OB1AR1_OFFSET - unitOffset;
		obar2 = (unsigned long *)_eonce_baseAddr + OB1AR2_OFFSET - unitOffset;
		obmsk = (unsigned long *)_eonce_baseAddr + OB1MSK_OFFSET - unitOffset;
		obcntr = (unsigned int *)_eonce_baseAddr + OB1CNTR_OFFSET - unitOffset;
	}
	
	*ocr &= ~OCR_PWU;
	
	*obcr = options;
	*obar1 = value1;
	*obar2 = value2;
	*obmsk = mask;
	*obcntr = counter;
	if (counter2 != 0)
		*oscntr = counter2;
		
	*ocr |= OCR_PWU;
	
	_eonce_inUse = 1;
	
	return EONCE_ERR_NONE;
}


int _eonce_ClearTrigger( unsigned int unit )
{
	unsigned long *obcr;
	unsigned int *ocr;
	_EONCE_DO_CHECKS_WITH_UNIT(unit)
	
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	if (unit == 0)
		obcr = (unsigned long *)_eonce_baseAddr + OBCR_OFFSET;
	else
		obcr = (unsigned long *)_eonce_baseAddr + OB1CR_OFFSET - ((unit - 1) * OB_UNIT_REG_OFFSET);
		
	*ocr &= ~OCR_PWU;
	*obcr = 0;
	*ocr |= OCR_PWU;
	
	_eonce_inUse = 0;
	
	return EONCE_ERR_NONE;
}


int _eonce_GetCounters(	unsigned int unit,
						unsigned int *counter,
						unsigned long *counter2)
{
	unsigned long *oscntr;
	unsigned int *obcntr;
	_EONCE_DO_CHECKS_WITH_UNIT(unit)
	
	oscntr = (unsigned long *)_eonce_baseAddr + OSCNTR_OFFSET;
	
	if (unit == 0)
		obcntr = (unsigned int *)_eonce_baseAddr + OBCNTR_OFFSET;
	else
		obcntr = (unsigned int *)_eonce_baseAddr + OB1CNTR_OFFSET - ((unit - 1) * OB_UNIT_REG_OFFSET);
		
	if (counter)
		*counter = *obcntr;
	if (counter2)
		*counter2 = *oscntr;
		
	return EONCE_ERR_NONE;
}


int _eonce_GetCounterStatus(	char *counterIsZero,
								char *counterIsStopped)
{
	unsigned int *osr, osrVal;
	_EONCE_DO_CHECKS()
	
	osr = (unsigned int *)_eonce_baseAddr + OSR_OFFSET;
	
	osrVal = *osr;
	*counterIsZero = (osrVal & OSR_CZ) ? 1 : 0;
	*counterIsStopped = (osrVal & OSR_CS) ? 1 : 0;
	
	return EONCE_ERR_NONE;
}


int _eonce_SetupTraceBuffer( unsigned int options )
{
	unsigned int *otbcr, *ocr;
	_EONCE_DO_CHECKS()
	
	otbcr = (unsigned int *)_eonce_baseAddr + OTBCR_OFFSET;
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	*ocr &= ~OCR_PWU;
	*otbcr = options;
	*ocr |= OCR_PWU;
	
	return EONCE_ERR_NONE;
}


int _eonce_GetTraceBuffer(	unsigned int *count,
							unsigned long *buffer)
{
	unsigned int *otbcr, otbcrOrig, *otbpr, otbprOrig, *osr;
	unsigned int realCount = 8;
	unsigned int startIndex = 0;
	unsigned long *otb, readBuffer[8];
	int i,j;
	_EONCE_DO_CHECKS()
	
	otbcr = (unsigned int *)_eonce_baseAddr + OTBCR_OFFSET;
	otbpr = (unsigned int *)_eonce_baseAddr + OTBPR_OFFSET;
	osr = (unsigned int *)_eonce_baseAddr + OSR_OFFSET;
	otb = (unsigned long *)_eonce_baseAddr + OTB_OFFSET;
	
	otbcrOrig = *otbcr;
	*otbcr |= OTBCR_TBH;
	
	otbprOrig = *otbpr;
	
	if (!_eonce_traceBufferFull)
	{
		if (*osr & OSR_TBFL)
			_eonce_traceBufferFull = 1;
	}
	
	if (!_eonce_traceBufferFull)
	{
		realCount = otbprOrig;
		startIndex = 8 - realCount;
	}
	
	if (buffer == 0)
	{
		*count = realCount;
		*otbcr = otbcrOrig;
		return EONCE_ERR_NONE;
	}
	
	if (*count < realCount)
		startIndex += realCount - *count;
	
	if (realCount < *count)
		*count = realCount;
		
	for (i=0; i<8; i++)
		readBuffer[i] = *otb;
	
	for (i=startIndex,j=0; j<*count; i++,j++)
		buffer[j] = readBuffer[i];
	
	*otbcr = otbcrOrig;
	
	return EONCE_ERR_NONE;
}


int _eonce_ClearTraceBuffer()
{
	unsigned int *otbcr, otbcrOrig, *otbpr, *ocr;
	_EONCE_DO_CHECKS()
	
	otbcr = (unsigned int *)_eonce_baseAddr + OTBCR_OFFSET;
	otbpr = (unsigned int *)_eonce_baseAddr + OTBPR_OFFSET;
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	*ocr &= ~OCR_PWU;
	otbcrOrig = *otbcr;
	*otbcr = otbcrOrig |= OTBCR_TBH;
	*otbpr = 0;
	*otbcr = otbcrOrig;
	_eonce_traceBufferFull = 0;
	*ocr |= OCR_PWU;
	
	return EONCE_ERR_NONE;
}


int _eonce_StartTraceBuffer()
{
	unsigned int *otbcr, *ocr;
	_EONCE_DO_CHECKS()
	
	otbcr = (unsigned int *)_eonce_baseAddr + OTBCR_OFFSET;
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	*ocr &= ~OCR_PWU;
	*otbcr &= ~OTBCR_TBH;
	*ocr |= OCR_PWU;
	
	return EONCE_ERR_NONE;
}


int _eonce_HaltTraceBuffer()
{
	unsigned int *otbcr, *ocr;
	_EONCE_DO_CHECKS()
	
	otbcr = (unsigned int *)_eonce_baseAddr + OTBCR_OFFSET;
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	*ocr &= ~OCR_PWU;
	*otbcr |= OTBCR_TBH;
	*ocr |= OCR_PWU;
	
	return EONCE_ERR_NONE;
}


int _eonce_EnableDEBUGEV( char enable )
{
	unsigned int *ocr, ocrVal;
	_EONCE_DO_CHECKS()
	
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	ocrVal = *ocr;
	if (enable)
		ocrVal |= OCR_DEVEN;
	else
		ocrVal &= ~OCR_DEVEN;
	*ocr = ocrVal;
	
	return EONCE_ERR_NONE;
}


int _eonce_EnableLimitTrigger( char enable )
{
	unsigned int *ocr, ocrVal;
	_EONCE_DO_CHECKS()
	
	ocr = (unsigned int *)_eonce_baseAddr + OCR_OFFSET;
	
	ocrVal = *ocr;
	if (enable)
		ocrVal |= OCR_LTE;
	else
		ocrVal &= ~OCR_LTE;
	*ocr = ocrVal;
	
	return EONCE_ERR_NONE;
}