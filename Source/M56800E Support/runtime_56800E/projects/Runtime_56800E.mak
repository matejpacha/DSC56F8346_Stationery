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

all: small_program large_program huge_program

small_program: small_program_small_data \
small_program_small_data_o4p \
small_program_small_data_o4s \
small_program_small_data_SLLD \
small_program_small_data_SLLD_o4p \
small_program_small_data_SLLD_o4s

large_program: large_program_small_data \
large_program_small_data_o4p \
large_program_small_data_o4s \
large_program_small_data_SLLD \
large_program_small_data_SLLD_o4p \
large_program_small_data_SLLD_o4s \
large_program_small_data_hsst \
large_program_small_data_hsst_SLLD \
\
large_program_large_data \
large_program_large_data_o4p \
large_program_large_data_o4s \
large_program_large_data_SLLD \
large_program_large_data_SLLD_o4p \
large_program_large_data_SLLD_o4s \
large_program_large_data_hsst \
large_program_large_data_hsst_SLLD

huge_program: huge_program_small_data \
huge_program_small_data_o4p \
huge_program_small_data_o4s \
huge_program_small_data_SLLD \
huge_program_small_data_SLLD_o4p \
huge_program_small_data_SLLD_o4s \
huge_program_small_data_hsst \
huge_program_small_data_hsst_SLLD \
\
huge_program_large_data \
huge_program_large_data_o4p \
huge_program_large_data_o4s \
huge_program_large_data_SLLD \
huge_program_large_data_SLLD_o4p \
huge_program_large_data_SLLD_o4s \
huge_program_large_data_hsst \
huge_program_large_data_hsst_SLLD

clean: clean_large_program_small_data clean_large_program_large_data clean_large_program_small_data_hsst \
	clean_large_program_large_data_hsst clean_small_program_small_data clean_small_program_small_data_SLLD \
	clean_large_program_small_data_SLLD clean_large_program_large_data_SLLD clean_large_program_small_data_hsst_SLLD \
	clean_large_program_large_data_hsst_SLLD clean_small_program_small_data_o4p clean_large_program_small_data_o4p \
	clean_large_program_large_data_o4p clean_small_program_small_data_SLLD_o4p clean_large_program_small_data_SLLD_o4p \
	clean_large_program_large_data_SLLD_o4p clean_small_program_small_data_o4s clean_large_program_small_data_o4s \
	clean_large_program_large_data_o4s clean_small_program_small_data_SLLD_o4s clean_large_program_small_data_SLLD_o4s \
	clean_large_program_large_data_SLLD_o4s clean_huge_program_small_data clean_huge_program_large_data \
	clean_huge_program_small_data_hsst clean_huge_program_large_data_hsst clean_huge_program_small_data_SLLD \
	clean_huge_program_large_data_SLLD clean_huge_program_small_data_hsst_SLLD clean_huge_program_large_data_hsst_SLLD \
	clean_huge_program_small_data_o4p clean_huge_program_large_data_o4p clean_huge_program_small_data_SLLD_o4p \
	clean_huge_program_large_data_SLLD_o4p clean_huge_program_small_data_o4s clean_huge_program_large_data_o4s \
	clean_huge_program_small_data_SLLD_o4s clean_huge_program_large_data_SLLD_o4s


##############################
#######  TARGET: huge_program_small_data 
##############################
asm_SRC_huge_program_small_data+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data+=../init/FSTART.asm
c_SRC_huge_program_small_data+=../init/initsections.c
c_SRC_huge_program_small_data+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data+=../cpp_support/New.cpp
c_SRC_huge_program_small_data+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data+=../fp/result_is.asm
asm_SRC_huge_program_small_data+=../fp/utilities.asm
asm_SRC_huge_program_small_data+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data+=../hostio/console_asm.asm
c_SRC_huge_program_small_data+=../hostio/console_c.c
c_SRC_huge_program_small_data+=../hostio/file_io.stub.c
asm_SRC_huge_program_small_data+=../hostio/hostio_asm.asm
asm_SRC_huge_program_small_data+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data+=../crc_linker/crc.c
asm_SRC_huge_program_small_data+=../ll/div_64.asm

CFLAGS_huge_program_small_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O0 -opt speed -hugeprog

AFLAGS_huge_program_small_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21

clean_huge_program_small_data:
	rm -f '../lib/Runtime 56800E HPM.Lib'

huge_program_small_data: ${c_SRC_huge_program_small_data} ${asm_SRC_huge_program_small_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data} ${CFLAGS_huge_program_small_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data} ${AFLAGS_huge_program_small_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/Runtime 56800E HPM.Lib' -g -sym on
	rm -f $@_bin/*.o


##############################
#######  TARGET: huge_program_large_data 
##############################
asm_SRC_huge_program_large_data+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data+=../init/FSTART.asm
c_SRC_huge_program_large_data+=../init/initsections.c
c_SRC_huge_program_large_data+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data+=../cpp_support/New.cpp
c_SRC_huge_program_large_data+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data+=../fp/result_is.asm
asm_SRC_huge_program_large_data+=../fp/utilities.asm
asm_SRC_huge_program_large_data+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data+=../hostio/console_asm.asm
c_SRC_huge_program_large_data+=../hostio/console_c.c
c_SRC_huge_program_large_data+=../hostio/file_io.stub.c
asm_SRC_huge_program_large_data+=../hostio/hostio_asm.asm
asm_SRC_huge_program_large_data+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data+=../crc_linker/crc.c
asm_SRC_huge_program_large_data+=../ll/div_64.asm

CFLAGS_huge_program_large_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -largedata -O0 -opt speed -hugeprog

AFLAGS_huge_program_large_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data:
	rm -f '../lib/Runtime 56800E HPM LMM.lib'

huge_program_large_data: ${c_SRC_huge_program_large_data} ${asm_SRC_huge_program_large_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data} ${CFLAGS_huge_program_large_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data} ${AFLAGS_huge_program_large_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/Runtime 56800E HPM LMM.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_hsst 
##############################
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data_hsst+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data_hsst+=../init/FSTART.asm
c_SRC_huge_program_small_data_hsst+=../init/initsections.c
c_SRC_huge_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data_hsst+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data_hsst+=../cpp_support/New.cpp
c_SRC_huge_program_small_data_hsst+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data_hsst+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data_hsst+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data_hsst+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data_hsst+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data_hsst+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data_hsst+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data_hsst+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data_hsst+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data_hsst+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data_hsst+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data_hsst+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data_hsst+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data_hsst+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data_hsst+=../fp/result_is.asm
asm_SRC_huge_program_small_data_hsst+=../fp/utilities.asm
asm_SRC_huge_program_small_data_hsst+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data_hsst+=../hostio/console_asm.asm
c_SRC_huge_program_small_data_hsst+=../hostio/console_c.c
c_SRC_huge_program_small_data_hsst+=../hostio/file_io.stub.c
c_SRC_huge_program_small_data_hsst+=../hostio/hsst_hostio.c
asm_SRC_huge_program_small_data_hsst+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data_hsst+=../crc_linker/crc.c
asm_SRC_huge_program_small_data_hsst+=../ll/div_64.asm

CFLAGS_huge_program_small_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O0 -opt speed -hugeprog

AFLAGS_huge_program_small_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21

clean_huge_program_small_data_hsst:
	rm -f '../lib/runtime_hsst_HPM_56800E.lib'

huge_program_small_data_hsst: ${c_SRC_huge_program_small_data_hsst} ${asm_SRC_huge_program_small_data_hsst} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_hsst} ${CFLAGS_huge_program_small_data_hsst} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_hsst} ${AFLAGS_huge_program_small_data_hsst} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime_hsst_HPM_56800E.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_hsst 
##############################
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data_hsst+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data_hsst+=../init/FSTART.asm
c_SRC_huge_program_large_data_hsst+=../init/initsections.c
c_SRC_huge_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data_hsst+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data_hsst+=../cpp_support/New.cpp
c_SRC_huge_program_large_data_hsst+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data_hsst+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data_hsst+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data_hsst+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data_hsst+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data_hsst+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data_hsst+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data_hsst+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data_hsst+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data_hsst+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data_hsst+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data_hsst+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data_hsst+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data_hsst+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data_hsst+=../fp/result_is.asm
asm_SRC_huge_program_large_data_hsst+=../fp/utilities.asm
asm_SRC_huge_program_large_data_hsst+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data_hsst+=../hostio/console_asm.asm
c_SRC_huge_program_large_data_hsst+=../hostio/console_c.c
c_SRC_huge_program_large_data_hsst+=../hostio/file_io.stub.c
c_SRC_huge_program_large_data_hsst+=../hostio/hsst_hostio.c
asm_SRC_huge_program_large_data_hsst+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data_hsst+=../crc_linker/crc.c
asm_SRC_huge_program_large_data_hsst+=../ll/div_64.asm

CFLAGS_huge_program_large_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -largedata -O0 -opt speed -hugeprog

AFLAGS_huge_program_large_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24

clean_huge_program_large_data_hsst:
	rm -f '../lib/runtime_hsst_HPM_56800E_lmm.lib'

huge_program_large_data_hsst: ${c_SRC_huge_program_large_data_hsst} ${asm_SRC_huge_program_large_data_hsst} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_hsst} ${CFLAGS_huge_program_large_data_hsst} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_hsst} ${AFLAGS_huge_program_large_data_hsst} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime_hsst_HPM_56800E_lmm.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data 
##############################
asm_SRC_large_program_small_data+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data+=../init/FSTART.asm
c_SRC_large_program_small_data+=../init/initsections.c
c_SRC_large_program_small_data+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data+=../cpp_support/New.cpp
c_SRC_large_program_small_data+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data+=../fp/fcoerce.asm
asm_SRC_large_program_small_data+=../fp/result_is.asm
asm_SRC_large_program_small_data+=../fp/utilities.asm
asm_SRC_large_program_small_data+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data+=../hostio/console_asm.asm
c_SRC_large_program_small_data+=../hostio/console_c.c
c_SRC_large_program_small_data+=../hostio/file_io.stub.c
asm_SRC_large_program_small_data+=../hostio/hostio_asm.asm
asm_SRC_large_program_small_data+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data+=../crc_linker/crc.c
asm_SRC_large_program_small_data+=../ll/div_64.asm

CFLAGS_large_program_small_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O0 -opt speed

AFLAGS_large_program_small_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19

clean_large_program_small_data:
	rm -f '../lib/Runtime 56800E.Lib'

large_program_small_data: ${c_SRC_large_program_small_data} ${asm_SRC_large_program_small_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data} ${CFLAGS_large_program_small_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data} ${AFLAGS_large_program_small_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/Runtime 56800E.Lib' -g -sym on
	rm -f $@_bin/*.o


##############################
#######  TARGET: large_program_large_data 
##############################
asm_SRC_large_program_large_data+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data+=../init/FSTART.asm
c_SRC_large_program_large_data+=../init/initsections.c
c_SRC_large_program_large_data+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data+=../cpp_support/New.cpp
c_SRC_large_program_large_data+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data+=../fp/fcoerce.asm
asm_SRC_large_program_large_data+=../fp/result_is.asm
asm_SRC_large_program_large_data+=../fp/utilities.asm
asm_SRC_large_program_large_data+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data+=../hostio/console_asm.asm
c_SRC_large_program_large_data+=../hostio/console_c.c
c_SRC_large_program_large_data+=../hostio/file_io.stub.c
asm_SRC_large_program_large_data+=../hostio/hostio_asm.asm
asm_SRC_large_program_large_data+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data+=../crc_linker/crc.c
asm_SRC_large_program_large_data+=../ll/div_64.asm

CFLAGS_large_program_large_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -largedata -O0 -opt speed

AFLAGS_large_program_large_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data:
	rm -f '../lib/Runtime 56800E lmm.lib'

large_program_large_data: ${c_SRC_large_program_large_data} ${asm_SRC_large_program_large_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data} ${CFLAGS_large_program_large_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data} ${AFLAGS_large_program_large_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/Runtime 56800E lmm.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_hsst 
##############################
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data_hsst+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data_hsst+=../init/FSTART.asm
c_SRC_large_program_small_data_hsst+=../init/initsections.c
c_SRC_large_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data_hsst+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data_hsst+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data_hsst+=../cpp_support/New.cpp
c_SRC_large_program_small_data_hsst+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data_hsst+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data_hsst+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data_hsst+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data_hsst+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data_hsst+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data_hsst+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data_hsst+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data_hsst+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data_hsst+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data_hsst+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data_hsst+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data_hsst+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data_hsst+=../fp/fcoerce.asm
asm_SRC_large_program_small_data_hsst+=../fp/result_is.asm
asm_SRC_large_program_small_data_hsst+=../fp/utilities.asm
asm_SRC_large_program_small_data_hsst+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data_hsst+=../hostio/console_asm.asm
c_SRC_large_program_small_data_hsst+=../hostio/console_c.c
c_SRC_large_program_small_data_hsst+=../hostio/file_io.stub.c
c_SRC_large_program_small_data_hsst+=../hostio/hsst_hostio.c
asm_SRC_large_program_small_data_hsst+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data_hsst+=../crc_linker/crc.c
asm_SRC_large_program_small_data_hsst+=../ll/div_64.asm

CFLAGS_large_program_small_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O0 -opt speed

AFLAGS_large_program_small_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19

clean_large_program_small_data_hsst:
	rm -f '../lib/runtime_hsst_56800E.lib'

large_program_small_data_hsst: ${c_SRC_large_program_small_data_hsst} ${asm_SRC_large_program_small_data_hsst} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_hsst} ${CFLAGS_large_program_small_data_hsst} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_hsst} ${AFLAGS_large_program_small_data_hsst} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime_hsst_56800E.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_hsst 
##############################
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data_hsst+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data_hsst+=../init/FSTART.asm
c_SRC_large_program_large_data_hsst+=../init/initsections.c
c_SRC_large_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data_hsst+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data_hsst+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data_hsst+=../cpp_support/New.cpp
c_SRC_large_program_large_data_hsst+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data_hsst+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data_hsst+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data_hsst+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data_hsst+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data_hsst+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data_hsst+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data_hsst+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data_hsst+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data_hsst+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data_hsst+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data_hsst+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data_hsst+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data_hsst+=../fp/fcoerce.asm
asm_SRC_large_program_large_data_hsst+=../fp/result_is.asm
asm_SRC_large_program_large_data_hsst+=../fp/utilities.asm
asm_SRC_large_program_large_data_hsst+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data_hsst+=../hostio/console_asm.asm
c_SRC_large_program_large_data_hsst+=../hostio/console_c.c
c_SRC_large_program_large_data_hsst+=../hostio/file_io.stub.c
c_SRC_large_program_large_data_hsst+=../hostio/hsst_hostio.c
asm_SRC_large_program_large_data_hsst+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data_hsst+=../crc_linker/crc.c
asm_SRC_large_program_large_data_hsst+=../ll/div_64.asm

CFLAGS_large_program_large_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -largedata -O0 -opt speed

AFLAGS_large_program_large_data_hsst+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24

clean_large_program_large_data_hsst:
	rm -f '../lib/runtime_hsst_56800E_lmm.lib'

large_program_large_data_hsst: ${c_SRC_large_program_large_data_hsst} ${asm_SRC_large_program_large_data_hsst} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_hsst} ${CFLAGS_large_program_large_data_hsst} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_hsst} ${AFLAGS_large_program_large_data_hsst} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime_hsst_56800E_lmm.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data 
##############################
asm_SRC_small_program_small_data+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_small_program_small_data+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_small_program_small_data+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_small_program_small_data+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_small_program_small_data+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_small_program_small_data+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_small_program_small_data+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_small_program_small_data+=../rtmpy/Rtmpy32.asm
asm_SRC_small_program_small_data+=../exit/EXIT_DSP.asm
c_SRC_small_program_small_data+=../exit/_ExitProcess.c
asm_SRC_small_program_small_data+=../save_reg/save_reg.asm
asm_SRC_small_program_small_data+=../init/FSTART.asm
c_SRC_small_program_small_data+=../init/initsections.c
c_SRC_small_program_small_data+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_small_program_small_data+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_small_program_small_data+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_small_program_small_data+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_small_program_small_data+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_small_program_small_data+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_small_program_small_data+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_small_program_small_data+=../cpp_support/global_destructor_chain.c
c_SRC_small_program_small_data+=../cpp_support/New.cpp
c_SRC_small_program_small_data+=../cpp_support/StaticInitializers.c
asm_SRC_small_program_small_data+=../fp/ARTADDF32U.asm
asm_SRC_small_program_small_data+=../fp/ARTCMPF32.asm
asm_SRC_small_program_small_data+=../fp/ARTDIVF32UZ.asm
asm_SRC_small_program_small_data+=../fp/ARTFCONV.asm
asm_SRC_small_program_small_data+=../fp/ARTMPYF32U.asm
asm_SRC_small_program_small_data+=../fp/ARTROUND.asm
asm_SRC_small_program_small_data+=../fp/ARTWCONV.asm
asm_SRC_small_program_small_data+=../fp/Fp56800E.asm
asm_SRC_small_program_small_data+=../fp/dispatch_x0.asm
asm_SRC_small_program_small_data+=../fp/fcoerce.asm
asm_SRC_small_program_small_data+=../fp/result_is.asm
asm_SRC_small_program_small_data+=../fp/utilities.asm
asm_SRC_small_program_small_data+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_small_program_small_data+=../hostio/console_asm.asm
c_SRC_small_program_small_data+=../hostio/console_c.c
c_SRC_small_program_small_data+=../hostio/file_io.stub.c
asm_SRC_small_program_small_data+=../hostio/hostio_asm.asm
asm_SRC_small_program_small_data+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_small_program_small_data+=../crc_linker/crc.c
asm_SRC_small_program_small_data+=../ll/div_64.asm

CFLAGS_small_program_small_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -smallprog -O0 -opt speed

AFLAGS_small_program_small_data+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 16

clean_small_program_small_data:
	rm -f '../lib/runtime 56800E smm.lib'

small_program_small_data: ${c_SRC_small_program_small_data} ${asm_SRC_small_program_small_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data} ${CFLAGS_small_program_small_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data} ${AFLAGS_small_program_small_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E smm.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD 
##############################
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_small_program_small_data_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_small_program_small_data_SLLD+=../exit/EXIT_DSP.asm
c_SRC_small_program_small_data_SLLD+=../exit/_ExitProcess.c
asm_SRC_small_program_small_data_SLLD+=../save_reg/save_reg.asm
asm_SRC_small_program_small_data_SLLD+=../init/FSTART.asm
c_SRC_small_program_small_data_SLLD+=../init/initsections.c
c_SRC_small_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_small_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_small_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_small_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_small_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_small_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_small_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_small_program_small_data_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_small_program_small_data_SLLD+=../cpp_support/New.cpp
c_SRC_small_program_small_data_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_small_program_small_data_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_small_program_small_data_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_small_program_small_data_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_small_program_small_data_SLLD+=../fp/ARTFCONV.asm
asm_SRC_small_program_small_data_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_small_program_small_data_SLLD+=../fp/ARTROUND.asm
asm_SRC_small_program_small_data_SLLD+=../fp/ARTWCONV.asm
asm_SRC_small_program_small_data_SLLD+=../fp/Fp56800E.asm
asm_SRC_small_program_small_data_SLLD+=../fp/dispatch_x0.asm
asm_SRC_small_program_small_data_SLLD+=../fp/fcoerce.asm
asm_SRC_small_program_small_data_SLLD+=../fp/result_is.asm
asm_SRC_small_program_small_data_SLLD+=../fp/utilities.asm
asm_SRC_small_program_small_data_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_small_program_small_data_SLLD+=../hostio/console_asm.asm
c_SRC_small_program_small_data_SLLD+=../hostio/console_c.c
c_SRC_small_program_small_data_SLLD+=../hostio/file_io.stub.c
asm_SRC_small_program_small_data_SLLD+=../hostio/hostio_asm.asm
asm_SRC_small_program_small_data_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_small_program_small_data_SLLD+=../crc_linker/crc.c
c_SRC_small_program_small_data_SLLD+=../fp/f_db_ll/src/dbllib.c
c_SRC_small_program_small_data_SLLD+=../fp/f_db_ll/src/dblutil.c
c_SRC_small_program_small_data_SLLD+=../fp/f_db_ll/src/llfltconv.c
c_SRC_small_program_small_data_SLLD+=../fp/f_db_ll/src/prototype.c
asm_SRC_small_program_small_data_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_small_program_small_data_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_small_program_small_data_SLLD+=../ll/div_64.asm
asm_SRC_small_program_small_data_SLLD+=../ll/smm/smm_ARTDIVLL64.asm
asm_SRC_small_program_small_data_SLLD+=../ll/smm/smm_ARTEQLL64.asm
asm_SRC_small_program_small_data_SLLD+=../ll/smm/smm_ARTNEGLL64.asm
asm_SRC_small_program_small_data_SLLD+=../ll/smm/smm_ARTSHLL64.asm

CFLAGS_small_program_small_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -smallprog -O0 -opt speed

AFLAGS_small_program_small_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 16 -V3

clean_small_program_small_data_SLLD:
	rm -f '../lib/runtime 56800E smm_SLLD.lib'

small_program_small_data_SLLD: ${c_SRC_small_program_small_data_SLLD} ${asm_SRC_small_program_small_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD} ${CFLAGS_small_program_small_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_SLLD} ${AFLAGS_small_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E smm_SLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD 
##############################
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data_SLLD+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data_SLLD+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data_SLLD+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data_SLLD+=../init/FSTART.asm
c_SRC_huge_program_small_data_SLLD+=../init/initsections.c
c_SRC_huge_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data_SLLD+=../cpp_support/New.cpp
c_SRC_huge_program_small_data_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/result_is.asm
asm_SRC_huge_program_small_data_SLLD+=../fp/utilities.asm
asm_SRC_huge_program_small_data_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data_SLLD+=../hostio/console_asm.asm
c_SRC_huge_program_small_data_SLLD+=../hostio/console_c.c
c_SRC_huge_program_small_data_SLLD+=../hostio/file_io.stub.c
asm_SRC_huge_program_small_data_SLLD+=../hostio/hostio_asm.asm
asm_SRC_huge_program_small_data_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data_SLLD+=../crc_linker/crc.c
c_SRC_huge_program_small_data_SLLD+=../fp/f_db_ll/src/dbllib.c
c_SRC_huge_program_small_data_SLLD+=../fp/f_db_ll/src/dblutil.c
c_SRC_huge_program_small_data_SLLD+=../fp/f_db_ll/src/llfltconv.c
c_SRC_huge_program_small_data_SLLD+=../fp/f_db_ll/src/prototype.c
asm_SRC_huge_program_small_data_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_small_data_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_small_data_SLLD+=../ll/div_64.asm
asm_SRC_huge_program_small_data_SLLD+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_huge_program_small_data_SLLD+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_huge_program_small_data_SLLD+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_huge_program_small_data_SLLD+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_huge_program_small_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -O0 -opt speed -hugeprog

AFLAGS_huge_program_small_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -V3

clean_huge_program_small_data_SLLD:
	rm -f '../lib/runtime 56800E HPM SLLD.lib'

huge_program_small_data_SLLD: ${c_SRC_huge_program_small_data_SLLD} ${asm_SRC_huge_program_small_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD} ${CFLAGS_huge_program_small_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_SLLD} ${AFLAGS_huge_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E HPM SLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_SLLD 
##############################
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data_SLLD+=../init/FSTART.asm
c_SRC_huge_program_large_data_SLLD+=../init/initsections.c
c_SRC_huge_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data_SLLD+=../cpp_support/New.cpp
c_SRC_huge_program_large_data_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data_SLLD+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data_SLLD+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data_SLLD+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/result_is.asm
asm_SRC_huge_program_large_data_SLLD+=../fp/utilities.asm
asm_SRC_huge_program_large_data_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data_SLLD+=../hostio/console_asm.asm
c_SRC_huge_program_large_data_SLLD+=../hostio/console_c.c
c_SRC_huge_program_large_data_SLLD+=../hostio/file_io.stub.c
asm_SRC_huge_program_large_data_SLLD+=../hostio/hostio_asm.asm
asm_SRC_huge_program_large_data_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data_SLLD+=../crc_linker/crc.c
c_SRC_huge_program_large_data_SLLD+=../fp/f_db_ll/src/dbllib.c
c_SRC_huge_program_large_data_SLLD+=../fp/f_db_ll/src/dblutil.c
c_SRC_huge_program_large_data_SLLD+=../fp/f_db_ll/src/llfltconv.c
c_SRC_huge_program_large_data_SLLD+=../fp/f_db_ll/src/prototype.c
asm_SRC_huge_program_large_data_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_large_data_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_large_data_SLLD+=../ll/div_64.asm
asm_SRC_huge_program_large_data_SLLD+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_huge_program_large_data_SLLD+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_huge_program_large_data_SLLD+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_huge_program_large_data_SLLD+=../ll/lmm/lmm_ARTSHLL64.asm

CFLAGS_huge_program_large_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -largedata -O0 -opt speed -hugeprog

AFLAGS_huge_program_large_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm -V3

clean_huge_program_large_data_SLLD:
	rm -f '../lib/runtime 56800E HPM LMM SLLD.lib'

huge_program_large_data_SLLD: ${c_SRC_huge_program_large_data_SLLD} ${asm_SRC_huge_program_large_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD} ${CFLAGS_huge_program_large_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_SLLD} ${AFLAGS_huge_program_large_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E HPM LMM SLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_hsst_SLLD 
##############################
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../init/FSTART.asm
c_SRC_huge_program_small_data_hsst_SLLD+=../init/initsections.c
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/New.cpp
c_SRC_huge_program_small_data_hsst_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data_hsst_SLLD+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data_hsst_SLLD+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data_hsst_SLLD+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/result_is.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../fp/utilities.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../hostio/console_asm.asm
c_SRC_huge_program_small_data_hsst_SLLD+=../hostio/console_c.c
c_SRC_huge_program_small_data_hsst_SLLD+=../hostio/file_io.stub.c
c_SRC_huge_program_small_data_hsst_SLLD+=../hostio/hsst_hostio.c
asm_SRC_huge_program_small_data_hsst_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data_hsst_SLLD+=../crc_linker/crc.c
asm_SRC_huge_program_small_data_hsst_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../ll/div_64.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_huge_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_huge_program_small_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -O0 -opt speed -hugeprog

AFLAGS_huge_program_small_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -V3

clean_huge_program_small_data_hsst_SLLD:
	rm -f '../lib/runtime_hsst_HPM_56800ESLLD.lib'

huge_program_small_data_hsst_SLLD: ${c_SRC_huge_program_small_data_hsst_SLLD} ${asm_SRC_huge_program_small_data_hsst_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_hsst_SLLD} ${CFLAGS_huge_program_small_data_hsst_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_hsst_SLLD} ${AFLAGS_huge_program_small_data_hsst_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime_hsst_HPM_56800ESLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_hsst_SLLD 
##############################
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../init/FSTART.asm
c_SRC_huge_program_large_data_hsst_SLLD+=../init/initsections.c
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/New.cpp
c_SRC_huge_program_large_data_hsst_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data_hsst_SLLD+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data_hsst_SLLD+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data_hsst_SLLD+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/result_is.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../fp/utilities.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../hostio/console_asm.asm
c_SRC_huge_program_large_data_hsst_SLLD+=../hostio/console_c.c
c_SRC_huge_program_large_data_hsst_SLLD+=../hostio/file_io.stub.c
c_SRC_huge_program_large_data_hsst_SLLD+=../hostio/hsst_hostio.c
asm_SRC_huge_program_large_data_hsst_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data_hsst_SLLD+=../crc_linker/crc.c
asm_SRC_huge_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTSHLL64.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_large_data_hsst_SLLD+=../ll/div_64.asm

CFLAGS_huge_program_large_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -largedata -O0 -opt speed -hugeprog

AFLAGS_huge_program_large_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24 -V3

clean_huge_program_large_data_hsst_SLLD:
	rm -f '../lib/run_hsst_HPM_56800E_lmmSLLD.lib'

huge_program_large_data_hsst_SLLD: ${c_SRC_huge_program_large_data_hsst_SLLD} ${asm_SRC_huge_program_large_data_hsst_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_hsst_SLLD} ${CFLAGS_huge_program_large_data_hsst_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_hsst_SLLD} ${AFLAGS_huge_program_large_data_hsst_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/run_hsst_HPM_56800E_lmmSLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD 
##############################
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data_SLLD+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data_SLLD+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data_SLLD+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data_SLLD+=../init/FSTART.asm
c_SRC_large_program_small_data_SLLD+=../init/initsections.c
c_SRC_large_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data_SLLD+=../cpp_support/New.cpp
c_SRC_large_program_small_data_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data_SLLD+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data_SLLD+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data_SLLD+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data_SLLD+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data_SLLD+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data_SLLD+=../fp/fcoerce.asm
asm_SRC_large_program_small_data_SLLD+=../fp/result_is.asm
asm_SRC_large_program_small_data_SLLD+=../fp/utilities.asm
asm_SRC_large_program_small_data_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data_SLLD+=../hostio/console_asm.asm
c_SRC_large_program_small_data_SLLD+=../hostio/console_c.c
c_SRC_large_program_small_data_SLLD+=../hostio/file_io.stub.c
asm_SRC_large_program_small_data_SLLD+=../hostio/hostio_asm.asm
asm_SRC_large_program_small_data_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data_SLLD+=../crc_linker/crc.c
c_SRC_large_program_small_data_SLLD+=../fp/f_db_ll/src/dbllib.c
c_SRC_large_program_small_data_SLLD+=../fp/f_db_ll/src/dblutil.c
c_SRC_large_program_small_data_SLLD+=../fp/f_db_ll/src/llfltconv.c
c_SRC_large_program_small_data_SLLD+=../fp/f_db_ll/src/prototype.c
asm_SRC_large_program_small_data_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_large_program_small_data_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_large_program_small_data_SLLD+=../ll/div_64.asm
asm_SRC_large_program_small_data_SLLD+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_large_program_small_data_SLLD+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_large_program_small_data_SLLD+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_large_program_small_data_SLLD+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_large_program_small_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -O0 -opt speed

AFLAGS_large_program_small_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -V3

clean_large_program_small_data_SLLD:
	rm -f '../lib/runtime 56800E_SLLD.lib'

large_program_small_data_SLLD: ${c_SRC_large_program_small_data_SLLD} ${asm_SRC_large_program_small_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD} ${CFLAGS_large_program_small_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_SLLD} ${AFLAGS_large_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E_SLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_SLLD 
##############################
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data_SLLD+=../init/FSTART.asm
c_SRC_large_program_large_data_SLLD+=../init/initsections.c
c_SRC_large_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data_SLLD+=../cpp_support/New.cpp
c_SRC_large_program_large_data_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data_SLLD+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data_SLLD+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data_SLLD+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data_SLLD+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data_SLLD+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data_SLLD+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data_SLLD+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data_SLLD+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data_SLLD+=../fp/fcoerce.asm
asm_SRC_large_program_large_data_SLLD+=../fp/result_is.asm
asm_SRC_large_program_large_data_SLLD+=../fp/utilities.asm
asm_SRC_large_program_large_data_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data_SLLD+=../hostio/console_asm.asm
c_SRC_large_program_large_data_SLLD+=../hostio/console_c.c
c_SRC_large_program_large_data_SLLD+=../hostio/file_io.stub.c
asm_SRC_large_program_large_data_SLLD+=../hostio/hostio_asm.asm
asm_SRC_large_program_large_data_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data_SLLD+=../crc_linker/crc.c
c_SRC_large_program_large_data_SLLD+=../fp/f_db_ll/src/dbllib.c
c_SRC_large_program_large_data_SLLD+=../fp/f_db_ll/src/dblutil.c
c_SRC_large_program_large_data_SLLD+=../fp/f_db_ll/src/llfltconv.c
c_SRC_large_program_large_data_SLLD+=../fp/f_db_ll/src/prototype.c
asm_SRC_large_program_large_data_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_large_program_large_data_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_large_program_large_data_SLLD+=../ll/div_64.asm
asm_SRC_large_program_large_data_SLLD+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_large_program_large_data_SLLD+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_large_program_large_data_SLLD+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_large_program_large_data_SLLD+=../ll/lmm/lmm_ARTSHLL64.asm

CFLAGS_large_program_large_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -largedata -O0 -opt speed

AFLAGS_large_program_large_data_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm -V3

clean_large_program_large_data_SLLD:
	rm -f '../lib/runtime 56800E lmm_SLLD.lib'

large_program_large_data_SLLD: ${c_SRC_large_program_large_data_SLLD} ${asm_SRC_large_program_large_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD} ${CFLAGS_large_program_large_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_SLLD} ${AFLAGS_large_program_large_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E lmm_SLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_hsst_SLLD 
##############################
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../init/FSTART.asm
c_SRC_large_program_small_data_hsst_SLLD+=../init/initsections.c
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/New.cpp
c_SRC_large_program_small_data_hsst_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data_hsst_SLLD+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data_hsst_SLLD+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data_hsst_SLLD+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/fcoerce.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/result_is.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../fp/utilities.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../hostio/console_asm.asm
c_SRC_large_program_small_data_hsst_SLLD+=../hostio/console_c.c
c_SRC_large_program_small_data_hsst_SLLD+=../hostio/file_io.stub.c
c_SRC_large_program_small_data_hsst_SLLD+=../hostio/hsst_hostio.c
asm_SRC_large_program_small_data_hsst_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data_hsst_SLLD+=../crc_linker/crc.c
asm_SRC_large_program_small_data_hsst_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../ll/div_64.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_large_program_small_data_hsst_SLLD+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_large_program_small_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -O0 -opt speed

AFLAGS_large_program_small_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -V3

clean_large_program_small_data_hsst_SLLD:
	rm -f '../lib/runtime_hsst_56800ESLLD.lib'

large_program_small_data_hsst_SLLD: ${c_SRC_large_program_small_data_hsst_SLLD} ${asm_SRC_large_program_small_data_hsst_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_hsst_SLLD} ${CFLAGS_large_program_small_data_hsst_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_hsst_SLLD} ${AFLAGS_large_program_small_data_hsst_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime_hsst_56800ESLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_hsst_SLLD 
##############################
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../init/FSTART.asm
c_SRC_large_program_large_data_hsst_SLLD+=../init/initsections.c
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/New.cpp
c_SRC_large_program_large_data_hsst_SLLD+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data_hsst_SLLD+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data_hsst_SLLD+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data_hsst_SLLD+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/fcoerce.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/result_is.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../fp/utilities.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../hostio/console_asm.asm
c_SRC_large_program_large_data_hsst_SLLD+=../hostio/console_c.c
c_SRC_large_program_large_data_hsst_SLLD+=../hostio/file_io.stub.c
c_SRC_large_program_large_data_hsst_SLLD+=../hostio/hsst_hostio.c
asm_SRC_large_program_large_data_hsst_SLLD+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data_hsst_SLLD+=../crc_linker/crc.c
asm_SRC_large_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../ll/lmm/lmm_ARTSHLL64.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../ll/ARTADDLL64.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../ll/ARTMULLL64.asm
asm_SRC_large_program_large_data_hsst_SLLD+=../ll/div_64.asm

CFLAGS_large_program_large_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -flag slld -largedata -O0 -opt speed

AFLAGS_large_program_large_data_hsst_SLLD+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../../hsst/'target side'/code/common\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24 -V3

clean_large_program_large_data_hsst_SLLD:
	rm -f '../lib/run_hsst_56800E_lmmSLLD.lib'

large_program_large_data_hsst_SLLD: ${c_SRC_large_program_large_data_hsst_SLLD} ${asm_SRC_large_program_large_data_hsst_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_hsst_SLLD} ${CFLAGS_large_program_large_data_hsst_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_hsst_SLLD} ${AFLAGS_large_program_large_data_hsst_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/run_hsst_56800E_lmmSLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_o4p 
##############################
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_small_program_small_data_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_small_program_small_data_o4p+=../exit/EXIT_DSP.asm
c_SRC_small_program_small_data_o4p+=../exit/_ExitProcess.c
asm_SRC_small_program_small_data_o4p+=../save_reg/save_reg.asm
asm_SRC_small_program_small_data_o4p+=../init/FSTART.asm
c_SRC_small_program_small_data_o4p+=../init/initsections.c
c_SRC_small_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_small_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_small_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_small_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_small_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_small_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_small_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_small_program_small_data_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_small_program_small_data_o4p+=../cpp_support/New.cpp
c_SRC_small_program_small_data_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_small_program_small_data_o4p+=../fp/ARTADDF32U.asm
asm_SRC_small_program_small_data_o4p+=../fp/ARTCMPF32.asm
asm_SRC_small_program_small_data_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_small_program_small_data_o4p+=../fp/ARTFCONV.asm
asm_SRC_small_program_small_data_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_small_program_small_data_o4p+=../fp/ARTROUND.asm
asm_SRC_small_program_small_data_o4p+=../fp/ARTWCONV.asm
asm_SRC_small_program_small_data_o4p+=../fp/Fp56800E.asm
asm_SRC_small_program_small_data_o4p+=../fp/dispatch_x0.asm
asm_SRC_small_program_small_data_o4p+=../fp/fcoerce.asm
asm_SRC_small_program_small_data_o4p+=../fp/result_is.asm
asm_SRC_small_program_small_data_o4p+=../fp/utilities.asm
asm_SRC_small_program_small_data_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_small_program_small_data_o4p+=../hostio/console_asm.asm
c_SRC_small_program_small_data_o4p+=../hostio/console_c.c
c_SRC_small_program_small_data_o4p+=../hostio/file_io.stub.c
asm_SRC_small_program_small_data_o4p+=../hostio/hostio_asm.asm
asm_SRC_small_program_small_data_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_small_program_small_data_o4p+=../crc_linker/crc.c
asm_SRC_small_program_small_data_o4p+=../ll/div_64.asm

CFLAGS_small_program_small_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -smallprog

AFLAGS_small_program_small_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 16

clean_small_program_small_data_o4p:
	rm -f '../lib/runtime 56800E smm o4p.lib'

small_program_small_data_o4p: ${c_SRC_small_program_small_data_o4p} ${asm_SRC_small_program_small_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_o4p} ${CFLAGS_small_program_small_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_o4p} ${AFLAGS_small_program_small_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E smm o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_o4p 
##############################
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data_o4p+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data_o4p+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data_o4p+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data_o4p+=../init/FSTART.asm
c_SRC_huge_program_small_data_o4p+=../init/initsections.c
c_SRC_huge_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data_o4p+=../cpp_support/New.cpp
c_SRC_huge_program_small_data_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data_o4p+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data_o4p+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data_o4p+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data_o4p+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data_o4p+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data_o4p+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data_o4p+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data_o4p+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data_o4p+=../fp/result_is.asm
asm_SRC_huge_program_small_data_o4p+=../fp/utilities.asm
asm_SRC_huge_program_small_data_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data_o4p+=../hostio/console_asm.asm
c_SRC_huge_program_small_data_o4p+=../hostio/console_c.c
c_SRC_huge_program_small_data_o4p+=../hostio/file_io.stub.c
asm_SRC_huge_program_small_data_o4p+=../hostio/hostio_asm.asm
asm_SRC_huge_program_small_data_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data_o4p+=../crc_linker/crc.c
asm_SRC_huge_program_small_data_o4p+=../ll/div_64.asm

CFLAGS_huge_program_small_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -hugeprog

AFLAGS_huge_program_small_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21

clean_huge_program_small_data_o4p:
	rm -f '../lib/runtime 56800E HPM o4p.lib'

huge_program_small_data_o4p: ${c_SRC_huge_program_small_data_o4p} ${asm_SRC_huge_program_small_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_o4p} ${CFLAGS_huge_program_small_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_o4p} ${AFLAGS_huge_program_small_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E HPM o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_o4p 
##############################
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data_o4p+=../init/FSTART.asm
c_SRC_huge_program_large_data_o4p+=../init/initsections.c
c_SRC_huge_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data_o4p+=../cpp_support/New.cpp
c_SRC_huge_program_large_data_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data_o4p+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data_o4p+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data_o4p+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data_o4p+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data_o4p+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data_o4p+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data_o4p+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data_o4p+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data_o4p+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data_o4p+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data_o4p+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data_o4p+=../fp/result_is.asm
asm_SRC_huge_program_large_data_o4p+=../fp/utilities.asm
asm_SRC_huge_program_large_data_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data_o4p+=../hostio/console_asm.asm
c_SRC_huge_program_large_data_o4p+=../hostio/console_c.c
c_SRC_huge_program_large_data_o4p+=../hostio/file_io.stub.c
asm_SRC_huge_program_large_data_o4p+=../hostio/hostio_asm.asm
asm_SRC_huge_program_large_data_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data_o4p+=../crc_linker/crc.c
asm_SRC_huge_program_large_data_o4p+=../ll/div_64.asm

CFLAGS_huge_program_large_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -largedata -hugeprog

AFLAGS_huge_program_large_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data_o4p:
	rm -f '../lib/runtime 56800E HPM LMM o4p.lib'

huge_program_large_data_o4p: ${c_SRC_huge_program_large_data_o4p} ${asm_SRC_huge_program_large_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_o4p} ${CFLAGS_huge_program_large_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_o4p} ${AFLAGS_huge_program_large_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E HPM LMM o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_o4p 
##############################
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data_o4p+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data_o4p+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data_o4p+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data_o4p+=../init/FSTART.asm
c_SRC_large_program_small_data_o4p+=../init/initsections.c
c_SRC_large_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data_o4p+=../cpp_support/New.cpp
c_SRC_large_program_small_data_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data_o4p+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data_o4p+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data_o4p+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data_o4p+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data_o4p+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data_o4p+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data_o4p+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data_o4p+=../fp/fcoerce.asm
asm_SRC_large_program_small_data_o4p+=../fp/result_is.asm
asm_SRC_large_program_small_data_o4p+=../fp/utilities.asm
asm_SRC_large_program_small_data_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data_o4p+=../hostio/console_asm.asm
c_SRC_large_program_small_data_o4p+=../hostio/console_c.c
c_SRC_large_program_small_data_o4p+=../hostio/file_io.stub.c
asm_SRC_large_program_small_data_o4p+=../hostio/hostio_asm.asm
asm_SRC_large_program_small_data_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data_o4p+=../crc_linker/crc.c
asm_SRC_large_program_small_data_o4p+=../ll/div_64.asm

CFLAGS_large_program_small_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested

AFLAGS_large_program_small_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19

clean_large_program_small_data_o4p:
	rm -f '../lib/runtime 56800E o4p.lib'

large_program_small_data_o4p: ${c_SRC_large_program_small_data_o4p} ${asm_SRC_large_program_small_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_o4p} ${CFLAGS_large_program_small_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_o4p} ${AFLAGS_large_program_small_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_o4p 
##############################
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data_o4p+=../init/FSTART.asm
c_SRC_large_program_large_data_o4p+=../init/initsections.c
c_SRC_large_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data_o4p+=../cpp_support/New.cpp
c_SRC_large_program_large_data_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data_o4p+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data_o4p+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data_o4p+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data_o4p+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data_o4p+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data_o4p+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data_o4p+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data_o4p+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data_o4p+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data_o4p+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data_o4p+=../fp/fcoerce.asm
asm_SRC_large_program_large_data_o4p+=../fp/result_is.asm
asm_SRC_large_program_large_data_o4p+=../fp/utilities.asm
asm_SRC_large_program_large_data_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data_o4p+=../hostio/console_asm.asm
c_SRC_large_program_large_data_o4p+=../hostio/console_c.c
c_SRC_large_program_large_data_o4p+=../hostio/file_io.stub.c
asm_SRC_large_program_large_data_o4p+=../hostio/hostio_asm.asm
asm_SRC_large_program_large_data_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data_o4p+=../crc_linker/crc.c
asm_SRC_large_program_large_data_o4p+=../ll/div_64.asm

CFLAGS_large_program_large_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -largedata

AFLAGS_large_program_large_data_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data_o4p:
	rm -f '../lib/runtime 56800E lmm o4p.lib'

large_program_large_data_o4p: ${c_SRC_large_program_large_data_o4p} ${asm_SRC_large_program_large_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_o4p} ${CFLAGS_large_program_large_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_o4p} ${AFLAGS_large_program_large_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E lmm o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD_o4p 
##############################
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../exit/EXIT_DSP.asm
c_SRC_small_program_small_data_SLLD_o4p+=../exit/_ExitProcess.c
asm_SRC_small_program_small_data_SLLD_o4p+=../save_reg/save_reg.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../init/FSTART.asm
c_SRC_small_program_small_data_SLLD_o4p+=../init/initsections.c
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/New.cpp
c_SRC_small_program_small_data_SLLD_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/ARTADDF32U.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/ARTCMPF32.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/ARTFCONV.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/ARTROUND.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/ARTWCONV.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/Fp56800E.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/dispatch_x0.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/fcoerce.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/result_is.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../fp/utilities.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../hostio/console_asm.asm
c_SRC_small_program_small_data_SLLD_o4p+=../hostio/console_c.c
c_SRC_small_program_small_data_SLLD_o4p+=../hostio/file_io.stub.c
asm_SRC_small_program_small_data_SLLD_o4p+=../hostio/hostio_asm.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_small_program_small_data_SLLD_o4p+=../crc_linker/crc.c
c_SRC_small_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/dbllib.c
c_SRC_small_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/dblutil.c
c_SRC_small_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/llfltconv.c
c_SRC_small_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/prototype.c
asm_SRC_small_program_small_data_SLLD_o4p+=../ll/ARTADDLL64.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../ll/ARTMULLL64.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../ll/div_64.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../ll/smm/smm_ARTDIVLL64.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../ll/smm/smm_ARTEQLL64.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../ll/smm/smm_ARTNEGLL64.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../ll/smm/smm_ARTSHLL64.asm

CFLAGS_small_program_small_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -flag slld -smallprog

AFLAGS_small_program_small_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 16 -V3

clean_small_program_small_data_SLLD_o4p:
	rm -f '../lib/run 56800E smm_SLLD o4p.lib'

small_program_small_data_SLLD_o4p: ${c_SRC_small_program_small_data_SLLD_o4p} ${asm_SRC_small_program_small_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD_o4p} ${CFLAGS_small_program_small_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_SLLD_o4p} ${AFLAGS_small_program_small_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E smm_SLLD o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD_o4p 
##############################
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data_SLLD_o4p+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data_SLLD_o4p+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../init/FSTART.asm
c_SRC_huge_program_small_data_SLLD_o4p+=../init/initsections.c
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/New.cpp
c_SRC_huge_program_small_data_SLLD_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/result_is.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../fp/utilities.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../hostio/console_asm.asm
c_SRC_huge_program_small_data_SLLD_o4p+=../hostio/console_c.c
c_SRC_huge_program_small_data_SLLD_o4p+=../hostio/file_io.stub.c
asm_SRC_huge_program_small_data_SLLD_o4p+=../hostio/hostio_asm.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data_SLLD_o4p+=../crc_linker/crc.c
c_SRC_huge_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/dbllib.c
c_SRC_huge_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/dblutil.c
c_SRC_huge_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/llfltconv.c
c_SRC_huge_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/prototype.c
asm_SRC_huge_program_small_data_SLLD_o4p+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../ll/div_64.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_huge_program_small_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -flag slld -hugeprog

AFLAGS_huge_program_small_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -prog 21 -V3

clean_huge_program_small_data_SLLD_o4p:
	rm -f '../lib/run 56800E HPM SLLD o4p.lib' 

huge_program_small_data_SLLD_o4p: ${c_SRC_huge_program_small_data_SLLD_o4p} ${asm_SRC_huge_program_small_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD_o4p} ${CFLAGS_huge_program_small_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_SLLD_o4p} ${AFLAGS_huge_program_small_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E HPM SLLD o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_SLLD_o4p 
##############################
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../init/FSTART.asm
c_SRC_huge_program_large_data_SLLD_o4p+=../init/initsections.c
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/New.cpp
c_SRC_huge_program_large_data_SLLD_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data_SLLD_o4p+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data_SLLD_o4p+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data_SLLD_o4p+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/result_is.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../fp/utilities.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../hostio/console_asm.asm
c_SRC_huge_program_large_data_SLLD_o4p+=../hostio/console_c.c
c_SRC_huge_program_large_data_SLLD_o4p+=../hostio/file_io.stub.c
asm_SRC_huge_program_large_data_SLLD_o4p+=../hostio/hostio_asm.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data_SLLD_o4p+=../crc_linker/crc.c
c_SRC_huge_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/dbllib.c
c_SRC_huge_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/dblutil.c
c_SRC_huge_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/llfltconv.c
c_SRC_huge_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/prototype.c
asm_SRC_huge_program_large_data_SLLD_o4p+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../ll/div_64.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTSHLL64.asm

CFLAGS_huge_program_large_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -flag slld -largedata -hugeprog

AFLAGS_huge_program_large_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm -V3

clean_huge_program_large_data_SLLD_o4p:
	rm -f '../lib/run 56800E HPM LMM SLLD o4p.lib' 

huge_program_large_data_SLLD_o4p: ${c_SRC_huge_program_large_data_SLLD_o4p} ${asm_SRC_huge_program_large_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD_o4p} ${CFLAGS_huge_program_large_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_SLLD_o4p} ${AFLAGS_huge_program_large_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E HPM LMM SLLD o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD_o4p 
##############################
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data_SLLD_o4p+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data_SLLD_o4p+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../init/FSTART.asm
c_SRC_large_program_small_data_SLLD_o4p+=../init/initsections.c
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/New.cpp
c_SRC_large_program_small_data_SLLD_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/fcoerce.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/result_is.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../fp/utilities.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../hostio/console_asm.asm
c_SRC_large_program_small_data_SLLD_o4p+=../hostio/console_c.c
c_SRC_large_program_small_data_SLLD_o4p+=../hostio/file_io.stub.c
asm_SRC_large_program_small_data_SLLD_o4p+=../hostio/hostio_asm.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data_SLLD_o4p+=../crc_linker/crc.c
c_SRC_large_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/dbllib.c
c_SRC_large_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/dblutil.c
c_SRC_large_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/llfltconv.c
c_SRC_large_program_small_data_SLLD_o4p+=../fp/f_db_ll/src/prototype.c
asm_SRC_large_program_small_data_SLLD_o4p+=../ll/ARTADDLL64.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../ll/ARTMULLL64.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../ll/div_64.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_large_program_small_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -flag slld 

AFLAGS_large_program_small_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -prog 19 -V3

clean_large_program_small_data_SLLD_o4p:
	rm -f '../lib/run 56800E_SLLD o4p.lib' 

large_program_small_data_SLLD_o4p: ${c_SRC_large_program_small_data_SLLD_o4p} ${asm_SRC_large_program_small_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD_o4p} ${CFLAGS_large_program_small_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_SLLD_o4p} ${AFLAGS_large_program_small_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E_SLLD o4p.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_SLLD_o4p 
##############################
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../init/FSTART.asm
c_SRC_large_program_large_data_SLLD_o4p+=../init/initsections.c
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/New.cpp
c_SRC_large_program_large_data_SLLD_o4p+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data_SLLD_o4p+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data_SLLD_o4p+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data_SLLD_o4p+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/fcoerce.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/result_is.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../fp/utilities.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../hostio/console_asm.asm
c_SRC_large_program_large_data_SLLD_o4p+=../hostio/console_c.c
c_SRC_large_program_large_data_SLLD_o4p+=../hostio/file_io.stub.c
asm_SRC_large_program_large_data_SLLD_o4p+=../hostio/hostio_asm.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data_SLLD_o4p+=../crc_linker/crc.c
c_SRC_large_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/dbllib.c
c_SRC_large_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/dblutil.c
c_SRC_large_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/llfltconv.c
c_SRC_large_program_large_data_SLLD_o4p+=../fp/f_db_ll/src/prototype.c
asm_SRC_large_program_large_data_SLLD_o4p+=../ll/ARTADDLL64.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../ll/ARTMULLL64.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../ll/div_64.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../ll/lmm/lmm_ARTSHLL64.asm

CFLAGS_large_program_large_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt speed -DO nested -flag slld -largedata

AFLAGS_large_program_large_data_SLLD_o4p+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm -V3

clean_large_program_large_data_SLLD_o4p:
	rm -f '../lib/run 56800E lmm_SLLD o4p.lib' 

large_program_large_data_SLLD_o4p: ${c_SRC_large_program_large_data_SLLD_o4p} ${asm_SRC_large_program_large_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD_o4p} ${CFLAGS_large_program_large_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_SLLD_o4p} ${AFLAGS_large_program_large_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E lmm_SLLD o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_o4s 
##############################
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_small_program_small_data_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_small_program_small_data_o4s+=../exit/EXIT_DSP.asm
c_SRC_small_program_small_data_o4s+=../exit/_ExitProcess.c
asm_SRC_small_program_small_data_o4s+=../save_reg/save_reg.asm
asm_SRC_small_program_small_data_o4s+=../init/FSTART.asm
c_SRC_small_program_small_data_o4s+=../init/initsections.c
c_SRC_small_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_small_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_small_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_small_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_small_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_small_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_small_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_small_program_small_data_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_small_program_small_data_o4s+=../cpp_support/New.cpp
c_SRC_small_program_small_data_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_small_program_small_data_o4s+=../fp/ARTADDF32U.asm
asm_SRC_small_program_small_data_o4s+=../fp/ARTCMPF32.asm
asm_SRC_small_program_small_data_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_small_program_small_data_o4s+=../fp/ARTFCONV.asm
asm_SRC_small_program_small_data_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_small_program_small_data_o4s+=../fp/ARTROUND.asm
asm_SRC_small_program_small_data_o4s+=../fp/ARTWCONV.asm
asm_SRC_small_program_small_data_o4s+=../fp/Fp56800E.asm
asm_SRC_small_program_small_data_o4s+=../fp/dispatch_x0.asm
asm_SRC_small_program_small_data_o4s+=../fp/fcoerce.asm
asm_SRC_small_program_small_data_o4s+=../fp/result_is.asm
asm_SRC_small_program_small_data_o4s+=../fp/utilities.asm
asm_SRC_small_program_small_data_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_small_program_small_data_o4s+=../hostio/console_asm.asm
c_SRC_small_program_small_data_o4s+=../hostio/console_c.c
c_SRC_small_program_small_data_o4s+=../hostio/file_io.stub.c
asm_SRC_small_program_small_data_o4s+=../hostio/hostio_asm.asm
asm_SRC_small_program_small_data_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_small_program_small_data_o4s+=../crc_linker/crc.c
asm_SRC_small_program_small_data_o4s+=../ll/div_64.asm

CFLAGS_small_program_small_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -smallprog

AFLAGS_small_program_small_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 16

clean_small_program_small_data_o4s:
	rm -f '../lib/runtime 56800E smm o4s.lib' 

small_program_small_data_o4s: ${c_SRC_small_program_small_data_o4s} ${asm_SRC_small_program_small_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_o4s} ${CFLAGS_small_program_small_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_o4s} ${AFLAGS_small_program_small_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E smm o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_o4s 
##############################
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data_o4s+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data_o4s+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data_o4s+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data_o4s+=../init/FSTART.asm
c_SRC_huge_program_small_data_o4s+=../init/initsections.c
c_SRC_huge_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data_o4s+=../cpp_support/New.cpp
c_SRC_huge_program_small_data_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data_o4s+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data_o4s+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data_o4s+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data_o4s+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data_o4s+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data_o4s+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data_o4s+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data_o4s+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data_o4s+=../fp/result_is.asm
asm_SRC_huge_program_small_data_o4s+=../fp/utilities.asm
asm_SRC_huge_program_small_data_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data_o4s+=../hostio/console_asm.asm
c_SRC_huge_program_small_data_o4s+=../hostio/console_c.c
c_SRC_huge_program_small_data_o4s+=../hostio/file_io.stub.c
asm_SRC_huge_program_small_data_o4s+=../hostio/hostio_asm.asm
asm_SRC_huge_program_small_data_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data_o4s+=../crc_linker/crc.c
asm_SRC_huge_program_small_data_o4s+=../ll/div_64.asm

CFLAGS_huge_program_small_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -hugeprog

AFLAGS_huge_program_small_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21

clean_huge_program_small_data_o4s:
	rm -f '../lib/runtime 56800E HPM o4s.lib' 

huge_program_small_data_o4s: ${c_SRC_huge_program_small_data_o4s} ${asm_SRC_huge_program_small_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_o4s} ${CFLAGS_huge_program_small_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_o4s} ${AFLAGS_huge_program_small_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E HPM o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_o4s 
##############################
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data_o4s+=../init/FSTART.asm
c_SRC_huge_program_large_data_o4s+=../init/initsections.c
c_SRC_huge_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data_o4s+=../cpp_support/New.cpp
c_SRC_huge_program_large_data_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data_o4s+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data_o4s+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data_o4s+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data_o4s+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data_o4s+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data_o4s+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data_o4s+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data_o4s+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data_o4s+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data_o4s+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data_o4s+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data_o4s+=../fp/result_is.asm
asm_SRC_huge_program_large_data_o4s+=../fp/utilities.asm
asm_SRC_huge_program_large_data_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data_o4s+=../hostio/console_asm.asm
c_SRC_huge_program_large_data_o4s+=../hostio/console_c.c
c_SRC_huge_program_large_data_o4s+=../hostio/file_io.stub.c
asm_SRC_huge_program_large_data_o4s+=../hostio/hostio_asm.asm
asm_SRC_huge_program_large_data_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data_o4s+=../crc_linker/crc.c
asm_SRC_huge_program_large_data_o4s+=../ll/div_64.asm

CFLAGS_huge_program_large_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -largedata -hugeprog

AFLAGS_huge_program_large_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data_o4s:
	rm -f '../lib/runtime 56800E HPM LMM o4s.lib' 

huge_program_large_data_o4s: ${c_SRC_huge_program_large_data_o4s} ${asm_SRC_huge_program_large_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_o4s} ${CFLAGS_huge_program_large_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_o4s} ${AFLAGS_huge_program_large_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E HPM LMM o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_o4s 
##############################
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data_o4s+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data_o4s+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data_o4s+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data_o4s+=../init/FSTART.asm
c_SRC_large_program_small_data_o4s+=../init/initsections.c
c_SRC_large_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data_o4s+=../cpp_support/New.cpp
c_SRC_large_program_small_data_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data_o4s+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data_o4s+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data_o4s+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data_o4s+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data_o4s+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data_o4s+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data_o4s+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data_o4s+=../fp/fcoerce.asm
asm_SRC_large_program_small_data_o4s+=../fp/result_is.asm
asm_SRC_large_program_small_data_o4s+=../fp/utilities.asm
asm_SRC_large_program_small_data_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data_o4s+=../hostio/console_asm.asm
c_SRC_large_program_small_data_o4s+=../hostio/console_c.c
c_SRC_large_program_small_data_o4s+=../hostio/file_io.stub.c
asm_SRC_large_program_small_data_o4s+=../hostio/hostio_asm.asm
asm_SRC_large_program_small_data_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data_o4s+=../crc_linker/crc.c
asm_SRC_large_program_small_data_o4s+=../ll/div_64.asm

CFLAGS_large_program_small_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space

AFLAGS_large_program_small_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19

clean_large_program_small_data_o4s:
	rm -f '../lib/runtime 56800E o4s.lib' 

large_program_small_data_o4s: ${c_SRC_large_program_small_data_o4s} ${asm_SRC_large_program_small_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_o4s} ${CFLAGS_large_program_small_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_o4s} ${AFLAGS_large_program_small_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_o4s 
##############################
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data_o4s+=../init/FSTART.asm
c_SRC_large_program_large_data_o4s+=../init/initsections.c
c_SRC_large_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data_o4s+=../cpp_support/New.cpp
c_SRC_large_program_large_data_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data_o4s+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data_o4s+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data_o4s+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data_o4s+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data_o4s+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data_o4s+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data_o4s+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data_o4s+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data_o4s+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data_o4s+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data_o4s+=../fp/fcoerce.asm
asm_SRC_large_program_large_data_o4s+=../fp/result_is.asm
asm_SRC_large_program_large_data_o4s+=../fp/utilities.asm
asm_SRC_large_program_large_data_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data_o4s+=../hostio/console_asm.asm
c_SRC_large_program_large_data_o4s+=../hostio/console_c.c
c_SRC_large_program_large_data_o4s+=../hostio/file_io.stub.c
asm_SRC_large_program_large_data_o4s+=../hostio/hostio_asm.asm
asm_SRC_large_program_large_data_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data_o4s+=../crc_linker/crc.c
asm_SRC_large_program_large_data_o4s+=../ll/div_64.asm

CFLAGS_large_program_large_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -largedata

AFLAGS_large_program_large_data_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data_o4s:
	rm -f '../lib/runtime 56800E lmm o4s.lib' 

large_program_large_data_o4s: ${c_SRC_large_program_large_data_o4s} ${asm_SRC_large_program_large_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_o4s} ${CFLAGS_large_program_large_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_o4s} ${AFLAGS_large_program_large_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/runtime 56800E lmm o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD_o4s 
##############################
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../exit/EXIT_DSP.asm
c_SRC_small_program_small_data_SLLD_o4s+=../exit/_ExitProcess.c
asm_SRC_small_program_small_data_SLLD_o4s+=../save_reg/save_reg.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../init/FSTART.asm
c_SRC_small_program_small_data_SLLD_o4s+=../init/initsections.c
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/New.cpp
c_SRC_small_program_small_data_SLLD_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/ARTADDF32U.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/ARTCMPF32.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/ARTFCONV.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/ARTROUND.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/ARTWCONV.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/Fp56800E.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/dispatch_x0.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/fcoerce.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/result_is.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../fp/utilities.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../hostio/console_asm.asm
c_SRC_small_program_small_data_SLLD_o4s+=../hostio/console_c.c
c_SRC_small_program_small_data_SLLD_o4s+=../hostio/file_io.stub.c
asm_SRC_small_program_small_data_SLLD_o4s+=../hostio/hostio_asm.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_small_program_small_data_SLLD_o4s+=../crc_linker/crc.c
c_SRC_small_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/dbllib.c
c_SRC_small_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/dblutil.c
c_SRC_small_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/llfltconv.c
c_SRC_small_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/prototype.c
asm_SRC_small_program_small_data_SLLD_o4s+=../ll/ARTADDLL64.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../ll/ARTMULLL64.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../ll/div_64.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../ll/smm/smm_ARTDIVLL64.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../ll/smm/smm_ARTEQLL64.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../ll/smm/smm_ARTNEGLL64.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../ll/smm/smm_ARTSHLL64.asm

CFLAGS_small_program_small_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -flag slld -smallprog

AFLAGS_small_program_small_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 16 -V3

clean_small_program_small_data_SLLD_o4s:
	rm -f '../lib/run 56800E smm_SLLD o4s.lib' 

small_program_small_data_SLLD_o4s: ${c_SRC_small_program_small_data_SLLD_o4s} ${asm_SRC_small_program_small_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD_o4s} ${CFLAGS_small_program_small_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_SLLD_o4s} ${AFLAGS_small_program_small_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E smm_SLLD o4s.lib' -g -sym on 
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD_o4s 
##############################
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../exit/EXIT_DSP.asm
c_SRC_huge_program_small_data_SLLD_o4s+=../exit/_ExitProcess.c
asm_SRC_huge_program_small_data_SLLD_o4s+=../save_reg/save_reg.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../init/FSTART.asm
c_SRC_huge_program_small_data_SLLD_o4s+=../init/initsections.c
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/New.cpp
c_SRC_huge_program_small_data_SLLD_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/ARTFCONV.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/ARTROUND.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/ARTWCONV.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/Fp56800E.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/dispatch_x0.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/fcoerce.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/result_is.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../fp/utilities.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../hostio/console_asm.asm
c_SRC_huge_program_small_data_SLLD_o4s+=../hostio/console_c.c
c_SRC_huge_program_small_data_SLLD_o4s+=../hostio/file_io.stub.c
asm_SRC_huge_program_small_data_SLLD_o4s+=../hostio/hostio_asm.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_small_data_SLLD_o4s+=../crc_linker/crc.c
c_SRC_huge_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/dbllib.c
c_SRC_huge_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/dblutil.c
c_SRC_huge_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/llfltconv.c
c_SRC_huge_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/prototype.c
asm_SRC_huge_program_small_data_SLLD_o4s+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../ll/div_64.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_huge_program_small_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -flag slld -hugeprog

AFLAGS_huge_program_small_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -V3

clean_huge_program_small_data_SLLD_o4s:
	rm -f '../lib/run 56800E HPM SLLD o4s.lib' 

huge_program_small_data_SLLD_o4s: ${c_SRC_huge_program_small_data_SLLD_o4s} ${asm_SRC_huge_program_small_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD_o4s} ${CFLAGS_huge_program_small_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_SLLD_o4s} ${AFLAGS_huge_program_small_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E HPM SLLD o4s.lib' -g -sym on 
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_SLLD_o4s 
##############################
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../init/FSTART.asm
c_SRC_huge_program_large_data_SLLD_o4s+=../init/initsections.c
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/New.cpp
c_SRC_huge_program_large_data_SLLD_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_huge_program_large_data_SLLD_o4s+=../exit/EXIT_DSP.asm
c_SRC_huge_program_large_data_SLLD_o4s+=../exit/_ExitProcess.c
asm_SRC_huge_program_large_data_SLLD_o4s+=../save_reg/save_reg.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/ARTADDF32U.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/ARTCMPF32.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/ARTFCONV.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/ARTROUND.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/ARTWCONV.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/Fp56800E.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/dispatch_x0.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/fcoerce.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/result_is.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../fp/utilities.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../hostio/console_asm.asm
c_SRC_huge_program_large_data_SLLD_o4s+=../hostio/console_c.c
c_SRC_huge_program_large_data_SLLD_o4s+=../hostio/file_io.stub.c
asm_SRC_huge_program_large_data_SLLD_o4s+=../hostio/hostio_asm.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_huge_program_large_data_SLLD_o4s+=../crc_linker/crc.c
c_SRC_huge_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/dbllib.c
c_SRC_huge_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/dblutil.c
c_SRC_huge_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/llfltconv.c
c_SRC_huge_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/prototype.c
asm_SRC_huge_program_large_data_SLLD_o4s+=../ll/ARTADDLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../ll/ARTMULLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../ll/div_64.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTSHLL64.asm

CFLAGS_huge_program_large_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -flag slld -largedata -hugeprog

AFLAGS_huge_program_large_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm -V3

clean_huge_program_large_data_SLLD_o4s:
	rm -f '../lib/run 56800E HPM LMM SLLD o4s.lib' 

huge_program_large_data_SLLD_o4s: ${c_SRC_huge_program_large_data_SLLD_o4s} ${asm_SRC_huge_program_large_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD_o4s} ${CFLAGS_huge_program_large_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_SLLD_o4s} ${AFLAGS_huge_program_large_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E HPM LMM SLLD o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD_o4s 
##############################
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../exit/EXIT_DSP.asm
c_SRC_large_program_small_data_SLLD_o4s+=../exit/_ExitProcess.c
asm_SRC_large_program_small_data_SLLD_o4s+=../save_reg/save_reg.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../init/FSTART.asm
c_SRC_large_program_small_data_SLLD_o4s+=../init/initsections.c
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/New.cpp
c_SRC_large_program_small_data_SLLD_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/ARTADDF32U.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/ARTCMPF32.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/ARTFCONV.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/ARTROUND.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/ARTWCONV.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/Fp56800E.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/dispatch_x0.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/fcoerce.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/result_is.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../fp/utilities.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../hostio/console_asm.asm
c_SRC_large_program_small_data_SLLD_o4s+=../hostio/console_c.c
c_SRC_large_program_small_data_SLLD_o4s+=../hostio/file_io.stub.c
asm_SRC_large_program_small_data_SLLD_o4s+=../hostio/hostio_asm.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_small_data_SLLD_o4s+=../crc_linker/crc.c
c_SRC_large_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/dbllib.c
c_SRC_large_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/dblutil.c
c_SRC_large_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/llfltconv.c
c_SRC_large_program_small_data_SLLD_o4s+=../fp/f_db_ll/src/prototype.c
asm_SRC_large_program_small_data_SLLD_o4s+=../ll/ARTADDLL64.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../ll/ARTMULLL64.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../ll/div_64.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTDIVLL64.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTEQLL64.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTNEGLL64.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../ll/sdm/sdm_ARTSHLL64.asm

CFLAGS_large_program_small_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -flag slld

AFLAGS_large_program_small_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -V3

clean_large_program_small_data_SLLD_o4s:
	rm -f '../lib/run 56800E_SLLD o4s.lib' 

large_program_small_data_SLLD_o4s: ${c_SRC_large_program_small_data_SLLD_o4s} ${asm_SRC_large_program_small_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD_o4s} ${CFLAGS_large_program_small_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_SLLD_o4s} ${AFLAGS_large_program_small_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E_SLLD o4s.lib' -g -sym on 
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_SLLD_o4s 
##############################
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVS16UZ.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv16/ARTDIVU16UZ.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVS32UZ_2.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/ARTDIVU32UZ_2.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_ls_canoverflow.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv32/idiv_uls_canoverflow.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMS16Z.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtrem16/ARTREMU16Z.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMS32Z_2.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtrem32/ARTREMU32Z_2.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../rtmpy/Rtmpy32.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../init/FSTART.asm
c_SRC_large_program_large_data_SLLD_o4s+=../init/initsections.c
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_clear.c
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_alloc.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_onetimeinit.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_ptmf.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_rtti.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_pure.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/cxxabi/cxxabi_badeh.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/global_destructor_chain.c
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/New.cpp
c_SRC_large_program_large_data_SLLD_o4s+=../cpp_support/StaticInitializers.c
asm_SRC_large_program_large_data_SLLD_o4s+=../exit/EXIT_DSP.asm
c_SRC_large_program_large_data_SLLD_o4s+=../exit/_ExitProcess.c
asm_SRC_large_program_large_data_SLLD_o4s+=../save_reg/save_reg.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/ARTADDF32U.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/ARTCMPF32.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/ARTDIVF32UZ.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/ARTFCONV.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/ARTMPYF32U.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/ARTROUND.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/ARTWCONV.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/Fp56800E.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/dispatch_x0.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/fcoerce.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/result_is.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../fp/utilities.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../math_support/Rtdiv8/ARTDIVS8UZ.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../hostio/console_asm.asm
c_SRC_large_program_large_data_SLLD_o4s+=../hostio/console_c.c
c_SRC_large_program_large_data_SLLD_o4s+=../hostio/file_io.stub.c
asm_SRC_large_program_large_data_SLLD_o4s+=../hostio/hostio_asm.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../rtmpy_upperresult/ARTDIVREC_S32_01.asm
c_SRC_large_program_large_data_SLLD_o4s+=../crc_linker/crc.c
c_SRC_large_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/dbllib.c
c_SRC_large_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/dblutil.c
c_SRC_large_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/llfltconv.c
c_SRC_large_program_large_data_SLLD_o4s+=../fp/f_db_ll/src/prototype.c
asm_SRC_large_program_large_data_SLLD_o4s+=../ll/ARTADDLL64.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../ll/ARTMULLL64.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../ll/div_64.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTDIVLL64.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTEQLL64.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTNEGLL64.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../ll/lmm/lmm_ARTSHLL64.asm

CFLAGS_large_program_large_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -inline smart,bottomup -g -sym on -O4 -opt space -flag slld -largedata

AFLAGS_large_program_large_data_SLLD_o4s+= -ir ../init\
 -ir ../exit\
 -ir ../hostio\
 -ir ../rtmpy\
 -ir ../fp\
 -ir ../math_support\
 -ir ../save_reg\
 -ir ../include\
 -ir ../../msl/MSL_C/DSP_56800E/inc\
 -ir ../../msl/MSL_C/MSL_Common/Include\
 -ir ../../msl/MSL_C/DSP_56800E/prefix\
 -ir ../../msl/MSL_C++/DSP_56800E/inc\
 -ir ../../msl/MSL_C++/MSL_Common/Include\
 -ir ../../runtime_56800E/include\
 -ir ../rtmpy_upperresult\
 -ir ../crc_linker\
 -ir ../ll\
 -ir ../ll\
 -ir ../ll -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm -V3

clean_large_program_large_data_SLLD_o4s:
	rm -f '../lib/run 56800E lmm_SLLD o4s.lib' 

large_program_large_data_SLLD_o4s: ${c_SRC_large_program_large_data_SLLD_o4s} ${asm_SRC_large_program_large_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD_o4s} ${CFLAGS_large_program_large_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_SLLD_o4s} ${AFLAGS_large_program_large_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/run 56800E lmm_SLLD o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################

# end Makefile



