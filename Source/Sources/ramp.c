#include "ramp.h"

Frac16 Ramp(Frac16 wd, tRampParams * params)
{

	__turn_on_sat();
	if(params->wramp > 0)
	{
		if(wd > params->wramp)
		{
			params->wramp = add(params->wramp,mult(params->dt, params->kup));
			params->wramp = params->wramp > wd ? wd : params->wramp;
		}
		if(wd < params->wramp)
		{
			params->wramp = sub(params->wramp,mult(params->dt, params->kdwn));
			params->wramp = params->wramp < wd ? wd : params->wramp;
		}
	}
	else
	{
		if(wd > params->wramp)
		{
			params->wramp = add(params->wramp,mult(params->dt, params->kdwn));
			params->wramp = params->wramp > wd ? wd : params->wramp;
		}
		if(wd < params->wramp)
		{
			params->wramp = sub(params->wramp,mult(params->dt, params->kup));
			params->wramp = params->wramp < wd ? wd : params->wramp;
		}
	}	
	__turn_off_sat();
	return params->wramp;
}
