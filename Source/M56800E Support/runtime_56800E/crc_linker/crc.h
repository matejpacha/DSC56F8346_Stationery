/*
 Copyright ©2005 Freescale Corporation.  All rights reserved.
*/
typedef struct {
	unsigned long start_addr;
	unsigned long mem_length;
	unsigned short mem_type;
	unsigned short poly;
	unsigned short crc16;
} CRC16_record;  

typedef struct {
	unsigned long cycle_count;

	//other items to be specified later
} CRC16_runtime_defs;


typedef enum 
{
	P_RECTYPE,
	X_RECTYPE
} MEM_RECTYPE;

typedef enum
{
	P_MEM,
	X_MEM
} MEM_AREA_TYPE;

unsigned short CRC16_check(CRC16_record CRCrecord, 
 						   CRC16_runtime_defs *runtime_defs );

void CRC16_create(CRC16_record *CRCrecord,
							MEM_RECTYPE rec_placing);


