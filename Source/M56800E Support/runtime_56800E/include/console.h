




/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/

 /*	include file for console print through debugger
 */

#if defined(__cplusplus)
#include <stdlib.h>
#endif

#include <size_t.h>

int		printf_console(const char * , ...);
void	fflush_console();



unsigned int __consolewrite(const void * ptr, size_t num_memb);

void * __ConsoleWrite(void *File, const char * Buffer, size_t NumChars);
