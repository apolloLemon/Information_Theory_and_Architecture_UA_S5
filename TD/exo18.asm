fib:
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]
	cmp eax, 1
	jle .end

.else:
	sub eax, 1
	push eax
	call fib
	mov ecx, eax
	pop eax
	sub eax, 1
	push eax
	call fib
	add eax, ecx


.end:
	mov esp, ebp
	pop ebp


.else_prof:
	sub eax, 1
	push eax
	call fib
	add esp, 4
	mov ecx, [ebp+8]
	sub ecx, 2
	push ecx
	call fib
	add esp, 4
	pop ecx
	add eax, ecx