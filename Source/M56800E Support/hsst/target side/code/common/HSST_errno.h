
/*
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/


#ifndef _HSST_ERROR_H_
#define _HSST_ERROR_H_

/* This section is intended to be included by the host
   HSST. please note that all definitions must be kept consistent
 */

#define ENOHSSTERR 			0	/* no error */
#define EHSSTERR 			1   /* HSST error	*/
#define EHOSTMAILBOXDIRTY	2	/* more data available to be read by the target */
#define ETARGETMAILBOXDIRTY 3	/* more data available to be read by the host	*/
#define ENOHSSTMSG 			4	/* no data available */
#define ENOHSSTCHAN			5	/* invalid channel 	*/
#define ECANTOPENFILE		6	/* cannot open log file */
#define ECOMMERR			7	/* communication error */

extern int HSST_ERRNO;


#endif
