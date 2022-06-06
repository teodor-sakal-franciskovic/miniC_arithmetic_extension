
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$24,%15
@main_body:
		ADDS	c,b,%0
		ADDS	%0,g,%0
			PUSH	$1
			PUSH	$1
			PUSH	$1
			CALL	x
			ADDS	%15,$4,%15
			ADDS	%15,$4,%15
			ADDS	%15,$4,%15
		MOV 	%13,%1
		MOV 	%1,-20(%14)
			PUSH	b
			PUSH	$3
			PUSH	c
			CALL	x
			ADDS	%15,$4,%15
			ADDS	%15,$4,%15
			ADDS	%15,$4,%15
		MOV 	%13,%1
		MOV 	%1,-4(%14)
		MULS	a,$2,%1
		ADDS	%1,d,%1
			PUSH	c
			PUSH	-20(%14)
			CALL	y
			ADDS	%15,$4,%15
			ADDS	%15,$4,%15
		MOV 	%13,%2
		MOV 	%2,-20(%14)
			PUSH	-24(%14)
			PUSH	a
			CALL	y
			ADDS	%15,$4,%15
			ADDS	%15,$4,%15
		MOV 	%13,%2
		MOV 	%2,-20(%14)
		MOV 	$2,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET