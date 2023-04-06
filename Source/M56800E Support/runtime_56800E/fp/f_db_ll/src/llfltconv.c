/* *** Copyright Freescale Semiconductor, Inc, 2005 *** */ 
    
/* long long to float/double conversion */
#include "fltutil.h"
#include "prototype.h"
#include "dblutil.h"

#include <signal.h>
#include <float.h>    
                                    
static int __clz64(long long x)
{
	int count;
	int i;
	unsigned long long mask;
	long long y;

	count = 0;
	mask = (unsigned long long)0x8000000000000000LL;
	for(i = 0; i < 64; i++)
	{
		y = x & mask;
		if(y == 0)
		{
			count++;
		}
		else
			break;

		x = x << 1;
	}

	return count;
}  

  
/* long long to double precision floating point */
double ARTS64_TO_F64(long long a)
{	   
	int zSign;

	if (a == 0) 
    	return packDouble( 0, 0, 0, 0 );
	if (a == 0x8000000000000000LL) 
	       	return packDouble(1, 0x43e, 0, 0);
	
	zSign = (a<0);
	a = zSign ? - a : a ;
	return normalizeRoundAndPackDouble(zSign, 0x432, 
				(unsigned long)LL_get_msb(a), (unsigned long)LL_get_lsb(a));
}
   

/* unsigned long long to double precision floating point */
double ARTU64_TO_F64(unsigned long long a)
{
	if (a == 0) 
        	return packDouble( 0, 0, 0, 0 );        
    return normalizeRoundAndPackDouble( 0, 0x432, 
    		(unsigned long)LL_get_msb(a), (unsigned long)LL_get_lsb(a));
}
  

/* double precision floating point to long long */
long long ARTF64_TO_LL64(double a)
{
		int aSign;
    	int aExp, shiftCount;
    	unsigned long long aSig;
    	long long z;
    	unsigned long long temp;
    	unsigned long aHigh, aLow;
    	int internal_ieee_exceptions = IEEE_No_Exception;
    	

    	/* extract high and low parts of the double precision number */
    	aLow = (unsigned long)Db_get_lsb(a);
    	aHigh = (unsigned long)Db_get_msb(a);

    	aSig = (((unsigned long long)extractDoubleFrac0(a)) << 32) + extractDoubleFrac1(a);
    	aExp = extractDoubleExp(a);
    	aSign = extractDoubleSign(a);
    	if ( aExp )
    		aSig |= 0x0010000000000000LL;
    	
       	shiftCount = aExp - 0x433;
    	if ( 0 <= shiftCount )
    	{
        	if ( 0x43E <= aExp )
        	{
            		if ( aHigh != 0xC3E00000 || aLow!=0 )
            		{
            			internal_ieee_exceptions = IEEE_Signaling_Nan;
                		IEEE_Exceptions |= internal_ieee_exceptions;
                		if(EnableFPExceptions & internal_ieee_exceptions)
                			raise(SIGFPE);
						if (!aSign||((aExp == 0x7FF )&&(aSig!=0x0010000000000000LL)))
                			return 0x7FFFFFFFFFFFFFFFLL;
                		
            		}
            		return (signed long long) 0x8000000000000000LL;
        	}
        	z = aSig<<shiftCount;
    	}
    	else
    	{
        	if ( aExp < 0x3FE )
        			return 0;
        	
        	z = aSig>>( - shiftCount );
    	}
    	if ( aSign ) z = - z;
    	return z;
}
    

/* double precision floating point to unsigned long long */
unsigned long long ARTF64_TO_ULL64(double a)
{
    	int aSign;
    	int aExp, shiftCount;
    	unsigned long long aSig;
    	unsigned long long z;
    	unsigned long long temp;
    	long long zi;
    	
    	int internal_ieee_exceptions = IEEE_No_Exception;
    	


   	aSig = (((unsigned long long)(extractDoubleFrac0(a))) << 32) + extractDoubleFrac1(a);
   	aExp = extractDoubleExp(a);
   	aSign = extractDoubleSign(a);
    
    	if (aSign)
    	{
        	if (aExp==0x7FF && aSig)
        	{
        		internal_ieee_exceptions = IEEE_Signaling_Nan;
           		IEEE_Exceptions |= internal_ieee_exceptions;
           		if(EnableFPExceptions & internal_ieee_exceptions)
           			raise(SIGFPE);
           		return 0xFFFFFFFFFFFFFFFFLL;
        	}
		zi = ARTF64_TO_LL64(a);
		return (unsigned long long)zi;
		//return 0;
    	}
    
    	if ( aExp )
    		aSig |= 0x0010000000000000LL;
    	shiftCount = aExp - 0x433;
    	if ( 0 <= shiftCount )
    	{
        	if ( 0x43E < aExp )
        	{
        		internal_ieee_exceptions = IEEE_Signaling_Nan;
			        	
            	IEEE_Exceptions |= internal_ieee_exceptions;
            	if(EnableFPExceptions & internal_ieee_exceptions)
            		raise(SIGFPE);
            	return 0xFFFFFFFFFFFFFFFFLL;
        	}
        	z = aSig<<shiftCount;
    	}
    	else 
    	{
        	if ( aExp < 0x3FE )
       		return 0;

        	z = aSig>>( - shiftCount );
    	}
    	return z;
}
     

/* long long to single-precision floating point	 */
float ARTLL64_TO_F32(long long a)
{
  		int zSign;
   		unsigned long long absA;
    	int shiftCount;
    	unsigned long normA0,normA1;    
    	unsigned long res;
	
	   	if (a == 0) return 0;
    	zSign = (a < 0);
    	absA = zSign ? - a : a; 
    	shiftCount = __clz64(absA) - 40;
    	if (0 <= shiftCount)
    	{
        	return packFloat(zSign, 0x95-shiftCount, 
        			(unsigned long)LL_get_lsb(absA<<shiftCount));
    	}
    	else
    	{   
        	shiftCount += 7;
        	if (shiftCount < 0)
        		dbl_shift64RightJamming((unsigned long)LL_get_msb(absA), (unsigned long)LL_get_lsb(absA), 
        									-shiftCount, &normA0, &normA1);
        	else
        		normA1 = (unsigned long)LL_get_lsb(absA<<shiftCount);
       		return roundAndPackFloat( zSign, 0x9C - shiftCount, normA1 );
    	}
}

/* unsigned long long to single-precision floating point */
float ARTULL64_TO_F32(unsigned long long a)
{
 	int shiftCount;
    unsigned long normA0, normA1;    
    unsigned long res;

	if (a == 0) return 0;
	shiftCount = __clz64(a) - 40;
	if ( 0 <= shiftCount ) 
	{
    	return packFloat( 0, 0x95 - shiftCount, (unsigned long)a<<shiftCount );
	}
	else 
	{
    	shiftCount += 7;
    	if ( shiftCount < 0 )
    	{
        		dbl_shift64RightJamming((unsigned long)(a>>32), (unsigned long)a, 
        					- shiftCount, &normA0, &normA1);
    	}
    	else
    	{
        		normA1 = (unsigned long)a << shiftCount;
    	}
    	return roundAndPackFloat( 0, 0x9C - shiftCount, normA1 );
	}
}

/* single precision floating point to long long */
long long ARTF32_TO_LL64(float a)
{
    	int aSign;
    	int aExp, shiftCount;
    	unsigned long aSig;
    	unsigned long long aSig64;
    	long long z;
    	unsigned long long temp;
		int internal_ieee_exceptions = IEEE_No_Exception;

	   	aSig = extractFloatFrac(a);
    	aExp = extractFloatExp(a);
    	aSign = extractFloatSign(a);
    	shiftCount = aExp - 0xBE;
    	if ( 0 <= shiftCount ) 
    	{
        	if ( a != 0xDF000000 ) 
        	{
        		internal_ieee_exceptions = IEEE_Signaling_Nan;
            		IEEE_Exceptions |= internal_ieee_exceptions;
            		if(EnableFPExceptions & internal_ieee_exceptions)
						raise(SIGFPE);
            		if (!aSign || ( (aExp == 0xFF) && aSig ) ) 
            			return 0x7FFFFFFFFFFFFFFFLL;
        	}
        	return  0x8000000000000000LL;
    	}
    	else if ( aExp <= 0x7E )
    	{
        	return 0;
    	}
    	aSig64 = aSig | 0x00800000;
    	aSig64 = aSig64 << 40;
    	z = aSig64>>( - shiftCount );
    	if ( aSign ) z = - z;
    	return z;
}           
           
/* single precision floating point to unsigned long long */
unsigned long long ARTF32_TO_ULL64(float a)
{
   		int aSign;
    	int aExp, shiftCount;
    	unsigned long aSig;
    	unsigned long long aSig64;
    	unsigned long long z;
    	unsigned long long temp;
    	long long zi;
		int internal_ieee_exceptions = IEEE_No_Exception;
		
    	aSig = extractFloatFrac(a);
    	aExp = extractFloatExp(a);
    	aSign = extractFloatSign(a);

    	if (aSign)
    	{
        	if (aExp==0xFF && aSig)
        	{
        		internal_ieee_exceptions = IEEE_Signaling_Nan;
            		IEEE_Exceptions |= internal_ieee_exceptions;
            		if(EnableFPExceptions & internal_ieee_exceptions)
						raise(SIGFPE);
           		return 0xFFFFFFFFFFFFFFFFLL;
        	}
        	zi = ARTF32_TO_LL64(a);
        	return (unsigned long long)zi;
        	//return 0;
    	}
    	shiftCount = aExp - 0xBE;
    	if ( 0 == shiftCount )
    	{
        	aSig64 = aSig | 0x00800000;
        	return aSig64 <<= 40;
    	}
    	else if ( 0 < shiftCount )
    	{
			internal_ieee_exceptions = IEEE_Signaling_Nan;
		    	
        	IEEE_Exceptions |= internal_ieee_exceptions;
        	if(EnableFPExceptions & internal_ieee_exceptions)
				raise(SIGFPE);
        	return 0xFFFFFFFFFFFFFFFFLL;
    	}
    	else if ( aExp <= 0x7E )
    	{
        	return 0;
    	}
    	aSig64 = aSig | 0x00800000;
    	aSig64 <<= 40;
    	z = aSig64>>( - shiftCount );
    	return z;
}


