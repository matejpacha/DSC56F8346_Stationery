/* ******************************************************************************* */

/* LONG LONG INTRINSICS */

#include <div_int.h>

#define Intrinsic_Word16 short
#define Intrinsic_Word32 long
#define Intrinsic_Word64 long long
#define Word16 Intrinsic_Word16
#define Word32 Intrinsic_Word32
#define Word64 Intrinsic_Word64

#pragma slld on

#pragma mark <<<<<< Macros >>>>>>
#define LL_abs(a)				__LL_abs(a)
#define LL_negate(a)			__LL_negate(a)
#define LL_add(a,b)  			__LL_add(a,b)
#define LL_sub(a,b)  			__LL_sub(a,b)
#define LL_deposit_h(a)			__LL_deposit_h(a)
#define LL_deposit_l(a)			__LL_deposit_l(a)
#define LL_extract_h(a)			__LL_extract_h(a)
#define LL_extract_l(a)			__LL_extract_l(a)
#define LL_LL_mult_int(a,b)		__LL_LL_mult_int(a,b)
#define LL_mult_int(a,b)		__LL_mult_int(a,b)
#define LL_LL_mac_int(a,b,c)	__LL_LL_mac_int(a,b,c)
#define LL_mac_int(a,b,c)		__LL_mac_int(a,b,c)
#define LL_msu_int(a,b,c)		__LL_msu_int(a,b,c)
#define LL_LL_msu_int(a,b,c)	__LL_LL_msu_int(a,b,c)
#define LL_mult_ls_int(a,b)		__LL_mult_ls_int(a,b)
#define LL_LL_mult(a,b)			__LL_LL_mult(a,b)
#define LL_mult(a,b)			__LL_mult(a,b)
#define LL_LL_mac(a,b,c)		__LL_LL_mac(a,b,c)
#define LL_mac(a,b,c)			__LL_mac(a,b,c)
#define LL_msu(a,b,c)			__LL_msu(a,b,c)
#define LL_LL_msu(a,b,c)		__LL_LL_msu(a,b,c)
#define LL_mult_ls(a,b)			__LL_mult_ls(a,b)
#define LL_round(a)				__LL_round(a)
#define LL_div(a,b)  			__LL_div(a,b)
#define LL_div_int(a,b)  		__LL_div_int(a,b)
#define LL_div_s4q_int(a,b)  	__LL_div_s4q_int(a,b)

#pragma mark -
#pragma mark <<<< Long Long Intrinsics >>>>


#pragma mark <deposit>

/* LL_DEPOSIT_H */
inline Word64 __LL_deposit_h(register Word32 lsrc)
{
/*  Defn: Deposits the 32-bit integer or fractional value
 *        into the upper 32-bits of a 64 bit value, and
 *        zeros out the lower 32-bits of a 64-bit value.
 */
	union un
	{
		long long ull;
		struct
		{
			long l1;
			long l2;
		};
	};

	union un my_union;

	my_union.l1 = 0;
	my_union.l2 = lsrc;

	return my_union.ull;
}



/* LL_DEPOSIT_L */
inline Word64 __LL_deposit_l(register Word32 lsrc)
{
/*  Defn: Deposits the 32-bit integer or fractional value
 *        into the lower 32-bits of a 64 bit value, and
 *        sign extends the upper 32-bits of a 64-bit value.
 */
	union un
	{
		long long ull;
		struct
		{
			long l1;
			long l2;
		};
	};

	union un my_union;

	my_union.l1 = lsrc;
	// Sign extend the upper 32-bits of the 64-bit long long value.
	//my_union.l2 = 0;
	if(lsrc & 0x80000000)
		my_union.l2 = ~0;
	else
		my_union.l2 = 0;

	return my_union.ull;
}

#pragma mark <extract>

/* LL_EXTRACT_H */
inline Word32 __LL_extract_h(register Word64 llsrc)
{
/*  Defn: Extracts the 32 MSBs of a 64-bit integer or fractional value.
 *        Returns a 32-bit value.
 */
	union un
	{
		long long ull;
		struct
		{
			long l1;
			long l2;
		};
	};

	union un my_union;

	my_union.ull = llsrc;

	return my_union.l2;
}



/* LL_EXTRACT_L */
inline Word32 __LL_extract_l(register Word64 llsrc)
{
/*  Defn: Extracts the 32 LSBs of a 64-bit integer or fractional value.
 *        Returns a 32-bit value.
 */
	union un
	{
		long long ull;
		struct
		{
			long l1;
			long l2;
		};
	};

	union un my_union;

	my_union.ull = llsrc;

	return my_union.l1;
}

#pragma mark <abs/negate>

inline Word32 __L_abs_local(register Word32 lvar1)
{
   asm(.optimize_iasm on);
   asm(.iasm_sideeffects off; abs lvar1; .iasm_sideeffects on;);
   asm(.optimize_iasm off);
   return lvar1;
}


/* LL_ABS */
inline Word64 __LL_abs(register Word64 llvar)
{
/*
 *   Defn: Absolute value of a 64-bit integer or fractional value
 *         returning a 64-bit result.
 */
	union un
	{
		long long ull;
		struct
		{
			long l1;
			long l2;
		};
	};

	union un my_union;

	my_union.ull = llvar;

	/* return immediately if the value is positive */
    if ((my_union.l2 & 0x80000000) == 0x0)
	  return llvar;

	//call 64bit negate library when lower word is non-zero
	if (my_union.l1)
	  return ARTNEGLL64(llvar);

	// appropriate to call 'L_abs(higher word)' when lower word is zero (0Xxxxxxxxx00000000)
	my_union.l2 = __L_abs_local(my_union.l2);

	return my_union.ull;
}


/* LL_NEGATE */
inline Word64 __LL_negate(register Word64 llvar)
{
/*    Defn: Negates a 64-bit integer or fractional value
 *           returning a 64-bit result.
 */
	return ARTNEGLL64(llvar);
}



#pragma mark <add/sub>



/* LL_ADD */
inline Word64 __LL_add(register Word64 src_dst, register Word64 src2)
{
/*    Defn: Addition of two 64-bit integer or fractional values,
 *           returning a 64-bit result.
 */
	return ARTADDLL64(src_dst, src2);
}


/* LL_SUB */
inline Word64 __LL_sub(register Word64 src_dst, register Word64 src2)
{
/*    Defn: Subtraction of two 64-bit integer or fractional values,
 *           returning a 64-bit result.
 */
	return ARTSUBLL64(src_dst, src2);
}



#pragma mark <rounding>


/* LL_ROUND */
inline Word32 __LL_round(register Word64 llvar)
{
/*
 *	Defn: Rounds a 64-bit integer or fractional value. Returns a 32-bit value.
 */
	union un
	{
		long long ull;
		struct
		{
			long l1;
			long l2;
		};
	};

	union un my_union;

	my_union.ull = llvar;

	return my_union.l1;
}



#pragma mark <multiplication/int>




/* LL_LL_MULT_INT */
inline Word64 __LL_LL_mult_int(register Word64 sinp1, register Word64 sinp2)
{
/*  Defn: Multiply two 64-bit integer values
 *        generating a signed 64-bit integer result.
 */
	return ARTMULLL64(sinp1, sinp2);
}


/* LL_MULT_INT */
inline Word64 __LL_mult_int(register Word32 sinp1, register Word32 sinp2)
{
/*  Defn: Multiply two 32-bit integer values
 *        generating a signed 64-bit integer result.
 */

	Word64 op1 = sinp1, op2 = sinp2;

	return ARTMULLL64(op1, op2);
}

/* LL_LL_MAC_INT */
inline Word64 __LL_LL_mac_int(register Word64 laccum, register Word64 sinp1, register Word64 sinp2)
{
/*  Defn: Multiply two 64-bit integer values and add to 64-bit
 *        integer value, generating a 64-bit result.
 */

	Word64 result, temp;

	temp = ARTMULLL64(sinp1, sinp2);

	result = ARTADDLL64(laccum, temp);

	return result;
}


/* LL_MAC_INT */
inline Word64 __LL_mac_int(register Word64 laccum, register Word32 sinp1, register Word32 sinp2)
{
/*  Defn: Multiply two 32-bit integer values and add to 64-bit
 *        integer value, generating a 64-bit result.
 */

	Word64 result, temp;
	Word64 op1 = sinp1, op2 = sinp2;

	temp = ARTMULLL64(op1, op2);

	result = ARTADDLL64(laccum, temp);

	return result;
}

/* LL_MSU_INT */
inline Word64 __LL_msu_int(register Word64 laccum, register Word32 sinp1, register Word32 sinp2)
{
/*  Defn: Multiply two 32-bit integer values and subtract this product
 *        from a 64-bit integer value. Generates a 64-bit result.
 */

 	Word64 result, temp;
 	Word64 op1 = sinp1, op2 = sinp2;

 	temp = ARTMULLL64(op1, op2);

 	result = ARTSUBLL64(laccum, temp);

 	return result;

}


/* LL_LL_MSU_INT */
inline Word64 __LL_LL_msu_int(register Word64 laccum, register Word64 sinp1, register Word64 sinp2)
{
/*  Defn: Multiply two 64-bit integer values and subtract this product
 *        from a 64-bit integer value. Generates a 64-bit result.
 */

 	Word64 result, temp;

 	temp = ARTMULLL64(sinp1, sinp2);

 	result = ARTSUBLL64(laccum, temp);

 	return result;

}



/* LL_MULT_LS_INT */
inline Word64 __LL_mult_ls_int(register Word64 linp1, register Word32 sinp2)
{
/*
 *	Defn:	Multiply a 64-bit integer value with a 32-bit integer value,
 *			generating a 64-bit result.
 */

	Word64 op2 = sinp2;

	return ARTMULLL64(linp1, op2);
}



#pragma mark <multiplication/fract>


/* LL_LL_MULT */
inline Word64 __LL_LL_mult(register Word64 sinp1, register Word64 sinp2)
{
/*  Defn: Multiply two 64-bit fractional values
 *        generating a signed 64-bit fractional result.
 */
 	Word64 op1 = sinp1, op2 = sinp2;

	return (ARTMULLL64(op1, op2)<<1);//+0xC000000000000000;
}


/* LL_MULT */
inline Word64 __LL_mult(register Word32 sinp1, register Word32 sinp2)
{
/*  Defn: Multiply two 32-bit fractional values
 *        generating a signed 64-bit fractional result.
 */

	Word64 op1 = sinp1, op2 = sinp2;

	return ARTMULLL64(op1, op2)<<1;
}

/* LL_LL_MAC */
inline Word64 __LL_LL_mac(register Word64 laccum, register Word64 sinp1, register Word64 sinp2)
{
/*  Defn: Multiply two 64-bit fractional values and add to 64-bit
 *        fractional value, generating a 64-bit result.
 */

	Word64 result, temp;

	temp = ARTMULLL64(sinp1, sinp2)<<1;

	result = ARTADDLL64(laccum, temp);

	return result;
}


/* LL_MAC */
inline Word64 __LL_mac(register Word64 laccum, register Word32 sinp1, register Word32 sinp2)
{
/*  Defn: Multiply two 32-bit fractional values and add to 64-bit
 *        fractional value, generating a 64-bit result.
 */

	Word64 result, temp;
	Word64 op1 = sinp1, op2 = sinp2;

	temp = ARTMULLL64(op1, op2)<<1;

	result = ARTADDLL64(laccum, temp);

	return result;
}

/* LL_MSU */
inline Word64 __LL_msu(register Word64 laccum, register Word32 sinp1, register Word32 sinp2)
{
/*  Defn: Multiply two 32-bit fractional values and subtract this product
 *        from a 64-bit fractional value. Generates a 64-bit result.
 */

 	Word64 result, temp;
 	Word64 op1 = sinp1, op2 = sinp2;

 	temp = ARTMULLL64(op1, op2)<<1;

 	result = ARTSUBLL64(laccum, temp);

 	return result;

}


/* LL_LL_MSU */
inline Word64 __LL_LL_msu(register Word64 laccum, register Word64 sinp1, register Word64 sinp2)
{
/*  Defn: Multiply two 64-bit fractional values and subtract this product
 *        from a 64-bit fractional value. Generates a 64-bit result.
 */

 	Word64 result, temp;

 	temp = ARTMULLL64(sinp1, sinp2)<<1;

 	result = ARTSUBLL64(laccum, temp);

 	return result;

}


/* LL_MULT_LS */
inline Word64 __LL_mult_ls(register Word64 linp1, register Word32 sinp2)
{
/*
 *	Defn:	Multiply a 64-bit fractional value with a 32-bit fractional value,
 *			generating a 64-bit result.
 */

	Word64 op2 = sinp2;

	return ARTMULLL64(linp1, op2)<<1;
}


#pragma mark <division/int>

/* DIV_LL_INT */
inline Word64 __LL_div_int(register Word64 s_numerator, register Word64 s_denominator)
{
/* Defn: Single quadrant division (i.e. both operands positive) of
 *       two 64-bit integer values, returning a 64-bit result.
 */
	return ARTDIVULL64(s_numerator, s_denominator);
}

/* DIV_LL_S4Q_INT */
inline Word64 __LL_div_s4q_int(register Word64 s_numerator, register Word64 s_denominator)
{
/*	Defn:	Four quadrant division of a 64-bit integer divident and a
 *			64-bit integer divisor, returning a 64-bit result.
 */
	return ARTDIVLL64(s_numerator, s_denominator);
}

#pragma mark <division/fract>

/* DIV_LL */
inline Word32 __LL_div(register Word64 s_numerator, register Word32 s_denominator)
{
/* Defn: Single quadrant division (i.e. both operands positive) of
 *       one 64-bit fractional value and one 32-bit fractional value,
 *		 returning a 32-bit result.
 */
	return ARTDIV64(s_numerator, s_denominator);
}


/*
 ********************************************************************************
 */

