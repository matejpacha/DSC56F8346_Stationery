/*******************************************************************************
*
* Freescale Semiconductor Inc.
* (c) Copyright 2004-2007 Freescale Semiconductor, Inc.
* ALL RIGHTS RESERVED.
*
********************************************************************************
*
* File Name:  intctarget.h
*
* $Date:      Oct-12-2010$
*
* $Version:   2.3.7.0$
*
* Description: Header file for the MC56F834x/835x device specific implementation 
*              of the interrupt controller driver
*
*****************************************************************************/

#ifndef __INTCTARGET_H
#define __INTCTARGET_H

/* bitmask of system interrupts which can be set to levels 1,2,3 only */

#define INTC_IPL123_INTS 0x0ec0L /* interrupts 6,7,9,10,11 */

/* bit values for IPR registers */

#define INTC_IPR_INT6_INDEX  0
#define INTC_IPR_INT6_SHIFT  10
#define INTC_IPR_INT6_MASK   (3<<INTC_IPR_INT6_SHIFT)
#define INTC_IPR_INT6_IPLDIS 0
#define INTC_IPR_INT6_IPL1   (1<<INTC_IPR_INT6_SHIFT)
#define INTC_IPR_INT6_IPL2   (2<<INTC_IPR_INT6_SHIFT)
#define INTC_IPR_INT6_IPL3   (3<<INTC_IPR_INT6_SHIFT)

#define INTC_IPR_INT7_INDEX  0
#define INTC_IPR_INT7_SHIFT  12
#define INTC_IPR_INT7_MASK   (3<<INTC_IPR_INT7_SHIFT)
#define INTC_IPR_INT7_IPLDIS 0
#define INTC_IPR_INT7_IPL1   (1<<INTC_IPR_INT7_SHIFT)
#define INTC_IPR_INT7_IPL2   (2<<INTC_IPR_INT7_SHIFT)
#define INTC_IPR_INT7_IPL3   (3<<INTC_IPR_INT7_SHIFT)

#define INTC_IPR_INT9_INDEX  1
#define INTC_IPR_INT9_SHIFT  0
#define INTC_IPR_INT9_MASK   (3<<INTC_IPR_INT9_SHIFT)
#define INTC_IPR_INT9_IPLDIS 0
#define INTC_IPR_INT9_IPL1   (1<<INTC_IPR_INT9_SHIFT)
#define INTC_IPR_INT9_IPL2   (2<<INTC_IPR_INT9_SHIFT)
#define INTC_IPR_INT9_IPL3   (3<<INTC_IPR_INT9_SHIFT)

#define INTC_IPR_INT10_INDEX  1
#define INTC_IPR_INT10_SHIFT  2
#define INTC_IPR_INT10_MASK   (3<<INTC_IPR_INT10_SHIFT)
#define INTC_IPR_INT10_IPLDIS 0
#define INTC_IPR_INT10_IPL1   (1<<INTC_IPR_INT10_SHIFT)
#define INTC_IPR_INT10_IPL2   (2<<INTC_IPR_INT10_SHIFT)
#define INTC_IPR_INT10_IPL3   (3<<INTC_IPR_INT10_SHIFT)

#define INTC_IPR_INT11_INDEX  1
#define INTC_IPR_INT11_SHIFT  4
#define INTC_IPR_INT11_MASK   (3<<INTC_IPR_INT11_SHIFT)
#define INTC_IPR_INT11_IPLDIS 0
#define INTC_IPR_INT11_IPL1   (1<<INTC_IPR_INT11_SHIFT)
#define INTC_IPR_INT11_IPL2   (2<<INTC_IPR_INT11_SHIFT)
#define INTC_IPR_INT11_IPL3   (3<<INTC_IPR_INT11_SHIFT)

#define INTC_IPR_INT17_INDEX  2
#define INTC_IPR_INT17_SHIFT  0
#define INTC_IPR_INT17_MASK   (3<<INTC_IPR_INT17_SHIFT)
#define INTC_IPR_INT17_IPLDIS 0
#define INTC_IPR_INT17_IPL0   (1<<INTC_IPR_INT17_SHIFT)
#define INTC_IPR_INT17_IPL1   (2<<INTC_IPR_INT17_SHIFT)
#define INTC_IPR_INT17_IPL2   (3<<INTC_IPR_INT17_SHIFT)

#define INTC_IPR_INT18_INDEX  2
#define INTC_IPR_INT18_SHIFT  2
#define INTC_IPR_INT18_MASK   (3<<INTC_IPR_INT18_SHIFT)
#define INTC_IPR_INT18_IPLDIS 0
#define INTC_IPR_INT18_IPL0   (1<<INTC_IPR_INT18_SHIFT)
#define INTC_IPR_INT18_IPL1   (2<<INTC_IPR_INT18_SHIFT)
#define INTC_IPR_INT18_IPL2   (3<<INTC_IPR_INT18_SHIFT)

#define INTC_IPR_INT20_INDEX  2
#define INTC_IPR_INT20_SHIFT  6
#define INTC_IPR_INT20_MASK   (3<<INTC_IPR_INT20_SHIFT)
#define INTC_IPR_INT20_IPLDIS 0
#define INTC_IPR_INT20_IPL0   (1<<INTC_IPR_INT20_SHIFT)
#define INTC_IPR_INT20_IPL1   (2<<INTC_IPR_INT20_SHIFT)
#define INTC_IPR_INT20_IPL2   (3<<INTC_IPR_INT20_SHIFT)

#define INTC_IPR_INT21_INDEX  2
#define INTC_IPR_INT21_SHIFT  8
#define INTC_IPR_INT21_MASK   (3<<INTC_IPR_INT21_SHIFT)
#define INTC_IPR_INT21_IPLDIS 0
#define INTC_IPR_INT21_IPL0   (1<<INTC_IPR_INT21_SHIFT)
#define INTC_IPR_INT21_IPL1   (2<<INTC_IPR_INT21_SHIFT)
#define INTC_IPR_INT21_IPL2   (3<<INTC_IPR_INT21_SHIFT)

#define INTC_IPR_INT22_INDEX  2
#define INTC_IPR_INT22_SHIFT  10
#define INTC_IPR_INT22_MASK   (3<<INTC_IPR_INT22_SHIFT)
#define INTC_IPR_INT22_IPLDIS 0
#define INTC_IPR_INT22_IPL0   (1<<INTC_IPR_INT22_SHIFT)
#define INTC_IPR_INT22_IPL1   (2<<INTC_IPR_INT22_SHIFT)
#define INTC_IPR_INT22_IPL2   (3<<INTC_IPR_INT22_SHIFT)

#define INTC_IPR_INT23_INDEX  2
#define INTC_IPR_INT23_SHIFT  12
#define INTC_IPR_INT23_MASK   (3<<INTC_IPR_INT23_SHIFT)
#define INTC_IPR_INT23_IPLDIS 0
#define INTC_IPR_INT23_IPL0   (1<<INTC_IPR_INT23_SHIFT)
#define INTC_IPR_INT23_IPL1   (2<<INTC_IPR_INT23_SHIFT)
#define INTC_IPR_INT23_IPL2   (3<<INTC_IPR_INT23_SHIFT)

#define INTC_IPR_INT24_INDEX  2
#define INTC_IPR_INT24_SHIFT  14
#define INTC_IPR_INT24_MASK   (3<<INTC_IPR_INT24_SHIFT)
#define INTC_IPR_INT24_IPLDIS 0
#define INTC_IPR_INT24_IPL0   (1<<INTC_IPR_INT24_SHIFT)
#define INTC_IPR_INT24_IPL1   (2<<INTC_IPR_INT24_SHIFT)
#define INTC_IPR_INT24_IPL2   (3<<INTC_IPR_INT24_SHIFT)

#define INTC_IPR_INT26_INDEX  3
#define INTC_IPR_INT26_SHIFT  2
#define INTC_IPR_INT26_MASK   (3<<INTC_IPR_INT26_SHIFT)
#define INTC_IPR_INT26_IPLDIS 0
#define INTC_IPR_INT26_IPL0   (1<<INTC_IPR_INT26_SHIFT)
#define INTC_IPR_INT26_IPL1   (2<<INTC_IPR_INT26_SHIFT)
#define INTC_IPR_INT26_IPL2   (3<<INTC_IPR_INT26_SHIFT)

#define INTC_IPR_INT27_INDEX  3
#define INTC_IPR_INT27_SHIFT  4
#define INTC_IPR_INT27_MASK   (3<<INTC_IPR_INT27_SHIFT)
#define INTC_IPR_INT27_IPLDIS 0
#define INTC_IPR_INT27_IPL0   (1<<INTC_IPR_INT27_SHIFT)
#define INTC_IPR_INT27_IPL1   (2<<INTC_IPR_INT27_SHIFT)
#define INTC_IPR_INT27_IPL2   (3<<INTC_IPR_INT27_SHIFT)

#define INTC_IPR_INT28_INDEX  3
#define INTC_IPR_INT28_SHIFT  6
#define INTC_IPR_INT28_MASK   (3<<INTC_IPR_INT28_SHIFT)
#define INTC_IPR_INT28_IPLDIS 0
#define INTC_IPR_INT28_IPL0   (1<<INTC_IPR_INT28_SHIFT)
#define INTC_IPR_INT28_IPL1   (2<<INTC_IPR_INT28_SHIFT)
#define INTC_IPR_INT28_IPL2   (3<<INTC_IPR_INT28_SHIFT)

#define INTC_IPR_INT29_INDEX  3
#define INTC_IPR_INT29_SHIFT  8
#define INTC_IPR_INT29_MASK   (3<<INTC_IPR_INT29_SHIFT)
#define INTC_IPR_INT29_IPLDIS 0
#define INTC_IPR_INT29_IPL0   (1<<INTC_IPR_INT29_SHIFT)
#define INTC_IPR_INT29_IPL1   (2<<INTC_IPR_INT29_SHIFT)
#define INTC_IPR_INT29_IPL2   (3<<INTC_IPR_INT29_SHIFT)

#define INTC_IPR_INT30_INDEX  3
#define INTC_IPR_INT30_SHIFT  10
#define INTC_IPR_INT30_MASK   (3<<INTC_IPR_INT30_SHIFT)
#define INTC_IPR_INT30_IPLDIS 0
#define INTC_IPR_INT30_IPL0   (1<<INTC_IPR_INT30_SHIFT)
#define INTC_IPR_INT30_IPL1   (2<<INTC_IPR_INT30_SHIFT)
#define INTC_IPR_INT30_IPL2   (3<<INTC_IPR_INT30_SHIFT)

#define INTC_IPR_INT31_INDEX  3
#define INTC_IPR_INT31_SHIFT  12
#define INTC_IPR_INT31_MASK   (3<<INTC_IPR_INT31_SHIFT)
#define INTC_IPR_INT31_IPLDIS 0
#define INTC_IPR_INT31_IPL0   (1<<INTC_IPR_INT31_SHIFT)
#define INTC_IPR_INT31_IPL1   (2<<INTC_IPR_INT31_SHIFT)
#define INTC_IPR_INT31_IPL2   (3<<INTC_IPR_INT31_SHIFT)

#define INTC_IPR_INT32_INDEX  3
#define INTC_IPR_INT32_SHIFT  14
#define INTC_IPR_INT32_MASK   (3<<INTC_IPR_INT32_SHIFT)
#define INTC_IPR_INT32_IPLDIS 0
#define INTC_IPR_INT32_IPL0   (1<<INTC_IPR_INT32_SHIFT)
#define INTC_IPR_INT32_IPL1   (2<<INTC_IPR_INT32_SHIFT)
#define INTC_IPR_INT32_IPL2   (3<<INTC_IPR_INT32_SHIFT)

#define INTC_IPR_INT33_INDEX  4
#define INTC_IPR_INT33_SHIFT  0
#define INTC_IPR_INT33_MASK   (3<<INTC_IPR_INT33_SHIFT)
#define INTC_IPR_INT33_IPLDIS 0
#define INTC_IPR_INT33_IPL0   (1<<INTC_IPR_INT33_SHIFT)
#define INTC_IPR_INT33_IPL1   (2<<INTC_IPR_INT33_SHIFT)
#define INTC_IPR_INT33_IPL2   (3<<INTC_IPR_INT33_SHIFT)

#define INTC_IPR_INT34_INDEX  4
#define INTC_IPR_INT34_SHIFT  2
#define INTC_IPR_INT34_MASK   (3<<INTC_IPR_INT34_SHIFT)
#define INTC_IPR_INT34_IPLDIS 0
#define INTC_IPR_INT34_IPL0   (1<<INTC_IPR_INT34_SHIFT)
#define INTC_IPR_INT34_IPL1   (2<<INTC_IPR_INT34_SHIFT)
#define INTC_IPR_INT34_IPL2   (3<<INTC_IPR_INT34_SHIFT)

#define INTC_IPR_INT35_INDEX  4
#define INTC_IPR_INT35_SHIFT  4
#define INTC_IPR_INT35_MASK   (3<<INTC_IPR_INT35_SHIFT)
#define INTC_IPR_INT35_IPLDIS 0
#define INTC_IPR_INT35_IPL0   (1<<INTC_IPR_INT35_SHIFT)
#define INTC_IPR_INT35_IPL1   (2<<INTC_IPR_INT35_SHIFT)
#define INTC_IPR_INT35_IPL2   (3<<INTC_IPR_INT35_SHIFT)

#define INTC_IPR_INT38_INDEX  4
#define INTC_IPR_INT38_SHIFT  10
#define INTC_IPR_INT38_MASK   (3<<INTC_IPR_INT38_SHIFT)
#define INTC_IPR_INT38_IPLDIS 0
#define INTC_IPR_INT38_IPL0   (1<<INTC_IPR_INT38_SHIFT)
#define INTC_IPR_INT38_IPL1   (2<<INTC_IPR_INT38_SHIFT)
#define INTC_IPR_INT38_IPL2   (3<<INTC_IPR_INT38_SHIFT)

#define INTC_IPR_INT39_INDEX  4
#define INTC_IPR_INT39_SHIFT  12
#define INTC_IPR_INT39_MASK   (3<<INTC_IPR_INT39_SHIFT)
#define INTC_IPR_INT39_IPLDIS 0
#define INTC_IPR_INT39_IPL0   (1<<INTC_IPR_INT39_SHIFT)
#define INTC_IPR_INT39_IPL1   (2<<INTC_IPR_INT39_SHIFT)
#define INTC_IPR_INT39_IPL2   (3<<INTC_IPR_INT39_SHIFT)

#define INTC_IPR_INT40_INDEX  4
#define INTC_IPR_INT40_SHIFT  14
#define INTC_IPR_INT40_MASK   (3<<INTC_IPR_INT40_SHIFT)
#define INTC_IPR_INT40_IPLDIS 0
#define INTC_IPR_INT40_IPL0   (1<<INTC_IPR_INT40_SHIFT)
#define INTC_IPR_INT40_IPL1   (2<<INTC_IPR_INT40_SHIFT)
#define INTC_IPR_INT40_IPL2   (3<<INTC_IPR_INT40_SHIFT)

#define INTC_IPR_INT41_INDEX  5
#define INTC_IPR_INT41_SHIFT  0
#define INTC_IPR_INT41_MASK   (3<<INTC_IPR_INT41_SHIFT)
#define INTC_IPR_INT41_IPLDIS 0
#define INTC_IPR_INT41_IPL0   (1<<INTC_IPR_INT41_SHIFT)
#define INTC_IPR_INT41_IPL1   (2<<INTC_IPR_INT41_SHIFT)
#define INTC_IPR_INT41_IPL2   (3<<INTC_IPR_INT41_SHIFT)

#define INTC_IPR_INT42_INDEX  5
#define INTC_IPR_INT42_SHIFT  2
#define INTC_IPR_INT42_MASK   (3<<INTC_IPR_INT42_SHIFT)
#define INTC_IPR_INT42_IPLDIS 0
#define INTC_IPR_INT42_IPL0   (1<<INTC_IPR_INT42_SHIFT)
#define INTC_IPR_INT42_IPL1   (2<<INTC_IPR_INT42_SHIFT)
#define INTC_IPR_INT42_IPL2   (3<<INTC_IPR_INT42_SHIFT)

#define INTC_IPR_INT43_INDEX  5
#define INTC_IPR_INT43_SHIFT  4
#define INTC_IPR_INT43_MASK   (3<<INTC_IPR_INT43_SHIFT)
#define INTC_IPR_INT43_IPLDIS 0
#define INTC_IPR_INT43_IPL0   (1<<INTC_IPR_INT43_SHIFT)
#define INTC_IPR_INT43_IPL1   (2<<INTC_IPR_INT43_SHIFT)
#define INTC_IPR_INT43_IPL2   (3<<INTC_IPR_INT43_SHIFT)

#define INTC_IPR_INT45_INDEX  5
#define INTC_IPR_INT45_SHIFT  8
#define INTC_IPR_INT45_MASK   (3<<INTC_IPR_INT45_SHIFT)
#define INTC_IPR_INT45_IPLDIS 0
#define INTC_IPR_INT45_IPL0   (1<<INTC_IPR_INT45_SHIFT)
#define INTC_IPR_INT45_IPL1   (2<<INTC_IPR_INT45_SHIFT)
#define INTC_IPR_INT45_IPL2   (3<<INTC_IPR_INT45_SHIFT)

#define INTC_IPR_INT46_INDEX  5
#define INTC_IPR_INT46_SHIFT  10
#define INTC_IPR_INT46_MASK   (3<<INTC_IPR_INT46_SHIFT)
#define INTC_IPR_INT46_IPLDIS 0
#define INTC_IPR_INT46_IPL0   (1<<INTC_IPR_INT46_SHIFT)
#define INTC_IPR_INT46_IPL1   (2<<INTC_IPR_INT46_SHIFT)
#define INTC_IPR_INT46_IPL2   (3<<INTC_IPR_INT46_SHIFT)

#define INTC_IPR_INT47_INDEX  5
#define INTC_IPR_INT47_SHIFT  12
#define INTC_IPR_INT47_MASK   (3<<INTC_IPR_INT47_SHIFT)
#define INTC_IPR_INT47_IPLDIS 0
#define INTC_IPR_INT47_IPL0   (1<<INTC_IPR_INT47_SHIFT)
#define INTC_IPR_INT47_IPL1   (2<<INTC_IPR_INT47_SHIFT)
#define INTC_IPR_INT47_IPL2   (3<<INTC_IPR_INT47_SHIFT)

#define INTC_IPR_INT48_INDEX  5
#define INTC_IPR_INT48_SHIFT  14
#define INTC_IPR_INT48_MASK   (3<<INTC_IPR_INT48_SHIFT)
#define INTC_IPR_INT48_IPLDIS 0
#define INTC_IPR_INT48_IPL0   (1<<INTC_IPR_INT48_SHIFT)
#define INTC_IPR_INT48_IPL1   (2<<INTC_IPR_INT48_SHIFT)
#define INTC_IPR_INT48_IPL2   (3<<INTC_IPR_INT48_SHIFT)

#define INTC_IPR_INT49_INDEX  6
#define INTC_IPR_INT49_SHIFT  0
#define INTC_IPR_INT49_MASK   (3<<INTC_IPR_INT49_SHIFT)
#define INTC_IPR_INT49_IPLDIS 0
#define INTC_IPR_INT49_IPL0   (1<<INTC_IPR_INT49_SHIFT)
#define INTC_IPR_INT49_IPL1   (2<<INTC_IPR_INT49_SHIFT)
#define INTC_IPR_INT49_IPL2   (3<<INTC_IPR_INT49_SHIFT)

#define INTC_IPR_INT50_INDEX  6
#define INTC_IPR_INT50_SHIFT  2
#define INTC_IPR_INT50_MASK   (3<<INTC_IPR_INT50_SHIFT)
#define INTC_IPR_INT50_IPLDIS 0
#define INTC_IPR_INT50_IPL0   (1<<INTC_IPR_INT50_SHIFT)
#define INTC_IPR_INT50_IPL1   (2<<INTC_IPR_INT50_SHIFT)
#define INTC_IPR_INT50_IPL2   (3<<INTC_IPR_INT50_SHIFT)

#define INTC_IPR_INT52_INDEX  6
#define INTC_IPR_INT52_SHIFT  6
#define INTC_IPR_INT52_MASK   (3<<INTC_IPR_INT52_SHIFT)
#define INTC_IPR_INT52_IPLDIS 0
#define INTC_IPR_INT52_IPL0   (1<<INTC_IPR_INT52_SHIFT)
#define INTC_IPR_INT52_IPL1   (2<<INTC_IPR_INT52_SHIFT)
#define INTC_IPR_INT52_IPL2   (3<<INTC_IPR_INT52_SHIFT)

#define INTC_IPR_INT53_INDEX  6
#define INTC_IPR_INT53_SHIFT  8
#define INTC_IPR_INT53_MASK   (3<<INTC_IPR_INT53_SHIFT)
#define INTC_IPR_INT53_IPLDIS 0
#define INTC_IPR_INT53_IPL0   (1<<INTC_IPR_INT53_SHIFT)
#define INTC_IPR_INT53_IPL1   (2<<INTC_IPR_INT53_SHIFT)
#define INTC_IPR_INT53_IPL2   (3<<INTC_IPR_INT53_SHIFT)

#define INTC_IPR_INT54_INDEX  6
#define INTC_IPR_INT54_SHIFT  10
#define INTC_IPR_INT54_MASK   (3<<INTC_IPR_INT54_SHIFT)
#define INTC_IPR_INT54_IPLDIS 0
#define INTC_IPR_INT54_IPL0   (1<<INTC_IPR_INT54_SHIFT)
#define INTC_IPR_INT54_IPL1   (2<<INTC_IPR_INT54_SHIFT)
#define INTC_IPR_INT54_IPL2   (3<<INTC_IPR_INT54_SHIFT)

#define INTC_IPR_INT55_INDEX  6
#define INTC_IPR_INT55_SHIFT  12
#define INTC_IPR_INT55_MASK   (3<<INTC_IPR_INT55_SHIFT)
#define INTC_IPR_INT55_IPLDIS 0
#define INTC_IPR_INT55_IPL0   (1<<INTC_IPR_INT55_SHIFT)
#define INTC_IPR_INT55_IPL1   (2<<INTC_IPR_INT55_SHIFT)
#define INTC_IPR_INT55_IPL2   (3<<INTC_IPR_INT55_SHIFT)

#define INTC_IPR_INT56_INDEX  6
#define INTC_IPR_INT56_SHIFT  14
#define INTC_IPR_INT56_MASK   (3<<INTC_IPR_INT56_SHIFT)
#define INTC_IPR_INT56_IPLDIS 0
#define INTC_IPR_INT56_IPL0   (1<<INTC_IPR_INT56_SHIFT)
#define INTC_IPR_INT56_IPL1   (2<<INTC_IPR_INT56_SHIFT)
#define INTC_IPR_INT56_IPL2   (3<<INTC_IPR_INT56_SHIFT)

#define INTC_IPR_INT57_INDEX  7
#define INTC_IPR_INT57_SHIFT  0
#define INTC_IPR_INT57_MASK   (3<<INTC_IPR_INT57_SHIFT)
#define INTC_IPR_INT57_IPLDIS 0
#define INTC_IPR_INT57_IPL0   (1<<INTC_IPR_INT57_SHIFT)
#define INTC_IPR_INT57_IPL1   (2<<INTC_IPR_INT57_SHIFT)
#define INTC_IPR_INT57_IPL2   (3<<INTC_IPR_INT57_SHIFT)

#define INTC_IPR_INT58_INDEX  7
#define INTC_IPR_INT58_SHIFT  2
#define INTC_IPR_INT58_MASK   (3<<INTC_IPR_INT58_SHIFT)
#define INTC_IPR_INT58_IPLDIS 0
#define INTC_IPR_INT58_IPL0   (1<<INTC_IPR_INT58_SHIFT)
#define INTC_IPR_INT58_IPL1   (2<<INTC_IPR_INT58_SHIFT)
#define INTC_IPR_INT58_IPL2   (3<<INTC_IPR_INT58_SHIFT)

#define INTC_IPR_INT59_INDEX  7
#define INTC_IPR_INT59_SHIFT  4
#define INTC_IPR_INT59_MASK   (3<<INTC_IPR_INT59_SHIFT)
#define INTC_IPR_INT59_IPLDIS 0
#define INTC_IPR_INT59_IPL0   (1<<INTC_IPR_INT59_SHIFT)
#define INTC_IPR_INT59_IPL1   (2<<INTC_IPR_INT59_SHIFT)
#define INTC_IPR_INT59_IPL2   (3<<INTC_IPR_INT59_SHIFT)

#define INTC_IPR_INT60_INDEX  7
#define INTC_IPR_INT60_SHIFT  6
#define INTC_IPR_INT60_MASK   (3<<INTC_IPR_INT60_SHIFT)
#define INTC_IPR_INT60_IPLDIS 0
#define INTC_IPR_INT60_IPL0   (1<<INTC_IPR_INT60_SHIFT)
#define INTC_IPR_INT60_IPL1   (2<<INTC_IPR_INT60_SHIFT)
#define INTC_IPR_INT60_IPL2   (3<<INTC_IPR_INT60_SHIFT)

#define INTC_IPR_INT61_INDEX  7
#define INTC_IPR_INT61_SHIFT  8
#define INTC_IPR_INT61_MASK   (3<<INTC_IPR_INT61_SHIFT)
#define INTC_IPR_INT61_IPLDIS 0
#define INTC_IPR_INT61_IPL0   (1<<INTC_IPR_INT61_SHIFT)
#define INTC_IPR_INT61_IPL1   (2<<INTC_IPR_INT61_SHIFT)
#define INTC_IPR_INT61_IPL2   (3<<INTC_IPR_INT61_SHIFT)

#define INTC_IPR_INT62_INDEX  7
#define INTC_IPR_INT62_SHIFT  10
#define INTC_IPR_INT62_MASK   (3<<INTC_IPR_INT62_SHIFT)
#define INTC_IPR_INT62_IPLDIS 0
#define INTC_IPR_INT62_IPL0   (1<<INTC_IPR_INT62_SHIFT)
#define INTC_IPR_INT62_IPL1   (2<<INTC_IPR_INT62_SHIFT)
#define INTC_IPR_INT62_IPL2   (3<<INTC_IPR_INT62_SHIFT)

#define INTC_IPR_INT63_INDEX  7
#define INTC_IPR_INT63_SHIFT  12
#define INTC_IPR_INT63_MASK   (3<<INTC_IPR_INT63_SHIFT)
#define INTC_IPR_INT63_IPLDIS 0
#define INTC_IPR_INT63_IPL0   (1<<INTC_IPR_INT63_SHIFT)
#define INTC_IPR_INT63_IPL1   (2<<INTC_IPR_INT63_SHIFT)
#define INTC_IPR_INT63_IPL2   (3<<INTC_IPR_INT63_SHIFT)

#define INTC_IPR_INT64_INDEX  7
#define INTC_IPR_INT64_SHIFT  14
#define INTC_IPR_INT64_MASK   (3<<INTC_IPR_INT64_SHIFT)
#define INTC_IPR_INT64_IPLDIS 0
#define INTC_IPR_INT64_IPL0   (1<<INTC_IPR_INT64_SHIFT)
#define INTC_IPR_INT64_IPL1   (2<<INTC_IPR_INT64_SHIFT)
#define INTC_IPR_INT64_IPL2   (3<<INTC_IPR_INT64_SHIFT)

#define INTC_IPR_INT65_INDEX  8
#define INTC_IPR_INT65_SHIFT  0
#define INTC_IPR_INT65_MASK   (3<<INTC_IPR_INT65_SHIFT)
#define INTC_IPR_INT65_IPLDIS 0
#define INTC_IPR_INT65_IPL0   (1<<INTC_IPR_INT65_SHIFT)
#define INTC_IPR_INT65_IPL1   (2<<INTC_IPR_INT65_SHIFT)
#define INTC_IPR_INT65_IPL2   (3<<INTC_IPR_INT65_SHIFT)

#define INTC_IPR_INT66_INDEX  8
#define INTC_IPR_INT66_SHIFT  2
#define INTC_IPR_INT66_MASK   (3<<INTC_IPR_INT66_SHIFT)
#define INTC_IPR_INT66_IPLDIS 0
#define INTC_IPR_INT66_IPL0   (1<<INTC_IPR_INT66_SHIFT)
#define INTC_IPR_INT66_IPL1   (2<<INTC_IPR_INT66_SHIFT)
#define INTC_IPR_INT66_IPL2   (3<<INTC_IPR_INT66_SHIFT)

#define INTC_IPR_INT67_INDEX  8
#define INTC_IPR_INT67_SHIFT  4
#define INTC_IPR_INT67_MASK   (3<<INTC_IPR_INT67_SHIFT)
#define INTC_IPR_INT67_IPLDIS 0
#define INTC_IPR_INT67_IPL0   (1<<INTC_IPR_INT67_SHIFT)
#define INTC_IPR_INT67_IPL1   (2<<INTC_IPR_INT67_SHIFT)
#define INTC_IPR_INT67_IPL2   (3<<INTC_IPR_INT67_SHIFT)

#define INTC_IPR_INT68_INDEX  8
#define INTC_IPR_INT68_SHIFT  6
#define INTC_IPR_INT68_MASK   (3<<INTC_IPR_INT68_SHIFT)
#define INTC_IPR_INT68_IPLDIS 0
#define INTC_IPR_INT68_IPL0   (1<<INTC_IPR_INT68_SHIFT)
#define INTC_IPR_INT68_IPL1   (2<<INTC_IPR_INT68_SHIFT)
#define INTC_IPR_INT68_IPL2   (3<<INTC_IPR_INT68_SHIFT)

#define INTC_IPR_INT69_INDEX  8
#define INTC_IPR_INT69_SHIFT  8
#define INTC_IPR_INT69_MASK   (3<<INTC_IPR_INT69_SHIFT)
#define INTC_IPR_INT69_IPLDIS 0
#define INTC_IPR_INT69_IPL0   (1<<INTC_IPR_INT69_SHIFT)
#define INTC_IPR_INT69_IPL1   (2<<INTC_IPR_INT69_SHIFT)
#define INTC_IPR_INT69_IPL2   (3<<INTC_IPR_INT69_SHIFT)

#define INTC_IPR_INT71_INDEX  8
#define INTC_IPR_INT71_SHIFT  12
#define INTC_IPR_INT71_MASK   (3<<INTC_IPR_INT71_SHIFT)
#define INTC_IPR_INT71_IPLDIS 0
#define INTC_IPR_INT71_IPL0   (1<<INTC_IPR_INT71_SHIFT)
#define INTC_IPR_INT71_IPL1   (2<<INTC_IPR_INT71_SHIFT)
#define INTC_IPR_INT71_IPL2   (3<<INTC_IPR_INT71_SHIFT)

#define INTC_IPR_INT72_INDEX  8
#define INTC_IPR_INT72_SHIFT  14
#define INTC_IPR_INT72_MASK   (3<<INTC_IPR_INT72_SHIFT)
#define INTC_IPR_INT72_IPLDIS 0
#define INTC_IPR_INT72_IPL0   (1<<INTC_IPR_INT72_SHIFT)
#define INTC_IPR_INT72_IPL1   (2<<INTC_IPR_INT72_SHIFT)
#define INTC_IPR_INT72_IPL2   (3<<INTC_IPR_INT72_SHIFT)

#define INTC_IPR_INT73_INDEX  9
#define INTC_IPR_INT73_SHIFT  0
#define INTC_IPR_INT73_MASK   (3<<INTC_IPR_INT73_SHIFT)
#define INTC_IPR_INT73_IPLDIS 0
#define INTC_IPR_INT73_IPL0   (1<<INTC_IPR_INT73_SHIFT)
#define INTC_IPR_INT73_IPL1   (2<<INTC_IPR_INT73_SHIFT)
#define INTC_IPR_INT73_IPL2   (3<<INTC_IPR_INT73_SHIFT)

#define INTC_IPR_INT74_INDEX  9
#define INTC_IPR_INT74_SHIFT  2
#define INTC_IPR_INT74_MASK   (3<<INTC_IPR_INT74_SHIFT)
#define INTC_IPR_INT74_IPLDIS 0
#define INTC_IPR_INT74_IPL0   (1<<INTC_IPR_INT74_SHIFT)
#define INTC_IPR_INT74_IPL1   (2<<INTC_IPR_INT74_SHIFT)
#define INTC_IPR_INT74_IPL2   (3<<INTC_IPR_INT74_SHIFT)

#define INTC_IPR_INT75_INDEX  9
#define INTC_IPR_INT75_SHIFT  4
#define INTC_IPR_INT75_MASK   (3<<INTC_IPR_INT75_SHIFT)
#define INTC_IPR_INT75_IPLDIS 0
#define INTC_IPR_INT75_IPL0   (1<<INTC_IPR_INT75_SHIFT)
#define INTC_IPR_INT75_IPL1   (2<<INTC_IPR_INT75_SHIFT)
#define INTC_IPR_INT75_IPL2   (3<<INTC_IPR_INT75_SHIFT)

#define INTC_IPR_INT76_INDEX  9
#define INTC_IPR_INT76_SHIFT  6
#define INTC_IPR_INT76_MASK   (3<<INTC_IPR_INT76_SHIFT)
#define INTC_IPR_INT76_IPLDIS 0
#define INTC_IPR_INT76_IPL0   (1<<INTC_IPR_INT76_SHIFT)
#define INTC_IPR_INT76_IPL1   (2<<INTC_IPR_INT76_SHIFT)
#define INTC_IPR_INT76_IPL2   (3<<INTC_IPR_INT76_SHIFT)

#define INTC_IPR_INT77_INDEX  9
#define INTC_IPR_INT77_SHIFT  8
#define INTC_IPR_INT77_MASK   (3<<INTC_IPR_INT77_SHIFT)
#define INTC_IPR_INT77_IPLDIS 0
#define INTC_IPR_INT77_IPL0   (1<<INTC_IPR_INT77_SHIFT)
#define INTC_IPR_INT77_IPL1   (2<<INTC_IPR_INT77_SHIFT)
#define INTC_IPR_INT77_IPL2   (3<<INTC_IPR_INT77_SHIFT)

#define INTC_IPR_INT78_INDEX  9
#define INTC_IPR_INT78_SHIFT  10
#define INTC_IPR_INT78_MASK   (3<<INTC_IPR_INT78_SHIFT)
#define INTC_IPR_INT78_IPLDIS 0
#define INTC_IPR_INT78_IPL0   (1<<INTC_IPR_INT78_SHIFT)
#define INTC_IPR_INT78_IPL1   (2<<INTC_IPR_INT78_SHIFT)
#define INTC_IPR_INT78_IPL2   (3<<INTC_IPR_INT78_SHIFT)

#define INTC_IPR_INT79_INDEX  9
#define INTC_IPR_INT79_SHIFT  12
#define INTC_IPR_INT79_MASK   (3<<INTC_IPR_INT79_SHIFT)
#define INTC_IPR_INT79_IPLDIS 0
#define INTC_IPR_INT79_IPL0   (1<<INTC_IPR_INT79_SHIFT)
#define INTC_IPR_INT79_IPL1   (2<<INTC_IPR_INT79_SHIFT)
#define INTC_IPR_INT79_IPL2   (3<<INTC_IPR_INT79_SHIFT)

#define INTC_IPR_INT80_INDEX  9
#define INTC_IPR_INT80_SHIFT  14
#define INTC_IPR_INT80_MASK   (3<<INTC_IPR_INT80_SHIFT)
#define INTC_IPR_INT80_IPLDIS 0
#define INTC_IPR_INT80_IPL0   (1<<INTC_IPR_INT80_SHIFT)
#define INTC_IPR_INT80_IPL1   (2<<INTC_IPR_INT80_SHIFT)
#define INTC_IPR_INT80_IPL2   (3<<INTC_IPR_INT80_SHIFT)



/*******************************************************************************
	ioctl commands to set or get the interrupt IPL
*******************************************************************************/

#define INTC_SET_IPL_6
#define INTC_SET_IPL_6_RAW
#define INTC_GET_IPL_6_RAW
#define ioctlINTC_SET_IPL_6(pIntcBase, param)     INTC_SET_IPL123_n(6, pIntcBase, param)
#define ioctlINTC_SET_IPL_6_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(6, pIntcBase, param)
#define ioctlINTC_GET_IPL_6_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(6, pIntcBase)

#define INTC_SET_IPL_7
#define INTC_SET_IPL_7_RAW
#define INTC_GET_IPL_7_RAW
#define ioctlINTC_SET_IPL_7(pIntcBase, param)     INTC_SET_IPL123_n(7, pIntcBase, param)
#define ioctlINTC_SET_IPL_7_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(7, pIntcBase, param)
#define ioctlINTC_GET_IPL_7_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(7, pIntcBase)

#define INTC_SET_IPL_9
#define INTC_SET_IPL_9_RAW
#define INTC_GET_IPL_9_RAW
#define ioctlINTC_SET_IPL_9(pIntcBase, param)     INTC_SET_IPL123_n(9, pIntcBase, param)
#define ioctlINTC_SET_IPL_9_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(9, pIntcBase, param)
#define ioctlINTC_GET_IPL_9_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(9, pIntcBase)

#define INTC_SET_IPL_10
#define INTC_SET_IPL_10_RAW
#define INTC_GET_IPL_10_RAW
#define ioctlINTC_SET_IPL_10(pIntcBase, param)     INTC_SET_IPL123_n(10, pIntcBase, param)
#define ioctlINTC_SET_IPL_10_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(10, pIntcBase, param)
#define ioctlINTC_GET_IPL_10_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(10, pIntcBase)

#define INTC_SET_IPL_11
#define INTC_SET_IPL_11_RAW
#define INTC_GET_IPL_11_RAW
#define ioctlINTC_SET_IPL_11(pIntcBase, param)     INTC_SET_IPL123_n(11, pIntcBase, param)
#define ioctlINTC_SET_IPL_11_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(11, pIntcBase, param)
#define ioctlINTC_GET_IPL_11_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(11, pIntcBase)

#define INTC_SET_IPL_17
#define INTC_SET_IPL_17_RAW
#define INTC_GET_IPL_17_RAW
#define ioctlINTC_SET_IPL_17(pIntcBase, param)     INTC_SET_IPL012_n(17, pIntcBase, param)
#define ioctlINTC_SET_IPL_17_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(17, pIntcBase, param)
#define ioctlINTC_GET_IPL_17_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(17, pIntcBase)

#define INTC_SET_IPL_18
#define INTC_SET_IPL_18_RAW
#define INTC_GET_IPL_18_RAW
#define ioctlINTC_SET_IPL_18(pIntcBase, param)     INTC_SET_IPL012_n(18, pIntcBase, param)
#define ioctlINTC_SET_IPL_18_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(18, pIntcBase, param)
#define ioctlINTC_GET_IPL_18_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(18, pIntcBase)

#define INTC_SET_IPL_20
#define INTC_SET_IPL_20_RAW
#define INTC_GET_IPL_20_RAW
#define ioctlINTC_SET_IPL_20(pIntcBase, param)     INTC_SET_IPL012_n(20, pIntcBase, param)
#define ioctlINTC_SET_IPL_20_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(20, pIntcBase, param)
#define ioctlINTC_GET_IPL_20_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(20, pIntcBase)

#define INTC_SET_IPL_21
#define INTC_SET_IPL_21_RAW
#define INTC_GET_IPL_21_RAW
#define ioctlINTC_SET_IPL_21(pIntcBase, param)     INTC_SET_IPL012_n(21, pIntcBase, param)
#define ioctlINTC_SET_IPL_21_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(21, pIntcBase, param)
#define ioctlINTC_GET_IPL_21_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(21, pIntcBase)

#define INTC_SET_IPL_22
#define INTC_SET_IPL_22_RAW
#define INTC_GET_IPL_22_RAW
#define ioctlINTC_SET_IPL_22(pIntcBase, param)     INTC_SET_IPL012_n(22, pIntcBase, param)
#define ioctlINTC_SET_IPL_22_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(22, pIntcBase, param)
#define ioctlINTC_GET_IPL_22_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(22, pIntcBase)

#define INTC_SET_IPL_23
#define INTC_SET_IPL_23_RAW
#define INTC_GET_IPL_23_RAW
#define ioctlINTC_SET_IPL_23(pIntcBase, param)     INTC_SET_IPL012_n(23, pIntcBase, param)
#define ioctlINTC_SET_IPL_23_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(23, pIntcBase, param)
#define ioctlINTC_GET_IPL_23_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(23, pIntcBase)

#define INTC_SET_IPL_24
#define INTC_SET_IPL_24_RAW
#define INTC_GET_IPL_24_RAW
#define ioctlINTC_SET_IPL_24(pIntcBase, param)     INTC_SET_IPL012_n(24, pIntcBase, param)
#define ioctlINTC_SET_IPL_24_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(24, pIntcBase, param)
#define ioctlINTC_GET_IPL_24_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(24, pIntcBase)

#define INTC_SET_IPL_26
#define INTC_SET_IPL_26_RAW
#define INTC_GET_IPL_26_RAW
#define ioctlINTC_SET_IPL_26(pIntcBase, param)     INTC_SET_IPL012_n(26, pIntcBase, param)
#define ioctlINTC_SET_IPL_26_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(26, pIntcBase, param)
#define ioctlINTC_GET_IPL_26_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(26, pIntcBase)

#define INTC_SET_IPL_27
#define INTC_SET_IPL_27_RAW
#define INTC_GET_IPL_27_RAW
#define ioctlINTC_SET_IPL_27(pIntcBase, param)     INTC_SET_IPL012_n(27, pIntcBase, param)
#define ioctlINTC_SET_IPL_27_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(27, pIntcBase, param)
#define ioctlINTC_GET_IPL_27_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(27, pIntcBase)

#define INTC_SET_IPL_28
#define INTC_SET_IPL_28_RAW
#define INTC_GET_IPL_28_RAW
#define ioctlINTC_SET_IPL_28(pIntcBase, param)     INTC_SET_IPL012_n(28, pIntcBase, param)
#define ioctlINTC_SET_IPL_28_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(28, pIntcBase, param)
#define ioctlINTC_GET_IPL_28_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(28, pIntcBase)

#define INTC_SET_IPL_29
#define INTC_SET_IPL_29_RAW
#define INTC_GET_IPL_29_RAW
#define ioctlINTC_SET_IPL_29(pIntcBase, param)     INTC_SET_IPL012_n(29, pIntcBase, param)
#define ioctlINTC_SET_IPL_29_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(29, pIntcBase, param)
#define ioctlINTC_GET_IPL_29_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(29, pIntcBase)

#define INTC_SET_IPL_30
#define INTC_SET_IPL_30_RAW
#define INTC_GET_IPL_30_RAW
#define ioctlINTC_SET_IPL_30(pIntcBase, param)     INTC_SET_IPL012_n(30, pIntcBase, param)
#define ioctlINTC_SET_IPL_30_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(30, pIntcBase, param)
#define ioctlINTC_GET_IPL_30_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(30, pIntcBase)

#define INTC_SET_IPL_31
#define INTC_SET_IPL_31_RAW
#define INTC_GET_IPL_31_RAW
#define ioctlINTC_SET_IPL_31(pIntcBase, param)     INTC_SET_IPL012_n(31, pIntcBase, param)
#define ioctlINTC_SET_IPL_31_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(31, pIntcBase, param)
#define ioctlINTC_GET_IPL_31_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(31, pIntcBase)

#define INTC_SET_IPL_32
#define INTC_SET_IPL_32_RAW
#define INTC_GET_IPL_32_RAW
#define ioctlINTC_SET_IPL_32(pIntcBase, param)     INTC_SET_IPL012_n(32, pIntcBase, param)
#define ioctlINTC_SET_IPL_32_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(32, pIntcBase, param)
#define ioctlINTC_GET_IPL_32_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(32, pIntcBase)

#define INTC_SET_IPL_33
#define INTC_SET_IPL_33_RAW
#define INTC_GET_IPL_33_RAW
#define ioctlINTC_SET_IPL_33(pIntcBase, param)     INTC_SET_IPL012_n(33, pIntcBase, param)
#define ioctlINTC_SET_IPL_33_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(33, pIntcBase, param)
#define ioctlINTC_GET_IPL_33_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(33, pIntcBase)

#define INTC_SET_IPL_34
#define INTC_SET_IPL_34_RAW
#define INTC_GET_IPL_34_RAW
#define ioctlINTC_SET_IPL_34(pIntcBase, param)     INTC_SET_IPL012_n(34, pIntcBase, param)
#define ioctlINTC_SET_IPL_34_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(34, pIntcBase, param)
#define ioctlINTC_GET_IPL_34_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(34, pIntcBase)

#define INTC_SET_IPL_35
#define INTC_SET_IPL_35_RAW
#define INTC_GET_IPL_35_RAW
#define ioctlINTC_SET_IPL_35(pIntcBase, param)     INTC_SET_IPL012_n(35, pIntcBase, param)
#define ioctlINTC_SET_IPL_35_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(35, pIntcBase, param)
#define ioctlINTC_GET_IPL_35_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(35, pIntcBase)

#define INTC_SET_IPL_38
#define INTC_SET_IPL_38_RAW
#define INTC_GET_IPL_38_RAW
#define ioctlINTC_SET_IPL_38(pIntcBase, param)     INTC_SET_IPL012_n(38, pIntcBase, param)
#define ioctlINTC_SET_IPL_38_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(38, pIntcBase, param)
#define ioctlINTC_GET_IPL_38_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(38, pIntcBase)

#define INTC_SET_IPL_39
#define INTC_SET_IPL_39_RAW
#define INTC_GET_IPL_39_RAW
#define ioctlINTC_SET_IPL_39(pIntcBase, param)     INTC_SET_IPL012_n(39, pIntcBase, param)
#define ioctlINTC_SET_IPL_39_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(39, pIntcBase, param)
#define ioctlINTC_GET_IPL_39_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(39, pIntcBase)

#define INTC_SET_IPL_40
#define INTC_SET_IPL_40_RAW
#define INTC_GET_IPL_40_RAW
#define ioctlINTC_SET_IPL_40(pIntcBase, param)     INTC_SET_IPL012_n(40, pIntcBase, param)
#define ioctlINTC_SET_IPL_40_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(40, pIntcBase, param)
#define ioctlINTC_GET_IPL_40_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(40, pIntcBase)

#define INTC_SET_IPL_41
#define INTC_SET_IPL_41_RAW
#define INTC_GET_IPL_41_RAW
#define ioctlINTC_SET_IPL_41(pIntcBase, param)     INTC_SET_IPL012_n(41, pIntcBase, param)
#define ioctlINTC_SET_IPL_41_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(41, pIntcBase, param)
#define ioctlINTC_GET_IPL_41_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(41, pIntcBase)

#define INTC_SET_IPL_42
#define INTC_SET_IPL_42_RAW
#define INTC_GET_IPL_42_RAW
#define ioctlINTC_SET_IPL_42(pIntcBase, param)     INTC_SET_IPL012_n(42, pIntcBase, param)
#define ioctlINTC_SET_IPL_42_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(42, pIntcBase, param)
#define ioctlINTC_GET_IPL_42_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(42, pIntcBase)

#define INTC_SET_IPL_43
#define INTC_SET_IPL_43_RAW
#define INTC_GET_IPL_43_RAW
#define ioctlINTC_SET_IPL_43(pIntcBase, param)     INTC_SET_IPL012_n(43, pIntcBase, param)
#define ioctlINTC_SET_IPL_43_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(43, pIntcBase, param)
#define ioctlINTC_GET_IPL_43_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(43, pIntcBase)

#define INTC_SET_IPL_45
#define INTC_SET_IPL_45_RAW
#define INTC_GET_IPL_45_RAW
#define ioctlINTC_SET_IPL_45(pIntcBase, param)     INTC_SET_IPL012_n(45, pIntcBase, param)
#define ioctlINTC_SET_IPL_45_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(45, pIntcBase, param)
#define ioctlINTC_GET_IPL_45_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(45, pIntcBase)

#define INTC_SET_IPL_46
#define INTC_SET_IPL_46_RAW
#define INTC_GET_IPL_46_RAW
#define ioctlINTC_SET_IPL_46(pIntcBase, param)     INTC_SET_IPL012_n(46, pIntcBase, param)
#define ioctlINTC_SET_IPL_46_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(46, pIntcBase, param)
#define ioctlINTC_GET_IPL_46_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(46, pIntcBase)

#define INTC_SET_IPL_47
#define INTC_SET_IPL_47_RAW
#define INTC_GET_IPL_47_RAW
#define ioctlINTC_SET_IPL_47(pIntcBase, param)     INTC_SET_IPL012_n(47, pIntcBase, param)
#define ioctlINTC_SET_IPL_47_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(47, pIntcBase, param)
#define ioctlINTC_GET_IPL_47_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(47, pIntcBase)

#define INTC_SET_IPL_48
#define INTC_SET_IPL_48_RAW
#define INTC_GET_IPL_48_RAW
#define ioctlINTC_SET_IPL_48(pIntcBase, param)     INTC_SET_IPL012_n(48, pIntcBase, param)
#define ioctlINTC_SET_IPL_48_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(48, pIntcBase, param)
#define ioctlINTC_GET_IPL_48_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(48, pIntcBase)

#define INTC_SET_IPL_49
#define INTC_SET_IPL_49_RAW
#define INTC_GET_IPL_49_RAW
#define ioctlINTC_SET_IPL_49(pIntcBase, param)     INTC_SET_IPL012_n(49, pIntcBase, param)
#define ioctlINTC_SET_IPL_49_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(49, pIntcBase, param)
#define ioctlINTC_GET_IPL_49_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(49, pIntcBase)

#define INTC_SET_IPL_50
#define INTC_SET_IPL_50_RAW
#define INTC_GET_IPL_50_RAW
#define ioctlINTC_SET_IPL_50(pIntcBase, param)     INTC_SET_IPL012_n(50, pIntcBase, param)
#define ioctlINTC_SET_IPL_50_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(50, pIntcBase, param)
#define ioctlINTC_GET_IPL_50_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(50, pIntcBase)

#define INTC_SET_IPL_52
#define INTC_SET_IPL_52_RAW
#define INTC_GET_IPL_52_RAW
#define ioctlINTC_SET_IPL_52(pIntcBase, param)     INTC_SET_IPL012_n(52, pIntcBase, param)
#define ioctlINTC_SET_IPL_52_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(52, pIntcBase, param)
#define ioctlINTC_GET_IPL_52_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(52, pIntcBase)

#define INTC_SET_IPL_53
#define INTC_SET_IPL_53_RAW
#define INTC_GET_IPL_53_RAW
#define ioctlINTC_SET_IPL_53(pIntcBase, param)     INTC_SET_IPL012_n(53, pIntcBase, param)
#define ioctlINTC_SET_IPL_53_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(53, pIntcBase, param)
#define ioctlINTC_GET_IPL_53_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(53, pIntcBase)

#define INTC_SET_IPL_54
#define INTC_SET_IPL_54_RAW
#define INTC_GET_IPL_54_RAW
#define ioctlINTC_SET_IPL_54(pIntcBase, param)     INTC_SET_IPL012_n(54, pIntcBase, param)
#define ioctlINTC_SET_IPL_54_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(54, pIntcBase, param)
#define ioctlINTC_GET_IPL_54_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(54, pIntcBase)

#define INTC_SET_IPL_55
#define INTC_SET_IPL_55_RAW
#define INTC_GET_IPL_55_RAW
#define ioctlINTC_SET_IPL_55(pIntcBase, param)     INTC_SET_IPL012_n(55, pIntcBase, param)
#define ioctlINTC_SET_IPL_55_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(55, pIntcBase, param)
#define ioctlINTC_GET_IPL_55_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(55, pIntcBase)

#define INTC_SET_IPL_56
#define INTC_SET_IPL_56_RAW
#define INTC_GET_IPL_56_RAW
#define ioctlINTC_SET_IPL_56(pIntcBase, param)     INTC_SET_IPL012_n(56, pIntcBase, param)
#define ioctlINTC_SET_IPL_56_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(56, pIntcBase, param)
#define ioctlINTC_GET_IPL_56_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(56, pIntcBase)

#define INTC_SET_IPL_57
#define INTC_SET_IPL_57_RAW
#define INTC_GET_IPL_57_RAW
#define ioctlINTC_SET_IPL_57(pIntcBase, param)     INTC_SET_IPL012_n(57, pIntcBase, param)
#define ioctlINTC_SET_IPL_57_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(57, pIntcBase, param)
#define ioctlINTC_GET_IPL_57_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(57, pIntcBase)

#define INTC_SET_IPL_58
#define INTC_SET_IPL_58_RAW
#define INTC_GET_IPL_58_RAW
#define ioctlINTC_SET_IPL_58(pIntcBase, param)     INTC_SET_IPL012_n(58, pIntcBase, param)
#define ioctlINTC_SET_IPL_58_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(58, pIntcBase, param)
#define ioctlINTC_GET_IPL_58_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(58, pIntcBase)

#define INTC_SET_IPL_59
#define INTC_SET_IPL_59_RAW
#define INTC_GET_IPL_59_RAW
#define ioctlINTC_SET_IPL_59(pIntcBase, param)     INTC_SET_IPL012_n(59, pIntcBase, param)
#define ioctlINTC_SET_IPL_59_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(59, pIntcBase, param)
#define ioctlINTC_GET_IPL_59_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(59, pIntcBase)

#define INTC_SET_IPL_60
#define INTC_SET_IPL_60_RAW
#define INTC_GET_IPL_60_RAW
#define ioctlINTC_SET_IPL_60(pIntcBase, param)     INTC_SET_IPL012_n(60, pIntcBase, param)
#define ioctlINTC_SET_IPL_60_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(60, pIntcBase, param)
#define ioctlINTC_GET_IPL_60_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(60, pIntcBase)

#define INTC_SET_IPL_61
#define INTC_SET_IPL_61_RAW
#define INTC_GET_IPL_61_RAW
#define ioctlINTC_SET_IPL_61(pIntcBase, param)     INTC_SET_IPL012_n(61, pIntcBase, param)
#define ioctlINTC_SET_IPL_61_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(61, pIntcBase, param)
#define ioctlINTC_GET_IPL_61_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(61, pIntcBase)

#define INTC_SET_IPL_62
#define INTC_SET_IPL_62_RAW
#define INTC_GET_IPL_62_RAW
#define ioctlINTC_SET_IPL_62(pIntcBase, param)     INTC_SET_IPL012_n(62, pIntcBase, param)
#define ioctlINTC_SET_IPL_62_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(62, pIntcBase, param)
#define ioctlINTC_GET_IPL_62_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(62, pIntcBase)

#define INTC_SET_IPL_63
#define INTC_SET_IPL_63_RAW
#define INTC_GET_IPL_63_RAW
#define ioctlINTC_SET_IPL_63(pIntcBase, param)     INTC_SET_IPL012_n(63, pIntcBase, param)
#define ioctlINTC_SET_IPL_63_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(63, pIntcBase, param)
#define ioctlINTC_GET_IPL_63_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(63, pIntcBase)

#define INTC_SET_IPL_64
#define INTC_SET_IPL_64_RAW
#define INTC_GET_IPL_64_RAW
#define ioctlINTC_SET_IPL_64(pIntcBase, param)     INTC_SET_IPL012_n(64, pIntcBase, param)
#define ioctlINTC_SET_IPL_64_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(64, pIntcBase, param)
#define ioctlINTC_GET_IPL_64_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(64, pIntcBase)

#define INTC_SET_IPL_65
#define INTC_SET_IPL_65_RAW
#define INTC_GET_IPL_65_RAW
#define ioctlINTC_SET_IPL_65(pIntcBase, param)     INTC_SET_IPL012_n(65, pIntcBase, param)
#define ioctlINTC_SET_IPL_65_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(65, pIntcBase, param)
#define ioctlINTC_GET_IPL_65_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(65, pIntcBase)

#define INTC_SET_IPL_66
#define INTC_SET_IPL_66_RAW
#define INTC_GET_IPL_66_RAW
#define ioctlINTC_SET_IPL_66(pIntcBase, param)     INTC_SET_IPL012_n(66, pIntcBase, param)
#define ioctlINTC_SET_IPL_66_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(66, pIntcBase, param)
#define ioctlINTC_GET_IPL_66_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(66, pIntcBase)

#define INTC_SET_IPL_67
#define INTC_SET_IPL_67_RAW
#define INTC_GET_IPL_67_RAW
#define ioctlINTC_SET_IPL_67(pIntcBase, param)     INTC_SET_IPL012_n(67, pIntcBase, param)
#define ioctlINTC_SET_IPL_67_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(67, pIntcBase, param)
#define ioctlINTC_GET_IPL_67_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(67, pIntcBase)

#define INTC_SET_IPL_68
#define INTC_SET_IPL_68_RAW
#define INTC_GET_IPL_68_RAW
#define ioctlINTC_SET_IPL_68(pIntcBase, param)     INTC_SET_IPL012_n(68, pIntcBase, param)
#define ioctlINTC_SET_IPL_68_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(68, pIntcBase, param)
#define ioctlINTC_GET_IPL_68_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(68, pIntcBase)

#define INTC_SET_IPL_69
#define INTC_SET_IPL_69_RAW
#define INTC_GET_IPL_69_RAW
#define ioctlINTC_SET_IPL_69(pIntcBase, param)     INTC_SET_IPL012_n(69, pIntcBase, param)
#define ioctlINTC_SET_IPL_69_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(69, pIntcBase, param)
#define ioctlINTC_GET_IPL_69_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(69, pIntcBase)

#define INTC_SET_IPL_71
#define INTC_SET_IPL_71_RAW
#define INTC_GET_IPL_71_RAW
#define ioctlINTC_SET_IPL_71(pIntcBase, param)     INTC_SET_IPL012_n(71, pIntcBase, param)
#define ioctlINTC_SET_IPL_71_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(71, pIntcBase, param)
#define ioctlINTC_GET_IPL_71_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(71, pIntcBase)

#define INTC_SET_IPL_72
#define INTC_SET_IPL_72_RAW
#define INTC_GET_IPL_72_RAW
#define ioctlINTC_SET_IPL_72(pIntcBase, param)     INTC_SET_IPL012_n(72, pIntcBase, param)
#define ioctlINTC_SET_IPL_72_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(72, pIntcBase, param)
#define ioctlINTC_GET_IPL_72_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(72, pIntcBase)

#define INTC_SET_IPL_73
#define INTC_SET_IPL_73_RAW
#define INTC_GET_IPL_73_RAW
#define ioctlINTC_SET_IPL_73(pIntcBase, param)     INTC_SET_IPL012_n(73, pIntcBase, param)
#define ioctlINTC_SET_IPL_73_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(73, pIntcBase, param)
#define ioctlINTC_GET_IPL_73_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(73, pIntcBase)

#define INTC_SET_IPL_74
#define INTC_SET_IPL_74_RAW
#define INTC_GET_IPL_74_RAW
#define ioctlINTC_SET_IPL_74(pIntcBase, param)     INTC_SET_IPL012_n(74, pIntcBase, param)
#define ioctlINTC_SET_IPL_74_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(74, pIntcBase, param)
#define ioctlINTC_GET_IPL_74_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(74, pIntcBase)

#define INTC_SET_IPL_75
#define INTC_SET_IPL_75_RAW
#define INTC_GET_IPL_75_RAW
#define ioctlINTC_SET_IPL_75(pIntcBase, param)     INTC_SET_IPL012_n(75, pIntcBase, param)
#define ioctlINTC_SET_IPL_75_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(75, pIntcBase, param)
#define ioctlINTC_GET_IPL_75_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(75, pIntcBase)

#define INTC_SET_IPL_76
#define INTC_SET_IPL_76_RAW
#define INTC_GET_IPL_76_RAW
#define ioctlINTC_SET_IPL_76(pIntcBase, param)     INTC_SET_IPL012_n(76, pIntcBase, param)
#define ioctlINTC_SET_IPL_76_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(76, pIntcBase, param)
#define ioctlINTC_GET_IPL_76_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(76, pIntcBase)

#define INTC_SET_IPL_77
#define INTC_SET_IPL_77_RAW
#define INTC_GET_IPL_77_RAW
#define ioctlINTC_SET_IPL_77(pIntcBase, param)     INTC_SET_IPL012_n(77, pIntcBase, param)
#define ioctlINTC_SET_IPL_77_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(77, pIntcBase, param)
#define ioctlINTC_GET_IPL_77_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(77, pIntcBase)

#define INTC_SET_IPL_78
#define INTC_SET_IPL_78_RAW
#define INTC_GET_IPL_78_RAW
#define ioctlINTC_SET_IPL_78(pIntcBase, param)     INTC_SET_IPL012_n(78, pIntcBase, param)
#define ioctlINTC_SET_IPL_78_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(78, pIntcBase, param)
#define ioctlINTC_GET_IPL_78_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(78, pIntcBase)

#define INTC_SET_IPL_79
#define INTC_SET_IPL_79_RAW
#define INTC_GET_IPL_79_RAW
#define ioctlINTC_SET_IPL_79(pIntcBase, param)     INTC_SET_IPL012_n(79, pIntcBase, param)
#define ioctlINTC_SET_IPL_79_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(79, pIntcBase, param)
#define ioctlINTC_GET_IPL_79_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(79, pIntcBase)

#define INTC_SET_IPL_80
#define INTC_SET_IPL_80_RAW
#define INTC_GET_IPL_80_RAW
#define ioctlINTC_SET_IPL_80(pIntcBase, param)     INTC_SET_IPL012_n(80, pIntcBase, param)
#define ioctlINTC_SET_IPL_80_RAW(pIntcBase, param) INTC_SET_IPLRAW_n(80, pIntcBase, param)
#define ioctlINTC_GET_IPL_80_RAW(pIntcBase, param) INTC_GET_IPLRAW_n(80, pIntcBase)



/* we have to make sure that all INT_PRIORITY_LEVEL_x are defined */

#ifdef INT_PRIORITY_LEVEL_1
#error The interrupt 1 has fixed priority level. You can not define INT_PRIORITY_LEVEL_1
#endif
#ifdef INT_PRIORITY_LEVEL_2
#error The interrupt 2 has fixed priority level. You can not define INT_PRIORITY_LEVEL_2
#endif
#ifdef INT_PRIORITY_LEVEL_3
#error The interrupt 3 has fixed priority level. You can not define INT_PRIORITY_LEVEL_3
#endif
#ifdef INT_PRIORITY_LEVEL_4
#error The interrupt 4 has fixed priority level. You can not define INT_PRIORITY_LEVEL_4
#endif
#ifdef INT_PRIORITY_LEVEL_5
#error The interrupt 5 has fixed priority level. You can not define INT_PRIORITY_LEVEL_5
#endif
#ifndef INT_PRIORITY_LEVEL_6
#define INT_PRIORITY_LEVEL_6 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_7
#define INT_PRIORITY_LEVEL_7 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_8
#error The interrupt 8 has fixed priority level. You can not define INT_PRIORITY_LEVEL_8
#endif
#ifndef INT_PRIORITY_LEVEL_9
#define INT_PRIORITY_LEVEL_9 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_10
#define INT_PRIORITY_LEVEL_10 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_11
#define INT_PRIORITY_LEVEL_11 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_12
#error The interrupt 12 has fixed priority level. You can not define INT_PRIORITY_LEVEL_12
#endif
#ifdef INT_PRIORITY_LEVEL_13
#error The interrupt 13 has fixed priority level. You can not define INT_PRIORITY_LEVEL_13
#endif
#ifdef INT_PRIORITY_LEVEL_14
#error The interrupt 14 has fixed priority level. You can not define INT_PRIORITY_LEVEL_14
#endif
#ifdef INT_PRIORITY_LEVEL_15
#error The interrupt 15 has fixed priority level. You can not define INT_PRIORITY_LEVEL_15
#endif
#ifdef INT_PRIORITY_LEVEL_16
#error The interrupt 16 has fixed priority level. You can not define INT_PRIORITY_LEVEL_16
#endif
#ifndef INT_PRIORITY_LEVEL_17
#define INT_PRIORITY_LEVEL_17 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_18
#define INT_PRIORITY_LEVEL_18 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_19
#error The interrupt 19 has fixed priority level. You can not define INT_PRIORITY_LEVEL_19
#endif
#ifndef INT_PRIORITY_LEVEL_20
#define INT_PRIORITY_LEVEL_20 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_21
#define INT_PRIORITY_LEVEL_21 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_22
#define INT_PRIORITY_LEVEL_22 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_23
#define INT_PRIORITY_LEVEL_23 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_24
#define INT_PRIORITY_LEVEL_24 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_25
#error The interrupt 25 has fixed priority level. You can not define INT_PRIORITY_LEVEL_25
#endif
#ifndef INT_PRIORITY_LEVEL_26
#define INT_PRIORITY_LEVEL_26 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_27
#define INT_PRIORITY_LEVEL_27 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_28
#define INT_PRIORITY_LEVEL_28 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_29
#define INT_PRIORITY_LEVEL_29 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_30
#define INT_PRIORITY_LEVEL_30 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_31
#define INT_PRIORITY_LEVEL_31 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_32
#define INT_PRIORITY_LEVEL_32 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_33
#define INT_PRIORITY_LEVEL_33 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_34
#define INT_PRIORITY_LEVEL_34 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_35
#define INT_PRIORITY_LEVEL_35 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_36
#error The interrupt 36 has fixed priority level. You can not define INT_PRIORITY_LEVEL_36
#endif
#ifdef INT_PRIORITY_LEVEL_37
#error The interrupt 37 has fixed priority level. You can not define INT_PRIORITY_LEVEL_37
#endif
#ifndef INT_PRIORITY_LEVEL_38
#define INT_PRIORITY_LEVEL_38 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_39
#define INT_PRIORITY_LEVEL_39 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_40
#define INT_PRIORITY_LEVEL_40 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_41
#define INT_PRIORITY_LEVEL_41 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_42
#define INT_PRIORITY_LEVEL_42 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_43
#define INT_PRIORITY_LEVEL_43 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_44
#error The interrupt 44 has fixed priority level. You can not define INT_PRIORITY_LEVEL_44
#endif
#ifndef INT_PRIORITY_LEVEL_45
#define INT_PRIORITY_LEVEL_45 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_46
#define INT_PRIORITY_LEVEL_46 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_47
#define INT_PRIORITY_LEVEL_47 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_48
#define INT_PRIORITY_LEVEL_48 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_49
#define INT_PRIORITY_LEVEL_49 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_50
#define INT_PRIORITY_LEVEL_50 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_51
#error The interrupt 51 has fixed priority level. You can not define INT_PRIORITY_LEVEL_51
#endif
#ifndef INT_PRIORITY_LEVEL_52
#define INT_PRIORITY_LEVEL_52 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_53
#define INT_PRIORITY_LEVEL_53 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_54
#define INT_PRIORITY_LEVEL_54 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_55
#define INT_PRIORITY_LEVEL_55 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_56
#define INT_PRIORITY_LEVEL_56 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_57
#define INT_PRIORITY_LEVEL_57 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_58
#define INT_PRIORITY_LEVEL_58 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_59
#define INT_PRIORITY_LEVEL_59 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_60
#define INT_PRIORITY_LEVEL_60 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_61
#define INT_PRIORITY_LEVEL_61 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_62
#define INT_PRIORITY_LEVEL_62 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_63
#define INT_PRIORITY_LEVEL_63 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_64
#define INT_PRIORITY_LEVEL_64 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_65
#define INT_PRIORITY_LEVEL_65 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_66
#define INT_PRIORITY_LEVEL_66 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_67
#define INT_PRIORITY_LEVEL_67 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_68
#define INT_PRIORITY_LEVEL_68 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_69
#define INT_PRIORITY_LEVEL_69 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_70
#error The interrupt 70 has fixed priority level. You can not define INT_PRIORITY_LEVEL_70
#endif
#ifndef INT_PRIORITY_LEVEL_71
#define INT_PRIORITY_LEVEL_71 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_72
#define INT_PRIORITY_LEVEL_72 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_73
#define INT_PRIORITY_LEVEL_73 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_74
#define INT_PRIORITY_LEVEL_74 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_75
#define INT_PRIORITY_LEVEL_75 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_76
#define INT_PRIORITY_LEVEL_76 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_77
#define INT_PRIORITY_LEVEL_77 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_78
#define INT_PRIORITY_LEVEL_78 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_79
#define INT_PRIORITY_LEVEL_79 INTC_DISABLED
#endif
#ifndef INT_PRIORITY_LEVEL_80
#define INT_PRIORITY_LEVEL_80 INTC_DISABLED
#endif
#ifdef INT_PRIORITY_LEVEL_81
#error The interrupt 81 has fixed priority level. You can not define INT_PRIORITY_LEVEL_81
#endif


/* for each interrupt vector, define here its correct prototype */

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


/* now we can define the init values for all IPR registers */

#define INTC_IPR0_INIT (0\
		| INTC_MAKE_IPR_VALUE(6, INT_PRIORITY_LEVEL_6) \
		| INTC_MAKE_IPR_VALUE(7, INT_PRIORITY_LEVEL_7) \
		)
#define INTC_IPR1_INIT (0\
		| INTC_MAKE_IPR_VALUE(9, INT_PRIORITY_LEVEL_9) \
		| INTC_MAKE_IPR_VALUE(10, INT_PRIORITY_LEVEL_10) \
		| INTC_MAKE_IPR_VALUE(11, INT_PRIORITY_LEVEL_11) \
		)
#define INTC_IPR2_INIT (0\
		| INTC_MAKE_IPR_VALUE(17, INT_PRIORITY_LEVEL_17) \
		| INTC_MAKE_IPR_VALUE(18, INT_PRIORITY_LEVEL_18) \
		| INTC_MAKE_IPR_VALUE(20, INT_PRIORITY_LEVEL_20) \
		| INTC_MAKE_IPR_VALUE(21, INT_PRIORITY_LEVEL_21) \
		| INTC_MAKE_IPR_VALUE(22, INT_PRIORITY_LEVEL_22) \
		| INTC_MAKE_IPR_VALUE(23, INT_PRIORITY_LEVEL_23) \
		| INTC_MAKE_IPR_VALUE(24, INT_PRIORITY_LEVEL_24) \
		)
#define INTC_IPR3_INIT (0\
		| INTC_MAKE_IPR_VALUE(26, INT_PRIORITY_LEVEL_26) \
		| INTC_MAKE_IPR_VALUE(27, INT_PRIORITY_LEVEL_27) \
		| INTC_MAKE_IPR_VALUE(28, INT_PRIORITY_LEVEL_28) \
		| INTC_MAKE_IPR_VALUE(29, INT_PRIORITY_LEVEL_29) \
		| INTC_MAKE_IPR_VALUE(30, INT_PRIORITY_LEVEL_30) \
		| INTC_MAKE_IPR_VALUE(31, INT_PRIORITY_LEVEL_31) \
		| INTC_MAKE_IPR_VALUE(32, INT_PRIORITY_LEVEL_32) \
		)
#define INTC_IPR4_INIT (0\
		| INTC_MAKE_IPR_VALUE(33, INT_PRIORITY_LEVEL_33) \
		| INTC_MAKE_IPR_VALUE(34, INT_PRIORITY_LEVEL_34) \
		| INTC_MAKE_IPR_VALUE(35, INT_PRIORITY_LEVEL_35) \
		| INTC_MAKE_IPR_VALUE(38, INT_PRIORITY_LEVEL_38) \
		| INTC_MAKE_IPR_VALUE(39, INT_PRIORITY_LEVEL_39) \
		| INTC_MAKE_IPR_VALUE(40, INT_PRIORITY_LEVEL_40) \
		)
#define INTC_IPR5_INIT (0\
		| INTC_MAKE_IPR_VALUE(41, INT_PRIORITY_LEVEL_41) \
		| INTC_MAKE_IPR_VALUE(42, INT_PRIORITY_LEVEL_42) \
		| INTC_MAKE_IPR_VALUE(43, INT_PRIORITY_LEVEL_43) \
		| INTC_MAKE_IPR_VALUE(45, INT_PRIORITY_LEVEL_45) \
		| INTC_MAKE_IPR_VALUE(46, INT_PRIORITY_LEVEL_46) \
		| INTC_MAKE_IPR_VALUE(47, INT_PRIORITY_LEVEL_47) \
		| INTC_MAKE_IPR_VALUE(48, INT_PRIORITY_LEVEL_48) \
		)
#define INTC_IPR6_INIT (0\
		| INTC_MAKE_IPR_VALUE(49, INT_PRIORITY_LEVEL_49) \
		| INTC_MAKE_IPR_VALUE(50, INT_PRIORITY_LEVEL_50) \
		| INTC_MAKE_IPR_VALUE(52, INT_PRIORITY_LEVEL_52) \
		| INTC_MAKE_IPR_VALUE(53, INT_PRIORITY_LEVEL_53) \
		| INTC_MAKE_IPR_VALUE(54, INT_PRIORITY_LEVEL_54) \
		| INTC_MAKE_IPR_VALUE(55, INT_PRIORITY_LEVEL_55) \
		| INTC_MAKE_IPR_VALUE(56, INT_PRIORITY_LEVEL_56) \
		)
#define INTC_IPR7_INIT (0\
		| INTC_MAKE_IPR_VALUE(57, INT_PRIORITY_LEVEL_57) \
		| INTC_MAKE_IPR_VALUE(58, INT_PRIORITY_LEVEL_58) \
		| INTC_MAKE_IPR_VALUE(59, INT_PRIORITY_LEVEL_59) \
		| INTC_MAKE_IPR_VALUE(60, INT_PRIORITY_LEVEL_60) \
		| INTC_MAKE_IPR_VALUE(61, INT_PRIORITY_LEVEL_61) \
		| INTC_MAKE_IPR_VALUE(62, INT_PRIORITY_LEVEL_62) \
		| INTC_MAKE_IPR_VALUE(63, INT_PRIORITY_LEVEL_63) \
		| INTC_MAKE_IPR_VALUE(64, INT_PRIORITY_LEVEL_64) \
		)
#define INTC_IPR8_INIT (0\
		| INTC_MAKE_IPR_VALUE(65, INT_PRIORITY_LEVEL_65) \
		| INTC_MAKE_IPR_VALUE(66, INT_PRIORITY_LEVEL_66) \
		| INTC_MAKE_IPR_VALUE(67, INT_PRIORITY_LEVEL_67) \
		| INTC_MAKE_IPR_VALUE(68, INT_PRIORITY_LEVEL_68) \
		| INTC_MAKE_IPR_VALUE(69, INT_PRIORITY_LEVEL_69) \
		| INTC_MAKE_IPR_VALUE(71, INT_PRIORITY_LEVEL_71) \
		| INTC_MAKE_IPR_VALUE(72, INT_PRIORITY_LEVEL_72) \
		)
#define INTC_IPR9_INIT (0\
		| INTC_MAKE_IPR_VALUE(73, INT_PRIORITY_LEVEL_73) \
		| INTC_MAKE_IPR_VALUE(74, INT_PRIORITY_LEVEL_74) \
		| INTC_MAKE_IPR_VALUE(75, INT_PRIORITY_LEVEL_75) \
		| INTC_MAKE_IPR_VALUE(76, INT_PRIORITY_LEVEL_76) \
		| INTC_MAKE_IPR_VALUE(77, INT_PRIORITY_LEVEL_77) \
		| INTC_MAKE_IPR_VALUE(78, INT_PRIORITY_LEVEL_78) \
		| INTC_MAKE_IPR_VALUE(79, INT_PRIORITY_LEVEL_79) \
		| INTC_MAKE_IPR_VALUE(80, INT_PRIORITY_LEVEL_80) \
		)


#endif /* __INTCTARGET_H */

