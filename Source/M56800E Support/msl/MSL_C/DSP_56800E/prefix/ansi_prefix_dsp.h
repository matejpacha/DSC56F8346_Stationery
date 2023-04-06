/* MSL
 * Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2013/02/19 12:34:43 $
 * $Revision: 1.45 $
 */

/*
    ansi_prefix_dsp.h

    this file is generalized in name for product-related path
    localization.
 */


#ifndef __ansi_prefix__
#define __ansi_prefix__

#include <os_enum.h>

/* jrusso 040109 - Protect against including wrong ansi_prefix_dsp.h -- really
	just a safeguard against a faulty layout */

#if defined (__m56800E__)

#define __dest_os __m56800E_os

#if __option(slld)
	#define _MSL_C99			1

	#define _MSL_LONGLONG 		1

    #define _MSL_DOUBLE_SIZE      64	/*- cc 011211 -*/

    #define _MSL_LONG_DOUBLE_SIZE 64	/*- cc 011211 -*/
#else
	#define _MSL_C99			0

	#define _MSL_LONGLONG 		0

    #define _MSL_DOUBLE_SIZE      32	/*- cc 011211 -*/

    #define _MSL_LONG_DOUBLE_SIZE 32	/*- cc 011211 -*/
#endif

#define _MSL_C_HAS_CPP_EXTENSIONS 1  /* Needed for the foof/fool versions of C89 math */

#define _MSL_USES_SUN_MATH_LIB 	1

#define _MSL_C99_MATH_LEAK 		1

#define _MSL_FLOAT_HEX			0

#define _MSL_C_LOCALE_ONLY		1

#define _MSL_WIDE_CHAR			0

#define _MSL_OS_TIME_SUPPORT	0

#define _MSL_CLOCK_T_AVAILABLE 	0

#define _MSL_TIME_T_AVAILABLE	1

#define _MSL_TM_STRUCT_AVAILABLE	1

#define _MSL_ASSERT_DISPLAYS_FUNC 0

#define _MSL_STRERROR_KNOWS_ERROR_NAMES 0

#define _MSL_OS_ALLOC_SUPPORT 	0

#ifndef _MSL_WEAK
	#define _MSL_WEAK
#endif

#ifndef _MSL_NORETURN
	#define _MSL_NORETURN
#endif

#if defined(__cplusplus) && __embedded_cplusplus == 0
    #define _MSL_USING_NAMESPACE

    #undef _MSL_LONGLONG
    #define _MSL_LONGLONG 1

    //#define _MSL_OS_DISK_FILE_SUPPORT 0
    #define  __ANSI_OVERLOAD__
#endif



#define _MSL_HEAP_EXTERN_PROTOTYPES \
	extern unsigned int _heap_addr[];	/* starting address for heap */ \
	extern unsigned int _heap_end[];	/* address after end byte of heap */

#define _MSL_HEAP_START _heap_addr
#define _MSL_HEAP_SIZE (2*(_heap_end - _heap_addr))  /* uses byte pointers */

#ifdef  _Old_DSP_IO_Interface
    #define _MSL_BUFFERED_CONSOLE 0
	/*#define _No_Disk_File_OS_Support*/ /* should now be _MSL_OS_DISK_FILE_SUPPORT */
	#define _MSL_OS_DISK_FILE_SUPPORT 0
	#define _MSL_NULL_CONSOLE_ROUTINES 1
#else
	#define _MSL_FILE_CONSOLE_ROUTINES 1
#endif

#define _MSL_CLASSIC_MALLOC

/************************************************************
 * Platform Specific Configuration:						    *
 * climits - Platform specific defines						*
 ************************************************************/

#define _CHAR_BIT             8
#define _SIZEOF_SHRT          2
#define _SIZEOF_INT           2
#define _SIZEOF_LONG          4

#if _MSL_LONGLONG
    #define _SIZEOF_LONG_LONG 8
#endif

#define _MSL_SIZEOF_INT 2

/************************************************************
 * Platform Specific Configuration:						    *
 * ansi_fp.h - Platform specific define of SIGDIGLEN		*
 ************************************************************/

#define _MSL_SIGDIGLEN		 20		/*- cc 011211 -*/

/************************************************************
 * Platform Specific Configuration:						    *
 * file_struct.h - Platform specific define of _MSL_BUFSIZ	*
 ************************************************************/

#define _MSL_BUFSIZ 		100		/*- cc 011024 -*/

/************************************************************
 * Platform Specific Configuration:						    *
 * msl_t.h - Platform specific define of _MSL_INT32_TYPE	*
 ************************************************************/

#define _MSL_INT32_TYPE 	long	/*- cc 011024 -*/

/************************************************************
 * Platform Specific Configuration:						    *
 * cfloat - Platform specific defines						*
 ************************************************************/



/********************************************************************************
 * Platform Specific Configuration:						    					*
 * cfloat - Platform specific define _MSL_OFFSETOF & _MSL_FLT_EVAL_METHOD		*
 ********************************************************************************/

#define _MSL_OFFSETOF(type, member)	((__std(size_t)) __offsetof(&(((type *) 0)->member)))
#define _MSL_FLT_EVAL_METHOD 0

#else
	#error "DSP device is not __m56800E__"
#endif /* defined(__m56800E__) */

#endif /* ifndef __ansi_prefix__ */

/* revision history:
 *
 * 981023 mm     -- Added fields to allow compilation
 * 010115 arden  -- generalized file name for folder-position identity
 * 010131 arden  -- _Old_DSP_IO_Interface-style hostio restored
 * 010928 arden  -- hawk-specific climits moved to this file
 * 011001 arden  -- reduced to hawk2-specific
 * 011024 cc	 -- Added define for _MSL_BUFSIZ and _MSL_INT32_TYPE
 * 011210 cc     -- Added define __div__
 * 011217 cc     -- Added _MSL_SIGDIGLEN
 * 011210 cc     -- Added _MSL_LONG_DOUBLE_SIZE & _MSL_DOUBLE_SIZE
 * 011217 cc     -- Added _MSL_OFFSETOF(type, member)
 * 020805 cc	 -- Changed pro 4 malloc to classic malloc
 * 021001 cc     -- Added _MSL_C_LOCALE_ONLY & _MSL_ASSERT_DISPLAYS_FUNC
 *                  & _MSL_STRERROR_KNOWS_ERROR_NAMES
 * JWW 030224 Changed __MSL_LONGLONG_SUPPORT__ flag into the new more configurable _MSL_LONGLONG
 * JWW 030224 Changed __NO_WIDE_CHAR flag into the new more configurable _MSL_WIDE_CHAR
 * cc  031106 Added _MSL_FLT_EVAL_METHOD define
 * cc  040217 Changed _No_Disk_File_OS_Support to _MSL_OS_DISK_FILE_SUPPORT
 * JWW 040401 Changed _No_Alloc_OS_Support to _MSL_OS_ALLOC_SUPPORT
 * JWW 040405 Changed _Unbuffered_Console to _MSL_BUFFERED_CONSOLE
 */