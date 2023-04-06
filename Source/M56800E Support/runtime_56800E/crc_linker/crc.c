/*
 Copyright ©2005 Freescale Corporation.  All rights reserved.
*/

#include <crc.h>


	//	updates the CRC16 with the next byte in the input stream
void UpdateCRC16(unsigned short* current_crc,unsigned short poly,unsigned char next)
{
	unsigned short test;
	int i ;
	for (i = 7; i>=0 ; i--)
	{
		test = (*current_crc) & (unsigned short)0x8000;
		
		(*current_crc) <<= 1 ;
		(*current_crc) |= (next>>i) & 1 ; //insert most significant bit
		
		if(test)
		{
			(*current_crc) ^= poly;	//if most significant bit was 1, xor the current crc with tmp
		}
		
	}

}

    /* verifies a crc record for consistency with the currcent values in memory */
unsigned short CRC16_check(CRC16_record CRC_rec, 
 						   CRC16_runtime_defs *runtime_defs )
{
	unsigned short CRC = 0;
	int i ;		
	
	if(CRC_rec.mem_type == P_MEM)
	{
		//memory area in P_MEM

		__pmem char* mem_area = (__pmem char*)(CRC_rec.start_addr);

		for(i = 0; i< CRC_rec.mem_length;i++)
		{
			UpdateCRC16(&CRC,CRC_rec.poly,mem_area[i]);
		}
		UpdateCRC16(&CRC,CRC_rec.poly,0);
		UpdateCRC16(&CRC,CRC_rec.poly,0);
		if(CRC != CRC_rec.crc16)
			return 0;
		else
			return 1;
	}
	else 
	{
		// memory area in X_MEM
		char* mem_area = (char*)(CRC_rec.start_addr);

		for(i = 0; i< CRC_rec.mem_length;i++)
		{
			UpdateCRC16(&CRC,CRC_rec.poly,mem_area[i]);
		}
		UpdateCRC16(&CRC,CRC_rec.poly,0);
		UpdateCRC16(&CRC,CRC_rec.poly,0);
		if(CRC != CRC_rec.crc16)
			return 0;
		else
			return 1;

	}
}

    /* creates a crc record at runtime the same way the lcf  */
void CRC16_create(	CRC16_record *CRCrecord,
					MEM_RECTYPE rec_placing)
{
	unsigned short CRC = 0 ;
	unsigned int i ;

	if(rec_placing == P_RECTYPE)
	{
		/* CRCrecord is in fact a storage in P_MEM, due to limitations 
		   in __pmem implementation we need to convert it to a __pmem qualified
		   structure in order to access it correctly */
		__pmem CRC16_record *P_CRCRecord = (__pmem CRC16_record*) CRCrecord;
		

		if(P_CRCRecord->mem_type == P_MEM)
		{
			/* start address and memory area refers to p_mem*/
			__pmem char* mem_area = (__pmem char*)(P_CRCRecord->start_addr);

			for(i = 0; i< P_CRCRecord->mem_length;i++)
			{
				UpdateCRC16(&CRC,P_CRCRecord->poly,mem_area[i]);
			}
			UpdateCRC16(&CRC,P_CRCRecord->poly,0);
			UpdateCRC16(&CRC,P_CRCRecord->poly,0);
			
			P_CRCRecord->crc16 = CRC ;
		}
		else
		{
			/* start address and memory area refers to x_mem*/
			char* mem_area = (char*)(P_CRCRecord->start_addr);

			for(i = 0; i< P_CRCRecord->mem_length;i++)
			{
				UpdateCRC16(&CRC,P_CRCRecord->poly,mem_area[i]);
			}
			UpdateCRC16(&CRC,P_CRCRecord->poly,0);
			UpdateCRC16(&CRC,P_CRCRecord->poly,0);
			
			P_CRCRecord->crc16 = CRC ;
			
		}
		   
	}
	else
	{
		
		if(CRCrecord->mem_type == P_MEM)
		{
			/* start address and memory area refers to p_mem*/
			__pmem char* mem_area = (__pmem char*)(CRCrecord->start_addr);

			for(i = 0; i< CRCrecord->mem_length;i++)
			{
				UpdateCRC16(&CRC,CRCrecord->poly,mem_area[i]);
			}
			UpdateCRC16(&CRC,CRCrecord->poly,0);
			UpdateCRC16(&CRC,CRCrecord->poly,0);
			
			CRCrecord->crc16 = CRC ;
		}
		else
		{
			/* start address and memory area refers to x_mem*/
			char* mem_area = (char*)(CRCrecord->start_addr);

			for(i = 0; i< CRCrecord->mem_length;i++)
			{
				UpdateCRC16(&CRC,CRCrecord->poly,mem_area[i]);
			}
			UpdateCRC16(&CRC,CRCrecord->poly,0);
			UpdateCRC16(&CRC,CRCrecord->poly,0);
			
			CRCrecord->crc16 = CRC ;
			
		}

	}
	
}

