
foo:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@foo_body:
		ADDS	8(%14),$2,%0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@foo_exit
@foo_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$16,%15
@main_body:
		JMP 	@main_body_0
@lambda_x_2_body:
		ADDS	8(%14),12(%14),%0
		MOV 	%0,%13
		JMP 	@lambda_x_2_exit
@lambda_x_2:
		PUSH	%14
		MOV 	%15,%14
		JMP 	@lambda_x_2_body
@lambda_x_2_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_0:
		MOV 	$5,-4(%14)
		MOV 	$3,-8(%14)
		ADDS	-4(%14),-8(%14),%0
		MULS	-4(%14),-8(%14),%1
		PUSH	%1
		PUSH	%0
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%2
		SUBS	-4(%14),-8(%14),%3
		ADDS	%3,$1,%3
		SUBS	-4(%14),-8(%14),%4
		SUBS	%4,$1,%4
		PUSH	%4
		PUSH	%3
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%5
		ADDS	%2,%5,%4
		MOV 	%4,-12(%14)
		SUBS	-4(%14),-8(%14),%4
		SUBS	-4(%14),-8(%14),%5
		PUSH	%5
		PUSH	%4
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%6
		MOV 	%6,-16(%14)
		ADDS	-12(%14),-16(%14),%6
		MOV 	%6,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET