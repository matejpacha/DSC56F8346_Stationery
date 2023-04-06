/************************************************************************
 *                                                                      *
 * Freescale, Inc.                                                      *
 * (c) Copyright 2004 Freescale, Inc.                                   *
 * ALL RIGHTS RESERVED                                                  *
 *                                                                      *   
 ************************************************************************
 *                                                                      *
 * File name  : mclib_svm.h                                             *
 *                                                                      *
 ************************************************************************/
 
#ifndef _MCLIB_SVM_H_
#define _MCLIB_SVM_H_
/********************************************************************
 * Function calculates the appropriate duty cycles needed to        *
 * generate a given stator reference voltage using the Space Vector *
 * Modulation with a duty cycle of the null switching state combined*
 * from states O000 and O111 in each sector of the hexagon.         *
 ********************************************************************/
extern int asm MCLIB_SvmStd (MC_2PhSyst *p_AlphaBeta, MC_3PhSyst *p_abc);
    
/********************************************************************
 * Function calculates the appropriate duty cycles needed to        *
 * generate a given stator reference voltage using the Space Vector *
 * Modulation with a duty cycle of the null switching state combined* 
 * only from states O000 in each sector of the hexagon.             *
 ********************************************************************/
extern int asm MCLIB_SvmU0n (MC_2PhSyst *p_AlphaBeta, MC_3PhSyst *p_abc);
    
/********************************************************************
 * Function calculates the appropriate duty cycles needed to        *
 * generate a given stator reference voltage using the Space Vector *
 * Modulation with a duty cycle of the null switching state combined*
 * only from states O111 in each sector of the hexagon.             *
 ********************************************************************/
extern int asm MCLIB_SvmU7n (MC_2PhSyst *p_AlphaBeta, MC_3PhSyst *p_abc);
	
/********************************************************************
 * Function calculates the appropriate duty cycles needed to        *
 * generate a given stator reference voltage using the Space Vector *
 * Modulation with a duty cycle of the null switching state combined*
 * from state O000 and O111 in the even (2,4,6) and odd (1,3,5)     *
 * sectors of the hexagon, respectively.                            *
 ********************************************************************/
extern int asm MCLIB_SvmAlt (MC_2PhSyst *p_AlphaBeta, MC_3PhSyst *p_abc);
                           
/********************************************************************   
 * Function calculates the appropriate duty cycles needed to        *
 * generate a given stator reference voltage using the General      *
 * Sinusoidal Modulation technique.                                 *
 ********************************************************************/                          
extern int asm MCLIB_PwmIct (MC_2PhSyst *p_AlphaBeta, MC_3PhSyst *p_abc);                            

/********************************************************************
 * Function calculates the appropriate duty cycles needed to        *
 * generate a given stator reference voltage using the General      *
 * Sinusoidal Modulation with an injection of the third harmonic.   *
 ********************************************************************/
extern int asm MCLIB_SvmSci (MC_2PhSyst *p_AlphaBeta, MC_3PhSyst *p_abc) ;

/********************************************************************
 * Function is used for elimination of the DC-Bus voltage ripple.   *
 ********************************************************************/
extern void MCLIB_ElimDcBusRip (Frac16 invModIndex, Frac16 u_DcBusMsr, 
                        MC_2PhSyst *pInp_AlphaBeta, MC_2PhSyst *pOut_AlphaBeta);                        

#endif /* _MCLIB_SVM_H_ */
