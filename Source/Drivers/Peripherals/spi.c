/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  spi.c
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.18.0$
*
* Description: Header file for the SCI driver.
*
*******************************************************************************/

#include "qs.h"
#include "spi.h"
#include "initconfig.h"

#ifdef __cplusplus
extern "C" {
#endif

/********************************************************************************

    spiInit() function performs the SPI module static configuration
    based on the configurable items from appconfig.h 

    It is the same for any higher software layer implementation used

********************************************************************************/

void spiInit(arch_sSPI *pSpiBase)
{
#pragma unused(pSpiBase)

#if SPI_0_INIT_USED && defined(SPI_0)
	if (pSpiBase == SPI_0)
	{
		#if defined(SPI_0_SPDSR_INIT) && !defined(SPI_0_SPDSCR_INIT)
		#define SPI_0_SPDSCR_INIT SPI_0_SPDSR_INIT
		#endif

		#ifdef SPI_0_SPDSCR_INIT
		periphMemWrite(SPI_0_SPDSCR_INIT, &pSpiBase->spdsr);
		#endif

		#ifdef SPI_0_SPSCR_INIT
		periphMemWrite(SPI_0_SPSCR_INIT, &pSpiBase->spscr);
		#endif
		
		#ifdef SPI_0_FIFO_INIT
		periphMemWrite(SPI_0_FIFO_INIT, &pSpiBase->fifo);
		#endif
  
		#ifdef SPI_0_DELAY_INIT
		periphMemWrite(SPI_0_DELAY_INIT, &pSpiBase->delay);
		#endif
	}
	else
#endif

#if SPI_1_INIT_USED && defined(SPI_1)
	if (pSpiBase == SPI_1)
	{
		#if defined(SPI_1_SPDSR_INIT) && !defined(SPI_1_SPDSCR_INIT)
		#define SPI_1_SPDSCR_INIT SPI_1_SPDSR_INIT
		#endif

		#ifdef SPI_1_SPDSCR_INIT
		periphMemWrite(SPI_1_SPDSCR_INIT, &pSpiBase->spdsr);
		#endif

		#ifdef SPI_1_SPSCR_INIT
		periphMemWrite(SPI_1_SPSCR_INIT, &pSpiBase->spscr);
		#endif

		#ifdef SPI_1_FIFO_INIT
		periphMemWrite(SPI_1_FIFO_INIT, &pSpiBase->fifo);
		#endif
  
		#ifdef SPI_1_DELAY_INIT
		periphMemWrite(SPI_1_DELAY_INIT, &pSpiBase->delay);
		#endif
	}
	else
#endif

#if SPI_INIT_USED && defined(SPI)

	#if SPI_0_INIT_USED
	/* please remove any SPI_0_xxx_INIT macros from your appconfig.h 
	 * SPI_0 is just an alias to the one and only "SPI" module */
	#warning SPI is same as SPI_0 but both are configured in appconfig.h
	#endif

	if (pSpiBase == SPI)
	{
		#if defined(SPI_SPDSR_INIT) && !defined(SPI_SPDSCR_INIT)
		#define SPI_SPDSCR_INIT SPI_SPDSR_INIT
		#endif

		#ifdef SPI_SPDSCR_INIT
		periphMemWrite(SPI_SPDSCR_INIT, &pSpiBase->spdsr);
		#endif

		#ifdef SPI_SPSCR_INIT
		periphMemWrite(SPI_SPSCR_INIT, &pSpiBase->spscr);
		#endif

		#ifdef SPI_FIFO_INIT
		periphMemWrite(SPI_FIFO_INIT, &pSpiBase->fifo);
		#endif
  
		#ifdef SPI_DELAY_INIT
		periphMemWrite(SPI_DELAY_INIT, &pSpiBase->delay);
		#endif
	}
	else
#endif

	; /* last else case */
}

