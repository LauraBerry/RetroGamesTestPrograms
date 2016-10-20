;
; VIC20 Test Program
; Control Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program demonstrates user control for the game that we will end up making
; The W, A, S, and D keys will be used to represent directions of movement for a player
; This program is meant to show that each directional key can be interpretted in a different way

; ************* Program Constants ****************
CLRSCN  = $e55f
SCNKEY = $FF9F
CHROUT  = $FFD2
GETIN = $FFE4
; ************* Assembly Code ***************
          processor 6502
          org 4097		   	;4097 ; start of program area

;labels

basicStub: 
		dc.w basicEnd		; 4 byte pointer to next line of basic
		dc.w 10			; 4 byte (can be any number for the most part)
		hex  9e			; 1 byte Basic token for SYS
		hex  20			; ascii for space = 32
		hex  34 31 31 30	; hex for asci 4110
		hex 00
basicEnd:	hex 00 00        	; The next BASIC line would start here

init:	
	JSR listen
	CMP #$57		; compare A register to the character code for 'w'
	BEQ up
    CLC
	CMP #$41		; compare A register to the character code for 'a'
	BEQ left
    CLC
	CMP #$44		; compare A register to the character code for 'd'
	BEQ right
    CLC
	CMP #$53		; compare A register to the character code for 's'
	BEQ down

	LDA #$00
	JMP init

up:
	;Print character for "UP" #$61[Spade]
	LDA #$B1
	JSR CHROUT
	LDA #$00
	JMP init
left:
	;Print character for "LEFT" #$78[Spade]
	LDA #$B3
	JSR CHROUT
	LDA #$00
	JMP init
right:
	;Print character for "RIGHT" $7A[Diamond]
	LDA #$AB
	JSR CHROUT
	LDA #$00
	JMP init
down:
	;Print character for "DOWN" #$73[Heart] 
	LDA #$B2
	JSR CHROUT
	LDA #$00
	JMP init

; Function listen. Gets keyboard input.
listen:
	JSR GETIN		; take a character from the keyborad queu and returns it as a ASCII value in A
	CMP #$00
	BEQ listen
	RTS
