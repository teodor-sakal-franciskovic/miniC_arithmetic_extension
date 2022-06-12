
foo:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@foo_body:
		MULS	$3,$2,%0
		ADDS	8(%14),%0,%0
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
		MULS	$5,$3,%0
		DIVS	$8,$2,%1
		SUBS	%0,%1,%0
		SUBS	%0,$1,%0
		MOV 	%0,-4(%14)
		PUSH	-4(%14)
			CALL	foo
			ADDS	%15,$4,%15
		MOV 	%13,%0
		MULS	%0,$2,%0
		ADDS	-4(%14),%0,%0
		MOV 	%0,-8(%14)
		SUBS	-8(%14),$2,%0
		ADDS	$3,$5,%1
		DIVS	%0,%1,%0
		MOV 	%0,-12(%14)
		MOV 	-12(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET