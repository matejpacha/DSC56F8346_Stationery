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

all: 56F83xx_sdm 56F83xx_ldm 5685x_sdm 5685x_ldm 5685x_sdm_o4p 5685x_ldm_o4p 56F83xx_sdm_o4p 56F83xx_ldm_o4p 5685x_sdm_o4s 5685x_ldm_o4s 56F83xx_sdm_o4s 56F83xx_ldm_o4s

clean: clean_56F83xx_sdm clean_56F83xx_ldm clean_5685x_sdm clean_5685x_ldm clean_5685x_sdm_o4p clean_5685x_ldm_o4p clean_56F83xx_sdm_o4p clean_56F83xx_ldm_o4p clean_5685x_sdm_o4s clean_5685x_ldm_o4s clean_56F83xx_sdm_o4s clean_56F83xx_ldm_o4s

##############################
#######  TARGET: 56F83xx_sdm 
##############################
c_SRC_56F83xx_sdm+=../source/RTDTProfiler.c
c_SRC_56F83xx_sdm+=../source/RTDTProfilerTiming.c
asm_SRC_56F83xx_sdm+=../source/RTDTProfiler_sdm.asm

CFLAGS_56F83xx_sdm+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0xF0C0 -g -sym on -O0 -opt speed

AFLAGS_56F83xx_sdm+= -debug -prog 19

clean_56F83xx_sdm:
	rm -f ../lib/rtdt_prof_56F83xx_sdm.lib

56F83xx_sdm: ${c_SRC_56F83xx_sdm} ${asm_SRC_56F83xx_sdm} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_56F83xx_sdm} ${CFLAGS_56F83xx_sdm} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_56F83xx_sdm} ${AFLAGS_56F83xx_sdm}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_56F83xx_sdm.lib -o ../lib/rtdt_prof_56F83xx_sdm.lib -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: 56F83xx_ldm 
##############################
c_SRC_56F83xx_ldm+=../source/RTDTProfiler.c
c_SRC_56F83xx_ldm+=../source/RTDTProfilerTiming.c
asm_SRC_56F83xx_ldm+=../source/RTDTProfiler_ldm.asm

CFLAGS_56F83xx_ldm+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0xF0C0 -g -sym on -largedata -O0 -opt speed

AFLAGS_56F83xx_ldm+= -debug -prog 19 -data 24

clean_56F83xx_ldm:
	rm -f ../lib/rtdt_prof_56F83xx_ldm.lib

56F83xx_ldm: ${c_SRC_56F83xx_ldm} ${asm_SRC_56F83xx_ldm} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_56F83xx_ldm} ${CFLAGS_56F83xx_ldm} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_56F83xx_ldm} ${AFLAGS_56F83xx_ldm}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_56F83xx_ldm.lib -o ../lib/rtdt_prof_56F83xx_ldm.lib -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: 5685x_sdm 
##############################
c_SRC_5685x_sdm+=../source/RTDTProfiler.c
c_SRC_5685x_sdm+=../source/RTDTProfilerTiming.c
asm_SRC_5685x_sdm+=../source/RTDTProfiler_sdm.asm

CFLAGS_5685x_sdm+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0x1FFE80 -g -sym on -O0 -opt speed

AFLAGS_5685x_sdm+= -debug -prog 19

clean_5685x_sdm:
	rm -f ../lib/rtdt_profiler_5685x_sdm.lib

5685x_sdm: ${c_SRC_5685x_sdm} ${asm_SRC_5685x_sdm} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_5685x_sdm} ${CFLAGS_5685x_sdm} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_5685x_sdm} ${AFLAGS_5685x_sdm}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_5685x_sdm.lib -o ../lib/rtdt_profiler_5685x_sdm.lib -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: 5685x_ldm 
##############################
c_SRC_5685x_ldm+=../source/RTDTProfiler.c
c_SRC_5685x_ldm+=../source/RTDTProfilerTiming.c
asm_SRC_5685x_ldm+=../source/RTDTProfiler_ldm.asm

CFLAGS_5685x_ldm+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0x1FFE80 -g -sym on -largedata -O0 -opt speed

AFLAGS_5685x_ldm+= -debug -prog 19 -data 24

clean_5685x_ldm:
	rm -f ../lib/rtdt_profiler_5685x_ldm.lib

5685x_ldm: ${c_SRC_5685x_ldm} ${asm_SRC_5685x_ldm} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_5685x_ldm} ${CFLAGS_5685x_ldm} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_5685x_ldm} ${AFLAGS_5685x_ldm}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_5685x_ldm.lib -o ../lib/rtdt_profiler_5685x_ldm.lib -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: 5685x_sdm_o4p 
##############################
c_SRC_5685x_sdm_o4p+=../source/RTDTProfiler.c
c_SRC_5685x_sdm_o4p+=../source/RTDTProfilerTiming.c
asm_SRC_5685x_sdm_o4p+=../source/RTDTProfiler_sdm.asm

CFLAGS_5685x_sdm_o4p+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0x1FFE80 -g -sym on -O4 -opt speed -DO nested

AFLAGS_5685x_sdm_o4p+= -debug -prog 19

clean_5685x_sdm_o4p:
	rm -f ../lib/rtdt_profi_5685x_sdmo4p.lib 

5685x_sdm_o4p: ${c_SRC_5685x_sdm_o4p} ${asm_SRC_5685x_sdm_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_5685x_sdm_o4p} ${CFLAGS_5685x_sdm_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_5685x_sdm_o4p} ${AFLAGS_5685x_sdm_o4p}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_5685x_sdm.lib -o ../lib/rtdt_profi_5685x_sdmo4p.lib -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: 5685x_ldm_o4p 
##############################
c_SRC_5685x_ldm_o4p+=../source/RTDTProfiler.c
c_SRC_5685x_ldm_o4p+=../source/RTDTProfilerTiming.c
asm_SRC_5685x_ldm_o4p+=../source/RTDTProfiler_ldm.asm

CFLAGS_5685x_ldm_o4p+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0x1FFE80 -g -sym on -O4 -opt speed -DO nested -largedata

AFLAGS_5685x_ldm_o4p+= -debug -prog 19 -data 24

clean_5685x_ldm_o4p:
	rm -f ../lib/rtdt_profi_5685x_ldmo4p.lib 

5685x_ldm_o4p: ${c_SRC_5685x_ldm_o4p} ${asm_SRC_5685x_ldm_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_5685x_ldm_o4p} ${CFLAGS_5685x_ldm_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_5685x_ldm_o4p} ${AFLAGS_5685x_ldm_o4p}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_5685x_ldm.lib -o ../lib/rtdt_profi_5685x_ldmo4p.lib -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: 56F83xx_sdm_o4p 
##############################
c_SRC_56F83xx_sdm_o4p+=../source/RTDTProfiler.c
c_SRC_56F83xx_sdm_o4p+=../source/RTDTProfilerTiming.c
asm_SRC_56F83xx_sdm_o4p+=../source/RTDTProfiler_sdm.asm

CFLAGS_56F83xx_sdm_o4p+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0xF0C0 -g -sym on -O4 -opt speed -DO nested

AFLAGS_56F83xx_sdm_o4p+= -debug -prog 19

clean_56F83xx_sdm_o4p:
	rm -f ../lib/rtdt_pro_56F83xx_sdmo4p.lib 

56F83xx_sdm_o4p: ${c_SRC_56F83xx_sdm_o4p} ${asm_SRC_56F83xx_sdm_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_56F83xx_sdm_o4p} ${CFLAGS_56F83xx_sdm_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_56F83xx_sdm_o4p} ${AFLAGS_56F83xx_sdm_o4p}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_56F83xx_sdm.lib -o ../lib/rtdt_pro_56F83xx_sdmo4p.lib -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: 56F83xx_ldm_o4p 
##############################
c_SRC_56F83xx_ldm_o4p+=../source/RTDTProfiler.c
c_SRC_56F83xx_ldm_o4p+=../source/RTDTProfilerTiming.c
asm_SRC_56F83xx_ldm_o4p+=../source/RTDTProfiler_ldm.asm

CFLAGS_56F83xx_ldm_o4p+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0xF0C0 -g -sym on -O4 -opt speed -DO nested -largedata

AFLAGS_56F83xx_ldm_o4p+= -debug -prog 19 -data 24

clean_56F83xx_ldm_o4p:
	rm -f ../lib/rtdt_pro_56F83xx_ldmo4p.lib 

56F83xx_ldm_o4p: ${c_SRC_56F83xx_ldm_o4p} ${asm_SRC_56F83xx_ldm_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_56F83xx_ldm_o4p} ${CFLAGS_56F83xx_ldm_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_56F83xx_ldm_o4p} ${AFLAGS_56F83xx_ldm_o4p}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_56F83xx_ldm.lib -o ../lib/rtdt_pro_56F83xx_ldmo4p.lib -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: 5685x_sdm_o4s 
##############################
c_SRC_5685x_sdm_o4s+=../source/RTDTProfiler.c
c_SRC_5685x_sdm_o4s+=../source/RTDTProfilerTiming.c
asm_SRC_5685x_sdm_o4s+=../source/RTDTProfiler_sdm.asm

CFLAGS_5685x_sdm_o4s+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0x1FFE80 -g -sym on -O4 -opt space

AFLAGS_5685x_sdm_o4s+= -debug -prog 19

clean_5685x_sdm_o4s:
	rm -f ../lib/rtdt_profi_5685x_sdmo4s.lib 

5685x_sdm_o4s: ${c_SRC_5685x_sdm_o4s} ${asm_SRC_5685x_sdm_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_5685x_sdm_o4s} ${CFLAGS_5685x_sdm_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_5685x_sdm_o4s} ${AFLAGS_5685x_sdm_o4s}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_5685x_sdm.lib -o ../lib/rtdt_profi_5685x_sdmo4s.lib -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: 5685x_ldm_o4s 
##############################
c_SRC_5685x_ldm_o4s+=../source/RTDTProfiler.c
c_SRC_5685x_ldm_o4s+=../source/RTDTProfilerTiming.c
asm_SRC_5685x_ldm_o4s+=../source/RTDTProfiler_ldm.asm

CFLAGS_5685x_ldm_o4s+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0x1FFE80 -g -sym on -O4 -opt space -largedata

AFLAGS_5685x_ldm_o4s+= -debug -prog 19 -data 24

clean_5685x_ldm_o4s:
	rm -f ../lib/rtdt_profi_5685x_ldmo4s.lib 

5685x_ldm_o4s: ${c_SRC_5685x_ldm_o4s} ${asm_SRC_5685x_ldm_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_5685x_ldm_o4s} ${CFLAGS_5685x_ldm_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_5685x_ldm_o4s} ${AFLAGS_5685x_ldm_o4s}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_5685x_ldm.lib -o ../lib/rtdt_profi_5685x_ldmo4s.lib -g -sym on -largedata
	rm -f $@_bin/*.o 

##############################
#######  TARGET: 56F83xx_sdm_o4s 
##############################
c_SRC_56F83xx_sdm_o4s+=../source/RTDTProfiler.c
c_SRC_56F83xx_sdm_o4s+=../source/RTDTProfilerTiming.c
asm_SRC_56F83xx_sdm_o4s+=../source/RTDTProfiler_sdm.asm

CFLAGS_56F83xx_sdm_o4s+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0xF0C0 -g -sym on -O4 -opt space

AFLAGS_56F83xx_sdm_o4s+= -debug -prog 19 

clean_56F83xx_sdm_o4s:
	rm -f ../lib/rtdt_pro_56F83xx_sdmo4s.lib 

56F83xx_sdm_o4s: ${c_SRC_56F83xx_sdm_o4s} ${asm_SRC_56F83xx_sdm_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_56F83xx_sdm_o4s} ${CFLAGS_56F83xx_sdm_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_56F83xx_sdm_o4s} ${AFLAGS_56F83xx_sdm_o4s}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_56F83xx_sdm.lib -o ../lib/rtdt_pro_56F83xx_sdmo4s.lib -g -sym on
	rm -f $@_bin/*.o 

##############################
#######  TARGET: 56F83xx_ldm_o4s 
##############################
c_SRC_56F83xx_ldm_o4s+=../source/RTDTProfiler.c
c_SRC_56F83xx_ldm_o4s+=../source/RTDTProfilerTiming.c
asm_SRC_56F83xx_ldm_o4s+=../source/RTDTProfiler_ldm.asm

CFLAGS_56F83xx_ldm_o4s+= -ir ..\
 -I- -ir ../.. -inline smart,nobottomup -DTMR_BASE=0xF0C0 -g -sym on -O4 -opt space -largedata

AFLAGS_56F83xx_ldm_o4s+= -debug -prog 19 -data 24

clean_56F83xx_ldm_o4s:
	rm -f ../lib/rtdt_pro_56F83xx_ldmo4s.lib

56F83xx_ldm_o4s: ${c_SRC_56F83xx_ldm_o4s} ${asm_SRC_56F83xx_ldm_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_56F83xx_ldm_o4s} ${CFLAGS_56F83xx_ldm_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_56F83xx_ldm_o4s} ${AFLAGS_56F83xx_ldm_o4s}  
	$(LINK) -library $@_bin/*.o ../../rtdt/lib/rtdt_56F83xx_ldm.lib -o ../lib/rtdt_pro_56F83xx_ldmo4s.lib -g -sym on -largedata
	rm -f $@_bin/*.o  

##############################

# end Makefile
