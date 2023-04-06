# Tools definition 
#
# This should be an environment variable
# Reset environment vars you explicitly want to override
#

# CWINSTALL :  
# Should Define in environment Eg: 1.Cygwin: export CWINSTALL="C:\Freescale\CW MCU v10.2\MCU"
#                                  2.WINDOWS HOST - command prompt: set CWINSTALL=C:\Freescale\CW MCUv10.2\MCU 

ifndef CWINSTALL
errornotdefined1:
	@echo "CWINSTALL not defined"
endif
-include ./../../make.os

ifneq (,$(findstring CYGWIN,$(SYS_OS)))
	CWFOLDER = '$(shell cygpath -m "$(CWINSTALL)")'
else
	CWFOLDER = '$(CWINSTALL)'
endif

# Local variable definitions
#
TOOLS = $(CWFOLDER)/DSP56800x_EABI_Tools/command_line_tools
CC = $(TOOLS)/mwcc56800e
LD = $(TOOLS)/mwld56800e
AS = $(TOOLS)/mwasm56800e

COMPILE = $(CC)
LINK = $(LD)
ASSEMBLER = $(AS)

all: sdm_release ldm_release sdm_release_o4p ldm_release_o4p sdm_release_o4s ldm_release_o4s

clean: clean_sdm_release clean_ldm_release clean_sdm_release_o4p clean_ldm_release_o4p clean_sdm_release_o4s clean_ldm_release_o4s

##############################
#######  TARGET: sdm_release 
##############################
c_SRC_sdm_release+=../code/common/HSST_close.c
c_SRC_sdm_release+=../code/common/HSST_errno.c
c_SRC_sdm_release+=../code/common/HSST_flush.c
c_SRC_sdm_release+=../code/common/HSST_internal.c
c_SRC_sdm_release+=../code/common/HSST_log.c
c_SRC_sdm_release+=../code/common/HSST_open.c
c_SRC_sdm_release+=../code/common/HSST_raw_read.c
c_SRC_sdm_release+=../code/common/HSST_raw_write.c
c_SRC_sdm_release+=../code/common/HSST_read.c
c_SRC_sdm_release+=../code/common/HSST_setbuf.c
c_SRC_sdm_release+=../code/common/HSST_size.c
c_SRC_sdm_release+=../code/common/HSST_write.c
c_SRC_sdm_release+=../code/56800E/HSST_utils_56800E.c
c_SRC_sdm_release+=../code/56800E/HSST_low_56800E.c
c_SRC_sdm_release+=../code/56800E/rd_56800E.c
c_SRC_sdm_release+=../code/56800E/wrt_56800E.c

CFLAGS_sdm_release+= -ir ../code -I- -ir ../../.. -inline off -prefix HSST_56800E_prefix.h -library -g -sym on -O0 -opt speed

clean_sdm_release:
	rm -f ../lib/hsst_56800E.lib 

sdm_release: ${c_SRC_sdm_release}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c  ${c_SRC_sdm_release} ${CFLAGS_sdm_release}
	$(LINK) -library $@_bin/*.o -o ../lib/hsst_56800E.lib -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: ldm_release 
##############################
c_SRC_ldm_release+=../code/common/HSST_close.c
c_SRC_ldm_release+=../code/common/HSST_errno.c
c_SRC_ldm_release+=../code/common/HSST_flush.c
c_SRC_ldm_release+=../code/common/HSST_internal.c
c_SRC_ldm_release+=../code/common/HSST_log.c
c_SRC_ldm_release+=../code/common/HSST_open.c
c_SRC_ldm_release+=../code/common/HSST_raw_read.c
c_SRC_ldm_release+=../code/common/HSST_raw_write.c
c_SRC_ldm_release+=../code/common/HSST_read.c
c_SRC_ldm_release+=../code/common/HSST_setbuf.c
c_SRC_ldm_release+=../code/common/HSST_size.c
c_SRC_ldm_release+=../code/common/HSST_write.c
c_SRC_ldm_release+=../code/56800E/HSST_utils_56800E.c
c_SRC_ldm_release+=../code/56800E/HSST_low_56800E.c
c_SRC_ldm_release+=../code/56800E/rd_56800E.c
c_SRC_ldm_release+=../code/56800E/wrt_56800E.c

CFLAGS_ldm_release+= -ir ../code -I- -ir ../../.. -inline off -prefix HSST_56800E_prefix.h -library -g -sym on -O0 -opt speed -largedata 

clean_ldm_release:
	rm -f ../lib/hsst_ldm_56800E.lib

ldm_release: ${c_SRC_ldm_release}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c  ${c_SRC_ldm_release} ${CFLAGS_ldm_release}
	$(LINK) -library $@_bin/*.o -o ../lib/hsst_ldm_56800E.lib -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: sdm_release_o4p 
##############################
c_SRC_sdm_release_o4p+=../code/common/HSST_close.c
c_SRC_sdm_release_o4p+=../code/common/HSST_errno.c
c_SRC_sdm_release_o4p+=../code/common/HSST_flush.c
c_SRC_sdm_release_o4p+=../code/common/HSST_internal.c
c_SRC_sdm_release_o4p+=../code/common/HSST_log.c
c_SRC_sdm_release_o4p+=../code/common/HSST_open.c
c_SRC_sdm_release_o4p+=../code/common/HSST_raw_read.c
c_SRC_sdm_release_o4p+=../code/common/HSST_raw_write.c
c_SRC_sdm_release_o4p+=../code/common/HSST_read.c
c_SRC_sdm_release_o4p+=../code/common/HSST_setbuf.c
c_SRC_sdm_release_o4p+=../code/common/HSST_size.c
c_SRC_sdm_release_o4p+=../code/common/HSST_write.c
c_SRC_sdm_release_o4p+=../code/56800E/HSST_utils_56800E.c
c_SRC_sdm_release_o4p+=../code/56800E/HSST_low_56800E.c
c_SRC_sdm_release_o4p+=../code/56800E/rd_56800E.c
c_SRC_sdm_release_o4p+=../code/56800E/wrt_56800E.c

CFLAGS_sdm_release_o4p+= -ir ../code -I- -ir ../../.. -inline off -prefix HSST_56800E_prefix.h -library -g -sym on -O4 -opt speed -DO nested 

clean_sdm_release_o4p:
	rm -f ../lib/hsst_56800E_o4p.lib
	
sdm_release_o4p: ${c_SRC_sdm_release_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c  ${c_SRC_sdm_release_o4p} ${CFLAGS_sdm_release_o4p} 
	$(LINK) -library $@_bin/*.o -o ../lib/hsst_56800E_o4p.lib  -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: ldm_release_o4p 
##############################
c_SRC_ldm_release_o4p+=../code/common/HSST_close.c
c_SRC_ldm_release_o4p+=../code/common/HSST_errno.c
c_SRC_ldm_release_o4p+=../code/common/HSST_flush.c
c_SRC_ldm_release_o4p+=../code/common/HSST_internal.c
c_SRC_ldm_release_o4p+=../code/common/HSST_log.c
c_SRC_ldm_release_o4p+=../code/common/HSST_open.c
c_SRC_ldm_release_o4p+=../code/common/HSST_raw_read.c
c_SRC_ldm_release_o4p+=../code/common/HSST_raw_write.c
c_SRC_ldm_release_o4p+=../code/common/HSST_read.c
c_SRC_ldm_release_o4p+=../code/common/HSST_setbuf.c
c_SRC_ldm_release_o4p+=../code/common/HSST_size.c
c_SRC_ldm_release_o4p+=../code/common/HSST_write.c
c_SRC_ldm_release_o4p+=../code/56800E/HSST_utils_56800E.c
c_SRC_ldm_release_o4p+=../code/56800E/HSST_low_56800E.c
c_SRC_ldm_release_o4p+=../code/56800E/rd_56800E.c
c_SRC_ldm_release_o4p+=../code/56800E/wrt_56800E.c

CFLAGS_ldm_release_o4p+= -ir ../code -I- -ir ../../.. -inline off -prefix HSST_56800E_prefix.h -library -g -sym on -O4 -opt speed -DO nested -largedata

clean_ldm_release_o4p:
	rm -f ../lib/hsst_ldm_56800E_o4p.lib

ldm_release_o4p: ${c_SRC_ldm_release_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_ldm_release_o4p} ${CFLAGS_ldm_release_o4p} 
	$(LINK) -library $@_bin/*.o -o ../lib/hsst_ldm_56800E_o4p.lib   -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: sdm_release_o4s 
##############################
c_SRC_sdm_release_o4s+=../code/common/HSST_close.c
c_SRC_sdm_release_o4s+=../code/common/HSST_errno.c
c_SRC_sdm_release_o4s+=../code/common/HSST_flush.c
c_SRC_sdm_release_o4s+=../code/common/HSST_internal.c
c_SRC_sdm_release_o4s+=../code/common/HSST_log.c
c_SRC_sdm_release_o4s+=../code/common/HSST_open.c
c_SRC_sdm_release_o4s+=../code/common/HSST_raw_read.c
c_SRC_sdm_release_o4s+=../code/common/HSST_raw_write.c
c_SRC_sdm_release_o4s+=../code/common/HSST_read.c
c_SRC_sdm_release_o4s+=../code/common/HSST_setbuf.c
c_SRC_sdm_release_o4s+=../code/common/HSST_size.c
c_SRC_sdm_release_o4s+=../code/common/HSST_write.c
c_SRC_sdm_release_o4s+=../code/56800E/HSST_utils_56800E.c
c_SRC_sdm_release_o4s+=../code/56800E/HSST_low_56800E.c
c_SRC_sdm_release_o4s+=../code/56800E/rd_56800E.c
c_SRC_sdm_release_o4s+=../code/56800E/wrt_56800E.c

CFLAGS_sdm_release_o4s+= -ir ../code -I- -ir ../../.. -inline off -prefix HSST_56800E_prefix.h -library -g -sym on -O4 -opt space

clean_sdm_release_o4s:
	rm -f  ../lib/hsst_56800E_o4s.lib
	
sdm_release_o4s: ${c_SRC_sdm_release_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c  ${c_SRC_sdm_release_o4s} ${CFLAGS_sdm_release_o4s} 
	$(LINK) -library $@_bin/*.o -o ../lib/hsst_56800E_o4s.lib   -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: ldm_release_o4s 
##############################
c_SRC_ldm_release_o4s+=../code/common/HSST_close.c
c_SRC_ldm_release_o4s+=../code/common/HSST_errno.c
c_SRC_ldm_release_o4s+=../code/common/HSST_flush.c
c_SRC_ldm_release_o4s+=../code/common/HSST_internal.c
c_SRC_ldm_release_o4s+=../code/common/HSST_log.c
c_SRC_ldm_release_o4s+=../code/common/HSST_open.c
c_SRC_ldm_release_o4s+=../code/common/HSST_raw_read.c
c_SRC_ldm_release_o4s+=../code/common/HSST_raw_write.c
c_SRC_ldm_release_o4s+=../code/common/HSST_read.c
c_SRC_ldm_release_o4s+=../code/common/HSST_setbuf.c
c_SRC_ldm_release_o4s+=../code/common/HSST_size.c
c_SRC_ldm_release_o4s+=../code/common/HSST_write.c
c_SRC_ldm_release_o4s+=../code/56800E/HSST_utils_56800E.c
c_SRC_ldm_release_o4s+=../code/56800E/HSST_low_56800E.c
c_SRC_ldm_release_o4s+=../code/56800E/rd_56800E.c
c_SRC_ldm_release_o4s+=../code/56800E/wrt_56800E.c

CFLAGS_ldm_release_o4s+= -ir ../code -I- -ir ../../.. -inline off -prefix HSST_56800E_prefix.h -library -g -sym on -O4 -opt space -largedata

clean_ldm_release_o4s:
	rm -f  ../lib/hsst_ldm_56800E_o4s.lib

ldm_release_o4s:${c_SRC_ldm_release_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c  ${c_SRC_ldm_release_o4s} ${CFLAGS_ldm_release_o4s} 
	$(LINK) -library $@_bin/*.o -o ../lib/hsst_ldm_56800E_o4s.lib   -g -sym on -largedata
	rm -f $@_bin/*.o
##############################

# end Makefile
