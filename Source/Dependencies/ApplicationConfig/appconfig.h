/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* (c) Copyright 2001-2004 Motorola, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name: appconfig.h
*
* Description: file for static configuration of the application
*              (initial values, interrupt vectors)
*
*****************************************************************************/

#ifndef __APPCONFIG_H
#define __APPCONFIG_H

/*.*************************************************************************
*
*  File generated by Graphical Configuration Tool Wed, 05/Apr/2023, 16:52:25
*
****************************************************************************.*/

#define MC56F8346
#define EXTCLK 8000000L
#define APPCFG_DFLTS_OMITTED 1
#define APPCFG_GCT_VERSION 0x02050300L

/*.
    OCCS Configuration
--------------------------------------------
    Core frequency: 60 MHz 
    VCO frequency: 240 MHz 
    Loss of lock interrupt 0: Disable 
    Loss of lock interrupt 1: Disable 
    Loss of reference clock Interrupt: Disable
    COP operation: Disable
    COP timeout: 8.38861 sec 
    COP Runs in Stop Mode: Disable
    COP Runs in Wait Mode: Disable
    COP Write Protect: Disable
.*/
#define OCCS_PLLCR_INIT                   0x0082U
#define OCCS_PLLDB_INIT                   0x201DU

/*.
    SYS Configuration
--------------------------------------------
    SIM: Power Saving Modes: Stop enabled , Wait enabled 
         OnCE clock to processor core: Enabled when core TAP enabled 
    Clock Output Mode: Off: Tristated 
    SIM - Interrupts: Low voltage 2.2V: Disable
                      Low voltage 2.7V: Disable
    SIM - Pull-up disabled: CAN: No 
                            Control Bus: No , 
                            EMI_MODE: No , JTAG: No 
                            PWM A0: No , PWM A1: No 
                            RESETB: No 
                            XBOOT: No , IRQ: No 
    SIM - Peripheral clock: PWM A: Enable , PWM B: Enable , SPI 0: Enable 
                            SPI 1: Enable , SCI 0: Enable , SCI 1: Enable 
                            TMR A: Enable , TMR B: Enable , TMR C: Enable 
                            TMR D: Enable , DEC 0: Enable , DEC 1: Enable 
                            CAN: Enable , ADC A: Enable , ADC B: Enable 
                            EMI: Enable
.*/
#define SIM_GPS_INIT                      0x0000U

/*.
    SEMI Configuration
--------------------------------------------
    Ext. bus driven when inactive : Disable
    Base (no CS) Write Wait States: 23
    Base (no CS) Read  Wait States: 23
    Minimal Delay before CS access: 0
    Chip Select CS0: Base address: 0x0, Blocksize: 128K , Byte Enable: 128K: Both bytes enable 
                     R/W: Read / Write , PS/DS select: PS only 
    Chip Select CS1: Base address: 0x0, Blocksize: 128K , Byte Enable: 128K: Lower byte enable 
                     R/W: Read / Write , PS/DS select: DS only 
    Chip Select CS2: Base address: 0x0, Blocksize: 128K , Byte Enable: 128K: Upper byte enable 
                     R/W: Read / Write , PS/DS select: DS only 
    Chip Select CS3: Base address: 0x0, Blocksize: 32K , Byte Enable: 32K: Disable 
                     R/W: Disable , PS/DS select: Disable 
    Wait States CS0: Read  Wait States: 3, CS Setup: 0, CS Hold: 0
                     Write Wait States: 3, CS Setup: 0, CS Hold: 0
                     Minimal Delay before other CS access: 3
    Wait States CS1: Read  Wait States: 3, CS Setup: 0, CS Hold: 0
                     Write Wait States: 3, CS Setup: 0, CS Hold: 0
                     Minimal Delay before other CS access: 3
    Wait States CS2: Read  Wait States: 3, CS Setup: 0, CS Hold: 0
                     Write Wait States: 3, CS Setup: 0, CS Hold: 0
                     Minimal Delay before other CS access: 3
    Wait States CS3: Read  Wait States: 23, CS Setup: 0, CS Hold: 0
                     Write Wait States: 23, CS Setup: 0, CS Hold: 0
                     Minimal Delay before other CS access: 3
.*/
#define SEMI_CSBAR0_INIT                  0x0005U
#define SEMI_CSBAR1_INIT                  0x0005U
#define SEMI_CSBAR2_INIT                  0x0005U
#define SEMI_CSOR0_INIT                   0x1FC3U
#define SEMI_CSOR1_INIT                   0x1BA3U
#define SEMI_CSOR2_INIT                   0x1DA3U

/*.
    INTC Configuration
--------------------------------------------
    All maskable interrupts disabled: No 
    IRQ A trigger mode: Low-level sensitive 
    IRQ B trigger mode: Low-level sensitive
.*/
#define INTC_ICTL_INIT                    0x0000U
#define INT_VECTOR_ADDR_64                ISR_QTA0_Cmp
#define INT_PRIORITY_LEVEL_64             INTC_LEVEL0
#define INT_VECTOR_ADDR_72                ISR_SCI0_Rx
#define INT_PRIORITY_LEVEL_72             INTC_LEVEL0
#define INT_VECTOR_ADDR_73                ISR_ADCB_eosi
#define INT_PRIORITY_LEVEL_73             INTC_LEVEL2
#define INT_VECTOR_ADDR_77                ISR_PWMB_reload
#define INT_PRIORITY_LEVEL_77             INTC_LEVEL2

/*.
    QT_A0 Configuration
--------------------------------------------
    Count mode: Counting mode, count rising edges of primary source 
    Primary source: Prescaler (IPB clock/ 4) , 
    Input polarity: True , Output polarity: True 
    Input capture mode: Capture disabled, Input Edge Flag disabled 
    Output mode: Asserted while counter is active 
    Count stop mode: Count repeatedly , Count length: Count until compare and reinitialize , Count direction: Count up 
    Output enable (OFLAG to pin): No 
    Force OFLAG output at startup: No , Forced OFLAG value: 0
    Master mode (broadcast compare event): Disable
    Enable external OFLAG force (on broadcasted event): No 
    Co-channel initialization (on broadcasted event): No 
    Preload Control: 1: Never , Load Reg: 0
                     2: Never , Load Reg: 0
    Interrupts: Overflow: Disabled
                Input edge: Disabled
                Compare: Enabled 
                Cmp 1: Disabled
                Cmp 2: Disabled
.*/
#define QT_A0_CTRL_INIT                   0x3420U
#define QT_A0_SCR_INIT                    0x4000U
#define QT_A0_CMP1_INIT                   0x05DCU

/*.
    QT_C3 Configuration
--------------------------------------------
    Count mode: Triggered mode, edge of secondary source triggers primary count till compare 
    Primary source: Prescaler (IPB clock/ 4) , Secondary: Counter #3 input pin 
    Input polarity: True , Output polarity: True 
    Input capture mode: Capture disabled, Input Edge Flag disabled 
    Output mode: Set on compare, cleared secondary source input edge 
    Count stop mode: Count repeatedly , Count length: Count until compare and reinitialize , Count direction: Count up 
    Force OFLAG output at startup: No , Forced OFLAG value: 0
    Master mode (broadcast compare event): Disable
    Enable external OFLAG force (on broadcasted event): No 
    Co-channel initialization (on broadcasted event): No 
    Preload Control: 1: Never , Load Reg: 0
                     2: Never , Load Reg: 0
    Interrupts: Overflow: Disabled
                Input edge: Disabled
                Compare: Disabled
                Cmp 1: Disabled
                Cmp 2: Disabled
.*/
#define QT_C3_CTRL_INIT                   0xD5A5U
#define QT_C3_CMP1_INIT                   0x02EEU

/*.
    DEC_0 Configuration
--------------------------------------------
    Mode (Sources of timer 0,1,2,3): Mode 0: PhA,PhB,Index,Home 
    Direction of counting: Normal 
    Home pulse to initialize Position Counter: Yes, By positive edge 
    Index pulse to initialize Position Counter: No , 
    Watchdog Operation: Disabled
    Bypass Quadrature Decoder logic: No 
    Watchdog timeout: 0.01667 us 
    Filter interval period: 0.08333 us 
    Interrupts: Home pulse: Disabled
                Index pulse: Disabled
.*/
#define DEC_0_DECCR_INIT                  0x2000U

/*.
    PWM_B Configuration
--------------------------------------------
    PWM module operation: Enabled 
    Prescaler: /4 , PWM clock period: 0.06667 us 
    PWM frequency: 10 kHz , Period: 100 us 
    PWM Deadtime: 1.05 us 
    PWM Reload Frequency: Every opportunity 
    Alignment: Center 
    Debug Mode Operation: Stop 
    Wait Mode Operation: Stop 
    Deadtime Correction Method: Manual correction (no correction) 
    Half Cycle Reload: Disabled
    Keep Hardware Acceleration Register Bits Writable: Disabled
    Output Pad Enable: Disabled
    Load OK: Yes
    Swap & Mask Mode: DSP56F80X compatible 
    Write Protection: No 
    Top Polarity   : Channels 0-1: Positive 
                     Channels 2-3: Positive 
                     Channels 4-5: Positive 
    Bottom Polarity: Channels 0-1: Positive 
                     Channels 2-3: Positive 
                     Channels 4-5: Positive 
    Chann. coupling: Channels 4-5: Complementary 
                     Channels 2-3: Complementary 
                     Channels 0-1: Complementary 
    Clearing Mode:   Fault 0 pin: Manual 
                     Fault 1 pin: Manual 
                     Fault 2 pin: Manual 
                     Fault 3 pin: Manual 
    Asymmetric Operation: Channels 0-1: Off (Correction Method used only) 
                          Channels 2-3: Off (Correction Method used only) 
                          Channels 4-5: Off (Correction Method used only) 
    Current Polarity: Channels 0-1: Value 0 
                      Channels 2-3: Value 2 
                      Channels 4-5: Value 4
.*/
#define PWM_B_PMCTL_INIT                  0x00A3U
#define PWM_B_PWMCM_INIT                  0x02EEU
#define PWM_B_PMDEADTM_INIT               0x0010U
#define PWM_B_PMDISMAP1_INIT              0x0000U
#define PWM_B_PMDISMAP2_INIT              0x0000U

/*.
    GPIO_D Configuration
--------------------------------------------
    Pin  0: Function: GPIO , Direction: Input , PullUp: Enable , Interrupt: Disable, Int.Polarity: Active high , 
    Pin  1: Function: GPIO , Direction: Output , Init.Value: Low - 0 , Interrupt: Disable, Int.Polarity: Active high , Output-Mode: Push-pull , 
    Pin  6: Function: TXD1 , PullUp: Enable , 
    Pin  7: Function: RXD1 , PullUp: Enable , 
    Pin  8: Function: PS/CS0 , PullUp: Enable , 
    Pin  9: Function: DS/CS1 , PullUp: Enable , 
    Pin 10: Function: ISB0 , PullUp: Enable , 
    Pin 11: Function: ISB1 , PullUp: Enable , 
    Pin 12: Function: ISB2 , PullUp: Enable ,
.*/
#define GPIO_D_DDR_INIT                   0x0002U
#define GPIO_D_PER_INIT                   0x1FC0U

/*.
    SCI_0 Configuration
--------------------------------------------
    Baudrate: 117188 bps 
    Enable Receiver: Enable 
    Enable Transmitter: Enable 
    Data word length: 8 bits 
    Parity: None 
    Polarity: True polarity 
    Loop mode: Disable
    Function in Wait Mode: SCI module enabled in Wait Mode 
    Interrupts: RX Full: Enable 
                RX Error: Disable
                TX Empty: Disable
                TX Empty: Disable
.*/
#define SCI_0_SCIBR_INIT                  0x0020U
#define SCI_0_SCICR_INIT                  0x002CU
#define SCI_0_RX_BUFFER_OKLIMIT           0x000FU
#define SCI_0_RX_BUFFER_LOWLIMIT          0x000AU

/*.
    ADC_B Configuration
--------------------------------------------
    Clock frequency: 5 MHz 
    Trigger source: SYNC input 
    Channel Configuration: AN0-AN1: Single ended , AN2-AN3: Single ended 
                           AN4-AN5: Single ended , AN6-AN7: Single ended 
    Channel to Sample Mapping: SMP0: AN2 , SMP1: AN0 , SMP2: AN4 , 
                               SMP4: AN3 , SMP5: AN1 , SMP6: AN5 , 
    Scan Mode: Triggered simultaneous 
    Zero crossing mode: SMP0: Disabled , SMP1: Disabled , SMP2: Disabled , SMP3: Disabled 
                        SMP4: Disabled , SMP5: Disabled , SMP6: Disabled , SMP7: Disabled 
    Power saving mode: Disable
    Power down converter 0 (AN0-AN3): No 
    Power down converter 1 (AN4-AN8): No 
    Power down voltage reference: No 
    Power up delay: 13, Delay: 2.6 us 
    Interrupts: Conversion complete: Enabled 
                High limit error: Disabled
                Low limit error: Disabled
                Zero crossing: Disabled
.*/
#define ADC_B_ADCR1_INIT                  0x1805U
#define ADC_B_ADLST1_INIT                 0x3402U
#define ADC_B_ADLST2_INIT                 0x7513U
#define ADC_B_ADSDIS_INIT                 0x0008U
#define ADC_B_ADOFS0_INIT                 0x4000U
#define ADC_B_ADOFS4_INIT                 0x4000U

/*.
    FCAN Configuration
--------------------------------------------
    Baudrate: 500 kBaud 
    Keep in low-power STOP mode: No 
    Self Wake Up: Disabled
    Halt/Freeze sensitivity: Disabled
    Keep in Halt/Freeze: No 
    Auto power save: Disabled
    Timer Synchronization mode: Disabled
    Loopback mode: Disabled
    Listen Only mode: Disabled
    Sampling: One sample per bit
    Transmission: Lowest ID transmitted first
    Prescaler Divide Factor: 12
    Propagation Segment (PROP_SEG): 1
    Phase Buffer Segment 1 (PHASE_SEG1): 4
    Phase Buffer Segment 2 (PHASE_SEG2): 4
    Re-Synchronization Jump Width (RJW): 1
    Interrupts: Wake up: Disable
                Error  : Disable
                Bus Off: Disable
    MB interrupts: MB0 : No , MB1 : No , MB2 : No , MB3 : No 
                   MB4 : No , MB5 : No , MB6 : No , MB7 : No 
                   MB8 : No , MB9 : No , MB10: No , MB11: No 
                   MB12: No , MB13: No , MB14: No , MB15 : No
.*/
#define FCAN_MCR_INIT                     0x0000U
#define FCAN_CTL0_INIT                    0x0000U
#define FCAN_CTL1_INIT                    0x0B1BU
#define FCAN_RXGMASKL_INIT                0x0000U
#define FCAN_RXGMASKH_INIT                0x00E0U
#define FCAN_RX14MASKL_INIT               0x0000U
#define FCAN_RX14MASKH_INIT               0x00E0U
#define FCAN_RX15MASKL_INIT               0x0000U
#define FCAN_RX15MASKH_INIT               0x00E0U


/*.         End of autogenerated code
********************************************************************** ..*/

#endif
