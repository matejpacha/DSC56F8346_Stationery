/* *** Copyright Freescale Semiconductor, Inc, 2005 *** */ 
/* Copyright © 2005 Metrowerks Corporation.  All rights reserved. */


#ifndef __dblutil  
#define __dblutil

#include <ansi_parms.h>
_MSL_BEGIN_EXTERN_C

/* general util functions */
       
#define extractDoubleFrac1(a)	Db_get_lsb(a)
#define extractDoubleFrac0(a)	(unsigned long)Db_get_msb(a) & 0x000FFFFF
#define extractDoubleExp(a)	(((unsigned long)Db_get_msb(a)) >> 20) & 0x7FF
#define extractDoubleSign(a)	((unsigned long)Db_get_msb(a)>>31) & 1
  
#define dbl_countLeadingZeros32(a)	(((a)>=0x80000000) ? 0 : norm_l((a))+1)


#define Db_isNaN(a) (0xFFE00000<=(Db_get_msb((a))<<1))&&(Db_get_lsb((a)) || (Db_get_msb((a)) & 0X000FFFFF))
#define Db_isSNaN(a) (((Db_get_msb((a))>>19)&0xFFF)==0xFFE)&&(Db_get_lsb((a))||(Db_get_msb((a))&0x0007FFFF))


#define dbl_eq64(a0,a1,b0,b1) ((a0)==(b0))&&((a1)==(b1))
#define dbl_lt64(a0,a1,b0,b1) ((a0)<(b0))||(((a0)==(b0))&&((a1)<(b1)))
#define dbl_gt64(a0,a1,b0,b1) ((a0)>(b0))||(((a0)==(b0))&&((a1)>(b1)))
#define dbl_le64(a0,a1,b0,b1) ((a0)<(b0))||(((a0)==(b0))&&((a1)<=(b1)))
#define dbl_ge64(a0,a1,b0,b1) ((a0)>(b0))||(((a0)==(b0))&&((a1)>=(b1)))


/*int dbl_countLeadingZeros64(unsigned long long);*/
void dbl_shortShift64Left(unsigned long, unsigned long, int count, 
				unsigned long*, unsigned long*);
void dbl_shortShift96Left(unsigned long, unsigned long, unsigned long, int,
     				unsigned long*, unsigned long*, unsigned long*);

/*int dbl_eq64(unsigned long, unsigned long, unsigned long, unsigned long);     		*/
/*int dbl_lt64( unsigned long, unsigned long, unsigned long, unsigned long);*/
/*int dbl_gt64(unsigned long, unsigned long, unsigned long, unsigned long);	*/			
/*int dbl_le64( unsigned long, unsigned long, unsigned long, unsigned long);*/
/*int dbl_ge64(unsigned long, unsigned long, unsigned long, unsigned long);*/

void dbl_shift64Right(unsigned long, unsigned long,int, unsigned long*, unsigned long*);
void dbl_shift64ExtraRightJamming(unsigned long, unsigned long, unsigned long, int,
     					unsigned long*, unsigned long*, unsigned long*);
void dbl_shift64RightJamming(unsigned long, unsigned long, int,unsigned long*, unsigned long*);
void dbl_shift32RightJamming(unsigned long, int, unsigned long*);

void dbl_add64(unsigned long, unsigned long, unsigned long,
			unsigned long, unsigned long*, unsigned long*);
void dbl_sub64(unsigned long, unsigned long, unsigned long, 
			unsigned long, unsigned long*, unsigned long*);
void dbl_add96(unsigned long, unsigned long, unsigned long, 
			unsigned long, unsigned long, unsigned long,
     			unsigned long*, unsigned long*, unsigned long*);
void dbl_sub96(unsigned long, unsigned long, unsigned long, unsigned long,
     			unsigned long, unsigned long, unsigned long*,
     		  	unsigned long*, unsigned long*);
     			
/*int double_is_nan(double);  */
/*int double_is_signaling_nan(double);*/
double propagateDoubleNaN(double, double);

void dbl_mul32To64(unsigned long, unsigned long, unsigned long*, unsigned long*);
void dbl_mul64To128(unsigned long, unsigned long, unsigned long, unsigned long,
     			unsigned long*, unsigned long*, unsigned long*, unsigned long*);
void dbl_mul64By32To96(unsigned long, unsigned long, unsigned long, 
			unsigned long*, unsigned long*, unsigned long *);
unsigned long dbl_estimateDiv64To32( unsigned long, unsigned long, unsigned long);
unsigned long dbl_estimateSqrt32(long, unsigned long);			

/* double util functions */

/*unsigned long extractDoubleFrac1(double);*/
/*unsigned long extractDoubleFrac0(double);*/
/*long extractDoubleExp(double);*/
/*long extractDoubleSign(double);*/

void normalizeDouble(unsigned long, unsigned long, long*, unsigned long*, unsigned long*);
void normalizeFloat(unsigned long, int*, unsigned long*);  
double packDouble(long, long, unsigned long, unsigned long);
double roundAndPackDouble(long, long, unsigned long, unsigned long, unsigned long);
double normalizeRoundAndPackDouble(long, long, unsigned long, unsigned long);


double addDoubleSigs(double, double, long);
double subDoubleSigs( double, double, int);

/* float util functions */
unsigned long extractFloatFrac(float);
int extractFloatExp(float);
int extractFloatSign(float);

float packFloat(int, int, unsigned long);
float roundAndPackFloat(int, int, unsigned long);
float normalizeRoundAndPackFloat(int, int, unsigned long);

long long strtoll ( const char*, char**, int );
#ifdef _FAR_RUNTIME_CALLS
#pragma far strtoll
#endif

unsigned long long strtoull ( const char*, char**, int );
#ifdef _FAR_RUNTIME_CALLS
#pragma far strtoull
#endif

_MSL_END_EXTERN_C

//# pragma reject_floats reset
#endif

