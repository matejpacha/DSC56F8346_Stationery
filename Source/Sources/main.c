/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* (c) Copyright 2001-2004 Motorola, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* FILE NAME: main.c   
*
* DESCRIPTION: Simple sample application demonstrating the functionality of 
*              FreeMASTER software driver.
*			   
*              The FreeMASTER driver and the SCI module are configured by GCT
*
* TARGET: MC56F8346 device
*
*******************************************************************************/

#include "hardwarelayer.h"
#include "motorcontrol.h"
#include "statemachine.h"

int led_period = 5000;

/*** Protocol ***/
// Frame:				MSB	............................ LSB
//   Byte 0 (Command): 	0|0|0|0|0| RESET | DIRECTION | ON_OFF
//	 Byte 1 (Status ):	0|0|0|0|0| FAULT | DIRECTION | ON_OFF
//	 Byte 2 (Data ID):	unisgned char
//	 Byte 3 (Data L ):	unsigned char
//	 Byte 4 (Data H ):	signed char

// Data ID		Meaning
// 0			Current
// 1			DC Bus Voltage
// 2 			Output Voltage
// 3 			Output Frequency
/****************/

static unsigned int rxFlag = 0;			// SCI0 data recieved flag
static unsigned int sci_data = 0;			// SCI0 data recieved


void wbyte_SCI(unsigned char data);	// Write byte to SCI0

static unsigned int rxBuffer[5];			// recieve buffer
static unsigned int txBuffer[5];			// transmitt buffer

typedef union
{
	unsigned int word;
	unsigned char bytes[2];
	
	struct
	{
		unsigned int bit0 : 1;
		unsigned int bit1 : 1;
		unsigned int bit2 : 1;
		unsigned int bit3 : 1;
		unsigned int bit4 : 1;
		unsigned int bit5 : 1;
		unsigned int bit6 : 1;
		unsigned int bit7 : 1;
		unsigned int bit8 : 1;
		unsigned int bit9 : 1;
		unsigned int bit10: 1;
		unsigned int bit11: 1;
		unsigned int bit12: 1;
		unsigned int bit13: 1;
		unsigned int bit14: 1;
		unsigned int bit15: 1;
	} bits;
	
} SciWord;

static SciWord sciData[4];

static SciWord cmdStatData;

typedef enum
{
	ID_CURRENT 	= 0,
	ID_DCBUS	= 1,
	ID_OUTVOLT	= 2,
	ID_OUTFREQ	= 3
} DATA_ID;

#define MOJA_KONSTANTA	5

static int msg_position = 0;

/*******************************************************************************
*								MAIN function
*******************************************************************************/
int main(void)
{
	InitDevice();
	
    // FreeMASTER initialization
    FMSTR_Init();
    
    EnableInterrupts();
    

	MotorControlInit();
	
		
	    // main application loop
    while (1)
    {
        // This call should be placed in the timer interrupt or anywhere where
        // the recorder sampling should occur.
        

        // The FreeMASTER polling call must be called periodically in the main 
        // application loop to handle the communication interface and protocol. 
        // Only in LONG_INTR FreeMASTER interrupt mode, all the processing is done 
        // during the communication interrupt so the FMSTR_Poll() is not needed
        // (the function is compiled empty in this case).
        
        if(rxFlag == 1)
        {
        	
        	
        	//sci_data
        	switch(msg_position)
        	{
        	
        		case 0:	//CMD
        		case 1: //STAT
        			if(sci_data > 7)
        				msg_position = 0;
        			else
        			{
        				rxBuffer[msg_position] = sci_data;
        				msg_position++;
        			}
        			break;
        		
        		case 2:
        			if(sci_data > 4)
        				msg_position = 0;
        			else
        			{
        				rxBuffer[msg_position] = sci_data;
        				msg_position++;
        			}
        			break;
        		case 3:
        			rxBuffer[msg_position] = sci_data;
        			msg_position++;
        			break;
        		case 4:
        			rxBuffer[msg_position] = sci_data;
        			//Message completed
        			cmdStatData.bytes[0] = rxBuffer[0];
        			cmdStatData.bytes[1] = rxBuffer[1];
        			
        			if(rxBuffer[2] == ID_OUTFREQ)
        			{
        				sciData[ID_OUTFREQ].bytes[0] = rxBuffer[3];
        				sciData[ID_OUTFREQ].bytes[1] = rxBuffer[4];
        			}
        			
        			
        			/// CMD byte processing
        			event 			= cmdStatData.bits.bit0 == 1 ? e_app_on : e_app_off;
        			speed_desired 	= cmdStatData.bits.bit1 == 1 ? sciData[ID_OUTFREQ].word : mult(sciData[ID_OUTFREQ].word, FRAC16(-1.0));
        			if((cmdStatData.bits.bit2 == 1)&&(state == s_fault))
        				event = e_reset;
        			
        			txBuffer[0] = rxBuffer[0];
        			
        			/// STAT byte processing
        			txBuffer[1]  = (state == s_run)    ? 0x01 : 0x00;
        			txBuffer[1] |= (speed > 0) 		   ? 0x02 : 0x00;
        			txBuffer[1] |= (state == s_fault)  ? 0x04 : 0x00;
        			
        			/// DATA ID
        			sciData[ID_CURRENT].word 	= Iabs;
        			sciData[ID_DCBUS].word 		= 0;
        			sciData[ID_OUTVOLT].word 	= Um;
        			sciData[ID_OUTFREQ].word 	= speed;

        		
					txBuffer[2] = rxBuffer[2];
        			txBuffer[3] = sciData[rxBuffer[2]].bytes[0];
        			txBuffer[4] = sciData[rxBuffer[2]].bytes[1];
        		
        			for(msg_position = 0; msg_position < 5; msg_position++)
        			{
        				wbyte_SCI(txBuffer[msg_position]);
        			}
        			
        			msg_position = 0;
        			break;
        		default:
        			msg_position = 0;
        			break;
        		
        	}
        	rxFlag = 0;
        	
        }
        
        
        FMSTR_Poll();
    }
    
    return 0;
}


/* period 100us ~10kHz - Called within the PWM Reload interrupt */
void FastLoop()
{
	//FMSTR_Recorder();
	
	stateMachine[event][state]();
	
}

/* ADC update currents - called within the ADC EOSI interrupt */
void UpdateCurrents(MC_3PhSyst *adc)
{
	Iabc.a = adc->a;
	Iabc.b = adc->b;
	Iabc.c = adc->c;
}

#pragma interrupt saveall
void ISR_SCI0_Rx(void)
{
	
	unsigned int error;
	unsigned int error_data;
	unsigned int data;

	error = ioctl(SCI_0, SCI_GET_ERROR, NULL); 
	//received byte is OK
	if(error==0)
	{
	  // clear receiver full flag
	  error_data=ioctl( SCI_0, SCI_GET_STATUS_REG, NULL);
	  data = (ioctl(SCI_0, SCI_READ_DATA, NULL))&0xFF;
	  
	  if(rxFlag == 0)
	  {
	  	sci_data = data;
	  	rxFlag = 1;
	  }
	}
	else
	{
	  // clear receiver full flag
	  error_data=ioctl( SCI_0, SCI_GET_STATUS_REG, NULL);
	  data = (ioctl(SCI_0, SCI_READ_DATA, NULL))&0xFF;
	  rxFlag = 0;
	}  
	// clear interrupt flag
	ioctl( SCI_0, SCI_CLEAR_STATUS_REG, NULL);
}


/**************************************************************/
void wbyte_SCI(unsigned char data)
{
	/* wait for transmitter empty flag              */
	while (!ioctl( SCI_0, SCI_GET_TX_EMPTY, NULL)){}

	/* send byte and clear transmitter empty flag            */ 
	ioctl(SCI_0, SCI_WRITE_DATA, data);

	/* wait for receiver full flag                */ 
	while (!ioctl( SCI_0, SCI_GET_TX_IDLE, NULL)){}

	  /* clear idle flag                  */ 
	ioctl( SCI_0, SCI_GET_STATUS_REG, NULL);
	ioctl( SCI_0, SCI_READ_DATA, NULL);
}


