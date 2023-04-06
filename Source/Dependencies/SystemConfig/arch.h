/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* (c) Copyright 2001-2004 Motorola, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* $File Name: arch.h$
*
* $Date:      Feb-5-2007$
*
* $Version:   2.3.11.0$
*
* Description: Peripheral space map of the MC56F8346 device
*
*****************************************************************************/

#ifndef __ARCH_H
#define __ARCH_H

#ifndef __TYPES_H
#error types.h must be included before arch.h
#endif

/* System Integration Module */

#define SIM_VERSION 1
#define SIM_VERSION_1

typedef volatile struct 
{
	ARCH_REG3(UWord16, sim_control, control, ControlReg);
	ARCH_REG3(UWord16, sim_rststs,  rststs, StatusReg);
	ARCH_REG2(UWord16, sim_scr0,    scr0);
	ARCH_REG2(UWord16, sim_scr1,    scr1);
	ARCH_REG2(UWord16, sim_scr2,    scr2);
	ARCH_REG2(UWord16, sim_scr3,    scr3);
	ARCH_REG2(UWord16, sim_msh_id,  msh_id);
	ARCH_REG2(UWord16, sim_lsh_id,  lsh_id);
	ARCH_REG2(UWord16, sim_pudr,    pudr);
	ARCH_REG1(UWord16, reserved1);
	ARCH_REG2(UWord16, sim_clkosr,  clkosr);
	ARCH_REG3(UWord16, sim_gps,     gps, dtss);
	ARCH_REG2(UWord16, sim_pce,     pce);
	ARCH_REG2(UWord16, sim_isalh,   isalh);
	ARCH_REG2(UWord16, sim_isall,   isall);
	ARCH_REG1(UWord16, reserved2);

} arch_sSIM;

/* External Memory Interface */

#define SEMI_VERSION 1
#define SEMI_VERSION_1
#define SEMI_CS_COUNT 4

typedef volatile struct
{
	ARCH_REG3(UWord16, csbar[8], cs[8], BaseReg[8]);
	ARCH_REG2(UWord16, csor[8],  OptionReg[8]);
	ARCH_REG2(UWord16, cstc[8],  TimingReg[8]);
	ARCH_REG2(UWord16, bcr,      ControlReg);
	ARCH_REG1(UWord16, reserved[7]);

} arch_sSEMI;

/* Quad Timer Module */

#define QT_VERSION 1
#define QT_VERSION_1

typedef volatile struct
{
	ARCH_REG3(UWord16, tmrcmp1,   cmp1, CompareReg1);
	ARCH_REG3(UWord16, tmrcmp2,   cmp2, CompareReg2);
	ARCH_REG3(UWord16, tmrcap,    cap, CaptureReg);
	ARCH_REG3(UWord16, tmrload,   load, LoadReg);
	ARCH_REG3(UWord16, tmrhold,   hold, HoldReg);
	ARCH_REG3(UWord16, tmrcntr,   cntr, CounterReg);
	ARCH_REG3(UWord16, tmrctrl,   ctrl, ControlReg);
	ARCH_REG3(UWord16, tmrscr,    scr, StatusControlReg);
	ARCH_REG2(UWord16, tmrcmpld1, cmpld1);
	ARCH_REG2(UWord16, tmrcmpld2, cmpld2);
	ARCH_REG2(UWord16, tmrcomscr, comscr);
	ARCH_REG1(UWord16, reserved[5]);

} arch_sTimerChannel;

typedef volatile struct
{
	ARCH_REG2(arch_sTimerChannel, ch0, Channel0);
	ARCH_REG2(arch_sTimerChannel, ch1, Channel1);
	ARCH_REG2(arch_sTimerChannel, ch2, Channel2);
	ARCH_REG2(arch_sTimerChannel, ch3, Channel3);

} arch_sTimer;

/* PWM Module */

#define PWM_VERSION 1
#define PWM_VERSION_1
#define PWM_HAS_FAULTS  0xf
#define PWM_HAS_IS_PINS 0x7

typedef volatile struct
{
	ARCH_REG2(UWord16, pmctl,     ControlReg);
	ARCH_REG2(UWord16, pmfctl,    FaultControlReg);
	ARCH_REG2(UWord16, pmfsa,     FaultStatusReg);
	ARCH_REG2(UWord16, pmout,     OutputControlReg);
	ARCH_REG2(UWord16, pmcnt,     CounterReg);
	ARCH_REG2(UWord16, pwmcm,     CounterModuloReg);
	ARCH_REG2(Word16,  pwmval[6], ValueReg[6]);
	ARCH_REG2(UWord16, pmdeadtm,  DeadtimeReg);
	ARCH_REG2(UWord16, pmdismap1, DisableMapping1Reg);
	ARCH_REG2(UWord16, pmdismap2, DisableMapping2Reg);
	ARCH_REG2(UWord16, pmcfg,     ConfigReg);
	ARCH_REG2(UWord16, pmccr,     ChannelControlReg);
	ARCH_REG2(UWord16, pmport,    PortReg);
	ARCH_REG1(UWord16, pmiccr);
	ARCH_REG1(UWord16, reserved[13]);

} arch_sPWM;

/* Quadrature Decoder */

#define DEC_VERSION 1
#define DEC_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, deccr,   ControlReg);
	ARCH_REG2(UWord16, fir,    FilterIntervalReg);
	ARCH_REG2(UWord16, wtr,    WatchdogTimeoutReg);
	ARCH_REG2(Word16,  posd,   PositionDifferenceReg);
	ARCH_REG2(Word16,  posdh,  PositionDifferenceHoldReg);
	ARCH_REG2(Word16,  rev,    RevolutionCounterReg);
	ARCH_REG2(Word16,  revh,   RevolutionHoldReg);
	ARCH_REG2(Word16,  upos,   UpperPositionCounterReg);
	ARCH_REG2(UWord16, lpos,   LowerPositionCounterReg);
	ARCH_REG2(Word16,  uposh,  UpperPositionHoldReg);
	ARCH_REG2(UWord16, lposh,  LowerPositionHoldReg);
	ARCH_REG2(Word16,  uir,    UpperInitializationReg);
	ARCH_REG2(UWord16, lir,    LowerInitializationReg);
	ARCH_REG2(UWord16, imr,    InputMonitorReg);
	ARCH_REG1(UWord16, reserved[2]);

} arch_sDecoder;

/* Interrupt Controller */

#define INTC_VERSION 1
#define INTC_VERSION_1
#define INTC_HAS_IRQPINS 3

typedef volatile struct
{
	ARCH_REG2(UWord16, ipr[10],    PriorityReg[10]);
	ARCH_REG2(UWord16, vba,        VecBaseReg);
	ARCH_REG2(UWord16, fim0,       FastInt0MatchReg);
	ARCH_REG2(UWord16, fival0,     FastInt0AddrLReg);
	ARCH_REG2(UWord16, fivah0,     FastInt0AddrHReg);
	ARCH_REG2(UWord16, fim1,       FastInt1MatchReg);
	ARCH_REG2(UWord16, fival1,     FastInt1AddrLReg);
	ARCH_REG2(UWord16, fivah1,     FastInt1AddrHReg);
	ARCH_REG2(UWord16, irqp[6],    IntPendingReg[6]);
	ARCH_REG1(UWord16, reserved1[6]);
	ARCH_REG2(UWord16, ictl,       ControlReg);
	ARCH_REG1(UWord16, reserved2[66]);

} arch_sIntc;

/* A/D Converter */

#define ADC_VERSION 1
#define ADC_VERSION_1

typedef volatile struct
{
	ARCH_REG3(UWord16, adctl1,    adcr1, Control1Reg);
	ARCH_REG3(UWord16, adctl2,    adcr2, Control2Reg);
	ARCH_REG2(UWord16, adzcc,     ZeroCrossControlReg);
	ARCH_REG2(UWord16, adlst1,    ChannelList1Reg);
	ARCH_REG2(UWord16, adlst2,    ChannelList2Reg);
	ARCH_REG2(UWord16, adsdis,    DisableReg);
	ARCH_REG2(UWord16, adstat,    StatusReg);
	ARCH_REG2(UWord16, adlstat,   LimitReg);
	ARCH_REG2(UWord16, adzcstat,  ZeroCrossStatusReg);
	ARCH_REG2(UWord16, adrslt[8], ResultReg[8]);
	ARCH_REG2(UWord16, adllmt[8], LowLimitReg[8]);
	ARCH_REG2(UWord16, adhlmt[8], HighLimitReg[8]);
	ARCH_REG2(UWord16, adofs[8],  OffsetReg[8]);
	ARCH_REG1(UWord16, adcpower);
	ARCH_REG1(UWord16, adc_cal);
	ARCH_REG1(UWord16, reserved[5]);

} arch_sADC;

/* Temperature sensor */

#define TSENSOR_VERSION 1
#define TSENSOR_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, ctrl, cntl);
	ARCH_REG1(UWord16, reserved[15]);

} arch_sTSensor;

/* Serial Communication Interface */

#define SCI_VERSION 1
#define SCI_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, scibr,    BaudRateReg);
	ARCH_REG2(UWord16, scicr,    ControlReg);
	ARCH_REG1(UWord16, reserved1);
	ARCH_REG2(UWord16, scisr,    StatusReg);
	ARCH_REG2(UWord16, scidr,    DataReg);
	ARCH_REG1(UWord16, reserved2[11]);

} arch_sSCI;

/* Serial Peripheral Interface */

#define SPI_VERSION 1
#define SPI_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, spscr,    ControlReg);
	ARCH_REG3(UWord16, spdsr,    spdscr, DataSizeReg);
	ARCH_REG2(UWord16, spdrr,    DataRxReg);
	ARCH_REG2(UWord16, spdtr,    DataTxReg);
	ARCH_REG1(UWord16, reserved[12]);

} arch_sSPI;

/* Watchdog Module */

#define COP_VERSION 1
#define COP_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, copctl,   ControlReg);
	ARCH_REG2(UWord16, copto,    TimeoutReg);
	ARCH_REG2(UWord16, copctr,   ServiceReg);
	ARCH_REG1(UWord16, reserved[13]);

} arch_sCOP;

/* PLL/OCCS Module */

#define OCCS_VERSION 1
#define OCCS_VERSION_1
#define OCCS_HAS_RXOSC 0

typedef volatile struct
{
	ARCH_REG2(UWord16, pllcr,   ControlReg);
	ARCH_REG2(UWord16, plldb,   DivideReg);
	ARCH_REG2(UWord16, pllsr,   StatusReg);
	ARCH_REG1(UWord16, reserved1);
	ARCH_REG1(UWord16, shutdown);
	ARCH_REG1(UWord16, osctl);
	ARCH_REG1(UWord16, reserved2[10]);

} arch_sPLL;

/* General Purpose I/O */

#define GPIO_VERSION 1
#define GPIO_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, pur,      PullUpReg);
	ARCH_REG2(UWord16, dr,       DataReg);
	ARCH_REG2(UWord16, ddr,      DataDirectionReg);
	ARCH_REG2(UWord16, per,      PeripheralReg);
	ARCH_REG2(UWord16, iar,      IntAssertReg);
	ARCH_REG2(UWord16, ienr,     IntEnableReg);
	ARCH_REG2(UWord16, ipolr,    IntPolarityReg);
	ARCH_REG2(UWord16, ipr,      IntPendingReg);
	ARCH_REG2(UWord16, iesr,     IntEdgeSensReg);
	ARCH_REG2(UWord16, ppmode,   PushPullModeReg);
	ARCH_REG2(UWord16, rawdata,  RawInputReg);
	ARCH_REG1(UWord16, reserved[5]);

} arch_sPort;

/* Lov-Voltage Detector */

#define LVI_VERSION 1
#define LVI_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, lvictlr,  control);
	ARCH_REG2(UWord16, lvisr,    status);
	ARCH_REG1(UWord16, test);
	ARCH_REG1(UWord16, reserved[157]);

} arch_sLVI;

/* Flash Memory Module */

#define HFM_VERSION 1
#define HFM_VERSION_1

typedef volatile struct
{
	ARCH_REG2(UWord16, fmclkd,     clkd);
	ARCH_REG2(UWord16, fmcr,       mcr);
	ARCH_REG1(UWord16, reserved1);
	ARCH_REG2(UWord16, fmsech,     sech);
	ARCH_REG2(UWord16, fmsecl,     secl);
	ARCH_REG2(UWord16, fmmntr,     mntr);
	ARCH_REG1(UWord16, reserved2[10]);
	ARCH_REG2(UWord16, fmprot,     prot);
	ARCH_REG2(UWord16, fmprotb,    protb);
	ARCH_REG1(UWord16, reserved3);
	ARCH_REG2(UWord16, fmustat,    ustat);
	ARCH_REG2(UWord16, fmcmd,      cmd);
	ARCH_REG2(UWord16, fmctl,      ctl);
	ARCH_REG1(UWord16, reserved4[4]);
	ARCH_REG2(UWord16, fmopt0,     ifropt0);
	ARCH_REG2(UWord16, fmopt1,     ifropt1);
	ARCH_REG2(UWord16, fmopt2,     ifropt2);
	ARCH_REG1(UWord16, reserved5[227]);

} arch_sHFM;

/* FlexCAN Module */

#define FCAN_VERSION 1
#define FCAN_VERSION_1

typedef volatile struct 
{
	ARCH_REG2(UWord16, control,    csw);
	ARCH_REG2(UWord16, id_high,    id_h);
	ARCH_REG3(UWord16, id_low,     id_l, timestamp);
	ARCH_REG1(UWord16, data[4]);
	ARCH_REG1(UWord16, reserved1);

} arch_sFlexCAN_MB;

/* number of FlexCAN Message Buffers available */
#define ARCH_FCAN_MBCOUNT 16

typedef volatile struct 
{
	ARCH_REG2(UWord16, fcmcr,        mcr);
	ARCH_REG1(UWord16, resrved1[2]);
	ARCH_REG2(UWord16, fcctl0,       ctl0);
	ARCH_REG2(UWord16, fcctl1,       ctl1);
	ARCH_REG2(UWord16, fctmr,        tmr);
	ARCH_REG2(UWord16, fcmaxmb,      maxmb);
	ARCH_REG2(UWord16, fcimask2,     imask2);
	ARCH_REG2(UWord16, fcrxgmask_h,  rxgmask_h);
	ARCH_REG2(UWord16, fcrxgmask_l,  rxgmask_l);
	ARCH_REG2(UWord16, fcrx14mask_h, rx14mask_h);
	ARCH_REG2(UWord16, fcrx14mask_l, rx14mask_l);
	ARCH_REG2(UWord16, fcrx15mask_h, rx15mask_h);
	ARCH_REG2(UWord16, fcrx15mask_l, rx15mask_l);
	ARCH_REG1(UWord16, reserved3[2]);
	ARCH_REG2(UWord16, fcstatus,     status);
	ARCH_REG2(UWord16, fcimask1,     imask1);
	ARCH_REG2(UWord16, fciflag1,     iflag1);
	ARCH_REG2(UWord16, fc_err_cntrs, errctr);
	ARCH_REG1(UWord16, reserved4[7]);
	ARCH_REG2(UWord16, fciflag2,     iflag2);
	ARCH_REG1(UWord16, reserved5[36]);

	// message buffers:
	ARCH_REG1(arch_sFlexCAN_MB, mb[ARCH_FCAN_MBCOUNT]);
	ARCH_REG1(arch_sFlexCAN_MB, mb_unused[32-ARCH_FCAN_MBCOUNT]);

	ARCH_REG1(UWord16, reserved6[0xc0]);

} arch_sFlexCAN;

/* EOnCE Module */

typedef volatile struct {

	ARCH_REG1(UWord16, reserved[0xfd]);
	ARCH_REG2(UWord16, otxrxsr, TxRxStatusControlReg);
	ARCH_REG3(UWord32, orx, otx, RxTxReg);

} arch_sEOnCE;

/* peripheral space base addresses */

#define SEMI_BASE    0xF020
#define TMRA_BASE    0xF040
#define TMRB_BASE	 0xF080
#define TMRC_BASE    0xF0C0
#define TMRD_BASE    0xF100
#define PWMA_BASE    0xF140
#define PWMB_BASE    0xF160
#define QD0_BASE     0xF180
#define QD1_BASE     0xF190
#define INTC_BASE    0xF1A0
#define ADCA_BASE    0xF200
#define ADCB_BASE    0xF240
#define TSNSR_BASE   0xF270
#define SCI0_BASE    0xF280
#define SCI1_BASE    0xF290
#define SPI0_BASE    0xF2A0
#define SPI1_BASE    0xF2B0
#define COP_BASE     0xF2C0
#define PLL_BASE     0xF2D0
#define GPIO_A_BASE  0xF2E0
#define GPIO_B_BASE  0xF300
#define GPIO_C_BASE  0xF310
#define GPIO_D_BASE  0xF320
#define GPIO_E_BASE  0xF330
#define GPIO_F_BASE  0xF340
#define SIM_BASE     0xF350
#define LVI_BASE     0xF360
#define HFM_BASE     0xF400
#define CAN_BASE     0xF800
#define EONCE_BASE   0xFFFF00

/* complete periphiperal space described by single structure */

typedef volatile struct{
	UWord16        Reserved0[32];
	arch_sSEMI     Semi;			/* Semi_BASE =   	0xF020 */
	
	arch_sTimer    TimerA;			/* TimerA_BASE =  	0xF040 */
	arch_sTimer    TimerB;			/* TimerB_BASE =  	0xF080 */
	arch_sTimer    TimerC;			/* TimerC_BASE =  	0xF0C0 */
	arch_sTimer    TimerD;			/* TimerD_BASE =  	0xF100 */
	
	arch_sPWM      PwmA;			/* PwmA_BASE =  	0xF140 */
	arch_sPWM      PwmB;			/* PwmB_BASE =  	0xF160 */
	
	arch_sDecoder  Decoder0;		/* Decoder0_BASE =  0xF180 */
	arch_sDecoder  Decoder1;		/* Decoder1_BASE =  0xF190 */
	
	arch_sIntc	   Intc;			/* Intc_BASE =  	0xF1A0 */
	
	arch_sADC      AdcA;			/* AdcA_BASE =  	0xF200 */
	UWord16 	   Reserved1[16];	
	arch_sADC      AdcB;			/* AdcB_BASE =  	0xF240 */
	arch_sTSensor  TSensor;         /* TSensor_BASE =   0xF270 */
	
	arch_sSCI      Sci0;			/* Sci0_BASE =  	0xF280 */
	arch_sSCI      Sci1;			/* Sci1_BASE =  	0xF290 */
	arch_sSPI      Spi0;			/* Spi0_BASE =  	0xF2A0 */
	arch_sSPI      Spi1;			/* Spi1_BASE =  	0xF2B0 */
	
	arch_sCOP      Cop;				/* Cop_BASE =  		0xF2C0 */
	arch_sPLL      Pll;				/* Pll_BASE =       0xF2D0 */
	
	arch_sPort     PortA;			/* PortA_BASE =  	0xF2E0 */
	UWord16 	   Reserved3[16];	
	arch_sPort     PortB;			/* PortB_BASE =  	0xF300 */
	arch_sPort     PortC;			/* PortC_BASE =  	0xF310 */
	arch_sPort     PortD;			/* PortD_BASE =  	0xF320 */
	arch_sPort     PortE;			/* PortE_BASE =  	0xF330 */
	arch_sPort     PortF;			/* PortF_BASE =  	0xF340 */
	
	arch_sSIM      Sim;				/* Sim_BASE =  		0xF350 */
	arch_sLVI      Lvi;				/* Lvi_BASE =  		0xF360 */
	arch_sHFM	   Hfm;				/* Hfm_BASE =  		0xF400 */
	UWord16        Reserved4[768];
	arch_sFlexCAN  FCan;			/* FCan_BASE =  	0xF800 */

	UWord16        Reserved5[0xFF0500];
	arch_sEOnCE	   EOnCE;           /* EOnCE_BASE =     0xFFFF00 */
} arch_sIO;

/* The location of the following structures is defined in linker.cmd */
extern arch_sIO    ArchIO;

/* you can try to use direct address access too */
//#define ArchIO (*(volatile arch_sIO*) 0xf000)

#endif

