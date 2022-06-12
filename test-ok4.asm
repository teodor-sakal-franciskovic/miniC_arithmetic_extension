
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		MOV 	$5,-4(%14)
		MOV 	$1,-12(%14)
		SUBS	$5,-12(%14),%0
		MULS	$2,%0,%0
		ADDS	-4(%14),%0,%0
		ADDS	%0,$1,%0
		DIVS	%0,$7,%0
		ADDS	%0,$3,%0
		MOV 	%0,-8(%14)
		MOV 	-8(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET