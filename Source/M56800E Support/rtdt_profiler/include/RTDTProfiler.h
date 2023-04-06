

#ifndef __RTDT_PROFILER__
#define __RTDT_PROFILER__


typedef   long int32;
typedef   unsigned long uint32;
typedef   short int16;
typedef   unsigned short uint16;

typedef   unsigned char	bool;

typedef struct CInt64 {
	int32		hi;						//	high 32-bit word
	uint32		lo;						//	low 32-bit word
}	CInt64;

typedef CInt64 TimeInterval, *TimeIntervalPtr;


void RTDT_ProfilerInit(void);
void RTDT_ProfilerDump(char* filename);
void RTDT_ProfilerSetStatus(short on);
short RTDT_ProfilerGetStatus(void);
void RTDT_ProfilerClear(void);
void RTDT_ProfilerTerm(void);

void RTDT_TraceClear(void);
void RTDT_TraceSetStatus(short on);
short RTDT_TraceGetStatus(void);


#endif // __RTDT_PROFILER__