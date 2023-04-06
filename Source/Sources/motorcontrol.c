#include "motorcontrol.h"
#include "hardwarelayer.h"


MC_2PhSyst Ualbe;
MC_3PhSyst Uabc;

MC_3PhSyst Upwm;

MC_3PhSyst 	Iabc;
MC_2PhSyst 	Ialbe;
MC_DqSyst 	Ixy;
Frac16		Iabs;




Frac16 omegat = FRAC16(0.0);
Frac16 Um = FRAC16(0.5);
Frac16 Usin;
Frac16 freq = FRAC16(0.5);			// fmax = 100 Hz
Frac16 k = FRAC16(0.5);
Frac16 I=FRAC16(0.1);		// Umax = 80v, Imax = 10A	


Word16 posDiff;
Word16 speed;
MC_Angle angle;
Frac16 absPos;

MC_PiParams PIparams;
Frac16 speed_desired = FRAC16(0.0);
Frac16 speed_ramp;
Frac16 PIoutput;
int enableRamp = 0;

tRampParams ramp;

int counter = 0;
tControl CONTROL;



void MotorControlInit()
{
	/* load input variable by data */
	PIparams.propGain = FRAC16(0.5); /* 0.5*2-1=0.25 */
	PIparams.propGainSc = -2;
	PIparams.integGainSc = 0;
	PIparams.integGain = FRAC16(0.5);
	PIparams.posPiLimit = FRAC16(0.95);
	PIparams.negPiLimit = FRAC16(-0.95);
	PIparams.integPartK_1= 0;
	speed_desired = FRAC16(0.5);
	
	ramp.kup = FRAC16(0.01);
    ramp.kdwn = FRAC16(0.01);
    ramp.dt = FRAC16(0.1);
    enableRamp = 1;
    CONTROL = CTRL_SLIP;
    
    Ualbe.alpha = 0;
    Ualbe.beta = 0;
    Uabc.a = 0;
    Uabc.b = 0;
    Uabc.c = 0;

    Upwm.a = FRAC16(0.5);
    Upwm.b = FRAC16(0.5);
    Upwm.c = FRAC16(0.5);

    Iabc.a = 0;
    Iabc.b = 0;
    Iabc.c = 0;
    
    
    Ialbe.alpha = 0;
    Ialbe.beta = 0;
    Ixy.d = 0;
    Ixy.q = 0;
    
    Iabs = 0;




    omegat = FRAC16(0.0);
    Um = FRAC16(0.5);
    Usin = 0;
    freq = FRAC16(0.5);			// fmax = 100 Hz
    k = FRAC16(0.5);
    I=FRAC16(0.1);		// Umax = 80v, Imax = 10A	


    posDiff = 0;
    speed = 0;
    absPos = 0;

    
    speed_desired = FRAC16(0.0);
    speed_ramp = 0;
    PIoutput = 0;

    counter = 0;
    
	return;
}

void MotorControlFastLoop()
{
	__turn_off_sat();
	omegat = add(omegat,mult(FRAC16(0.02),freq)); // omega = omega + 0.02.freq
	
	__turn_on_sat();
	
	MCLIB_ClarkTrfm(&Ialbe, &Iabc);
	
	MCLIB_ParkTrfm(&Ixy, &Ialbe, &angle);
	
	Iabs = MCLIB_Sqrt(L_add(L_mult(Ixy.d, Ixy.d), L_mult(Ixy.q, Ixy.q)));
	
	Um = abs_s(shl(freq,1));
	if(Um<FRAC16(0.4))
		Um = FRAC16(0.4);
	if(Um>FRAC16(0.9))
		Um = FRAC16(0.9);
	
	Ualbe.alpha = mult(Um,MCLIB_Sin2(omegat));
	Ualbe.beta = mult(Um,MCLIB_Cos2(omegat));
	
	angle.sin = Ualbe.alpha;
	angle.cos = Ualbe.beta;
	
	/* compute Clark Inverse Transformation */
	MCLIB_ClarkTrfmInv (&Uabc, &Ualbe);
	MCLIB_PwmIct(&Ualbe, &Upwm);
	__turn_off_sat();

}

void MotorControlSlowLoop()
{	
	if(enableRamp == 1)
		speed_ramp = Ramp(speed_desired, &ramp);
	else
		speed_ramp = speed_desired;
	
	__turn_on_sat();
	if(CONTROL == CTRL_SLIP)
	{
		PIparams.posPiLimit = FRAC16(0.2);
		PIparams.negPiLimit = FRAC16(-0.2);
		PIoutput =MCLIB_ControllerPI2(speed_ramp, speed, &PIparams);
		freq = add(speed,PIoutput);
		
	}
	else
	{
		if(CONTROL == CTRL_SCALAR)
		{
			PIparams.posPiLimit = FRAC16(1.0);
			PIparams.negPiLimit = FRAC16(-1.0);
			freq = MCLIB_ControllerPI2 (speed_ramp, speed, &PIparams);	
		}
		else
		{
			PIparams.integPartK_1= 0;
		}
	}
	__turn_off_sat();	 
}
