;
; VIC20 Test Program 1
; Font Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; This one is Konrad's fault.
; 
; This program is to show that we can get custom characters and colors on the screen.
; (for graphics presumably but maybe we could use it to get comic sans on here)
;

; **************** Program Constants ***********************
CHARMAP = $9005             ; Place where we store character maps


; **************** Assembly Code ***************************

    processor 6502          ; We're on the 6502 Processor
    org 4097                ; Set the origin location of our code.

    ; This is the BASIC stub we use to launch into assembly.
    ; It translates to "2006 SYS4109"
    byte 11,16,214,7,158,"4","1","0","9",0,0,0

init:                       ; We can do labels like this.
    LDA #$F2                ; This value corresponds to 'upper and lowercase' character map in ROM
    STA CHARMAP             ; This is where the char map is stored.
    RTS                     ; Transfer Control Back?

