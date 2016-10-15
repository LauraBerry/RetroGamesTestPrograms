;
; VIC20 Test Program 1
; Clear the Screen
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program is to show that we can get assembly code running on the VIC20.
;

; **************** Program Constants ***********************
CLRSCN  = $e55f             ; clear screen kernel method


; **************** Assembly Code ***************************

    processor 6502          ; We're on the 6502 Processor
    org 4097                ; Set the origin location of our code.

    ; This is the BASIC stub we use to launch into assembly.
    ; It translates to "2006 SYS4109"
    byte 11,16,214,7,158,"4","1","0","9",0,0,0

init:                       ; We can do labels like this.
    jsr CLRSCN              ; All this test program does is clear the screen.

