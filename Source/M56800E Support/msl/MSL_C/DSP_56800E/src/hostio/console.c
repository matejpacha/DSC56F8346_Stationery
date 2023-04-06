/*  MSL
 *  Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 *  $Date: 2005/12/09 02:05:56 $
 *  $Revision: 1.7 $
 */

/*
 *	console.c
 *	
 *	
 *	Routines
 *	--------
 *		fwrite	- Only supports CONSOLE IO
 *		fread	- Only supports CONSOLE IO
 *
 */

// #if !_MSL_OS_DISK_FILE_SUPPORT



 #include <size_t.h>
 #include <stdio.h>
 
int __stdout_ready = 0;

size_t fwrite(const void * ptr, size_t memb_size, size_t num_memb, FILE * file)
{
	const char *write_ptr;
	size_t		num_bytes, bytes_to_go;
	
	if (num_memb == 0 || memb_size == 0)
		return(0);
		
	if (memb_size == 1)
		bytes_to_go = num_memb;
	else if (num_memb == 1)
		bytes_to_go = memb_size;
	else
		bytes_to_go = memb_size * num_memb;

	write_ptr = ptr;
	
	while (bytes_to_go)
	{
		if (EOF == __put_char(*write_ptr++, file)) {	/* Ran out of room? */
			return(num_memb - ((bytes_to_go+memb_size-1)/memb_size));
		}
		--bytes_to_go;
	}
	return(num_memb);	/* All the way through, must have written all the members */
}		


size_t fread(void * ptr, size_t memb_size, size_t num_memb, FILE * file)
{
	char 	*read_ptr;
	size_t	num_bytes, bytes_to_go, bytes_read;
	int		got_char=0;
	
	if (num_memb == 0 || memb_size == 0)
		return(0);
		
	if (memb_size == 1)
		bytes_to_go = num_memb;
	else if (num_memb == 1)
		bytes_to_go = memb_size;
	else
		bytes_to_go = memb_size * num_memb;

	read_ptr = ptr;
	
	while (bytes_to_go)
	{
		/*got_char = getc(file);*/
		if (EOF == got_char) {	/* Ran out of file? */
			return(num_memb - ((bytes_to_go+memb_size-1)/memb_size));
		}
		*read_ptr++ = got_char;
		--bytes_to_go;
	}
	return(num_memb);	/* All the way through, must have read all the members */
}

//#endif // if !_MSL_OS_DISK_FILE_SUPPORT