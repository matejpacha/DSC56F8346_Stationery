
 
 	section	rtlib
       include	"asmdef.h"

    global  ARTDIV64
    global  FARTDIV64

    org p:


FARTDIV64:
ARTDIV64:


preparation:	
				tfr a,c
				move.l X:(SP-4),a
				move.l X:(SP-2),d
				;move.l X:(SP-6),c
				adda    #4,sp

startLoop:
				move.w	#32,y0
				moveu.w	y0,lc
	
				doslc	endLoop
				tfr d,b
		
shift_start:	

				asl a
				bcc nocarry
				asl d
				add.l #1,d
				jmp shift_end

nocarry:		
				asl d

shift_end:
check_sign:
				eor.l	c,b

				move.w b2,x:(SP+2)
				move.w x:(SP+2),x0
				and.w #$F,x0
				cmp.b #8,x0
	
				blt		sub
add:
				add c,d
				jmp afterSub
sub:			
				sub c,d
				
				move.w lc,b
				cmp #$20,b
				beq afterSub
				
				move.w c,x:(SP+2)
				tfr d,b
				neg c
				move.w c,x:(SP+4)
				move.l x:(SP+4),X:$BC00
				move.w #0,c
				asl c
				add.l x:$BC00,b
				move.l x:(SP+2),c
				
				bcc afterSub
				bfset #1, a0
				
afterSub:
				nop
endLoop:

	suba    #4,sp
	;tfr		d,b
	tfr a,b
	rts

	endsec

	end


