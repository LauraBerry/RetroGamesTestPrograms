;
; VIC20 Test Program 2
; Font Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; This one is Konrad's fault.
; 
; This program is to show that we can get custom characters and colors on the screen.
; (for graphics presumably but maybe we could use it to get comic sans on here)
;

; **************** Program Constants ***********************
CLRSCN  = $e55f           ; clear screen kernel method
CHAR_PTR = $9005          ; This address determines where we look for character maps.
CUSTOM_PTR = $FF          ; This points us to 7168 ($1c00) for our char map.
BACKGROUND_COLOR = $900f  ; Used for pretty printing purposes
SCREEN_RAM = $1E00        ; This is the location of screen RAM.
SCREEN_COLOR_RAM = $9600  ; The colors of chars on the screen.

; Some unused stuff that will become useful if we start copying fonts from ROM instead of supplying our own.
LOWERCASE_PTR = $F2       ; We insert this value in CHAR_PTR to get lowercase chars
CUSTOM_CHARSET = $1C00    ; This is the location in memory of our custom char map.
REG_CHARSET = $8000       ; The location of the default uppercase/gfx char map.

; **************** Assembly Code ***************************
    processor 6502          ; We're on the 6502 Processor
    org 4097                ; Set the origin location of our code. (At start of BASIC mem)

    ; This is the BASIC stub we use to launch into assembly.
    ; It translates to "2006 SYS4109"
    byte 11,16,214,7,158,"4","1","0","9",0,0,0

init:
    JSR CLRSCN              ; Clear the screen
    
    ; Set the border and background colors
    LDA #$18                ; White Background, Black Border
    STA BACKGROUND_COLOR    ; Write this to our BG Color register

    ; ==THIS SETS UP THE FONT==
    ; Include this line and the inlclude line at the end to use this font.
    ; Point us to our new character map.
    LDA #CUSTOM_PTR         ; Grab the code for our custom charmap.
    STA CHAR_PTR            ; This is where the machine determines our char map.

    ; Print our entire character set.
    LDX #$3F                ; We'll print all 64 characters. (0 to 64)
print_all_chars:
    TXA                     ; Put the char value of X in A
    STA SCREEN_RAM,X        ; Print that char to the screen
    LDA #$2                 ; Color Red
    STA SCREEN_COLOR_RAM,X  ; Print the color
    DEX                     ; Decrement Loop Counter
    BPL print_all_chars     ; Iterate!

end:                        ; Do not return to BASIC prompt. It'll think we're out of memory.
    JMP end                 ; Replace with RTS if you want BASIC back.

    include "font.asm"      ; This is our font file. Include it last. It maps to 7168
