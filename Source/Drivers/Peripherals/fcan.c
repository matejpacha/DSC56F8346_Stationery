/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  fcan.c
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.20.0$
*
* Description: Source file for the FlexCAN driver
*
*****************************************************************************/

#include "qs.h"
#include "fcan.h"
#include "initconfig.h"

#ifdef __cplusplus
extern "C" {
#endif

/* initialization of FlexCAN */

void FCAN_Init(arch_sFlexCAN *pFCanBase)
{
#pragma unused(pFCanBase)

#if FCAN_INIT_USED || FCAN2_INIT_USED
	/* put the module into soft-reset state */
	periphMemWrite(FCAN_MCR_SOFT_RST, &pFCanBase->fcmcr);
	
	/* wait one cycle */
	asm ( nop );

	/* wait for entering the debug mode (FREEZ_ACK) */
	while(!(periphMemRead(&pFCanBase->fcmcr) & FCAN_MCR_FREEZ_ACK))
		; /* do nothing */
#endif

#if FCAN_INIT_USED && defined(FCAN)
	if (pFCanBase == FCAN)
	{
    	UWord16 i;

		/* configure module */
		#ifdef FCAN_CTL0_INIT
		periphMemWrite(FCAN_CTL0_INIT, &pFCanBase->fcctl0);
		#endif
		#ifdef FCAN_CTL1_INIT
		periphMemWrite(FCAN_CTL1_INIT, &pFCanBase->fcctl1);
		#endif

		/* initialize all MB */	
		for(i=0; i<ARCH_FCAN_MBCOUNT; i++)
			periphMemWrite(0, &pFCanBase->mb[i].csw);
		
		#ifdef FCAN_RXGMASKL_INIT
		periphMemWrite(FCAN_RXGMASKL_INIT, &pFCanBase->fcrxgmask_l);
		#endif
		#ifdef FCAN_RXGMASKH_INIT
		periphMemWrite(FCAN_RXGMASKH_INIT, &pFCanBase->fcrxgmask_h);
		#endif
		#ifdef FCAN_RX14MASKL_INIT
		periphMemWrite(FCAN_RX14MASKL_INIT, &pFCanBase->fcrx14mask_l);
		#endif
		#ifdef FCAN_RX14MASKH_INIT
		periphMemWrite(FCAN_RX14MASKH_INIT, &pFCanBase->fcrx14mask_h);
		#endif
		#ifdef FCAN_RX15MASKL_INIT
		periphMemWrite(FCAN_RX15MASKL_INIT, &pFCanBase->fcrx15mask_l);
		#endif
		#ifdef FCAN_RX15MASKH_INIT
		periphMemWrite(FCAN_RX15MASKH_INIT, &pFCanBase->fcrx15mask_h);
		#endif
		#ifdef FCAN_IMASK1_INIT
		periphMemWrite(FCAN_IMASK1_INIT, &pFCanBase->fcimask1);
		#endif
		#ifdef FCAN_MAXMB_INIT
		periphMemWrite(FCAN_MAXMB_INIT, &pFCanBase->fcmaxmb);
		#endif
		
		/* apply user configuration to the module */
		#ifdef FCAN_MCR_INIT
		periphMemWrite(FCAN_MCR_INIT, &pFCanBase->fcmcr);
		#endif
	}
	else
#endif	

#if FCAN2_INIT_USED && defined(FCAN2)
	if (pFCanBase == FCAN2)
	{
    	UWord16 i;
    	
		/* configure module */
		#ifdef FCAN2_CTL0_INIT
		periphMemWrite(FCAN_CTL0_INIT, &pFCanBase->fcctl0);
		#endif
		#ifdef FCAN2_CTL1_INIT
		periphMemWrite(FCAN_CTL1_INIT, &pFCanBase->fcctl1);
		#endif

		/* initialize all MB */	
		for(i=0; i<ARCH_FCAN_MBCOUNT; i++)
			periphMemWrite(0, &pFCanBase->mb[i].csw);
		
		#ifdef FCAN2_RXGMASKL_INIT
		periphMemWrite(FCAN_RXGMASKL_INIT, &pFCanBase->fcrxgmask_l);
		#endif
		#ifdef FCAN2_RXGMASKH_INIT
		periphMemWrite(FCAN_RXGMASKH_INIT, &pFCanBase->fcrxgmask_h);
		#endif
		#ifdef FCAN2_RX14MASKL_INIT
		periphMemWrite(FCAN_RX14MASKL_INIT, &pFCanBase->fcrx14mask_l);
		#endif
		#ifdef FCAN2_RX14MASKH_INIT
		periphMemWrite(FCAN_RX14MASKH_INIT, &pFCanBase->fcrx14mask_h);
		#endif
		#ifdef FCAN2_RX15MASKL_INIT
		periphMemWrite(FCAN_RX15MASKL_INIT, &pFCanBase->fcrx15mask_l);
		#endif
		#ifdef FCAN2_RX15MASKH_INIT
		periphMemWrite(FCAN_RX15MASKH_INIT, &pFCanBase->fcrx15mask_h);
		#endif
		#ifdef FCAN2_IMASK1_INIT
		periphMemWrite(FCAN_IMASK1_INIT, &pFCanBase->fcimask1);
		#endif
		#ifdef FCAN2_MAXMB_INIT
		periphMemWrite(FCAN_MAXMB_INIT, &pFCanBase->fcmaxmb);
		#endif
		
		/* apply user configuration to the module */
		#ifdef FCAN2_MCR_INIT
		periphMemWrite(FCAN_MCR_INIT, &pFCanBase->fcmcr);
		#endif
	}
	else
#endif

	; /* last else case */
}

/* ID->RAW calculation implemented as inline assembly */

inline UWord32 FCAN_Id2Idr_IASM(register UWord32 id)
{
	register UWord32 ret;
	
	asm {
		tfr id,A;
	
		/* id is in A register */
		brclr #0x8000, A1, std_id;
	
	ext_id:
		asll.l #1,A;		/* move bits IDR[17-0] to right position (A0 is okay) */
		move.w A1,Y1;		/* save upper half of IDR */
		
		bfclr #0xfff8,A1;	/* leave only IDR[17-15] in A1 */
		bfclr #0x7,Y1;		/* leave only IDR[28-18] in Y1 */
		asll.w #2,Y1;		/* move IDR[28-18] to right position */
		or.w Y1,A;			/* build complete IDR in A */
		bfset #0x18,A1;		/* set SRR and IDE bit */
		bra <rtrn;
	
	std_id:
		asll.l #21,A;

	rtrn:
		tfr A,ret;
	}

	/* return in A */
	return ret;
}

/* RAW->ID calculation implemented as inline assembly (to be as fast as possible) */

inline UWord32 FCAN_Idr2Id_IASM(register UWord32 idr)
{
	register UWord32 ret;

	asm {
		tfr idr, A;
		
		/* decide the ID type */
		brclr #8, A1, std_id;		/* jump to process std ID */

	ext_id:
		lsrr.l #1, A;				/* move bits ID[17-0] to the right place */
		tfr A,B;					/* save bits ID[17-0] */
		bfclr #0xfffc,B1;			/* leave only ID[17-0] saved */
		
		lsrr.w #2,A;				/* move bits ID[28-18] to the right place (zero A0) */
		bfclr #0x3,A1;				/* zero position on ID[17-16] */
		or.l B,A;
		bfset #0x8000,A1;			/* mark extended ID (bit 31) */
		bra <rtrn;
		
	std_id:
		lsrr.l #21, A;
	
	rtrn:
		tfr A,ret;
	}

	/* return in A */
	return ret;
}

/* ID->RAW calculation implemented as a function call */

#pragma interrupt called
UWord32 FCAN_Id2Idr_V(register UWord32 id)
{
	return FCAN_Id2Idr_IASM(id);
}

/* RAW->ID calculation implemented as a function call */

#pragma interrupt called
UWord32 FCAN_Idr2Id_V(register UWord32 idr)
{
	return FCAN_Idr2Id_IASM(idr);
}

/* same as FCANMB_SET_ID but implemented as function (to be used when ID passed is a variable) */

#pragma interrupt called
void ioctlFCANMB_SET_ID_V(register arch_sFlexCAN_MB* pFCanMB, register UWord32 id)
{
	register UWord32 idr = FCAN_Id2Idr_IASM(id);
	
	/* set RTR ? */
	if(id & FCAN_ID_RTR)
		idr |= FCAN_MB_IDL_ERTR | (((UWord32)FCAN_MB_IDH_SRTR) << 16);
	
	ioctl(pFCanMB, FCANMB_SET_ID_RAW, idr);
}

/* Same as FCAN_SET_RXGMASK but implemented as a function call; 32bit mask */

#pragma interrupt called
void ioctlFCAN_SET_RXGMASK_V(register arch_sFlexCAN* pFCanBase, register UWord32 mask)
{
	register UWord32 idr = FCAN_Id2Idr_IASM(mask);
	ioctl(pFCanBase, FCAN_SET_RXGMASK_RAW, idr);
}

/* Same as FCAN_SET_RX14MASK but implemented as a function call; 32bit mask */

#pragma interrupt called
void ioctlFCAN_SET_RX14MASK_V(register arch_sFlexCAN* pFCanBase, register UWord32 mask)
{
	register UWord32 idr = FCAN_Id2Idr_IASM(mask);
	ioctl(pFCanBase, FCAN_SET_RX14MASK_RAW, idr);
}

/* Same as FCAN_SET_RX15MASK but implemented as a function call; 32bit mask */

#pragma interrupt called
void ioctlFCAN_SET_RX15MASK_V(register arch_sFlexCAN* pFCanBase, register UWord32 mask)
{
	register UWord32 idr = FCAN_Id2Idr_IASM(mask);
	ioctl(pFCanBase, FCAN_SET_RX15MASK_RAW, idr);
}

/* Retrieve 32bit ID from the apropriate bits in given MB */

#pragma interrupt called
UWord32 ioctlFCANMB_GET_ID(register arch_sFlexCAN_MB* pFCanMB, void*)
{
	register UWord32 ret;
	
	/* optimized assembly conversion */
	asm {
		move.w X:(pFCanMB+1), A;	/* get id_high */
		brclr #8, A1, std_id;		/* jump to process std ID */

	ext_id:
		move.w X:(pFCanMB+2), A0;	/* get id_low */
		lsrr.l #1, A;				/* move bits ID[17-0] to the right place */
		tfr A,B;					/* save bits ID[17-0] */
		bfclr #0xfffc,B1;			/* leave only ID[17-0] saved */
		
		lsrr.w #2,A;				/* move bits ID[28-18] to the right place (zero A0) */
		bfclr #0x3,A1;				/* zero position on ID[17-16] */
		or.l B,A;
		bfset #0x8000,A1;			/* mark extended ID (bit 31) */
		bra <rtrn;
		
	std_id:
		lsrr.l #21, A;
		
	rtrn:
		tfr A, ret;
	}
	
	return ret;
}	


#ifdef __cplusplus
}
#endif

