;
; VIC20 Test Program
; <Program Title>
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; <Program Descripion>
;

; ************* Program Constants ****************
CLRSCN  = $e55f
COLORMAP = $900f


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
	LDA #00
	STA COLORMAP
	LDX #00
sloop:
	ADC #1
	LDY #00
subLoop:
	INY
	CPY #$FF
	BNE subLoop	
	LDY #00
subLoop2:
	INY
	CPY #$FF
	BNE subLoop2
	LDY #00
subLoop3:
	INY
	CPY #$FF
	BNE subLoop3	
	LDY #00
subLoop4:
	INY
	CPY #$FF
	BNE subLoop4
	LDY #00	
subLoop5:
	INY
	CPY #$FF
	BNE subLoop5	
	LDY #00
subLoop6:
	INY
	CPY #$FF
	BNE subLoop6
	LDY #00
subLoop7:
	INY
	CPY #$FF
	BNE subLoop7	
	LDY #00
subLoop8:
	INY
	CPY #$FF
	BNE subLoop8
	LDY #00	
	INX 
	CPX #1
	BNE jump
	LDA #07
	STA COLORMAP
	LDA #00
	jmp sloop 
jump:
	LDA #02
	STA COLORMAP
	LDA #00
	LDX #00
	jmp sloop
	