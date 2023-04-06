#ifndef _RAMP_H
#define _RAMP_H

#include "qs.h"
#include "types.h"


/** Ramp parameters
*/
typedef struct
{
	Frac16	kup;		/// slope for ramping up (for both positive or negative input)
	Frac16	kdwn;		/// slope for ramping down (for both positive or negative input)
	Frac16	dt;			/// time constant for the ramp calculation
	Frac16	wramp;		/// internal memory for the ramp
} tRampParams;


/** Ramp function for periodic interrupt
*	Calculates a ramp of the input signal based on given parameters
*	Ramping up and down is calculated for absolute value of the input signal,
*	thus up-slope is valid for increasing the number in positive direction as well
*	as for negative direction (the same is valid for down-slope)
*
*	Basic equation:	output = wramp = wramp + dt * kup; 
*					output = wramp = wramp - dt * kdwn;
*
*	Input:
*		tRampParams * params ... Ramp parameters reference
*		Frac16 wd .............. Input signal - valid range -1.0 to 1.0
*	Output:
*		Frac16 .... resulting ramped signal
*
*	Special issues:
*		The function turns on and off the saturation mode
*/
extern Frac16 Ramp(Frac16 wd, tRampParams * params);




#endif //_RAMP_H