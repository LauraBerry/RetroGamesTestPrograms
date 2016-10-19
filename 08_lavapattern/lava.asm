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
BORDER_COLOR = $900f  ; Used to make things pretty
SCREEN_RAM = $1E00        ; This is the location of screen RAM.
SCREEN_COLOR_RAM = $9600  ; The colors of chars on the screen.

LAVA_THRESH = 128         ; If our random byte is >= this value, the tile has lava.
LAVA_COLOR = 2            ; Color the lava red.
BG_COLOR = 0              ; And the background black
FONT_TILE = 27            ; Character 27 is a lava tile.
FONT_SPACE = 32           ; Character 32 is a space.

LCG_MULT = 33             ; Multiplier for LCG
LCG_CONST = 1             ; Addition constant for LCG
LCG_SEED = 32000              ; Initial seed value for the LCG (Should be 16 bits)

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
    STA BORDER_COLOR        ; Write this to our border Color register

    ; ==THIS SETS UP THE FONT==
    ; Include this line and the inlclude line at the end to use this font.
    ; Point us to our new character map.
    LDA #CUSTOM_PTR         ; Grab the code for our custom charmap.
    STA CHAR_PTR            ; This is where the machine determines our char map.

    ; Fill the screen. We need to do this in two loops because the screen buffer is large.
    LDX #0
fill_screen:
    JSR lcg                 ; Generate the next random number
    LDA lcg_data            ; Load the value of the LCG Data
    CMP #LAVA_THRESH        ; Compare the value to the lava threshold
    BCS _tile_lava          ; If lcg_data >= LAVA_THRESH, it's lava.
    LDA #FONT_SPACE         ; Else, we're a normal tile
    JMP _write_tile         ; Run to the end of the screen.
_tile_lava:
    LDA #FONT_TILE          ; Lava tile!
_write_tile:
    STA SCREEN_RAM,X        ; Print that char to the screen
    LDA #LAVA_COLOR         ; Load the color
    STA SCREEN_COLOR_RAM,X  ; Print the color
    INX                     ; Decrement Loop Counter
    BNE fill_screen         ; Iterate!

    ; This is the ugly second loop. Pretty much a duplicate of the first.
    ; TODO: Maybe combine the loops. Could probably do something with self-modifying code.
    LDX #$f9                ; Don't outstep our screen memory.
fill_screen2:
    JSR lcg                 ; Generate the next random number
    LDA lcg_data            ; Load the value of the LCG Data
    CMP #LAVA_THRESH        ; Compare the value to the lava threshold
    BCS _tile_lava2         ; If lcg_data >= LAVA_THRESH, it's lava.
    LDA #FONT_SPACE         ; Else, we're a normal tile
    JMP _write_tile2        ; Run to the end of the screen.
_tile_lava2:
    LDA #FONT_TILE          ; Lava tile!
_write_tile2:
    STA SCREEN_RAM+$100,X       ; Print that char to the screen
    LDA #LAVA_COLOR             ; Load the color
    STA SCREEN_COLOR_RAM+$100,X ; Write the color
    DEX                         ; Decrement Loop Counter
    TXA                         ; Transfer loop counter to A for compare
    CMP #-1                     ; Compare to -1
    BNE fill_screen2            ; We finish looping when we hit -1

end:
    JMP end

;
; Linear Congruential Generator for Random Numbers.
; lcg_data holds the 16 bit random number
;
; Precondition: lcg_data holds a 16 bit number. (The seed)
; Postcondition: lcg_data = (33 * lcg_data) + 1 % 2^16
;
; Preserves X register. Wipes away others.
:
lcg:
    STX tmp                 ; Store our X
    LDA lcg_data            ; Save the high byte
    STA lcg_tmp_data        ; (In the temp place)
    LDA lcg_data+1          ; Save the low byte
    STA lcg_tmp_data+1      ; (In the temp place)

    ; Multiply by 32 by left shifting.
    CLC                     ; Clean this filth.
    LDX #5                  ; 32 = 2^5. 5 left shifts.
lcg_shift_loop:             ; Do our shifts through the carry (5 times)
    ROL lcg_data+1          ; Left shift low bits
    ROL lcg_data            ; Left Shift the carry into high bits.
    CLC                     ; Discard the highest bit we shift out.
    DEX                     ; Loop index decrement
    BPL lcg_shift_loop      ; Loopishness

    ; To multiply by 33, add the original value again.
    LDA lcg_data+1          ; Get the new low bytes
    ADC lcg_tmp_data+1      ; Add the old low bytes
    STA lcg_data+1          ; Store the low bytes back
    BCC lcg_add_highbytes   ; If there's no carry, proceed to adding high bytes
    INC lcg_data            ; If there is, increment the high byte first
lcg_add_highbytes:
    LDA lcg_data            ; Get the new high bytes
    ADC lcg_tmp_data        ; Add the old high bytes
    STA lcg_data            ; Store the high bytes back
    
    ; Increment the values. If there's overflow, carry it over.
    LDA lcg_data+1          ; Grab the low byte
    ADC #1                  ; Add c
    STA lcg_data+1          ; Store it back
    BCC lcg_end             ; If there was no overflow, we're good. Return.
    INC lcg_data            ; Else, add 1 to the high byte (ignore overflow here)

lcg_end:
    LDX tmp                 ; Restore our X
    RTS                     ; Return to Sender


; **************** DATA Section ****************************
; I'm storing variables here.
; Maybe come up with some kind of naming convention for vars in the future?
lcg_data: ; Random number stored here. Initialize to the high and low seed bytes.
    byte >LCG_SEED,<LCG_SEED
lcg_tmp_data:
    byte 0,0 ; Used for intermediate computation
tmp:
    byte 0 ; Used to store registers so we don't mess them up in functions

    ; This is our font file. Include it last. It maps to 7168 in mem.
    include "../02_fonts/font.asm"

