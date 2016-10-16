;
; VIC20 Test Program
; Wait Loop
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; waits 5000 loops and then writes something to the screen.
;

; ************* Program Constants ****************
CLRSCN  = $e55f
COLORMAP = $36879 					;location of colors in vic 20


; ************* Assembly Code ***************

	processor 6502
	org 4097

	; BASIC stub we use to launch our assembly
	; 158 = 9E = "SYS" token
	byte 11,16,214,7,158,"1","3","3","7",0,0,0

init:	
	LDA #00
	STA COLORMAP
	LDX #00
sloop:
	ADC #1
	CMP #99
	BNE sloop
	INX 
	CPX #1
	BNE jump
	LDA #07
	STA COLORMAP
	LDA #00
	jmp sloop 
jump:
	LDA #02
	STA COLORMAP
	LDA #00
	LDX #00
	jmp sloop
	