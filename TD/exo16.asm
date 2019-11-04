	;take x,y,z from the stack
	;x [ebp+8]
	;y [ebp+12]
	;z [ebp+16]



f:
	push ebp
	mov ebp, esp
	
	push ebx
	mov ebx, [ebp+16]
	cmp ebx, 0
	jne .else
.then:
	mov eax, [ebp+8]
	add eax, [ebp+12]
	mov ebx, [ebp+8]
	sub ebx, [ebp+12]
	mul ebx
	mov ebx, eax

	mov eax, [ebp+8]
	xor edx, edx
	div dword [ebp+12]
	mov ecx, 3
	mul ecx

	add eax, ebx
	xor edx, edx
	xchg eax, ebx
	div ebx
	jmp .end

.else:
	mov ecx, [ebp+8]
	add ecx, [ebp+12]

	mov eax, ecx
	sub ecx, [ebp+16]
	add eax, [ebp+16]
	mul ecx

	mov ecx, eax
	mov eax, ebx
	mul ebx
	mov ebx, 1
	sub ebx, eax
	mov eax, ebx
	mul ecx

.end:
	pop ebx
	mov esp, ebp
	pop ebp
	ret