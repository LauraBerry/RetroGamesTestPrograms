;
; VIC20 Test Program
; <Program Title>
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; <Program Descripion>
;

; ************* Program Constants ****************
CLRSCN  = $e55f


; ************* Assembly Code ***************

	processor 6502
	org 4097

	; BASIC stub we use to launch our assembly
	byte 11,16,214,7,158,"1","3","3","7",0,0,0

init:	; labels like this
	; Actual code goes here
	jsr CLRSCN 

