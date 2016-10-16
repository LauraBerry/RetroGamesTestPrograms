;
; VIC20 Test Program
; Sound Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program is meant to test sound output in the VIC20
;

; ************* Program Constants ****************
NOTEg = #$175
NOTEd = #373
NOTEf = #$163
QUIET = #$00
; The manual for note values is completely useless. I will have to do some testing to figue out which values are within the range of acceptable values (#$175 = #373)
LOWSOUND = $900A
MIDSOUND = $900B
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
one:
	LDA NOTEd
	STA MIDSOUND
	JMP init

	 

