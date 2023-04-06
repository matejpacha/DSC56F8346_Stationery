#ifndef _STATEMACHINE_H
#define _STATEMACHINE_H


typedef enum
{
	e_init 		= 0,
	e_init_done = 1,
	e_app_on	= 2,
	e_calib_done= 3,
	e_at_speed	= 4,
	e_speed_ok	= 5,
	e_app_off	= 6,
	e_error		= 7,
	e_reset		= 8	
} tEvents;
#define FSM_NUM_OF_EVENTS	9

typedef enum
{
	s_init		= 0,
	s_ready		= 1,
	s_calib		= 2,
	s_speedChck = 3,
	s_run		= 4,
	s_fault		= 5
} tStates;
#define FSM_NUM_OF_STATES	6

extern tEvents event;
extern tStates state;

// pointer to function
typedef void (*PFCN_VOID)(void); 

// main state machine table definiton
extern const PFCN_VOID stateMachine[FSM_NUM_OF_EVENTS][FSM_NUM_OF_STATES];

// state functions
extern void stateInit();
extern void stateReady();
extern void stateCalib();
extern void stateSpdCh();
extern void stateRun();
extern void stateFault();
// ...









#endif //_STATEMACHINE_H
