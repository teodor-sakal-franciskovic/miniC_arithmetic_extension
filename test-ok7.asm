
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
		JMP 	@main_body_1
@lambda_y_1:
		PUSH	%14
		MOV 	%15,%14
		JMP 	@lambda_y_1_body
@lambda_y_1_body:
		MULS	8(%14),$2,%0
		MOV 	%0,%13
		JMP 	@lambda_y_1_exit
@lambda_y_1_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_1:
		MOV 	$5,-4(%14)
		MOV 	$3,-8(%14)
		SUBS	-4(%14),$1,%0
		SUBS	-8(%14),$1,%1
		PUSH	%1
		PUSH	%0
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%2
		MULS	-4(%14),-8(%14),%3
		SUBS	%3,$1,%3
		PUSH	%3
		CALL	@lambda_y_1
		ADDS	%15,$4,%15
		MOV 	%13,%4
		ADDS	%2,%4,%3
		PUSH	$10
		PUSH	$10
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%4
		ADDS	%3,%4,%3
		MOV 	%3,-12(%14)
		PUSH	-12(%14)
		CALL	@lambda_y_1
		ADDS	%15,$4,%15
		MOV 	%13,%3
		PUSH	-12(%14)
		CALL	@lambda_y_1
		ADDS	%15,$4,%15
		MOV 	%13,%4
		ADDS	%3,%4,%3
		PUSH	$2
		CALL	@lambda_y_1
		ADDS	%15,$4,%15
		MOV 	%13,%4
		DIVS	%3,%4,%3
		MOV 	%3,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET