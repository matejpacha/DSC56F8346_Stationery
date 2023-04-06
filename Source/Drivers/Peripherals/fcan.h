/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  fcan.h
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.36.0$
*
* Description: FlexCAN driver macros and definitions
*
*****************************************************************************/

#ifndef __FCAN_H
#define __FCAN_H

/* qs.h is a master header file, which must be included */
#if !defined(__ARCH_H) || !defined(__PERIPH_H) || !defined(__APPCONFIG_H)
#error Please include qs.h before fcan.h
#endif

#ifdef __cplusplus
extern "C" {
#endif

/***************************************************************
* FlexCAN module identifier, corresponds to module base address
****************************************************************/

#ifdef CAN_BASE
#define FCAN  (&ArchIO.FCan)
#endif

#ifdef CAN2_BASE
#define FCAN2 (&ArchIO.FCan2)
#endif

/*************************************************************
* arch.h should define device-specific information about FCAN
**************************************************************/

#if !defined(FCAN_VERSION)
#error FCAN is not properly described in arch.h (old Quick_Start version?)
#endif

/******************************************************************************
*
*                      General Interface Description
*
*
* The FlexCAN module is a communication controller implementing the CAN protocol.
* The CAN protocol was primarily designed to be used as a vehicle serial data bus,
* meeting the specific requirements of:
*   • Real-time processing
*   • Reliable operation in the EMI environment of a vehicle
*   • Cost-effectiveness and required bandwidth
*
* For more information, please refer to the user manual for the particular
* chip that you are using, such as the MC56F8300 Peripheral Manual,
* for a description of the FlexCAN device.
*
* The FlexCAN device driver interface uses "ioctl" call to control specific
* FlexCAN functions during operation. For details see "ioctl" call.
*
******************************************************************************/

/***************************************************************
* FlexCAN Message Buffer identifiers, corresponds to MB address
****************************************************************/

typedef arch_sFlexCAN_MB FCAN_MB;

#ifdef FCAN
#define FCAN_MB0    (&ArchIO.FCan.mb[0])
#define FCAN_MB1    (&ArchIO.FCan.mb[1])
#define FCAN_MB2    (&ArchIO.FCan.mb[2])
#define FCAN_MB3    (&ArchIO.FCan.mb[3])
#define FCAN_MB4    (&ArchIO.FCan.mb[4])
#define FCAN_MB5    (&ArchIO.FCan.mb[5])
#define FCAN_MB6    (&ArchIO.FCan.mb[6])
#define FCAN_MB7    (&ArchIO.FCan.mb[7])
#define FCAN_MB8    (&ArchIO.FCan.mb[8])
#define FCAN_MB9    (&ArchIO.FCan.mb[9])
#define FCAN_MB10   (&ArchIO.FCan.mb[10])
#define FCAN_MB11   (&ArchIO.FCan.mb[11])
#define FCAN_MB12   (&ArchIO.FCan.mb[12])
#define FCAN_MB13   (&ArchIO.FCan.mb[13])
#define FCAN_MB14   (&ArchIO.FCan.mb[14])
#define FCAN_MB15   (&ArchIO.FCan.mb[15])
#endif

#ifdef FCAN2
#define FCAN2_MB0   (&ArchIO.FCan2.mb[0])
#define FCAN2_MB1   (&ArchIO.FCan2.mb[1])
#define FCAN2_MB2   (&ArchIO.FCan2.mb[2])
#define FCAN2_MB3   (&ArchIO.FCan2.mb[3])
#define FCAN2_MB4   (&ArchIO.FCan2.mb[4])
#define FCAN2_MB5   (&ArchIO.FCan2.mb[5])
#define FCAN2_MB6   (&ArchIO.FCan2.mb[6])
#define FCAN2_MB7   (&ArchIO.FCan2.mb[7])
#define FCAN2_MB8   (&ArchIO.FCan2.mb[8])
#define FCAN2_MB9   (&ArchIO.FCan2.mb[9])
#define FCAN2_MB10  (&ArchIO.FCan2.mb[10])
#define FCAN2_MB11  (&ArchIO.FCan2.mb[11])
#define FCAN2_MB12  (&ArchIO.FCan2.mb[12])
#define FCAN2_MB13  (&ArchIO.FCan2.mb[13])
#define FCAN2_MB14  (&ArchIO.FCan2.mb[14])
#define FCAN2_MB15  (&ArchIO.FCan2.mb[15])
#endif

/***********************************************************************
* FlexCAN static configuration items for appconfig.h
***********************************************************************/
/*
    #define FCAN_MCR_INIT         0x0000
    #define FCAN_CTL0_INIT        0x0000
    #define FCAN_CTL1_INIT        0x0000
    #define FCAN_IMASK1_INIT      0x0000
    #define FCAN_MAXMB_INIT       0x0000
    #define FCAN_RXGMASKL_INIT    0x0000
    #define FCAN_RXGMASKH_INIT    0x0000
    #define FCAN_RX14MASKL_INIT   0x0000
    #define FCAN_RX14MASKH_INIT   0x0000
    #define FCAN_RX15MASKL_INIT   0x0000
    #define FCAN_RX15MASKH_INIT   0x0000

    #define INTERRUPT_VECTOR_ADDR_yy  // specify interrupt handler routine
    #define INT_PRIORITY_LEVEL_yy     // interrupt level : (INTC_DISABLED, INTC_LEVEL0,
                                      //                   INTC_LEVEL1 or INTC_LEVEL2)
    where:
         yy  is interrupt vector number
            e.g. On 56F8346
                26 - FlexCAN Bus-Off
                27 - FlexCAN Error
                28 - FlexCAN Wake-up
                29 - FlexCAN Message Buffer Interrupt
*/

/***************************************************
* FlexCAN ioctl commands
****************************************************/
/* command                    |        Param       */

#define FCAN_INIT               /* FlexCAN peripheral initialization, NULL */
#define FCAN_STOP_MODE          /* Enter/leave sleeping state (STOP), FCAN_ENABLE/FCAN_DISABLE */
#define FCAN_DEBUG_MODE         /* Enter/Leave HALT (Debug) mode; FCAN_ENABLE/FCAN_DISABLE */

#define FCAN_SOFT_RESET         /* Issue soft-reset (auto-negated), NULL */
#define FCAN_SELF_WAKEUP_MODE   /* Enable/disable Self-Wakeup mode without CPU intervention; FCAN_ENABLE/FCAN_DISABLE */
#define FCAN_AUTO_PWRSAVE_MODE  /* Enable/disable Auto power save mode; FCAN_ENABLE/FCAN_DISABLE */

#define FCAN_TEST_READY         /* Test (negation of) NOTRDY bit in MCR; NULL */
#define FCAN_TEST_DEBUG         /* Test FREEZ_ACK bit in MCR; NULL */
#define FCAN_TEST_STOP          /* Test STOP_ACK bit in MCR; NULL */

#define FCAN_INT_ENABLE         /* Enable interrupts; FCAN_BUSOFF_INT | FCAN_ERROR_INT | FCAN_WAKEUP_INT */
#define FCAN_INT_DISABLE        /* Disable interrupts; FCAN_BUSOFF_INT | FCAN_ERROR_INT | FCAN_WAKEUP_INT */

#define FCAN_LOOPBACK_MODE      /* Enable/disable test loopback mode; FCAN_ENABLE/FCAN_DISABLE */
#define FCAN_TIMER_SYNC_MODE    /* Enable/disable Timer Sync mode; FCAN_ENABLE/FCAN_DISABLE */
#define FCAN_LISTEN_ONLY_MODE   /* Enable/disable Listen Only mode; FCAN_ENABLE/FCAN_DISABLE */
#define FCAN_SET_TX_FIRST_SCHEME /* set transmit-first scheme; FCAN_LOWEST_ID/FCAN_LOWEST_MB_NUMBER */

#define FCAN_SET_SAMPLING       /* set samples per bit; FCAN_1SAMP_PER_BIT / FCAN_3SAMPS_PER_BIT  */
#define FCAN_SET_PRESCALER      /* set PRES_DIV-1; number 0, .. 255 */
#define FCAN_SET_RJW            /* set RJW; FCAN_RJW_x or (number-1) 0, .. 3 */
#define FCAN_SET_PROP_SEG       /* set PROP_SEG; FCAN_PROPSEG_n or (number-1) 0, .. 7 */
#define FCAN_SET_PHASE_SEG1     /* set PHASE_SEG1; FCAN_PSEG_1 or (number-1) 0, .. 7 */
#define FCAN_SET_PHASE_SEG2     /* set PHASE_SEG2; FCAN_PSEG_1 or (number-1) 0, .. 7 */

#define FCAN_UNLOCK_ALL_MB      /* Reading FRT (can not be optimized out); NULL */

#define FCAN_GET_MAXMB          /* Get maximum number of MB used */
#define FCAN_SET_MAXMB          /* Set maximum number of MB used; number 0-15 */

#define FCAN_READ_ERR_AND_STATUS /* Read value of fcstatus register (error bits are self-cleared)  */

#define FCAN_CLEAR_BOFF_INT     /* Clear BusOff interrupt fcstatus; NULL */
#define FCAN_CLEAR_ERR_INT      /* Clear Error interrupt fcstatus; NULL */
#define FCAN_CLEAR_WAKE_INT     /* Clear WakeUp interrupt fcstatus; NULL */
#define FCAN_CLEAR_INT          /* Clear selected interrupt states: FCAN_STATUS_BOFF_INT | FCAN_STATUS_ERR_INT | FCAN_STATUS_WAKE_INT */

#define FCAN_MBINT_ENABLE       /* Enable MB interrupts; MB bits or FCAN_MBINT_0, FCAN_MBINT_1, ...  */
#define FCAN_MBINT_DISABLE      /* Disable MB interrupts; MB bits or FCAN_MBINT_0, FCAN_MBINT_1, ... */
#define FCAN_READ_MBINT_FLAGS   /* Read MB interrupt sources; NULL */
#define FCAN_CLEAR_MBINT_FLAGS  /* Clear MB interrupts; MB bits or FCAN_MBINT_0, FCAN_MBINT_1, ... */

#define FCAN_SET_RXGMASK        /* Set Global RX mask, the passed mask is rebuilt to suit the IDR bit-scheme; 32bit mask */
#define FCAN_SET_RXGMASK_V      /* Same as FCAN_SET_RXGMASK but implemented as a function call; 32bit mask */
#define FCAN_SET_RXGMASK_RAW    /* Set Global RX mask, the passed mask must already be in raw (IDR) format, mask_idr */
#define FCAN_SET_RX14MASK       /* Set MB14 RX mask, the passed mask is rebuilt to suit the IDR bit-scheme, mask */
#define FCAN_SET_RX14MASK_V     /* Same as FCAN_SET_RX14MASK but implemented as a function call; 32bit mask */
#define FCAN_SET_RX14MASK_RAW   /* Set MB14 RX mask, the passed mask must already be in raw (IDR) format, mask_idr */
#define FCAN_SET_RX15MASK       /* Set MB15 RX mask, the passed mask is rebuilt to suit the IDR bit-scheme, mask */
#define FCAN_SET_RX15MASK_V     /* Same as FCAN_SET_RX15MASK but implemented as a function call; 32bit mask */
#define FCAN_SET_RX15MASK_RAW   /* Set MB15 RX mask, the passed mask must already be in raw (IDR) format, mask_idr */

#define FCAN_GET_RX_ERR_COUNT   /* read RX error counter; NULL */
#define FCAN_GET_TX_ERR_COUNT   /* read TX error counter; NULL */

/* Message Buffer operations */

#define FCAN_GET_MB_MODULE      /* Get pointer to MB module, MB index */

#define FCANMB_GET_ID           /* Parse 29+1bit ID from the apropriate bits in given MB; NULL */
#define FCANMB_GET_ID_RAW       /* Get 32bit ID as it was received (raw, mixed with IDE,SRR,RTR) in given MB; NULL */
#define FCANMB_GET_LEN          /* Get lenght field of the MB; NULL */
#define FCANMB_GET_DATAPTR      /* Get pointer to data buffer of the MB (as ptr to UWord16); NULL */
#define FCANMB_GET_CODE         /* Get code field of the MB; NULL */
#define FCANMB_GET_TIMESTAMP    /* Get MB TimeStamp, both bytes if available; NULL  */
#define FCANMB_GET_TIMESTAMP8   /* Get MB TimeStamp (lower byte zeroed); NULL  */

#define FCANMB_SET_ID           /* Write given ID to the apropriate bits in given MB (clears RTR); 32bit id value (MSB=ExtID) */
#define FCANMB_SET_ID_V         /* Same as FCAN_SET_MBPTR_ID but implemented as a function call; 32bit id value (MSB=ExtID) */
#define FCANMB_SET_ID_RAW       /* Set 32bit ID as it is to be transmitted (raw, mixed with IDE,SRR,RTR); idraw */
#define FCANMB_SET_RTR          /* Set/Clear RTR bits in given MB; FCAN_ON/FCAN_OFF */
#define FCANMB_SET_LEN          /* Set length field of the MB; length */
#define FCANMB_SET_CODE         /* Set code field of the MB; code */

/****************************************************************************
* FlexCAN constants and type declarations used in the ioctl functions
*****************************************************************************/

#define FCAN_ENABLE     1
#define FCAN_DISABLE    0

#define FCAN_ON         1
#define FCAN_OFF        0

/* enabling/disabling interrupts */
#define FCAN_BUSOFF_INT FCAN_CTL0_BUSOFF_MASK
#define FCAN_ERROR_INT  FCAN_CTL0_ERROR_MASK
#define FCAN_WAKEUP_INT FCAN_MCR_WAKE_MASK

/* bit sampling modes */
#define FCAN_1SAMP_PER_BIT  0
#define FCAN_3SAMPS_PER_BIT 1

/* transmit-first schemes */
#define FCAN_LOWEST_ID          0
#define FCAN_LOWEST_MB_NUMBER   1

/* timing parameters: RJW */
#define FCAN_RJW_1      0
#define FCAN_RJW_2      1
#define FCAN_RJW_3      2
#define FCAN_RJW_4      3

/* PROP_SEG */
#define FCAN_PROPSEG_1  0
#define FCAN_PROPSEG_2  1
#define FCAN_PROPSEG_3  2
#define FCAN_PROPSEG_4  3
#define FCAN_PROPSEG_5  4
#define FCAN_PROPSEG_6  5
#define FCAN_PROPSEG_7  6
#define FCAN_PROPSEG_8  7

/* PHASE_SEG1 and PHASE_SEG2 */
#define FCAN_PSEG_1     0
#define FCAN_PSEG_2     1
#define FCAN_PSEG_3     2
#define FCAN_PSEG_4     3
#define FCAN_PSEG_5     4
#define FCAN_PSEG_6     5
#define FCAN_PSEG_7     6
#define FCAN_PSEG_8     7

/* Message Buffer interupts */
#define FCAN_MBINT_0    0x0001
#define FCAN_MBINT_1    0x0002
#define FCAN_MBINT_2    0x0004
#define FCAN_MBINT_3    0x0008
#define FCAN_MBINT_4    0x0010
#define FCAN_MBINT_5    0x0020
#define FCAN_MBINT_6    0x0040
#define FCAN_MBINT_7    0x0080
#define FCAN_MBINT_8    0x0100
#define FCAN_MBINT_9    0x0200
#define FCAN_MBINT_10   0x0400
#define FCAN_MBINT_11   0x0800
#define FCAN_MBINT_12   0x1000
#define FCAN_MBINT_13   0x2000
#define FCAN_MBINT_14   0x4000
#define FCAN_MBINT_15   0x8000

/* special flags for passing the ID value */
#define FCAN_ID_EXT 0x80000000  /* specifies extended ID anywhere the ID is required */
#define FCAN_ID_RTR 0x40000000  /* turns on the RTR bit when calling FCANMB_SET_ID (only) */

/****************************************************************************
* FlexCAN register bit names
*****************************************************************************/

/* MCR */
#define FCAN_MCR_STOP              0x8000
#define FCAN_MCR_FRZ1              0x4000
#define FCAN_MCR_HALT              0x1000
#define FCAN_MCR_NOT_RDY           0x0800
#define FCAN_MCR_WAKE_MASK         0x0400
#define FCAN_MCR_SOFT_RST          0x0200
#define FCAN_MCR_FREEZ_ACK         0x0100
#define FCAN_MCR_SELF_WAKE         0x0040
#define FCAN_MCR_AUTO_PWR_SAVE     0x0020
#define FCAN_MCR_STOP_ACK          0x0010

/* CTL0 */
#define FCAN_CTL0_BUSOFF_MASK      0x8000
#define FCAN_CTL0_ERROR_MASK       0x4000
#define FCAN_CTL0_SAMP             0x0080
#define FCAN_CTL0_LOOPB            0x0040
#define FCAN_CTL0_TSYNC            0x0020
#define FCAN_CTL0_LBUF             0x0010
#define FCAN_CTL0_LOM              0x0008
#define FCAN_CTL0_PROPSEG_MASK     0x0007

/* CTL1 */
#define FCAN_CTL1_PRES_DIV_MASK    0xff00
#define FCAN_CTL1_RJW_MASK         0x00c0
#define FCAN_CTL1_PSEG1_MASK       0x0038
#define FCAN_CTL1_PSEG2_MASK       0x0007

/* MAXMB */
#define FCAN_MAXMB_TEST_EN         0x0080
#define FCAN_MAXMB_MAXMB_MASK      0x000f

/* STATUS */
#define FCAN_STATUS_BIT1_ERR       0x8000
#define FCAN_STATUS_BIT0_ERR       0x4000
#define FCAN_STATUS_ACK_ERR        0x2000
#define FCAN_STATUS_CRC_ERR        0x1000
#define FCAN_STATUS_FORM_ERR       0x0800
#define FCAN_STATUS_STUFF_ERR      0x0400
#define FCAN_STATUS_TX_WARN        0x0200
#define FCAN_STATUS_RX_WARN        0x0100
#define FCAN_STATUS_IDLE           0x0080
#define FCAN_STATUS_TXRX           0x0040
#define FCAN_STATUS_FCS_MASK       0x0030
#define FCAN_STATUS_FCS_BUSOFF     0x0020
#define FCAN_STATUS_FCS_EACTIVE    0x0000
#define FCAN_STATUS_FCS_EPASSIVE   0x0010
#define FCAN_STATUS_BOFF_INT       0x0004
#define FCAN_STATUS_ERR_INT        0x0002
#define FCAN_STATUS_WAKE_INT       0x0001

/* MB */
#define FCAN_MB_CSW_TIMESTAMP_MASK 0xff00
#define FCAN_MB_CSW_CODE_MASK      0x00f0
#define FCAN_MB_CSW_LENGTH_MASK    0x000f

#define FCAN_MB_IDH_ID_28_18_MASK  0xffe0
#define FCAN_MB_IDH_SRTR           0x0010
#define FCAN_MB_IDH_SRR            0x0010
#define FCAN_MB_IDH_IDE            0x0008
#define FCAN_MB_IDH_ID_17_15_MASK  0x0007

#define FCAN_MB_IDL_ID_14_0_MASK   0xfffe
#define FCAN_MB_IDL_ERTR           0x0001

/* MB codes */
#define FCAN_MB_CODE_RXVOID        0x00   /* buffer void after received data read-out */
#define FCAN_MB_CODE_RXEMPTY       0x40   /* active and empty */
#define FCAN_MB_CODE_RXFULL        0x20   /* filled with received data */
#define FCAN_MB_CODE_RXOVERRUN     0x60   /* receiver overrun (last data) */
#define FCAN_MB_CODE_RXBUSY        0x10   /* just receiving */
#define FCAN_MB_CODE_TXVOID        0x80   /* buffer void before new TX data can be copied into it */
#define FCAN_MB_CODE_TXONCE        0xc0   /* queued for transmission, once */
#define FCAN_MB_CODE_TXRALWAYS     0xa0   /* transmit remote frame always */


/****************************************************************************
* FlexCAN inline functions
*****************************************************************************/

inline UWord32 FCAN_Idr2Id(UWord32 idr)
{
    /* Extended ID ? */
    if(idr & (((UWord32)FCAN_MB_IDH_IDE) << 16))
        return ((idr >> 1) & 0x3FFFFL) | ((idr >> 3) & 0x1FFC0000) | 0x80000000;
    /* Standard ID */
    else
        return idr >> 21;
}

inline UWord32 FCAN_Id2Idr(UWord32 id)
{
    /* Extended ID */
    if(id & FCAN_ID_EXT)
        return (((id & 0x1FFC0000L) << 3) | 0x00180000L | ((id & 0x0003FFFFL) << 1));
    /* Standard ID */
    else
        return id << 21;
}

/* same as above but implemented as function call (use when passing a variable) */
UWord32 FCAN_Id2Idr_V(register UWord32 id);
UWord32 FCAN_Idr2Id_V(register UWord32 idr);

/****************************************************************************
* FlexCAN commands implementation
*****************************************************************************/

/****************/
/* MCR register */

/* FlexCAN peripheral initialization, NULL */
void FCAN_Init(arch_sFlexCAN *pFCanBase);
#define ioctlFCAN_INIT(pFCanBase, param) FCAN_Init(pFCanBase)

/* Issue soft-reset, NULL */
#define ioctlFCAN_SOFT_RESET(pFCanBase, param)  \
  periphBitSet(FCAN_MCR_SOFT_RST, &((pFCanBase)->fcmcr))

/* Enter/leave sleeping state (STOP), FCAN_ENABLE/FCAN_DISABLE */
#define ioctlFCAN_STOP_MODE(pFCanBase, param)   \
  if(param) periphBitSet(FCAN_MCR_STOP, &((pFCanBase)->fcmcr)); \
  else  periphBitClear(FCAN_MCR_STOP, &((pFCanBase)->fcmcr))

/* Enter/Leave Debug (freeze) mode; FCAN_ENABLE/FCAN_DISABLE */
#define ioctlFCAN_DEBUG_MODE(pFCanBase, param)  \
  if(param) { \
    periphBitSet(FCAN_MCR_FRZ1, &((pFCanBase)->fcmcr)); \
    periphBitSet(FCAN_MCR_HALT, &((pFCanBase)->fcmcr)); \
  } else  \
    periphBitClear(FCAN_MCR_HALT | FCAN_MCR_FRZ1, &((pFCanBase)->fcmcr))

/* Enable/disable Self-Wakeup without CPU intervention; FCAN_ENABLE/FCAN_DISABLE */
#define ioctlFCAN_SELF_WAKEUP_MODE(pFCanBase, param)    \
  if(param) periphBitSet(FCAN_MCR_SELF_WAKE, &((pFCanBase)->fcmcr)); \
  else  periphBitClear(FCAN_MCR_SELF_WAKE, &((pFCanBase)->fcmcr))

/* Enable/disable Auto power save mode; FCAN_ENABLE/FCAN_DISABLE */
#define ioctlFCAN_AUTO_PWRSAVE_MODE(pFCanBase, param)   \
  if(param) periphBitSet(FCAN_MCR_AUTO_PWR_SAVE, &((pFCanBase)->fcmcr)); \
  else  periphBitClear(FCAN_MCR_AUTO_PWR_SAVE, &((pFCanBase)->fcmcr))
  
/* Test (negation of) NOTRDY bit in MCR; NULL */
#define ioctlFCAN_TEST_READY(pFCanBase, param)  \
    (! (periphBitTest(FCAN_MCR_NOT_RDY, &((pFCanBase)->fcmcr)) ))

/* Test FREEZ_ACK bit in MCR; NULL */
#define ioctlFCAN_TEST_DEBUG(pFCanBase, param)  \
    periphBitTest(FCAN_MCR_FREEZ_ACK, &((pFCanBase)->fcmcr))
    
/* Test STOP_ACK bit in MCR; NULL */
#define ioctlFCAN_TEST_STOP(pFCanBase, param)   \
    periphBitTest(FCAN_MCR_STOP_ACK, &((pFCanBase)->fcmcr))

/*****************************/
/* interrupts (MCR and CTL0) */

/* Enable interrupts; FCAN_BUSOFF_INT | FCAN_ERROR_INT | FCAN_WAKEUP_INT */
#define ioctlFCAN_INT_ENABLE(pFCanBase, param) {    \
    periphBitSet((param) & FCAN_MCR_WAKE_MASK, &((pFCanBase)->fcmcr)); \
    periphBitSet((param) & (FCAN_CTL0_BUSOFF_MASK | FCAN_CTL0_ERROR_MASK), &((pFCanBase)->fcctl0)); \
  }

/* Disable interrupts; FCAN_BUSOFF_INT | FCAN_ERROR_INT | FCAN_WAKEUP_INT */
#define ioctlFCAN_INT_DISABLE(pFCanBase, param) {   \
    periphBitClear((param) & FCAN_MCR_WAKE_MASK, &((pFCanBase)->fcmcr)); \
    periphBitClear((param) & (FCAN_CTL0_BUSOFF_MASK | FCAN_CTL0_ERROR_MASK), &((pFCanBase)->fcctl0)); \
  }

/*****************/
/* CTL0 register */

/* Enable/disable test loopback mode; FCAN_ENABLE/FCAN_DISABLE */
#define ioctlFCAN_LOOPBACK_MODE(pFCanBase, param)   \
  if(param) {   \
    periphBitSet(FCAN_MAXMB_TEST_EN, &((pFCanBase)->fcmaxmb)); \
    periphBitSet(FCAN_CTL0_LOOPB, &((pFCanBase)->fcctl0)); \
  } else { \
    periphBitClear(FCAN_CTL0_LOOPB, &((pFCanBase)->fcctl0)); \
    periphBitClear(FCAN_MAXMB_TEST_EN, &((pFCanBase)->fcmaxmb)); \
  }

/* Enable/disable Timer Sync mode; FCAN_ENABLE/FCAN_DISABLE */
#define ioctlFCAN_TIMER_SYNC_MODE(pFCanBase, param)     \
  if(param) periphBitSet(FCAN_CTL0_TSYNC, &((pFCanBase)->fcctl0)); \
  else  periphBitClear(FCAN_CTL0_TSYNC, &((pFCanBase)->fcctl0))
  
/* Enable/disable Listen Only mode; FCAN_ENABLE/FCAN_DISABLE */
#define ioctlFCAN_LISTEN_ONLY_MODE(pFCanBase, param)    \
  if(param) periphBitSet(FCAN_CTL0_LOM, &((pFCanBase)->fcctl0)); \
  else  periphBitClear(FCAN_CTL0_LOM, &((pFCanBase)->fcctl0))

/* set transmit-first mode  */
#define ioctlFCAN_SET_TX_FIRST_SCHEME(pFCanBase, param)     \
  if(param) periphBitSet(FCAN_CTL0_LBUF, &((pFCanBase)->fcctl0)); \
  else  periphBitClear(FCAN_CTL0_LBUF, &((pFCanBase)->fcctl0))

/*********************************************************/
/* Setting bitrates and timings in CTL0 & CTL1 registers */

/* set samples per bit; FCAN_1SAMP_PER_BIT / FCAN_3SAMPS_PER_BIT  */
#define ioctlFCAN_SET_SAMPLING(pFCanBase, param)    \
  if(param) periphBitSet(FCAN_CTL0_SAMP, &((pFCanBase)->fcctl0)); \
  else  periphBitClear(FCAN_CTL0_SAMP, &((pFCanBase)->fcctl0))

/* set Propagation Segment (PROP_SEG); number 0, .. 7 */
#define ioctlFCAN_SET_PROP_SEG(pFCanBase, param)    \
  periphBitGrpRS(FCAN_CTL0_PROPSEG_MASK, param, &((pFCanBase)->fcctl0))

/* set PRES_DIV; number 0, .. 255 */
#define ioctlFCAN_SET_PRESCALER(pFCanBase, param)   \
  periphBitGrpRS(FCAN_CTL1_PRES_DIV_MASK, (param) << 8, &((pFCanBase)->fcctl1))

/* set RJW (known also as SJW); number 0, .. 3 */
#define ioctlFCAN_SET_RJW(pFCanBase, param)     \
  periphBitGrpRS(FCAN_CTL1_RJW_MASK, (param) << 6, &((pFCanBase)->fcctl1))

/* set PHASE_SEG1; number 0, .. 7 */
#define ioctlFCAN_SET_PHASE_SEG1(pFCanBase, param)  \
  periphBitGrpRS(FCAN_CTL1_PSEG1_MASK, (param) << 3, &((pFCanBase)->fcctl1))
  
/* set PHASE_SEG2; number 0, .. 7 */
#define ioctlFCAN_SET_PHASE_SEG2(pFCanBase, param)  \
  periphBitGrpRS(FCAN_CTL1_PSEG2_MASK, param, &((pFCanBase)->fcctl1))


/*******************/
/* STATUS register */

/* Read error and status bits; NULL */
#define ioctlFCAN_READ_ERR_AND_STATUS(pFCanBase, param)     \
    periphMemRead(&((pFCanBase)->fcstatus))

/* Clear BusOff interrupt status; NULL */
#define ioctlFCAN_CLEAR_BOFF_INT(pFCanBase, param)  \
    periphMemWrite(FCAN_STATUS_BOFF_INT, &((pFCanBase)->fcstatus))
    
/* Clear Error interrupt status; NULL */
#define ioctlFCAN_CLEAR_ERR_INT(pFCanBase, param)   \
    periphMemWrite(FCAN_STATUS_ERR_INT, &((pFCanBase)->fcstatus))

/* Clear WakeUp interrupt status; NULL */
#define ioctlFCAN_CLEAR_WAKE_INT(pFCanBase, param)  \
    periphMemWrite(FCAN_STATUS_WAKE_INT, &((pFCanBase)->fcstatus))

/* Clear selected interrupt status; param */
#define ioctlFCAN_CLEAR_INT(pFCanBase, param)   \
    periphMemWrite((param) & (FCAN_STATUS_BOFF_INT | FCAN_STATUS_ERR_INT | FCAN_STATUS_WAKE_INT), &((pFCanBase)->fcstatus))


/*******************/
/* Mask registers  */

/* Set Global RX mask, the passed mask is rebuilt to suit the IDR bit-scheme, mask */
#define ioctlFCAN_SET_RXGMASK(pFCanBase, param)     \
  { register UWord32 maskRaw = FCAN_Id2Idr(param);  \
    periphMemWrite((UWord16)(maskRaw), &((pFCanBase)->fcrxgmask_l)); \
    periphMemWrite((UWord16)((maskRaw) >> 16), &((pFCanBase)->fcrxgmask_h)); }
    
/* Set MB14 RX mask, the passed mask is rebuilt to suit the IDR bit-scheme, mask */
#define ioctlFCAN_SET_RX14MASK(pFCanBase, param)    \
  { register UWord32 maskRaw = FCAN_Id2Idr(param);  \
    periphMemWrite((UWord16)(maskRaw), &((pFCanBase)->fcrx14mask_l)); \
    periphMemWrite((UWord16)((maskRaw) >> 16), &((pFCanBase)->fcrx14mask_h)); }
    
/* Set MB15 RX mask, the passed mask is rebuilt to suit the IDR bit-scheme, mask */
#define ioctlFCAN_SET_RX15MASK(pFCanBase, param)    \
  { register UWord32 maskRaw = FCAN_Id2Idr(param);  \
    periphMemWrite((UWord16)(maskRaw), &((pFCanBase)->fcrx15mask_l)); \
    periphMemWrite((UWord16)((maskRaw) >> 16), &((pFCanBase)->fcrx15mask_h)); }

/* Same as FCAN_SET_RX?MASK but implemented as a function call; 32bit mask */
void ioctlFCAN_SET_RXGMASK_V(register arch_sFlexCAN* pFCanMB, register UWord32 mask);
void ioctlFCAN_SET_RX14MASK_V(register arch_sFlexCAN* pFCanMB, register UWord32 mask);
void ioctlFCAN_SET_RX15MASK_V(register arch_sFlexCAN* pFCanMB, register UWord32 mask);
    
/* Set Global RX mask, the passed mask must already be in raw (IDR) format, mask_idr */
#define ioctlFCAN_SET_RXGMASK_RAW(pFCanBase, param)     \
  { periphMemWrite((UWord16)((param) >> 16), &((pFCanBase)->fcrxgmask_h)); \
    periphMemWrite((UWord16)(param), &((pFCanBase)->fcrxgmask_l)); }

/* Set MB14 RX mask, the passed mask must already be in raw (IDR) format, mask_idr */
#define ioctlFCAN_SET_RX14MASK_RAW(pFCanBase, param)    \
  { periphMemWrite((UWord16)((param) >> 16), &((pFCanBase)->fcrx14mask_h)); \
    periphMemWrite((UWord16)(param), &((pFCanBase)->fcrx14mask_l)); }
    
/* Set MB15 RX mask, the passed mask must already be in raw (IDR) format, mask_idr */
#define ioctlFCAN_SET_RX15MASK_RAW(pFCanBase, param)    \
  { periphMemWrite((UWord16)((param) >> 16), &((pFCanBase)->fcrx15mask_h)); \
    periphMemWrite((UWord16)(param), &((pFCanBase)->fcrx15mask_l)); }


/******************/
/* Error Counters */

/* read RX error counter; NULL */
#define ioctlFCAN_GET_RX_ERR_COUNT(pFCanBase, param)    \
  (( periphMemRead(&((pFCanBase)->fc_err_cntrs)) >> 8) & 0xff)
  
/* read TX error counter; NULL */
#define ioctlFCAN_GET_TX_ERR_COUNT(pFCanBase, param)    \
  ( periphMemRead(&((pFCanBase)->fc_err_cntrs)) & 0xff )


/*********/
/* Timer */

/* Read FRT to unlock any MB locked; NULL */
#define ioctlFCAN_UNLOCK_ALL_MB(pFCanBase, param)   \
  periphMemDummyRead(&((pFCanBase)->fctmr))

/*********/
/* MAXMB */

/* Set maximum number of MB used; number 0-15 */
#define ioctlFCAN_SET_MAXMB(pFCanBase, param)   \
  periphBitGrpSR(FCAN_MAXMB_MAXMB_MASK, param, &((pFCanBase)->fcmaxmb))

/* Get maximum number of MB used */
#define ioctlFCAN_GET_MAXMB(pFCanBase, param)   \
  ( periphMemRead(&((pFCanBase)->fcmaxmb)) & FCAN_MAXMB_MAXMB_MASK )


/*****************/
/* MB interrupts */
    
/* Enable MB interrupts; MB bits */
#define ioctlFCAN_MBINT_ENABLE(pFCanBase, param)    \
  periphBitSet(param, &((pFCanBase)->fcimask1))

/* Disable MB interrupts; MB bits */
#define ioctlFCAN_MBINT_DISABLE(pFCanBase, param)   \
  periphBitClear(param, &((pFCanBase)->fcimask1))

/* get MB interrupt source; NULL */
#define ioctlFCAN_READ_MBINT_FLAGS(pFCanBase, param)    \
  periphMemRead(&((pFCanBase)->fciflag1))

/* ack MB interrupts; MB bits */
#define ioctlFCAN_CLEAR_MBINT_FLAGS(pFCanBase, param)   \
  periphMemWrite(param, &((pFCanBase)->fciflag1))

/*******************/
/* Message Buffers */

/* Get pointer to MB structure; MB index */
#define ioctlFCAN_GET_MB_MODULE(pFCanBase, param)   \
    (&((pFCanBase)->mb[param]))

/* Retrieve 32bit ID from the apropriate bits in given MB;  */
UWord32 ioctlFCANMB_GET_ID(register arch_sFlexCAN_MB* pFCanMB, void*);

/* Set 32bit ID to the apropriate bits in given MB (also set/clear RTR);  */
#define ioctlFCANMB_SET_ID(pFCanMB, id) \
  { UWord32 idr = FCAN_Id2Idr(id);  \
    if((id) & FCAN_ID_RTR)  \
        idr |= FCAN_MB_IDL_ERTR | (((UWord32)FCAN_MB_IDH_SRTR) << 16);  \
    periphMemWrite((UWord16)(idr), &((pFCanMB)->id_low)); \
    periphMemWrite((UWord16)(idr >> 16), &((pFCanMB)->id_high)); }

/* same as above but done as function (to be used when ID passed is a variable) */
void ioctlFCANMB_SET_ID_V(register arch_sFlexCAN_MB* pFCanMB, register UWord32 id);

/* Write given ID to the apropriate bits in given MB; FCAN_ON/FCAN_OFF */
#define ioctlFCANMB_SET_RTR(pFCanMB, param)     \
  if(param) { \
    periphBitSet(FCAN_MB_IDH_SRTR, &((pFCanMB)->id_high)); \
    periphBitSet(FCAN_MB_IDL_ERTR, &((pFCanMB)->id_low)); \
  }         \
  else {    \
    if(periphBitTest(FCAN_MB_IDH_IDE, &((pFCanMB)->id_high))) \
     { asm { nop; nop; } \
      periphBitClear(FCAN_MB_IDL_ERTR, &((pFCanMB)->id_low)); } \
    else \
      periphBitClear(FCAN_MB_IDH_SRTR, &((pFCanMB)->id_high)); \
  }

/* Get 32bit ID as it was received (IDR) (mixed with IDE,SRR,RTR) in given MB; NULL */
#define ioctlFCANMB_GET_ID_RAW(pFCanMB, param)  \
  ((((UWord32) periphMemRead(&((pFCanMB)->id_high))) << 16) | ((UWord32) periphMemRead(&((pFCanMB)->id_low))))

/* Set 32bit ID as it is to be transmitted (IDR) (mixed with IDE,SRR,RTR) in given MB;  */
#define ioctlFCANMB_SET_ID_RAW(pFCanMB, param)  \
  { periphMemWrite((UWord16)((((UWord32)(param)) >> 16) & 0xffff), &((pFCanMB)->id_high)); \
    periphMemWrite((UWord16)((param) & 0xffff), &((pFCanMB)->id_low)); }

/* Get lenght field of the MB; NULL */
#define ioctlFCANMB_GET_LEN(pFCanMB, param)     \
  periphBitTest(FCAN_MB_CSW_LENGTH_MASK, &((pFCanMB)->control))

/* Set lenght field of the MB; length */
#define ioctlFCANMB_SET_LEN(pFCanMB, param)     \
  periphBitGrpZS(FCAN_MB_CSW_LENGTH_MASK, param, &((pFCanMB)->control))
    
/* Get code field of the MB; NULL */
inline UWord16 ioctlFCANMB_GET_CODE(register arch_sFlexCAN_MB* pFCanMB, void*)
{
    register UWord16 tmp = periphMemRead(&((pFCanMB)->control));
    tmp &= FCAN_MB_CSW_CODE_MASK;
    return tmp;
}

/* Set code field of the MB; code */
#define ioctlFCANMB_SET_CODE(pFCanMB, param)    \
  { register UWord16 tmp = periphMemRead(&((pFCanMB)->control));    \
    tmp &= ~(FCAN_MB_CSW_CODE_MASK); \
    tmp |= param; \
    periphMemWrite(tmp, &((pFCanMB)->control)); \
  }

/* Get pointer to data buffer of the MB (as ptr to UWord16); NULL */
#define ioctlFCANMB_GET_DATAPTR(pFCanMB, param)     \
  ( (UWord16*)((pFCanMB)->data) )

/* Get MB TimeStamp, both bytes if available, NULL  */
#define ioctlFCANMB_GET_TIMESTAMP(pFCanMB, param)   \
  ( periphBitTest(FCAN_MB_IDH_IDE, &((pFCanMB)->id_high)) ? \
      (periphMemRead(&((pFCanMB)->control)) & 0xff00) : \
      periphMemRead(&((pFCanMB)->id_low)) )

/* Get MB TimeStamp (lower byte zeroed), NULL  */
#define ioctlFCANMB_GET_TIMESTAMP8(pFCanMB, param)  \
  ( periphMemRead(&((pFCanMB)->control)) & 0xff00 )

#ifdef __cplusplus
}
#endif

#endif

