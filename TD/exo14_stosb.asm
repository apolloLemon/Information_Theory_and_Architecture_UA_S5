init:
	push ebp
	mov ebp, esp
	push edi

	mov edi, [ebp+8]	;*t

	mov al, 48
	rep stosb			;mov [edi], a;
						;inc edi

	pop edi
	mov esp, ebp
	pop ebp
	ret