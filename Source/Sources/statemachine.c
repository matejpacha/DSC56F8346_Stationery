#include "statemachine.h"
#include "motorcontrol.h"
#include "hardwarelayer.h"


const PFCN_VOID stateMachine[FSM_NUM_OF_EVENTS][FSM_NUM_OF_STATES] = 
{
	/*				s_init 	| s_ready    | s_calib   | s_speedChck | s_run | s_fault	*/
/*e_init 		*/{stateInit,  stateReady, stateCalib, stateSpdCh, stateRun,  stateInit },
/*e_init_done	*/{stateReady, stateReady, stateCalib, stateSpdCh, stateRun,  stateFault},
/*e_app_on		*/{stateInit,  stateCalib, stateCalib, stateSpdCh, stateRun,  stateFault},
/*e_calib_done 	*/{stateInit,  stateReady, stateSpdCh, stateSpdCh, stateRun,  stateFault},
/*e_at_speed	*/{stateInit,  stateReady, stateCalib, stateSpdCh, stateRun,  stateFault},
/*e_speed_ok	*/{stateInit,  stateReady, stateCalib, stateRun,   stateRun,  stateFault},
/*e_app_off		*/{stateInit,  stateReady, stateReady, stateReady, stateReady,stateFault},
/*e_error		*/{stateFault, stateFault, stateFault, stateFault, stateFault,stateFault},
/*e_reset		*/{stateInit,  stateReady, stateCalib, stateSpdCh, stateRun,  stateReady}
};

tEvents event = e_init;
tStates state = s_init;


/******************************************************/
/*		INIT										  */
/******************************************************/
void stateInit()
{
	if(state != s_init)	
	{
		//On state entry code
		//...
		state = s_init;
		event = e_init;
	}
	// state code here
	//...
	MotorControlInit();
	
	//On state done code
	//if(done) ...
	event = e_init_done;
	//if(error)
	//	event = e_error;
}

/******************************************************/
/*		READY										  */
/******************************************************/
void stateReady()
{
	if(state != s_ready)	
	{
		//On state entry code
		DisableOutput();
		
		state = s_ready;
		event = e_app_off;
	}
	// state code here
	//...
	if(counter++ >= 100) /* period 10ms ~100 Hz*/
	{
		counter = 0;
		UpdateSpeedPos(&posDiff, &speed, &absPos);
	}

	//On state done code
	//if(done) ...
	//event = e_app_off;
}
/******************************************************/
/*		CALIB										  */
/******************************************************/
void stateCalib()
{
	if(state != s_calib)	
	{
		//On state entry code
		//...
		state = s_calib;
		event = e_app_on;
	}
	// state code here
	//...
	adcCalibrate();
	if(counter++ >= 100) /* period 10ms ~100 Hz*/
	{
		counter = 0;
		UpdateSpeedPos(&posDiff, &speed, &absPos);
	}

	//On state done code
	//if(done) ...
	event = e_calib_done;
}
/******************************************************/
/*		SPEED CHECK									  */
/******************************************************/
void stateSpdCh()
{
	if(state != s_speedChck)	
	{
		//On state entry code
		//...
		state = s_speedChck;
		event = e_at_speed;
	}
	// state code here
	if(counter++ >= 100) /* period 10ms ~100 Hz*/
	{
		counter = 0;
		UpdateSpeedPos(&posDiff, &speed, &absPos);
		if((speed < FRAC16(0.1))&&(speed > FRAC16(-0.1)))
		{
			event = e_speed_ok;
		}
	}

	//On state done code
	//if(done) ...
	//event = e_speed_ok;
}
/******************************************************/
/*		RUN										  */
/******************************************************/
void stateRun()
{
	if(state != s_run)	
	{
		//On state entry code
		//...
		ramp.wramp = FRAC16(0.0);
		EnableOutput();
		
		state = s_run;
		event = e_speed_ok;
	}
	// state code here
	MotorControlFastLoop();
	if(counter++ >= 100) /* period 10ms ~100 Hz*/
	{
		counter = 0;
		UpdateSpeedPos(&posDiff, &speed, &absPos);
		MotorControlSlowLoop();
	}
	UpdateOutput(&Upwm);

	//On state done code
	//if(done) ...
	//event = e_app_off;
}
/******************************************************/
/*		FAULT										  */
/******************************************************/
void stateFault()
{
	if(state != s_fault)	
	{
		//On state entry code
		DisableOutput();
		
		state = s_fault;
		event = e_error;
	}
	// state code here
	//...

	//On state done code
	//if(done) ...
	//event = e_reset;
}
