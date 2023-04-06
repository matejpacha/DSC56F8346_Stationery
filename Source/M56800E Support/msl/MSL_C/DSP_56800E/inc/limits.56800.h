/* MSL
 * Copyright ©1995-2006 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2005/12/09 02:02:45 $
 * $Revision: 1.5 $
 */

/*
 *	limits.be.h
 *	
 */
 
#define ARG_MAX             (128*1024)
#define CHILD_MAX	        	(666)
#define LINK_MAX            (1)
#define MAX_CANON           (255)
#define MAX_INPUT           (255)
#define NAME_MAX            (64)
#define NGROUPS_MAX         (32)
#define OPEN_MAX            (32)
#define PATH_MAX            (1024)  /* really it's infinite though */
#define PIPE_MAX            (512)
#define SSIZE_MAX           (32767)
#define TZNAME_MAX          (32)

#define _POSIX_ARG_MAX      ARG_MAX
#define _POSIX_CHILD_MAX    CHILD_MAX
#define _POSIX_LINK_MAX     LINK_MAX
#define _POSIX_MAX_CANON    MAX_CANON
#define _POSIX_MAX_INPUT    MAX_INPUT
#define _POSIX_NAME_MAX     NAME_MAX
#define _POSIX_NGROUPS_MAX  NGROUPS_MAX
#define _POSIX_OPEN_MAX     OPEN_MAX
#define _POSIX_PATH_MAX     PATH_MAX
#define _POSIX_PIPE_MAX     PIPE_MAX
#define _POSIX_SSIZE_MAX    SSIZE_MAX
#define _POSIX_TZNAME_MAX   TZNAME_MAX
