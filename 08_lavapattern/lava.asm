;
; VIC20 Test Program 6
; Lava Pattern Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
;
; Generates a random pattern of lava according to some distribution.
; Random numbers generated using a 16 bit LCG
;

; **************** Program Constants ***********************
CLRSCN  = $e55f           ; clear screen kernel method
RDTIM = $FFDE             ; Read Clock Kernel Method
CHAR_PTR = $9005          ; This address determines where we look for character maps.
CUSTOM_PTR = $FF          ; This points us to 7168 ($1c00) for our char map.
BACKGROUND_COLOR = $900f  ; Used to make things pretty
SCREEN_RAM = $1E00        ; This is the location of screen RAM.
SCREEN_COLOR_RAM = $9600  ; The colors of chars on the screen.

; **************** Assembly Code ***************************

    processor 6502          ; We're on the 6502 Processor
    org $1001               ; Set the origin location of this code. (At start of BASIC mem)

    ; This is the BASIC stub we use to launch into assembly.
    ; It translates to "2006 SYS4109"
    byte 11,16,214,7,158,"4","1","0","9",0,0,0

init:                       ; Address 4109
    ; Set up the screen
    JSR CLRSCN              ; Clear the screen
    LDA #24                 ; White on Black
    STA BACKGROUND_COLOR    ; Write this to our BG Color register

end:
    JMP end

; **************** DATA Section ****************************
; I'm storing variables here.
; Maybe come up with some kind of naming convention for vars in the future?

    ; This is our font file. Include it last. It maps to 7168 in mem.
    include "../02_fonts/font.asm"

