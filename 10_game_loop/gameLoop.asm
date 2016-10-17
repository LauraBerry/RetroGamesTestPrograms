;
; VIC20 Test Program
; game loop
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; <Program Descripion>
;

; ************* Program Constants ****************
CLRSCN  = $e55f
CURRSCORE = $4100
TOUCHEDLAVA = $4101



; ************* Assembly Code ***************

	processor 6502
	org 4097

	; BASIC stub we use to launch our assembly
	; 158 = 9E = "SYS" token
	byte 11,16,214,7,158,"1","3","3","7",0,0,0

turn:
	;LDA #score
	;STA CURRSCORE
	LDA TOUCHEDLAVA
	CMP #1
	BEQ	jump
	LDA CURRSCORE
	ADC #1
	STA CURRSCORE
	JSR $FFD2
	BEQ turn
jump:
	;this should spell out game over
	LDA #$47
	JSR $FFD2
	LDA #$41
	JSR $FFD2
	LDA #$53
	JSR $FFD2
	LDA #$45
	JSR $FFD2
	LDA $0
	JSR $FFD2
	LDA #$55
	JSR $FFD2
	LDA #$62
	JSR $FFD2
	LDA #$45
	JSR $FFD2
	LDA #$58
	JSR $FFD2
	LDY #00
subLoop:        	
    CPY #$ff
	BNE subLoop
	;jsr CLRSCN	 
	;this should spell out start game
	LDA #$59
	JSR $FFD2
	LDA #$60
	JSR $FFD2
	LDA #$41
	JSR $FFD2
	LDA #$58
	JSR $FFD2
	LDA #$60
	JSR $FFD2
	LDA $0
	JSR $FFD2
	LDA #$47
	JSR $FFD2
	LDA #$41
	JSR $FFD2
	LDA #$53
	JSR $FFD2
	LDA #$45
	JSR $FFD2
	;QUESTION MARK
	LDA $0
	JSR $FFD2
	LDA #65
	JSR $FFD2
	LDA $0
	JSR $FFD2
	LDA $0
	JSR $FFD2
	LDA #54
	JSR $FFD2
	jmp finish		
finish:


; **************** DATA Section ****************************

gameState: byte 0 		;0== game running, 1== end game, 2== new game



;include "../06_score/score_test.asm"