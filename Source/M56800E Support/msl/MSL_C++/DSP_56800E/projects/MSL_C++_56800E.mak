# Tools definition
#
# This should be an environment variable
# Reset environment vars you explicitly want to override
#

# CWINSTALL:
# Should Define in environment Eg: 1.Cygwin: export CWINSTALL="C:\Freescale\CW MCU v10.2\MCU"
#                                  2.WINDOWS HOST - command prompt: set CWINSTALL=C:\Freescale\CW MCU v10.2\MCU

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

all: small_program large_program huge_program

small_program: small_program_small_data \
small_program_small_data_SLLD \
small_program_small_data_o4p \
small_program_small_data_SLLD_o4p \
small_program_small_data_o4s \
small_program_small_data_SLLD_o4s \

large_program: large_program_small_data \
large_program_small_data_o4p \
large_program_small_data_o4s \
large_program_small_data_SLLD \
large_program_small_data_SLLD_o4p \
large_program_small_data_SLLD_o4s \
\
large_program_large_data \
large_program_large_data_o4p \
large_program_large_data_o4s \
large_program_large_data_SLLD \
large_program_large_data_SLLD_o4p \
large_program_large_data_SLLD_o4s

huge_program: huge_program_small_data \
huge_program_small_data_o4p \
huge_program_small_data_o4s \
huge_program_small_data_SLLD \
huge_program_small_data_SLLD_o4p \
huge_program_small_data_SLLD_o4s \
\
huge_program_large_data \
huge_program_large_data_o4p \
huge_program_large_data_o4s \
huge_program_large_data_SLLD \
huge_program_large_data_SLLD_o4p \
huge_program_large_data_SLLD_o4s

clean: clean_large_program_small_data clean_large_program_large_data clean_small_program_small_data \
clean_small_program_small_data_SLLD clean_large_program_small_data_SLLD clean_large_program_large_data_SLLD \
clean_small_program_small_data_o4p clean_large_program_small_data_o4p clean_large_program_large_data_o4p \
clean_small_program_small_data_SLLD_o4p clean_large_program_small_data_SLLD_o4p clean_large_program_large_data_SLLD_o4p \
clean_small_program_small_data_o4s clean_large_program_small_data_o4s clean_large_program_large_data_o4s \
clean_small_program_small_data_SLLD_o4s clean_large_program_small_data_SLLD_o4s clean_large_program_large_data_SLLD_o4s \
clean_huge_program_small_data clean_huge_program_large_data clean_huge_program_small_data_SLLD \
clean_huge_program_large_data_SLLD clean_huge_program_small_data_o4p clean_huge_program_large_data_o4p \
clean_huge_program_small_data_SLLD_o4p clean_huge_program_large_data_SLLD_o4p clean_huge_program_small_data_o4s \
clean_huge_program_large_data_o4s clean_huge_program_small_data_SLLD_o4s clean_huge_program_large_data_SLLD_o4s

##############################
#######  TARGET: huge_program_small_data
##############################
c_SRC_huge_program_small_data+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_small_data+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_small_data+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O0 -opt speed -hugeprog

clean_huge_program_small_data:
	rm -f "../lib/MSL C++ 56800E HPM.lib"

huge_program_small_data: ${c_SRC_huge_program_small_data}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data} ${CFLAGS_huge_program_small_data}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data
##############################
c_SRC_huge_program_large_data+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_large_data+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_large_data+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -largedata -O0 -opt speed -hugeprog

clean_huge_program_large_data:
	rm -f "../lib/MSL C++ 56800E HPM LMM.lib"

huge_program_large_data: ${c_SRC_huge_program_large_data}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data} ${CFLAGS_huge_program_large_data}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM LMM.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data
##############################
c_SRC_large_program_small_data+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_small_data+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_small_data+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O0 -opt speed

clean_large_program_small_data:
	rm -f "../lib/MSL C++ 56800E.lib"

large_program_small_data: ${c_SRC_large_program_small_data}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data} ${CFLAGS_large_program_small_data}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data
##############################
c_SRC_large_program_large_data+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_large_data+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_large_data+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -largedata -O0 -opt speed

clean_large_program_large_data:
	rm -f "../lib/MSL C++ 56800E LMM.lib"

large_program_large_data: ${c_SRC_large_program_large_data}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data} ${CFLAGS_large_program_large_data}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E LMM.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data
##############################
c_SRC_small_program_small_data+=../../MSL_Common/Src/complex.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/iostream.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/ios.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/strstream.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/locale.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/msl_time.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_small_program_small_data+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_small_program_small_data+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -smallprog -O0 -opt speed

clean_small_program_small_data:
	rm -f "../lib/MSL C++ 56800E smm.lib"

small_program_small_data: ${c_SRC_small_program_small_data}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data} ${CFLAGS_small_program_small_data}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E smm.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD
##############################
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/complex.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/iostream.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/ios.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/strstream.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/locale.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/msl_time.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_small_program_small_data_SLLD+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -smallprog

clean_small_program_small_data_SLLD:
	rm -f "../lib/MSL C++ 56800E smm_SLLD.lib"

small_program_small_data_SLLD: ${c_SRC_small_program_small_data_SLLD}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD} ${CFLAGS_small_program_small_data_SLLD}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E smm_SLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD
##############################
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_small_data_SLLD+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -hugeprog

clean_huge_program_small_data_SLLD:
	rm -f "../lib/MSL C++ 56800E HPM SLLD.lib"

huge_program_small_data_SLLD: ${c_SRC_huge_program_small_data_SLLD}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD} ${CFLAGS_huge_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM SLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_SLLD
##############################
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_large_data_SLLD+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -largedata -hugeprog

clean_huge_program_large_data_SLLD:
	rm -f "../lib/MSL C++ 56800E HPM LMM SLLD.lib"

huge_program_large_data_SLLD: ${c_SRC_huge_program_large_data_SLLD}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD} ${CFLAGS_huge_program_large_data_SLLD}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM LMM SLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD
##############################
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_small_data_SLLD+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld

clean_large_program_small_data_SLLD:
	rm -f "../lib/MSL C++ 56800E_SLLD.lib"

large_program_small_data_SLLD: ${c_SRC_large_program_small_data_SLLD}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD} ${CFLAGS_large_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E_SLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_SLLD
##############################
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_large_data_SLLD+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -largedata

clean_large_program_large_data_SLLD:
	rm -f "../lib/MSL C++ 56800E lmm_SLLD.lib"

large_program_large_data_SLLD: ${c_SRC_large_program_large_data_SLLD}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD} ${CFLAGS_large_program_large_data_SLLD}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E lmm_SLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_o4p
##############################
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_small_program_small_data_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -smallprog

clean_small_program_small_data_o4p:
	rm -f "../lib/MSL C++ 56800E smm o4p.lib"

small_program_small_data_o4p: ${c_SRC_small_program_small_data_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_o4p} ${CFLAGS_small_program_small_data_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E smm o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_o4p
##############################
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_small_data_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -hugeprog

clean_huge_program_small_data_o4p:
	rm -f "../lib/MSL C++ 56800E HPM o4p.lib"

huge_program_small_data_o4p: ${c_SRC_huge_program_small_data_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_o4p} ${CFLAGS_huge_program_small_data_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_o4p
##############################
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_large_data_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -largedata -hugeprog

clean_huge_program_large_data_o4p:
	rm -f "../lib/MSL C++ 56800E HPM LMM o4p.lib"

huge_program_large_data_o4p: ${c_SRC_huge_program_large_data_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_o4p} ${CFLAGS_huge_program_large_data_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM LMM o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_o4p
##############################
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_small_data_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested

clean_large_program_small_data_o4p:
	rm -f "../lib/MSL C++ 56800E o4p.lib"

large_program_small_data_o4p: ${c_SRC_large_program_small_data_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_o4p} ${CFLAGS_large_program_small_data_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_o4p
##############################
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_large_data_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -largedata

clean_large_program_large_data_o4p:
	rm -f "../lib/MSL C++ 56800E lmm o4p.lib"

large_program_large_data_o4p: ${c_SRC_large_program_large_data_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_o4p} ${CFLAGS_large_program_large_data_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E lmm o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD_o4p
##############################
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/complex.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/iostream.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/ios.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/MSLstring.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/strstream.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/locale.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/msl_time.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/msl_thread.cpp
c_SRC_small_program_small_data_SLLD_o4p +=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_small_program_small_data_SLLD_o4p += -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -smallprog

clean_small_program_small_data_SLLD_o4p:
	rm -f "../lib/MSL C++ 56800Esmm_SLLDo4p.lib"

small_program_small_data_SLLD_o4p: ${c_SRC_small_program_small_data_SLLD_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD_o4p} ${CFLAGS_small_program_small_data_SLLD_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800Esmm_SLLDo4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD_o4p
##############################
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_small_data_SLLD_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -hugeprog

clean_huge_program_small_data_SLLD_o4p:
	rm -f "../lib/MSL C++ 56800E HPM SLLD o4p.lib"

huge_program_small_data_SLLD_o4p: ${c_SRC_huge_program_small_data_SLLD_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD_o4p} ${CFLAGS_huge_program_small_data_SLLD_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM SLLD o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_SLLD_o4p
##############################
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_large_data_SLLD_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -largedata -hugeprog

clean_huge_program_large_data_SLLD_o4p:
	rm -f "../lib/MSL C++ 56800E HPM LMM SLLD o4p.lib"

huge_program_large_data_SLLD_o4p: ${c_SRC_huge_program_large_data_SLLD_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD_o4p} ${CFLAGS_huge_program_large_data_SLLD_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM LMM SLLD o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD_o4p
##############################
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_small_data_SLLD_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld

clean_large_program_small_data_SLLD_o4p:
	rm -f "../lib/MSL C++ 56800E_SLLD o4p.lib"

large_program_small_data_SLLD_o4p: ${c_SRC_large_program_small_data_SLLD_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD_o4p} ${CFLAGS_large_program_small_data_SLLD_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E_SLLD o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_SLLD_o4p
##############################
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_large_data_SLLD_o4p+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -largedata

clean_large_program_large_data_SLLD_o4p:
	rm -f "../lib/MSL C++ 56800Elmm_SLLDo4p.lib"

large_program_large_data_SLLD_o4p: ${c_SRC_large_program_large_data_SLLD_o4p}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD_o4p} ${CFLAGS_large_program_large_data_SLLD_o4p}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800Elmm_SLLDo4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_o4s
##############################
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/complex.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/iostream.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/ios.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/strstream.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/locale.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/msl_time.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_small_program_small_data_o4s+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -smallprog

clean_small_program_small_data_o4s:
	rm -f "../lib/MSL C++ 56800E smm o4s.lib"

small_program_small_data_o4s: ${c_SRC_small_program_small_data_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_o4s} ${CFLAGS_small_program_small_data_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E smm o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_o4s 
##############################
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_small_data_o4s +=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_small_data_o4s += -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -hugeprog

clean_huge_program_small_data_o4s:
	rm -f "../lib/MSL C++ 56800E HPM o4s.lib"

huge_program_small_data_o4s: ${c_SRC_huge_program_small_data_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_o4s} ${CFLAGS_huge_program_small_data_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_o4s
##############################
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_large_data_o4s +=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_large_data_o4s += -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -largedata -hugeprog

clean_huge_program_large_data_o4s:
	rm -f "../lib/MSL C++ 56800E HPM LMM o4s.lib"

huge_program_large_data_o4s: ${c_SRC_huge_program_large_data_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_o4s} ${CFLAGS_huge_program_large_data_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM LMM o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_o4s 
##############################
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_small_data_o4s +=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_small_data_o4s += -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space

clean_large_program_small_data_o4s:
	rm -f "../lib/MSL C++ 56800E o4s.lib"

large_program_small_data_o4s: ${c_SRC_large_program_small_data_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_o4s} ${CFLAGS_large_program_small_data_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_o4s
##############################
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_large_data_o4s +=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_large_data_o4s += -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -largedata

clean_large_program_large_data_o4s:
	rm -f "../lib/MSL C++ 56800E lmm o4s.lib"

large_program_large_data_o4s: ${c_SRC_large_program_large_data_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_o4s} ${CFLAGS_large_program_large_data_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E lmm o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD_o4s
##############################
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/complex.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/iostream.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ios.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strstream.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/locale.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_time.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_small_program_small_data_SLLD_o4s+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -smallprog

clean_small_program_small_data_SLLD_o4s:
	rm -f "../lib/MSL C++ 56800Esmm_SLLDo4s.lib"

small_program_small_data_SLLD_o4s: ${c_SRC_small_program_small_data_SLLD_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD_o4s} ${CFLAGS_small_program_small_data_SLLD_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800Esmm_SLLDo4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD_o4s
##############################
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_small_data_SLLD_o4s+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -hugeprog

clean_huge_program_small_data_SLLD_o4s:
	rm -f "../lib/MSL C++ 56800E HPM SLLD o4s.lib"

huge_program_small_data_SLLD_o4s: ${c_SRC_huge_program_small_data_SLLD_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD_o4s} ${CFLAGS_huge_program_small_data_SLLD_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM SLLD o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_SLLD_o4s
##############################
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/complex.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/iostream.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/ios.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/strstream.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/locale.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_time.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_huge_program_large_data_SLLD_o4s+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -largedata -hugeprog

clean_huge_program_large_data_SLLD_o4s:
	rm -f "../lib/MSL C++ 56800E HPM LMM SLLD o4s.lib"

huge_program_large_data_SLLD_o4s: ${c_SRC_huge_program_large_data_SLLD_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD_o4s} ${CFLAGS_huge_program_large_data_SLLD_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E HPM LMM SLLD o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD_o4s
##############################
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_small_data_SLLD_o4s+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -flag slld

clean_large_program_small_data_SLLD_o4s:
	rm -f "../lib/MSL C++ 56800E_SLLD o4s.lib"

large_program_small_data_SLLD_o4s: ${c_SRC_large_program_small_data_SLLD_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD_o4s} ${CFLAGS_large_program_small_data_SLLD_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800E_SLLD o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_SLLD_o4s
##############################
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/complex.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/iostream.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/ios.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/MSLstring.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/strstream.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/locale.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_time.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_mutex.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_thread.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/msl_condition.cpp

CFLAGS_large_program_large_data_SLLD_o4s+= -ir ../inc\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../MSL_C -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -largedata

clean_large_program_large_data_SLLD_o4s:
	rm -f "../lib/MSL C++ 56800Elmm_SLLDo4s.lib"

large_program_large_data_SLLD_o4s: ${c_SRC_large_program_large_data_SLLD_o4s}
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD_o4s} ${CFLAGS_large_program_large_data_SLLD_o4s}
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C++ 56800Elmm_SLLDo4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################

# end Makefile
