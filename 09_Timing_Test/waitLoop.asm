;
; VIC20 Test Program
; Wait Loop
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; waits 5000 loops and then writes something to the screen.
;

; ************* Program Constants ****************
CLRSCN  = $e55f


; ************* Assembly Code ***************

	processor 6502
	org 4097

	; BASIC stub we use to launch our assembly
	; 158 = 9E = "SYS" token
	byte 11,16,214,7,158,"1","3","3","7",0,0,0

init:	
	LDA #00
	LDX #01
	sloop:
		INC A
		CMP #5000
		BNE sloop
	LDX	$7680  ; writes "A" to the upper left hand corner of the screen.
	INX
	BEQ init	
	jsr CLRSCN 