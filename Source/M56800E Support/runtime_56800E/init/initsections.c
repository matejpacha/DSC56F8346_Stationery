



/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/



extern unsigned char	_start_bss;
extern unsigned char	_end_bss;


#include <string.h>
void __init_sections(void) {

		/* Initialize BSS section to 0 */

	memset ((void*)(&_start_bss), 0, (size_t)((char *)(&_end_bss) - (char *)(&_start_bss)) );
}