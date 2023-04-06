# Tools definition 
#
# This should be an environment variable
# Reset environment vars you explicitly want to override
#

# CWINSTALL :  
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
	clean_small_program_small_data_SLLD_o4p clean_large_program_small_data_SLLD_o4p \
	clean_large_program_large_data_SLLD_o4p clean_small_program_small_data_o4s clean_large_program_small_data_o4s \
	clean_large_program_large_data_o4s clean_small_program_small_data_SLLD_o4s \
	clean_large_program_small_data_SLLD_o4s clean_large_program_large_data_SLLD_o4s \
	clean_huge_program_small_data clean_huge_program_large_data clean_huge_program_small_data_SLLD \
	clean_huge_program_large_data_SLLD clean_huge_program_small_data_o4p clean_huge_program_large_data_o4p \
	clean_huge_program_small_data_SLLD_o4p clean_huge_program_large_data_SLLD_o4p clean_huge_program_small_data_o4s \
	clean_huge_program_large_data_o4s clean_huge_program_small_data_SLLD_o4s clean_huge_program_large_data_SLLD_o4s


##############################
#######  TARGET: huge_program_small_data 
##############################
asm_SRC_huge_program_small_data+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_small_data+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/float.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/string.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_small_data+=../../MSL_Common/Src/time.c
c_SRC_huge_program_small_data+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_small_data+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_small_data+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_small_data+=../src/msl_overrides/exp.c
c_SRC_huge_program_small_data+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_small_data+=../src/msl_overrides/log.c
c_SRC_huge_program_small_data+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_small_data+=../src/msl_overrides/pow.c
c_SRC_huge_program_small_data+=../src/ansi_fp/ansi_fp.c
asm_SRC_huge_program_small_data+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_small_data+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_small_data+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_small_data+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_small_data+=../asm_src/signal/Fsignal.asm
asm_SRC_huge_program_small_data+=../asm_src/math/Ffabs.asm
asm_SRC_huge_program_small_data+=../asm_src/math/Ffrexp.asm
asm_SRC_huge_program_small_data+=../asm_src/math/Fldexp.asm
asm_SRC_huge_program_small_data+=../asm_src/math/Fmodf.asm
c_SRC_huge_program_small_data+=../src/hostio/hostio.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_huge_program_small_data+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_small_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O0 -opt speed -hugeprog

AFLAGS_huge_program_small_data= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21

clean_huge_program_small_data:
	rm -f '../lib/MSL C 56800E HPM.lib'

huge_program_small_data: ${c_SRC_huge_program_small_data} ${asm_SRC_huge_program_small_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data} ${CFLAGS_huge_program_small_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data} ${AFLAGS_huge_program_small_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data 
##############################
asm_SRC_huge_program_large_data+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_large_data+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/float.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/string.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_large_data+=../../MSL_Common/Src/time.c
c_SRC_huge_program_large_data+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_large_data+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_large_data+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_large_data+=../src/msl_overrides/exp.c
c_SRC_huge_program_large_data+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_large_data+=../src/msl_overrides/log.c
c_SRC_huge_program_large_data+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_large_data+=../src/msl_overrides/pow.c
c_SRC_huge_program_large_data+=../src/ansi_fp/ansi_fp.c
asm_SRC_huge_program_large_data+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_large_data+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_large_data+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_large_data+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_large_data+=../asm_src/signal/Fsignal.asm
asm_SRC_huge_program_large_data+=../asm_src/math/Ffabs.asm
asm_SRC_huge_program_large_data+=../asm_src/math/Ffrexp.asm
asm_SRC_huge_program_large_data+=../asm_src/math/Fldexp.asm
asm_SRC_huge_program_large_data+=../asm_src/math/Fmodf.asm
c_SRC_huge_program_large_data+=../src/hostio/hostio.c
asm_SRC_huge_program_large_data+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_huge_program_large_data+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_large_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -largedata -O0 -opt speed -hugeprog

AFLAGS_huge_program_large_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data:
	rm -f '../lib/MSL C 56800E HPM LMM.lib'

huge_program_large_data: ${c_SRC_huge_program_large_data} ${asm_SRC_huge_program_large_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data} ${CFLAGS_huge_program_large_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data} ${AFLAGS_huge_program_large_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM LMM.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data 
##############################
asm_SRC_large_program_small_data+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_small_data+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/arith.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/assert.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/errno.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/float.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/locale.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/mem.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/printf.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/rand.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/string.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_small_data+=../../MSL_Common/Src/time.c
c_SRC_large_program_small_data+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_small_data+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_small_data+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_small_data+=../src/msl_overrides/exp.c
c_SRC_large_program_small_data+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_small_data+=../src/msl_overrides/log.c
c_SRC_large_program_small_data+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_small_data+=../src/msl_overrides/pow.c
c_SRC_large_program_small_data+=../src/ansi_fp/ansi_fp.c
asm_SRC_large_program_small_data+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_small_data+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_small_data+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_small_data+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_small_data+=../asm_src/signal/Fsignal.asm
asm_SRC_large_program_small_data+=../asm_src/math/Ffabs.asm
asm_SRC_large_program_small_data+=../asm_src/math/Ffrexp.asm
asm_SRC_large_program_small_data+=../asm_src/math/Fldexp.asm
asm_SRC_large_program_small_data+=../asm_src/math/Fmodf.asm
c_SRC_large_program_small_data+=../src/hostio/hostio.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_large_program_small_data+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_small_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O0 -opt speed

AFLAGS_large_program_small_data= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_large_program_small_data:
	rm -f '../lib/MSL C 56800E.lib'

large_program_small_data: ${c_SRC_large_program_small_data} ${asm_SRC_large_program_small_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data} ${CFLAGS_large_program_small_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data} ${AFLAGS_large_program_small_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data 
##############################
asm_SRC_large_program_large_data+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_large_data+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/arith.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/assert.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/errno.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/float.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/locale.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/mem.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/printf.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/rand.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/string.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_large_data+=../../MSL_Common/Src/time.c
c_SRC_large_program_large_data+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_large_data+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_large_data+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_large_data+=../src/msl_overrides/exp.c
c_SRC_large_program_large_data+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_large_data+=../src/msl_overrides/log.c
c_SRC_large_program_large_data+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_large_data+=../src/msl_overrides/pow.c
c_SRC_large_program_large_data+=../src/ansi_fp/ansi_fp.c
asm_SRC_large_program_large_data+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_large_data+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_large_data+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_large_data+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_large_data+=../asm_src/signal/Fsignal.asm
asm_SRC_large_program_large_data+=../asm_src/math/Ffabs.asm
asm_SRC_large_program_large_data+=../asm_src/math/Ffrexp.asm
asm_SRC_large_program_large_data+=../asm_src/math/Fldexp.asm
asm_SRC_large_program_large_data+=../asm_src/math/Fmodf.asm
c_SRC_large_program_large_data+=../src/hostio/hostio.c
asm_SRC_large_program_large_data+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_large_program_large_data+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_large_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -largedata -O0 -opt speed

AFLAGS_large_program_large_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data:
	rm -f '../lib/MSL C 56800E LMM.lib'

large_program_large_data: ${c_SRC_large_program_large_data} ${asm_SRC_large_program_large_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data} ${CFLAGS_large_program_large_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data} ${AFLAGS_large_program_large_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E LMM.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data 
##############################
asm_SRC_small_program_small_data+=../asm_src/stack/getcurrentsp.asm
c_SRC_small_program_small_data+=../../MSL_Common/Src/alloc.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/ansi_files.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/arith.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/assert.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/bsearch.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/buffer_io.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/char_io.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/ctype.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/direct_io.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/errno.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/file_io.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/file_pos.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/float.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/locale.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/math_api.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/math_double.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/math_float.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/math_fma.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/math_longdouble.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/mbstring.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/mem.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/mem_funcs.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/misc_io.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/pool_alloc.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/printf.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/qsort.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/rand.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/scanf.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/secure_error.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/string.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/strtold.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/strtoul.c
c_SRC_small_program_small_data+=../../MSL_Common/Src/time.c
c_SRC_small_program_small_data+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_small_program_small_data+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_small_program_small_data+=../src/msl_overrides/dsp_float.c
c_SRC_small_program_small_data+=../src/msl_overrides/exp.c
c_SRC_small_program_small_data+=../src/msl_overrides/fenv_58800E.c
c_SRC_small_program_small_data+=../src/msl_overrides/log.c
c_SRC_small_program_small_data+=../src/msl_overrides/math_56800E.c
c_SRC_small_program_small_data+=../src/msl_overrides/pow.c
c_SRC_small_program_small_data+=../src/ansi_fp/ansi_fp.c
asm_SRC_small_program_small_data+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_small_program_small_data+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_small_program_small_data+=../asm_src/signal/F__sig_err.asm
asm_SRC_small_program_small_data+=../asm_src/signal/Fraise.asm
asm_SRC_small_program_small_data+=../asm_src/signal/Fsignal.asm
asm_SRC_small_program_small_data+=../asm_src/math/Ffabs.asm
asm_SRC_small_program_small_data+=../asm_src/math/Ffrexp.asm
asm_SRC_small_program_small_data+=../asm_src/math/Fldexp.asm
asm_SRC_small_program_small_data+=../asm_src/math/Fmodf.asm
c_SRC_small_program_small_data+=../src/hostio/hostio.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_small_program_small_data+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_small_program_small_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -smallprog -O0 -opt speed

AFLAGS_small_program_small_data+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_small_program_small_data:
	rm -f '../lib/MSL C 56800E smm.lib'

small_program_small_data: ${c_SRC_small_program_small_data} ${asm_SRC_small_program_small_data} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data} ${CFLAGS_small_program_small_data} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data} ${AFLAGS_small_program_small_data} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E smm.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD 
##############################
TOP_small_program_small_data_SLLD=E:\Soft\Hawk1\M56800E Support\msl\MSL_C\DSP_56800E\projects\
WD_small_program_small_data_SLLD=$(shell cd ${TOP_small_program_small_data_SLLD};echo `pwd`)

asm_SRC_small_program_small_data_SLLD+=../asm_src/stack/getcurrentsp.asm
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/alloc.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/ansi_files.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/arith.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/assert.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/bsearch.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/buffer_io.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/char_io.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/ctype.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/direct_io.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/errno.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/file_io.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/file_pos.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/float.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/locale.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/math_api.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/math_double.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/math_float.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/math_fma.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/math_longdouble.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/mbstring.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/mem.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/mem_funcs.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/misc_io.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/pool_alloc.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/printf.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/qsort.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/rand.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/scanf.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/secure_error.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/string.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/strtold.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/strtoul.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common/Src/time.c
c_SRC_small_program_small_data_SLLD+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_small_program_small_data_SLLD+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_small_program_small_data_SLLD+=../src/msl_overrides/dsp_float.c
c_SRC_small_program_small_data_SLLD+=../src/msl_overrides/exp.c
c_SRC_small_program_small_data_SLLD+=../src/msl_overrides/fenv_58800E.c
c_SRC_small_program_small_data_SLLD+=../src/msl_overrides/log.c
c_SRC_small_program_small_data_SLLD+=../src/msl_overrides/math_56800E.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_small_program_small_data_SLLD+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_small_program_small_data_SLLD+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_small_program_small_data_SLLD+=../asm_src/signal/F__sig_err.asm
asm_SRC_small_program_small_data_SLLD+=../asm_src/signal/Fraise.asm
asm_SRC_small_program_small_data_SLLD+=../asm_src/signal/Fsignal.asm
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_small_program_small_data_SLLD+=../src/hostio/hostio.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_small_program_small_data_SLLD+=../../MSL_Common_Embedded/Src/math_sun.c

obj_small_program_small_data_SLLD+=$(asm_SRC_small_program_small_data_SLLD:.asm=.obj)

obj_small_program_small_data_SLLD+=$(c_SRC_small_program_small_data_SLLD:.c=.obj)

CFLAGS_small_program_small_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -smallprog

AFLAGS_small_program_small_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_small_program_small_data_SLLD:
	rm -f '../lib/MSL C 56800E smm_SLLD.lib'

small_program_small_data_SLLD: ${c_SRC_small_program_small_data_SLLD} ${asm_SRC_small_program_small_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD} ${CFLAGS_small_program_small_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_SLLD} ${AFLAGS_small_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E smm_SLLD.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD 
##############################
asm_SRC_huge_program_small_data_SLLD+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/float.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/string.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common/Src/time.c
c_SRC_huge_program_small_data_SLLD+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_small_data_SLLD+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_small_data_SLLD+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_small_data_SLLD+=../src/msl_overrides/exp.c
c_SRC_huge_program_small_data_SLLD+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_small_data_SLLD+=../src/msl_overrides/log.c
c_SRC_huge_program_small_data_SLLD+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_huge_program_small_data_SLLD+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_small_data_SLLD+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_small_data_SLLD+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_small_data_SLLD+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_small_data_SLLD+=../asm_src/signal/Fsignal.asm
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_huge_program_small_data_SLLD+=../src/hostio/hostio.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_huge_program_small_data_SLLD+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_small_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -hugeprog

AFLAGS_huge_program_small_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21

clean_huge_program_small_data_SLLD:
	rm -f '../lib/MSL C 56800E HPM SLLD.lib'

huge_program_small_data_SLLD: ${c_SRC_huge_program_small_data_SLLD} ${asm_SRC_huge_program_small_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD} ${CFLAGS_huge_program_small_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_SLLD} ${AFLAGS_huge_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM SLLD.lib' -g -sym on
	rm -f $@_bin/*.o


##############################
#######  TARGET: huge_program_large_data_SLLD 
##############################
asm_SRC_huge_program_large_data_SLLD+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/float.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/string.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common/Src/time.c
c_SRC_huge_program_large_data_SLLD+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_large_data_SLLD+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_large_data_SLLD+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_large_data_SLLD+=../src/msl_overrides/exp.c
c_SRC_huge_program_large_data_SLLD+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_large_data_SLLD+=../src/msl_overrides/log.c
c_SRC_huge_program_large_data_SLLD+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_huge_program_large_data_SLLD+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_large_data_SLLD+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_large_data_SLLD+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_large_data_SLLD+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_large_data_SLLD+=../asm_src/signal/Fsignal.asm
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_huge_program_large_data_SLLD+=../src/hostio/hostio.c
asm_SRC_huge_program_large_data_SLLD+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_huge_program_large_data_SLLD+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_large_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -largedata -hugeprog

AFLAGS_huge_program_large_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data_SLLD:
	rm -f '../lib/MSL C 56800E HPM LMM SLLD.lib'

huge_program_large_data_SLLD: ${c_SRC_huge_program_large_data_SLLD} ${asm_SRC_huge_program_large_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD} ${CFLAGS_huge_program_large_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_SLLD} ${AFLAGS_huge_program_large_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM LMM SLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o 

##############################
#######  TARGET: large_program_small_data_SLLD 
##############################
asm_SRC_large_program_small_data_SLLD+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/arith.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/assert.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/errno.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/float.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/locale.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/mem.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/printf.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/rand.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/string.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common/Src/time.c
c_SRC_large_program_small_data_SLLD+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_small_data_SLLD+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_small_data_SLLD+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_small_data_SLLD+=../src/msl_overrides/exp.c
c_SRC_large_program_small_data_SLLD+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_small_data_SLLD+=../src/msl_overrides/log.c
c_SRC_large_program_small_data_SLLD+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_large_program_small_data_SLLD+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_small_data_SLLD+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_small_data_SLLD+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_small_data_SLLD+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_small_data_SLLD+=../asm_src/signal/Fsignal.asm
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_large_program_small_data_SLLD+=../src/hostio/hostio.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_large_program_small_data_SLLD+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_small_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld

AFLAGS_large_program_small_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_large_program_small_data_SLLD:
	rm -f '../lib/MSL C 56800E_SLLD.lib'

large_program_small_data_SLLD: ${c_SRC_large_program_small_data_SLLD} ${asm_SRC_large_program_small_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD} ${CFLAGS_large_program_small_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_SLLD} ${AFLAGS_large_program_small_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E_SLLD.lib' -g -sym on
	rm -f $@_bin/*.o


##############################
#######  TARGET: large_program_large_data_SLLD 
##############################
asm_SRC_large_program_large_data_SLLD+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/arith.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/assert.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/errno.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/float.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/locale.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/mem.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/printf.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/rand.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/string.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common/Src/time.c
c_SRC_large_program_large_data_SLLD+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_large_data_SLLD+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_large_data_SLLD+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_large_data_SLLD+=../src/msl_overrides/exp.c
c_SRC_large_program_large_data_SLLD+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_large_data_SLLD+=../src/msl_overrides/log.c
c_SRC_large_program_large_data_SLLD+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_large_program_large_data_SLLD+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_large_data_SLLD+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_large_data_SLLD+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_large_data_SLLD+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_large_data_SLLD+=../asm_src/signal/Fsignal.asm
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_large_program_large_data_SLLD+=../src/hostio/hostio.c
asm_SRC_large_program_large_data_SLLD+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_large_program_large_data_SLLD+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_large_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O0 -opt speed -flag slld -largedata

AFLAGS_large_program_large_data_SLLD+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data_SLLD:
	rm -f '../lib/MSL C 56800E lmm_SLLD.lib'

large_program_large_data_SLLD: ${c_SRC_large_program_large_data_SLLD} ${asm_SRC_large_program_large_data_SLLD} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD} ${CFLAGS_large_program_large_data_SLLD} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_SLLD} ${AFLAGS_large_program_large_data_SLLD} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E lmm_SLLD.lib' -g -sym on -largedata
	rm -f $@_bin/*.o 

##############################
#######  TARGET: small_program_small_data_o4p 
##############################
asm_SRC_small_program_small_data_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/arith.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/assert.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/errno.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/float.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/locale.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/mem.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/printf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/rand.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/string.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common/Src/time.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/exp.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/log.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_small_program_small_data_o4p+=../src/msl_overrides/pow.c
c_SRC_small_program_small_data_o4p+=../src/ansi_fp/ansi_fp.c
asm_SRC_small_program_small_data_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/signal/Fsignal.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/math/Ffabs.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/math/Ffrexp.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/math/Fldexp.asm
asm_SRC_small_program_small_data_o4p+=../asm_src/math/Fmodf.asm
c_SRC_small_program_small_data_o4p+=../src/hostio/hostio.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_small_program_small_data_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_small_program_small_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -smallprog

AFLAGS_small_program_small_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_small_program_small_data_o4p:
	rm -f '../lib/MSL C 56800E smm o4p.lib'

small_program_small_data_o4p: ${c_SRC_small_program_small_data_o4p} ${asm_SRC_small_program_small_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_o4p} ${CFLAGS_small_program_small_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_o4p} ${AFLAGS_small_program_small_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E smm o4p.lib' -g -sym on
	rm -f $@_bin/*.o  

##############################
#######  TARGET: huge_program_small_data_o4p 
##############################
asm_SRC_huge_program_small_data_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/float.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/string.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common/Src/time.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/exp.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/log.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_small_data_o4p+=../src/msl_overrides/pow.c
c_SRC_huge_program_small_data_o4p+=../src/ansi_fp/ansi_fp.c
asm_SRC_huge_program_small_data_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/signal/Fsignal.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/math/Ffabs.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/math/Ffrexp.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/math/Fldexp.asm
asm_SRC_huge_program_small_data_o4p+=../asm_src/math/Fmodf.asm
c_SRC_huge_program_small_data_o4p+=../src/hostio/hostio.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_huge_program_small_data_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_small_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -hugeprog

AFLAGS_huge_program_small_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21

clean_huge_program_small_data_o4p:
	rm -f '../lib/MSL C 56800E HPM o4p.lib'

huge_program_small_data_o4p: ${c_SRC_huge_program_small_data_o4p} ${asm_SRC_huge_program_small_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_o4p} ${CFLAGS_huge_program_small_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_o4p} ${AFLAGS_huge_program_small_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM o4p.lib' -g -sym on
	rm -f $@_bin/*.o  

##############################
#######  TARGET: huge_program_large_data_o4p 
##############################
asm_SRC_huge_program_large_data_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/float.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/string.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common/Src/time.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/exp.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/log.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_large_data_o4p+=../src/msl_overrides/pow.c
c_SRC_huge_program_large_data_o4p+=../src/ansi_fp/ansi_fp.c
asm_SRC_huge_program_large_data_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/signal/Fsignal.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/math/Ffabs.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/math/Ffrexp.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/math/Fldexp.asm
asm_SRC_huge_program_large_data_o4p+=../asm_src/math/Fmodf.asm
c_SRC_huge_program_large_data_o4p+=../src/hostio/hostio.c
asm_SRC_huge_program_large_data_o4p+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_huge_program_large_data_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_large_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -largedata -hugeprog

AFLAGS_huge_program_large_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data_o4p:
	rm -f '../lib/MSL C 56800E HPM LMM o4p.lib'

huge_program_large_data_o4p: ${c_SRC_huge_program_large_data_o4p} ${asm_SRC_huge_program_large_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_o4p} ${CFLAGS_huge_program_large_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_o4p} ${AFLAGS_huge_program_large_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM LMM o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_o4p 
##############################
asm_SRC_large_program_small_data_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/arith.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/assert.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/errno.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/float.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/locale.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/mem.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/printf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/rand.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/string.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common/Src/time.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/exp.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/log.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_small_data_o4p+=../src/msl_overrides/pow.c
c_SRC_large_program_small_data_o4p+=../src/ansi_fp/ansi_fp.c
asm_SRC_large_program_small_data_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/signal/Fsignal.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/math/Ffabs.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/math/Ffrexp.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/math/Fldexp.asm
asm_SRC_large_program_small_data_o4p+=../asm_src/math/Fmodf.asm
c_SRC_large_program_small_data_o4p+=../src/hostio/hostio.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_large_program_small_data_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_small_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested 

AFLAGS_large_program_small_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_large_program_small_data_o4p:
	rm -f '../lib/MSL C 56800E o4p.lib'

large_program_small_data_o4p: ${c_SRC_large_program_small_data_o4p} ${asm_SRC_large_program_small_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_o4p} ${CFLAGS_large_program_small_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_o4p} ${AFLAGS_large_program_small_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E o4p.lib' -g -sym on
	rm -f $@_bin/*.o  

##############################
#######  TARGET: large_program_large_data_o4p 
##############################
asm_SRC_large_program_large_data_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/arith.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/assert.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/errno.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/float.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/locale.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/mem.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/printf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/rand.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/string.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common/Src/time.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/exp.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/log.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_large_data_o4p+=../src/msl_overrides/pow.c
c_SRC_large_program_large_data_o4p+=../src/ansi_fp/ansi_fp.c
asm_SRC_large_program_large_data_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/signal/Fsignal.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/math/Ffabs.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/math/Ffrexp.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/math/Fldexp.asm
asm_SRC_large_program_large_data_o4p+=../asm_src/math/Fmodf.asm
c_SRC_large_program_large_data_o4p+=../src/hostio/hostio.c
asm_SRC_large_program_large_data_o4p+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_large_program_large_data_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_large_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -largedata

AFLAGS_large_program_large_data_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data_o4p:
	rm -f '../lib/MSL C 56800E lmm o4p.lib'

large_program_large_data_o4p: ${c_SRC_large_program_large_data_o4p} ${asm_SRC_large_program_large_data_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_o4p} ${CFLAGS_large_program_large_data_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_o4p} ${AFLAGS_large_program_large_data_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E lmm o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o  

##############################
#######  TARGET: small_program_small_data_SLLD_o4p 
##############################
asm_SRC_small_program_small_data_SLLD_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/arith.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/assert.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/errno.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/float.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/locale.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mem.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/printf.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/rand.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/string.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common/Src/time.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/msl_overrides/exp.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/msl_overrides/log.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_small_program_small_data_SLLD_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_small_program_small_data_SLLD_o4p+=../asm_src/signal/Fsignal.asm
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_small_program_small_data_SLLD_o4p+=../src/hostio/hostio.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_small_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_small_program_small_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -smallprog

AFLAGS_small_program_small_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_small_program_small_data_SLLD_o4p:
	rm -f '../lib/MSL C 56800Esmm_SLLDo4p.lib'

small_program_small_data_SLLD_o4p: ${c_SRC_small_program_small_data_SLLD_o4p} ${asm_SRC_small_program_small_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD_o4p} ${CFLAGS_small_program_small_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_SLLD_o4p} ${AFLAGS_small_program_small_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800Esmm_SLLDo4p.lib' -g -sym on
	rm -f $@_bin/*.o  

##############################
#######  TARGET: huge_program_small_data_SLLD_o4p 
##############################
asm_SRC_huge_program_small_data_SLLD_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/float.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/string.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common/Src/time.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/msl_overrides/exp.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/msl_overrides/log.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_huge_program_small_data_SLLD_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_small_data_SLLD_o4p+=../asm_src/signal/Fsignal.asm
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_huge_program_small_data_SLLD_o4p+=../src/hostio/hostio.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_huge_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_small_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -hugeprog

AFLAGS_huge_program_small_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21

clean_huge_program_small_data_SLLD_o4p:
	rm -f '../lib/MSL C 56800E HPM SLLD o4p.lib'

huge_program_small_data_SLLD_o4p: ${c_SRC_huge_program_small_data_SLLD_o4p} ${asm_SRC_huge_program_small_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD_o4p} ${CFLAGS_huge_program_small_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_SLLD_o4p} ${AFLAGS_huge_program_small_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM SLLD o4p.lib' -g -sym on
	rm -f $@_bin/*.o


##############################
#######  TARGET: huge_program_large_data_SLLD_o4p 
##############################
asm_SRC_huge_program_large_data_SLLD_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/float.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/string.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common/Src/time.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/msl_overrides/exp.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/msl_overrides/log.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_huge_program_large_data_SLLD_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_large_data_SLLD_o4p+=../asm_src/signal/Fsignal.asm
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_huge_program_large_data_SLLD_o4p+=../src/hostio/hostio.c
asm_SRC_huge_program_large_data_SLLD_o4p+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_huge_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_large_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -largedata -hugeprog

AFLAGS_huge_program_large_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data_SLLD_o4p:
	rm -f '../lib/MSL C 56800E HPM LMM SLLD o4p.lib'

huge_program_large_data_SLLD_o4p: ${c_SRC_huge_program_large_data_SLLD_o4p} ${asm_SRC_huge_program_large_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD_o4p} ${CFLAGS_huge_program_large_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_SLLD_o4p} ${AFLAGS_huge_program_large_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM LMM SLLD o4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD_o4p 
##############################
asm_SRC_large_program_small_data_SLLD_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/arith.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/assert.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/errno.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/float.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/locale.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mem.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/printf.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/rand.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/string.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common/Src/time.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/msl_overrides/exp.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/msl_overrides/log.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_large_program_small_data_SLLD_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_small_data_SLLD_o4p+=../asm_src/signal/Fsignal.asm
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_large_program_small_data_SLLD_o4p+=../src/hostio/hostio.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_large_program_small_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_small_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld

AFLAGS_large_program_small_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_large_program_small_data_SLLD_o4p:
	rm -f '../lib/MSL C 56800E_SLLD o4p.lib'

large_program_small_data_SLLD_o4p: ${c_SRC_large_program_small_data_SLLD_o4p} ${asm_SRC_large_program_small_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD_o4p} ${CFLAGS_large_program_small_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_SLLD_o4p} ${AFLAGS_large_program_small_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E_SLLD o4p.lib' -g -sym on
	rm -f $@_bin/*.o


##############################
#######  TARGET: large_program_large_data_SLLD_o4p 
##############################
asm_SRC_large_program_large_data_SLLD_o4p+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/arith.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/assert.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/errno.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/float.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/locale.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/mem.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/printf.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/rand.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/string.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common/Src/time.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/msl_overrides/exp.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/msl_overrides/log.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_large_program_large_data_SLLD_o4p+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_large_data_SLLD_o4p+=../asm_src/signal/Fsignal.asm
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_large_program_large_data_SLLD_o4p+=../src/hostio/hostio.c
asm_SRC_large_program_large_data_SLLD_o4p+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_large_program_large_data_SLLD_o4p+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_large_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt speed -DO nested -flag slld -largedata

AFLAGS_large_program_large_data_SLLD_o4p+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data_SLLD_o4p:
	rm -f '../lib/MSL C 56800Elmm_SLLDo4p.lib'

large_program_large_data_SLLD_o4p: ${c_SRC_large_program_large_data_SLLD_o4p} ${asm_SRC_large_program_large_data_SLLD_o4p} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD_o4p} ${CFLAGS_large_program_large_data_SLLD_o4p} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_SLLD_o4p} ${AFLAGS_large_program_large_data_SLLD_o4p} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800Elmm_SLLDo4p.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_o4s 
##############################
asm_SRC_small_program_small_data_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/arith.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/assert.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/errno.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/float.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/locale.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/mem.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/printf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/rand.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/string.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common/Src/time.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/exp.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/log.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_small_program_small_data_o4s+=../src/msl_overrides/pow.c
c_SRC_small_program_small_data_o4s+=../src/ansi_fp/ansi_fp.c
asm_SRC_small_program_small_data_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/signal/Fsignal.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/math/Ffabs.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/math/Ffrexp.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/math/Fldexp.asm
asm_SRC_small_program_small_data_o4s+=../asm_src/math/Fmodf.asm
c_SRC_small_program_small_data_o4s+=../src/hostio/hostio.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_small_program_small_data_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_small_program_small_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -smallprog

AFLAGS_small_program_small_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_small_program_small_data_o4s:
	rm -f '../lib/MSL C 56800E smm o4s.lib'

small_program_small_data_o4s: ${c_SRC_small_program_small_data_o4s} ${asm_SRC_small_program_small_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_o4s} ${CFLAGS_small_program_small_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_o4s} ${AFLAGS_small_program_small_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E smm o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_o4s 
##############################
asm_SRC_huge_program_small_data_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/float.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/string.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common/Src/time.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/exp.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/log.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_small_data_o4s+=../src/msl_overrides/pow.c
c_SRC_huge_program_small_data_o4s+=../src/ansi_fp/ansi_fp.c
asm_SRC_huge_program_small_data_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/signal/Fsignal.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/math/Ffabs.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/math/Ffrexp.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/math/Fldexp.asm
asm_SRC_huge_program_small_data_o4s+=../asm_src/math/Fmodf.asm
c_SRC_huge_program_small_data_o4s+=../src/hostio/hostio.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_huge_program_small_data_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_small_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -hugeprog

AFLAGS_huge_program_small_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21

clean_huge_program_small_data_o4s:
	rm -f '../lib/MSL C 56800E HPM o4s.lib'

huge_program_small_data_o4s: ${c_SRC_huge_program_small_data_o4s} ${asm_SRC_huge_program_small_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_o4s} ${CFLAGS_huge_program_small_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_o4s} ${AFLAGS_huge_program_small_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_o4s 
##############################
asm_SRC_huge_program_large_data_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/float.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/string.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common/Src/time.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/exp.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/log.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_large_data_o4s+=../src/msl_overrides/pow.c
c_SRC_huge_program_large_data_o4s+=../src/ansi_fp/ansi_fp.c
asm_SRC_huge_program_large_data_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/signal/Fsignal.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/math/Ffabs.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/math/Ffrexp.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/math/Fldexp.asm
asm_SRC_huge_program_large_data_o4s+=../asm_src/math/Fmodf.asm
c_SRC_huge_program_large_data_o4s+=../src/hostio/hostio.c
asm_SRC_huge_program_large_data_o4s+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_huge_program_large_data_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_large_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -largedata -hugeprog

AFLAGS_huge_program_large_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data_o4s:
	rm -f '../lib/MSL C 56800E HPM LMM o4s.lib'

huge_program_large_data_o4s: ${c_SRC_huge_program_large_data_o4s} ${asm_SRC_huge_program_large_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_o4s} ${CFLAGS_huge_program_large_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_o4s} ${AFLAGS_huge_program_large_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM LMM o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_o4s 
##############################
asm_SRC_large_program_small_data_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/arith.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/assert.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/errno.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/float.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/locale.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/mem.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/printf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/rand.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/string.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common/Src/time.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/exp.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/log.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_small_data_o4s+=../src/msl_overrides/pow.c
c_SRC_large_program_small_data_o4s+=../src/ansi_fp/ansi_fp.c
asm_SRC_large_program_small_data_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/signal/Fsignal.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/math/Ffabs.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/math/Ffrexp.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/math/Fldexp.asm
asm_SRC_large_program_small_data_o4s+=../asm_src/math/Fmodf.asm
c_SRC_large_program_small_data_o4s+=../src/hostio/hostio.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_large_program_small_data_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_small_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space

AFLAGS_large_program_small_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_large_program_small_data_o4s:
	rm -f '../lib/MSL C 56800E o4s.lib'

large_program_small_data_o4s: ${c_SRC_large_program_small_data_o4s} ${asm_SRC_large_program_small_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_o4s} ${CFLAGS_large_program_small_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_o4s} ${AFLAGS_large_program_small_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_o4s 
##############################
asm_SRC_large_program_large_data_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/arith.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/assert.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/errno.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/float.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/locale.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/mem.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/printf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/rand.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/string.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common/Src/time.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/exp.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/log.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_large_data_o4s+=../src/msl_overrides/pow.c
c_SRC_large_program_large_data_o4s+=../src/ansi_fp/ansi_fp.c
asm_SRC_large_program_large_data_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/signal/Fsignal.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/math/Ffabs.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/math/Ffrexp.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/math/Fldexp.asm
asm_SRC_large_program_large_data_o4s+=../asm_src/math/Fmodf.asm
c_SRC_large_program_large_data_o4s+=../src/hostio/hostio.c
asm_SRC_large_program_large_data_o4s+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acosf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_acoshf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_asinf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atan2f.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_atanhf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_coshf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_fmodf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_hypotf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_rem_pio2f.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_remainderf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sinhf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_sqrtf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_expf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/e_logf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/fminmaxdimf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_cosf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_rem_pio2f.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_sinf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/k_tanf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_asinhf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_atanf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ceilf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_copysignf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_cosf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_expm1f.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_floorf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_ilogbf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_log1pf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_logbf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_rintf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_sinf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/s_tanhf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acosf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_acoshf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_asinf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atan2f.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_atanhf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_coshf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_fmodf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_hypotf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_remainderf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sinhf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Math/Single_precision/w_sqrtf.c
c_SRC_large_program_large_data_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_large_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -largedata

AFLAGS_large_program_large_data_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data_o4s:
	rm -f '../lib/MSL C 56800E lmm o4s.lib'

large_program_large_data_o4s: ${c_SRC_large_program_large_data_o4s} ${asm_SRC_large_program_large_data_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_o4s} ${CFLAGS_large_program_large_data_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_o4s} ${AFLAGS_large_program_large_data_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E lmm o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: small_program_small_data_SLLD_o4s 
##############################
asm_SRC_small_program_small_data_SLLD_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/arith.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/assert.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/errno.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/float.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/locale.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mem.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/printf.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/rand.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/string.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common/Src/time.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/msl_overrides/exp.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/msl_overrides/log.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_small_program_small_data_SLLD_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_small_program_small_data_SLLD_o4s+=../asm_src/signal/Fsignal.asm
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_small_program_small_data_SLLD_o4s+=../src/hostio/hostio.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_small_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_small_program_small_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -smallprog

AFLAGS_small_program_small_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_small_program_small_data_SLLD_o4s:
	rm -f '../lib/MSL C 56800Esmm_SLLDo4s.lib'

small_program_small_data_SLLD_o4s: ${c_SRC_small_program_small_data_SLLD_o4s} ${asm_SRC_small_program_small_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_small_program_small_data_SLLD_o4s} ${CFLAGS_small_program_small_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_small_program_small_data_SLLD_o4s} ${AFLAGS_small_program_small_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800Esmm_SLLDo4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_small_data_SLLD_o4s 
##############################
asm_SRC_huge_program_small_data_SLLD_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/float.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/string.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common/Src/time.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/msl_overrides/exp.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/msl_overrides/log.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_huge_program_small_data_SLLD_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_small_data_SLLD_o4s+=../asm_src/signal/Fsignal.asm
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_huge_program_small_data_SLLD_o4s+=../src/hostio/hostio.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_huge_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_small_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -hugeprog

AFLAGS_huge_program_small_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21

clean_huge_program_small_data_SLLD_o4s:
	rm -f '../lib/MSL C 56800E HPM SLLD o4s.lib'

huge_program_small_data_SLLD_o4s: ${c_SRC_huge_program_small_data_SLLD_o4s} ${asm_SRC_huge_program_small_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_small_data_SLLD_o4s} ${CFLAGS_huge_program_small_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_small_data_SLLD_o4s} ${AFLAGS_huge_program_small_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM SLLD o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: huge_program_large_data_SLLD_o4s 
##############################
asm_SRC_huge_program_large_data_SLLD_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/arith.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/assert.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/errno.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/float.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/locale.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/mem.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/printf.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/rand.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/string.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common/Src/time.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/msl_overrides/exp.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/msl_overrides/log.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_huge_program_large_data_SLLD_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_huge_program_large_data_SLLD_o4s+=../asm_src/signal/Fsignal.asm
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_huge_program_large_data_SLLD_o4s+=../src/hostio/hostio.c
asm_SRC_huge_program_large_data_SLLD_o4s+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_huge_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_huge_program_large_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -largedata -hugeprog

AFLAGS_huge_program_large_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 21 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_huge_program_large_data_SLLD_o4s:
	rm -f '../lib/MSL C 56800E HPM LMM SLLD o4s.lib'

huge_program_large_data_SLLD_o4s: ${c_SRC_huge_program_large_data_SLLD_o4s} ${asm_SRC_huge_program_large_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_huge_program_large_data_SLLD_o4s} ${CFLAGS_huge_program_large_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_huge_program_large_data_SLLD_o4s} ${AFLAGS_huge_program_large_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E HPM LMM SLLD o4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_small_data_SLLD_o4s 
##############################
asm_SRC_large_program_small_data_SLLD_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/arith.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/assert.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/errno.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/float.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/locale.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mem.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/printf.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/rand.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/string.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common/Src/time.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/msl_overrides/exp.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/msl_overrides/log.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_large_program_small_data_SLLD_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_small_data_SLLD_o4s+=../asm_src/signal/Fsignal.asm
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_large_program_small_data_SLLD_o4s+=../src/hostio/hostio.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_large_program_small_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_small_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -flag slld

AFLAGS_large_program_small_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19

clean_large_program_small_data_SLLD_o4s:
	rm -f '../lib/MSL C 56800E_SLLD o4s.lib'

large_program_small_data_SLLD_o4s: ${c_SRC_large_program_small_data_SLLD_o4s} ${asm_SRC_large_program_small_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_small_data_SLLD_o4s} ${CFLAGS_large_program_small_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_small_data_SLLD_o4s} ${AFLAGS_large_program_small_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800E_SLLD o4s.lib' -g -sym on
	rm -f $@_bin/*.o

##############################
#######  TARGET: large_program_large_data_SLLD_o4s 
##############################
asm_SRC_large_program_large_data_SLLD_o4s+=../asm_src/stack/getcurrentsp.asm
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/alloc.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/ansi_files.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/arith.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/assert.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/bsearch.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/buffer_io.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/char_io.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/ctype.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/direct_io.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/errno.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/file_io.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/file_pos.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/float.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/locale.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_api.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_double.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_float.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_fma.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/math_longdouble.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/mbstring.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/mem.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/mem_funcs.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/misc_io.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/pool_alloc.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/printf.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/qsort.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/rand.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/scanf.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/secure_error.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/string.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/strtold.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/strtoul.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common/Src/time.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/msl_overrides/abort_exit_dsp568E.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/msl_overrides/critical_regions.dsp568E.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/msl_overrides/dsp_float.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/msl_overrides/exp.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/msl_overrides/fenv_58800E.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/msl_overrides/log.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/msl_overrides/math_56800E.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_pow.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_pow.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/ansi_fp.c
asm_SRC_large_program_large_data_SLLD_o4s+=../asm_src/setjmp/Flongjmp.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../asm_src/setjmp/Fsetjmp.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../asm_src/signal/F__sig_err.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../asm_src/signal/Fraise.asm
asm_SRC_large_program_large_data_SLLD_o4s+=../asm_src/signal/Fsignal.asm
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_fabs.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_frexp.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ldexp.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_modf.c
c_SRC_large_program_large_data_SLLD_o4s+=../src/hostio/hostio.c
asm_SRC_large_program_large_data_SLLD_o4s+=../prefix/msl_prefix_dsp_lmm.asm
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acos.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_acosh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_asin.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atan2.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_atanh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_cosh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_fmod.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_gamma_r.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_hypot.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_lgamma_r.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_rem_pio2.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_remainder.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sinh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_sqrt.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/e_log.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/fminmaxdim.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_cos.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_rem_pio2.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_sin.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_standard.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/k_tan.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_asinh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_atan.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cbrt.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ceil.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_copysign.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_cos.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_erf.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_expm1.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_floor.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_ilogb.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_lib_version.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_log1p.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_logb.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_matherr.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_nextafter.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_rint.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_signgam.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_sin.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tan.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/s_tanh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acos.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_acosh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_asin.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atan2.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_atanh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_cosh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_fmod.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_gamma_r.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_hypot.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_lgamma_r.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_remainder.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sinh.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Math/Double_precision/w_sqrt.c
c_SRC_large_program_large_data_SLLD_o4s+=../../MSL_Common_Embedded/Src/math_sun.c

CFLAGS_large_program_large_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -inline off -g -sym on -O4 -opt space -flag slld -largedata

AFLAGS_large_program_large_data_SLLD_o4s+= -ir ../prefix\
 -ir ../inc\
 -ir ../src\
 -ir ../asm_src\
 -ir ../../MSL_Common/Src\
 -ir ../../MSL_Common/Include\
 -ir ../../MSL_Common\
 -ir ../../../../runtime_56800E\
 -ir ../../MSL_Common_Embedded/Math/Double_precision\
 -ir ../../MSL_Common_Embedded/Src\
 -ir ../../MSL_Common_Embedded/Math/Include -nosyspath -debug -prog 19 -data 24 -prefix msl_prefix_dsp_lmm.asm

clean_large_program_large_data_SLLD_o4s:
	rm -f '../lib/MSL C 56800Elmm_SLLDo4s.lib'

large_program_large_data_SLLD_o4s: ${c_SRC_large_program_large_data_SLLD_o4s} ${asm_SRC_large_program_large_data_SLLD_o4s} 
	mkdir -p $@_bin
	$(COMPILE) -o $@_bin/ -c ${c_SRC_large_program_large_data_SLLD_o4s} ${CFLAGS_large_program_large_data_SLLD_o4s} 
	$(ASSEMBLER) -o $@_bin/ -c ${asm_SRC_large_program_large_data_SLLD_o4s} ${AFLAGS_large_program_large_data_SLLD_o4s} 
	$(LINK) -library $@_bin/*.o -o '../lib/MSL C 56800Elmm_SLLDo4s.lib' -g -sym on -largedata
	rm -f $@_bin/*.o

##############################

# end Makefile
