;************************************************************************************
; File: bitmap.asm
; Author:  Anthony Rufrano (paradoxnj)
; Description:  Display koala file example for Commander X16 using the VERA chip
;************************************************************************************

; Tell ACME what to name the file and what format it is
; CX16 uses Commodore format
!to "bitmap.prg", cbm

;***************************
; Define Constants
;***************************

VERA_ADDR_LO    = $9F20
VERA_ADDR_MID   = $9F21
VERA_ADDR_HI    = $9F22
VERA_DATA1      = $9F23
VERA_DATA2      = $9F24
VERA_CTRL       = $9F25
VERA_IEN        = $9F26
VERA_ISR        = $9F27

; Setup BASIC start routine
; 10 SYS 2049
*=$0801

!byte $0B,$08,$0A,$00,$9E,$20,$32,$30,$36,$32,$00,$00,$00

*=$0000

init:
    ;******************************************
    ; Tell VERA which data port we are using
    ;******************************************
    lda #0
    sta VERA_CTRL                   ; Select primary VRAM address

    ;******************************************
    ; Copy the bitmap from $6000 to VRAM
    ;******************************************
    lda #$10
    ldx #$00
    ldy #$00

    sta VERA_ADDR_HI
    stx VERA_ADDR_MID
    sty VERA_ADDR_LO

    lda #1
    sta VERA_DATA1

    ldx #$88
    ldy #0
    lda #<bitmap+2
    sta 2
    lda #>bitmap+2
    sta 3
loop1:
    lda (2),y
    sta VERA_DATA1
    iny
    bne loop1
    inc 3
    dex
    bne loop1

    ;******************************************
    ; Setup the Display Composer to output
    ; VGA
    ;******************************************
    lda $1F
    ldx $00
    ldy $00

    sta VERA_ADDR_HI
    stx VERA_ADDR_MID
    sty VERA_ADDR_LO

    lda #1                                  ; VGA Output
    sta VERA_DATA1

    lda #64                                 ; 320x200 Resolution
    sta VERA_DATA1                          ; Store Horizontal
    sta VERA_DATA1                          ; Store Vertical

    lda #2                                  ; Set the border color
    sta VERA_DATA1

    ;******************************************
    ; Tell VERA what memory address to use
    ; We are using $F2000 for Layer0
    ;******************************************
    lda #$1F                        ; Set the stride to 1 and the hi mem to F
    ldx #$20                        ; Set the mid to 0
    ldy #$00                        ; Set the lo to 0

    sta VERA_ADDR_HI
    stx VERA_ADDR_MID
    sty VERA_ADDR_LO


    ;*****************************************************************************************************
    ; Layer display modes
    ; Each layer supports a few different display modes, which can be selected using the MODE field:
    ;
    ; Mode	        Description
    ; ----          -----------
    ; 0	            Tile mode 1bpp (per-tile 16 color foreground and background color)
    ; 1	            Tile mode 1bpp (per-tile 256 color foreground color and fixed background color 0)
    ; 2	            Tile mode 2bpp
    ; 3	            Tile mode 4bpp
    ; 4	            Tile mode 8bpp
    ; 5	            Bitmap mode 2bpp
    ; 6	            Bitmap mode 4bpp
    ; 7	            Bitmap mode 8bpp
    ;*****************************************************************************************************
    lda #6 << 5 | 1                             ; 4bpp Bitmap Mode (Bit 7,6,5 = 6)
    sta VERA_DATA1

    lda #0                                      ; TileW = 320
    sta VERA_DATA1
    sta VERA_DATA1                              ; Map_Base_L not used
    sta VERA_DATA1                              ; Map_Base_H not used

    lda #<bitmap
    sta VERA_DATA1
    lda #>bitmap
    sta VERA_DATA1


gameloop:
    jmp *                           ; Infinite loop
    rts                             ; Back to OS

*=$6000
bitmap:
 !bin "danica.kla"
