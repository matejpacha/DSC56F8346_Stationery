/* *** Copyright Freescale Semiconductor, Inc, 2005 *** */ 

#include "fltutil.h"
#include "dblutil.h"
#include "prototype.h"

#include <signal.h>
#include <float.h>
          
extern int EnableFPExceptions;  /* Bit field mask. 
					               Setting a flag will raise
					               a SIGFPE signal if the last FP
					               operations raised this exception. 
					               Set by default to FALSE for all
					               exceptions.                     */ 
					               
extern int IEEE_Exceptions ;    /* IEEE exceptions that were raised
                                   during the last FP operation.   */ 					                         


//int Round_Mode      = ROUND_TO_NEAREST_EVEN;
int FLUSH_TO_ZERO   = False;
int IEEE_Exceptions = IEEE_No_Exception;
int EnableFPExceptions = 0;
int IEEE_Condition_Codes = 0;



#define TININESS_BEFORE_ROUNDING	0
#define TININESS_AFTER_ROUNDING		1

int DetectTininess = TININESS_BEFORE_ROUNDING;

/* UTILS */
/* counts the number of leading 0 bits before th ng a0 and a1 left by the number
   of bits given in count. The value of count must be less than 32 */
void dbl_shortShift64Left(unsigned long a0, unsigned long a1, int count, 
				unsigned long *z0Ptr, unsigned long *z1Ptr )
{
//#pragma inline
    *z1Ptr = a1<<count;
    *z0Ptr =
        ( count == 0 ) ? a0 : ( a0<<count ) | ( a1>>( ( - count ) & 31 ) );
  
}

/* shifts the 96-bit value formed by concatenating a0, a1 and a2 left by the
   number of bits specified by count */
void dbl_shortShift96Left(unsigned long a0, unsigned long a1, unsigned long a2,
     int count, unsigned long *z0Ptr, unsigned long *z1Ptr, unsigned long *z2Ptr)
{
    	unsigned long z0, z1, z2;
    	int negCount;

    z2 = a2<<count;
    z1 = a1<<count;
    z0 = a0<<count;
    if ( 0 < count ) {
        negCount = ( ( - count ) & 31 );
        z1 |= a2>>negCount;
        z0 |= a1>>negCount;
    }
    *z2Ptr = z2;
    *z1Ptr = z1;
    *z0Ptr = z0;

}
   
/* shifts the 96-bit value formed by concatenating a0, a1 and a2 right by 32 plus
   the number of bits given by count */  

void dbl_shift64ExtraRightJamming(unsigned long a0, unsigned long a1,unsigned long a2,
     int count, unsigned long *z0Ptr, unsigned long *z1Ptr, unsigned long *z2Ptr)
{  
    	unsigned long z0, z1, z2;
    	int negCount = ( - count ) & 31;

    if ( count == 0 ) {
        z2 = a2;
        z1 = a1;
        z0 = a0;
    }
    else {
        if ( count < 32 ) {
            z2 = a1<<negCount;
            z1 = ( a0<<negCount ) | ( a1>>count );
            z0 = a0>>count;
        }
        else {  
            if ( count == 32 ) {
                z2 = a1;
                z1 = a0;
            }
            else {
                a2 |= a1;
                if ( count < 64 ) {
                    z2 = a0<<negCount;
                    z1 = a0>>( count & 31 );
                }
                else {
                    z2 = ( count == 64 ) ? a0 : ( a0 != 0 );
                    z1 = 0;
                }
            }
            z0 = 0;  
        }
        z2 |= (unsigned long)( a2 != 0 );
    }
    *z2Ptr = z2;
    *z1Ptr = z1;
    *z0Ptr = z0;
}

/* shifts the 64-bit value formed by concatenating a0 and a1 right by the number of bits given in count.
   if any nonzero bits are shifted off, they are jammed into the least significant bit of the result by
   setting the least significat bit to one */
void dbl_shift64RightJamming(unsigned long a0, unsigned long a1, int count, 
				unsigned long *z0Ptr, unsigned long *z1Ptr )
{
    unsigned long z0, z1;
    int negCount = ( - count ) & 31;

    if ( count == 0 ) {
        z1 = a1;
        z0 = a0;
    }
    else if ( count < 32 ) {
        z1 = ( a0<<negCount ) | ( a1>>count ) | ( ( a1<<negCount ) != 0 );
        z0 = a0>>count;
    }
    else {
        if ( count == 32 ) {
            z1 = a0 | ( a1 != 0 );
        }
        else if ( count < 64 ) {
            z1 = ( a0>>( count & 31 ) ) | ( ( ( a0<<negCount ) | a1 ) != 0 );
        }
        else {
            z1 = (unsigned long)( ( a0 | a1 ) != 0 );
        }
        z0 = 0;
    }
    *z1Ptr = z1;
    *z0Ptr = z0;
}

/* shifts a right by the number given in count */
void dbl_shift32RightJamming(unsigned long a, int count, unsigned long *zPtr )
{
    unsigned long z;
    int negCount = (-count) & 31;

    if (count == 0) {
        z = a; 
    } else { 
    		if ( count < 32 ) 
        		z = ( a>>count ) | ( ( a<<negCount ) != 0 );
    		else
    			z = (unsigned long)( a != 0 );
    }
    *zPtr = z;
}
     
/* adds the 64-bit value formed by concatenating a0 and a1 to the 64-bit value formed by 
   concatenating b0 and b1 */
void dbl_add64(unsigned long a0, unsigned long a1, unsigned long b0, 
			unsigned long b1, unsigned long *z0Ptr, unsigned long *z1Ptr )
{
//#pragma inline     
    unsigned long z1;

    z1 = a1 + b1;
    *z1Ptr = z1;
    *z0Ptr = a0 + b0 + ( z1 < a1 );
}

/* subtracts the 64-bit value formed by concatenating b0 and b1 from the 64-bit value formed
   by concatenating a0 and a1 */
void dbl_sub64(unsigned long a0, unsigned long a1, unsigned long b0, 
			unsigned long b1, unsigned long *z0Ptr, unsigned long *z1Ptr )
{
//#pragma inline
    *z1Ptr = a1 - b1;
    *z0Ptr = a0 - b0 - ( a1 < b1 );
}

/* adds the 96-bit value formed by concatenating a0, a1 and a2 to the 96-bit value formed
   by concatenating b0, b1 and b2 */
void dbl_add96(
     unsigned long a0,
     unsigned long a1,
     unsigned long a2,
     unsigned long b0,
     unsigned long b1,
     unsigned long b2,
     unsigned long *z0Ptr,
     unsigned long *z1Ptr,
     unsigned long *z2Ptr
)
{
    unsigned long z0, z1, z2;
    char carry0, carry1;

    z2 = a2 + b2;
    carry1 = ( z2 < a2 );
    z1 = a1 + b1;
    carry0 = ( z1 < a1 );
    z0 = a0 + b0;
    z1 += carry1;
    z0 += ( z1 < carry1 );
    z0 += carry0;
    *z2Ptr = z2;
    *z1Ptr = z1;
    *z0Ptr = z0;
}

/* subtracts the 96-it value formed by concatenating b0, b1 and b2 form the 96-bit
   value formed by concatenating a0, a1 and a2 */
void dbl_sub96(
     unsigned long a0,
     unsigned long a1,
     unsigned long a2,
     unsigned long b0,
     unsigned long b1,
     unsigned long b2,
     unsigned long *z0Ptr,
     unsigned long *z1Ptr,
     unsigned long *z2Ptr
 )
{
    unsigned long z0, z1, z2;
    char borrow0, borrow1;

    z2 = a2 - b2;
    borrow1 = ( a2 < b2 );
    z1 = a1 - b1;
    borrow0 = ( a1 < b1 );
    z0 = a0 - b0;
    z0 -= ( z1 < borrow1 );
    z1 -= borrow1;
    z0 -= borrow0;
    *z2Ptr = z2;
    *z1Ptr = z1;
    *z0Ptr = z0;
}

/* shifts the 64-bit value formed by concatenitng a0 and a1 right by the number of
   bits given in count */
void dbl_shift64Right(unsigned long a0, unsigned long a1, 
			int count, unsigned long *z0Ptr, unsigned long *z1Ptr)
{
    unsigned long z0, z1;
    int negCount = ( - count ) & 31;

    if ( count == 0 ) {
        z1 = a1;
        z0 = a0;
    }
    else if ( count < 32 ) {
        z1 = ( a0<<negCount ) | ( a1>>count );
        z0 = a0>>count;
    }
    else {
        z1 = ( count < 64 ) ? ( a0>>( count & 31 ) ) : 0;
        z0 = 0;
    }
    *z1Ptr = z1;
    *z0Ptr = z0;
}


/* takes two double-precision floating-point values one of which is a NaN and
   returns the appropriate NaN result. If either value is a signaling NaN the 
   invalid exception is raised */
double propagateDoubleNaN( double a, double b )
{
    int aIsNaN, aIsSignalingNaN, bIsNaN, bIsSignalingNaN;
    unsigned long long temp;
    unsigned hi, lo;
	int internal_ieee_exceptions;

    aIsNaN = Db_isNaN(a);
    aIsSignalingNaN = Db_isSNaN(a);
    bIsNaN = Db_isNaN(b);
    bIsSignalingNaN = Db_isSNaN(b);
    
    /* both values are made QNaN ???*/
    hi = Db_get_msb(a); lo = Db_get_lsb(a);
    hi |= 0x00080000;
    temp = ((unsigned long long)hi << 32) | lo;
    a = LL_to_Db(temp);


    hi = Db_get_msb(b); lo = Db_get_lsb(b);
    hi |= 0x00080000;
    temp = ((unsigned long long)hi << 32) | lo;
    b = LL_to_Db(temp);

    if ( aIsSignalingNaN | bIsSignalingNaN ) 
    {
   	internal_ieee_exceptions = IEEE_Signaling_Nan;

    IEEE_Exceptions |= internal_ieee_exceptions;
    if(EnableFPExceptions & internal_ieee_exceptions)
    	raise(SIGFPE);
	}
    if (aIsNaN && (!aIsSignalingNaN || !bIsNaN)) return a;
    else return b;
}
        
    
/* multiplies a by b to obtain a 64-bit product */
void dbl_mul32To64( unsigned long a, unsigned long b, unsigned long *z0Ptr, unsigned long *z1Ptr )
{
    unsigned long aHigh, aLow, bHigh, bLow;
    unsigned long z0, zMiddleA, zMiddleB, z1;

    aLow = (unsigned short int)a;
    aHigh = a>>16;
    bLow = (unsigned short int)b;
    bHigh = b>>16;
    z1 =  aLow  * bLow;
    zMiddleA = aLow * bHigh;
    zMiddleB = aHigh * bLow;
    z0 = aHigh * bHigh;
    zMiddleA += zMiddleB;
    z0 += ( ( (unsigned long) ( zMiddleA < zMiddleB ) )<<16 ) + ( zMiddleA>>16 );
    zMiddleA <<= 16;
    z1 += zMiddleA;
    z0 += ( z1 < zMiddleA );
    *z1Ptr = z1;
    *z0Ptr = z0;
}

/* multiplies the 64-bit value formed by concatenating a0 and a1 to the 64-bit
   value formed by concatenating b0 and b1 to obtain a 128-bit product */
void dbl_mul64To128(
     unsigned long a0,
     unsigned long a1,
     unsigned long b0,
     unsigned long b1,
     unsigned long *z0Ptr,
     unsigned long *z1Ptr,
     unsigned long *z2Ptr,
     unsigned long *z3Ptr
 )
{
    unsigned long z0, z1, z2, z3;
    unsigned long more1, more2;

    dbl_mul32To64( a1, b1, &z2, &z3 );
    dbl_mul32To64( a1, b0, &z1, &more2 );
    dbl_add64( z1, more2, 0, z2, &z1, &z2 );
    dbl_mul32To64( a0, b0, &z0, &more1 );
    dbl_add64( z0, more1, 0, z1, &z0, &z1 );
    dbl_mul32To64( a0, b1, &more1, &more2 );
    dbl_add64( more1, more2, 0, z2, &more1, &z2 );
    dbl_add64( z0, z1, 0, more1, &z0, &z1 );
    *z3Ptr = z3;
    *z2Ptr = z2;
    *z1Ptr = z1;
    *z0Ptr = z0;

}

/* multiplies the 64-bit value formed by concatenating a0 and a1 by the 32-bit
   value b to obtain a 96-bit product */
void dbl_mul64By32To96(
     unsigned long a0,
     unsigned long a1,
     unsigned long b,
     unsigned long *z0Ptr,
     unsigned long *z1Ptr,
     unsigned long *z2Ptr
 )
{
    unsigned long z0, z1, z2, more1;

    dbl_mul32To64( a1, b, &z1, &z2 );
    dbl_mul32To64( a0, b, &z0, &more1 );
    dbl_add64( z0, more1, 0, z1, &z0, &z1 );
    *z2Ptr = z2;
    *z1Ptr = z1;
    *z0Ptr = z0;
}

/* returns an approximation to the 32-bit integer obtained by dividing b into the 
   64-bit value formed by concatenating a0 and a1 */
unsigned long dbl_estimateDiv64To32( unsigned long a0, unsigned long a1, unsigned long b )
{
    unsigned long b0, b1;
    unsigned long rem0, rem1, term0, term1;
    unsigned long z;

    if ( b <= a0 ) return 0xFFFFFFFF;
    b0 = b>>16;
    z = ( b0<<16 <= a0 ) ? 0xFFFF0000 : ( a0 / b0 )<<16;
    dbl_mul32To64( b, z, &term0, &term1 );
    dbl_sub64( a0, a1, term0, term1, &rem0, &rem1 );
    while ( ( (long) rem0 ) < 0 ) {
        z -= 0x10000;
        b1 = b<<16;
        dbl_add64( rem0, rem1, b0, b1, &rem0, &rem1 );
    }
    rem0 = ( rem0<<16 ) | ( rem1>>16 );
    z |= ( b0<<16 <= rem0 ) ? 0xFFFF : rem0 / b0;
    return z;
}

/* returns an approximation to the square root of the 32-bit significand given by a */
unsigned long dbl_estimateSqrt32( long aExp, unsigned long a )
{
    static const unsigned short int sqrtOddAdjustments[] = {
        0x0004, 0x0022, 0x005D, 0x00B1, 0x011D, 0x019F, 0x0236, 0x02E0,
        0x039C, 0x0468, 0x0545, 0x0631, 0x072B, 0x0832, 0x0946, 0x0A67
    };
    static const unsigned short int sqrtEvenAdjustments[] = {
        0x0A2D, 0x08AF, 0x075A, 0x0629, 0x051A, 0x0429, 0x0356, 0x029E,
        0x0200, 0x0179, 0x0109, 0x00AF, 0x0068, 0x0034, 0x0012, 0x0002
    };
    int index;
    unsigned long z;

    index = ( a>>27 ) & 15;
    if ( aExp & 1 ) {
        z = 0x4000 + ( a>>17 ) - sqrtOddAdjustments[ index ];
        z = ( ( a / z )<<14 ) + ( z<<15 );
        a >>= 1;
    }
    else {
        z = 0x8000 + ( a>>17 ) - sqrtEvenAdjustments[ index ];
        z = a / z + z;
        z = ( 0x20000 <= z ) ? 0xFFFF8000 : ( z<<15 );
        if ( z <= a ) return (unsigned long) ( ( (long) a )>>1 );
    }
    return ( ( dbl_estimateDiv64To32( a, 0, z ) )>>1 ) + ( z>>1 );
}
  
/* normalizes the double-precision floating-point value represented by the denormalized
   significant formed by the concatenation of 'aSig0' and 'aSig1' */
void normalizeDouble(unsigned long aSig0, unsigned long aSig1, long *zExpPtr, 
				unsigned long *zSig0Ptr, unsigned long* zSig1Ptr)
{
	int shiftCount;
	  
	if ( aSig0 == 0 ) {
		shiftCount = dbl_countLeadingZeros32( aSig1 ) - 11;
	        if ( shiftCount < 0 ) {
	            *zSig0Ptr = aSig1>>( - shiftCount );
	            *zSig1Ptr = aSig1<<( shiftCount & 31 );
	        } else {
	            *zSig0Ptr = aSig1<<shiftCount;
	            *zSig1Ptr = 0;
	        }
	        *zExpPtr = - shiftCount - 31;
	} else {
	        shiftCount = dbl_countLeadingZeros32( aSig0 ) - 11;
	        dbl_shortShift64Left( aSig0, aSig1, shiftCount, zSig0Ptr, zSig1Ptr );
	        *zExpPtr = 1 - shiftCount;
	}
}

/* normalized the single-precision floating-point value represented by the denormalized
   significand aSig */
void normalizeFloat(unsigned long aSig, int* zExpPtr, unsigned long* zSigPtr)  
{
    	int shiftCount;

    	shiftCount = dbl_countLeadingZeros32( aSig ) - 8;
    	*zSigPtr = aSig<<shiftCount;
    	*zExpPtr = 1 - shiftCount;
}
  		
/* packs the sign, exponent and significand formed by the concatenation of zSig0 and
   zSig1 into a double-precision floating-point value */
double packDouble(long zSign, long zExp, unsigned long zSig0, unsigned long zSig1)
{
	unsigned long long temp;
	unsigned long hi, lo;
	
	lo = zSig1;
	hi = (((unsigned long)zSign)<<31) + ((unsigned long)zExp<<20) + zSig0;
	temp = (unsigned long long)lo;
	temp |= ((unsigned long long)hi<<32);
	
	
	/*temp = (unsigned long long)hi;
	temp |= ((unsigned long long)lo<<32);
	*/
	
	return LL_to_Db(temp);
}

/* returns the proper double-precision floating-point value corresponding to 
   the abstract input */
double roundAndPackDouble(long zSign, long zExp, unsigned long zSig0, unsigned long zSig1, 
					unsigned long zSig2)
{
	int roundNearestEven, increment, isTiny;

	int internal_ieee_exceptions = IEEE_No_Exception;

    	increment = ( (zSig2  & 0x80000000) != 0 );
    	if (0x7FD<=(unsigned short int)zExp)
    	{
        	if((0x7FD < zExp)||((zExp == 0x7FD)&&dbl_eq64( 0x001FFFFF, 0xFFFFFFFF, zSig0, zSig1 )&&increment)) 
        	{
			internal_ieee_exceptions = IEEE_Overflow;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
            return packDouble(zSign, 0x7FF, 0, 0 );
        	}
        	if ( zExp < 0 ) 
        	{
            		isTiny = ( DetectTininess == TININESS_BEFORE_ROUNDING )||
            			( zExp < -1 ) || ! increment || dbl_lt64( zSig0, zSig1, 0x001FFFFF, 0xFFFFFFFF );
            		dbl_shift64ExtraRightJamming(zSig0, zSig1, zSig2, - zExp, &zSig0, &zSig1, &zSig2 );
            		zExp = 0;
            		
          		if ( isTiny && zSig2 )
          		{
          		internal_ieee_exceptions = IEEE_Underflow;
          		
				IEEE_Exceptions |= internal_ieee_exceptions;
				if(EnableFPExceptions & internal_ieee_exceptions)
					raise(SIGFPE);
          		}
			increment = ( (zSig2  & 0x80000000) != 0 );
        	}
    	}
	
	   	if ( increment ) {
        	dbl_add64( zSig0, zSig1, 0, 1, &zSig0, &zSig1 );
        	zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & 1);
    	} else {
        	if ( ( zSig0 | zSig1 ) == 0 ) zExp = 0;
    	}
	return packDouble(zSign, zExp, zSig0, zSig1);
}

/* returns the proper double-precision floating-point value corresponding to 
   the abstract input */
double normalizeRoundAndPackDouble(long zSign, long zExp, unsigned long zSig0, unsigned long zSig1)
{
    	int shiftCount;
    	unsigned long zSig2;

    	if ( zSig0 == 0 ) {
        	zSig0 = zSig1;
        	zSig1 = 0;
        	zExp -= 32;
    	}
    	shiftCount = dbl_countLeadingZeros32( zSig0 ) - 11;
    	if ( 0 <= shiftCount ) {
        	zSig2 = 0;
       	 	dbl_shortShift64Left( zSig0, zSig1, shiftCount, &zSig0, &zSig1 );
    	} else {
        	dbl_shift64ExtraRightJamming(zSig0, zSig1, 0, - shiftCount, &zSig0, &zSig1, &zSig2 );
    	}
    	zExp -= shiftCount;
    	return roundAndPackDouble(zSign, zExp, zSig0, zSig1, zSig2);
}


/* returns the result of adding the absolute values of the double precision
   floating-point values. If zSign is 1, the sum is negated before being 
   returned */
double addDoubleSigs(double a, double b, long zSign)
{
    	long aExp, bExp, zExp;
    	unsigned long aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2;
    	long expDiff;
	
		aSig1 = extractDoubleFrac1(a);
    	aSig0 = extractDoubleFrac0(a);
    	aExp = extractDoubleExp(a);
    	bSig1 = extractDoubleFrac1(b);
    	bSig0 = extractDoubleFrac0(b);
    	bExp = extractDoubleExp(b);
    	    	
    	expDiff = aExp - bExp;
    	if ( 0 < expDiff )
    	{
        	if ( aExp == 0x7FF )
        	{
            		if ( aSig0 | aSig1 ) return propagateDoubleNaN( a, b );
            		return a;
        	}
        	if ( bExp == 0 ) 
        	{
            		--expDiff;
        	} else {
            		bSig0 |= 0x00100000;
        	}
        	dbl_shift64ExtraRightJamming(bSig0, bSig1, 0, expDiff, &bSig0, &bSig1, &zSig2 );
        	zExp = aExp;
    	} else if ( expDiff < 0 )
    	{
        	if ( bExp == 0x7FF )
        	{
            		if ( bSig0 | bSig1 ) return propagateDoubleNaN( a, b );
            		return packDouble( zSign, 0x7FF, 0, 0 );
        	}
        	if ( aExp == 0 )
        	{
            		++expDiff;
        	} else {
            		aSig0 |= 0x00100000;
        	}
        	dbl_shift64ExtraRightJamming(aSig0, aSig1, 0, - expDiff, &aSig0, &aSig1, &zSig2 );
        	zExp = bExp;
    	} else {
        	if ( aExp == 0x7FF )
        	{
            		if ( aSig0 | aSig1 | bSig0 | bSig1 )
            		{
                		return propagateDoubleNaN( a, b );
            		}
            		return a;
        	}
        	dbl_add64( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
        	if ( aExp == 0 ) return packDouble( zSign, 0, zSig0, zSig1 );
        	zSig2 = 0;
        	zSig0 |= 0x00200000;
        	zExp = aExp;
        	goto shiftRight1;
    	}
    	aSig0 |= 0x00100000;
    	dbl_add64( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
    	--zExp;
    	if ( zSig0 < 0x00200000 ) goto roundAndPack;
    	++zExp;
shiftRight1:
    	dbl_shift64ExtraRightJamming( zSig0, zSig1, zSig2, 1, &zSig0, &zSig1, &zSig2 );
roundAndPack:
    	return roundAndPackDouble( zSign, zExp, zSig0, zSig1, zSig2 );

}       

/* returns the result of subtracting the absolute values of the double-precision
   floating-point values . If zSign is 1 the difference is negated before being
   returned */
double subDoubleSigs( double a, double b, int zSign )
{
    	signed int aExp, bExp, zExp;
    	unsigned long aSig0, aSig1, bSig0, bSig1, zSig0, zSig1;
    	signed int expDiff;
    	double z;

		int internal_ieee_exceptions;
		
    	aSig1 = extractDoubleFrac1(a);
    	aSig0 = extractDoubleFrac0(a);
    	aExp = extractDoubleExp(a);
    	bSig1 = extractDoubleFrac1(b);
    	bSig0 = extractDoubleFrac0(b);
    	bExp = extractDoubleExp(b);
    	expDiff = aExp - bExp;
    	dbl_shortShift64Left( aSig0, aSig1, 10, &aSig0, &aSig1 );
    	dbl_shortShift64Left( bSig0, bSig1, 10, &bSig0, &bSig1 );
    	if ( 0 < expDiff ) goto aExpBigger;
    	if ( expDiff < 0 ) goto bExpBigger;
    	if ( aExp == 0x7FF )
    	{
        	if ( aSig0 | aSig1 | bSig0 | bSig1 )
        	{
            		return propagateDoubleNaN( a, b );
        	}
			internal_ieee_exceptions = IEEE_Signaling_Nan;
		IEEE_Exceptions |= internal_ieee_exceptions;
		if(EnableFPExceptions & internal_ieee_exceptions)
			raise(SIGFPE);
        	z = packDouble(1, 0x7FF, 0xFFFFF, 0xFFFFFFFF);
        	return z;
    	}
    	if ( aExp == 0 )
    	{
        	aExp = 1;
        	bExp = 1;
    	}
    	if ( bSig0 < aSig0 ) goto aBigger;
    	if ( aSig0 < bSig0 ) goto bBigger;
    	if ( bSig1 < aSig1 ) goto aBigger;
    	if ( aSig1 < bSig1 ) goto bBigger;
	return packDouble(0, 0, 0, 0);
bExpBigger:
    	if ( bExp == 0x7FF )
    	{
        	if ( bSig0 | bSig1 ) return propagateDoubleNaN( a, b );
        	return packDouble( zSign ^ 1, 0x7FF, 0, 0 );
    	}
   	 if ( aExp == 0 ) {
       	 	++expDiff;
    	} else {
        	aSig0 |= 0x40000000;
    	}
    	dbl_shift64RightJamming( aSig0, aSig1, - expDiff, &aSig0, &aSig1 );
    	bSig0 |= 0x40000000;
bBigger:
    	dbl_sub64( bSig0, bSig1, aSig0, aSig1, &zSig0, &zSig1 );
    	zExp = bExp;
    	zSign ^= 1;
    	goto normalizeRoundAndPack;
aExpBigger:
    	if ( aExp == 0x7FF )
    	{
       		if ( aSig0 | aSig1 ) return propagateDoubleNaN( a, b );
        	return a;
    	}
    	if ( bExp == 0 ) {
        	--expDiff;
    	} else {
        	bSig0 |= 0x40000000;
    	}
    	dbl_shift64RightJamming( bSig0, bSig1, expDiff, &bSig0, &bSig1 );
    	aSig0 |= 0x40000000;
aBigger:
    	dbl_sub64( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
    	zExp = aExp;
normalizeRoundAndPack:
    	--zExp;
    	return normalizeRoundAndPackDouble( zSign, zExp - 10, zSig0, zSig1 );
}

unsigned long extractFloatFrac(float a)
{
//#pragma inline
	unsigned long temp = *((unsigned long*)&a);
	return temp & 0x007fffff;
}

int extractFloatExp(float a)
{
//#pragma inline
	unsigned long temp = *((unsigned long*)&a);
	return (temp >> 23) & 0xff;
}

int extractFloatSign(float a)
{
//#pragma inline
	unsigned long temp = *((unsigned long*)&a);
	return temp >> 31;
}

/* packs a floating point single precision number */
float packFloat(int Sign, int Exp, unsigned long Sig)
{
	unsigned long temp;
	float f;
		
	temp = (((unsigned long)Sign)<<31); 
	temp = temp + (((unsigned long)Exp)<<23);
	temp = temp + Sig;
	f = *((float*)&temp);
	return f;
}

float roundAndPackFloat(int zSign, int zExp, unsigned long zSig)
{
		int roundNearestEven;
    	int roundIncrement, roundBits;
    	int isTiny;
    	unsigned int res;
		int internal_ieee_exceptions;
		float f;
		
		roundNearestEven = 1;
    	roundIncrement = 0x40;
    	
    	roundBits = zSig & 0x7F;
    	if (0xFD <= (unsigned short int) zExp)
    	{
        	if (( 0xFD < zExp )||((zExp == 0xFD)&&((zSig + roundIncrement)&0x80000000)))
        	{
        		internal_ieee_exceptions = IEEE_Overflow;
					IEEE_Exceptions |= internal_ieee_exceptions;
            		if(EnableFPExceptions & internal_ieee_exceptions)
            			raise(SIGFPE);
            		return packFloat( zSign, 0xFF, 0 );
        	}
        	if ( zExp < 0 )
        	{
            		isTiny=(DetectTininess == TININESS_BEFORE_ROUNDING)
                		||(zExp < -1 )
                		||(zSig + roundIncrement < 0x80000000);
            		dbl_shift32RightJamming( zSig, - zExp, &zSig );
            		zExp = 0;
            		roundBits = zSig & 0x7F;
            
            		if ( isTiny && roundBits ) 
            		{
					internal_ieee_exceptions = IEEE_Underflow;
					IEEE_Exceptions |= internal_ieee_exceptions;
            		if(EnableFPExceptions & internal_ieee_exceptions)
            			raise(SIGFPE);
            		}
        	}
    	}
    	zSig = ( zSig + roundIncrement )>>7;
    	zSig &= ~ (( ( roundBits ^ 0x40 ) == 0 ) & 1);
    	if ( zSig == 0 ) zExp = 0;
    	
    	
    	f = packFloat( zSign, zExp, zSig );
    	return f;
}

float normalizeRoundAndPackFloat(int zSign, int zExp, unsigned long zSig)
{
	int shiftCount;

    	shiftCount = dbl_countLeadingZeros32( zSig ) - 1;
    	return roundAndPackFloat( zSign, zExp - shiftCount, zSig<<shiftCount );
}

  