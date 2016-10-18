;
; VIC20 Test Program
; game loop
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; checks memory location to see if player has touched the lava (died) and if so prints game over  new game Y N on the screen
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

turn:
	JSR $FFC0 ;OPEN CHANNEL
	JSR $FFC6	;CHECK IN CHANNEL
	LDX #00
	JSR $FFCF
	JSR $FFE4
	TXA
	CPX $41
	BNE red
	LDA #00
	STA COLORMAP
	STA AUXCOLOR
	JSR RDTIM     			 ;busy loop to make the program wait 3 seconds                     
	JSR delay
	jmp turn
red:
	LDA #02
	STA COLORMAP
	STA AUXCOLOR
	JSR RDTIM     			 ;busy loop to make the program wait 3 seconds                     
	JSR delay
	jmp turn
	
delay:
    JSR RDTIM               ; Read the time
    ADC #10                 ; Add 10 to the MSB (Dunno how many 'jiffies' that is
    STA next_inc      		; Put it in memory
_wait_loop:                  ; This is weird and I'm not sure it's totally uniform
    JSR RDTIM               ; Read the system timer
    CMP next_inc      		; Check the time against our stored value
    BNE _wait_loop           ; if time != next_increment, loop
    RTS
	
	; **************** DATA Section ****************************
next_inc: byte 0 


