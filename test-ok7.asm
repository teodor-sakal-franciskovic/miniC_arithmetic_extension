
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
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
		MOV 	$5,-4(%14)
		MOV 	$3,-8(%14)
		PUSH	$3
		PUSH	$5
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%0
		DIVS	%0,$2,%0
		MOV 	%0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET