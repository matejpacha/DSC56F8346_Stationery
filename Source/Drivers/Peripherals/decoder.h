/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  decoder.h
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.21.0$
*
* Description: Header file for Quadrature Decoder driver
*
*******************************************************************************/

#ifndef __DECODER_H
#define __DECODER_H

/* qs.h is a master header file, which must be included */
#if !defined(__ARCH_H) || !defined(__PERIPH_H) || !defined(__APPCONFIG_H)
#error Please include qs.h before decoder.h
#endif

#ifdef __cplusplus
extern "C" {
#endif

/***************************************************************************
* Quadrature Decoder module identifiers; corresponds to module base address
****************************************************************************/

#ifdef QD0_BASE
#define DEC_0   (&ArchIO.Decoder0)
#endif

#ifdef QD1_BASE
#define DEC_1   (&ArchIO.Decoder1)
#endif

/*************************************************************
* arch.h should define device-specific information about DEC
**************************************************************/

#if !defined(DEC_VERSION)
#error Decoder (DEC) not properly described in arch.h (old Quick_Start version?)
#endif

/******************************************************************************
*
*                      General Interface Description
*
* On the MC56F8300, the Quad Timer modules A and B share pins with
* Quadrature Decoder modules #0 and #1.
* Each Quadrature Decoder module has four input signals: PHASEA, PHASEB, INDEX,
* and HOME.
* Each Quadrature Decoder module has circuitry called the switch matrix that provides a
* means to share the input pins with an associated timer module.
* 
* The Quadrature Decoder features:
* - Includes logic to decode quadrature signals
* - Configurable digital filter for inputs
* - 32-bit position counter
* - 16-bit position difference register
* - Maximum count frequency equals the peripheral clock rate
* - Position counter can be initialized by SW or external events
* - Preloadable 16-bit revolution counter
* - Inputs can be connected to a general purpose timer to aid low speed velocity
*   measurements
* - Quadrature decoder filter can be bypassed
* - A watchdog timer to detect a non-rotating shaft condition
* 
* For more information, please refer to the user manual for the particular chip that you
* are using, such as the MC56F8300 Peripheral Manual,
* for a description of the Quadratute Decoder device.
*
* The Quadratute Decoder device driver interface uses "ioctl" call to control specific
* Quadratute Decoder functions during operation. For details see "ioctl" call.
*      
*
******************************************************************************/

/****************************************************
* Configurable items, i.e. defines, for appconfig.h
*****************************************************

  void decxxISR( void );              prototype for user ISR 
  #define INT_VECTOR_ADDR_yy          decxxISR
  #define INT_PRIORITY_LEVEL_yy       one of INTC_DISABLED, INTC_LEVEL0, INTC_LEVEL1 or INTC_LEVEL2

  #define  DEC_0_DECCR_INIT   0x0000 
  #define  DEC_0_WTR_INIT     0x0000
  #define  DEC_0_FIR_INIT     0x0000
  #define  DEC_0_UIR_INIT     0x0000
  #define  DEC_0_LIR_INIT     0x0000
    
  and dtto for DEC_1

  where:
         yy  is interrupt vector number
            e.g. for 56F8346:
                50 - Quadrature Decoder 0 INDEX Pulse
                49 - Quadrature Decoder 0 Home switch or Watchdog
                48 - Quadrature Decoder 1 INDEX Pulse
                47 - Quadrature Decoder 1 Home switch or Watchdog

*/

/***********************************************************************
* ioctl() commands
*
*  Word16 ioctl( Decoder_module_identifier, Command_name, Parameter );
*
************************************************************************

 COMMAND NAME                                       PARAMETERS, COMMENTS
------------------------------------------------------------------------------- */
#define DEC_INIT                            /* NULL */

#define DEC_CLEAR_HOME_INT_REQUEST          /* NULL                                HIRQ         */
#define DEC_HOME_INT                        /* DEC_ENABLE / DEC_DISABLE            HIE in DECCR */
#define DEC_HOME_TRIGGERED_INIT             /* DEC_ENABLE / DEC_DISABLE            HIP in DECCR */
#define DEC_HOME_EDGE                       /* DEC_NEGATIVE / DEC_POSITIVE         HNE in DECCR */
#define DEC_SOFTWARE_TRIGGERED_INIT         /* NULL                                SWIP         */
#define DEC_DIRECTION_COUNTING_ENABLE       /* DEC_REVERSE / DEC_NORMAL            REV in DECCR */
#define DEC_SINGLE_PHASE_COUNT              /* DEC_ENABLE / DEC_DISABLE            PH1 in DECCR */
#define DEC_CLEAR_INDEX_PULSE_INT_REQUEST   /* NULL                                XIRQ         */
#define DEC_INDEX_PULSE_INT                 /* DEC_ENABLE / DEC_DISABLE            XIE in DECCR */
#define DEC_INDEX_TRIGGERED_INIT            /* DEC_ENABLE / DEC_DISABLE            XIP in DECCR */
#define DEC_INDEX_EDGE                      /* DEC_NEGATIVE / DEC_POSITIVE         XNE in DECCR */
#define DEC_CLEAR_WATCHDOG_INT_REQUEST      /* NULL                                DIRQ         */
#define DEC_WATCHDOG_INT                    /* DEC_ENABLE / DEC_DISABLE            DIE in DECCR */
#define DEC_WATCHDOG                        /* DEC_ENABLE / DEC_DISABLE            WDE in DECCR */
#define DEC_SWITCH_MATRIX                   /* DEC_MODE_x                          MODE[1:0] in DECCR */

#define DEC_WRITE_FILTER                    /* value */
#define DEC_WRITE_WATCHDOG_TIMEOUT          /* value */
#define DEC_READ_POSITION_DIFFERENCE        /* NULL */
#define DEC_READ_REVOLUTION                 /* NULL */
#define DEC_WRITE_REVOLUTION                /* value */
#define DEC_READ_POSITION                   /* pointer to 32bit value (or to decoder_uReg32bit) */
#define DEC_WRITE_POSITION                  /* value  (32bit) */
#define DEC_WRITE_INIT_STATE                /* value  (32bit) */
#define DEC_READ_MONITOR_REG                /* NULL */
#define DEC_GET_RAW_ENCSIGNALS              /* NULL */
#define DEC_GET_FILTERED_ENCSIGNALS         /* NULL */

#define DEC_READ_HOLD_DATA_REGS             /* *decoder_sState */
#define DEC_READ_CONTROL_REG                /* NULL */

#define DEC_CALCULATE_SCALE_COEF            /* *decoder_sEncScale */
#define DEC_GET_SCALED_POSITION             /* *decoder_sEncScale */
#define DEC_GET_SCALED_POSITION_DIFFERENCE  /* *decoder_sEncScale */

#define DEC_INT_ENABLE                      /* DEC_HOME | DEC_INDEX | DEC_WDTIMEOUT */
#define DEC_INT_DISABLE                     /* DEC_HOME | DEC_INDEX | DEC_WDTIMEOUT */
#define DEC_INT_REQUEST_CLEAR               /* DEC_HOME | DEC_INDEX | DEC_WDTIMEOUT */

/*******************************************************************************
* Quadratute Decoder constants and type declarations used in the ioctl functions
********************************************************************************/

#define DEC_ENABLE      1
#define DEC_DISABLE     0

#define DEC_NEGATIVE    1
#define DEC_POSITIVE    0

#define DEC_REVERSE     1
#define DEC_NORMAL      0

#define DEC_MODE_0      0
#define DEC_MODE_1      1
#define DEC_MODE_2      2

#define DEC_HOME        DEC_DECCR_HIE
#define DEC_INDEX       DEC_DECCR_XIE
#define DEC_WDTIMEOUT   DEC_DECCR_DIE

typedef union
{
    struct
    {
        UWord16 LSBpart;
        Word16 MSBpart;
    } RegParts;
    
    Word32 Reg32bit;
    
} decoder_uReg32bit;

typedef struct
{
    union { Word16 PositionDifferenceHoldReg;
            Word16 posdh; };
    union { Word16 RevolutionHoldReg;
            Word16 revh; };
    union { decoder_uReg32bit PositionHoldReg; 
            Word32 posh; };
            
}decoder_sState;

typedef struct
{
    UWord16 EncPulses;
    UWord16 RevolutionScale;
    
    Int16   scaleDiffPosCoef;
    UInt16  scalePosCoef;
    Int16   normDiffPosCoef;
    Int16   normPosCoef;
} decoder_sEncScale;

typedef struct
{
    UWord16 Index    :1;
    UWord16 PhaseB   :1;
    UWord16 PhaseA   :1;
    UWord16 Reserved :13;
} decoder_sEncSignals;

typedef union
{
    decoder_sEncSignals EncSignals;
    UWord16             Value;
} decoder_uEncSignals;


/*******************************************************************************
*  Register and bit names
********************************************************************************/

/* Decoder Control Register DECCR */
#define DEC_DECCR_HIRQ    0x8000  /* HOME Signal Transition Interrupt Request */
#define DEC_DECCR_HIE     0x4000  /* HOME Interrupt Enable */
#define DEC_DECCR_HIP     0x2000  /* Enable HOME to Initialize UPOS and LPOS */
#define DEC_DECCR_HNE     0x1000  /* Use Negative Edge of HOME Input */
#define DEC_DECCR_SWIP    0x0800  /* Software Triggered Initialization of UPOS and LPOS */
#define DEC_DECCR_REV     0x0400  /* Enable Reverse Direction Counting */
#define DEC_DECCR_PH1     0x0200  /* Enable Signal Phase Count Mode */
#define DEC_DECCR_XIRQ    0x0100  /* Index Pulse Interrupt Request */
#define DEC_DECCR_XIE     0x0080  /* Index Pulse Interrupt Enable */
#define DEC_DECCR_XIP     0x0040  /* Index Triggered Initialization of UPOS and LPOS */
#define DEC_DECCR_XNE     0x0020  /* Use Negative Edge of Index Pulse */
#define DEC_DECCR_DIRQ    0x0010  /* Watchdog Time-Out Interrupt Request */
#define DEC_DECCR_DIE     0x0008  /* Watchdog Time-Out Interrupt Enable */
#define DEC_DECCR_WDE     0x0004  /* Watch Dog Enable */
#define DEC_DECCR_MODE_MASK 0x0003  /* Switch Matrix Mode bits [1:0] */
#define DEC_DECCR_MODE_2 0x0002  /* Switch Matrix Mode 2 */
#define DEC_DECCR_MODE_1 0x0001  /* Switch Matrix Mode 1 */
#define DEC_DECCR_MODE_0 0x0000  /* Switch Matrix Mode 0 */

/* Input Monitor Register IMR */
#define DEC_IMR_FPHA      0x0080  /* filtered PHASEA */
#define DEC_IMR_FPHB      0x0040  /* filtered PHASEB */
#define DEC_IMR_FIND      0x0020  /* filtered INDEX */
#define DEC_IMR_FHOM      0x0010  /* filtered HOME */
#define DEC_IMR_PHA       0x0008  /* raw PHASEA */
#define DEC_IMR_PHB       0x0004  /* raw PHASEB */
#define DEC_IMR_INDEX     0x0002  /* raw INDEX */
#define DEC_IMR_HOME      0x0001  /* raw HOME */

/*******************************************************************************
    Bit names of older SDK version, maintained here for backward compatibility.
*******************************************************************************/

/* Do not use for new development ! */
#define DEC_HIRQ    DEC_DECCR_HIRQ
#define DEC_HIE     DEC_DECCR_HIE 
#define DEC_HIP     DEC_DECCR_HIP 
#define DEC_HNE     DEC_DECCR_HNE 
#define DEC_SWIP    DEC_DECCR_SWIP
#define DEC_REV     DEC_DECCR_REV 
#define DEC_PH1     DEC_DECCR_PH1 
#define DEC_XIRQ    DEC_DECCR_XIRQ
#define DEC_XIE     DEC_DECCR_XIE 
#define DEC_XIP     DEC_DECCR_XIP 
#define DEC_XNE     DEC_DECCR_XNE 
#define DEC_DIRQ    DEC_DECCR_DIRQ
#define DEC_DIE     DEC_DECCR_DIE 
#define DEC_WDE     DEC_DECCR_WDE 
#define DEC_MODE    DEC_DECCR_MODE_MASK

/*******************************************************************************
  Implementations of Quad Decoder ioctl() commands
*******************************************************************************/

/* Quadrature Decoder init */

void decoderInit(arch_sDecoder *pDecBase);  
#define ioctlDEC_INIT(pDecBase, param) decoderInit(pDecBase)

/* Decoder Control Register */

#define ioctlDEC_CLEAR_HOME_INT_REQUEST(pDecBase, param) \
  periphBitClear(DEC_DECCR_XIRQ | DEC_DECCR_DIRQ, &((pDecBase)->deccr))

#define ioctlDEC_HOME_INT(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_HIE, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_HIE, &((pDecBase)->deccr))

#define ioctlDEC_HOME_TRIGGERED_INIT(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_HIP, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_HIP, &((pDecBase)->deccr))

#define ioctlDEC_HOME_EDGE(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_HNE, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_HNE, &((pDecBase)->deccr))

#define ioctlDEC_SOFTWARE_TRIGGERED_INIT(pDecBase, param) \
  periphBitSet(DEC_DECCR_SWIP, &((pDecBase)->deccr))

#define ioctlDEC_DIRECTION_COUNTING_ENABLE(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_REV, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_REV, &((pDecBase)->deccr))

#define ioctlDEC_SINGLE_PHASE_COUNT(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_PH1, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_PH1, &((pDecBase)->deccr))

#define ioctlDEC_CLEAR_INDEX_PULSE_INT_REQUEST(pDecBase, param) \
  periphBitClear(DEC_DECCR_HIRQ | DEC_DECCR_DIRQ, &((pDecBase)->deccr))

#define ioctlDEC_INDEX_PULSE_INT(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_XIE, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_XIE, &((pDecBase)->deccr))

#define ioctlDEC_INDEX_TRIGGERED_INIT(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_XIP, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_XIP, &((pDecBase)->deccr))

#define ioctlDEC_INDEX_EDGE(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_XNE, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_XNE, &((pDecBase)->deccr))

#define ioctlDEC_CLEAR_WATCHDOG_INT_REQUEST(pDecBase, param) \
  periphBitClear(DEC_DECCR_HIRQ | DEC_DECCR_XIRQ, &((pDecBase)->deccr))

#define ioctlDEC_WATCHDOG_INT(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_DIE, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_DIE, &((pDecBase)->deccr))

#define ioctlDEC_WATCHDOG(pDecBase, param) \
  if (param) periphBitSet(DEC_DECCR_WDE, &((pDecBase)->deccr)); \
  else periphBitClear(DEC_DECCR_WDE, &((pDecBase)->deccr))

#define ioctlDEC_SWITCH_MATRIX(pDecBase, param) \
  periphBitGrpRS(DEC_DECCR_MODE_MASK, param, &((pDecBase)->deccr))

#define ioctlDEC_INT_ENABLE(pDecBase, param)        \
  periphBitSet(param, &((pDecBase)->deccr))

#define ioctlDEC_INT_DISABLE(pDecBase, param)       \
  periphBitClear(param, &((pDecBase)->deccr))
  
#define ioctlDEC_INT_REQUEST_CLEAR(pDecBase, param)     \
  periphSafeAckByOne(DEC_DECCR_HIRQ | DEC_DECCR_XIRQ | DEC_DECCR_DIRQ, ((param) << 1), &((pDecBase)->deccr))

#define ioctlDEC_READ_CONTROL_REG(pDecBase, param) \
  periphMemRead(&((pDecBase)->deccr))

/* Filter Interval Register */

#define ioctlDEC_WRITE_FILTER(pDecBase, param) \
  periphMemWrite(param, &((pDecBase)->fir))
         
/* Watchdog Time-out Register */

#define ioctlDEC_WRITE_WATCHDOG_TIMEOUT(pDecBase, param) \
  periphMemWrite(param, &((pDecBase)->wtr))
        
/* Position Diffrence Register */

#define ioctlDEC_READ_POSITION_DIFFERENCE(pDecBase, param) \
  periphMemRead(&((pDecBase)->posd))

/* Revolution Counter Register */

#define ioctlDEC_READ_REVOLUTION(pDecBase, param) \
  periphMemRead(&((pDecBase)->rev))

#define ioctlDEC_WRITE_REVOLUTION(pDecBase, param) \
  periphMemWrite(param, &((pDecBase)->rev))


/* Upper and Lower Position Register */

#define ioctlDEC_READ_POSITION(pDecBase, param) \
  { ((decoder_uReg32bit*)(param))->RegParts.LSBpart = periphMemRead(&((pDecBase)->lpos)); \
    ((decoder_uReg32bit*)(param))->RegParts.MSBpart = periphMemRead(&((pDecBase)->uposh)); }


/* Upper and Lower Initialization Register */

#define ioctlDEC_WRITE_POSITION(pDecBase, param) \
  { periphMemWrite((Word16)((param) >> 16), &((pDecBase)->uir)); \
    periphMemWrite((UWord16)(param), &((pDecBase)->lir)); \
    periphBitSet(DEC_DECCR_SWIP, &((pDecBase)->deccr)); }

#define ioctlDEC_WRITE_INIT_STATE(pDecBase, param) \
  { periphMemWrite((Word16)((param) >> 16), &((pDecBase)->uir)); \
    periphMemWrite((UWord16)(param), &((pDecBase)->lir)); }

/* Input Monitor Register */

#define ioctlDEC_READ_MONITOR_REG(pDecBase, param) \
  periphMemRead(&((pDecBase)->imr))

#define ioctlDEC_GET_RAW_ENCSIGNALS(pDecBase, param) \
  ((periphMemRead(&((pDecBase)->imr)) & 0x000e) >> 1)

#define ioctlDEC_GET_FILTERED_ENCSIGNALS(pDecBase, param) \
  ((periphMemRead(&((pDecBase)->imr)) & 0x00e0) >> 5)
          

/* Decoder Hold Registers */

#define ioctlDEC_READ_HOLD_DATA_REGS(pDecBase, param) \
  { ((decoder_sState*)(param))->PositionDifferenceHoldReg = periphMemRead(&((pDecBase)->posd)); \
    ((decoder_sState*)(param))->RevolutionHoldReg = periphMemRead(&((pDecBase)->revh)); \
    ((decoder_sState*)(param))->PositionHoldReg.RegParts.LSBpart = periphMemRead(&((pDecBase)->lposh)); \
    ((decoder_sState*)(param))->PositionHoldReg.RegParts.MSBpart = periphMemRead(&((pDecBase)->uposh)); }


/***************************************************************************
 the API for the Quadrature Decoder module commands implemented as routines
****************************************************************************/

#define ioctlDEC_CALCULATE_SCALE_COEF(pDecBase, param) \
  decoderCoefCalc((decoder_sEncScale*) (param))

#define ioctlDEC_GET_SCALED_POSITION(pDecBase, param) \
  decoderGetScaledPosition(pDecBase, (decoder_sEncScale*) (param))

#define ioctlDEC_GET_SCALED_POSITION_DIFFERENCE(pDecBase, param) \
  decoderGetScaledPositionDifference(pDecBase, (decoder_sEncScale*) (param))

/* function prototypes, implemented in decoder.c */
void decoderCoefCalc(decoder_sEncScale *pEncScale);
Word32 decoderGetScaledPosition(arch_sDecoder *pDecBase, decoder_sEncScale *pEncScale);
Word16 decoderGetScaledPositionDifference(arch_sDecoder *pDecBase, decoder_sEncScale *pEncScale);

/***************************************************************************
 end-of-life commands, maintained for backward compatibility only
****************************************************************************/

#define ioctlDEC_HOME_INT_REQUEST_CLEAR(pDecBase, param) \
  periphBitClear(DEC_DECCR_XIRQ | DEC_DECCR_DIRQ, &((pDecBase)->deccr))

#define ioctlDEC_INDEX_PULSE_INT_REQUEST_CLEAR(pDecBase, param) \
  periphBitClear(DEC_DECCR_HIRQ | DEC_DECCR_DIRQ, &((pDecBase)->deccr))

#define ioctlDEC_WATCHDOG_INT_REQUEST_CLEAR(pDecBase, param) \
  periphBitClear(DEC_DECCR_HIRQ | DEC_DECCR_XIRQ, &((pDecBase)->deccr))

#define ioctlDEC_INT_SELECT(pDecBase, param)        \
  periphBitGrpRS(DEC_DECCR_HIE | DEC_DECCR_XIE | DEC_DECCR_DIE, param, &((pDecBase)->deccr))


#ifdef __cplusplus
}
#endif
                                    
#endif
