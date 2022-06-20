
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@main_body:
		MOV 	$2,-4(%14)
		JMP 	@main_body_0
@lambda_x_3:
		PUSH	%14
		MOV 	%15,%14
		JMP 	@lambda_x_3_body
@lambda_x_3_body:
		MULS	8(%14),12(%14),%0
		MULS	%0,16(%14),%0
		MOV 	%0,%13
		JMP 	@lambda_x_3_exit
@lambda_x_3_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_0:
		JMP 	@main_body_1
@lambda_x_2:
		PUSH	%14
		MOV 	%15,%14
		JMP 	@lambda_x_2_body
@lambda_x_2_body:
		ADDS	8(%14),12(%14),%0
		MOV 	%0,%13
		JMP 	@lambda_x_2_exit
@lambda_x_2_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_1:
		PUSH	$3
		PUSH	$2
		PUSH	$1
		CALL	@lambda_x_3
		ADDS	%15,$12,%15
		MOV 	%13,%0
		MOV 	%0,-8(%14)
		PUSH	-4(%14)
		PUSH	$1
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%0
		MOV 	%0,-8(%14)
		MOV 	$2,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET