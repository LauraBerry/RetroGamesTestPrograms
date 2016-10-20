;
; VIC20 Test Program
; Move characters on the screen
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program is to show that we can get assembly code running on the VIC20.
;

; **************** Program Constants ***********************
        ; clear screen kernel method
;A = #$11;   dec 17	
;D = #$12;   dec 18
;W = #$13;   dec 09
;S = #$14;   dec 41
Sscreen = #$1E00	;start of screen memory
Sscreen1 = #$1F00	;start of second part of screen memory
keypress = #$00C5	;read from here to get key press
sln = #$16	;screen line spacing, add to go to the next line 
zero_print = $F0;the character we are printing
zero_x = $F1;the current x location
zero_y = $F2;the current y location
screencolor = $9600		;colour space
screencolor1 = $96ff	;colour space
; **************** Assembly Stub ***************************

    processor 6502          ; We're on the 6502 Processor
    org 4097                ; Set the origin location of our code.

;labels
chrout = $ffd2

basicStub: 
		dc.w basicEnd		; 4 byte pointer to next line of basic
		dc.w 2013		; 4 byte (can be any number for the most part)
		hex  9e			; 1 byte Basic token for SYS
		hex  20			; ascii for space = 32
		hex  34 31 31 30	; hex for asci 4110
		hex 00
basicEnd:	hex 00 00        	; The next BASIC line would start here
;------------------------------------------------------------
;----change the screen colour 
	LDA #00
	LDX #$00
color:
	STA screencolor,x
	STA screencolor1,x
	INX
	CPX #$ff
	BNE color

	

;------set player location
	LDA #$01
	STA zero_print
	LDA #$0B
	STA zero_y
	LDA #$00
	STA zero_x
;--------movement loop
move:
	LDA keypress
	CMP #17	;A
	BEQ cleft
	CMP #18	;D
	BEQ cright
	CMP #9	;S
	BEQ cdown
	CMP #41	;W
	BEQ cup
	JMP move
cleft:
	JMP left
cright:
	JMP right
cdown:
	JMP	down
cup:
	JMP up



left:
	LDX zero_x
	CPX #$00
	BEQ	leftat
	DEX
	STX zero_x
	JMP leftend
leftat:	
	LDA #21
	STA zero_x
leftend:
	JMP printcharacter


right:
	LDX zero_x
	CPX #$15
	BEQ	rightat
	INX
	STX zero_x
	JMP rightend
rightat:	
	LDA #00
	STA zero_x
rightend:
	JMP printcharacter

	
down:
	LDX zero_y
	CPX #$16 
	BEQ downat
	INX
	STX zero_y
	JMP downend
downat:
	LDA #$00
	STA zero_y
downend:
	JMP printcharacter

up:
	LDX zero_y
	CPX #$00
	BEQ upat
	DEX
	STX zero_y
	JMP upend
upat:
	LDA #$16
	STA zero_y
upend:
	JMP printcharacter
	
	
	
;-------------------print the character at the new spot-----------------
printcharacter:
;check if at the break line	
	LDA zero_y
	CMP #$0B
	BEQ atline
;see if in first or second memory page	
	CLC
	SBC #$0B
	BPL printscreen2
;----at screen one, calculate the y offset	
	LDA #$00
	LDX zero_y
pc1:	;loop to add
	CPX #$00
	BEQ pc1d
	ADC #$15
	DEX
	JMP pc1
pc1d:	;add x offset
	ADC zero_x
	TAX
	DEX
	LDA zero_print
	STA $1E00,x
	ADC #$01
	STA zero_print
	JMP move
;----at screen two calculate the print position
printscreen2: ;1EF2
;get y location on the second table
	TAX
	LDA #$00
pc2:
	CPX #$0C
	BEQ pc2d
	ADC #$16
	DEX
	JMP pc2
pc2d:
	ADC zero_x
	TAX
	DEX
	DEX
	LDA zero_print
	STA $1F08,x
	ADC #$01
	STA zero_print
	JMP move
;----on the fuck line, calculate the print position
atline:
	LDA zero_print	;get print character
	LDX zero_x	;get x offset
	STA $1EF2,x	;store to screen memory
	ADC #$01
	STA zero_print
	JMP move

	
	BRK
