//Input 
//R0 = start number.
//note: this is psuedo random and is taken from here (https://en.wikipedia.org/wiki/Wichmann-Hill)

.section    .init
.global     _start

_start:
    b       randNum
    
.section .text

randNum:
	JMP main
	MOV R3, R6
	MOV R4, #0
	loopStart:
		SUB R3, 171, R3
		CMP R3, R6
		BLT nextStep
		INC R4
nextStep:
	ADD R4, R4
	MOV R5, #0
	loop2start:
		ADD R3, R3
		INC R5
		CMP R5, #171
		BNE	loop2start
	SUB R3, R3, R4
main:
	MOV R6, R0
	JMP randNum
	MOV R7, R3
	MOV R6, R1
	JMP randNum
	ADD R7, R3, R7
	MOV R6, R2
	JUMP randNum
	ADD R7, R3, R7

	
	
		
	

		
	
		
	
	
	