/* *** Copyright Freescale Semiconductor, Inc, 2005 *** */ 

#include <stdio.h>

#include "fltutil.h"
#include "dblutil.h"
#include "prototype.h"
    
#include <signal.h>
#include <float.h>                                    

/* CONVERSIONS */
       
/* converts the signed integer value of a to double precision, and returns the 
   double precision value */
double ARTS32_TO_F64(long a)
{
		int zSign;
    	unsigned long absA;
    	int shiftCount;
    	unsigned long zSig0, zSig1;

    	if ( a == 0 ) return packDouble( 0, 0, 0, 0 );
    	zSign = ( a < 0 );
    	absA = zSign ? - a : a;
    	shiftCount = dbl_countLeadingZeros32( absA ) - 11;
    	if ( 0 <= shiftCount ) {
        	zSig0 = absA<<shiftCount;
        	zSig1 = 0;
    	} else {  
        	dbl_shift64Right( absA, 0, - shiftCount, &zSig0, &zSig1 );
    	} 
    	return packDouble( zSign, 0x412 - shiftCount, zSig0, zSig1 );
}             
         
/* converts the unsigned integer value of a to double precision, and returns the
   double precision value */
double ARTU32_TO_F64(unsigned long a)   
{ 
 	unsigned int absA;
    	int shiftCount;
    	unsigned long zSig0, zSig1;

    	if (a == 0) return packDouble( 0, 0, 0, 0 );
    	absA = a;
    	shiftCount = dbl_countLeadingZeros32(absA) - 11;
    	if (0 <= shiftCount) {
        	zSig0 = absA<<shiftCount;
        	zSig1 = 0;
    	} else {  
        	dbl_shift64Right( absA, 0, - shiftCount, &zSig0, &zSig1 );
        }
    	return packDouble( 0, 0x412 - shiftCount, zSig0, zSig1 );
}

/* returns the result of converting the double-precision floaintg-point value a to
   32-bit two's complement integer format. The result is always rounded towards zero */
long ARTF64_TO_S32(double a)
{
    	long aSign;
    	int aExp, shiftCount;
    	unsigned long aSig0, aSig1, absZ, aSigExtra;
    	int internal_ieee_exceptions = IEEE_No_Exception;
    	long z;

    	aSig1 = extractDoubleFrac1(a);
    	aSig0 = extractDoubleFrac0(a);
    	aExp = extractDoubleExp(a);
    	aSign = extractDoubleSign(a);
    
    	shiftCount = aExp - 0x413;
    	if (shiftCount >= 0)
    	{
        	if (aExp > 0x41E)
        	{
            		if ( ( aExp == 0x7FF ) && ( aSig0 | aSig1 ) ) aSign = 0; // NaN
            		goto invalid;
        	}
        	dbl_shortShift64Left(aSig0 | 0x00100000, aSig1, shiftCount, &absZ, &aSigExtra );
    	} else {
        	if ( aExp < 0x3FF ) /* a < 1.0 */
           		return 0;

        	aSig0 |= 0x00100000;
        	aSigExtra = ( aSig0<<( shiftCount & 31 ) ) | aSig1;
        	absZ = aSig0>>( - shiftCount );
    	}
    	z = aSign ? - absZ : absZ;
    	if ( ( aSign ^ ( z < 0 ) ) && z )
    	{
invalid:
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);

        	return aSign ? (signed long) 0x80000000 : 0x7FFFFFFF;
    	}
    	return z;
}


/* returns the result of converting the double-precision floaintg-point value a to
   an unsigned integer by truncating any fractional part. The result is always 
   rounded towards zero */
unsigned long ARTF64_TO_U32(double a)
{
		long aSign;
    	long aExp, shiftCount;
    	unsigned long aSig0, aSig1, absZ, aSigExtra;
		int internal_ieee_exceptions = IEEE_No_Exception;
		

    	aSig1 = extractDoubleFrac1(a);
    	aSig0 = extractDoubleFrac0(a);
    	aExp = extractDoubleExp(a);
    	aSign = extractDoubleSign(a);
      
    	if (aSign)
    	{
        	if (aExp==0x7FF && ( aSig0 | aSig1 ))
        	{
        		internal_ieee_exceptions = IEEE_Signaling_Nan;
			        	
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
	           	return (unsigned int) 0xFFFFFFFF;
        	}
        	return 0;    
    	}        
    
   	shiftCount = aExp - 0x413;
    	if ( shiftCount >= 0 )
    	{
        	if ( aExp > 0x41E )
        	{
        	internal_ieee_exceptions = IEEE_Signaling_Nan;
			        	
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
            		return 0xFFFFFFFF;
        	}
        	dbl_shortShift64Left(aSig0 | 0x00100000, aSig1, shiftCount, &absZ, &aSigExtra );
    	} else {
       		if ( aExp < 0x3FF )
             		return 0;
 
        	aSig0 |= 0x00100000;
        	aSigExtra = ( aSig0<<( shiftCount & 31 ) ) | aSig1;
        	absZ = aSig0>>( - shiftCount );
    	}
    	return absZ;
}

/* single precision floating point to double precision floating point */
double ARTF32_TO_F64(float a)
{
	double result;
	int aSign;
    	int aExp;
    	unsigned long aSig, zSig0, zSig1;
    	int internal_ieee_exceptions = IEEE_No_Exception;

    	aSig = extractFloatFrac(a);
    	aExp = extractFloatExp(a);
    	aSign = extractFloatSign(a);
    	if (aExp == 0xFF) 
    	{
        	if (aSig)
        	{
        	internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if (EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
        	 	return packDouble(aSign, 0x7FF, 0xFFFFF, 0xFFFFFFFF); // return QNaN
        	}
        	return packDouble(aSign, 0x7FF, 0, 0); // return Inf
    	}
    	if (aExp==0)
    	{  
        	if (aSig == 0) return packDouble(aSign, 0, 0, 0);
        	normalizeFloat( aSig, &aExp, &aSig );
        	--aExp;
    	}
    	dbl_shift64Right(aSig, 0, 3, &zSig0, &zSig1);
    	result = packDouble(aSign, aExp + 0x380, zSig0, zSig1);
    	return result;
}

/* double precision floatign point to single precision floating point */
float ARTF64_TO_F32(double a)
{
    	int aSign;
    	int aExp;
    	unsigned long aSig0, aSig1, zSig;
    	unsigned long allZero;
    	unsigned long result;
    	float ret;

    	aSig1 = extractDoubleFrac1(a);
    	aSig0 = extractDoubleFrac0(a);
    	aExp = extractDoubleExp(a);
    	aSign = extractDoubleSign(a);
    	if (aExp == 0x7FF) 
    	{
        	if (aSig0|aSig1)
        	{
        		return packFloat(aSign, 0xFF, 0x7FFFFF);
        	}
        	return packFloat(aSign, 0xFF, 0); 
    	}
    	dbl_shift64RightJamming( aSig0, aSig1, 22, &allZero, &zSig );
    	if ( aExp ) zSig |= 0x40000000;
    	
    	//ret = roundAndPackFloat( aSign, aExp - 0x381, zSig );
    	
    	//return ret; 
    	
    	return roundAndPackFloat( aSign, aExp - 0x381, zSig );
}

/* ARITHMETIC OPERATIONS */

/* returns the result of adding two double-precision floating-point values */
double ARTADDF64U(double a, double b)
{
   	long aSign, bSign;

   	aSign = extractDoubleSign( a );
    	bSign = extractDoubleSign( b );
    	if ( aSign == bSign ) {
        	return addDoubleSigs( a, b, aSign );
    	}
    	else {
        	return subDoubleSigs( a, b, aSign );
    	}
}

/* returns the result of subtracting two double-precision floating-point values */
double ARTSUBF64U(double a, double b)
{
		long aSign, bSign;

    	aSign = extractDoubleSign( a );
    	bSign = extractDoubleSign( b );
    	if ( aSign == bSign ) {
        	return subDoubleSigs( a, b, aSign );
    	}
    	else {
        	return addDoubleSigs( a, b, aSign );
    	}
}

/* negates the double-precision floating point value */
double _d_usub(double a)
{
	unsigned long hi, lo;
	unsigned long long temp;

	hi = (unsigned long)Db_get_msb(a);
	lo = Db_get_lsb(a);
	
	if ((hi&0x80000000) == 0) hi |= (0x80000000);
	else hi &= 0x7fffffff;
	
	temp = (unsigned long long)lo;
	temp |= (unsigned long long)hi << 32;
	
	return LL_to_Db(temp);
}

/* returns the absolute value of a double precision floatin-point number */
double _d_abs(double a)
{
	unsigned long hi, lo;
	unsigned long long temp;
	
	hi = (unsigned long)Db_get_msb(a);
	lo = Db_get_lsb(a);
	
	hi &= 0x7fffffff;
	
	temp = (unsigned long long)lo;
	temp |= (unsigned long long)hi << 32;
	
	return LL_to_Db(temp);
}      
   
/* returns the result of multiplying two double-precision floating-point values */
double ARTMPYF64U(double a, double b)
{
    	long aSign, bSign, zSign;
    	long aExp, bExp, zExp;
    	unsigned long aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2, zSig3;
    	double z;

		int internal_ieee_exceptions = IEEE_No_Exception;


    	aSig1 = extractDoubleFrac1(a);
    	aSig0 = extractDoubleFrac0(a);
    	aExp = extractDoubleExp(a);
    	aSign = extractDoubleSign(a);
    	bSig1 = extractDoubleFrac1(b);
    	bSig0 = extractDoubleFrac0(b);
    	bExp = extractDoubleExp(b);
    	bSign = extractDoubleSign(b);
    	zSign = aSign ^ bSign;
    	if (aExp == 0x7FF)
    	{
        	if (( aSig0 | aSig1 )||( ( bExp == 0x7FF ) && ( bSig0 | bSig1 ) ) )
        	{
            		return propagateDoubleNaN( a, b );
        	}
        	if ( ( bExp | bSig0 | bSig1 ) == 0 ) goto invalid;
        	return packDouble( zSign, 0x7FF, 0, 0 );
    	}
    	if ( bExp == 0x7FF )
    	{
        	if ( bSig0 | bSig1 ) return propagateDoubleNaN( a, b );
        	if ( ( aExp | aSig0 | aSig1 ) == 0 ) 
        	{
invalid:
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
	        z = packDouble(1, 0x7FF, 0xFFFFF, 0xFFFFFFFF);
	        return z;
        	}
        	return packDouble( zSign, 0x7FF, 0, 0 );
    	}
    	if ( aExp == 0 )
    	{
        	if ( ( aSig0 | aSig1 ) == 0 ) return packDouble( zSign, 0, 0, 0 );
        	normalizeDouble( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
    	}
    	if ( bExp == 0 )
    	{
        	if ( ( bSig0 | bSig1 ) == 0 ) return packDouble( zSign, 0, 0, 0 );
        	normalizeDouble( bSig0, bSig1, &bExp, &bSig0, &bSig1 );
    	}
    	zExp = aExp + bExp - 0x400;
    	aSig0 |= 0x00100000;
    	dbl_shortShift64Left( bSig0, bSig1, 12, &bSig0, &bSig1 );
    	dbl_mul64To128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1, &zSig2, &zSig3 );
    	
    	dbl_add64( zSig0, zSig1, aSig0, aSig1, &zSig0, &zSig1 );
    	zSig2 |= ( zSig3 != 0 );
    	if ( 0x00200000 <= zSig0 ) 
    	{
        	dbl_shift64ExtraRightJamming(zSig0, zSig1, zSig2, 1, &zSig0, &zSig1, &zSig2 );
        	++zExp;
    	}
    	return roundAndPackDouble( zSign, zExp, zSig0, zSig1, zSig2 );
}      
               
/* returns the result of dividing the double-precision floating-point value a by the 
   double-precision floating-point value b */
double ARTDIVF64Z(double a, double b)
{
    	long aSign, bSign, zSign;
    	long aExp, bExp, zExp;
    	unsigned long aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2;
    	unsigned long rem0, rem1, rem2, rem3, term0, term1, term2, term3;
    	double z;
		int internal_ieee_exceptions = IEEE_No_Exception;

	

    	aSig1 = extractDoubleFrac1( a );
    	aSig0 = extractDoubleFrac0( a );
    	aExp = extractDoubleExp( a );
    	aSign = extractDoubleSign( a );
    	bSig1 = extractDoubleFrac1( b );
    	bSig0 = extractDoubleFrac0( b );
    	bExp = extractDoubleExp( b );
    	bSign = extractDoubleSign( b );
      
    	zSign = aSign ^ bSign;
    	if ( aExp == 0x7FF )
    	{
        	if ( aSig0 | aSig1 ) return propagateDoubleNaN( a, b );
        	if ( bExp == 0x7FF )
        	{
            		if ( bSig0 | bSig1 ) return propagateDoubleNaN( a, b );
            		goto invalid;
        	}
        	return packDouble( zSign, 0x7FF, 0, 0 );
    	}
    	if ( bExp == 0x7FF )
    	{
        	if ( bSig0 | bSig1 ) return propagateDoubleNaN( a, b );
        	return packDouble( zSign, 0, 0, 0 );
    	}
    	if ( bExp == 0 )
    	{
        	if ( ( bSig0 | bSig1 ) == 0 )
        	{
            		if ( ( aExp | aSig0 | aSig1 ) == 0 )
            		{
invalid:
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
					z = packDouble(1, 0x7FF, 0xFFFFF, 0xFFFFFFFF);
           			return z;
           			}
			internal_ieee_exceptions = IEEE_Divide_By_Zero;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
            return packDouble( zSign, 0x7FF, 0, 0 );
        	}
        	normalizeDouble( bSig0, bSig1, &bExp, &bSig0, &bSig1 );
    	}
    	if ( aExp == 0 )
    	{
        	if ( ( aSig0 | aSig1 ) == 0 ) return packDouble( zSign, 0, 0, 0 );
        	normalizeDouble( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
    	}
    	
    	zExp = aExp - bExp + 0x3FD;
    	dbl_shortShift64Left( aSig0 | 0x00100000, aSig1, 11, &aSig0, &aSig1 );
    	dbl_shortShift64Left( bSig0 | 0x00100000, bSig1, 11, &bSig0, &bSig1 );
    	if ( dbl_le64( bSig0, bSig1, aSig0, aSig1 ) )
    	{
        	dbl_shift64Right( aSig0, aSig1, 1, &aSig0, &aSig1 );
        	++zExp;
    	}
    	zSig0 = dbl_estimateDiv64To32( aSig0, aSig1, bSig0 );
    	dbl_mul64By32To96( bSig0, bSig1, zSig0, &term0, &term1, &term2 );
    	dbl_sub96( aSig0, aSig1, 0, term0, term1, term2, &rem0, &rem1, &rem2 );
    	while ( (rem0 & 0x80000000) != 0 )
    	{
        	--zSig0;
        	dbl_add96( rem0, rem1, rem2, 0, bSig0, bSig1, &rem0, &rem1, &rem2 );
    	}
    	zSig1 = dbl_estimateDiv64To32( rem1, rem2, bSig0 );
    	if ( ( zSig1 & 0x3FF ) <= 4 )
    	{
        	dbl_mul64By32To96( bSig0, bSig1, zSig1, &term1, &term2, &term3 );
        	dbl_sub96( rem1, rem2, 0, term1, term2, term3, &rem1, &rem2, &rem3 );
        	while ( (rem1 & 0x80000000) != 0 )
        	{
            		--zSig1;
            		dbl_add96( rem1, rem2, rem3, 0, bSig0, bSig1, &rem1, &rem2, &rem3 );
        	}
        	zSig1 |= ( ( rem1 | rem2 | rem3 ) != 0 );
    	}
    	dbl_shift64ExtraRightJamming( zSig0, zSig1, 0, 11, &zSig0, &zSig1, &zSig2 );
    	return roundAndPackDouble( zSign, zExp, zSig0, zSig1, zSig2 );
}  

/* returns the remainder of the double-precision floating-point value a with  respect
   to the double precision floating-point value b */
double _d_rem(double a, double b)
{
    	long aSign, bSign, zSign;
    	long aExp, bExp, expDiff;
    	unsigned long aSig0, aSig1, bSig0, bSig1, q, term0, term1, term2;
    	unsigned long allZero, alternateASig0, alternateASig1, sigMean1;
    	long sigMean0;
    	double z;

		int internal_ieee_exceptions = IEEE_No_Exception;


    	aSig1 = extractDoubleFrac1( a );
    	aSig0 = extractDoubleFrac0( a );
    	aExp = extractDoubleExp( a );
    	aSign = extractDoubleSign( a );
    	bSig1 = extractDoubleFrac1( b );
    	bSig0 = extractDoubleFrac0( b );
    	bExp = extractDoubleExp( b );
    	bSign = extractDoubleSign( b );
    	if ( aExp == 0x7FF )
    	{
        	if ( ( aSig0 | aSig1 ) || ( ( bExp == 0x7FF ) && ( bSig0 | bSig1 ) ) ) 
        	{
            		return propagateDoubleNaN( a, b );
        	}
        	goto invalid;
    	}
    	if ( bExp == 0x7FF )
    	{
        	if ( bSig0 | bSig1 ) return propagateDoubleNaN( a, b );
        	return a;
    	}
    	if ( bExp == 0 )
    	{
        	if ( ( bSig0 | bSig1 ) == 0 )
        	{
invalid:
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
            z = packDouble(1, 0x7FF, 0xFFFFF, 0xFFFFFFFF);
            return z;
        	}
        	normalizeDouble( bSig0, bSig1, &bExp, &bSig0, &bSig1 );
    	}
    	if ( aExp == 0 )
    	{
        	if ( ( aSig0 | aSig1 ) == 0 ) return a;
        	normalizeDouble( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
    	}
    	expDiff = aExp - bExp;
    	if ( expDiff < -1 ) return a;
    	dbl_shortShift64Left(aSig0 | 0x00100000, aSig1, 11 - ( expDiff < 0 ), &aSig0, &aSig1 );
    	dbl_shortShift64Left( bSig0 | 0x00100000, bSig1, 11, &bSig0, &bSig1 );
    	q = dbl_le64( bSig0, bSig1, aSig0, aSig1 );
    	if ( q ) dbl_sub64( aSig0, aSig1, bSig0, bSig1, &aSig0, &aSig1 );
    	expDiff -= 32;
    	while ( 0 < expDiff )
    	{
        	q = dbl_estimateDiv64To32( aSig0, aSig1, bSig0 );
        	q = ( 4 < q ) ? q - 4 : 0;
        	dbl_mul64By32To96( bSig0, bSig1, q, &term0, &term1, &term2 );
        	dbl_shortShift96Left( term0, term1, term2, 29, &term1, &term2, &allZero );
        	dbl_shortShift64Left( aSig0, aSig1, 29, &aSig0, &allZero );
        	dbl_sub64( aSig0, 0, term1, term2, &aSig0, &aSig1 );
        	expDiff -= 29;
    	}
   	if ( -32 < expDiff )
   	{
        	q = dbl_estimateDiv64To32( aSig0, aSig1, bSig0 );
        	q = ( 4 < q ) ? q - 4 : 0;
        	q >>= - expDiff;
        	dbl_shift64Right( bSig0, bSig1, 8, &bSig0, &bSig1 );
        	expDiff += 24;
        	if ( expDiff < 0 )
        	{
            		dbl_shift64Right( aSig0, aSig1, - expDiff, &aSig0, &aSig1 );
        	} else {
            		dbl_shortShift64Left( aSig0, aSig1, expDiff, &aSig0, &aSig1 );
        	}
        	dbl_mul64By32To96( bSig0, bSig1, q, &term0, &term1, &term2 );
        	dbl_sub64( aSig0, aSig1, term1, term2, &aSig0, &aSig1 );
    	} else {
        	dbl_shift64Right( aSig0, aSig1, 8, &aSig0, &aSig1 );
        	dbl_shift64Right( bSig0, bSig1, 8, &bSig0, &bSig1 );
    	}
    	do {
        	alternateASig0 = aSig0;
        	alternateASig1 = aSig1;
        	++q;
        	dbl_sub64( aSig0, aSig1, bSig0, bSig1, &aSig0, &aSig1 );
    	} while ( 0 <= (signed long) aSig0 );
    	dbl_add64(aSig0, aSig1, alternateASig0, alternateASig1, (unsigned long*)&sigMean0, &sigMean1 );
    	if (( sigMean0 < 0 )||( ( ( sigMean0 | sigMean1 ) == 0 ) && ( q & 1 ) ) ) 
    	{
        	aSig0 = alternateASig0;
        	aSig1 = alternateASig1;
    	}
   	zSign = ( aSig0 >> 31 );
    	if ( zSign ) dbl_sub64( 0, 0, aSig0, aSig1, &aSig0, &aSig1 );
    	return normalizeRoundAndPackDouble( aSign ^ zSign, bExp - 4, aSig0, aSig1 );
}

/* SQUARE ROOT */

/* returns the sqare root of the double-precision floating-point number a */
double _d_sqrt(double a)
{
   		int aSign;
    	long aExp, zExp;
    	unsigned long aSig0, aSig1, zSig0, zSig1, zSig2, doubleZSig0;
    	unsigned long rem0, rem1, rem2, rem3, term0, term1, term2, term3;
    	double z;
		
		int internal_ieee_exceptions = IEEE_No_Exception;

    	aSig1 = extractDoubleFrac1( a );
    	aSig0 = extractDoubleFrac0( a );
    	aExp = extractDoubleExp( a );
    	aSign = extractDoubleSign( a );
    	if ( aExp == 0x7FF )
    	{
        	if ( aSig0 | aSig1 ) return propagateDoubleNaN( a, a );
        	if ( ! aSign ) return a;
        	goto invalid;
    	}
    	if ( aSign )
    	{
        	if ( ( aExp | aSig0 | aSig1 ) == 0 ) return a;
invalid:
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
        	z = packDouble(1, 0x7FF, 0xFFFFF, 0xFFFFFFFF);
        	return z;
    	}
    	if ( aExp == 0 )
    	{
        	if ( ( aSig0 | aSig1 ) == 0 ) return packDouble( 0, 0, 0, 0 );
        	normalizeDouble( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
    	}
    	zExp = ( ( aExp - 0x3FF )>>1 ) + 0x3FE;
    	aSig0 |= 0x00100000;
    	dbl_shortShift64Left( aSig0, aSig1, 11, &term0, &term1 );
    	zSig0 = ( dbl_estimateSqrt32( aExp, term0 )>>1 ) + 1;
    	if ( zSig0 == 0 ) zSig0 = 0x7FFFFFFF;
    	doubleZSig0 = zSig0 + zSig0;
    	dbl_shortShift64Left( aSig0, aSig1, 9 - ( aExp & 1 ), &aSig0, &aSig1 );
    	dbl_mul32To64( zSig0, zSig0, &term0, &term1 );
    	dbl_sub64( aSig0, aSig1, term0, term1, &rem0, &rem1 );
    	while ( (rem0 & 0x80000000) != 0 )
    	{
        	--zSig0;
        	doubleZSig0 -= 2;
        	dbl_add64( rem0, rem1, 0, doubleZSig0 | 1, &rem0, &rem1 );
    	}
    	zSig1 = dbl_estimateDiv64To32( rem1, 0, doubleZSig0 );
    	if ( ( zSig1 & 0x1FF ) <= 5 )
    	{
        	if ( zSig1 == 0 ) zSig1 = 1;
        	dbl_mul32To64( doubleZSig0, zSig1, &term1, &term2 );
        	dbl_sub64( rem1, 0, term1, term2, &rem1, &rem2 );
        	dbl_mul32To64( zSig1, zSig1, &term2, &term3 );
        	dbl_sub96( rem1, rem2, 0, 0, term2, term3, &rem1, &rem2, &rem3 );
        	while ( (rem1 & 0x80000000) != 0 ){
            --zSig1;
            dbl_shortShift64Left( 0, zSig1, 1, &term2, &term3 );
            term3 |= 1;
            term2 |= doubleZSig0;
            dbl_add96( rem1, rem2, rem3, 0, term2, term3, &rem1, &rem2, &rem3 );
        }  
        zSig1 |= ( ( rem1 | rem2 | rem3 ) != 0 );
    }
    dbl_shift64ExtraRightJamming( zSig0, zSig1, 0, 10, &zSig0, &zSig1, &zSig2 );
    return roundAndPackDouble( 0, zExp, zSig0, zSig1, zSig2 );
}

/* COMPARISONS */

/* performs an unordered comparison of the double precision floating-point values
   a and b and sets the T bit if they are equal, clears the T bit otherwise */
int ARTEQF64(double a, double b)
{
	unsigned long aLow, bLow;
	long aHigh, bHigh;
	long long temp;
	int internal_ieee_exceptions = IEEE_No_Exception;
	    

   	if( Db_isNaN(a) || Db_isNaN(b))
	{
		internal_ieee_exceptions = IEEE_Signaling_Nan;
		IEEE_Exceptions |= internal_ieee_exceptions;
		if(EnableFPExceptions & internal_ieee_exceptions)
			raise(SIGFPE);

		//clearSRbit(2);
		return 0;
	}
    	
    aHigh = Db_get_msb(a);
    aLow = Db_get_lsb(a);
	bHigh = Db_get_msb(b);
	bLow = Db_get_lsb(b);    	
	
   	if ( (aLow == bLow) && ((aHigh == bHigh)||((aLow == 0)&&( (unsigned long)((aHigh|bHigh)<<1 ) == 0 ))) )
   	{
    		//setSRbit(2);
    		return 1;
   	}
   	else
   	{
    		//clearSRbit(2);
    		return 0;
   	}
}

/* performs an ordered comparison of the double precision floating-point values a and b
   sets the T bit a is less than or equal to b, clears the T bit otherwise */
int ARTLEF64(double a, double b)   
{
    long aSign, bSign;
	unsigned long aLow, bLow;
	long aHigh, bHigh;
	long long temp;
	int internal_ieee_exceptions = IEEE_No_Exception;
	    

	   	if( Db_isNaN(a) || Db_isNaN(b))
    	{
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);

    		//clearSRbit(2);
    		return 0;
    	}
    	
    aHigh = Db_get_msb(a);
    aLow = Db_get_lsb(a);
	bHigh = Db_get_msb(b);
	bLow = Db_get_lsb(b);    	
   	aSign = extractDoubleSign(a);
   	bSign = extractDoubleSign(b);
    
    	if (aSign != bSign)
    	{
        	if(aSign||((((unsigned long)((aHigh | bHigh )<<1 ) ) | aLow | bLow )==0))
        	{
        		//setSRbit(2);
        		return 1;
        	}
        	else
        	{
        		//clearSRbit(2);
        		return 0;
        	}
    	}


    	if(aSign) {
    		if (dbl_le64(bHigh, bLow, aHigh, aLow )) // lt64 ???
    		{
    			//setSRbit(2);
    			return 1;
    		}
    		else 
    		{
    			//clearSRbit(2);
    			return 0;
    		}
    	} 
  
    	if (dbl_le64( aHigh, aLow, bHigh, bLow )) 
    	{
    	       	//setSRbit(2);
    	       	return 1;
    	}
    	else 
    	{
    		//clearSRbit(2);
    		return 0;
    	}
}
/* performs an ordered comparison of the two double-precision floating-point values
   a and b, sets the T bit if a is less than b, clears the T bit otherwise */
int ARTLTF64(double a, double b)   
{
    long aSign, bSign;
	unsigned long aLow, bLow;
	long aHigh, bHigh;
	long long temp;
	int internal_ieee_exceptions = IEEE_No_Exception;
	    

	   	if( Db_isNaN(a) || Db_isNaN(b))
    	{
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);

    		//clearSRbit(2);
    		return 0;
    	}
    	
    aHigh = Db_get_msb(a);
    aLow = Db_get_lsb(a);
	bHigh = Db_get_msb(b);
	bLow = Db_get_lsb(b);    	
   	aSign = extractDoubleSign(a);
   	bSign = extractDoubleSign(b);

    	if ( aSign != bSign ) {
    		if ( aSign && ( ( ((unsigned long)((aHigh|bHigh) <<1)) |aLow|bLow) !=0 ) )
    		{
    			//setSRbit(2);
    			return 1;
    		}
        	else
        	{
        	    //clearSRbit(2);
        	    return 0;
        	}
    	}
    	

    	if(aSign) {
    		if (dbl_lt64(bHigh, bLow, aHigh, aLow )) 
    		{
    			//setSRbit(2);
    			return 1;
    		}
    		else
    		{
    			//clearSRbit(2);
    			return 0;
    		}
    	} 

    	if (dbl_lt64( aHigh, aLow, bHigh, bLow ))
    	{
        	//setSRbit(2);
        	return 1;
    	}
    	else
    	{
        	//clearSRbit(2);
        	return 0;
    	}
}

/* performs an unordered comparison of the double-precision floating-point values
   a and b, sets the T bit if the two values are unordered or not equal, clears the 
   T bit otherwise */
int ARTNEF64(double a, double b)
{
	unsigned long aLow, bLow;
	long aHigh, bHigh;
	long long temp;
	int internal_ieee_exceptions = IEEE_No_Exception;
	    
        	

	   	if( Db_isNaN(a) || Db_isNaN(b))
    	{
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);

    		//setSRbit(2);
    		return 1;
    	}
    	
    aHigh = Db_get_msb(a);
    aLow = Db_get_lsb(a);
	bHigh = Db_get_msb(b);
	bLow = Db_get_lsb(b);    	
  	  	
    	if ( (aLow == bLow) && ((aHigh == bHigh)||((aLow == 0)&&((unsigned long)((aHigh|bHigh)<<1 ) == 0 ))) )
    	{
    		//clearSRbit(2);
    		return 0;
    	}
    	else
    	{
        	//setSRbit(2);
        	return 1;
    	}
}  

/* performs an ordered comparison of the double precision floating-point values a and b
   sets the T bit if a is greater than or equal to b, clears the T bit otherwise */
int ARTGEF64(double a, double b)
{
    long aSign, bSign;
	unsigned long aLow, bLow;
	long aHigh, bHigh;
	long long temp;
	int internal_ieee_exceptions = IEEE_No_Exception;
	        	

	   	if( Db_isNaN(a) || Db_isNaN(b))
    	{
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);

    		//clearSRbit(2);
    		return 0;
    	}
    	
    aHigh = Db_get_msb(a);
    aLow = Db_get_lsb(a);
	bHigh = Db_get_msb(b);
	bLow = Db_get_lsb(b);    	
   	aSign = extractDoubleSign(a);
   	bSign = extractDoubleSign(b);
    
    	if (aSign != bSign)
    	{
        	if(bSign||((((unsigned long)((aHigh | bHigh )<<1 ) ) | aLow | bLow )==0))
        	{
           		//setSRbit(2);
           		return 1;
        	}
    		else
    		{
        		//clearSRbit(2);
        		return 0;
    		}
    	}


    	if(aSign) {
    		if (dbl_ge64(bHigh, bLow, aHigh, aLow )) // lt64 ???
    		{
        		//setSRbit(2);
        		return 1;
    		}
    		else
    		{
        		//clearSRbit(2);
        		return 0;
    		}
    		return;
    	} 

    	if (dbl_ge64( aHigh, aLow, bHigh, bLow )) {
        	//setSRbit(2);
        	return 1;
    	} else {
        	//clearSRbit(2);
        	return 0;
    	}
}      

/* performs an ordered comparison of the double precision floating-point values a and b
   sets the T bit if a is greater than b and clears the T bit otherwise */   
int ARTGTF64(double a, double b)
{
    long aSign, bSign;
	unsigned long aLow, bLow;
	long aHigh, bHigh;
	long long temp;
	int internal_ieee_exceptions = IEEE_No_Exception;
	    

	   	if( Db_isNaN(a) || Db_isNaN(b))
    	{
			internal_ieee_exceptions = IEEE_Signaling_Nan;
			IEEE_Exceptions |= internal_ieee_exceptions;
			if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);

    		//clearSRbit(2);
    		return 0;
    	}
    	
    aHigh = Db_get_msb(a);
    aLow = Db_get_lsb(a);
	bHigh = Db_get_msb(b);
	bLow = Db_get_lsb(b);    	
   	aSign = extractDoubleSign(a);
   	bSign = extractDoubleSign(b);
    	
    	if ( aSign != bSign ) {
    		if (bSign &&  ( (((aHigh|bHigh) << 1)|aLow|bLow) != 0 ) )
        	{
        	       	//setSRbit(2);
        	       	return 1;
        	} else {
        	       	//clearSRbit(2);
        	       	return 0;
        	}
	   	}
    	

    	if(aSign) {
    		if (dbl_gt64(bHigh, bLow, aHigh, aLow )) { 
    			//setSRbit(2);
    			return 1;
    		} else {
      			//clearSRbit(2);
      			return 0;
    		}
    	} 

    	if (dbl_gt64( aHigh, aLow, bHigh, bLow )) {
    		//setSRbit(2);
    		return 1;
    	} else {
    		//clearSRbit(2);
    		return 0;
    	}
}



