/* MSL
 * Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2005/12/09 02:02:42 $
 * $Revision: 1.7 $
 */

#ifndef __fltmath

#define  __fltmath

#include <float.h>
typedef long SpFloat;    /* This is machine dependent !!!        */
                         /* It should be a 32 bit value for IEEE */
                         /* single precision.                    */

/* IEEE Exceptions       */
#define	  IEEE_No_Exception     0x00
#define   IEEE_Inexact          0x01
#define   IEEE_Divide_By_Zero   0x02
#define   IEEE_Underflow        0x04
#define   IEEE_Overflow		0x08	
#define   IEEE_Signaling_Nan    0x10

/* IEEE condition Codes  */
#define   IEEE_Equal_To         1
#define   IEEE_Greater_Than     2
#define   IEEE_Less_Than        4
#define   IEEE_Unordered        8

/*
--
-- An IEEE single precision 32 bit floating point number is represented
-- by a little endian 32 bit integer. The LSB come in the first 16 bits
-- (lower address in memory) and the MSB come in the next 16 bits.
--


--
--
--   ----------------------------------------------------
--   | S |<----- Exp   ----->|<----- Mantissa --------->|
--   ----------------------------------------------------
--    31     30-23                      22-0
--
*/

/*
 *
 * FAdd - Adds two signle precision floating point values.
 * FSub - Subtracts two signle precision floating point values.
 * FMul - Multiplies two signle precision floating point values.
 * FDiv - Divides two signle precision floating point values.
 *
 * IEEE_Exceptions bit is set, if an exception is raised.
 *
 * FCmp - Compare two signle precision floating point values and return  
 *        a condition code value.
 *
 * IntToFloat and FloatToInt convert from/to 32-bit integers to 
 * signle precision floats. These two functions take an additional
 * boolean parameter, IsUnsigned. If true, the integer value is treated
 * as an unsigned value.
 *       
 * Note that these functions are called by the C/C++ compiler generated
 * code. They could be called, however, directly as well.
 *
 */
/* #pragma linkage name="ARTADDF32U" */
SpFloat FAdd ( SpFloat, SpFloat  );
//#pragma linkage name="ARTSUBF32U"
SpFloat FSub ( SpFloat,  SpFloat );
SpFloat FAbs ( SpFloat );

/* #pragma linkage name="ARTMPYF32U" */
SpFloat FMul ( SpFloat, SpFloat );
/* #pragma linkage name="ARTDIVF32UZ" */
SpFloat FDiv ( SpFloat , SpFloat);

/* #pragma linkage name="ARTCMPF32" */
void    FCmp ( SpFloat, SpFloat );

/* Integer to Floating point conversions.   */

// INPUT: y0 = signed word
// OUTPUT: a = float
/* #pragma linkage name="ARTS16_TO_F32" */
SpFloat	Int16sToFloat( int );

 

// INPUT: y0 = unsigned word
// OUTPUT: a = float
/* #pragma linkage name="ARTU16_TO_F32" */
SpFloat	Int16uToFloat( unsigned int );

// INPUT: y0 = signed word
// OUTPUT: a = float
/* #pragma linkage name="ARTS32_TO_F32" */
SpFloat Int32sToFloat( long );        

// INPUT: y0 = unsigned word
// OUTPUT: a = float
/* #pragma linkage name="ARTU32_TO_F32" */
SpFloat Int32uToFloat( unsigned long );    

/* Floating point to integer conversions.   */

// INPUT: a = float
// OUTPUT: y0 = int
/* #pragma linkage name="ARTF32_TO_S16U" */
int     FloatToInt16s( SpFloat );

// INPUT: a = float
// OUTPUT: y0 = unsigned int
/* #pragma linkage name="ARTF32_TO_U16U" */
unsigned int FloatToInt16u( SpFloat );

// INPUT: a = float
// OUTPUT: a = long
/* #pragma linkage name="ARTF32_TO_S32U" */
long    FloatToInt32s( SpFloat );

// INPUT: a = float
// OUTPUT: a = unsigned long long
/* #pragma linkage name="ARTF32_TO_U32U" */
unsigned long FloatToInt32u( SpFloat );

/* Floating point to fractional type conversions  */
#if defined(FIXED_IS_IMPLEMENTED)

/* #pragma linkage name="ARTF32_TO_FXS16U" */
frac FloatToFrac16s( SpFloat );
/* #pragma linkage name="ARTF32_TO_FXU16U" */
unsigned frac FloatToFrac16u( SpFloat );
/* #pragma linkage name="ARTF32_TO_FXS32U" */
long frac FloatToFrac32s( SpFloat );
/* #pragma linkage name="ARTF32_TO_FXU32U" */
unsigned long frac FloatToFrac32u( SpFloat );
/* #pragma linkage name="ARTF32_TO_FXS20U" */
accum FloatToFrac20s( SpFloat );
/* #pragma linkage name="ARTF32_TO_FXS36U" */
long accum FloatToFrac36s( SpFloat );

/* Fractional types to floating point conversions  */ 
 
/* #pragma linkage name="ARTFXS16_TO_F32" */
SpFloat Frac16sToFloat( frac );    
/* #pragma linkage name="FXU16_TO_F32" */
SpFloat Frac16uToFloat( unsigned frac );   
/* #pragma linkage name="ARTFXS32_TO_F32" */    
SpFloat Frac32sToFloat( long frac );       
/* #pragma linkage name="FXU32_TO_F32" */   
SpFloat Frac32uToFloat( unsigned long frac );
/* #pragma linkage name="FXS20_TO_F32" */   
SpFloat Frac20sToFloat( accum );     
/* #pragma linkage name="FXS36_TO_F32" */    
SpFloat Frac36sToFloat( long accum );
#endif

extern int Round_Mode ;			/* Sets the round mode used by the 
					   floating point package. Set to
					   one of the IEEE rounding modes.
					   Is set by default to 
                                           ROUND_TO_NEAREST_EVEN           */

extern int FLUSH_TO_ZERO ;              /* Boolean flag. If set, all 
                                           values that can not be normalized
                                           are flashed to zero. Set to true
                                           by default.                     */

extern int EnableFPExceptions;          /* Bit field mask. 
					   Setting a flag will raise
					   a SIGFPE signal if the last FP
					   operations raised this exception. 
					   Set by default to FALSE for all
					   exceptions.                     */ 

extern int IEEE_Condition_Codes;        /* IEEE condition codes of the last
				           FP compare  .                   */

extern int IEEE_Exceptions ;            /* IEEE exceptions that were raised
                                           during the last FP operation.   */ 


#endif
