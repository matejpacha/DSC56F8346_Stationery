#ifndef MOTORCONTROL_H
#define MOTORCONTROL_H

#include "qs.h"
#include "mclib.h"
#include "ramp.h"

extern void MotorControlInit();
extern void MotorControlFastLoop();
extern void MotorControlSlowLoop();

typedef enum
{
	CTRL_NONE = 0,
	CTRL_SCALAR = 1,
	CTRL_SLIP = 2
		
} tControl;

//MC_2PhSyst Ualbe;
//MC_3PhSyst Uabc;

extern MC_3PhSyst Upwm;

extern MC_3PhSyst 	Iabc;
//MC_2PhSyst 	Ialbe;
//MC_DqSyst 	Ixy;
extern Frac16		Iabs;

extern MC_Angle angle;
extern Frac16 absPos;
//extern decoder_sEncScale decEncScale;

//extern pwm_sComplementaryValues comp;

//Frac16 omegat = FRAC16(0.0);
extern Frac16 Um;
//Frac16 Usin;
//Frac16 freq = FRAC16(0.5);			// fmax = 100 Hz
//Frac16 k = FRAC16(0.5)
//Frac16 U;
//Frac16 I=FRAC16(0.1);		// Umax = 80v, Imax = 10A	
extern int led_period;

extern int Run;
extern int counter;
extern tControl CONTROL;
//extern decoder_uReg32bit positionReg32;
extern Word16 posDiff;
extern Word16 speed;
//extern adc_tBuff adc_Buff;
extern MC_PiParams PIparams;
extern Frac16 speed_desired;
extern Frac16 speed_ramp;
extern Frac16 PIoutput;
//extern int enableRamp = 0;

extern tRampParams ramp;












#endif //MOTORCONTROL_H
