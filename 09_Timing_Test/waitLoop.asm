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
	STA color_value
	STA COLORMAP
	STA AUXCOLOR
sloop:
	LDA color_value			;write what ever is in to COLORMAP and AUXCOLOR
	STA COLORMAP
	STA AUXCOLOR
	LDA #00
	JSR RDTIM     			 ;busy loop to make the program wait 3 seconds                     
    ADC #10               	; add 10 to curr value of A 	 
    STA next_inc			; store value of A to next_inc
subLoop:      					
    JSR RDTIM               
    CMP next_inc     			;loop 10 times		
    BNE subLoop          	
    RTS
	
	LDA color_checker			;load color checker value into A
	CMP #0
	BNE yellow					;if A!=0 move to next color
	LDA #0						;make screen black
	STA color_value
	ADC #1
	STA color_checker
	jmp sloop
	
yellow:							;make screen yellow
	CMP #1
	BNE red						;if A!= 1 move to next color
	ADC #1
	STA color_checker
	LDA #07
	STA color_value
	jmp sloop 
	
red:							;make screen red
	LDA #02
	STA color_value
	LDA #0						;re-set X to 0 so on next loop screen will go black.
	STA color_checker
	jmp sloop
	
; **************** DATA Section ****************************
next_inc: byte 0 
	
color_checker: byte 0			;0== black, 1== yellow, 2== red 

color_value: byte 0				;0==black, 7== yellow, 2== red

