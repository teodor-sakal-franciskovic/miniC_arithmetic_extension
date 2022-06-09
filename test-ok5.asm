
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
		SUBS	%15,$12,%15
@main_body:
		JMP 	@main_body_0
@lambda_x:
		PUSH	%14
		MOV 	%15,%14
@lambda_x_body:
		MULS	8(%14),12(%14),%0
		ADDS	%0,12(%14),%0
		ADDS	%0,16(%14),%0
		MOV 	%0,%13
@lambda_x_exit:
		MOV 	%14,%15
		POP 	%14
		RET
@main_body_0:
		MOV 	$10,-4(%14)
		MOV 	$1,-8(%14)
		PUSH	-4(%14)
		PUSH	-8(%14)
		PUSH	$3
		CALL	@lambda_x
		ADDS	%15,$12,%15
		MOV 	%13,%0
		MOV 	%0,-12(%14)
		MOV 	-12(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET