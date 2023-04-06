/********************************************************************
 *                                                                  *
 * Freescale Inc.                                                   *
 * (c) Copyright 2004 Freescale, Inc.                               *
 * ALL RIGHTS RESERVED.                                             *
 *                                                                  *
 ********************************************************************
 *                                                                  *
 * File Name: mclib.h                                               *
 *                                                                  *
 ********************************************************************/
#ifndef _MCLIB_H_
#define _MCLIB_H_

#include "mclib_types.h"    /* motor control data definitions       */

/* include header files of motor control library functions          */ 
#include "mclib_basic.h"      /* basic operations definitons        */
#include "mclib_transform.h"  /* basic transformations definitions  */  
#include "mclib_controller.h" /* controller definitions             */
#include "mclib_ramp.h"       /* ramp generation definitions        */
#include "mclib_resolver.h"   /* resolver driver definitions        */
#include "mclib_svm.h"        /* space vector modulation definitions*/
										
#endif  /* _MCLIB_H_ */ 

