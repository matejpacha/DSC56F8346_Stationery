/* DSP56800E EOnCE Library
 Copyright ©2002 Freescale Corporation.  All rights reserved.
*/

#ifndef _56800E_EONCE_LIB_H
#define _56800E_EONCE_LIB_H


/* function prototypes */
void	_eonce_Initialize(	unsigned long baseAddr,
							unsigned int units);
int		_eonce_SetTrigger(	unsigned int unit,
							unsigned long options, /* OR in options defined below */
							unsigned long value1,
							unsigned long value2,
							unsigned long mask,
							unsigned int counter); /* see trigger mode key for N */
int		_eonce_SetCounterTrigger(	unsigned int unit,
									unsigned long options, /* OR in options defined below */
									unsigned long value1,
									unsigned long value2,
									unsigned long mask,
									unsigned int counter, /* counter must be preset with count, counting proceeds backwards */
									unsigned long counter2); /* if EXTEND_COUNTER option used, counter contains least significant 16 bits, counter2 contains most significant 24 bits */
int		_eonce_ClearTrigger( unsigned int unit );
int		_eonce_GetCounters(	unsigned int unit,
							unsigned int *counter,
							unsigned long *counter2 );
int		_eonce_GetCounterStatus(	char *counterIsZero,
									char *counterIsStopped);
int		_eonce_SetupTraceBuffer( unsigned int options );
int		_eonce_GetTraceBuffer(	unsigned int *count,
								unsigned long *buffer);
int		_eonce_ClearTraceBuffer();
int		_eonce_StartTraceBuffer();
int		_eonce_HaltTraceBuffer();
int		_eonce_EnableDEBUGEV( char enable );
int		_eonce_EnableLimitTrigger( char enable );


/* Processor specific defines and macros */
#define DEFAULT_EONCE_BASE_ADDR		0xFFFF00
#define M56838E_EONCE_BASE_ADDR		DEFAULT_EONCE_BASE_ADDR
#define M56852E_EONCE_BASE_ADDR		DEFAULT_EONCE_BASE_ADDR
#define M56858E_EONCE_BASE_ADDR		DEFAULT_EONCE_BASE_ADDR

#define DEFAULT_EONCE_BP_UNITS		1
#define M56838E_EONCE_BP_UNITS		DEFAULT_EONCE_BP_UNITS
#define M56852E_EONCE_BP_UNITS		DEFAULT_EONCE_BP_UNITS
#define M56858E_EONCE_BP_UNITS		DEFAULT_EONCE_BP_UNITS

#define _eonce_Initialize56838E()	_eonce_Initialize( M56838E_EONCE_BASE_ADDR, M56838E_EONCE_BP_UNITS )
#define _eonce_Initialize56852E()	_eonce_Initialize( M56852E_EONCE_BASE_ADDR, M56852E_EONCE_BP_UNITS )
#define _eonce_Initialize56858E()	_eonce_Initialize( M56858E_EONCE_BASE_ADDR, M56858E_EONCE_BP_UNITS )


/* Error codes */
#define EONCE_ERR_NONE				0  /* no error */
#define EONCE_ERR_NOT_INITIALIZED	1  /* function called before _eonce_Initialize() */
#define EONCE_ERR_UNIT_OUT_OF_RANGE	2  /* passed in a breakpoint unit higher than allowed */
#define EONCE_ERR_LOCKED_OUT		3  /* the debugger has locked out the core's EOnCE access */


/* Special counter modes
// OR in one from this list when setting a counter trigger */
#define PCLK_CLOCK_CYCLES		0x800004
#define CLK_CLOCK_CYCLES		0x800008
#define INSTRUCTIONS_EXECUTED	0x80000C
#define TRACE_BUFFER_WRITES		0x800010
#define COUNTER_START_TRIGGERS	0x800014


/* Key for trigger modes:
//
// B1	breakpoint 1; value set in value1
// B2	breakpoint 2; value set in value2
// P	p-memory address; this will be followed by a type of access
// X	x-memory address; this will be followed by a type of access
// D	value being read from/written to x-memory
// A	memory access
// R	memory read
// W	memory write
// F	memory fetch; will only follow a P
// OR	links two subtriggers by a logical or
// AND	links two subtriggers by a logical and
// THEN	creates a sequence; first subtrigger must occur, then second
//		subtrigger must occur to complete the trigger
// N	the subtrigger it follows must occur N times as set in the
//		count parameter; if N follows an operation, then the combination
//		of the subtriggers must occur N times;
//		(count - 1) will be written to the BCNTR register 
// STB	subtrigger starts the trace buffer
// HTB	subtrigger halts the trace buffer */


/* Trigger modes - OR in one from this list when setting a non-counter trigger */
#define B1PA_N				0x700000
#define B1PR_N				0x500000
#define B1PW_N				0x600000
#define B2PF_N				0x000300
#define B1XA_OR_B2PF_N		0x300200
#define B1XA_N_OR_B2PF		0x300100
#define B1PF_OR_B2PF_N		0x400200
#define B1PA_OR_B2PF_N		0x700200
#define B1PA_N_OR_B2PF		0x700100
#define B1PF_OR_N_B2PF		0x400400
#define B1PA_OR_N_B2PF		0x700400
#define B1XR_AND_N_B2DR		0x140500  /* becomes B1XR_N when mask set to 0 */
#define B1XW_AND_N_B2DW		0x280500  /* becomes B1XW_N when mask set to 0 */
#define B1XA_AND_N_B2DRW	0x3C0500  /* becomes B1XA_N when mask set to 0 */
#define B1PF_N_THEN_B2PF	0x400900
#define B2PF_THEN_B1PF_N	0x400800
#define B1PA_N_THEN_B2PF	0x700900
#define B1PA_THEN_B2PF_N	0x700A00
#define B2PF_N_THEN_B1PA	0x700B00
#define B2PF_THEN_B1PA_N	0x700800
#define B1XA_N_THEN_B2PF	0x300900
#define B1XA_THEN_B2PF_N	0x300A00
#define B2PF_N_THEN_B1XA	0x300B00
#define B2PF_THEN_B1XA_N	0x300800
#define B1XW_N_THEN_B2PF	0x200900
#define B1XW_THEN_B2PF_N	0x200A00
#define B2PF_N_THEN_B1XW	0x200B00
#define B2PF_THEN_B1XW_N	0x200800
#define B1XR_N_THEN_B2PF	0x100900
#define B1XR_THEN_B2PF_N	0x100A00
#define B2PF_N_THEN_B1XR	0x100B00
#define B2PF_THEN_B1XR_N	0x100800
#define B1PF_STB_B2PF_HTB	0x400C00
#define B1PA_STB_B2PF_HTB	0x700C00
#define B2PF_STB_B1PA_HTB	0x700D00

/* additional keys for counter triggers
//
// SC	start counter
// HC	halt counter

// Counter trigger modes - OR in one from this list when setting a counter trigger
// Except for the final three triggers (start and stop triggers) these
// represent counter stop triggers. */
#define B1PA				0x700000
#define B1PR				0x500000
#define B1PW				0x600000
#define B2PF				0x000300
#define B1XA_OR_B2PF		0x300200
#define B1PF_OR_B2PF		0x400200
#define B1PA_OR_B2PF		0x700200
#define B1XR_AND_B2DR		0x140500  /* becomes B1XR when mask set to 0 */
#define B1XW_AND_B2DW		0x280500  /* becomes B1XW when mask set to 0 */
#define B1XA_AND_B2DRW		0x3C0500  /* becomes B1XA when mask set to 0 */
#define B1PF_THEN_B2PF		0x400900
#define B1PA_THEN_B2PF		0x700900
#define B2PF_THEN_B1PA		0x700800
#define B1XA_THEN_B2PF		0x300900
#define B2PF_THEN_B1XA		0x300800
#define B1XW_THEN_B2PF		0x200900
#define B2PF_THEN_B1XW		0x200800
#define B1XR_THEN_B2PF		0x100900
#define B2PF_THEN_B1XR		0x100800
#define B1PF_SC_B2PF_HC		0x400C00
#define B1PA_SC_B2PF_HC		0x700C00
#define B2PF_SC_B1PA_HC		0x700D00


/* Breakpoint 2 data selection modes
// When a subtrigger indicates a data comparison, the comparison is only
// made if the size of the data moved (as indicated by the instruction)
// matches the expected size indicated by the following options
// OR in one from this list only if breakpoint 2 is comparing data values (mode above includes B2D) */
#define B2D_BYTE			0x010000
#define B2D_WORD			0x020000
#define B2D_LONG			0x030000


/* Breakpoint 2 compare invert option
// this is optional, OR it in if you want the result of breakpoint 2
// comparison to be inverted (logical NOT) */
#define INVERT_B2_COMPARE	0x008000


/* Extend counter option
// This is optional, OR it in if you want to extend the counter to 40 bits
// by using the OSCNTR register as the most significant 24 bits
// The counter can only be extended if using breakpoint unit 0
// WARNING:  It is recommended that this option not be used if the processor
// is going to enter debug mode (breakpoint, console or file I/O) during counting
// because the OSCNTR is needed for stepping and the count value would most
// likely be corrupted */
#define EXTEND_COUNTER		0x001000


/* Accumulating trigger options - not used with counter triggers
// Indicates the sequence of events that must occur to trigger a unit action
// core events are DEBUGEV's and limit triggers when they are enabled

// OR in one from this list if setting the trigger for unit 0
// do not select an option that requires a previous unit to trigger first
// if a previous unit does not exist, as nothing will happen */
#define PREV_UNIT_OR_THIS_TRIGGER_OR_CORE_EVENT		0x800000
#define PREV_UNIT_THEN_THIS_TRIGGER_OR_CORE_EVENT	0x000040  /* do not use this option if a previous unit does not exist */
#define THIS_TRIGGER_THEN_CORE_EVENT				0x800080
#define PREV_UNIT_THEN_THIS_TRIGGER_THEN_CORE_EVENT	0x0000C0  /* do not use this option if a previous unit does not exist */

/* OR in one from this list if setting the trigger for unit other than unit 0 */
#define PREV_UNIT_OR_THIS_TRIGGER					0x800000
#define PREV_UNIT_THEN_THIS_TRIGGER					0x000040  /* do not use this option if a previous unit does not exist */


/* Unit action options - OR in one from this list when setting a non-counter trigger */
#define UNIT_ACTION			0x000000  /* enters debug if unit 0, else passes signal on to next unit */
#define INTERRUPT_CORE		0x000001
#define HALT_TRACE_BUFFER	0x000002
#define START_TRACE_BUFFER	0x000003

/* Unit action options - OR in one from this list when setting a counter trigger
// If zero before trigger is specified, the action occurs only if the counter
// reaches zero before a counter stop trigger occurs.
// If trigger before zero is specified, the action occurs only if the counter
// stop trigger occurs before the counter reaches zero */
#define NO_ACTION							0x000002  /* the counter status bits still get set properly */
#define UNIT_ACTION_ZERO_BEFORE_TRIGGER		0x000000  /* enters debug if unit 0, else passes signal on to next unit */
#define INTERRUPT_CORE_ZERO_BEFORE_TRIGGER	0x000001
#define UNIT_ACTION_TRIGGER_BEFORE_ZERO		0x000020  /* enters debug if unit 0, else passes signal on to next unit */
#define INTERRUPT_CORE_TRIGGER_BEFORE_ZERO	0x000021


/* Trace buffer options - used to setup trace buffer

// Capture options - OR in as many of these as you need */
#define CAPTURE_CHANGE_OF_FLOW_NOT_TAKEN	0x08
#define CAPTURE_CHANGE_OF_FLOW_INTERRUPT	0x10
#define CAPTURE_CHANGE_OF_FLOW_SUBROUTINE	0x20
#define CAPTURE_CHANGE_OF_FLOW_0			0x40 /* this includes all forward branches and JCC backward branches */
#define CAPTURE_CHANGE_OF_FLOW_1			0x80 /* this includes all backward branches except JCC backward branches */

/* Halt trace buffer option
// This is optional, OR it in if you want the trace buffer to start off halted */
#define TRACE_BUFFER_HALTED					0x04

/* Trace buffer full actions
// OR in one from this list */
#define TB_FULL_NO_ACTION					0x00 /* capture continues, overwriting oldest entries */
#define TB_FULL_HALT_CAPTURE				0x01
#define TB_FULL_DEBUG						0x02
#define TB_FULL_INTERRUPT					0x03

#endif  /* _56800E_EONCE_LIB_H */