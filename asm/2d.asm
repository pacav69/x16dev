.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

; zero page registers

r0 = $02
r0_L = $02
r0_H = $03

r1 = $04
r1_L = $04
r1_H = $05

r2 = $06
r2_L = $06
r2_H = $07

r3 = $08
r3_L = $08
r3_H = $09

; floating point stuff 

GIVAYF = $FE03					; convert signed 16 bit word int to float; A/Y (hi/lo)
GETADR = $fe06					; convert float to unsigned 16 bit word at A/Y (hi/lo) 
FOUT = $fe81					; output the FAC as a string stored in memory from $100
DIV10 = $fe3c 					; divides the FAC by 10 
NEGOP = $fe93					; negate the FAC 
MOVMF = $fe4b					; move the FAC to memory at address X/Y
MOVFM = $fe48					; move memory content from A/Y to FAC 
MOVEF = $fe54					; copy FAC to FAC2
MOVFA = $fe4e					; copy FAC2 to FAC
MULTT = $fe2a     				; FAC = FAC * FAC2
FADDT = $fe15					; FAC = FAC + FAC2  
FCOMP = $fe6f					; comp FAC to float in A/Y mem -> A. 0=equal, 1=FAC>mem, 255=FAC<mem
FSUBT = $fe0f 					; FAC = FAC2 - FAC 
FDIVT = $fe42					; FAC = FAC2 / FAC 
MUL10 = $fe36					; FAC *= 10
COS	= $fea5						; FAC = cos(FAC)
SIN	= $fea8						; FAC = sin(FAC)
INT	= $fe78						; FAC = int(FAC)

; graphics stuff

SCREEN_set_mode = $ff5f 
GRAPH_init = $ff20
GRAPH_set_colors = $ff29 
GRAPH_clear = $ff23 
GRAPH_draw_line = $ff2c
GRAPH_draw_rect = $FF2F

CHROUT = $FFD2
NEWLINE = $0D

; mouse stuff

mouse_config = $FF68
mouse_get = $FF6B
mouse_scan = $FF71

; some other places to store temporary data 

ZP_PTR_1 = $30					
ZP_PTR_2 = $40 
ZP_PTR_3 = $70 

F_PTR = $25 

Z_HL = $50						; set up the HL register pair in the zero page 
Z_L  = $50
Z_H  = $51

Z_DE = $54						; set up the DE register pair in the zero page 
Z_E  = $54
Z_D  = $55

Z_FG = $46						; set up the FG register pair in the zero page 
Z_G  = $46
Z_F  = $47

Z_BC = $52						; set up the BC register pair in the zero page 
Z_C  = $52
Z_B  = $53

num_off = $30					; start of the PETSCII number chars 
alp_off = $37 					; offset to convert hex number into PETSCII alphabet chars 

start:

	; set up vera graphics 
     
	jsr reset_registers
	lda #$80
	jsr SCREEN_set_mode

	jsr reset_registers
	jsr GRAPH_init
	
	lda #0
	tax
	tay
	lda #1
	jsr GRAPH_set_colors
	
	jsr GRAPH_clear
	
	; define Pi and store it as a float 
	
	lda #<31416
	tay 
	lda #>31416 
	jsr GIVAYF
	jsr DIV10
	jsr DIV10
	jsr DIV10
	jsr DIV10
	
	lda #<Pi
	tax 
	lda #>Pi
	tay 
	jsr MOVMF
	
	jsr MOVEF
	
	; load 180 into float 
	
	lda #<180
	tay
	lda #>180
	jsr GIVAYF
	
	jsr FDIVT ; pi/180 (this is the conversion from deg to rad)
	
	lda #<Rads
	tax 
	lda #>Rads
	tay 
	jsr MOVMF

	lda #<POLY2
	sta Z_L
	lda #>POLY2
	sta Z_H		
	lda #<POLY2_F
	sta Z_E
	lda #>POLY2_F
	sta Z_D
	jsr poly_to_float
	
	lda #<POLY3
	sta Z_L
	lda #>POLY3
	sta Z_H		
	lda #<POLY3_F
	sta Z_E
	lda #>POLY3_F
	sta Z_D
	jsr poly_to_float
	
	lda #<POLY4
	sta Z_L
	lda #>POLY4
	sta Z_H		
	lda #<POLY4_F
	sta Z_E
	lda #>POLY4_F
	sta Z_D
	jsr poly_to_float

test_loop:

	lda #<POLY2_F
	sta Z_L
	lda #>POLY2_F
	sta Z_H	
	lda #<5
	sta Z_C
	lda #>5
	sta Z_B
	lda #<105
	sta Z_E
	lda #>105   
	sta Z_D 
	lda #<105
	sta Z_G
	lda #>105	
	sta Z_F 
	jsr rotate 
	
	lda #<POLY2_F
	sta Z_L
	lda #>POLY2_F
	sta Z_H	
	lda #<10
	sta Z_C
	lda #>10
	sta Z_B
	lda #<175
	sta Z_E
	lda #>175   
	sta Z_D 
	lda #<75
	sta Z_G
	lda #>75	
	sta Z_F 
	jsr rotate 
	
	lda #<POLY3_F
	sta Z_L
	lda #>POLY3_F
	sta Z_H	
	lda #<5
	sta Z_C
	lda #>5
	sta Z_B
	lda #<250
	sta Z_E
	lda #>250   
	sta Z_D 
	lda #<70
	sta Z_G
	lda #>70	
	sta Z_F 
	jsr rotate 
	
	lda #<POLY3_F
	sta Z_L
	lda #>POLY3_F
	sta Z_H	
	lda #<1
	sta Z_C
	lda #>1
	sta Z_B
	lda #<180
	sta Z_E
	lda #>190   
	sta Z_D 
	lda #<100
	sta Z_G
	lda #>100	
	sta Z_F 
	jsr rotate 
	
	lda #<POLY4_F
	sta Z_L
	lda #>POLY4_F
	sta Z_H	
	lda #<1
	sta Z_C
	lda #>1
	sta Z_B
	lda #<75
	sta Z_E
	lda #>75   
	sta Z_D 
	lda #<75
	sta Z_G
	lda #>75	
	sta Z_F 
	jsr rotate
	
	lda #<POLY4_F
	sta Z_L
	lda #>POLY4_F
	sta Z_H	
	lda #<5
	sta Z_C
	lda #>5
	sta Z_B
	lda #<80
	sta Z_E
	lda #>80   
	sta Z_D 
	lda #<75
	sta Z_G
	lda #>75	
	sta Z_F 
	jsr rotate
	
	lda #<POLY4_F
	sta Z_L
	lda #>POLY4_F
	sta Z_H	
	lda #<10
	sta Z_C
	lda #>10
	sta Z_B
	lda #<60
	sta Z_E
	lda #>60   
	sta Z_D 
	lda #<55
	sta Z_G
	lda #>55	
	sta Z_F 
	jsr rotate

	inc COL

	lda #0
	tax
	tay
	lda COL
	jsr GRAPH_set_colors
	
	lda #<POLY2_F
	sta Z_L
	lda #>POLY2_F
	sta Z_H	
	jsr draw_poly_float

	inc COL 

	lda #0
	tax
	tay
	lda COL
	jsr GRAPH_set_colors
	
	lda #<POLY3_F
	sta Z_L
	lda #>POLY3_F
	sta Z_H	
	jsr draw_poly_float
	
	inc COL 

	lda #0
	tax
	tay
	lda COL
	jsr GRAPH_set_colors
	
	lda #<POLY4_F
	sta Z_L
	lda #>POLY4_F
	sta Z_H	
	jsr draw_poly_float
	
	lda #100
	cmp COL
	beq clr_scr
	lda #150
	cmp COL
	beq clr_scr
	lda #200
	cmp COL
	beq clr_scr
	jmp skip_clr 
clr_scr:
	jsr GRAPH_clear
skip_clr:
	
	;jsr delay
	
	jmp test_loop
	
	rts

reset_registers: ; resets the registers used to pass arguments to the graphics stuff 
	stz r0_L
	stz r0_H
	stz r1_L
	stz r1_H
	stz r2_L
	stz r2_H
	stz r3_L
	stz r3_H
	rts 
	
delay:
	lda  #$1
	ldy  #$33   ; (2 cycles)
    ldx  #$ff   ; (2 cycles)
delay_loop:
	dex          ; (2 cycles)
    bne  delay_loop   ; (3 cycles in loop, 2 cycles at end)
    dey          ; (2 cycles)
    bne  delay_loop   ; (3 cycles in loop, 2 cycles at end)
	dec
	bne  delay_loop

	rts 
	
; data handling 

poly_to_float:					; converts the polygon in Z_HL to a floating point equivalent 
								; and stores it at location Z_DE
	jsr poly_length
	sta (Z_DE)					; store the length at the beginning of the poly_float object 

	clc
	lda Z_E 
	adc #1
	sta Z_E 
	lda Z_D 
	adc #0 
	sta Z_D 
 
	lda #255					
	tay
	
poly_to_float_loop: ; note high bytes are Z_H, Z_B, Z_D 
	iny
	
	iny
	lda (Z_HL),y
	cmp #$ff 	; check if the high byte is $ff then this marks the end of the polygon
	beq poly_to_float_loop_end
	dey
	
	lda (Z_HL),y	; low bytes first 
	sta r0_L
	iny				; now high bytes
	lda (Z_HL),y
	sta r0_H
		
	iny
	lda (Z_HL),y	; low bytes first
	sta r1_L
	iny				; now high bytes
	lda (Z_HL),y 
	sta r1_H
	
	tya
	sta ZP_PTR_1	; back up .Y
	
	lda r0_L
	tay 		; low byte to .Y
	lda r0_H 	; high byte of X
	jsr GIVAYF	; to float
	
	lda Z_E
	tax 
	lda Z_D 	
	tay 
	jsr MOVMF
	
	clc
	lda Z_E  
	adc #5
	sta Z_E 
	lda Z_D
	adc #0
	sta Z_D 
 
	lda r1_L
	tay 		; low byte to .Y
	lda r1_H 	; high byte of Y 
	jsr GIVAYF	; to float
	
	lda Z_E
	tax 
	lda Z_D 	
	tay 
	jsr MOVMF
	
	clc
	lda Z_E  
	adc #5
	sta Z_E 
	lda Z_D
	adc #0
	sta Z_D 
	
	lda ZP_PTR_1
	tay				; get .Y back 
	
	jmp poly_to_float_loop
	
poly_to_float_loop_end: 
	rts 
	
	
poly_length:					; returns the length of polygon at Z_HL to .A 
	lda #255
	tay
	
	lda #0
	tax
	
poly_length_loop: ; note high bytes are Z_H, Z_B, Z_D 
	iny
	
	iny
	lda (Z_HL),y
	cmp #$ff 	; check if the high byte is $ff then this marks the end of the polygon
	beq poly_length_loop_end
	dey
	
	iny				
	iny
	iny				
	
	inx
	
	jmp poly_length_loop
	
poly_length_loop_end:

	txa 
	rts 
	
; transforming functions

neg_16_HL: 						; negate 16 bit value in HL 
	lda Z_L
	eor AllBits
	inc
	sta Z_L
	lda Z_H
	eor AllBits
	sta Z_H
	rts 
	
neg_16_DE: 						; negate 16 bit value in DE 
	lda Z_E
	eor AllBits
	inc
	sta Z_E
	lda Z_D
	eor AllBits
	sta Z_D
	rts 

neg_16_BC: 						; negate 16 bit value in BC 
	lda Z_C
	eor AllBits
	inc
	sta Z_C
	lda Z_B
	eor AllBits
	sta Z_B
	rts 

translate: 		; translate the polygon in Z_HL by the offset x=Z_BC and y=Z_DE

	lda #255
	tay
	
translate_loop: ; note high bytes are Z_H, Z_B, Z_D 
	iny
	
	iny
	lda (Z_HL),y
	cmp #$ff 	; check if the high byte is $ff then this marks the end of the polygon
	beq translate_loop_end
	dey
	
	clc
	lda (Z_HL),y	; low bytes first 
	adc Z_C 
	sta (Z_HL),y
	iny				; now high bytes
	lda (Z_HL),y 
	adc Z_B 
	sta (Z_HL),y 	; x translate is done 
	
	iny
	clc
	lda (Z_HL),y	; low bytes first 
	adc Z_E 
	sta (Z_HL),y
	iny				; now high bytes
	lda (Z_HL),y 
	adc Z_D 
	sta (Z_HL),y 	; y translate is done 
	
	jmp translate_loop
	
translate_loop_end: 
	rts 
	
rotate: 		; rotates the polygon in Z_HL by the angle (degrees) in BC, about point DE(x),FG(y) 

	lda (Z_HL)
	sta ZP_PTR_1	; store the length of the poly to be rotated
	
	lda #0
	sta ZP_PTR_2	; a counter 
	
	clc
	lda Z_L
	adc #1
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H

	lda Z_E
	tay 		; low byte to .Y
	lda Z_D 	; high byte of X
	jsr GIVAYF	; to float 
	
	lda #<Cx
	tax 
	lda #>Cx 	; store this X value 
	tay 
	jsr MOVMF
	
	lda Z_G
	tay 		; low byte to .Y
	lda Z_F 	; high byte of Y
	jsr GIVAYF	; to float 
	
	lda #<Cy
	tax 
	lda #>Cy 	; store this Y value 
	tay 
	jsr MOVMF

	lda Z_C 	; low byte -> Y
	tay 
	lda Z_B 	; high byte of angle 
	jsr GIVAYF 	; to float 
	
	jsr MOVEF   ; to FAC2 
	
	lda #>Rads
	tay
	lda #<Rads
	jsr MOVFM	; get the deg to rads ratio 
	
	jsr MULTT	; angle in rads = angle*pi/180
	
	jsr COS		; cos(FAC) 
	
	lda #<Ca
	tax 
	lda #>Ca 	; store this cos value 
	tay 
	jsr MOVMF
	
	; get the original angle back 
	lda Z_C 	; low byte -> Y
	tay 
	lda Z_B 	; high byte of angle 
	jsr GIVAYF 	; to float 
	
	jsr MOVEF   ; to FAC2 
	
	lda #>Rads
	tay
	lda #<Rads
	jsr MOVFM	; get the deg to rads ratio 
	
	jsr MULTT	; angle in rads = angle*pi/180
	
	jsr SIN		; sin(FAC) 
	
	lda #<Sa
	tax 
	lda #>Sa 	; store this sin value 
	tay 
	jsr MOVMF	; ALL WORKS UP TO HERE *************************
	
	lda #255
	tay 
	
rotate_loop:

	tya
	sta ZP_PTR_3 ;	back up Y - it will now get trashed 

	lda Z_H
	tay
	lda Z_L
	jsr MOVFM 	; load x 
	
	jsr MOVEF	; FAC2 = x
	
	lda #>Cx
	tay
	lda #<Cx
	jsr MOVFM	; FAC = Cx

	jsr FSUBT	; FAC = x - Cx 
	
	lda #<Tx
	tax 
	lda #>Tx 	; Tx = x - Cx 
	tay 
	jsr MOVMF
		
	clc
	lda Z_L
	adc #5
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H
	
	lda Z_H
	tay
	lda Z_L
	jsr MOVFM 	; load y
	
	jsr MOVEF	; FAC2 = y
	
	lda #>Cy
	tay
	lda #<Cy
	jsr MOVFM	; FAC = Cy

	jsr FSUBT	; FAC = y - Cy 

	lda #<Ty
	tax 
	lda #>Ty 	; Ty = y - Cy 
	tay 
	jsr MOVMF					; ALL WORKS TO HERE *****************
	
	jsr MOVEF 	; Ty in FAC2
	
	lda #>Sa
	tay
	lda #<Sa
	jsr MOVFM	; sin(a) is in FAC 
	
	jsr MULTT	; FAC = Ty * sin(a)
	
	lda #<Tmp
	tax 
	lda #>Tmp 	
	tay 
	jsr MOVMF	; Tmp = Ty * sin(a)
	
	lda #>Tx
	tay
	lda #<Tx
	jsr MOVFM
	
	jsr MOVEF	; Tx is in FAC2 
	
	lda #>Ca
	tay
	lda #<Ca
	jsr MOVFM	; cos(a) is in FAC 
	
	jsr MULTT	; FAC = Tx * cos(a)
	
	jsr MOVEF	; FAC2 = Tx * cos(a) 
	
	lda #>Tmp
	tay
	lda #<Tmp
	jsr MOVFM	; FAC = Ty * sin(a)
	
	jsr FSUBT 	; FAC = Tx * cos(a) - Ty * sin(a) 
	
	jsr MOVEF	; FAC2 = Txnew 
	
	lda #>Cx
	tay
	lda #<Cx
	jsr MOVFM
	
	jsr FADDT	; FAC = Txnew + Cx      WORKS TO HERE!!! 

	;jsr GETADR		; x = Txnew
	;sta r0_H
	;tya 
	;sta r0_L 
	
	lda #<TF1
	tax 
	lda #>TF1 	
	tay 
	jsr MOVMF		; store x value in TF1
	
	lda #>Ty
	tay
	lda #<Ty
	jsr MOVFM
	jsr MOVEF		; FAC2 = Ty 
	
	lda #>Ca
	tay
	lda #<Ca
	jsr MOVFM		; FAC = cos(a) 
	
	jsr MULTT		; FAC = Ty * cos(a) 
		
	lda #<Tmp
	tax 
	lda #>Tmp 	
	tay 
	jsr MOVMF	; Tmp = Ty * cos(a)
	
	lda #>Tx
	tay
	lda #<Tx
	jsr MOVFM
	jsr MOVEF		; FAC2 = Tx

	lda #>Sa
	tay
	lda #<Sa
	jsr MOVFM		; FAC = sin(a)
	
	jsr MULTT		; FAC = Tx * sin(a) 
	
	jsr MOVEF 		; FAC2 = Tx * sin(a) 
	
	lda #>Tmp
	tay
	lda #<Tmp
	jsr MOVFM
	
	jsr FADDT		; FAC = Ty * cos(a) + Tx * sin(a) 
	
	jsr MOVEF		; FAC2 = Tynew 

	lda #>Cy
	tay
	lda #<Cy 
	jsr MOVFM
	
	jsr FADDT		; FAC = Tynew + Cy 
		
	;jsr GETADR		; y = Txnew
	;sta r1_H
	;tya 
	;sta r1_L 
	
	lda #<TF2
	tax 
	lda #>TF2 	
	tay 
	jsr MOVMF		; store y value in TF2 
	
	lda ZP_PTR_3
	tay 		; retrieve the backed up Y

	; copy the temp floats in to the original slots 
	
	sec
	lda Z_L
	sbc #5
	sta Z_L
	lda Z_H
	sbc #0
	sta Z_H
	
	lda #>TF1
	tay
	lda #<TF1
	jsr MOVFM
	
	lda Z_L
	tax 
	lda Z_H	
	tay 
	jsr MOVMF
	
	clc 
	lda Z_L
	adc #5
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H 
	
	lda #>TF2
	tay
	lda #<TF2
	jsr MOVFM
	
	lda Z_L
	tax 
	lda Z_H	
	tay 
	jsr MOVMF
	
	clc 
	lda Z_L
	adc #5
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H 
	
	inc ZP_PTR_2
	lda ZP_PTR_1
	cmp ZP_PTR_2
	beq rotate_loop_end
	
	jmp rotate_loop	

rotate_loop_end:	
	rts 
	
; drawing functions 

draw_poly_float: ; draw the float poly at address Z_HL 

	lda (Z_HL)
	sta ZP_PTR_1	; store the length of the poly to be drawn 
	
	lda #1 
	sta ZP_PTR_2	; a counter 
	
	clc
	lda Z_L
	adc #1
	sta Z_L
	sta Z_C
	lda Z_H
	adc #0
	sta Z_H
	sta Z_B 
	
draw_poly_float_loop:

	lda Z_H
	tay
	lda Z_L
	jsr MOVFM
	
	jsr GETADR		
	sta r0_H
	tya 
	sta r0_L	; x1
	
	clc
	lda Z_L
	adc #5
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H
	
	lda Z_H
	tay
	lda Z_L
	jsr MOVFM
	
	jsr GETADR		
	sta r1_H
	tya 
	sta r1_L	; y1
	
	clc
	lda Z_L
	adc #5
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H
	
	lda Z_H
	tay
	lda Z_L
	jsr MOVFM
	
	jsr GETADR		
	sta r2_H
	tya 
	sta r2_L	; x2
	
	clc
	lda Z_L
	adc #5
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H
	
	lda Z_H
	tay
	lda Z_L
	jsr MOVFM
	
	jsr GETADR		
	sta r3_H
	tya 
	sta r3_L	; y2
	
	sec
	lda Z_L
	sbc #5
	sta Z_L
	lda Z_H
	sbc #0
	sta Z_H
	
	jsr clip				; check if all the coordinates of this line are in range 	
	bne draw_poly_float_skip_line	; returns A=0 if you should draw the line 
	jsr GRAPH_draw_line		; draw the line 
draw_poly_float_skip_line:

	inc ZP_PTR_2
	lda ZP_PTR_1
	cmp ZP_PTR_2
	beq draw_poly_float_loop_end
	jmp draw_poly_float_loop
	
draw_poly_float_loop_end:

	lda Z_H
	tay
	lda Z_L
	jsr MOVFM
	
	jsr GETADR		
	sta r0_H
	tya 
	sta r0_L	; x1
	
	clc
	lda Z_L
	adc #5
	sta Z_L
	lda Z_H
	adc #0
	sta Z_H
	
	lda Z_H
	tay
	lda Z_L
	jsr MOVFM
	
	jsr GETADR		
	sta r1_H
	tya 
	sta r1_L	; y1
	
	lda Z_B
	tay
	lda Z_C
	jsr MOVFM
	
	jsr GETADR		
	sta r2_H
	tya 
	sta r2_L	; x2
	
	clc
	lda Z_C
	adc #5
	sta Z_C
	lda Z_B
	adc #0
	sta Z_B
	
	lda Z_B
	tay
	lda Z_C
	jsr MOVFM
	
	jsr GETADR		
	sta r3_H
	tya 
	sta r3_L	; y2

	jsr clip				; check if all the coordinates of this line are in range 	
	bne draw_poly_float_skip_line1	; returns A=0 if you should draw the line 
	jsr GRAPH_draw_line		; draw the line 
draw_poly_float_skip_line1:
	
	rts

draw_poly:		; expects an address to the polygon to be drawn in Z_HL
				; ASSUMES THAT MINIMUM POLY LENGTH IS 2 COORDS, MAXIMUM 255 
	lda #255
	tay

draw_poly_loop:		
	iny
	lda (Z_HL),y
	sta r0_L
	iny
	lda (Z_HL),y
	sta r0_H	; takes the first x value and places it in r0 
	
	cmp #$ff 	; check if the high byte is $ff then this marks the end of the polygon
	beq draw_poly_end
	
	iny
	lda (Z_HL),y
	sta r1_L
	iny
	lda (Z_HL),y
	sta r1_H	; takes the first y value and places it in r1
	
	iny
	lda (Z_HL),y
	sta r2_L
	iny
	lda (Z_HL),y
	sta r2_H	; takes the next x value and places it in r2
	
	cmp #$ff 	; check if the high byte is $ff then this marks the end of the polygon
	beq draw_poly_end
	
	iny
	lda (Z_HL),y
	sta r3_L
	iny
	lda (Z_HL),y
	sta r3_H	; takes the next y value and places it in r3
	
	jsr clip				; check if all the coordinates of this line are in range 	
	bne draw_poly_skip_line	; returns A=0 if you should draw the line 
	jsr save_y
	jsr GRAPH_draw_line		; draw the line 
	jsr load_y
draw_poly_skip_line:
	dey
	dey
	dey
	dey
	jmp draw_poly_loop
draw_poly_end:

	dey
	dey
	dey
	dey
	dey
	lda (Z_HL),y
	sta r0_L
	iny
	lda (Z_HL),y
	sta r0_H	; takes the first x value and places it in r0 
	
	iny
	lda (Z_HL),y
	sta r1_L
	iny
	lda (Z_HL),y
	sta r1_H	; takes the first y value and places it in r1

	lda #0
	tay
	lda (Z_HL),y
	sta r2_L
	iny
	lda (Z_HL),y
	sta r2_H	; takes the next x value and places it in r2
	
	iny
	lda (Z_HL),y
	sta r3_L
	iny
	lda (Z_HL),y
	sta r3_H	; takes the next y value and places it in r3
	
	jsr clip					; check if all the coordinates of this line are in range 	
	bne draw_poly_skip_line1	; returns A=0 if you should draw the line 
	jsr save_y
	jsr GRAPH_draw_line		; draw the line 
	jsr load_y
draw_poly_skip_line1:
	rts 

save_y:
	tya
	sta ZP_PTR_1
	rts
	
load_y:
	lda ZP_PTR_1
	tay
	rts
	
save_carry:
	bcs save_carry1
	stz ZP_PTR_1
	rts
save_carry1:
	lda #1
	sta ZP_PTR_1
	rts 
	
load_carry:
	lda ZP_PTR_1
	cmp #1
	beq load_carry1
	clc
	rts 
load_carry1:
	sec
	rts 
	
clip:				; check if coordinates in r0-3 are able to be drawn 
					; returns A of 0 if this is the case 				
	lda r1_H		; load the high byte of the first y coordinate 
	bne	clip_OOR	; if it's not zero, we can already say the coordinate is off the screen, and this line
					; should not be drawn
	lda r3_H
	bne clip_OOR	; same again for the other y coordinate 
	
	lda r1_L
	cmp #$C8		; load the low byte of first y and check if >199
	bcs clip_OOR
	
	lda r3_L
	cmp #$C8		; same again for second y coordinate
	bcs clip_OOR
	
	lda r0_H		; load the high byte of the first x coord 
	beq clip_IR0	; if the high byte of x is 0 then it's in range, check the other x 
	cmp #$02
	bcs clip_OOR	; if higher than 2 then out of range 
					; which leaves, if it's 1 then check the low byte 
	lda r0_L
	cmp #$40		; if over or equal to $40 then out of range 
	bcs clip_OOR

clip_IR0:	
	lda r2_H		; load the high byte of the second x coord 
	beq clip_IR		; if the high byte of x is 0 then it's in range 
	cmp #$02
	bcs clip_OOR	; if higher than 2 then out of range 
					; which leaves, if it's 1 then check the low byte 
	lda r2_L
	cmp #$40		; if over or equal to $40 then out of range 
	bcs clip_OOR

clip_IR:			; In Range 
	lda #0
	rts 			; in range, can be drawn 
	
clip_OOR:			; Out Of Range-  do not draw (return A = $FF)
	lda #$FF
	rts 
	
	
; data area 

AllBits: .byte %11111111

Pi:
.byte 0,0,0,0,0

Rads:
.byte 0,0,0,0,0

Sa:					; sin(a)
.byte 0,0,0,0,0

Ca:					; cos(a) 
.byte 0,0,0,0,0

Tmp:
.byte 0,0,0,0,0

Tmp2:
.byte 0,0,0,0,0

Cx:
.byte 0,0,0,0,0

Cy:
.byte 0,0,0,0,0 

Tx:
.byte 0,0,0,0,0

Ty:
.byte 0,0,0,0,0 

POLYS:		; a 2d polygon is an array of x and y points stored as pairs of WORDS terminating in $FF00 or more

COL: 
.byte 1

POLY1:
.word 150 
.word 50	
.word 200 
.word 100	
.word 150 
.word 150 
.word 100 
.word 100 	
.word $ffff			; indicates the end of the polygon (they can be any length)

POLY2:
.word 105
.word 100
.word 108
.word 110
.word 100
.word 104
.word 110
.word 104
.word 102
.word 110
.word $ffff			; indicates the end of the polygon (they can be any length)

POLY3:
.word 220
.word 50
.word 232
.word 90
.word 200
.word 66
.word 240
.word 66
.word 208
.word 90
.word $ffff			; indicates the end of the polygon (they can be any length)

POLY4:
.word 50
.word 50
.word 100
.word 50
.word 100
.word 100
.word 50
.word 100
.word $ffff			; indicates the end of the polygon (they can be any length)

TF1:				; temp floats 
.byte 0,0,0,0,0

TF2: 
.byte 0,0,0,0,0

POLY2_F:			; floating point poly 
.byte 0				; length 
.byte 0,0,0,0,0		; x1
.byte 0,0,0,0,0		; y1
.byte 0,0,0,0,0
.byte 0,0,0,0,0		; ...
.byte 0,0,0,0,0
.byte 0,0,0,0,0
.byte 0,0,0,0,0		; x4
.byte 0,0,0,0,0		; y4 
.byte 0,0,0,0,0		
.byte 0,0,0,0,0	

POLY3_F:			; floating point poly 
.byte 0				; length 
.byte 0,0,0,0,0		; x1
.byte 0,0,0,0,0		; y1
.byte 0,0,0,0,0
.byte 0,0,0,0,0		; ...
.byte 0,0,0,0,0
.byte 0,0,0,0,0
.byte 0,0,0,0,0		; x4
.byte 0,0,0,0,0		; y4 
.byte 0,0,0,0,0		
.byte 0,0,0,0,0	

POLY4_F:			; floating point poly 
.byte 0				; length 
.byte 0,0,0,0,0		; x1
.byte 0,0,0,0,0		; y1
.byte 0,0,0,0,0
.byte 0,0,0,0,0		; ...
.byte 0,0,0,0,0
.byte 0,0,0,0,0
.byte 0,0,0,0,0		; x4
.byte 0,0,0,0,0		; y4 
	

