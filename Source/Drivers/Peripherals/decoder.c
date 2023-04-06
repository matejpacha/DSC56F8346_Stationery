/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  decoder.c
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.13.0$
*
* Description: Source file for the Quadrature Decoder driver
*
*****************************************************************************/

#include "qs.h"
#include "decoder.h"
#include "initconfig.h"

#ifdef __cplusplus
extern "C" {
#endif

/********************************************************************************
 decoderInit() function performs the Quadrature Decoder module static 
 configuration based on the configurable items from appconfig.h 
 
********************************************************************************/
void decoderInit(arch_sDecoder *pDecBase)
{
#pragma unused(pDecBase)

#if DEC_0_INIT_USED && defined(DEC_0)
	if(pDecBase == DEC_0)
	{  
		#ifdef DEC_0_WTR_INIT
		periphMemWrite(DEC_0_WTR_INIT,&pDecBase->wtr);
		#endif
		#ifdef DEC_0_FIR_INIT
		periphMemWrite(DEC_0_FIR_INIT,&pDecBase->fir);
		#endif
		#ifdef DEC_0_UIR_INIT
		periphMemWrite(DEC_0_UIR_INIT,&pDecBase->uir);
		#endif
		#ifdef DEC_0_LIR_INIT
		periphMemWrite(DEC_0_LIR_INIT,&pDecBase->lir);
		#endif
		#ifdef DEC_0_DECCR_INIT
		periphMemWrite(DEC_0_DECCR_INIT,&pDecBase->deccr);
		#endif
	}
	else
#endif

#if DEC_1_INIT_USED && defined(DEC_1)
	if(pDecBase == DEC_1)
	{
		#ifdef DEC_1_WTR_INIT
		periphMemWrite(DEC_1_WTR_INIT,&pDecBase->wtr);
		#endif
		#ifdef DEC_1_FIR_INIT
		periphMemWrite(DEC_1_FIR_INIT,&pDecBase->fir);
		#endif
		#ifdef DEC_1_UIR_INIT
		periphMemWrite(DEC_1_UIR_INIT,&pDecBase->uir);
		#endif
		#ifdef DEC_1_LIR_INIT
		periphMemWrite(DEC_1_LIR_INIT,&pDecBase->lir);
		#endif
		#ifdef DEC_1_DECCR_INIT
		periphMemWrite(DEC_1_DECCR_INIT,&pDecBase->deccr);
		#endif			
	}
	else
#endif

#if DEC_INIT_USED && defined(DEC)
	if(pDecBase == DEC)
	{
		#ifdef DEC_WTR_INIT
		periphMemWrite(DEC_WTR_INIT,&pDecBase->wtr);
		#endif
		#ifdef DEC_FIR_INIT
		periphMemWrite(DEC_FIR_INIT,&pDecBase->fir);
		#endif
		#ifdef DEC_UIR_INIT
		periphMemWrite(DEC_UIR_INIT,&pDecBase->uir);
		#endif
		#ifdef DEC_LIR_INIT
		periphMemWrite(DEC_LIR_INIT,&pDecBase->lir);
		#endif
		#ifdef DEC_DECCR_INIT
		periphMemWrite(DEC_DECCR_INIT,&pDecBase->deccr);
		#endif			
	}
	else
#endif

	; /* last else case */
}
	    

/********************************************************************************
 decoderCoefCalc() function calculates the scaling coeficients needed for the correct
 functionality of decoderGetScaledPosition() and decoderGetScaledPositionDifference()
 functions. Note, this function must be called before the function call of the above
 mentioned functions.
 decoder_sEncScale structure memebers needed to fill prior calling this routine:
     EncPulses ... the number of encoder pulses
     RevolutionScale ... the number of revoulutions to represent the register full range
       ( this variable has only meaning for decoderGetScaledPositionDifference() function ) 
			                0 ->  +/- PI
							1 ->  +/- 2PI
							2 ->  +/- 4PI
********************************************************************************/

void decoderCoefCalc(decoder_sEncScale *pEncScale)
{
  Word16 stmp, stmp1;
  Word32 ltmp;
  UInt16 ustmp;
  UInt32 ultmp;


  /* scaling for the Position Difference Counter Register */
  if( pEncScale->RevolutionScale == 0 )
  {
	  ltmp = L_mult( pEncScale->EncPulses, 0x0001 );
  }
  else
  {
      ltmp = L_mult( pEncScale->EncPulses, pEncScale->RevolutionScale );
      ltmp = L_shl( ltmp, 1 );
  }

  if( ltmp < 0x00007fffL )
  {
     stmp = extract_l( ltmp );
     pEncScale->normDiffPosCoef = sub( 14, norm_s( stmp ) );
     /* stmp1 = shl( 0x0001, normBits); */
     stmp1 = 0x0001 << (pEncScale->normDiffPosCoef);
     ltmp = L_mult( 0x7fff, stmp1 );
  
     ltmp = ltmp / stmp;
     pEncScale->scaleDiffPosCoef = (Int16)(ltmp / 2 );
  }
  else
  {
     pEncScale->normDiffPosCoef = 0;
     pEncScale->scaleDiffPosCoef = 0;
  }
  
  
   /* scaling for Position Counter Register */
  ltmp = L_mult( pEncScale->EncPulses, 0x0002 );
  pEncScale->normPosCoef = sub( 30, norm_l( ltmp ) );
  ultmp = L_shl( 0x00000001, pEncScale->normPosCoef);
  ustmp = extract_l( ultmp );
  ultmp = impyuu( 0xffff, ustmp );
	
  ltmp = ((long)(ultmp)) / ltmp;
  pEncScale->scalePosCoef = extract_l( ltmp );
  return;
}

/********************************************************************************
 decoderGetScaledPosition() calculates the absolute position. It returns a 32bit
 result where the upper part represesnts the number of revolutions while the lower
 part represents the portion of the current revolution scaled into the 16bit
 unsigned data range.
 Note, the decoderCoefCalc() function must be called prior to the call of this function.
 Attention!  This function forces to hold all data registers when called.
********************************************************************************/

Word32 decoderGetScaledPosition(arch_sDecoder *pDecBase, decoder_sEncScale *pEncScale)
{
    decoder_uReg32bit position, positionReg;
    Int32 iltemp;
	UWord16 revolutionPosition;		/* position inside one revolution */
    Word16 sign;            /* direction of rotation */

    
	/* reading of the registers content */
	/* read number of revolutions, create MSB part of the result, i.e. number of completed rotations */
    position.RegParts.MSBpart = periphMemRead(&pDecBase->rev);  /* RevolutionCounterReg */
        
    /* read the current position */
    positionReg.RegParts.LSBpart = periphMemRead(&pDecBase->lposh);  /* LowerPositionHoldReg */
    positionReg.RegParts.MSBpart = periphMemRead(&pDecBase->uposh);  /* UpperPositionHoldReg */
    
    sign = positionReg.RegParts.MSBpart;  /* to distinguish direction of rotation */
    
    /* convert negative values to positive ones for the subsequent calculations */
    if( sign < 0 ) positionReg.Reg32bit = L_abs(positionReg.Reg32bit);
    
    revolutionPosition = (UWord16)positionReg.RegParts.LSBpart;

	/* scale of revolutionPosition */
    iltemp = (Int32)( impyuu(pEncScale->scalePosCoef, revolutionPosition) );
	iltemp = L_shr(iltemp, pEncScale->normPosCoef);
	
	/* convert back to negative values if originally negative direction */
	if( sign < 0 ) iltemp = L_negate( iltemp );

	revolutionPosition = extract_l(iltemp);
	/* create LSB part of the result, i.e. portion of 1 rotation scaled into 16bits */
    position.RegParts.LSBpart = revolutionPosition;
    
	return( position.Reg32bit );	
}

/********************************************************************************
 decoderGetScaledPositionDifference() returns the scaled relative position - difference.
 The 16bit signed value represents the range determined by the arguments of decoderCoefCalc()
 function.
 Note, the decoderCoefCalc() function must be called prior to the call of this function.
 Attention!  This function forces to hold all data registers when called.
********************************************************************************/

Word16 decoderGetScaledPositionDifference(arch_sDecoder *pDecBase, decoder_sEncScale *pEncScale)
{
   Word16 stmp;
   Word32 ltmp;

   stmp = periphMemRead(&pDecBase->posd);  /* PositionDifferenceReg */

      
   ltmp = L_mult( stmp, pEncScale->scaleDiffPosCoef );
   stmp = pEncScale->normDiffPosCoef + 1;
   ltmp = L_shr( ltmp, stmp );
   stmp = extract_l( ltmp );
      
   return( stmp );
}
	
#ifdef __cplusplus
}
#endif

