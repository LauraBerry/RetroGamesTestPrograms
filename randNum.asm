;Input 
;R0 = start number. R1== secondary number R2 == third number
;note: this is psuedo random and is taken from here (https://en.wikipedia.org/wiki/Wichmann-Hill)

randNum:
	JMP main
	MOV R6, R3
	MOV 0,  R4
	loopStart:
		SUB R3, 171, R3
		CMP R3, R6
		BLT nextStep
		INC R4
nextStep:
	ADD R4, R4
	MOV 0, R5
	loop2start:
		ADD R3, R3
		INC R5
		CMP R5, 171
		BNE	loop2start
	SUB R3, R3, R4
main:
	MOV R0, R6
	JMP randNum
	MOV R3, R7
	MOV R1, R6
	JMP randNum
	ADD R7, R3, R7
	MOV R2, R6
	JMP randNum
	ADD R7, R3, R7

	
	
		
	

		
	
		
	
	
	