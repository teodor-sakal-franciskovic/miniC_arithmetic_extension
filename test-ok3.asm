
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$16,%15
@main_body:
		JMP 	@main_body_0
@lambda_x:
		PUSH	%14
		MOV 	%15,%14
@lambda_x_body:
		MULS	12(%14),8(%14),%0
		MOV 	%0,%13
@lambda_x_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_0:
		PUSH	$2
		PUSH	$3
		CALL	@lambda_x
		ADDS	%15,$8,%15
		MOV 	%13,%0
		MOV 	%0,-4(%14)
		JMP 	@main_body_1
@lambda_y:
		PUSH	%14
		MOV 	%15,%14
@lambda_y_body:
		ADDS	8(%14),12(%14),%0
		MOV 	%0,%13
@lambda_y_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_1:
		MOV 	$5,-12(%14)
		MOV 	$5,-16(%14)
		ADDS	-12(%14),-16(%14),%0
		PUSH	%0
		PUSH	-16(%14)
		CALL	@lambda_y
		ADDS	%15,$8,%15
		MOV 	%13,%0
		MOV 	%0,-8(%14)
		ADDS	-4(%14),-8(%14),%0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET