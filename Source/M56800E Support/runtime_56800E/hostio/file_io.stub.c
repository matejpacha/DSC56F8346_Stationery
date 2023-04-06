



/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/



#include "file_io.h"


typedef struct 
{
	/* change these members to whatever is appropriate */
	short	refnum;
	void *	spec;
} temp_file_info;


static temp_file_info	temp_info[FOPEN_MAX];

static temp_file_info * find_temp_info(short refnum)
{
	int								i;
	temp_file_info *	p;
	
	for (i = 0, p = temp_info; i < FOPEN_MAX; i++, p++)
		if (p->refnum == refnum)
			return(p);
	
	return(0);
}


int __open_temp_file(__file_handle * handle)
{
	char					temp_name[L_tmpnam];
	temp_file_info *		info;
	void *					spec;
	int						ioresult;
	
	__temp_file_name(temp_name, &spec);
	
	if (!(info = find_temp_info(0)))
		return(__io_error);
	
	ioresult = __open_file(temp_name, __temp_file_mode, handle);
	
	if (ioresult == __no_io_error)
	{
		info->refnum = *handle;
		info->spec   = spec;
	}
	
	return(ioresult);
}


void __temp_file_name(char * name_str, void * filespec)
{
	// copy the temp file's name into name_str and
	// the file specification structure into filespec
}

int __delete_file(const char * name)
{
	return(__no_io_error); 	// Replace this with an OS call
							// that deletes the file.
}

int __rename_file(const char * old_name, const char * new_name)
{
	return(__no_io_error); 	// Replace this with an OS call
							// that renames the file.
}
