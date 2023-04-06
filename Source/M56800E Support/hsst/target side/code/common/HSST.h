/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/


#if ! defined ( __HSST )
#define __HSST



// commented out but left in for temporary continuity

// 030328 arden -- one cannot make assumptions about size_t
// size_t is different for hawk2 depending on SDM or LDM
// if this code is shared elsewhere, it may need product #if defines
//#if ! defined ( __SIZE_T )
//typedef unsigned int size_t;
//#define __SIZE_T
//#endif



// 030328 arden -- get def of size_t from MSL
#include "size_t.h"



typedef struct
{
    int _flag;   		    /* channel status */
    int _stream; 		    /* descriptor / channel id */
    size_t _cnt;			/* number of unsigned chars buffered */
    size_t _bufsiz;   		/* so buffer size be flexible */
    unsigned char* _buffer;	/* storage buffer */
    unsigned char* _ptr;	/* current pointer in buffer */
    
} HSST_STREAM;

#define	_HSST_BUFSIZ   256     /* default channel buffer size,
								   can be changed with HSST_setbuf() 
								*/
#define HSSTFBUF   0x0002     /* fully buffered data exchange mode */
#define HSSTNBUF   0x0004     /* unbuffered data exchange mode */

#if ! defined (NULL)
#define	NULL ((void*)0)
#endif

#ifndef EOF
#define EOF (-1)
#endif
 
#if ! defined (true)
#define true (1) 
#endif
#if ! defined (false)
#define false (0)
#endif

#if ! defined (bool)
typedef unsigned char bool;
#endif

/* FUNCTION PROTOTYPES */

HSST_STREAM*	HSST_open  ( const char *stream );
int				HSST_close ( HSST_STREAM *stream );

size_t			HSST_write ( void *data, size_t size, size_t nmemb, HSST_STREAM * stream );
size_t			HSST_read  ( void *data, size_t size, size_t nmemb, HSST_STREAM * stream );

size_t 			HSST_raw_write ( void *ptr, size_t length, HSST_STREAM *rs );
size_t 			HSST_raw_read  ( void *ptr, size_t length, HSST_STREAM *rs );

int 			HSST_flush   ( HSST_STREAM *stream );
int				HSST_setvbuf ( HSST_STREAM *rs, unsigned char *buf, int mode, size_t size );

int 			HSST_set_log_dir ( HSST_STREAM *stream, char *dir_name );

size_t			HSST_size ( HSST_STREAM *stream );


#endif




