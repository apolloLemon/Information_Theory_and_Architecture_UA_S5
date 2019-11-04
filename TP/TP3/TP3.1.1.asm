global main


section .data

section .text

	push ebp
	mov ebp, esp

	push esi
	push edi
	push ebx
	mov esi, [ebp+8]
	mov edi, [ebp+12]
	mov ebx, [ebp+16]
	mov edx, [ebp+20]

	xor ecx,ecx

.for:
	cmp ecx, edx

	mov eax, [esi+ecx*4]
	add eax, [edi+ecx*4]
	mov [ebx+ecx*4], eax
	inc ecx
	jmp .for

.endfor:
	pop ebx
	pop edi
	pop esi

	leave
	ret