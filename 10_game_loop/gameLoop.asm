;
; VIC20 Test Program
; game loop
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; listens for the user to press enter with each enter the screen back ground will change color
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
start:
	LDY #0
	STY black_or_red
turn:
	JSR listen
	LDY black_or_red
	CPY #0
	BNE red	
	LDA #00
	STA COLORMAP
	STA AUXCOLOR
	JSR RDTIM     			 ;busy loop to make the program wait 3 seconds                     
	JSR delay
	LDY #1
	STY black_or_red
	jmp turn
red:
	LDA #02
	STA COLORMAP
	STA AUXCOLOR
	JSR RDTIM     			 ;busy loop to make the program wait 3 seconds                     
	JSR delay
	LDY #0
	STY black_or_red
	jmp turn
	
listen:
	JSR $FFC0 				;OPEN CHANNEL
	JSR $FFC6				;CHECK IN CHANNEL
	JSR $FFCF				;get character from keyboard
	JSR $FFE4				;supposedly take a character from the keyborad queu and returns it as a ASCII value in A
	JSR $FFC3 				;closes the channel	
	RTS
	
delay:
    JSR RDTIM               ; Read the time
    ADC #10                 ; Add 10 to the MSB
    STA next_inc      		; Put it in memory
_wait_loop:                 
    JSR RDTIM               ; Read the system timer
    CMP next_inc      		; Check the time against our stored value
    BNE _wait_loop           ; if time != next_increment, loop
    RTS
	
	; **************** DATA Section ****************************
next_inc: byte 0 

black_or_red: byte 0


