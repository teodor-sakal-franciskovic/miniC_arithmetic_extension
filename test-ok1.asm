
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@main_body:
		SUBS	%15,$12,%15
@lambda_main_body:
		MULS	a,b,%0
		MULS	%0,c,%0
@lambda_x_exit:
		MOV 	%14,%15
		POP 	%14
		RET
			PUSH	$1
			PUSH	$1
			PUSH	$1
			CALL	lambda_x
			ADDS	%15,$12,%15
		MOV 	%13,%1
		MOV 	%1,-4(%14)
			PUSH	a
			PUSH	a
			PUSH	a
			CALL	lambda_x
			ADDS	%15,$12,%15
		MOV 	%13,%1
		MOV 	%1,-8(%14)
			PUSH	$1
			PUSH	$2
			PUSH	b
			CALL	lambda_x
			ADDS	%15,$12,%15
		MOV 	%13,%1
		MOV 	%1,-4(%14)
		MOV 	$2,%13
		JMP 	@x_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET