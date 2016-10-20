;
; VIC20 Test Program
; Display text in a loop
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program is to show that we can get assembly code running on the VIC20.
;

; **************** Program Constants ***********************

screencolor = $9600		;colour space
screencolor1 = $96ff	;colour space

screen0 = $1E00			;screen location
screen1 = $1F00			;screen location

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


;***************** Assembly Code****************************
;----------set screen colour	
	LDA #00
	LDX #$00
color:
	STA screencolor,x
	STA screencolor1,x
	INX
	CPX #$ff
	BNE color


;--------generate 22 "random" 0(48) or 1(49), dont 
	LDA #49
	STA $1E16
start:
;------generate
	LDX #$00
	LDA $1E16
	CMP #49
	BEQ g1
generate:
	CMP #49
	BNE g2
g1:
	LDA #48
	JMP gp
g2:
	LDA #49
gp:	
	STA $1E00,x
	INX
	CPX #22
	BNE generate
	JSR screendown
	JMP start
	BRK
	
;-----------function to copy the screen down one row--------	
screendown:	
	LDX #$00
screenloop:
	LDA $1E00,x
	STA $1E16,x	;1e16 is the second row
	LDA $1EB0,x
	STA $1EC6,x ;1F15 is 1e16 + ff
	LDA $1F4A,x
	STA $1F60,x 
	INX
	CPX #$B0
	BNE screenloop
	RTS
	
	
	
