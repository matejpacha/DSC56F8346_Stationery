



; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




;RSJ    Cashes crash UseRep	EQU	1
	
;===============================================================================
; GLOBAL DATA: fpe_state -- one word of state per process, indicating the
;	prevailing rouding mode and holding the sticky exception flags.
;
	SECTION	fp_state GLOBAL
	ORG	X:
FPE_state:
	DC	$0000
	ENDSEC




;===============================================================================
; SECTION: the floating point code
	SECTION	fp_engine
	ORG P:
	OPT	CC
	XREF	FPE_state
	GLOBAL	ARTCMPF32
	GLOBAL	ARTCMPEF32

;	Specific compare routines
	GLOBAL	FARTEQF32
	GLOBAL	FARTNEF32
	GLOBAL	FARTGEF32
	GLOBAL	FARTLEF32
	GLOBAL	FARTGTF32
	GLOBAL	FARTLTF32
	GLOBAL	ARTEQF32
	GLOBAL	ARTNEF32
	GLOBAL	ARTGEF32
	GLOBAL	ARTLEF32
	GLOBAL	ARTGTF32
	GLOBAL	ARTLTF32

	GLOBAL  ARTMPYF32U
	GLOBAL	ARTADDF32U
	GLOBAL	ARTSUBF32U
	GLOBAL	ARTDIVF32UZ
	GLOBAL	FARTROUND
	GLOBAL	FARTGETFPSCR
	GLOBAL	FARTSETFPSCR
	GLOBAL	ARTF32_TO_U16U
	GLOBAL	ARTF32_TO_S16U
	GLOBAL	ARTF32_TO_U32U
	GLOBAL	ARTF32_TO_S32U
	GLOBAL	ARTU16_TO_F32
	GLOBAL	ARTS16_TO_F32
	GLOBAL	ARTU32_TO_F32
	GLOBAL	ARTS32_TO_F32
	

; xhi/xlo save the x operand (passed in a) in two-op functions, which
;	is handy for NaN handling, etc.
; yhi/ylo save the y operand (passed in b) in two-op functions, which
;	is handy for NaN handling, etc.
; rexp is the result exponent
; rsign is the result sign (compute as xor during unpack)
; yflip is 0 for add, 0x8000 for sub, to indicate a flip of y's sign
xhi	EQU	0
xlo	EQU	1
yhi	EQU	2
ylo	EQU	3
yflip	EQU	4
rsign	EQU	5
rexp	EQU	6

;offsets for the unpack routines.
xhi_unp	EQU	2
xlo_unp	EQU	3
yhi_unp	EQU	4
ylo_unp	EQU	5
yflip_unp	EQU	6
rsign_unp	EQU	7
rexp_unp	EQU	8


INVALID		EQU	$0040
OVERFLOW	EQU	$0010
UNDERFLOW	EQU	$0008
DIVBYZERO	EQU	$0020
INEXACT		EQU	$0004

TONEAREST	EQU	0
TOWARDZERO	EQU	1
UPWARD		EQU	2
DOWNWARD	EQU	3
BITDIRRND	EQU	2
BITDOWNORCHOP		EQU	1

LFPState	MACRO
	move.w	x:FPE_state,x0 ; jrusso LMM- let 16-24bit asm switch handle instr len
	ENDM
	
SetInvalid	MACRO
	bfset	#INVALID,x:FPE_state ; jrusso LMM
	ENDM
	
SetInexact	MACRO
	bfset	#INEXACT,x:FPE_state ; jrusso LMM
	ENDM
	
SetOverflow	MACRO
	bfset	#(OVERFLOW+INEXACT),x:FPE_state  ; jrusso LMM
	ENDM
	
SetUnderflow	MACRO
	bfset	#(UNDERFLOW+INEXACT),x:FPE_state ; jrusso LMM
	ENDM
	
SetDivByZero	MACRO
	bfset	#DIVBYZERO,x:FPE_state ; jrusso LMM
	ENDM
	
StFPState	MACRO
	move.w	x0,x:FPE_state ; jrusso LMM
	ENDM


;===============================================================================
; FUNCTION: FARTCMPF32, FARTCMPEF32
; DESCRIPTION: Comparison functions, all described here because of commonality.
;
; INPUT: x in a, y in b
; OUTPUT: y0 = result
;	FARTCMPF32  --> 0-eq, 1-lt, 2-gt, 3-un (invalid if an SNaN)
;	FARTCMPEF32 --> 0-eq, 1-lt, 2-gt, 3-un (invalid if unordered)
;	In both cases, the condition codes are set as follows
;
;    | <  =  >  ?  <-- IEEE relation discovered, '?' means 'unordered'
;  --+------------
;  C | 1  0  0  0  <-- setting of condition codes on exit from function
;  Z | 0  1  0  0
;  N | 1  0  0  0
;  V | 0  0  0  1
;
; Here's how to use the CCs to implement C-style branches:
;
;         |  neg.  |  "fp"  |                          |
;  rel_op | rel_op | branch | DSP568 branch (with CC)  | op
; --------+--------+-----------------------------------+------------
;    !=   |   ==   |  fbeq  |  beq  (Z = 1)            | FARTCMPF32
;    ==   |   !=   |  fbne  |  bne  (Z = 0)            | FARTCMPF32
;    <    |  ">=?" |  fbgeu |  bcc  (C = 0)            | FARTCMPEF32
;    <=   |  ">?"  |  fbgu  |  bgt  (Z + (V + N) = 0)  | FARTCMPEF32
;    >    |  "<=?" |  fbleu |  ble  (Z + (V + N) = 1)  | FARTCMPEF32
;    >=   |  "<?"  |  fblu  |  blt  ((V + N) = 1)      | ARTCMPEF32
;
;Note that equal/not-equal comparisons never raise invalid on unordered,
;but the other four C relationals do raise invalid on unordered.  Here
;is how to simply branch on the six C relational operators:
;    
;         |  "fp"  |
;  rel_op | branch | DSP568 branch (with CC)
; --------+-----------------------------------
;    ==   |  fbeq  |  beq  (Z = 1)
;    !=   |  fbne  |  bne  (Z = 0)
;    <    |  fblt  |  blo  (C = 1)
;    <=   |  fble  |  bls  (C + Z = 1)
;    >    |  fbgt  |  bgt  (Z + (N xor V) = 0)
;    >=   |  fbge  |  bge  ((N xor V) = 0)
;
;Finally, here is the table of the other 8 relationals, excluding the
;trivial cases branch-on-true and branch-on-false.  Four of these
;cases arose in the flipped conditionals above.  The statement
;"bxx skip" means that the condition is not true, and that the
;second conditional branch should be skipped.  A pair of
;branches like "bcs ; beq" has the target of the "fp" branch
;as the target of both branches.
;
;         |  "fp"  |
;  rel_op | branch | DSP568 branch (with CC)
; --------+-----------------------------------
;  ">=?"  |  fbgeu |  bcc  (C = 0)
;  ">?"   |  fbgu  |  bgt  (Z + (V + N) = 0)
;  "<=?"  |  fbleu |  ble  (Z + (V + N) = 1)
;  "<?"   |  fblu  |  blt  ((V + N) = 1)
;  "?"    |  fbu   |  bgt skip; bcc
;  "<=>"  |  fbleg |  bcs ; beq
;  "=?"   |  fbeu  |  bcs skip; ble
;  "<>"   |  fbgl  |  bcs ; bgt
;
;What this shows is that with careful use of the integer condition
;codes on a machine supporting signed and unsigned arithmetic, it's
;possible to satisfy the 4-way IEEE floating point branches with zero
;extra overhead.
;
; INCIDENTALLY: un --> unordered; NaNs are unordered with EVERYTHING,
; or --> ordered; all pairs of numbers, finite or infinite, are ordered
; as lt, eq, or gt.
;
; IMPLEMENTATION: This routine descends from a line of float/double
; routines that include boolean functions for testing ==, !=, etc.
; individually.
; The code uses a dispatch table, based on the sum
;	<operation code> + <relation>
; In this case there are just two codes, for the vanilla and the
; exceptional comparison.  Because DSP568 is a word-oriented machine,
; the <relation> is encoded in bis 0x0003, and the <operation code>
; in bit 0x004 -- all in y1.
; Historically, one grand dispatch has 
; taken care of myriad cases, including setting of Invalid on unordered.
; The comparison codes are 0-eq, 1-lt, 2-gt, 3-un, as with the result.
; The idea is to compare the values as integers, converting the sign-magnitude
; representation to 2's-complement.  To catch unordered cases, watch compare
; against -INF and +INF as 2's-complement integers.  Also, look for 
; signaling NaNs to force a signal, regardless of the type of comparison.
;
; BUG WORKAROUND: 32-bit cmp or accumulators doesn't work, so use a pair
; of comparisons: signed for high parts and, if those are equal, UNSIGNED
; for low parts.  This works because of the nature of 2's-complement
; representation.
;
;
; 2000.03.10	US	Added ARTEQF32, ARTNEF32, ARTGEF32, ARTLEF32, ARTGTF32, 
;					and  ARTLTF32. Basically all that was needed was new
;					entry points and an extended dispatch table.

BRA_SZ	EQU	2		; increment dispatch address by this.				(=1 in 56800)		
UN_BF	EQU	6		; bitfield used by bfset to mark result unordered.	(=3 in 56800)
OP_CMP	EQU $000	; was $040
OP_CMPE	EQU $008	; was $048
OP_EQ	EQU	$010
OP_NE 	EQU	$018
OP_GE	EQU	$020
OP_LE	EQU	$028
OP_GT	EQU	$030
OP_LT	EQU	$038

FARTEQF32:
ARTEQF32:
	move.w	#OP_EQ,y1
	bra		f_compare
	;~~~~~~~

FARTNEF32:
ARTNEF32:
	move.w	#OP_NE,y1
	bra		f_compare
	;~~~~~~~

FARTGEF32:
ARTGEF32:
	move.w	#OP_GE,y1
	bra		f_compare
	;~~~~~~~

FARTLEF32:
ARTLEF32:
	move.w	#OP_LE,y1
	bra		f_compare
	;~~~~~~~

FARTGTF32:
ARTGTF32:
	move.w	#OP_GT,y1
	bra		f_compare
	;~~~~~~~

FARTLTF32:
ARTLTF32:
	move.w	#OP_LT,y1
	bra		f_compare
	;~~~~~~~

ARTCMPEF32:
	move.w	#OP_CMPE,y1
	bra		f_compare
	;~~~~~~~

ARTCMPF32:
	move.w	#OP_CMP,y1
	;bra	f_compare
	; Fall through to f_compare
	
f_compare:
	; y1 = operation code
	; a = x operand
	; b = y operand
	; Change signed-magnitude representation to 2's-complement to get
	; basic comparison.  Then watch for NaNs.
	clr.w	a2			; clear extension
	tst.w	a1			; is sign bit set?
	bge		y_12		; ge ==> already nonnegative
	asl		a
	move.w	#0,a2		; clear sign bits
	asr		a			; realign
	neg		a
y_12:
	clr.w	b2			; clear extension
	tst.w	b1
	bge		y_13
	asl		b
	move.w	#0,b2
	asr		b
	neg		b
y_13:
	; Here's the big comparison x vs y.  After the comparison, check
	; the lower against -NaN and the biggest against NaN.  Be sure
	; to watch for BOTH being less than -NaN...
	; Compare in two halves, signed high and unsigned low.

	cmp		b,a
	blt		f_bounds_less
	nop
	nop
	beq		f_bounds_check

	; Fall through to f_bounds_greater.
f_bounds_greater:
	add.w	#BRA_SZ,y1
f_bounds_less:
	add.w	#BRA_SZ,y1			; code = 4 if greater than	
f_bounds_check:
	; y1 = code.
	; Now check whether one or the other is a NaN by first restoring
	; to positive form and then checking against QNaN and SNaN.
	; Quiet NaNs look bigger than 7fc00000, and signaling NaNs
	; lie between 7f800000 (inf) and 7fc00000, exclusive.
	; TRICK: logically OR the unordered code into result, which is
	; now based on initial compare.
	; TRICK: Lead frac bit marks quiet NaN.  If a value has
	; magnitude >= 0x7fc00000 then it's quiet.
	move.w	#$7f80,x0		; true +INF
	
	tst		a			; is the a operand negative
	bge		y_133
	neg		a
y_133:
	cmp.w	a,x0
	bgt		check_fy		; a-b < 0 means a is at most huge
	nop
	nop
	blt		f_cmp_x_NaN
	tst.w	a0			; a0 0 if INF
	nop
	beq		check_fy
f_cmp_x_NaN:
	move.w	#$7fc0,x0		; make smallest QNaN
	cmp.w	a,x0			; a - QNaN
	bgt		f_compare_un_inv	; a-b < 0 means a is an SNaN, so done
	bfset	#3,y1			; mark the result unordered
	; Fall through to check_fy in case it's signaling.
check_fy:
	move.w	#$7f80,x0
	tst		b
	bge		y_135
	neg		b
y_135:
	cmp.w	b,x0
	bgt		compare_dispatch	; a-b < 0 means a at most huge
	nop
	nop
	blt		f_cmp_y_NaN
	tst.w	b0			; 0 if INF
	nop
	beq		compare_dispatch
f_cmp_y_NaN:
	move.w	#$7fc0,x0
	cmp.w	b,x0			; a - QNaN
	ble		f_compare_un	; a-b >= 0 means a is QNaN
	; Fall through to f_compare_un_inv.
	
f_compare_un_inv:
	SetInvalid
f_compare_un:
	bfset	#UN_BF,y1			; mark the result unordered
	; Fall through to compare_dispatch	


;===============================================================================
; TERMINAL: compare_dispatch
; DESCRIPTION: Return result from one of many comparison routines.
; INPUT: y1 = dispatch code = (opcode * 8) + (relation * 2), where the codes
;	are defined at the start of FPE_cmp.
; OUTPUT: result in y0
;
compare_dispatch:
	jsr	cmp_do_dispatch
	
cmp_dispatch_top:
	bra	>cmp_equal 	; fcmp (ARTCMPF32)
	bra	>cmp_less 
	bra	>cmp_greater
	bra	>cmp_unordered 

	bra	>cmp_equal	; fcmpe (ARTFCMPEF32)
	bra	>cmp_less 
	bra	>cmp_greater
	bra	>cmp_unordered_invalid 

	bra	>cmp_true 	; fcmp (ARTEQF32)
	bra	>cmp_false 
	bra	>cmp_false
	bra	>cmp_false 

	bra	>cmp_false 	; fcmp (ARTNEF32)
	bra	>cmp_true 
	bra	>cmp_true
	bra	>cmp_true 

	bra	>cmp_true 	; fcmp (ARTGEF32)
	bra	>cmp_false 
	bra	>cmp_true
	bra	>cmp_false_invalid 

	bra	>cmp_true 	; fcmp (ARTLEF32)
	bra	>cmp_true 
	bra	>cmp_false
	bra	>cmp_false_invalid 

	bra	>cmp_false 	; fcmp (ARTGTF32)
	bra	>cmp_false 
	bra	>cmp_true
	bra	>cmp_false_invalid 

	bra	>cmp_false 	; fcmp (ARTLTF32)
	bra	>cmp_true 
	bra	>cmp_false
	bra	>cmp_false_invalid 

cmp_do_dispatch:
	add.w	x:(sp-1),y1		; bump table address
	move.w	y1,x:(sp-1)
	rts				; ...into branch
	

;===============================================================================
; TERMINAL: cmp_false_invalid, cmp_false, cmp_true, cmp_equal, cmp_less
;	cmp_false_invalid
; DESCRIPTION: Deliver the result of a comparison in y0.
;	cmp_false -- set y0 to 0
;	cmp_true -- leave y0 as 1
;	cmp_equal -- set y0 to 0.
; INPUT: y0 = 0
; OUTPUT: y0 = result, with CC set
;
cmp_false_invalid:
	SetInvalid
cmp_equal:
cmp_false:
	clr.w	y0
	tst.w	y0		; set Z in CC
	rts
cmp_less:
cmp_true:
cmp_done:
	move.w	#1,y0
	cmp.w	#<2,y0		; set C and N
	rts


;===============================================================================
; TERMINAL: cmp_greater
; DESCRIPTION: Deliver the result greater than.
; OUTPUT: y0 = 2
;
cmp_greater:
	move.w	#2,y0
	cmp.w	#<1,y0		; clear all CC bits
	rts


;===============================================================================
; TERMINAL: cmp_unordered, cmp_unordered_invalid
; DESCRIPTION: Deliver the result unordered.
; OUTPUT: y0 = 3 with V set and all other bits clear
;
cmp_unordered_invalid:
	SetInvalid
cmp_unordered:
	move.w	#3,y0
	cmp.w	#<1,y0		; clear all CC bits
	bfset	#2,sr		; set V bit
	rts

	
;===============================================================================
; TERMINAL: f_divide_by_zero
; DESCRIPTION: Signal divbyzero and return INF
; INPUT: rsign = sign of result.
;
f_divide_by_zero:
	; Get here dividing finite / 0.
	SetDivByZero
	jmp	f_result_is_INF	

; Get to utilities the long way.
go_f_result_is_zero:
	jmp	f_result_is_zero
go_f_result_is_Invalid:
	jmp	f_result_is_Invalid
go_f_result_is_INF:
	jmp	f_result_is_INF
go_div_f_x_is_NaN:
	jmp	f_x_is_NaN
go_f_y_is_NaN:
	jmp	f_y_is_NaN
go_f_x_and_y_are_NaN:
	jmp	f_x_and_y_are_NaN
	
;===============================================================================
; FUNCTION: ARTDIVF32UZ
; DESCRIPTION: Float divide.
; INPUT: a=x, b=y, floats
; OUTPUT: a = result
;
ARTDIVF32UZ:
	; Compute (-1)^x.sign * 2^x.exp-bias * 1.xxxx divided by
	; (-1)^y.sign * 2^y.exp-bias * 1.yyyy --->
	; result.sign		= xor of x and y signs
	; result.exp (biased)	= x.exp - y.exp + bias
	; result.bits		= w.zzzzz before normalization, rounding, etc.
	; If the leading w bit is 0, then must decrement the exponent by 1
	; and realign.
	adda	#8,sp
	jsr		f_unpack2z		; return with <x,y> flags in x0
	lsl.w	x0	;mutiplies dispatch address by 2 (since bra is 2 words instead of 1 in 56800)
	move.w	r0,x:(sp-rsign)		; stuff xor
	jsr	dispatch_x0
	; TRICK: dispatch table must be next.

	bra	>f_div_numbers		; x is a number, y is number
	bra	>f_divide_by_zero	; 	y is zero
	bra	>go_f_result_is_zero	; 	y is INF
	bra	>go_f_y_is_NaN		; 	y is NaN

	bra	>go_f_result_is_zero	; x is zero, y is number
	bra	>go_f_result_is_Invalid	; 	y is zero
	bra	>go_f_result_is_zero	;	y is INF
	bra	>go_f_y_is_NaN		;	y is NaN

	bra	>go_f_result_is_INF	; x is INF, y is number
	bra	>go_f_result_is_INF	; 	y is zero
	bra	>go_f_result_is_Invalid	; 	y is INF
	bra	>go_f_y_is_NaN		;	y is NaN

	bra	>go_div_f_x_is_NaN	; x is NaN, y is number
	bra	>go_div_f_x_is_NaN	;	y is zero
	bra	>go_div_f_x_is_NaN	;	y is INF
	bra	>go_f_x_and_y_are_NaN	;	y is NaN

f_div_numbers:
	; In this typical case, compute exp = x.exp - y.exp + bias.
	; This presumes alignment as though the leading significant
	; bit will be 1.  If it's zero, we'll left shift and decrement
	; the exponenet.
	
	; Have to divide dyb into dxb.  It's "just" two steps of
	; 64/32 --> 32 quo + 32 rem.
	; In terms of 32-bit digits, the division is just
	;
	;            X Y
	;       --------
	;  A B | C D 0 0.
	;
	; Knuth, Vol. 2, explains how it goes.  First, A is normalized
	; because its leading bit is one.  To ensure that no bit is
	; needed left of the X-digit above, right-shift CD by 1 bit at
	; the outset.  Then use the div utility to divide CD by A
	; to guess X.  As Knuth shows, even for hideously large integers
	; like these, the guess X is at worst 2 units too high, so we watch
	; and correct the remainder suitably.
	;
	; Guessing Y is more interesting, because the partial remainder
	; is not constrained downward, as X was via preconditioning.
	; After X has been guessed and corrected, the situation is this:
	;
	;            X ?
	;       --------
	;  A B | C D 0 0.
	;        X*A B
	;          E F 0
	;
	; All that's known is that, after X is corrected, AB < EF.
	; It's possible for E to be = A, in which case the guess for Y
	; is the maximum "digit", in this case 0xffffffff.  Correcting Y
	; as before yields an unnormalized quotient (by 0 or 1 bit) and
	; a remainder (that contributes to the sticky bits).
	;
	; Subtract exp's and rebias as though dvd.sig >= dvr.sig.
	; rexp = dvd exp.
	move.w	x:(sp-rexp),y0
	sub		y1,y0
	add.w	#127,y0
	move.w	y0,x:(sp-rexp)
	
	; We'll divide in the form 001xxxxx / 01yyyy to avoid sign,
	; producing a result of the form 0rstttttt, where r|s=1.
	; rsign contains the xor, so xhi and xlo are free for temporaries,
	; as are the r regs. b = dvd bits, a = drv bits.
	asr	b		; align 001xxx
	asr	b
	asr	a		; align as 01yyy
	move.w	a1,x0
	move.w	a0,x:(sp-xlo)	; xlo = dvrlo
	
	; Produce first quotient 0rsttttt.
	bfclr	#1,sr		; clear C to start
	nop
	nop
	IF @def('UseRep')
	rep	#16
	ELSE
	nop
	do	#16,div_1
	ENDIF
	div	x0,b
div_1:
	nop
	nop
	nop
	add		x0,b		; b1 = remainder, b0 = qhi
	move.w	b0,y0		; y0 = qhi
	move.w	#0,b0
	asr		b		; align partial rem as 00rrrrrrrr
	
	; Now set up qhi * dvrlo to compute true remainder, for
	; possible correction by 1 or 2.
	move.w	x:(sp-xlo),y1	; y1 = dvrlo
	mpysu	y0,y1,a
	asr		a		; align as 00sssssss
	
	; True remainder with quotient digit qhi is b-a, adjusted to be
	; nonnegative.
	sub		a,b
	nop
	bcc		f_div_post_1st_fixup
	
	; Must correct qhi downward by 1 or 2.
	move.w	x0,a
	move.w	y1,a0		; a = dvr (right-adjusted)
	sub.w	#1,y0		; --qhi
	add		a,b		; does this fix the deficit?
	bcs		f_div_post_1st_fixup
	sub.w	#1,y0
	add		a,b		; this MUST set carry
	
f_div_post_1st_fixup:
	move.w	y0,x:(sp-xhi)	; xhi = qhi
	; Now compute the 2nd 15-bit quotient "digit".
	bfclr	#1,sr		; clear C to start
	nop
	nop
	IF @def('UseRep')
	rep	#16
	ELSE
	nop
	do	#16,div_2
	ENDIF
	div	x0,b
div_2:
	nop
	nop
	nop
	add		x0,b
	move.w	b0,y0		; y0 = qlo
	move.w	#0,b0
	asr		b		; align partial rem as 00rrrrrrr
	
	; Compute qlo * dvrlo, as before.
	move.w	x:(sp-xlo),y1
	mpysu	y0,y1,a
	asr		a		; align as 00ssssss
	
	; Subtract as before, and adjust by 1 or 2.
	sub		a,b
	nop
	bcc		f_div_post_2nd_fixup
	
	; Set a = dvr to correct qlo.
	move.w	x0,a
	move.w	y1,a0		; a dvr
	sub.w	#1,y0		; --qlo
	add		a,b
	bcs		f_div_post_2nd_fixup
	sub.w	#1,y0
	add		a,b		; MUST set carry
	
f_div_post_2nd_fixup:
	; xhi/y0 = pair of 0xxxxx pieces of quotient
	; b = remainder, nonzero --> sticky
	lsl.w	y0
	; Any sticky bits in b?
	move.w	b0,y1
	or.w	b,y1
	beq		f_div_nonstick
	add.w	#1,y0
f_div_nonstick:
	move.w	x:(sp-rexp),y1
	move.w	x:(sp-xhi),a
	move.w	y0,a0		; have quo = 0rstttt, r|s = 1
	asl		a
	tst.w	a1
	jlt		f_coerce
	asl		a		; must set lead bit
	sub.w	#1,y1
	jmp		f_coerce


;===============================================================================
; FUNCTION: ARTMPYF32U
; DESCRIPTION: float multiply
; INPUT: x in a; y in b
; OUTPUT: product in a
;
ARTMPYF32U:
	adda	#8,sp
	jsr		f_unpack2z		; return with <x,y> flags in x0
	lsl.w	x0	;mutiplies dispatch address by 2 (since bra is 2 words instead of 1 in 56800)
	move.w	r0,x:(sp-rsign)		; stuff xor
	jsr		dispatch_x0
	; TRICK: dispatch table must be next.
	
	; Dispatch table for special cases.
	bra	>f_mul_numbers		; x is a number, y is number
	bra	>f_result_is_zero	; 	y is zero
	bra	>f_result_is_INF		; 	y is INF
	bra	>f_y_is_NaN		; 	y is NaN

	bra	>f_result_is_zero	; x is zero, y is number
	bra	>f_result_is_zero	; 	y is zero
	bra	>f_result_is_Invalid 	;	y is INF
	bra	>f_y_is_NaN		;	y is NaN

	bra	>f_result_is_INF		; x is INF, y is number
	bra	>f_result_is_Invalid	; 	y is zero
	bra	>f_result_is_INF		; 	y is INF
	bra	>f_y_is_NaN		;	y is NaN

	bra	>f_x_is_NaN		; x is NaN, y is number
	bra	>f_x_is_NaN		;	y is zero
	bra	>f_x_is_NaN		;	y is INF
	bra	>f_x_and_y_are_NaN	;	y is NaN
	
dispatch_x0:
	; TRICK: Avoid mysterious "add x0,x:(sp-1)", which
	; seems to malfunction.  It trashes x0 anyway (!)
	; and fools the debugger when stepping.
	add.w	x:(sp-1),x0
	move.w	x0,x:(sp-1)
	rts



;===============================================================================
; TERMINAL: f_result_is_zero
; DESCRIPTION: a gets 0 with sign from rsign
; OUTPUT: a
;
f_result_is_zero:
	move.w	x:(sp-rsign),a
	bfclr	#$7fff,a1
	suba	#8,sp
	rts


;===============================================================================
; TERMINAL: f_result_is_INF
; DESCRIPTION: a gets INF with sign from rsign
; OUTPUT: a
;
f_result_is_INF:
	move.w	x:(sp-rsign),a
	move.w	#$ff00,a1
	asr		a
	suba	#8,sp
	rts
	

;===============================================================================
; TERMINAL: f_y_is_NaN
; DESCRIPTION: Know y is a NaN and other operand isn't.  If y is signaling,
;	quiet it and signal invalid.  Else just return it.
; INPUT: y in memory
; OPTIMIZATION: Use shared code.
;
f_y_is_NaN:
	move.w	x:(sp-yhi),a
	move.w	x:(sp-ylo),a0
	bra		f_NaNs_common


;===============================================================================
; TERMINAL: f_result_is_Invalid
; DESCRIPTION: a gets +NaN
; OUTPUT: a
;
f_result_is_Invalid:
	move.w	x:(sp-rsign),a
	move.w	#$ff80,a1
	asr		a
f_inv_common:
	SetInvalid
	suba	#8,sp
	rts
	

;===============================================================================
; TERMINAL: f_x_and_y_are_NaN
; DESCRIPTION: Both are NaNs.  If x is signaling, go signal.  Ditto for y.
;	Else return x with no signal.
; INPUT: x bits in b, y bits in a.
; TRICK: Use fact that NaN bits are delivered without implicit bit,
;	with the quiet bit in bit #31.  Q=1, S=0, so try for the
;	signal.
;
f_x_and_y_are_NaN:
	tst.w	b1			; check x first
	bge	f_x_is_NaN		; it's signaling
	tst.w	a1
	nop
	bge	f_y_is_NaN		; use y if it's signaling
	; ...else fall through to f_x_is_NaN
	

;===============================================================================
; TERMINAL: f_x_is_NaN
; DESCRIPTION: Know x is a NaN and other operand isn't.  If x is signaling,
;	return canonical NaN and signal invalid.  Else just return it.
; INPUT: x saved in low mem registers.
;
f_x_is_NaN:
	; x has bits seee eeee eSff ffff ffff ffff ffff ffff,
	; where S is the signaling bit.  If bit is clear, set and signal.
	move.w	x:(sp-xhi),a
	move.w	x:(sp-xlo),a0
f_NaNs_common:
	brclr	#$0040,a1,f_inv_common	; quiet bit clear? if yes, signaling
	suba	#8,sp
	nop
	rts
	

;===============================================================================
; TERMINAL: f_mul_numbers
; DESCRIPTION: Usual case of 2 finite, nonzero numbers
;
f_mul_numbers:
	add.w	x:(sp-rexp),y1	; sum biased exponents
	sub.w	#126,y1
	move.w	y1,x:(sp-rexp)	; save computed exp
	
	; b = x, a = y, normalized and so pairs of "signed" values.
	; Because the fixed-point multiply shifts left a bit and
	; because the dsp doesn't support unsigned integer-style
	; multiplies, right-shift a bit to have 1+24+7 -bit
	; significands.  The fractional style of dsp arithmetic
	; causes the result of 01xxxx * 01xxxx style arithmetic
	; to be 0zyyyy, where z may be 1 or 0.  If 1, then there's
	; no need for further normalization -- hence the 126 bias
	; adjust.
	; The minimum number of moves is obtained by putting y
	; in x0-y1.
	asr	a
	asr	b
	; Set up <x0, y1> * <b1, b0>.
	move.w	a1,x0		; x0 = yhi
	move.w	a0,y1		; y1 = ylo
	; Set up <x0, y1> * <b1, y0>.
	move.w	b0,y0		; y0 = xlo
	mpysu	y0,y1,a		; a get lowest unsigned product, xlo*ylo
	tst.w	y0		; if "negative" add y1 into high half
	nop
	bge		flolo_nofix
	; Correct for signed y0.  To get unsigned add * 2,
	; shift right and add 4 times.  y1 has trailing 0's.
	lsr.w	y1
	add		y1,a
	add		y1,a
	add		y1,a
	add		y1,a
	lsl.w	y1
flolo_nofix:
	; a0 has just 2 high bits of the product. a2 may have carry
	moveu.w	a0,r0		; save lowest couple of stickies
;	move	a1,b0		; save high part for right shift
;	move	a2,a		; move carry down
;	move	b0,a0		; set up low bits
	asr16	a
	
	; <x0, y1> * <b1, y0> with y1 * y0 aligned in a.
	macsu	x0,y0,a
	; <x0, y1> * <b1, 0>, with <x0, y1> * y0 aligned in a.
	move.w	b1,y0
	macsu	y0,y1,a		; add y1 * <y0, 0> into a
	; <x0, y1> * <y0, 0>
	; a now has a 33-bit result, so shift right with care
	nop
	move.w	a0,y1		; stickies
;	move	a1,a0		; right shift 16 bits
;	move	a2,a1
	lsr16	a
	;move	#0,a2		don't care about junk bits to left
	mac		x0,y0,a
	move.w	r0,y0
	or.w	y0,y1		; any stickies?
	beq		fmn_nostick
	bfset	#1,a0		; force low bit
fmn_nostick:
	; a has leading 0, then 31 bits, including stickies.  If it's
	; normalized then exp is correct. Otherwise, it's unnormalized
	; by 1 bit so shift and decrement exp.
	move.w	x:(sp-rexp),y1	; set up for coerce
	asl		a		; V bit messes up test
	tst.w	a1		; extension bits mess up the CCR in asl
	blt		fmn_noshift
	asl		a
	sub.w	#1,y1
fmn_noshift:
	jmp		f_coerce


;===============================================================================
; TERMINAL: f_add_INF_to_INF
; DESCRIPTION: INF +/- INF can be INF or NaN
; INPUT: x, y, though only signs matter now.
; OUTPUT: Returns INF, with sign, or NaN.
;
f_add_INF_to_INF:
	; If adding magnitude, just deliver x. Otherwise invalid.
	tst.w	x:(sp-rsign)	; has xor of signs
	blt	f_result_is_Invalid
	; fall through to f_result_is_x...
	
	
;===============================================================================
; TERMINAL: f_result_is_x, f_result_is_y
; DESCRIPTION: Return saved arg (even if y has been flipped in sub).
; INPUT: x saved in xhi/xlo, y on stack.
; OUTPUT: a
;
f_result_is_x:
	move.w	x:(sp-xhi),a
	move.w	x:(sp-xlo),a0
	suba	#8,sp
	rts
f_result_is_y:
	move.w	x:(sp-yhi),a
	move.w	x:(sp-ylo),a0
	suba	#8,sp
	rts


;===============================================================================
; FUNCTION: ARTSUBF32U
; DESCRIPTION: Float subtract.
;
; INPUT: a = x, b = y
; OUTPUT: a = result = x - y
;
ARTSUBF32U:
	move.w	#$8000,x0		; sign flipper
	move.w	b1,y1		; high part of y
	eor.w	x0,y1			; flip y to look like add
	move.w	y1,b1		; replace operand
	bra		f_add_common
	
;===============================================================================
; TERMINAL: f_flipped_y_is_NaN, f_x_and_flipped_y_are_NaN
; DESCRIPTION: Adjust y, whose sign may have been flipped, and go to terminal.
; INPUT: y on stack, yflip
; OUTPUT: none
;
f_flipped_y_is_NaN:
	move.w	x:(sp-yhi),x0
	move.w	x:(sp-yflip),y0
	eor.w	y0,x0
	move.w	x0,x:(sp-yhi)
	jmp		f_y_is_NaN
	
f_x_and_flipped_y_are_NaN:
	move.w	x:(sp-yhi),x0
	move.w	x:(sp-yflip),y0
	eor.w	y0,x0
	move.w	x0,x:(sp-yhi)
	jmp		f_x_and_y_are_NaN


;===============================================================================
; TERMINAL: f_add_zero_to_zero
; DESCRIPTION: If signs agree, answer is easy, else fall through to subtract
;	magnitude.
; INPUT: 
; OUTPUT: Returns 0.
;
f_add_zero_to_zero:
	; When result is zero, if signs disagree let the rounding mode
	; decide the sign of the result.  The IEEE standard says use +0
	; unless rounding to -INF, in which case use -0.
	tst.w	x:(sp-rsign)	; the xor of operand signs
	bge		f_result_is_x
	nop
	nop
	; Fall through to f_add_zero_difference.


;===============================================================================
; TERMINAL: f_add_zero_difference
; DESCRIPTION: Deliver zero based on rounding mode. +0, except when round down.
; INPUT: 
; OUTPUT: Returns 0.
;
f_add_zero_difference:
	; TRICK: DOWNWARD = 3, so can use brset...
	brset	#DOWNWARD,x:FPE_state,f_add_neg_zero ; jrusso LMM
	clr		a
	suba	#8,sp
	rts
f_add_neg_zero:
	move.w	#$8000,a
	suba	#8,sp
	rts
	

;===============================================================================
; FUNCTION: ARTADDF32U
; DESCRIPTION: Float add.
;
; INPUT: a = x, b = y
; OUTPUT: a = x + y
;
ARTADDF32U:
	; Add and subtract share common code.  Subtract is identical to add
	; but with y's sign flipped.
	; SUBTLETY: In subtraction, must track y's original sign in case it's
	; a NaN and need to return y EXACTLY as it was.
	; Use r30 to hold sign flip flag: 0 for add 0x80000000 for subtract.
	; This allows subtract to look like add, but with its operand's sign
	; flipped.  The reason sub(x,y) is not the same as add(x,-y) is that
	; sub(number,NaN) needs to return the NaN with its ORIGINAL sign.
	;
	; Compute (-1)^x.sign * 2^x.exp-bias * 1.xxxx plus/minus
	; (-1)^y.sign * 2^y.exp-bias * 1.yyyy --->
	; result.sign		= sign of larger operand, though in case
	;	of zero result from operands of different signs, the result
	;	sign depends on the rounding mode: + for all except toward -INF
	; result.exp (biased)	= larger of two exps, subject to normalization
	; result.bits		= rounded sum or difference
	;
	; Many SPECIAL CASES apply:
	; Subnorms need not be normalized -- just adjust their exp to 1 and be
	;	sure not to artificially set the implicit bit to 1.
	; Magnitude add is benign. The worst that can happen is a 1-bit carry-out,
	;	and even when the operands are aligned there can be rounding from
	;	the Round (1st) bit.
	; Magnitude subtract when exps are equal can lead to massive cancellation,
	;	but never a rounding error.
	; Magnitude subtract when exps differ by one can lead to massive cancellation,
	;	and possible rounding from Round bit.
	; Magnitude subtract when exps differ by more than one never suffers
	;	cancellation by more than 1 bit, and requires general rounding.
	; Tiny results can arise from the sum or difference of subnormals, or
	;	from the difference of normals.  Must be careful when realigning
	;	after cancellation to be ready to back off to subnormal.  The results
	;	are always exact (i.e. no bit can lie to the right of the LSB of
	;	a subnormal.
	; The benign nature of subnormals (tinies) in add/sub means some care must
	;	be taken in packing the result back up to fudge the exponent
	;	(compare mul/div, where tiny results can be trickier).  At the cost
	;	of a few instructions, tiny results filter through the mul/div
	;	common code.
	move.w	#0,x0			; sign flipper
	; Fall through to add/sub common code.
	
f_add_common:
	adda	#8,sp
	move.w	x0,x:(sp-yflip) ; save add/sub distinction
	move.w	#$e000,x0		; mark no normalization
	jsr		f_unpack2
	move.w	r0,x:(sp-rsign)		; this is the xor, not result
	bfclr	#$ff00,x0		; clear normalization bits
	lsl.w	x0	;mutiplies dispatch address by 2 (since bra is 2 words instead of 1 in 56800)
	jsr		dispatch_x0
	; TRICK: table must fall the dispatch jsr.
	
	bra	>f_add_numbers			; x is a number, y is number
	bra	>f_result_is_x			; 	y is zero (y may be flipped)
	bra	>f_result_is_y			; 	y is INF
	bra	>f_flipped_y_is_NaN		; 	y is NaN

	bra	>f_result_is_y			; x is zero, y is number
	bra	>f_add_zero_to_zero		; 	y is zero
	bra	>f_result_is_y			;	y is INF
	bra	>f_flipped_y_is_NaN		;	y is NaN

	bra	>f_result_is_x			; x is INF, y is number
	bra	>f_result_is_x			; 	y is zero
	bra	>f_add_INF_to_INF		; 	y is INF
	bra	>f_flipped_y_is_NaN		;	y is NaN

	bra	>go_f_x_is_NaN			; x is NaN, y is number
	bra	>go_f_x_is_NaN			;	y is zero
	bra	>go_f_x_is_NaN			;	y is INF
	bra	>f_x_and_flipped_y_are_NaN	;	y is NaN

go_f_x_is_NaN:
	jmp	f_x_is_NaN
f_add_numbers:
	; x + y, with y's sign reflecting operation add/sub.
	; b = x bits
	; a = y bits
	; rexp = x.exp
	; y1 = y.exp
	; rsign = r0 = xor signs
	; yflip = 0x8000 if sub, 0 if add (i.e. fix to get original y)
	; Align operands so larger one is in b/rexp, with exp in rexp, sgn in rsign.
	; Smaller operand is in (rexp-yexp) & fyb.
	; SPECIAL CASES:
	;	Exponents match:
	;		Add magnitude: Easy case, at most 1 rounding bit.
	;			May not carry-out (if one operand subnormal).
	;		Sub magnitude: Can have massive cancellation with exact,
	;			possibly zero result.  Can't over/underflow, but
	;			may require subnormalization.
	;	Exponents differ by 1:
	;		Add magnitude: nothing special
	;		Sub magnitude: Only other cancellation case, but may
	;			be inexact only if there's no cancellation.
	;	Exponents differ by 2-8: shift without losing stickies
	;	Exponents differ by 9-15: shift by 8, then 1-7
	;	Exponents differ by 16: shift by a word
	;	Exponents differ by 17-24, shift by a word, then 1-8
	;	Exponents differ by > 24: smaller operand goes to sticky.
	; WARNING: rsign indicates whether to add or sub magnitude,
	;	but result sign is that of larger operand, tentatively xhi
	;
	; First, put xor in yflip, and y's sign in rsign.
	move.w	r0,x:(sp-yflip)
	move.w	x:(sp-yhi),x0
	move.w	x0,x:(sp-rsign)
	; Start checking for various cases.
	move.w	y1,x0			; tentative larger exp
	move.w	x:(sp-rexp),y0
	sub		y0,x0		; y.exp - x.exp = +/- shift
	bne		f_add_unaligned		; go shift in hard case
	
	tst.w	x:(sp-yflip)	; add or sub?
	nop
	blt	f_sub_aligned
f_add_aligned:
	; Two normalized operands will cause Carry -- the typical case,
	; in which rounding and overflow must be checked.  If one or
	; the other is subnormal, the result may not Carry (though it
	; may be normal), and it's ready to be packed.  In order to share
	; code with more typical case, just go through whole coerce routine.
	; Note that in cases of subtract magnitude or of no carry in add
	; magnitude, there's no chance for overflow.
	add		b,a			; add magnitudes
	tst.w	a2
	jeq		f_coerce
	asr		a			; reinstate high bit
	add.w	#1,y1			; bump exp
	jmp		f_coerce
f_sub_aligned:
	; Subtraction may lead to borrow, in which case must negate and flip
	; result sign.  This is the only case of a sign flip.
	sub		b,a
	bhs		f_sub_no_borrow		; C clear if cool subtract
	neg		a
	move.w	x:(sp-rsign),y0
	bfchg	#$8000,y0		; flip result
	move.w	y0,x:(sp-rsign)
f_sub_no_borrow:
	; TRICK: can't depend on Z flag from neg, so test halves and
	; take the chance to speed up the case of massive normalization.
	tst.w	a1			; high half clear
	jlt	f_coerce		; already normal
	nop
	bne	f_sub_renorm		; go shift up to 16
	tst.w	a0			; low half clear
	beq	f_add_zero_difference
	; Fall through if high half is zero, but low isn't.
	; Do a quick 16-bit shift.
	move.w	a0,a			; clears a0
	sub.w	#<16,y1			; adjust exponent
	tst.w	a1			; check for luck case
	jlt	f_coerce	
	; Fall through to f_sub_renorm
f_sub_renorm:
	; Have exact result which must be normalized.  Ideally, we'd shift
	; only until the biased exponent reaches 1, but it's easier to
	; just go through with it and let the tiny cases get shifted back.
	; They're exact, in any case.
f_sub_renorm_cont:
	dec.w	y1
	asl		a
	tst.w	a1
	bge		f_sub_renorm_cont
	nop
	nop
	jmp		f_coerce

f_add_unaligned:
	; CC from sub x:exp,(y1 in x0) and then bne.
	; If gt, we're OK: y1 has larger exp and x0 has pos diff.
	; If negative, swap operands
	; yflip = xor of signs
	; y is in a, y1, rsign  (bits, exp, sign)
	; x is in b, rexp, xhi
	; xor of signs is in yflip
	; set up larger exponent in rexp and difference in x0
	bgt	f_add_swap_done
f_add_swap:
	move.w	x:(sp-xhi),y0		; get sign
	move.w	y0,x:(sp-rsign)
	move.w	a1,y0			; swap the 2 words of bits
	move.w	b1,a1
	move.w	y0,b1
	
	move.w	a0,y0
	move.w	b0,a0
	move.w	y0,b0
	
	move.w	x:(sp-rexp),y1		; larger exponent
	not.w	x0			; -difference = shift count
	add.w	#1,x0			; poor man's "negw x0"
f_add_swap_done:
	; Shifting up to 8 bits is easy.
	cmp.w	#1,x0
	bgt		f_add_2_plus
	
	; Case 1: shift b by 1 bit.  Add is nothing special,
	; but sub may require serious renormalization.
	asr		b
	tst.w	x:(sp-yflip)	; test xor
	bge		f_add_aligned
f_sub_1:
	; Sub operands shifted by 1 bit.  Can't borrow, but may require
	; significant renormalization.
	sub		b,a
	tst.w	a1			; still normalized
	jlt		f_coerce
	bra		f_sub_renorm_cont

f_add_2_plus:
	cmp.w	#8,x0
	bgt		f_add_9_plus
	
	; Case 2-8: shift b by x0 within itself without fear of bit loss.
	moveu.w	b1,r0
	move.w	b0,y0
	lsrr.w	y0,x0,y0
	nop
	move.w	y0,b0
	move.w	#0,b1
	move.w	r0,y0
	lsrac	y0,x0,b
	bra	f_add_realigned
	
f_add_9_plus:
	cmp.w	#16,x0
	bgt		f_add_17_plus
	nop
	nop
	beq		f_add_16
	
	; Case 9-15: shift in one shot, watching for stickies.
	move.w	b1,r0
	move.w	b0,y0
	clr		b
	lsrac	y0,x0,b		; low bits / stickies
	nop
	tst.w	b0		; any stickies?
	nop
	beq		f_a_9_1
	add.w	#1,b		; bump high half, safely
f_a_9_1:
	move.w	b1,b0
	move.w	#0,b1
	move.w	r0,y0
	lsrac	y0,x0,b		; upper half, shifted and added
	bra		f_add_realigned
	
	; Case 16: shift by a word
f_add_16:
	tst.w	b0
	beq		f_a_16_1
	bfset	#1,b1

f_a_16_1:
	move.w	b1,b0
	move.w	#0,b1
	bra		f_add_realigned
	
f_add_17_plus:
	cmp.w	#24,x0
	bgt		f_add_25_plus
	
	; Case 17-24: shift by a word and then the remainder.
	move.w	b1,y0
	tst.w	b0			; any stickies
	beq		f_add_17_1
	bfset	#1,y0			; force sticky
f_add_17_1:
	sub.w	#16,x0
	clr		b
	lsrac	y0,x0,b			; b1 = low bits, b0 = sticky
	nop
	tst.w	b0
	nop
	beq		f_add_17_3
	bfset	#1,b1
f_add_17_3:
	move.w	b1,b0
	move.w	#0,b1
	bra		f_add_realigned
	
	; Case of huge shift --> all sticky.
f_add_25_plus
	clr		b
	move.w	#1,b0
	; Fall through to f_add_realigned
	
f_add_realigned:
	; Now add b to or subtract it from a.  At worst, there can be
	; a carry-out on add, or a 1-bit renormalization on subtract.
	; Always round and check for overflow, though overflow can't
	; happen on a magnitude subtract.  At the bottom of the range,
	; subtracting two numbers near the smallest normal can lead to
	; a subnormal, but it will be exact.
	tst.w	x:(sp-yflip)	; add or sub?
	bge		f_add_with_sticky
;f_sub_easy:
	sub		b,a			; can't borrow, might need 1-bit shift
	tst.w	a1
	blt		f_coerce
	asl		a
	sub.w	#1,y1			; adjust exponent
	bra		f_coerce
f_add_with_sticky:
	; Add operands shifted by bunch o' bits.  Watch for sticky bit.
	add		b,a
	tst.w	a2			; carry out?
	beq		f_coerce
	add.w	#1,y1			; bump exponent for right shift
	asr		a
	bhs		f_coerce
	bfset	#1,a0			; force sticky
	; Fall through to f_coerce


;===============================================================================
; TERMINAL: f_coerce
; DESCRIPTION: Coerce a value to float format.
; INPUT: a = bits, y1 = exponent, x:(sp-rsign) = sign.
; OUTPUT: a
;
f_coerce:
	tst.w	y1
	ble		>f_tiny_result
	bftstl	#$0ff,a0		; C clear if any nonzero rounding bits
	bcc		f_round
f_checkoflow:
	cmp.w	#$0ff,y1		; huge exp?
	jge		f_oflow
f_pack:
	; a = bits, y1 = exp, x:rsign has sign bit
	move.w	#8,x0			; shift count
	moveu.w	a1,r0			; r0 = rrss
	move.w	a0,y0			; y0 = tt00
	lsrr.w	y0,x0,a			; a  = 00tt 0000
	nop
;	move	a1,a0			; a  = 00tt 00tt
;	move	a2,a1			; a  = 0000 00tt
	lsr16	a
	move.w	r0,y0
	lsrac	y0,x0,a			; a  = 00rr sstt
	nop
	; Clear implicit, and if it's already zero, decrement the exp.
	bfclr	#$0080,a1		; knock off lead bit
	bcs		f_pack_norm		; C set when lead bit is 0
	dec.w	y1			; decrement exp (to 0)
f_pack_norm:
	move.w	x:(sp-rsign),b		; b  = xxxx xyyyy... bits, where
					; x is the sign bit
	asll.w	y1,x0,y1		; align exp left
	nop
	move.w	y1,b1			; b = xxxx eeee eeee 0000... bits
	asr		b			; b = xxxx xeee eeee e000... bits
	add		b,a			; add = or, when bits are exclusive
	suba	#8,sp
	rts			
	
;===============================================================================
; TERMINAL: f_round
; DESCRIPTION: Round an inexact value and continue with coercion.
; INPUT: a = bits normalized to 0xffffff00
;	y1 = biased, repaired exp
;	rsign.15 = result sign
; OUTPUT: rounded significand with junk low bits, Inexact set
;
f_round:
	SetInexact
f_tiny_resume:
	; Get back here with a tiny, inexact result.  Underflow and inexact
	; have been signaled in that case.
	brset	#BITDIRRND,x:FPE_state,f_round_dirrnd ; jrusso LMM
	nop
	nop
	brset	#BITDOWNORCHOP,x:FPE_state,f_checkoflow ; jrusso LMM
	nop
	nop
	; round to nearest...
	brclr	#$0080,a0,f_checkoflow	; done if round bit clear
	bftstl	#$007f,a0		; C clear if any set
	bcc		f_roundup
	nop
	nop
	; get here in half-way case
	brclr	#$0100,a0,f_checkoflow	; already even, so no round
f_roundup:
	move.w	#0,a2			; clear carry-out bits
	clr		b
	move.w	#$0100,b0		; increment unit
	add		b,a
	brclr	#1,a2,f_checkoflow	; look for carry-out
	asr		a			; realign
	add.w	#1,y1
	bra		f_checkoflow

f_round_dirrnd:
	brset	#BITDOWNORCHOP,x:FPE_state,f_round_downward  ; jrusso LMM
;f_round_upward:
	tst.w	x:(sp-rsign)
	nop
	bge		f_roundup
	nop
	nop
	bra		f_checkoflow
f_round_downward:
	tst.w	x:(sp-rsign)
	blt		f_roundup
	nop
	nop
	bra		f_checkoflow

	
;===============================================================================
; TERMINAL: f_tiny_result
; DESCRIPTION: Subnormalize a result and return to rounding...
; INPUT: a = bits normalized to 0xffffff00, with rounding bits in 0x0...0ff
;	y1 = biased, underflowed exp
;	rsign = result sign
; OUTPUT: subnormalized signif. and exp=1 to continue at f_tiny_resume if
;	inexact and at f_pack if exact.  Note, it's OK to be tiny and exact;
;	no underflow occurs.
f_tiny_result:
	; 1 - exp = number of bits to shift right in order to achieve
	; exp of 1 with unnormalized value.
	; If shift > 24, then every bit is sticky.
	; Else shift requisite amount.
	; In any case, the exponent goes to the minimum, 1.
	move.w	#1,x0
	sub		y1,x0			; x0 = 1 - exp = # bits to shift
	cmp.w	#25,x0			; 25 < x0 means minuscule
	bgt		f_very_tiny_result
	
	; Shift fr right by x0, with bits shifted off or-ed into sticky.
	move.w	#0,y0			; accumulate stickies into b
	move.w	y0,y1			; (don't need y1 for exp here)
	clr		b
	do		x0,sub_loop_end
	asr		a			; C <-- sticky bit
	adc		y,b
sub_loop_end:
	nop
	nop
	nop
	; b0 is at most 25, if all bits are one
	move.w	a0,y0
	move.w	b0,y1
	or.w	y0,y1
	move.w	y1,a0
	move.w	#1,y1			; set minimum exponent
	; CASES:
	;	Exact --> no underflow or inexact; just stuff subnormal
	;	Rounds up to min normal --> be sure biased exp is 1
	;	Rounds to subnormal --> inexact and underflow
	bftstl	#$00ff,a0		; sets C if exact
	jlo		f_pack
	bra		f_set_uflow

f_very_tiny_result:
	; Value underflows to 0 or tiny subnormal.  Latter arises
	; depending on rounding.
	clr		a
	move.w	#1,a0			; barest sticky
	move.w	a0,y1			; min exponent
f_set_uflow:
	SetUnderflow
	bra	f_tiny_resume		; go round and pack result


;===============================================================================
; TERMINAL: f_oflow
; DESCRIPTION: Stuff INF or largest result, according to rounding mode. Signal
;	overflow and inexact.
;
f_oflow:
	; Know result is too big. Signal, and respond according to the rounding
	; mode.
	SetOverflow
	; CASES:
	; nearest, pos & upward, neg & downward --> INF
	; chop, pos & downward, neg & upward --> HUGE
	brset	#BITDIRRND,x:FPE_state,f_oflow_dirrnd  ; jrusso LMM
	nop
	nop
	brset	#BITDOWNORCHOP,x:FPE_state,f_result_is_huge ; jrusso LMM
	nop
	nop
f_go_inf:
	jmp	f_result_is_INF


;===============================================================================
; TERMINAL: f_oflow_dirrnd
; DESCRIPTION: Check mode and sign to decide huge or INF.
;
f_oflow_dirrnd:
	brset	#BITDOWNORCHOP,x:FPE_state,f_oflow_down  ; jrusso LMM
	tst.w	x:(sp-rsign)
	nop
	bge		f_go_inf
	nop
	nop
	bra		f_result_is_huge
f_oflow_down:
	tst.w	x:(sp-rsign)
	blt		f_go_inf
	; Fall through to huge...
	

;===============================================================================
; TERMINAL: f_result_is_huge
; DESCRIPTION: Stuff huge with sign from rsign.
; Want the value 0x7f7fffff.  Get it by adding -1 to 0x7f800000.
;
f_result_is_huge:
	move.w	x:(sp-rsign),a
;	move	#$feff,a1
;	move	#$ffff,a0
	move.l	#>>$feffffff,a
	asr		a
	suba	#8,sp
	rts


;===============================================================================
; FUNCTION: FARTROUND, ARTSETFPSCR
; DESCRIPTION: Set the rounding mode, according to the code in x; set the fpscr.
; INPUT: y0 = 2-bit code.
; OUTPUT: y0
;
FARTROUND:
	move.w	x:FPE_state,y1	; jrusso LMM
	bfclr	#$03,y1			; remove old mode
	bfclr	#$fffc,y0		; strip extraneous bits
	or.w	y1,y0
FARTSETFPSCR:
	move.w	y0,x:FPE_state 	; jrusso LMM
	rts
	

;===============================================================================
; FUNCTION: FARTGETFPSCR
; DESCRIPTION: Return the fpscr in y0.
; INPUT: none
; OUTPUT: y0 = fpscr
;
FARTGETFPSCR:
	move.w	x:FPE_state,y0 	; jrusso LMM
	rts
	
y_34_rts:
	suba	#8,sp
	rts


;===============================================================================
; FUNCTION: ARTU16_TO_F32, ARTU32_TO_F32
; DESCRIPTION: Convert unsigned word to float.
; INPUT: y0 = unsigned word
; OUTPUT: a = float
; OPTIMIZATION: Uses signed conversion, with faked positive sign.
;
ARTU16_TO_F32:
	move.w	y0,a
	move.w	#15,y1
	bra	utoX_common
ARTU32_TO_F32:
	move.w	#31,y1
utoX_common:
	adda	#8,sp
	move.w	#0,y0
	move.w	y0,x:(sp-rsign)		; positive sign
	bra	wtoX_common

;===============================================================================
; FUNCTION: ARTS16_TO_F32, ARTS32_TO_F32
; DESCRIPTION: Convert signed word to float.
; INPUT: y0 = signed word
; OUTPUT: a = float
; CASES: Zero maps to +0. Large values are rounded according to the current mode.
;
ARTS16_TO_F32:
	move.w	y0,a
	move.w	#15,y1
	bra	itoX_common
ARTS32_TO_F32:
	move.w	#31,y1
itoX_common:
	adda	#8,sp
	move.w	a1,x:(sp-rsign)
	abs	a			; ********** check extension ***********
	; fall through to wtoX_common
	
;===============================================================================
; TERMINAL: wtoX_common  (word to floating conversion, common code)
; DESCRIPTION: Normalize integer in a and coerce to destination. If dest
;	is wide (future), be sure to widen the integer operand suitably.
; INPUT: a = unsigned integer, rsign = sign, y1 = unbiased exp
; OUTPUT: Convert to float (or double) destination using coercions.
;
wtoX_common:
	; Normalize the operand in a and set the exponent to the
	; unbiased exp.  Then branch to appropriate coercion routine.
	; SPECIAL CASE: Zero is treated specially.
	add.w	#$7f,y1			; bias exponent
	tst.w	a1			; is high half 0?
	blt		wtoX_done		; already normal
	nop
	nop
	bne		wtoX_leftward		; go shift < 16 bits
	tst.w	a0
	nop
	beq	y_34_rts		; return with 0
	; Fall through with 16+ bits of shift
	move.w	a0,a			; shift and clear low half
	sub.w		#16,y1
	tst.w	a1
	blt		wtoX_done		; exactly 16 bits needed
wtoX_leftward:
	sub.w	#1,y1
	asl		a
	tst.w	a1
	bgt		wtoX_leftward
	nop
	nop
wtoX_done:
	jmp		f_coerce


;===============================================================================
; A NOTE ABOUT CONVERSIONS TO INTEGRAL FORMATS
;=============================================
;
; Conversions from float to the 16- and 32-bit signed and unsigned
; integral formats follow a number of conventions.
; 1) A negative number converts to unsigned 0, without signaling an exception.
; 2) Otherwise, any fractional part is truncated, regardless of rounding mode.
; 3) If a nonzero fraction is truncated, and the value doesn't overflow,
;	inexact is set.
; 4) If a value overflows the integer destination, invalid (not overflow) is set
;	and the result is set to the most negative value for signed destinations
;	and to the biggest value for unsigned destinations.
; Conversions from float and double can share common terminal code.
; Bits 0x018 of y1 are set to indicate:
;	0x008 -- signed destination (versus unsigned)
;	0x004 -- long destination (32-bit), versus short (16-bit)
;	0x003 -- bits from unpack routine
; To use the f_unpack mechanism, they are placed in the word as is, not needing
; to be shifted left 2 bits.  (We let the routine normalize subnorms.)
DST_SIGNED	EQU	8
DST_LONG	EQU	4
DST_UNSIGNED	EQU	0
DST_SHORT	EQU	0

;===============================================================================
; FUNCTION: ARTF32_TO_S32U
; DESCRIPTION: Convert float to long integer.
; INPUT: a = float
; OUTPUT: a = long
;
ARTF32_TO_S32U:
	move.w	#(DST_SIGNED+DST_LONG),x0
	bra	f_toX_common

;===============================================================================
; FUNCTION: ARTF32_TO_U32U
; DESCRIPTION: Convert float to unsigned long integer.
; INPUT: a = float
; OUTPUT: a = unsigned long long
;
ARTF32_TO_U32U:
	move.w	#(DST_UNSIGNED+DST_LONG),x0
	bra	f_toX_common
	
;===============================================================================
; FUNCTION: ARTF32_TO_U16U
; DESCRIPTION: Convert float to unsigned short.
; INPUT: a = float
; OUTPUT: y0 = unsigned int
;
ARTF32_TO_U16U:
	move.w	#(DST_UNSIGNED+DST_SHORT),x0
	bra	f_toX_common

;===============================================================================
; FUNCTION: ARTF32_TO_S16U
; DESCRIPTION: Convert float to integer.
; INPUT: a = float
; OUTPUT: y0 = int
;
ARTF32_TO_S16U:
	move.w	#(DST_SIGNED+DST_SHORT),x0
	; Fall through to f_toX_common
	
f_toX_common:
	adda	#8,sp
	move.w	a1,x:(sp-rsign)		; result sign, if DST_SIGNED
	jsr		f_unpackA		; return with x0 set to code
	move.w	x0,y0			; BUG trashes dispatch register
	lsl.w	y0	;mutiplies dispatch address by 2 (since bra is 2 words instead of 1 in 56800)
	jsr		dispatch_y0
	; OPTIMIZATION: save x0 for later tests.
	
f_toX_top:
	bra	>go_f_tou		; unsigned int cases, #
	bra	>i_result_is_zero	;	zero
	bra	>u_result_from_inf	;	INF
	bra	>u_result_is_max		;	NaN
	
	bra	>go_f_toul		; unsigned long long cases, #
	bra	>l_result_is_zero	;	zero
	bra	>ul_result_from_inf 	;	INF
	bra	>ul_result_is_max	;	NaN

	bra	>f_toi			; signed int cases, #
	bra	>i_result_is_zero	;	zero
	bra	>i_result_is_max		;	INF
	bra	>i_result_is_neg_max	;	NaN

	bra	>go_f_tol		; signed long long cases, #
	bra	>l_result_is_zero	;	zero
	bra	>l_result_is_max		;	INF
	bra	>l_result_is_neg_max	;	NaN
	
dispatch_y0:
	add.w	x:(sp-1),y0
	move.w	y0,x:(sp-1)
	rts

	; Compensate for branch range.
go_f_toul
	;jmp	f_toul -- same address
go_f_tol
	jmp	f_tol
go_f_tou:
	jmp	f_tou
	
;===============================================================================
; TERMINAL: u_result_from_inf
; DESCRIPTION: Unsigned result from INF, -INF-->0, +INF-->max
; INPUT: rsign
; OUTPUT: Return with y0 = 0 or max positive.
;
u_result_from_inf:
	; If it's -INF, return 0, else return max with Invalid.
	tst.w	x:(sp-rsign)
	bge		u_result_is_max
	; Fall through to i_result_is_zero...

;===============================================================================
; TERMINAL: i_result_is_zero
; DESCRIPTION: Force an int zero return value.
; INPUT: 
; OUTPUT: Return with y0 = 0.
;
i_result_is_zero:
	move.w	#0,y0
	suba	#8,sp
	rts
	
;===============================================================================
; TERMINAL: short_result_is_max, u_result_is_max, i_result_is_neg_max,
;		i_result_is_max
; DESCRIPTION: Signed or unsigned max result, with Invalid signal.
; INPUT: x0 = original unpack code = bits 0...0qrst
;	where q = DST_SIGNED, r = DST_LONG, st = x info
;	rsign = sign
; OUTPUT: Return with y0 = max positive (signed or unsigned) or max negative
;	and signal Invalid.
;
i_result_is_neg_max:
	move.w	#$ffff,x:(sp-rsign)	; fake neg sign
i_result_is_max:
	move.w	#$8000,y0			; tentative huge neg.
	tst.w	x:(sp-rsign)
	blt		toX_exit_Invalid
	dec.w	y0				; back to $7fff
	nop
	bra		toX_exit_Invalid

; Get here by computing huge value. Distinguish signed and not.
short_result_is_max:
	brset	#DST_SIGNED,x0,i_result_is_max
	; Fall through to u_result_is_max.
u_result_is_max:
	move.w	#$ffff,y0
toX_exit_Invalid:
	SetInvalid
	suba	#8,sp
	rts
	
;===============================================================================
; TERMINAL: l_result_is_zero
; DESCRIPTION: Force an int zero return value.
; INPUT: 
; OUTPUT: Return with a = 0.
;
l_result_is_zero:
	clr		a
	suba	#8,sp
	rts

;===============================================================================
; TERMINAL: ul_result_from_inf
; DESCRIPTION: Unsigned result from INF, -INF-->0, +INF-->max
; INPUT: rsign
; OUTPUT: Return with a = 0 or max positive.
;
ul_result_from_inf:
	tst.w	x:(sp-rsign)
	blt		l_result_is_zero
	nop
	nop
	bra		ul_result_is_max

;===============================================================================
; TERMINAL: l_result_is_neg_max, l_result_is_max,
;		long_result_is_max, ul_result_is_max
; DESCRIPTION: Signed or unsigned long long max result, with Invalid signal.
; INPUT: x0 = original unpack code = bits 0...0qrst
;	where q = DST_SIGNED, r = DST_LONG, st = x info
;	rsign.15 = sign
; OUTPUT: Return with a = max positive (signed or unsigned) or max
;	value.
;
l_result_is_neg_max:
	move.w	#$ffff,x:(sp-rsign)		; fake neg sign in msb word
l_result_is_max:
	move.w	#$8000,a		; a = 8000 0000
	tst.w	x:(sp-rsign)
	blt		toX_exit_Invalid	; yes, it's negative
	dec.w	a			; a = 7fff 0000
	move.w	#-1,a0			; a = 7fff ffff
	bra		toX_exit_Invalid
	
; Get here by computing a large value from a number.
long_result_is_max:
	brset	#DST_SIGNED,x0,l_result_is_max
	; Fall through to...
ul_result_is_max:
	move.w	#-1,a
	move.w	a1,a0
	bra		toX_exit_Invalid


;===============================================================================
; TERMINAL: f_toi, f_tou
; DESCRIPTION: Convert unpacked float to a 16-bit integer.
; INPUT: x0 = original unpack code = bits 0...0qrst
;	where q = DST_SIGNED, r = DST_LONG, st = x info
;	rsign.15 = sign
; OUTPUT: Return with y0 set to value.
;
f_toi:
f_tou:
	; Convert an unpacked float to one of the short types.
	; Unbias the exponent and place the binary point to the right
	; of a1. That is, subtract 127+15 = 142, from the biased exp.
	sub.w		#142,y1
	brset		#DST_SIGNED,x0,y_6
	tst.w		x:(sp-rsign)
	nop
	blt			i_result_is_zero	; neg to unsigned is 0
y_6:
	tst.w	y1			; exp > 0 means oflow
	nop
	bgt		short_result_is_max
	nop
	nop
	beq		to_short_check_oflow	; tricky cases
	; Negative exponent gives number of right shifts.
	move.w	y1,b
	neg		b
	cmp.w	#16,b			; will we shift all the way
	blt		to_short_right
	
	; Shift all the way to 0, truncating fraction bits.
	move.w	a1,y1
	move.w	#0,a1
	bra		to_short_right_common
	
to_short_right:
	; Shift a1 rightward into a, collecting all round bits for
	; inexact test.
	move.w	b,y0			; shift count
	move.w	a0,y1			; low round bits
	lsrr.w	a1,y0,a
	nop
to_short_right_common:
	move.w	a0,y0			; higher round bits
	or.w	y0,y1
	bra		to_short_finale
	
to_short_check_oflow:
	; a1 = tentative value, with leading bit of 1.
	; a0 = rounding bits, if any
	; rsign = sign
	; x0 = result code
	; Any result with leading 0 is within range regardless.
	; Any 32-bit result is fine for unsigned destinations.
	; Otherwise, the only huge magnitude allowed to be negative
	; is 0x80000000, so test for that one tricky case.
	move.w	a0,y1			; round bits
	brclr	#DST_SIGNED,x0,to_short_finale	; unsigned big numbers pass
	tst.w	x:(sp-rsign)					; if positive, must overflow
	nop
	bge		i_result_is_max
	; Signed & negative, so must be 0x8000...
	tfr	a,b
	add	a,b			; 32-bit result is 0 only if
					; operands were 0x80000000
	; The book doesn't say so, but add sets CC based on 32 bits.
	;;;tst	b			; 32-bit value zero means OK
	bne	i_result_is_max		; too big if any lower bits are set
	; Fall through to to_short_finale with a = 0x80000000 = result
	
to_short_finale:
	; a1 = value in range
	; y1 = rounding bits
	; rsign = sign
	; x0 = conversion codes
	brclr	#DST_SIGNED,x0,to_short_check	; unsigned
	tst.w	x:(sp-rsign)
	nop
	bge		to_short_check
	move.w	#0,a0
	neg		a			; negate result
to_short_check:
	tst.w	y1
	beq		y_8			; any round bits?
to_short_finale_inexact:
	SetInexact
y_8:
	move.w	a1,y0
	suba	#8,sp
	rts
	


;===============================================================================
; TERMINAL: f_tol, f_toul
; DESCRIPTION: Convert unpacked float to a 32-bit integer.
; INPUT: x0 = original unpack code = bits 0...0qrst
;	where q = DST_SIGNED, r = DST_LONG, st = x info
;	rsign.15 = sign
; OUTPUT: Return with a (long) set to value.
;
f_tol:
f_toul:
	; Convert an unpacked float to one of the long types.
	; Unbias the exponent and place the binary point to the right
	; of a1. That is, subtract 127+31 = 158, from the biased exp.
	sub.w	#158,y1
	brset	#DST_SIGNED,x0,y_16
	tst.w	x:(sp-rsign)	; if positive, must overflow
	nop
	jlt	l_result_is_zero	; neg to unsigned is 0
y_16:
	tst.w	y1			; exp > 0 means oflow
	bgt	long_result_is_max
	nop
	nop
	beq	to_long_check_oflow	; tricky cases
	; Negative exponent gives number of right shifts.
	move.w	y1,b
	neg		b
	cmp.w	#32,b			; will we shift all the way
	blt	to_long_right
	
	; Shift all the way to 0, truncating fraction bits.
	move.w	a1,y1
	move.w	a0,y0			; higher round bits
	or.w	y0,y1
	clr		a
	bra		to_long_finale
	
to_long_right:
	; Shift a1 rightward into a, collecting all round bits for
	; inexact test.  Three cases arise:
	; CASE  under16: b < 16, so shift is less than a word
	;	exactly16: b == 16, so easy shift
	;	over16: b > 16 so shift into low word
	move.w	b,y0			; shift count
	cmp.w	#16,y0
	bgt		over16
	nop
	nop
	blt		under16
;exactly16:
	move.w	a0,y1			; round bits
	move.w	a1,a0
	move.w	#0,a1
	bra		to_long_finale
over16:
	; Save the lowest bits for rounding. Then shift the high sixteen
	; bits by (shift-16).  Finally, do the last 16-bit shift.
	sub.w	#16,y0			; diminish by a word
	move.w	a0,y1			; low round bits
	lsrr.w	a1,y0,a			; a has aligned bits, left one word
	nop
	move.w	a0,y0			; higher round bits
	or.w	y0,y1
	move.w	a1,a0			; now shift the other 16 bits
	move.w	#0,a1
	bra		to_long_finale
under16:
	; Trickiest case, shifting the 32-bit value by under 16 bits.
	; Use b to shift low half, then shift and accumulate.
	move.w	a0,y1			; low bits, for shifting
	lsrr.w	y1,y0,b			; b1 = low bits, b0 = rounding
	nop
	move.w	b0,y1			; all the round bits
	move.w	b1,b0			; lowest sig bits
	move.w	#0,b1
	lsrac	a1,y0,b
	tfr		b,a
	bra		to_long_finale
	
to_long_check_oflow:
	; a1 = tentative value, with leading bit of 1.
	; no rounding bits
	; rsign = sign
	; x0 = result code
	; Any result with leading 0 is within range regardless.
	; Any 32-bit result is fine for unsigned destinations.
	; Otherwise, the only huge magnitude allowed to be negative
	; is 0x80000000, so test for that one tricky case.
	move.w	#0,y1			; round bits
	brclr	#DST_SIGNED,x0,y_18	; unsigned big numbers pass
	tst.w	x:(sp-rsign)		; if positive, must overflow
	nop
	jge		l_result_is_max
	; Signed & negative, so must be 0x8000...
	tfr		a,b
	add		a,b			; 32-bit result is 0 only if
						; operands were 0x80000000
	;;;;tst	b			; 32-bit value zero means OK
	jne	l_result_is_max		; too big if any lower bits are set
	; Fall through to to_long_finale with a = 0x80000000 = result
	
to_long_finale:
	; a = value in range
	; y1 = rounding bits
	; rsign = sign
	; x0 = conversion codes
	brclr	#DST_SIGNED,x0,to_long_check	; unsigned
	tst.w	x:(sp-rsign)
	nop
	bge		to_long_check
	neg		a			; negate result
to_long_check:
	tst.w	y1
	beq		y_18			; any round bits?
	SetInexact
y_18:	
	suba	#8,sp
	rts


;===============================================================================
; UTILITY: f_unpackA, f_unpack2, f_unpack2z
; DESCRIPTION: Unpack 1 or 2 input floats.
;	f_unpackA -- unpacks a
;	f_unpack2 -- unpack 2 operands, eor-ing the signs
;	f_unpack2z -- f_unpack2, with x0 <-- 0, for mul and div
;
; INPUT: x in a; y in b, for 2-operand functions;
;	flags in x0 for f_unpackA and f_unpack2
; OUTPUT:
;	f_unpackA -- a = bits, x0 = flags, y1 = exp
;	f_unpack2, f_unpack2z -- b = x bits, x:rexp = x exp, x:xhi/xlo = x,
;			a = y bits, y1 = y exp, r0 = xor signs, x:yhi/ylo = y
;
;		!_____!
;		|	  |
;		!_____!
;		|	  |
;		!_____!<-- SP at the begining of Caller Routine.
;		|	  |
;		!_____!
;		|rexp |
;		!_____!
;		|rsign|
;		!_____!
;		|yflip|
;		!_____!
;		| ylo |
;		!_____!
;		| yhi |
;		!_____!
;		| xlo |
;		!_____!
;		| xhi |
;		!_____!<-- SP after f_unpack2z or f_unpack2
;		| 	  |
;		!_____!
;		| 	  |
;		!_____!<-- SP at f_unpack2z or f_unpack2
;		| 	  |




f_unpack2z:
	move.w	#<0,x0		; set up flags for normalization
f_unpack2:
	move.w	b1,x:(sp-yhi_unp)	; save y operand for later ref.
	move.w	b0,x:(sp-ylo_unp)
	move.w	b1,y1	; y sign
	eor.w	a,y1
	move.w	y1,r0		; save eor sign for all binary ops
	move.w	a1,x:(sp-xhi_unp)	; save x operand for later ref.
	move.w	a0,x:(sp-xlo_unp)
	jsr		f_unpackA	; a = bits, y1 = exp, x0 = flags
	tfr		a,b		; save x bits
	move.w	y1,x:(sp-rexp_unp)
	lsl.w	x0		; shift flags over two
	lsl.w	x0
	move.w	x:(sp-yhi_unp),a	; set up operand y
	move.w	x:(sp-ylo_unp),a0
	; Fall through to f_unpackA...
f_unpackA:
	move.w	#<8,y0		; shift count
	moveu.w	a1,r1		; save exp field
	move.w	a0,y1		; low bits for right shift into a (from left)
	asll.w	a1,y0,a		; a1 = xbbb bbbb 0000 0000, x = implicit
	lsrac	y1,y0,a		; a1 = xbbb bbbb cccc cccc, a0 = dddd dddd 0000 0000
	move.w	r1,y1		; restore exp in bits seee eeee ebbb bbbb
	lsl.w	y1		; strip sign bit
	lsrr.w	y1,y0,y1	; right-align biased exp
	nop
	beq		unpZerSub	; exit if 0 or subnormal
	cmp.w	#$0ff,y1	; look for max exp
	beq		unpNanInf
	bfset	#$8000,a1	; jam the implicit 1-bit
	move.w	#0,a2		; be sure high bits are Czero
	rts

; Distinguish Nan and Inf by significand, sans implicit bit
unpNanInf:
	add.w	#<2,x0		; 2 for inf, 3 for NaN
	asl		a		; strip implicit bit
	beq		unpSpecDone
unpBump:
	add.w	#<1,x0
	nop
unpSpecDone:
	rts

; Distinguish zero and subnormal by sig, with implicit = 0.
unpZerSub:
	;tst	a		BUGGY INSTRUCTION TESTS HIGH HALF ONLY
	tst.w	a1
	bne		unpNorm
	tst.w	a0
	nop
	beq	unpBump		; go bump x0 by 1 and exit
unpNorm:
	move.w	#<1,y1	; adjust exponent for tiny value
	tst.w	x0		; negative if unnormal
	blt		unpSpecDone
unpNormLoop:
	sub.w	#<1,y1	; dec exp
	asl		a		; sets N and V, so CCR messed up
	tst.w	a1		; check N bit
	bge		unpNormLoop	; >= because only bits might be lowC
	nop				; guaranteed a2 = 0 here
	nop
	rts
	
	ENDSEC

