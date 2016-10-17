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
AUXCOLOR = $9600		  ;aux color
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
	LDA #00					;make background black to start
	STA COLORMAP
	STA AUXCOLOR
sloop:
	LDA color_value
	STA COLORMAP
	STA AUXCOLOR
	
	JSR RDTIM     			 ;busy loop to make the program wait 3 seconds                     
    ADC #10                 
    STA next_increment
subLoop:      					
    JSR RDTIM               
    CMP next_increment     			
    BNE subLoop          	
    RTS
	
	LDA color_checker
	CMP #00
	BNE yellow
	LDA #00						;make screen black
	STA color_value
	ADC #1
	STA color_checker
	jmp sloop
yellow:							;make screen yellow
	CMP #1
	BNE red
	ADC #1
	STA color_checker
	LDA #7
	STA color_value
	jmp sloop 
red:							;make screen red
	LDA #2
	STA color_value
	LDX #00						;re-set X to 0 so on next loop screen will go black.
	STA color_checker
	jmp sloop
	
; **************** DATA Section ****************************
next_increment: byte 0 
	
color_checker: byte 0

color_value: byte 0

