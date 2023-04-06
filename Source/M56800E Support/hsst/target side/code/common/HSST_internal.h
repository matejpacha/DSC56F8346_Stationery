

/* 
 MSL
 Copyright ©1995-2004 Freescale Corporation.  All rights reserved.
*/




#ifndef __HSST_INTERNAL_H__
#define __HSST_INTERNAL_H__

/* Use this file to declare the prototypes of functions that are target 
   specific, but called by common code. Also, put stuff here that is not
   appropriate for HSST.h.
*/

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include "HSST.h"

enum HSST_command 
{ 
  HSST_OPEN, 
  HSST_CLOSE, 
  HSST_READ, 
  HSST_WRITE, 
  HSST_ATTACH_LISTENER,
  HSST_LOG_DIRECTORY,
  HSST_RAW_WRITE,
  HSST_RAW_READ,
  HSST_SIZE
};

#define _HSSTABUF	 0x0008		/* buffer allocated */
#define _HSSTERR  	 0x0040     /* stream error has occured */

extern size_t _HSST_send ( void *ptr, size_t to_write);
extern size_t _HSST_recv ( void *ptr, size_t to_read );

#define ENORTXSTREAM 1

#define _HSST_PACKET_CMD_FIELD 0
#define _HSST_PACKET_DES_FIELD 1
#define _HSST_PACKET_SIZE_FIELD 2
#define _HSST_PACKET_NMEMB_FIELD 3



/* linked list to store open channels */

#define DBG 0

#define ELEMENT HSST_STREAM* 

size_t nequals ( ELEMENT lhs, ELEMENT rhs );

typedef struct Node
{
	ELEMENT data;
	struct Node *next;
} Node;


typedef struct List
{
	Node* head;	
} List;

#define list_iterator Node*

extern List *p_open_channels;

/* list functions */

Node* create_node ( ELEMENT d, Node *nxt );
List* create_list ( );
void destroy_list ( List **l );
size_t push_front ( List *l, ELEMENT d );
size_t erase ( List *l, ELEMENT d );
bool   find ( List *l, ELEMENT d );
#if DBG
void print_element ( ELEMENT d, FILE *fout );
void print_list ( List *l, FILE *fout );
#endif
#endif


