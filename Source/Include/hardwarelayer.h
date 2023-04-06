#ifndef HARDWARELAYER_H
#define HARDWARELAYER_H

#include "qs.h"
#include "intc.h"
#include "gpio.h"
#include "occs.h"
#include "qtimer.h"
#include "sci.h"
#include "fcan.h"

#include "pwm.h"
#include "adc.h"

#include "sys.h"
#include "freemaster.h"
#include "mclib.h"
#include "decoder.h"


extern void adcCalibrate (void);
extern void UpdateSpeedPos(Word16 *pd, Word16 *spd, Frac16 *absp);
extern void InitDevice();
extern void EnableInterrupts();
extern void DisableInterrupts();

extern void FastLoop();
extern void UpdateCurrents(MC_3PhSyst *adc);
extern void UpdateOutput(MC_3PhSyst * upwm);
extern void EnableOutput();
extern void DisableOutput();


#endif //HARDWARELAYER_H
