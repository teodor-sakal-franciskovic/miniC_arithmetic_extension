
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
		SUBS	%15,$8,%15
@main_body:
		JMP 	@main_body_0
@lambda_x_2_body:
		ADDS	$3,8(%14),%0
		ADDS	%0,12(%14),%0
		SUBS	8(%14),$2,%1
		MULS	%0,%1,%0
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
		MOV 	$3,-4(%14)
		PUSH	-4(%14)
			CALL	foo
			ADDS	%15,$4,%15
		MOV 	%13,%0
		PUSH	$5
		PUSH	%0
		CALL	@lambda_x_2
		ADDS	%15,$8,%15
		MOV 	%13,%1
		MOV 	%1,-8(%14)
		MOV 	-8(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET