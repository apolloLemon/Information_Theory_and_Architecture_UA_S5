mini:
	push ebp,
	mov ebp, esp

	mov eax, [ebp+8] 	;p
	mov ecx, [ebp+12]	;q
	mov edx, eax

	sub edx, ecx		;r=(p-q)
	sar edx, 31		

	and eax, edx
	not edx
	and ecx, edx
	or eax, ecx

.end:
	leave
	ret