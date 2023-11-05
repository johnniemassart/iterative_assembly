#Program Name: guessNum.s
#Author: Johnnie Massart
#Date: 11/2/2023
#Purpose: guess number with binary search
.text
.global main
main:
	#program dictionary
	#r4 -> min. loop value
	#r5 -> max. loop value - user input
	#r6 -> user response Y/N
	#r7 -> mid value
	#r9 -> guess counter
	#r10 -> user response high/low
	#r11 -> secret number

	#push the stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	#user prompt
	LDR r0, =prompt
	BL printf

	#scan user input
	LDR r0, =formatInput
	LDR r1, =input
	BL scanf

	#store user input value
	LDR r1, =input
	LDR r1, [r1]

	#call function
	BL guessingNum
	
	#re-store value
	MOV r1, r11
	MOV r2, r9

	#output
	LDR r0, =output
	BL printf

	#pop the stack
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	prompt: .asciz "Enter a max number: "
	formatInput: .asciz "%d"
	input: .word 0
	output: .asciz "The secret number is %d, requiring %d guesses\n" 

#end main

.text
guessingNum:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	#low, max value
	MOV r4, #1
	MOV r5, r1

	#guess count
	MOV r9, #0

	#continue loop until low <= user input max
	startLoop:
		#calc mid value
		MOV r0, r5
		ADD r0, r0, r4
		MOV r1, #2
		BL __aeabi_idiv

		#store mid value
		MOV r7, r0
		MOV r1, r7
		
		#output guess
		LDR r0, =guess
		BL printf

		#scan user Y/N response
		LDR r0, =formatYesNo
		LDR r1, =yesNo
		BL scanf

		#store user response
		LDR r6, =yesNo
		LDR r6, [r6]

		#compare yes, no response
		CMP r6, #1
		BEQ else
			#no response
			LDR r0, =isHighOrLow
			BL printf
		
			#scan user high/low response
			LDR r0, =formatHighOrLow
			LDR r1, =highOrLow
			BL scanf
	
			#store user response
			LDR r10, =highOrLow
			LDR r10, [r10]

			#compare high/low
			CMP r10, #1
			BEQ elsif_1
				#low response, add guess, update low value
				ADD r9, r9, #1
				ADD r4, r7, #1
				B startLoop
			elsif_1:
				#high response, add guess, update high value
				ADD r9, r9, #1
				SUB r5, r7, #1
				B startLoop
		else:
			#yes response
			ADD r9, r9, #1
			MOV r11, r7
			B endLoop

		endIf:	


	endLoop:

	#pop the stack
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	guess: .asciz "Is the secret number %d? Enter 1 (Yes) / 0 (No): "
	formatYesNo: .asciz "%d"
	yesNo: .word 0
	isHighOrLow: .asciz "Is the secret number low or high? Enter 1 (high) / 0 (low): "
	formatHighOrLow: .asciz "%d"
	highOrLow: .word 0
