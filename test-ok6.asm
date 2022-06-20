
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
		ADDS	8(%14),12(%14),%0
		MOV 	%0,%13
		JMP 	@lambda_x_2_exit
@lambda_x_2_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_0:
		MOV 	$3,-4(%14)
		JMP 	@main_body_1
@lambda_x_1:
		PUSH	%14
		MOV 	%15,%14
		JMP 	@lambda_x_1_body
@lambda_x_1_body:
		ADDS	8(%14),$1,%0
		MOV 	%0,%13
		JMP 	@lambda_x_1_exit
@lambda_x_1_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_1:
		MOV 	$5,-4(%14)
		MOV 	$3,-8(%14)
		PUSH	-4(%14)
		CALL	@lambda_x_1
		ADDS	%15,$4,%15
		MOV 	%13,%0
		MOV 	%0,-12(%14)
		PUSH	$2
		PUSH	-8(%14)
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%0
		ADDS	-12(%14),%0,%0
		MOV 	%0,-8(%14)
		MOV 	-8(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET