
/* *** Copyright Freescale Semiconductor, Inc, 2005 *** */

#include "prototype.h"

UWord32 LL_get_lsb(Int64 Val)
{
	return (Val>>32);
}

Word32 LL_get_msb(Int64 Val)
{
	return Val;
}

Word32 Db_get_msb(double Val)
{
	union {
		Int64 L;
		double D;
	} X;
	X.D = Val;

	return (X.L>>32);
}

UWord32 Db_get_lsb(double Val)

{
	union {
		Int64 L;
		double D;
	} X;
	X.D = Val;
	return  (X.L);
}

Int64 Db_to_LL(double Val)

{
	union {
		Int64 L;
		double D;
	} X;
	X.D = Val;
	return  (X.L);
}

double LL_to_Db(Int64 Val)

{
	union {
		Int64 L;
		double D;
	} X;
	X.L = Val;
	return  (X.D);
}


/*___________________________________________________________________________
 |                                                                           |
 |   Function Name : norm_l                                                  |
 |                                                                           |
 |   Purpose :                                                               |
 |                                                                           |
 |   Produces the number of left shifts needed to normalize the 32 bit varia-|
 |   ble L_var1 for positive values on the interval with minimum of          |
 |   1073741824 and maximum of 2147483647, and for negative values on the in-|
 |   terval with minimum of -2147483648 and maximum of -1073741824; in order |
 |   to normalize the result, the following operation must be done :         |
 |                   norm_L_var1 = L_shl(L_var1,norm_l(L_var1)).             |
 |                                                                           |
 |   Complexity weight : 30                                                  |
 |                                                                           |
 |   Inputs :                                                                |
 |                                                                           |
 |    L_var1                                                                 |
 |             32 bit long signed integer (Word32) whose value falls in the  |
 |             range : 0x8000 0000 <= var1 <= 0x7fff ffff.                   |
 |                                                                           |
 |   Outputs :                                                               |
 |                                                                           |
 |    none                                                                   |
 |                                                                           |
 |   Return Value :                                                          |
 |                                                                           |
 |    var_out                                                                |
 |             16 bit short signed integer (Word16) whose value falls in the |
 |             range : 0x0000 0000 <= var_out <= 0x0000 001f.                |
 |___________________________________________________________________________|
*/

Word16 norm_l (Word32 L_var1)
{
    Word16 var_out;

    if (L_var1 == 0)
    {
        var_out = 0;
    }
    else
    {
        if (L_var1 == (Word32) 0xffffffffL)
        {
            var_out = 31;
        }
        else
        {
            if (L_var1 < 0)
            {
                L_var1 = ~L_var1;
            }
            for (var_out = 0; L_var1 < (Word32) 0x40000000L; var_out++)
            {
                L_var1 <<= 1;
            }
        }
    }

    return (var_out);
}