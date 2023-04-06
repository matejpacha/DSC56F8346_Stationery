

/* 
 MSL
 Copyright ©1995-2002 Freescale Corporation.  All rights reserved.
*/




#include "HSST_internal.h"


size_t 
nequals ( ELEMENT lhs, ELEMENT rhs )
{
#pragma inline
	return lhs->_stream == rhs->_stream;
}


/* List implementation to store open channels */

List *p_open_channels = NULL;

/* creates a list node */

Node* 
create_node ( ELEMENT d, Node *nxt )
{
	Node* n = malloc ( sizeof(Node) );
	if ( n )
	{
		n->data = d;
		n->next = nxt;
	}
	return n;
}

/* creates a list instance */

List* 
create_list ( )
{
	List *l = malloc ( sizeof(List) );
	if ( l )
	{
		l->head = NULL;	
	}	
	return l;
}


/* destroys a list and deallocates memory */

void 
destroy_list ( List **l )
{
	Node *n;
	while ( (*l)->head )
	{
		n = (*l)->head;
		(*l)->head = (*l)->head->next;		
		free ( n );
	}
	free ( *l );				
	*l = NULL;
}

/* adds the given element to the front of the list */

size_t 
push_front ( List *l, ELEMENT d )
{		
	Node *n = create_node ( d, l->head );
	if ( n )
	{
		l->head = n;
		return 1;
	}	
	return (size_t) 0;
}

/* erases the given element from the given list */

size_t 
erase ( List *l, ELEMENT d )
{
	Node *n = l->head;
	Node *prev = NULL;
	
	for ( ; n && nequals ( d, n->data ); n = n->next )
	{
		prev = n;
	}	
	if ( n )
	{
		if ( prev )
		{	
			prev->next = n->next;
		}
		else
		{
			l->head = l->head->next;			
		}
		free ( n );
		return 1;
	}
	
	return (size_t)0;
}	

/* returns true if the element exists in the given list. false otherwise */

bool
find ( List *l, ELEMENT d )
{
	Node *n = l->head;
	
	while ( n && nequals ( d, n->data ) )
	{	
		n = n->next;
	}
	
	return ( n != NULL ? true : false );
}


#if DBG
/* print the list and the individual elements for debugging */
void 
print_element ( ELEMENT d, FILE *fout )
{
	fprintf ( fout, "Descriptor = %d\n", d->_stream );
	fprintf ( fout, "Flag = %d\n", d->_flag );
	fprintf ( fout, "Count = %d\n", d->_cnt );	
}


void 
print_list ( List *l, FILE *fout )
{
	Node *n = l->head;
	while ( n )
	{
		print_element ( n->data, fout );
		n = n->next;
	} 
};

#endif


