
foo:
		PUSH	%14
		MOV 	%15,%14
@foo_body:
		MULS	8(%14),$2,%0
		MOV 	%0,%13
		JMP 	@foo_exit
@foo_exit:
		MOV 	%14,%15
		POP 	%14
		RET
foofoo:
		PUSH	%14
		MOV 	%15,%14
@foofoo_body:
		ADDU	8(%14),$5,%0
		MOV 	%0,%13
		JMP 	@foofoo_exit
@foofoo_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$28,%15
@main_body:
		MULS	-8(%14),-12(%14),%0
		MOV 	%0,-4(%14)
		DIVS	-4(%14),-12(%14),%0
			PUSH	-4(%14)
			CALL	foo
			ADDS	%15,$4,%15
		MOV 	%13,%1
		ADDS	%0,%1,%0
		MOV 	%0,-8(%14)
		SUBS	-4(%14),-8(%14),%0
		MULS	-4(%14),%0,%0
		MOV 	%0,-12(%14)
		ADDS	-8(%14),-12(%14),%0
		DIVS	-4(%14),%0,%0
			PUSH	-8(%14)
			CALL	foo
			ADDS	%15,$4,%15
		MOV 	%13,%1
		SUBS	%0,%1,%0
		MOV 	%0,-16(%14)
		MULU	-24(%14),-28(%14),%0
		SUBU	%0,-24(%14),%0
		MOV 	%0,-20(%14)
		ADDU	-28(%14),-20(%14),%0
			PUSH	-28(%14)
			CALL	foofoo
			ADDS	%15,$4,%15
		MOV 	%13,%1
		DIVU	%0,%1,%0
		MOV 	%0,-24(%14)
		SUBU	-20(%14),-24(%14),%0
		MULU	-20(%14),%0,%0
			PUSH	-28(%14)
			CALL	foofoo
			ADDS	%15,$4,%15
		MOV 	%13,%1
		DIVU	%0,%1,%0
		MOV 	%0,-28(%14)
		MOV 	$2,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET