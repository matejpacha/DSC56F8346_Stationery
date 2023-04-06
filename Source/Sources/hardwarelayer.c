#include "hardwarelayer.h"


extern int led_period;

decoder_sEncScale decEncScale;
decoder_uReg32bit positionReg32;

pwm_sComplementaryValues comp;

adc_tBuff adc_Buff;

void InitDevice()
{
	
	led_period = 5000;
	
	// initialize SYS
	ioctl(SYS, SYS_INIT, NULL);
    
    // initialize UART 
    ioctl(SCI_0, SCI_INIT, NULL);
    
    ioctl(QTIMER_A0, QT_INIT, NULL);
    ioctl(QTIMER_C3, QT_INIT, NULL);
    
    ioctl(GPIO_D, GPIO_INIT, NULL);
    
    ioctl(PWM_B, PWM_INIT, NULL);
    
    ioctl(ADC_B, ADC_INIT, NULL);
    
    ioctl(DEC_0, DEC_INIT, NULL );

    decEncScale.EncPulses = 128;
   	ioctl( DEC_0, DEC_CALCULATE_SCALE_COEF, &decEncScale );

   	ioctl(FCAN, FCAN_INIT, NULL);
}

void EnableInterrupts()
{
	// initialize & enable interrupts
    ioctl(INTC, INTC_INIT, NULL);
    archEnableInt();
}

void DisableInterrupts()
{
	archDisableInt();
}


// 10 kHz
#pragma interrupt saveall
void ISR_QTA0_Cmp()
{
	static int led_counter = 0;
	
	if(led_counter++ > led_period)
	{
		led_counter = 0;
		ioctl(GPIO_D, GPIO_TOGGLE_PIN, BIT_1);
	}
	ioctl(QTIMER_A0, QT_CLEAR_FLAG, QT_COMPARE_FLAG);
}

#pragma interrupt saveall
void ISR_PWMB_reload()
{
	FastLoop();
		
	ioctl(PWM_B, PWM_CLEAR_RELOAD_FLAG, NULL);
}

#pragma interrupt saveall
void ISR_ADCB_eosi()
{
	static MC_3PhSyst currents;
	
	ioctl(ADC_B, ADC_READ_ALL_SAMPLES, adc_Buff);
	currents.a = (Frac16) adc_Buff[0];
	currents.b = (Frac16) adc_Buff[2];
	currents.c = (Frac16) adc_Buff[4];
	UpdateCurrents(&currents);

	ioctl(ADC_B, ADC_CLEAR_STATUS_EOSI, NULL);
}

/***********************************************************************/
/*                  Function for calibrate of ADC                      */
/***********************************************************************/
void adcCalibrate (void)
{
	static volatile signed  int i = 0;
	static volatile signed  int NUM_ADC_SAMPLES = 10;

	Frac32 offset_Ia = 0;
	Frac32 offset_Ib = 0;
	Frac32 offset_Ic = 0;
	
	ioctl(ADC_B, ADC_WRITE_OFFSET0, 0);
	ioctl(ADC_B, ADC_WRITE_OFFSET4, 0);
	ioctl(ADC_B, ADC_WRITE_OFFSET2, 0);

	/* disable ADC operation                                            */ 
	ioctl(ADC_B, ADC_STOP, ADC_ON);
	ioctl(ADC_B, ADC_INT_DISABLE, ADC_END_OF_SCAN);
	ioctl(ADC_B, ADC_CLEAR_STATUS_EOSI, NULL);
	/* re-enable ADC operation                   */
	ioctl(ADC_B, ADC_STOP, ADC_OFF);
	/* measurement loop               */
	for (i=0; i<(1<<NUM_ADC_SAMPLES); i++)
	{
		/* wait for end of scan flag                    */
		while (!ioctl(ADC_B, ADC_GET_STATUS_EOSI, NULL))
			ioctl(ADC_B, ADC_CLEAR_STATUS_EOSI, NULL);
		
		offset_Ia += (int)ioctl(ADC_B, ADC_READ_SAMPLE, 0);
		offset_Ib += (int)ioctl(ADC_B, ADC_READ_SAMPLE, 4);
		offset_Ic += (int)ioctl(ADC_B, ADC_READ_SAMPLE, 2);
		//offset_Udc += (int)ioctl(ADC_B, ADC_READ_SAMPLE, 1);
	}
	offset_Ia = L_shr(offset_Ia,NUM_ADC_SAMPLES);
	offset_Ib = L_shr(offset_Ib,NUM_ADC_SAMPLES);
	offset_Ic = L_shr(offset_Ic,NUM_ADC_SAMPLES);
	//offset_Udc = L_shr(offset_Udc,NUM_ADC_SAMPLES);

	/* write offset values  to offset registers                          */
	ioctl(ADC_B, ADC_WRITE_OFFSET0, offset_Ia);
	ioctl(ADC_B, ADC_WRITE_OFFSET4, offset_Ib);
	ioctl(ADC_B, ADC_WRITE_OFFSET2, offset_Ic);
	//ioctl(ADC_B, ADC_WRITE_OFFSET1, offset_Udc);

	/* rewrite old parameters of conversion                            */  
	ioctl(ADC_B, ADC_STOP, ADC_ON);
	ioctl(ADC_B, ADC_INT_ENABLE, ADC_END_OF_SCAN);
	ioctl(ADC_B, ADC_STOP, ADC_OFF);
	i = 0;
	NUM_ADC_SAMPLES = 10;
}


void UpdateSpeedPos(Word16 *pd, Word16 *spd, Frac16 *absp)
{
	*pd = ioctl( DEC_0, DEC_READ_POSITION_DIFFERENCE, NULL );
	*spd = shl(*pd,7);
	ioctl( DEC_0, DEC_READ_POSITION, &positionReg32 );
	*absp = extract_l(ioctl(DEC_0,DEC_GET_SCALED_POSITION,&decEncScale));
}

void UpdateOutput(MC_3PhSyst * upwm)
{
	comp.pwmChannel_0_Value = upwm->a;
	comp.pwmChannel_2_Value = upwm->b;
	comp.pwmChannel_4_Value = upwm->c;
	
	ioctl(PWM_B, PWM_UPDATE_VALUE_REGS_COMPL, &comp);
}

void EnableOutput()
{
	ioctl(PWM_B, PWM_OUTPUT_PAD, PWM_ENABLE);
}

void DisableOutput()
{
	ioctl(PWM_B, PWM_OUTPUT_PAD, PWM_DISABLE);
}
