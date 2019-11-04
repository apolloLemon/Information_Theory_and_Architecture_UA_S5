init:
	push ebp
	mov ebp, esp
	push edi

	mov edi, [ebp+8]	;*t
	mov ecx, [ebp+12]	;n

.w:
	cmp ecx, 0
	je .end
	mov byte [edi], 48
	add edi, 1
	dec ecx
	jmp .w

.end:
	pop edi
	mov esp, ebp
	pop ebp
	ret




;;
.w2:
	mov byte [edi], 48
	add edi, 1
	dec ecx
	jnz .w2

;;
.w3
	mov byte [edi], 48
	add edi, 1
	loop .w3