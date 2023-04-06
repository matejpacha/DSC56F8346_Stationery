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

all: ldm ldm_04p ldm_o4s

clean: clean_ldm clean_ldm_04p clean_ldm_o4s

##############################
#######  TARGET: ldm 
##############################


c_SRC_ldm+=../source/eonceLib.c

CFLAGS_ldm+= -I../source\
             -I../include\
             -I- -I../.. \
             -library -g -sym on -inline off -r -O0 -opt speed -largedata

clean_ldm:
	rm -f '../lib/eonce 56800E lmm.lib'

ldm: ${c_SRC_ldm}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_ldm} ${CFLAGS_ldm}
	$(LINK) -library $@_bin/*.o -o '../lib/eonce 56800E lmm.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: ldm_04p 
##############################
c_SRC_ldm_04p+=../source/eonceLib.c

CFLAGS_ldm_04p+= -I../source\
                 -I../include\
                 -I- -I../.. \
                 -library -g -sym on -inline off -r -O4 -opt speed -DO nested -largedata

clean_ldm_04p:
	rm -f '../lib/eonce 56800E lmm o4p.lib'

ldm_04p: ${c_SRC_ldm_04p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_ldm_04p} ${CFLAGS_ldm_04p} 
	$(LINK) -library $@_bin/*.o -o '../lib/eonce 56800E lmm o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o
	

##############################
#######  TARGET: ldm_o4s 
##############################
c_SRC_ldm_o4s+=../source/eonceLib.c

CFLAGS_ldm_o4s+= -I../source\
                 -I../include\
                 -I- -I../.. \
                 -library -g -sym on -inline off -r -O4 -opt space -largedata

clean_ldm_o4s:
	rm -f '../lib/eonce 56800E lmm o4s.lib'

ldm_o4s: ${c_SRC_ldm_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_ldm_o4s} ${CFLAGS_ldm_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/eonce 56800E lmm o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o
	

##############################





# end Makefile
