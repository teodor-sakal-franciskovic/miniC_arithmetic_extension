
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		JMP 	@main_body_0
@lambda_x_2:
		PUSH	%14
		MOV 	%15,%14
		JMP 	@lambda_x_2_body
@lambda_x_2_body:
		MULS	12(%14),8(%14),%0
		ADDS	%0,$1,%0
		MOV 	%0,%13
		JMP 	@lambda_x_2_exit
@lambda_x_2_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_0:
		MOV 	$2,-8(%14)
		MOV 	$3,-12(%14)
		PUSH	-8(%14)
		PUSH	$3
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET