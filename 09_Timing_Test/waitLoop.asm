;
; VIC20 Test Program
; <Program Title>
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; <Program Descripion>
;

; ************* Program Constants ****************
CLRSCN  = $e55f
COLORMAP = $900f		  ;background color
AUXCOLOR = $900e		  ;aux color
RDTIM = $FFDE             ; Read Clock Kernel Method

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
	LDA #04
	STA COLORMAP
	STA AUXCOLOR
	LDX #00
sloop:
	STA COLORMAP
	STA AUXCOLOR
	ADC #1
	LDY #00
subLoop:                  
    JSR RDTIM               ; Read the system timer
    CMP next_increment     			; Check the time against our stored value
    BNE subLoop          	; if time != next_increment, loop
    RTS
	BNE yellow
	LDA #04
	INX
	jmp sloop
yellow:
	CPX #1
	BNE red
	LDA #7
	INX
	jmp sloop 
red:
	LDA #2
	LDX #00
	jmp sloop
	
; **************** DATA Section ****************************
next_increment: byte 0 
	