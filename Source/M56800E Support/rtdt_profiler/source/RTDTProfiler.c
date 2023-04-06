

#include "RTDTProfiler.h"
#include "RTDTProfilerInt.h"
#include "RTDT.h"

short gRTDTProfilerStatus = 0;
short gRTDTTraceStatus = 0;
short gRTDTProfilerDone = 0;

extern unsigned int gTxReady;

void RTDT_HandleFuncNameRequest();


void RTDT_ProfilerInit(void)
{
	RTDT_ProfilerStartTimeBase();
	RTDT_Enable();
	gRxHandler = RTDT_HandleFuncNameRequest;
	gRTDTProfilerStatus = 1;
}

//void RTDT_ProfilerDump(char* filename);

void RTDT_ProfilerSetStatus(short on)
{
	gRTDTProfilerStatus = on;
}

short RTDT_ProfilerGetStatus(void)
{
	return gRTDTProfilerStatus;
}

//void RTDT_ProfilerClear(void);

void RTDT_ProfilerTerm(void)
{
	gRTDTProfilerStatus = 0;
	gRTDTTraceStatus = 0;
	while (!gTxReady || !gRTDTProfilerDone) ;
}

//void RTDT_TraceClear(void);

void RTDT_TraceSetStatus(short on)
{
	gRTDTTraceStatus = on;
}

short RTDT_TraceGetStatus(void)
{
	return gRTDTTraceStatus;
}
