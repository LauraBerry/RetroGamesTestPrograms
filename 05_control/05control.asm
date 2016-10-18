;
; VIC20 Test Program
; Control Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program demonstrates user control for the game that we will end up making
;

; ************* Program Constants ****************
CLRSCN  = $e55f


; ************* Assembly Code ***************
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

init:	; labels like this
	; Actual code goes here
	jsr CLRSCN 

