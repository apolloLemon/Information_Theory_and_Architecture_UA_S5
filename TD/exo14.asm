init:
	push ebp
	mov ebp, esp
	push edi

	mov edi, [ebp+8]	;*t
	mov edx, [ebp+12]	;n

	mov ecx, 0			;i

.for_i
	cmp ecx, edx
	jge .endfor_i

	mov byte [edi+ecx], 48

	inc ecx
	jmp .for_i

.endfor_i:
	pop edi
	mov esp, ebp
	pop ebp
	ret