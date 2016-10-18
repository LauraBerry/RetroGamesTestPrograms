;
; VIC20 Test Program
; Sound Test
; (C) 2016 by Konrad Aust, Laura Berry, Andrew Lata, Yue Chen
; 
; This program is meant to test sound output in the VIC20
;

; ************* Program Constants ****************
NOTEg = #244	; high 244 (mid note)
NOTEc = #145	; lowest note
NOTEf = #209	; highest note
QUIET = #00
; The manual for note values is completely useless. I will have to do some testing to figue out which values are within the range of acceptable values (#$175 = #373)
LOWSOUND = $900A
MIDSOUND = $900B
HIGHSOUND = $900C
NOISE = $900D
VOL = $900E
RDTIM = $FFDE


; ************* Assembly Code ***************
          processor 6502
          org 4097		   	;4097 ; start of program area

basicStub: 
		dc.w basicEnd		; 4 byte pointer to next line of basic
		dc.w 2013		; 4 byte (can be any number for the most part)
		hex  9e			; 1 byte Basic token for SYS
		hex  20			; ascii for space = 32
		hex  34 31 31 30	; hex for asci 4110
		hex 00
basicEnd:	hex 00 00        	; The next BASIC line would start here


init:	
	LDY #15
	STY VOL
one:
	LDY NOTEg		; Load note (not really G)
	STY MIDSOUND		; Store note in Mid-Range Speaker
	JSR RDTIM		; 
	JSR delay		; Jump to delay subroutine
	LDY QUIET		; Load silence
	STY MIDSOUND		; Squelch the mid-range speaker
;	JSR RDTIM
;	JSR delay		; jump to timer subroutine
two:
	LDY NOTEc
	STY MIDSOUND
	JSR RDTIM
	JSR delay
	LDY QUIET
	STY MIDSOUND
three:
	LDY NOTEf
	STY MIDSOUND
	JSR RDTIM
	JSR delay
	LDY QUIET
	STY MIDSOUND
	JSR RDTIM
	JSR delay
	LDY NOTEf
	STY MIDSOUND
	JSR RDTIM
	JSR delay
	LDY QUIET
	STY MIDSOUND
	JSR RDTIM
	JSR delay
rumble:
	LDY NOTEg
	STY NOISE
	JSR RDTIM
	JSR delay
	LDY QUIET
	STY NOISE
	JSR RDTIM
	JSR delay
	JMP one

end:
	RTS

delay:
	JSR RDTIM	; read time
	ADC #20		; Add 10 to the MSB (some number of 'jiffies')
	STA next_inc	; put in memory
_wait_loop:
	JSR RDTIM	; read system time
	CMP next_inc	; check time against stored value
	BNE _wait_loop	; if time != next_increment, loop
	RTS


; ************************ DATA ****************************
next_inc: byte 0
	 

