;
; VIC20 Test Program
; Sound Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program is meant to test sound output in the VIC20
;

; ************* Program Constants ****************
NOTEg = #$AF00
NOTEd = #$C900
NOTEf = #$A300
QUIET = #00
; The manual for note values is completely useless. I will have to do some testing to figue out which values are within the range of acceptable values (#$175 = #373)
LOWSOUND = $900A
MIDSOUND = $900B
HIGHSOUND = $900C
NOISE = $900D
VOL = $900E


; ************* Assembly Code ***************
          processor 6502
          org 4097		   	;4097 ; start of program area

basicStub: 
		dc.w basicEnd		; 4 byte pointer to next line of basic
		dc.w 2013		; 4 byte (can be any number for the most part)
		hex  9e			; 1 byte Basic token for SYS
		hex  20			; ascii for space = 32
		hex  34 31 31 30	; hex for asci 4110
		hex 00
basicEnd:	hex 00 00        	; The next BASIC line would start here


init:	
	LDA #15
	STA VOL
	LDX #$00
one:
	LDA NOTEg		; Load note (not really G)
	STA MIDSOUND		; Store note in Mid-Range Speaker
	JSR timer		; Jump to timer subroutine so this note is held
	LDA QUIET		; Load silence
	STA MIDSOUND		; Squelch the Mid-range speaker
	LDX #$00		; reset timer value
	JSR timer		; jump to timer subroutine
	LDX #$00		; reset timer value
	JMP one			; restart the note
two:
;	LDA NOTEf
;	STA LOWSOUND
;	INX
;	CPX #70
;	BNE two
;	LDA QUIET
;	STA LOWSOUND
;	LDX #00
three:
;	LDA NOTEd
;	STA NOISE
;	INX
;	CPX #70
;	BNE three
;	LDA QUIET
;	STA NOISE
;	LDX #00	

timer:
	INX
	CPX #$FF
	BNE timer
	NOP
	RTS

end:
	RTS
	 

