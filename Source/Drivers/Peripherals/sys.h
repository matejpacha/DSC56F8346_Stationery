/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  sys.h
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.6.0$
*
* Description: System reset, SIM, low voltage interrupt and various system 
*              support macros and definitions
*
*****************************************************************************/

#ifndef __SYS_H
#define __SYS_H

/* qs.h is a master header file, which must be included */
#if !defined(__ARCH_H) || !defined(__PERIPH_H) || !defined(__APPCONFIG_H)
#error Please include qs.h before sys.h
#endif

#ifdef __cplusplus
extern "C" {
#endif

/************************************************************
* system module identifiers, correspond to module base address
*************************************************************/

#define SYS (&ArchIO.Sim)
#define SIM (&ArchIO.Sim)
#define LVI (&ArchIO.Lvi)
#define SEMI (&ArchIO.Semi)

/***********************************************************************
* SYS static configuration items for appconfig.h
***********************************************************************/

/*
    initial register values:

    #define SIM_CONROL_INIT
    #define SIM_PUDR_INIT
    #define SIM_CLKOSR_INIT
    #define SIM_GPS_INIT
    #define SIM_PCE_INIT
    
    #define LVI_CONTROL_INIT

    #define SEMI_BCR_INIT
    #define SEMI_CSBAR0_INIT
    #define SEMI_CSBAR1_INIT
    #define SEMI_CSBAR2_INIT
    #define SEMI_CSBAR3_INIT
    #define SEMI_CSBAR4_INIT
    #define SEMI_CSBAR5_INIT
    #define SEMI_CSBAR6_INIT
    #define SEMI_CSBAR7_INIT
    #define SEMI_CSOR0_INIT
    #define SEMI_CSOR1_INIT
    #define SEMI_CSOR2_INIT
    #define SEMI_CSOR3_INIT
    #define SEMI_CSOR4_INIT
    #define SEMI_CSOR5_INIT
    #define SEMI_CSOR6_INIT
    #define SEMI_CSOR7_INIT
    #define SEMI_CSTC0_INIT
    #define SEMI_CSTC1_INIT
    #define SEMI_CSTC2_INIT
    #define SEMI_CSTC3_INIT
    #define SEMI_CSTC4_INIT
    #define SEMI_CSTC5_INIT
    #define SEMI_CSTC6_INIT
    #define SEMI_CSTC7_INIT


    #define INTERRUPT_VECTOR_ADDR_yy  userISR //specify interrupt handler routine : e.g. lviISR
    #define INT_PRIORITY_LEVEL_yy     INTC_xxx // interrupt level : (INTC_DISABLED, INTC_LEVEL0,
                                               //                    INTC_LEVEL1 or INTC_LEVEL2)
  where:
         yy  is interrupt vector number
            e.g. On 56F8347
                20 - Low Voltage Detector (Power sense)

*/


/***************************************************
* SYS ioctl commands
****************************************************/
/* command                    |        Param       */

/* SYS(SIM) registers initialization according static config in AppConfig.h */
#define SYS_INIT                /* NULL */

/* reprogramable "stop" instruction disable */ 
#define SYS_STOP                /* SYS_ENABLE (0)/SYS_DISABLE (1) */
/* permanent "stop" instruction disable (can be enabled only by RESET) */
#define SYS_STOP_PERMANENT_DISABLE /* NULL */
/* reprogramable "wait" instruction disable */ 
#define SYS_WAIT                /* SYS_ENABLE (0)/SYS_DISABLE (1) */
/* permanent "wait" instruction disable (can be enabled only by RESET) */
#define SYS_WAIT_PERMANENT_DISABLE /* NULL */

/* issue software reset */
#define SYS_SOFTWARE_RESET       /* NULL */

/* OnCE enable */
#define SYS_ONCE                 /* SYS_ENABLE (0)/SYS_DISABLE (1) */

/* get/test type of the previous RESET */
#define SYS_TEST_RESET_SOURCE   /* any of SYS_xxx_RESET */
/* clear apropriate bit in reset staus register */
#define SYS_CLEAR_RESET_SOURCE  /* any of SYS_xxx_RESET */

/* SIM software control registers */
#define SYS_WRITE_SW_CONTROL_REG0  /* UWord16 */
#define SYS_READ_SW_CONTROL_REG0   /* NULL, returns UWord16 */
#define SYS_WRITE_SW_CONTROL_REG1  /* UWord16 */
#define SYS_READ_SW_CONTROL_REG1   /* NULL, returns UWord16 */
#define SYS_WRITE_SW_CONTROL_REG2  /* UWord16 */
#define SYS_READ_SW_CONTROL_REG2   /* NULL, returns UWord16 */
#define SYS_WRITE_SW_CONTROL_REG3  /* UWord16 */
#define SYS_READ_SW_CONTROL_REG3   /* NULL, returns UWord16 */

/* JTAG ID */
#define SYS_READ_LSH_JTAG_ID       /* NULL, returns UWord16 */
#define SYS_READ_MSH_JTAG_ID       /* NULL, returns UWord16 */

/* enable pull-up for defined pin group */
#define SYS_PULL_UP_ENABLE      /* any of SYS_xxxx_PINS */
/* disable pull-up for defined pin group */
#define SYS_PULL_UP_DISABLE     /* any of SYS_xxxx_PINS */

/* enable CLKOUT pin */
#define SYS_CLKOUT              /* SYS_ENABLE (0)/SYS_DISABLE (1) */
/* select CLSKOUT source */
#define SYS_CLKOUT_SELECT       /* one of SYS_CLKOUT_xxx */

/* reprogram A23-A20 pins for dedicated clock-outs */
#define SYS_ACLK_ENABLE         /* any of SYS_ACLK_xx */
/* revert A23-A20 pins to their original function */
#define SYS_ACLK_DISABLE        /* any of SYS_ACLK_xx */

/* alternative peripheral function selection */
#define SYS_SET_PADS_FUNCTION   /* any combination of SYS_PAD_xxx or SYS_PADS_xxx macros */

/* enable peripheral clock */
#define SYS_PERIPH_CLK_ENABLE   /* any of SYS_xxxx_CLK */
/* disable peripheral clock */
#define SYS_PERIPH_CLK_DISABLE  /* any of SYS_xxxx_CLK */

/* memory reference via the I/O short address mode */
#define SYS_WRITE_IO_SHORT_ADDR_LOCATION_REG  /* UWord32, 18bits effective */
#define SYS_READ_IO_SHORT_ADDR_LOCATION_REG   /* NULL, returns UWord32 */

/* low voltage interrupt enable for defined level */
#define LVI_INT_ENABLE              /* LVI_22V_LEVEL | LVI_27V_LEVEL */
/* low voltage interrupt disable for defined level */
#define LVI_INT_DISABLE             /* LVI_22V_LEVEL | LVI_27V_LEVEL */
/* low voltage interrupt selection */
#define LVI_INT_SELECT              /* LVI_22V_LEVEL | LVI_27V_LEVEL */
/* test low voltage interrupt flags */
#define LVI_GET_LOW_VOLTAGE         /* LVI_22V_LEVEL | LVI_27V_LEVEL */
#define LVI_GET_NONSTICKY_INT_SOURCE/* LVI_22V_LEVEL | LVI_27V_LEVEL */
/* clear low voltage interrupt flags */
#define LVI_CLEAR_LOW_VOLTAGE_INT   /* LVI_INT | LVI_22V_LEVEL | LVI_27V_LEVEL */

/* system bus driven(1)/undriven when not accessed */
#define SEMI_SET_DRIVE_BUS      /* SEMI_DRIVEN (1)/ SEMI_NON_DRIVEN */

/* SEMI operations, just direct register access */
#define SEMI_WRITE_BASE_REGn    /* n=0..7, any combination of SEMI_CSBAR_xx bits */
#define SEMI_READ_BASE_REGn     /* n=0..7, NULL */
#define SEMI_WRITE_OPTION_REGn  /* n=0..7, any combination of SEMI_CSOR_xx bits */
#define SEMI_READ_OPTION_REGn   /* n=0..7, NULL */
#define SEMI_WRITE_TIMING_REGn  /* n=0..7, any combination of SEMI_CSTC_xx bits */
#define SEMI_READ_TIMING_REGn   /* n=0..7, NULL */
#define SEMI_WRITE_CONTROL_REG  /* any combination of SEMI_BCR_xx bits */
#define SEMI_READ_CONTROL_REG   /* NULL */

/****************************************************************************
* SYS constants and type declarations used in the ioctl functions
*****************************************************************************/

#define SYS_ENABLE      1
#define SYS_DISABLE     0

#define SYS_DRIVEN      1
#define SEMI_DRIVEN     1
#define SYS_NON_DRIVEN  0
#define SEMI_NON_DRIVEN 0

/* reset sources */
#define SYS_SW_RESET        SIM_RSTSTS_SWR  
#define SYS_COP_RESET       SIM_RSTSTS_COPR
#define SYS_EXTERN_RESET    SIM_RSTSTS_EXTR
#define SYS_POWER_ON_RESET  SIM_RSTSTS_POR  
#define SYS_ALL_RESETS      (SIM_RSTSTS_SWR | SIM_RSTSTS_COPR | SIM_RSTSTS_EXTR | SIM_RSTSTS_POR)
#define SYS_ANY_RESET       SYS_ALL_RESETS

/* pull-up'ed pin groups */
#define SYS_CAN_PINS        SIM_PUDR_CAN    
#define SYS_EMIMODE_PINS    SIM_PUDR_EMIMODE
#define SYS_RESET_PINS      SIM_PUDR_RESET
#define SYS_RESETB_PINS     SIM_PUDR_RESETB
#define SYS_IRQ_PINS        SIM_PUDR_IRQ    
#define SYS_XBOOT_PINS      SIM_PUDR_XBOOT  
#define SYS_PWMB_PINS       SIM_PUDR_PWMB   
#define SYS_PWMA_PINS       SIM_PUDR_PWMA
#define SYS_PWMA0_PINS      SIM_PUDR_PWMA0
#define SYS_PWMA1_PINS      SIM_PUDR_PWMA1
#define SYS_DATA_PINS       SIM_PUDR_DATA   
#define SYS_CTRL_PINS       SIM_PUDR_CTRL   
#define SYS_ADR_PINS        SIM_PUDR_ADR    
#define SYS_JTAG_PINS       SIM_PUDR_JTAG   
#define SYS_TMRD_PINS       SIM_PUDR_TMRD   
#define SYS_TMRC_PINS       SIM_PUDR_TMRC   
#define SYS_TMRA_PINS       SIM_PUDR_TMRA   

/* clock enable groups */
#define SYS_EMI_CLK       SIM_PCE_EMI
#define SYS_ADCB_CLK      SIM_PCE_ADC_B
#define SYS_ADCA_CLK      SIM_PCE_ADC_A
#define SYS_CAN_CLK       SIM_PCE_CAN
#define SYS_DEC1_CLK      SIM_PCE_DEC_1
#define SYS_DEC0_CLK      SIM_PCE_DEC_0
#define SYS_TMRD_CLK      SIM_PCE_TMR_D
#define SYS_TMRC_CLK      SIM_PCE_TMR_C
#define SYS_TMRB_CLK      SIM_PCE_TMR_B
#define SYS_TMRA_CLK      SIM_PCE_TMR_A
#define SYS_SCI1_CLK      SIM_PCE_SCI_1
#define SYS_SCI0_CLK      SIM_PCE_SCI_0
#define SYS_SPI1_CLK      SIM_PCE_SPI_1
#define SYS_SPI0_CLK      SIM_PCE_SPI_0
#define SYS_PWMB_CLK      SIM_PCE_PWM_B
#define SYS_PWMA_CLK      SIM_PCE_PWM_A

#ifdef CAN2_BASE
#define SYS_CAN2_CLK      (((UWord32)(SIM_PCE2_CAN2)) << 16)
#endif

/* pad functions */
#define SYS_PAD_C3_TB3      ((UWord32)(SIM_GPS_C3_TB3)   | (((UWord32)(SIM_GPS_C3))<<16))
#define SYS_PAD_C3_SS1      ((UWord32)(SIM_GPS_C3_SS1)   | (((UWord32)(SIM_GPS_C3))<<16))
#define SYS_PAD_C2_TB2      ((UWord32)(SIM_GPS_C2_TB2)   | (((UWord32)(SIM_GPS_C2))<<16))
#define SYS_PAD_C2_MISO1    ((UWord32)(SIM_GPS_C2_MISO1) | (((UWord32)(SIM_GPS_C2))<<16))
#define SYS_PAD_C1_TB1      ((UWord32)(SIM_GPS_C1_TB1)   | (((UWord32)(SIM_GPS_C1))<<16))
#define SYS_PAD_C1_MOSI1    ((UWord32)(SIM_GPS_C1_MOSI1) | (((UWord32)(SIM_GPS_C1))<<16))
#define SYS_PAD_C0_TB0      ((UWord32)(SIM_GPS_C0_TB0)   | (((UWord32)(SIM_GPS_C0))<<16))
#define SYS_PAD_C0_SCLK1    ((UWord32)(SIM_GPS_C0_SCLK1) | (((UWord32)(SIM_GPS_C0))<<16))

#define SYS_PADS_SPI1 (SYS_PAD_C3_SS1 | SYS_PAD_C2_MISO1 | SYS_PAD_C1_MOSI1 | SYS_PAD_C0_SCLK1)

#ifdef CAN2_BASE
#define SYS_PAD_D1_CS3      ((UWord32)(SIM_GPS_D1_CS3)    | (((UWord32)(SIM_GPS_D1))<<16))
#define SYS_PAD_D1_CAN2RX   ((UWord32)(SIM_GPS_D1_CAN2RX) | (((UWord32)(SIM_GPS_D1))<<16))
#define SYS_PAD_D0_CS2      ((UWord32)(SIM_GPS_D0_CS2)    | (((UWord32)(SIM_GPS_D0))<<16))
#define SYS_PAD_D0_CAN2TX   ((UWord32)(SIM_GPS_D0_CAN2TX) | (((UWord32)(SIM_GPS_D0))<<16))

#define SYS_PADS_CAN2 (SYS_PAD_D1_CAN2RX | SYS_PAD_D0_CAN2TX)
#endif

/* clkout mux */
#define SYS_CLKOUT_SYSCLK   0x00    /* default sys_clk */
#define SYS_CLKOUT_OSC      0x07    /* oscillator out */
#define SYS_CLKOUT_FOUT     0x08    /* Fout (from OCCS) */
#define SYS_CLKOUT_ADCACLK  0x10
#define SYS_CLKOUT_ADCBCLK  0x11

#define SYS_ACLK_OSC        SIM_CLKOSR_A23_B  /* A23 as oscillator out */
#define SYS_ACLK_SYSCLK2X   SIM_CLKOSR_A22_B  /* A22 as sys_clk2x */
#define SYS_ACLK_SYSCLK     SIM_CLKOSR_A21_B  /* A21 as sys_clk */
#define SYS_ACLK_PRESC      SIM_CLKOSR_A20_B  /* A20 as prescaler clock */

/* LVI levels */
#define LVI_22V_LEVEL       LVI_CONTROL_LVIE22 
#define LVI_27V_LEVEL       LVI_CONTROL_LVIE27
#define LVI_INT             0x0004

/* register bit names and masks */

/* SIM_CONTROL */
#define SIM_CONTROL_EMIMODE 0x0040
#define SIM_CONTROL_ONCEEBL 0x0020
#define SIM_CONTROL_SWRST   0x0010
#define SIM_CONTROL_STOPDIS_MASK        0x000c
#define SIM_CONTROL_STOPDIS_ENABLE      0x0000
#define SIM_CONTROL_STOPDIS_SOFT        0x0004
#define SIM_CONTROL_STOPDIS_PERMANENT   0x0008
#define SIM_CONTROL_WAITDIS_MASK        0x0003
#define SIM_CONTROL_WAITDIS_ENABLE      0x0000
#define SIM_CONTROL_WAITDIS_SOFT        0x0001
#define SIM_CONTROL_WAITDIS_PERMANENT   0x0002

/* SIM_RSTSTS */
#define SIM_RSTSTS_SWR          0x0020
#define SIM_RSTSTS_COPR         0x0010
#define SIM_RSTSTS_EXTR         0x0008
#define SIM_RSTSTS_POR          0x0004

/* SIM_PUDR */
#define SIM_PUDR_PWMA1          0x4000
#define SIM_PUDR_CAN            0x2000
#define SIM_PUDR_EMIMODE        0x1000
#define SIM_PUDR_RESET          0x0800
#define SIM_PUDR_RESETB         0x0800
#define SIM_PUDR_IRQ            0x0400
#define SIM_PUDR_XBOOT          0x0200
#define SIM_PUDR_PWMB           0x0100
#define SIM_PUDR_PWMA           0x0080
#define SIM_PUDR_PWMA0          0x0080
#define SIM_PUDR_DATA           0x0040
#define SIM_PUDR_CTRL           0x0020
#define SIM_PUDR_ADR            0x0010
#define SIM_PUDR_JTAG           0x0008
#define SIM_PUDR_TMRD           0x0004
#define SIM_PUDR_TMRC           0x0002
#define SIM_PUDR_TMRA           0x0001

/* SIM_CLKOSR */
#define SIM_CLKOSR_A23_B        0x0200
#define SIM_CLKOSR_A22_B        0x0100
#define SIM_CLKOSR_A21_B        0x0080
#define SIM_CLKOSR_A20_B        0x0040
#define SIM_CLKOSR_CLKDIS       0x0020
#define SIM_CLKOSR_CLKOSEL_MASK 0x001f

/* SIM_GPS */
#define SIM_GPS_C3              0x0008
#define SIM_GPS_C3_TB3          0x0000
#define SIM_GPS_C3_SS1          0x0008
#define SIM_GPS_C2              0x0004
#define SIM_GPS_C2_TB2          0x0000
#define SIM_GPS_C2_MISO1        0x0004
#define SIM_GPS_C1              0x0002
#define SIM_GPS_C1_TB1          0x0000
#define SIM_GPS_C1_MOSI1        0x0002
#define SIM_GPS_C0              0x0001
#define SIM_GPS_C0_TB0          0x0000
#define SIM_GPS_C0_SCLK1        0x0001

#ifdef CAN2_BASE
#define SIM_GPS_D1              0x0020
#define SIM_GPS_D1_CS3          0x0000
#define SIM_GPS_D1_CAN2RX       0x0020
#define SIM_GPS_D0              0x0010
#define SIM_GPS_D0_CS2          0x0000
#define SIM_GPS_D0_CAN2TX       0x0010
#endif

/* SIM_PCE */
#define SIM_PCE_EMI             0x8000
#define SIM_PCE_ADC_B           0x4000
#define SIM_PCE_ADC_A           0x2000
#define SIM_PCE_CAN             0x1000
#define SIM_PCE_DEC_1           0x0800
#define SIM_PCE_DEC_0           0x0400
#define SIM_PCE_TMR_D           0x0200
#define SIM_PCE_TMR_C           0x0100
#define SIM_PCE_TMR_B           0x0080
#define SIM_PCE_TMR_A           0x0040
#define SIM_PCE_SCI_1           0x0020
#define SIM_PCE_SCI_0           0x0010
#define SIM_PCE_SPI_1           0x0008
#define SIM_PCE_SPI_0           0x0004
#define SIM_PCE_PWM_B           0x0002
#define SIM_PCE_PWM_A           0x0001

/* SIM_PCE2 */
#ifdef CAN2_BASE
#define SIM_PCE2_CAN2           0x0001
#endif

/* LVI_CONTROL */
#define LVI_CONTROL_LVIE27      0x0002
#define LVI_CONTROL_LVIE22      0x0001

/* LVI_STATUS */
#define LVI_STATUS_LVI          0x0010
#define LVI_STATUS_LVIS27S      0x0008
#define LVI_STATUS_LVIS22S      0x0004
#define LVI_STATUS_LVIS27       0x0002
#define LVI_STATUS_LVIS22       0x0001

/* SEMI_CSBAR */
#define SEMI_CSBAR_ADR_MASK     0xfff0
#define SEMI_CSBAR_BLKSZ_MASK   0x000f
#define SEMI_CSBAR_BLKSZ_4K     0x0000
#define SEMI_CSBAR_BLKSZ_8K     0x0001
#define SEMI_CSBAR_BLKSZ_16K    0x0002
#define SEMI_CSBAR_BLKSZ_32K    0x0003
#define SEMI_CSBAR_BLKSZ_64K    0x0004
#define SEMI_CSBAR_BLKSZ_128K   0x0005
#define SEMI_CSBAR_BLKSZ_256K   0x0006
#define SEMI_CSBAR_BLKSZ_512K   0x0007
#define SEMI_CSBAR_BLKSZ_1M     0x0008
#define SEMI_CSBAR_BLKSZ_2M     0x0009
#define SEMI_CSBAR_BLKSZ_4M     0x000a
#define SEMI_CSBAR_BLKSZ_8M     0x000b
#define SEMI_CSBAR_BLKSZ_16M    0x000c

/* SEMI_CSOR */
#define SEMI_CSOR_RWS_MASK      0xf800
#define SEMI_CSOR_BYTEEN_MASK   0x0600
#define SEMI_CSOR_BYTEEN_DIS    0x0000
#define SEMI_CSOR_BYTEEN_LOBYTE 0x0200
#define SEMI_CSOR_BYTEEN_HIBYTE 0x0400
#define SEMI_CSOR_BYTEEN_BOTH   0x0600
#define SEMI_CSOR_RW_MASK       0x0180
#define SEMI_CSOR_RW_DIS        0x0000
#define SEMI_CSOR_RW_WO         0x0080
#define SEMI_CSOR_RW_RO         0x0100
#define SEMI_CSOR_RW_RW         0x0180
#define SEMI_CSOR_PSDS_MASK     0x0060
#define SEMI_CSOR_PSDS_DIS      0x0000
#define SEMI_CSOR_PSDS_DSONLY   0x0020
#define SEMI_CSOR_PSDS_PSONLY   0x0040
#define SEMI_CSOR_PSDS_BOTH     0x0060
#define SEMI_CSOR_WWS_MASK      0x001f

/* SEMI_CSTC */
#define SEMI_CSTC_WWSS_MASK     0xc000
#define SEMI_CSTC_WWSH_MASK     0x3000
#define SEMI_CSTC_RWSS_MASK     0x0c00
#define SEMI_CSTC_RWSH_MASK     0x0300
#define SEMI_CSTC_MDAR_MASK     0x0007

/* SEMI_BCR */
#define SEMI_BCR_DRV            0x8000
#define SEMI_BCR_BMDAR_MASK     0x7000
#define SEMI_BCR_BWWS_MASK      0x03e0
#define SEMI_BCR_BRWS_MASK      0x001f

/***********************************************************************
* SYS control command macros
***********************************************************************/

/* SYS initialization */
void sysInit(arch_sSIM *pSimBase);
#define ioctlSYS_INIT(pSimBase, param) sysInit(pSimBase)

/* reprogramable "stop" instruction disable */ 
#define ioctlSYS_STOP(pSimBase, param) \
  if(param) periphBitClear(SIM_CONTROL_STOPDIS_SOFT, &((pSimBase)->sim_control)); \
  else  periphBitSet(SIM_CONTROL_STOPDIS_SOFT, &((pSimBase)->sim_control))

/* permanent "stop" instruction disable (can be enabled only by RESET) */
#define ioctlSYS_STOP_PERMANENT_DISABLE(pSimBase, param) \
   periphBitSet(SIM_CONTROL_STOPDIS_PERMANENT, &((pSimBase)->sim_control))

/* reprogramable "wait" instruction disable */ 
#define ioctlSYS_WAIT(pSimBase, param) \
  if(param) periphBitClear(SIM_CONTROL_WAITDIS_SOFT, &((pSimBase)->sim_control)); \
  else  periphBitSet(SIM_CONTROL_WAITDIS_SOFT, &((pSimBase)->sim_control))

/* permanent "wait" instruction disable (can be enabled only by RESET) */
#define ioctlSYS_WAIT_PERMANENT_DISABLE(pSimBase, param) \
   periphBitSet(SIM_CONTROL_WAITDIS_PERMANENT, &((pSimBase)->sim_control))

/* issue software reset */
#define ioctlSYS_SOFTWARE_RESET(pSimBase, param) \
  periphBitSet(SIM_CONTROL_SWRST, &((pSimBase)->sim_control))

/* OnCE enable/disable */
#define ioctlSYS_ONCE(pSimBase, param) \
  if(param) periphBitSet(SIM_CONTROL_ONCEEBL, &((pSimBase)->sim_control));\
  else periphBitClear(SIM_CONTROL_ONCEEBL, &((pSimBase)->sim_control))

/* OnCE enable */
#define ioctlSYS_ONCE_ENABLE(pSimBase, param) \
  periphBitSet(SIM_CONTROL_ONCEEBL, &((pSimBase)->sim_control))

/* OnCE enable only if core TAP is enabled  */
#define ioctlSYS_ONCE_DISABLE(pSimBase, param) \
  periphBitClear(SIM_CONTROL_ONCEEBL, &((pSimBase)->sim_control))

/* test reset status SWR, COPR, EXTR, POR bits */
#define ioctlSYS_TEST_RESET_SOURCE(pSimBase, param) \
  periphBitTest(param, &((pSimBase)->sim_rststs))

/* clear reset status SWR, COPR, EXTR, POR bits */
/*
#define ioctlSYS_CLEAR_RESET_SOURCE(pSimBase, param) \
  periphBitSet(param, &((pSimBase)->sim_rststs))
*/
#define ioctlSYS_CLEAR_RESET_SOURCE(pSimBase, param) \
  periphMemInvBitSet(param, &((pSimBase)->sim_rststs))

/* SIM software control registers */ 
#define ioctlSYS_WRITE_SW_CONTROL_REG0(pSimBase, param) \
  periphMemWrite(param, &((pSimBase)->sim_scr0))

#define ioctlSYS_WRITE_SW_CONTROL_REG1(pSimBase, param) \
  periphMemWrite(param, &((pSimBase)->sim_scr1))

#define ioctlSYS_WRITE_SW_CONTROL_REG2(pSimBase, param) \
  periphMemWrite(param, &((pSimBase)->sim_scr2))

#define ioctlSYS_WRITE_SW_CONTROL_REG3(pSimBase, param) \
  periphMemWrite(param, &((pSimBase)->sim_scr3))

#define ioctlSYS_READ_SW_CONTROL_REG0(pSimBase, param) \
  periphMemRead(&((pSimBase)->sim_scr0))

#define ioctlSYS_READ_SW_CONTROL_REG1(pSimBase, param) \
  periphMemRead(&((pSimBase)->sim_scr1))

#define ioctlSYS_READ_SW_CONTROL_REG2(pSimBase, param) \
  periphMemRead(&((pSimBase)->sim_scr2))

#define ioctlSYS_READ_SW_CONTROL_REG3(pSimBase, param) \
  periphMemRead(&((pSimBase)->sim_scr3))


/* JTAG ID */
#define ioctlSYS_READ_LSH_JTAG_ID(pSimBase, param) \
  periphMemRead(&((pSimBase)->sim_lsh_id))

#define ioctlSYS_READ_MSH_JTAG_ID(pSimBase, param) \
  periphMemRead(&((pSimBase)->sim_msh_id))


/* SYS pull-ups enable */
#define ioctlSYS_PULL_UP_ENABLE(pSimBase, param) \
  periphBitClear(param, &((pSimBase)->sim_pudr))

/* SYS pull-ups disable */
#define ioctlSYS_PULL_UP_DISABLE(pSimBase, param) \
  periphBitSet(param, &((pSimBase)->sim_pudr))

/* enable/disable CLKOUT pin */
#define ioctlSYS_CLKOUT(pSimBase, param) \
  if(param) periphBitClear(SIM_CLKOSR_CLKDIS, &((pSimBase)->sim_clkosr));\
  else periphBitSet(SIM_CLKOSR_CLKDIS, &((pSimBase)->sim_clkosr))
  
/* enable CLKOUT pin */
#define ioctlSYS_CLKOUT_ENABLE(pSimBase, param)  \
  periphBitClear(SIM_CLKOSR_CLKDIS, &((pSimBase)->sim_clkosr))
  
/* disable CLKOUT pin */
#define ioctlSYS_CLKOUT_DISABLE(pSimBase, param) \
  periphBitSet(SIM_CLKOSR_CLKDIS, &((pSimBase)->sim_clkosr))

/* select CLSKOUT source */
#define ioctlSYS_CLKOUT_SELECT(pSimBase, param)  \
  periphBitGrpSet(SIM_CLKOSR_CLKOSEL_MASK, param, &((pSimBase)->sim_clkosr))

/* reprogram A23-A20 pins for dedicated clock-outs */
#define ioctlSYS_ACLK_ENABLE(pSimBase, param)    \
  periphBitSet(param, &((pSimBase)->sim_clkosr))

/* revert A23-A20 pins to their original function */
#define ioctlSYS_ACLK_DISABLE(pSimBase, param)   \
  periphBitClear(param, &((pSimBase)->sim_clkosr))

/* alternate pad function selection */
#define ioctlSYS_SET_PADS_FUNCTION(pSimBase, param) \
  periphBitGrpSet((UWord16)((param)>>16),(UWord16)((param)&0xffff), &((pSimBase)->sim_gps))

/* peripheral clock */
#ifdef CAN2_BASE
#define ioctlSYS_PERIPH_CLK_DISABLE(pSimBase, param) \
  { if(((param) & 0xFFFF)) periphBitClear(param, &((pSimBase)->sim_pce)); \
    if(((param) & 0xFFFF0000L)) periphBitClear((param)>>16, &((pSimBase)->sim_pce2)); }
#define ioctlSYS_PERIPH_CLK_ENABLE(pSimBase, param) \
  { if(((param) & 0xFFFF)) periphBitSet(param, &((pSimBase)->sim_pce)); \
    if(((param) & 0xFFFF0000L)) periphBitSet((param)>>16, &((pSimBase)->sim_pce2)); }
    
#else /* CAN2_BASE */
#define ioctlSYS_PERIPH_CLK_DISABLE(pSimBase, param) \
  periphBitClear(param, &((pSimBase)->sim_pce))
#define ioctlSYS_PERIPH_CLK_ENABLE(pSimBase, param) \
  periphBitSet(param, &((pSimBase)->sim_pce))
#endif /* CAN2_BASE */

/* memory reference via the I/O short address mode */
#define ioctlSYS_WRITE_IO_SHORT_ADDR_LOCATION_REG(pSimBase, param) \
  { periphMemWrite((UWord16)(((UWord32)(param)) & 0xFFFF), &((pSimBase)->sim_isall));   \
    periphMemWrite((UWord16)(((UWord32)(param)) >> 16), &((pSimBase)->sim_isalh));  }

#define ioctlSYS_READ_IO_SHORT_ADDR_LOCATION_REG(pSimBase, param) \
  (  (UWord32) periphMemRead(&((pSimBase)->sim_isall)) + \
    ((UWord32)(periphMemRead(&((pSimBase)->sim_isalh)) & 3) << 16) )

/********** LVI **********/

/* LVI low voltage interrupt enable */
#define ioctlLVI_INT_ENABLE(pLviBase, param) \
  periphBitSet(param, &((pLviBase)->lvictlr))

/* LVI low voltage interrupt disable */
#define ioctlLVI_INT_DISABLE(pLviBase, param) \
  periphBitClear(param, &((pLviBase)->lvictlr))

/* LVI low voltage interrupt selection */
#define ioctlLVI_INT_SELECT(pLviBase, param) \
  periphBitGrpSR(LVI_CONTROL_LVIE22|LVI_CONTROL_LVIE27, param, &((pLviBase)->lvictlr))

/* test LVI Status LVIS27, LVIS22 bits */
#define ioctlLVI_GET_LOW_VOLTAGE(pLviBase, param) \
  periphBitTest(((param) << 2), &((pLviBase)->lvisr))

#define ioctlLVI_GET_NONSTICKY_INT_SOURCE(pLviBase, param) \
  periphBitTest(param, &((pLviBase)->lvisr))

/* clear LVI Status LVIS27, LVIS22 bits (cleared by writing "1") */
#define ioctlLVI_CLEAR_LOW_VOLTAGE(pLviBase, param) \
  periphMemWrite(((param) << 2), &((pLviBase)->lvisr))

#define ioctlLVI_CLEAR_LOW_VOLTAGE_INT(pLviBase, param) \
  periphMemWrite(((param) << 2), &((pLviBase)->lvisr))

/********** SEMI **********/

/* write base register */
#define ioctlSEMI_WRITE_BASEREG_0(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[0]))
#define ioctlSEMI_WRITE_BASEREG_1(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[1]))
#define ioctlSEMI_WRITE_BASEREG_2(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[2]))
#define ioctlSEMI_WRITE_BASEREG_3(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[3]))
#define ioctlSEMI_WRITE_BASEREG_4(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[4]))
#define ioctlSEMI_WRITE_BASEREG_5(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[5]))
#define ioctlSEMI_WRITE_BASEREG_6(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[6]))
#define ioctlSEMI_WRITE_BASEREG_7(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[7]))

#define ioctlSEMI_WRITE_BASE_REG0(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[0]))
#define ioctlSEMI_WRITE_BASE_REG1(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[1]))
#define ioctlSEMI_WRITE_BASE_REG2(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[2]))
#define ioctlSEMI_WRITE_BASE_REG3(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[3]))
#define ioctlSEMI_WRITE_BASE_REG4(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[4]))
#define ioctlSEMI_WRITE_BASE_REG5(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[5]))
#define ioctlSEMI_WRITE_BASE_REG6(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[6]))
#define ioctlSEMI_WRITE_BASE_REG7(pSemiBase, param) \
  periphMemWrite(param, &((pSemiBase)->csbar[7]))


/* read base register */
#define ioctlSEMI_READ_BASEREG_0(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[0]))
#define ioctlSEMI_READ_BASEREG_1(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[1]))
#define ioctlSEMI_READ_BASEREG_2(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[2]))
#define ioctlSEMI_READ_BASEREG_3(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[3]))
#define ioctlSEMI_READ_BASEREG_4(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[4]))
#define ioctlSEMI_READ_BASEREG_5(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[5]))
#define ioctlSEMI_READ_BASEREG_6(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[6]))
#define ioctlSEMI_READ_BASEREG_7(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[7]))

#define ioctlSEMI_READ_BASE_REG0(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[0]))
#define ioctlSEMI_READ_BASE_REG1(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[1]))
#define ioctlSEMI_READ_BASE_REG2(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[2]))
#define ioctlSEMI_READ_BASE_REG3(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[3]))
#define ioctlSEMI_READ_BASE_REG4(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[4]))
#define ioctlSEMI_READ_BASE_REG5(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[5]))
#define ioctlSEMI_READ_BASE_REG6(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[6]))
#define ioctlSEMI_READ_BASE_REG7(pSemiBase, param)  \
  periphMemRead(&((pSemiBase)->csbar[7]))

/* write option register */
#define ioctlSEMI_WRITE_OPTIONREG_0(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[0]))
#define ioctlSEMI_WRITE_OPTIONREG_1(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[1]))
#define ioctlSEMI_WRITE_OPTIONREG_2(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[2]))
#define ioctlSEMI_WRITE_OPTIONREG_3(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[3]))
#define ioctlSEMI_WRITE_OPTIONREG_4(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[4]))
#define ioctlSEMI_WRITE_OPTIONREG_5(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[5]))
#define ioctlSEMI_WRITE_OPTIONREG_6(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[6]))
#define ioctlSEMI_WRITE_OPTIONREG_7(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[7]))

#define ioctlSEMI_WRITE_OPTION_REG0(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[0]))
#define ioctlSEMI_WRITE_OPTION_REG1(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[1]))
#define ioctlSEMI_WRITE_OPTION_REG2(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[2]))
#define ioctlSEMI_WRITE_OPTION_REG3(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[3]))
#define ioctlSEMI_WRITE_OPTION_REG4(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[4]))
#define ioctlSEMI_WRITE_OPTION_REG5(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[5]))
#define ioctlSEMI_WRITE_OPTION_REG6(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[6]))
#define ioctlSEMI_WRITE_OPTION_REG7(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->csor[7]))


/* read option register */
#define ioctlSEMI_READ_OPTIONREG_0(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[0]))
#define ioctlSEMI_READ_OPTIONREG_1(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[1]))
#define ioctlSEMI_READ_OPTIONREG_2(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[2]))
#define ioctlSEMI_READ_OPTIONREG_3(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[3]))
#define ioctlSEMI_READ_OPTIONREG_4(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[4]))
#define ioctlSEMI_READ_OPTIONREG_5(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[5]))
#define ioctlSEMI_READ_OPTIONREG_6(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[6]))
#define ioctlSEMI_READ_OPTIONREG_7(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[7]))

#define ioctlSEMI_READ_OPTION_REG0(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[0]))
#define ioctlSEMI_READ_OPTION_REG1(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[1]))
#define ioctlSEMI_READ_OPTION_REG2(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[2]))
#define ioctlSEMI_READ_OPTION_REG3(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[3]))
#define ioctlSEMI_READ_OPTION_REG4(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[4]))
#define ioctlSEMI_READ_OPTION_REG5(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[5]))
#define ioctlSEMI_READ_OPTION_REG6(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[6]))
#define ioctlSEMI_READ_OPTION_REG7(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->csor[7]))


/* write timing register */
#define ioctlSEMI_WRITE_TIMINGREG_0(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[0]))
#define ioctlSEMI_WRITE_TIMINGREG_1(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[1]))
#define ioctlSEMI_WRITE_TIMINGREG_2(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[2]))
#define ioctlSEMI_WRITE_TIMINGREG_3(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[3]))
#define ioctlSEMI_WRITE_TIMINGREG_4(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[4]))
#define ioctlSEMI_WRITE_TIMINGREG_5(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[5]))
#define ioctlSEMI_WRITE_TIMINGREG_6(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[6]))
#define ioctlSEMI_WRITE_TIMINGREG_7(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[7]))

#define ioctlSEMI_WRITE_TIMING_REG0(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[0]))
#define ioctlSEMI_WRITE_TIMING_REG1(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[1]))
#define ioctlSEMI_WRITE_TIMING_REG2(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[2]))
#define ioctlSEMI_WRITE_TIMING_REG3(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[3]))
#define ioctlSEMI_WRITE_TIMING_REG4(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[4]))
#define ioctlSEMI_WRITE_TIMING_REG5(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[5]))
#define ioctlSEMI_WRITE_TIMING_REG6(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[6]))
#define ioctlSEMI_WRITE_TIMING_REG7(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->cstc[7]))


/* read timing register */
#define ioctlSEMI_READ_TIMINGREG_0(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[0]))
#define ioctlSEMI_READ_TIMINGREG_1(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[1]))
#define ioctlSEMI_READ_TIMINGREG_2(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[2]))
#define ioctlSEMI_READ_TIMINGREG_3(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[3]))
#define ioctlSEMI_READ_TIMINGREG_4(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[4]))
#define ioctlSEMI_READ_TIMINGREG_5(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[5]))
#define ioctlSEMI_READ_TIMINGREG_6(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[6]))
#define ioctlSEMI_READ_TIMINGREG_7(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[7]))

#define ioctlSEMI_READ_TIMING_REG0(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[0]))
#define ioctlSEMI_READ_TIMING_REG1(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[1]))
#define ioctlSEMI_READ_TIMING_REG2(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[2]))
#define ioctlSEMI_READ_TIMING_REG3(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[3]))
#define ioctlSEMI_READ_TIMING_REG4(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[4]))
#define ioctlSEMI_READ_TIMING_REG5(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[5]))
#define ioctlSEMI_READ_TIMING_REG6(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[6]))
#define ioctlSEMI_READ_TIMING_REG7(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->cstc[7]))

/* write control register */
#define ioctlSEMI_WRITE_CONTROLREG(pSemiBase, param)    \
  periphMemWrite(param, &((pSemiBase)->bcr))
#define ioctlSEMI_WRITE_CONTROL_REG(pSemiBase, param)   \
  periphMemWrite(param, &((pSemiBase)->bcr))

/* read control register */
#define ioctlSEMI_READ_CONTROLREG(pSemiBase, param) \
  periphMemRead(&((pSemiBase)->bcr))
#define ioctlSEMI_READ_CONTROL_REG(pSemiBase, param)    \
  periphMemRead(&((pSemiBase)->bcr))

/* system bus driven(1)/undriven when not accessed */
#define ioctlSYS_SET_DRIVE_BUS(pSemiBase, param) \
 if (param) periphBitSet(SEMI_BCR_DRV, &((pSemiBase)->bcr)); \
 else periphBitClear(SEMI_BCR_DRV, &((pSemiBase)->bcr))

#define ioctlSEMI_SET_DRIVE_BUS(pSemiBase, param) \
 if (param) periphBitSet(SEMI_BCR_DRV, &((pSemiBase)->bcr)); \
 else periphBitClear(SEMI_BCR_DRV, &((pSemiBase)->bcr))

#ifdef __cplusplus
}
#endif

#endif
