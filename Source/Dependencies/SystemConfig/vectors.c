/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* $File Name: vectors_83xx.c$
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.19.0$
*
* Description: 56F83xx Interrupt Vector Table (81 interrupts, INTC_VERSION_1)
*
*****************************************************************************/

#include "qs.h"

#ifndef INTC_VERSION_1
#error Bad INTC version defined in arch.h, or wrong vectors.c used
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* reference to startup code */

void Start(void);

/* for each interrupt vector, we (re)define HERE its correct prototype -
   - So, in the case the user defines BAD prototype himself e.g. in appconfig.h,
     the compiler warns him here about function prototype redefinition */
     
#ifdef INT_VECTOR_ADDR_1
void INT_VECTOR_ADDR_1(void);
#endif
#ifdef INT_VECTOR_ADDR_2
void INT_VECTOR_ADDR_2(void);
#endif
#ifdef INT_VECTOR_ADDR_3
void INT_VECTOR_ADDR_3(void);
#endif
#ifdef INT_VECTOR_ADDR_4
void INT_VECTOR_ADDR_4(void);
#endif
#ifdef INT_VECTOR_ADDR_5
void INT_VECTOR_ADDR_5(void);
#endif
#ifdef INT_VECTOR_ADDR_6
void INT_VECTOR_ADDR_6(void);
#endif
#ifdef INT_VECTOR_ADDR_7
void INT_VECTOR_ADDR_7(void);
#endif
#ifdef INT_VECTOR_ADDR_8
void INT_VECTOR_ADDR_8(void);
#endif
#ifdef INT_VECTOR_ADDR_9
void INT_VECTOR_ADDR_9(void);
#endif
#ifdef INT_VECTOR_ADDR_10
void INT_VECTOR_ADDR_10(void);
#endif
#ifdef INT_VECTOR_ADDR_11
void INT_VECTOR_ADDR_11(void);
#endif
#ifdef INT_VECTOR_ADDR_12
void INT_VECTOR_ADDR_12(void);
#endif
#ifdef INT_VECTOR_ADDR_13
void INT_VECTOR_ADDR_13(void);
#endif
#ifdef INT_VECTOR_ADDR_14
void INT_VECTOR_ADDR_14(void);
#endif
#ifdef INT_VECTOR_ADDR_15
void INT_VECTOR_ADDR_15(void);
#endif
#ifdef INT_VECTOR_ADDR_16
void INT_VECTOR_ADDR_16(void);
#endif
#ifdef INT_VECTOR_ADDR_17
void INT_VECTOR_ADDR_17(void);
#endif
#ifdef INT_VECTOR_ADDR_18
void INT_VECTOR_ADDR_18(void);
#endif
#ifdef INT_VECTOR_ADDR_19
void INT_VECTOR_ADDR_19(void);
#endif
#ifdef INT_VECTOR_ADDR_20
void INT_VECTOR_ADDR_20(void);
#endif
#ifdef INT_VECTOR_ADDR_21
void INT_VECTOR_ADDR_21(void);
#endif
#ifdef INT_VECTOR_ADDR_22
void INT_VECTOR_ADDR_22(void);
#endif
#ifdef INT_VECTOR_ADDR_23
void INT_VECTOR_ADDR_23(void);
#endif
#ifdef INT_VECTOR_ADDR_24
void INT_VECTOR_ADDR_24(void);
#endif
#ifdef INT_VECTOR_ADDR_25
void INT_VECTOR_ADDR_25(void);
#endif
#ifdef INT_VECTOR_ADDR_26
void INT_VECTOR_ADDR_26(void);
#endif
#ifdef INT_VECTOR_ADDR_27
void INT_VECTOR_ADDR_27(void);
#endif
#ifdef INT_VECTOR_ADDR_28
void INT_VECTOR_ADDR_28(void);
#endif
#ifdef INT_VECTOR_ADDR_29
void INT_VECTOR_ADDR_29(void);
#endif
#ifdef INT_VECTOR_ADDR_30
void INT_VECTOR_ADDR_30(void);
#endif
#ifdef INT_VECTOR_ADDR_31
void INT_VECTOR_ADDR_31(void);
#endif
#ifdef INT_VECTOR_ADDR_32
void INT_VECTOR_ADDR_32(void);
#endif
#ifdef INT_VECTOR_ADDR_33
void INT_VECTOR_ADDR_33(void);
#endif
#ifdef INT_VECTOR_ADDR_34
void INT_VECTOR_ADDR_34(void);
#endif
#ifdef INT_VECTOR_ADDR_35
void INT_VECTOR_ADDR_35(void);
#endif
#ifdef INT_VECTOR_ADDR_36
void INT_VECTOR_ADDR_36(void);
#endif
#ifdef INT_VECTOR_ADDR_37
void INT_VECTOR_ADDR_37(void);
#endif
#ifdef INT_VECTOR_ADDR_38
void INT_VECTOR_ADDR_38(void);
#endif
#ifdef INT_VECTOR_ADDR_39
void INT_VECTOR_ADDR_39(void);
#endif
#ifdef INT_VECTOR_ADDR_40
void INT_VECTOR_ADDR_40(void);
#endif
#ifdef INT_VECTOR_ADDR_41
void INT_VECTOR_ADDR_41(void);
#endif
#ifdef INT_VECTOR_ADDR_42
void INT_VECTOR_ADDR_42(void);
#endif
#ifdef INT_VECTOR_ADDR_43
void INT_VECTOR_ADDR_43(void);
#endif
#ifdef INT_VECTOR_ADDR_44
void INT_VECTOR_ADDR_44(void);
#endif
#ifdef INT_VECTOR_ADDR_45
void INT_VECTOR_ADDR_45(void);
#endif
#ifdef INT_VECTOR_ADDR_46
void INT_VECTOR_ADDR_46(void);
#endif
#ifdef INT_VECTOR_ADDR_47
void INT_VECTOR_ADDR_47(void);
#endif
#ifdef INT_VECTOR_ADDR_48
void INT_VECTOR_ADDR_48(void);
#endif
#ifdef INT_VECTOR_ADDR_49
void INT_VECTOR_ADDR_49(void);
#endif
#ifdef INT_VECTOR_ADDR_50
void INT_VECTOR_ADDR_50(void);
#endif
#ifdef INT_VECTOR_ADDR_51
void INT_VECTOR_ADDR_51(void);
#endif
#ifdef INT_VECTOR_ADDR_52
void INT_VECTOR_ADDR_52(void);
#endif
#ifdef INT_VECTOR_ADDR_53
void INT_VECTOR_ADDR_53(void);
#endif
#ifdef INT_VECTOR_ADDR_54
void INT_VECTOR_ADDR_54(void);
#endif
#ifdef INT_VECTOR_ADDR_55
void INT_VECTOR_ADDR_55(void);
#endif
#ifdef INT_VECTOR_ADDR_56
void INT_VECTOR_ADDR_56(void);
#endif
#ifdef INT_VECTOR_ADDR_57
void INT_VECTOR_ADDR_57(void);
#endif
#ifdef INT_VECTOR_ADDR_58
void INT_VECTOR_ADDR_58(void);
#endif
#ifdef INT_VECTOR_ADDR_59
void INT_VECTOR_ADDR_59(void);
#endif
#ifdef INT_VECTOR_ADDR_60
void INT_VECTOR_ADDR_60(void);
#endif
#ifdef INT_VECTOR_ADDR_61
void INT_VECTOR_ADDR_61(void);
#endif
#ifdef INT_VECTOR_ADDR_62
void INT_VECTOR_ADDR_62(void);
#endif
#ifdef INT_VECTOR_ADDR_63
void INT_VECTOR_ADDR_63(void);
#endif
#ifdef INT_VECTOR_ADDR_64
void INT_VECTOR_ADDR_64(void);
#endif
#ifdef INT_VECTOR_ADDR_65
void INT_VECTOR_ADDR_65(void);
#endif
#ifdef INT_VECTOR_ADDR_66
void INT_VECTOR_ADDR_66(void);
#endif
#ifdef INT_VECTOR_ADDR_67
void INT_VECTOR_ADDR_67(void);
#endif
#ifdef INT_VECTOR_ADDR_68
void INT_VECTOR_ADDR_68(void);
#endif
#ifdef INT_VECTOR_ADDR_69
void INT_VECTOR_ADDR_69(void);
#endif
#ifdef INT_VECTOR_ADDR_70
void INT_VECTOR_ADDR_70(void);
#endif
#ifdef INT_VECTOR_ADDR_71
void INT_VECTOR_ADDR_71(void);
#endif
#ifdef INT_VECTOR_ADDR_72
void INT_VECTOR_ADDR_72(void);
#endif
#ifdef INT_VECTOR_ADDR_73
void INT_VECTOR_ADDR_73(void);
#endif
#ifdef INT_VECTOR_ADDR_74
void INT_VECTOR_ADDR_74(void);
#endif
#ifdef INT_VECTOR_ADDR_75
void INT_VECTOR_ADDR_75(void);
#endif
#ifdef INT_VECTOR_ADDR_76
void INT_VECTOR_ADDR_76(void);
#endif
#ifdef INT_VECTOR_ADDR_77
void INT_VECTOR_ADDR_77(void);
#endif
#ifdef INT_VECTOR_ADDR_78
void INT_VECTOR_ADDR_78(void);
#endif
#ifdef INT_VECTOR_ADDR_79
void INT_VECTOR_ADDR_79(void);
#endif
#ifdef INT_VECTOR_ADDR_80
void INT_VECTOR_ADDR_80(void);
#endif
#ifdef INT_VECTOR_ADDR_81
void INT_VECTOR_ADDR_81(void);
#endif

/* unhandled exception "handler" */

static asm void unhandled_interrupt(void)
{
	/* retrieve VAB field from ICTL register */
	move.l  #ArchIO.Intc.ictl,R0
	move.w  X:(R0),X0
	asrr.w  #6,X0
	bfclr   #0xff80,X0

	/* Interrupt number is stored in X0 register */	
	debughlt
	
	/* Loop forever */
	bra *+0
}

/* illegal instruction interrupt ($04) */

#ifndef INT_VECTOR_ADDR_2
#define INT_VECTOR_ADDR_2 ill_op

static asm void ill_op(void)
{
	debughlt	
	nop
	rti
}

#endif

/* hardware stack overflow interrupt ($08) */

#ifndef INT_VECTOR_ADDR_4
#define INT_VECTOR_ADDR_4 hws_overflow

static asm void hws_overflow(void)
{
	debughlt	
	nop
	rti
}

#endif
	
/* misaligned long word access interrupt ($0A) */

#ifndef INT_VECTOR_ADDR_5
#define INT_VECTOR_ADDR_5 misalign

static asm void misalign(void)
{
	debughlt	
	nop
	rti
}

#endif

/* PLL lost of lock interrupt ($28) */

#ifndef INT_VECTOR_ADDR_20
#define INT_VECTOR_ADDR_20 pll_losslock

static asm void pll_losslock(void)
{
	debughlt
	nop
	rti
}

#endif

/***************************
 *
 * Boot-Interrupt vectors
 *
 ***************************/
 
#pragma define_section boot_delay "boot_delay" RW
#pragma section boot_delay begin

#ifdef BOOT_DELAY_INIT
static UWord16 bdelay = BOOT_DELAY_INIT;
#else
static UWord16 bdelay = 0xFEA0;
#endif

#pragma section boot_delay end

#pragma define_section boot_jump "boot_jump.text" RX
#pragma section boot_jump begin

#ifndef BOOT_DELAY_INIT

static asm void boot_vec(void)
{
	jmp >Start;	            /* Reset */
	
#ifdef INT_VECTOR_ADDR_1	
	jmp >INT_VECTOR_ADDR_1   /* COP Reset */
#else
	jmp >Start;
#endif
}

#endif

#pragma section boot_jump end

/***************************
 *
 * Interrupt vectors table
 *
 ***************************/

#pragma define_section interrupt_vectors "interrupt_vectors.text"  RX
#pragma section interrupt_vectors begin

static asm void int_vec(void)
{
	jmp >Start;           	/* Reset */
	
#ifdef INT_VECTOR_ADDR_1	
	jmp >INT_VECTOR_ADDR_1	/* COP Reset */
#else
	jmp >Start;		
#endif
	
#ifdef INT_VECTOR_ADDR_2	/* 0x04: illegal instruction */ 
	jsr >INT_VECTOR_ADDR_2
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_3	/* 0x06: software interrupt 3 */ 
	jsr >INT_VECTOR_ADDR_3
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_4	/* 0x08: hardware stack overflow */
	jsr >INT_VECTOR_ADDR_4
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_5	/* 0x0A: misaligned long word access */ 
	jsr >INT_VECTOR_ADDR_5
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_6	/* 0x0C: EOnCE step counter */ 
	jsr >INT_VECTOR_ADDR_6
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_7	/* 0x0E: EOnCE breakpoint unit 0 */ 
	jsr >INT_VECTOR_ADDR_7
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_8	/* 0x10: reserved */ 
	jsr >INT_VECTOR_ADDR_8
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_9	/* 0x12: EOnCE trace buffer */ 
	jsr >INT_VECTOR_ADDR_9
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_10	/* 0x14: EOnCE transmit register empty */ 
	jsr >INT_VECTOR_ADDR_10
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_11	/* 0x16: EOnCE receive register full */ 
	jsr >INT_VECTOR_ADDR_11
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_12	/* 0x18: reserved */ 
	jsr >INT_VECTOR_ADDR_12
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_13	/* 0x1A: reserved */ 
	jsr >INT_VECTOR_ADDR_13
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_14	/* 0x1C: software interrupt 2 */ 
	jsr >INT_VECTOR_ADDR_14
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_15	/* 0x1E: software interrupt 1 */ 
	jsr >INT_VECTOR_ADDR_15
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_16	/* 0x20: software interrupt 0 */ 
	jsr >INT_VECTOR_ADDR_16
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_17	/* 0x22: IRQA */ 
	jsr >INT_VECTOR_ADDR_17
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_18	/* 0x24: IRQB */ 
	jsr >INT_VECTOR_ADDR_18
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_19	/* 0x26: reserved */ 
	jsr >INT_VECTOR_ADDR_19
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_20	/* 0x28: Low voltage detector */ 
	jsr >INT_VECTOR_ADDR_20
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_21	/* 0x2A: PLL loss of lock/clock */ 
	jsr >INT_VECTOR_ADDR_21
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_22	/* 0x2C: HFM error interrupt */ 
	jsr >INT_VECTOR_ADDR_22
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_23	/* 0x2E: HFM command complete */ 
	jsr >INT_VECTOR_ADDR_23
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_24	/* 0x30: HFM command data & address buffers empty */ 
	jsr >INT_VECTOR_ADDR_24
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_25	/* 0x32: reserved */ 
	jsr >INT_VECTOR_ADDR_25
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_26	/* 0x34: FlexCAN bus-off */ 
	jsr >INT_VECTOR_ADDR_26
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_27	/* 0x36: FlexCAN error */ 
	jsr >INT_VECTOR_ADDR_27
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_28	/* 0x38: FlexCAN wakeup */ 
	jsr >INT_VECTOR_ADDR_28
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_29	/* 0x3A: FlexCAN message buffer */ 
	jsr >INT_VECTOR_ADDR_29
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_30	/* 0x3C: GPIO F */ 
	jsr >INT_VECTOR_ADDR_30
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_31	/* 0x3E: GPIO E */ 
	jsr >INT_VECTOR_ADDR_31
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_32	/* 0x40: GPIO D */ 
	jsr >INT_VECTOR_ADDR_32
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_33	/* 0x42: GPIO C */ 
	jsr >INT_VECTOR_ADDR_33
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_34	/* 0x44: GPIO B */ 
	jsr >INT_VECTOR_ADDR_34
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_35	/* 0x46: GPIO A */ 
	jsr >INT_VECTOR_ADDR_35
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_36	/* 0x48: reserved */ 
	jsr >INT_VECTOR_ADDR_36
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_37	/* 0x4a: reserved */ 
	jsr >INT_VECTOR_ADDR_37
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_38	/* 0x4c: SPI1 receiver full */ 
	jsr >INT_VECTOR_ADDR_38
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_39	/* 0x4e: SPI1 transmitter empty */ 
	jsr >INT_VECTOR_ADDR_39
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_40	/* 0x50: SPI0 receiver full */ 
	jsr >INT_VECTOR_ADDR_40
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_41	/* 0x52: SPI0 transmitter empty */ 
	jsr >INT_VECTOR_ADDR_41
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_42	/* 0x54: SCI1 transmitter empty */ 
	jsr >INT_VECTOR_ADDR_42
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_43	/* 0x56: SCI1 receiver idle */ 
	jsr >INT_VECTOR_ADDR_43
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_44	/* 0x58: SCI1 reserved */ 
	jsr >INT_VECTOR_ADDR_44
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_45	/* 0x5a: SCI1 receiver error */ 
	jsr >INT_VECTOR_ADDR_45
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_46	/* 0x5c: SCI1 receiver full */ 
	jsr >INT_VECTOR_ADDR_46
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_47	/* 0x5e: QDEC1 Home switch or watchdog */ 
	jsr >INT_VECTOR_ADDR_47	
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_48	/* 0x60: QDEC1 Index */ 
	jsr >INT_VECTOR_ADDR_48
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_49	/* 0x62: QDEC0 Home switch or watchdog */ 
	jsr >INT_VECTOR_ADDR_49
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_50	/* 0x64: QDEC0 Index pulse */ 
	jsr >INT_VECTOR_ADDR_50
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_51	/* 0x66: reserved */ 
	jsr >INT_VECTOR_ADDR_51
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_52	/* 0x68: timer D channel 0 */ 
	jsr >INT_VECTOR_ADDR_52
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_53	/* 0x6a: timer D channel 1 */ 
	jsr >INT_VECTOR_ADDR_53
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_54	/* 0x6c: timer D channel 2 */ 
	jsr >INT_VECTOR_ADDR_54
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_55	/* 0x6e: timer D channel 3 */ 
	jsr >INT_VECTOR_ADDR_55
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_56	/* 0x70: timer C channel 0 */ 
	jsr >INT_VECTOR_ADDR_56
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_57	/* 0x72: timer C channel 1 */ 
	jsr >INT_VECTOR_ADDR_57
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_58	/* 0x74: timer C channel 2 */ 
	jsr >INT_VECTOR_ADDR_58
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_59	/* 0x76: timer C channel 3 */ 
	jsr >INT_VECTOR_ADDR_59
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_60	/* 0x78: timer B channel 0 */ 
	jsr >INT_VECTOR_ADDR_60
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_61	/* 0x7a: timer B channel 1 */ 
	jsr >INT_VECTOR_ADDR_61
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_62	/* 0x7c: timer B channel 2 */ 
	jsr >INT_VECTOR_ADDR_62
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_63	/* 0x7e: timer B channel 3 */ 
	jsr >INT_VECTOR_ADDR_63
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_64	/* 0x80: timer A channel 0 */ 
	jsr >INT_VECTOR_ADDR_64
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_65	/* 0x82: timer A channel 1 */ 
	jsr >INT_VECTOR_ADDR_65
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_66	/* 0x84: timer A channel 2 */ 
	jsr >INT_VECTOR_ADDR_66
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_67	/* 0x86: timer A channel 3 */ 
	jsr >INT_VECTOR_ADDR_67
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_68	/* 0x88: SCI0 transmitter empty */
	jsr >INT_VECTOR_ADDR_68
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_69	/* 0x8a: SCI0 transmitter idle */ 
	jsr >INT_VECTOR_ADDR_69
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_70	/* 0x8c: SCI0 reserved */ 
	jsr >INT_VECTOR_ADDR_70
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_71	/* 0x8e: SCI0 receiver error */ 
	jsr >INT_VECTOR_ADDR_71
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_72	/* 0x90: SCI0 receiver full */ 
	jsr >INT_VECTOR_ADDR_72
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_73	/* 0x92: ADC B conversion complete */ 
	jsr >INT_VECTOR_ADDR_73
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_74	/* 0x94: ADC A conversion complete */ 
	jsr >INT_VECTOR_ADDR_74
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_75	/* 0x96: ADC B zero crossing or limit error */
	jsr >INT_VECTOR_ADDR_75
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_76	/* 0x98: ADC A zero crossing or limit error */
	jsr >INT_VECTOR_ADDR_76
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_77	/* 0x9a: PWM B reload */ 
	jsr >INT_VECTOR_ADDR_77
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_78	/* 0x9c: PWM A reload */ 
	jsr >INT_VECTOR_ADDR_78
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_79	/* 0x9e: PWM B fault */ 
	jsr >INT_VECTOR_ADDR_79
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_80	/* 0xa0: PWM A fault */ 
	jsr >INT_VECTOR_ADDR_80
#else
	jsr >unhandled_interrupt
#endif
#ifdef INT_VECTOR_ADDR_81	/* 0xa2: SW interrupt LP */ 
	jsr >INT_VECTOR_ADDR_81
#else
	jsr >unhandled_interrupt
#endif
}

#pragma section interrupt_vectors end

#ifdef __cplusplus
}
#endif

