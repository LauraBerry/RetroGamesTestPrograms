;
; VIC20 Test Program
; Sound Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program is meant to test sound output in the VIC20
;

; ************* Program Constants ****************
NOTEg = #$175
NOTEd = #$228
NOTEf = #$163
LOWSOUND = #$36874
VOL = #$36878


; ************* Assembly Code ***************

;DASM VIC20 BASIC stub --------------------------------------|
          processor 6502
          org 4097		   	;4097 ; start of program area

;labels
chrout  = $ffd2

basicStub: 
		dc.w basicEnd		; 4 byte pointer to next line of basic
		dc.w 2013		; 4 byte (can be any number for the most part)
		hex  9e			; 1 byte Basic token for SYS
		hex  20			; ascii for space = 32
		hex  34 31 31 30	; hex for asci 4110
		hex 00
basicEnd:	hex 00 00        	; The next BASIC line would start here

;End of DASM VIC20 BASIC stub ---------------------------------|

init:	
	LDA #15
	STA VOL
	LDA NOTEg
	STA LOWSOUND
	BEQ init
	 

