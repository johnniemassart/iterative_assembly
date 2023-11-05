#Program Name: primeNums.s
#Author: Johnnie Massart
#Date: 11/5/2023
#Purpose: output prime numbers within max loop value
.text
.global main
main:
	#program dictionary
	#r4 -> outer loop counter
	#r5 -> max loop value, user input
	#r6 -> inner loop counter
	#r7 -> inner loop max value
	#r10 -> remainder (%) value

	#push the stack
	SUB sp, sp, #4
	STR lr, [sp]

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
	BL Prime

	#pop the stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	prompt: .asciz "Enter max loop value: "
	formatInput: .asciz "%d"
	input: .word 0
	output: .asciz "The divided value is %d and the remainder is %d\n"

#end main

.text
Prime:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp]

	#initialize outer
	MOV r4, #3
	MOV r5, r1

	#initialize inner
	MOV r6, #2
	MOV r0, r5
	MOV r1, #2
	BL __aeabi_idiv
	MOV r7, r0

	#start outer loop
	startOuterLoop:

		#check the limit
		CMP r4, r5
		BGT endOuterLoop
	
		startInnerLoop:

			#check the limit
			CMP r6, r7
			BGT endInnerLoop

			#inner loop block

			#modulus r4 % r6
			MOV r0, r4
			MOV r1, r6
			BL __aeabi_idiv
			#remainder % value
			MUL r9, r0, r6
			SUB r10, r4, r9

			
			CMP r10, #0
			BEQ elsif_1
				#remainder is not equal to zero
				CMP r6, r7
				BEQ elsif_3
					#not equal to one another
					B endIf

				elsif_3:
					#equal to one another
					MOV r1, r4
					LDR r0, =primeMsg
					BL printf
					B endInnerLoop
				
			elsif_1:
				#remainder is equal to zero
				#compare r4 (i), r6 (j)
				CMP r4, r6
				BEQ elsif_2
					#r4, r6 not equal to one another
					B endInnerLoop
				elsif_2:
					#r4, r6 equal to one another
					B endIf

			endIf:

			#get next value
			ADD r6, r6, #1
			B startInnerLoop

		endInnerLoop:

		#reset inner loop value
		MOV r6, #2
	
		#get next value
		ADD r4, r4, #1
		B startOuterLoop

	endOuterLoop:

	#pop the stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	primeMsg: .asciz "%d is prime\n"
