

; MSL
; Copyright ©1995-2002 Freescale Corporation.  All rights reserved.




; SECTION: the floating point code

	SECTION	fp_engine
	
	OPT	    CC
	
	include "Fp56800E.h"
	
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
	adda    #SIZE_TEMPS,SP
	NORMALIZE_OMR
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
	; wb1-41373 - Allow jump table dispatch to handle 16 and
	; 24-bit address calculations.
	;
	CALC_DISPATCH y1,cmp_dispatch_top
	
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
	RESTORE_OMR
	suba    #SIZE_TEMPS,SP
	clr.w	y0
	tst.w	y0		; set Z in CC
	rts
cmp_less:
cmp_true:
cmp_done:
	RESTORE_OMR
	suba    #SIZE_TEMPS,SP
	move.w	#1,y0
	cmp.w	#<2,y0		; set C and N
	rts


;===============================================================================
; TERMINAL: cmp_greater
; DESCRIPTION: Deliver the result greater than.
; OUTPUT: y0 = 2
;
cmp_greater:
	RESTORE_OMR
	suba    #SIZE_TEMPS,SP
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
	RESTORE_OMR
	suba    #SIZE_TEMPS,SP
	move.w	#3,y0
	cmp.w	#<1,y0		; clear all CC bits
	bfset	#2,sr		; set V bit
	rts

	
	

	ENDSEC
