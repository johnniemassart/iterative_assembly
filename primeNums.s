.text
.global main
main:
	#program dictionary
	#

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

#end main

.text
Prime:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp]

	#initialize outer
	MOV r4, #3
	MOV r5, r1
	#ADD r5, r5, #1

	#initialize inner
	MOV r6, #2
	MOV r0, r5
	MOV r1, #2
	BL __aeabi_idiv
	MOV r7, r0
	#ADD r7, r7, #1

	#start outer loop
	startOuterLoop:

		#check the limit
		CMP r4, r5
		BGT endOuterLoop
	
		startInnerLoop:

			#check the limit
			#ADD r7, r7, #1
			CMP r6, r7
			BGT endInnerLoop

			#inner loop block

			#modulus r4 % r6
			AND r8, r4, r6
			CMP r8, #0
			BEQ elsif_1
				#remainder is not equal to 0
				CMP r6, r7
				BEQ elsif_2
					#not equal
					B endInnerLoop
					
				elsif_2:
					#equal
					MOV r1, r4
					LDR r0, =primeMsg
					BL printf
					B endInnerLoop
			
			elsif_1:
				#remainder is equal to 0
				CMP r4, r6
				BEQ elsif_3
					#not equal
					B endInnerLoop
				elsif_3:
					#equal
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
	rem0Msg: .asciz "The remainder is zero, %d\n"
	remNot0Msg: .asciz "The remainder is not zero, it is %d\n"
	primeMsg: .asciz "%d is prime\n"
