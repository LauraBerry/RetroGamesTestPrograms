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

init:	
	JSR listen
	CMP #$57		; compare A register to the character code for 'w'
	BEQ up
	CMP #$53		; compare A register to the character code for 's'
	BEQ down
	CMP #$41		; compare A register to the character code for 'a'
	BEQ left
	CMP #$44		; compare A register to the character code for 'd'
	BEQ right

	JMP init




listen:
	JSR $FFC0 		; OPEN CHANNEL
	JSR $FFC6		; CHECK IN CHANNEL
	JSR $FF9F		; get character from keyboard
	JSR $FFE4		; supposedly take a character from the keyborad queu and returns it as a ASCII value in A
	CMP #00
	BEQ listen
	JSR $FFC3 		;closes the channel	
	RTS


up:
	;Print character for "UP" (CHR$ 94) #$5E[ArrowUp] #$61[Spade]
	RTS
down:
	;Print character for "DOWN" (CHR$ 94) #$73[Heart] 
	RTS
left:
	;Print character for "LEFT" (CHR$ 94) #$78
	RTS
right:
	;Print character for "RIGHT" (CHR$ 94) $5E
	RTS
