;
; VIC20 Test Program 6
; Score Tracker Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
;
; This program keeps track of a player's score, storing it in memory and incrementing
; or decrementing it.
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
    LDA #28                 ; White Background, Purple Border
    STA BACKGROUND_COLOR    ; Write this to our BG Color register

    ; ==THIS SETS UP THE FONT==
    ; Include this line and the inlclude line at the end to use this font.
    ; Point us to our new character map.
    LDA #CUSTOM_PTR         ; Grab the code for our custom charmap.
    STA CHAR_PTR            ; This is where the machine determines our char map.

    ; Print score string
    LDX #$06                ; 'SCORE: " is 7 characters
print_score:
    LDA score_str,X         ; Location of SCORE string.
    STA SCREEN_RAM,X        ; Print that char to the screen
    LDA #$0                 ; Color Black
    STA SCREEN_COLOR_RAM,X  ; Set the color
    DEX                     ; Decrement Loop Counter
    BPL print_score         ; Iterate!

update_score:               ; This code is run over and over to update the score displayed.
    LDA score               ; Grab our score
    JSR fill_digits         ; Subroutine that fills the digits array in memory

    ; Print the number as a Character representation
    ; Just use the array of digits to output it.
    ; Number display codes start at $30, end at $39
    LDX #$02                  ; Loop 3 times. (1 for each digit)
print_digits:
    CLC                       ; Make sure we start by clearing our carry bit.
    LDA digits,X              ; Load this digit
    ADC #$30                  ; Add $30 to make it a display code
    STA SCREEN_RAM+$7,X       ; Print to Screen
    LDA #$0                   ; Color Black
    STA SCREEN_COLOR_RAM+$7,X ; Set the color
    DEX                       ; Loop Decrement
    BPL print_digits          ; Loopyness

    JSR delay               ; Delay so we don't increment the score too fast
    INC score               ; Increment the Score
    JMP update_score        ; Go back and keep updating the score

; *** Delay Subroutine ***
delay:
    JSR RDTIM               ; Read the time
    ADC #10                 ; Add 10 to the MSB (Dunno how many 'jiffies' that is
    STA next_increment      ; Put it in memory
_wait_loop:                  ; This is weird and I'm not sure it's totally uniform
    JSR RDTIM               ; Read the system timer
    CMP next_increment      ; Check the time against our stored value
    BNE _wait_loop           ; if time != next_increment, loop
    RTS

; *** Fill Digits Subroutine ***
; Takes the value of A, and spits out decimal digits into an array called 'digits'
fill_digits:
    LDX #0                  ; Zero out the digits we're storing
    STX digits
    STX digits + 1
    STX digits + 2

_hundreds:
    CLC
    CMP #100                ; Is our value >= 100?
    BCC _tens               ; If not, check the hundreds
    SBC #100                ; If so, subtract 100
    INC digits              ; And increment the hundreds place.
    JMP _hundreds           ; And check again for the hundreds

_tens:
    CLC
    CMP #10                 ; Is our value >= 10?
    BCC _ones               ; If not, check the hundreds
    SBC #10                 ; If so, subtract 10
    INC digits+1            ; And increment the tens place.
    JMP _tens               ; And check again for the tens

_ones:
    STA digits+2            ; The remainder is our ones place.
    RTS                     ; We're done. Return to caller.

; **************** DATA Section ****************************
; I'm storing variables here.
; Maybe come up with some kind of naming convention for vars in the future?
score:
    byte $0                 ; This is our player's score. Goes to 255.
score_str:                  
    byte $13, $03, $0f, $12, $5, $2c, $20, $0 ; String: "SCORE: \0"
digits: byte 1,2,3          ; Hundreds, Tens, Ones places.
next_increment: byte 0      ; Time at which we'll increment

    ; This is our font file. Include it last. It maps to 7168 in mem.
    include "../02_fonts/font.asm"

