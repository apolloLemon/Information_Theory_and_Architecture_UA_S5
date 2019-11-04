mini:
	push ebp,
	mov ebp, esp

	mov eax, [ebp+8]
	mov ebx, [ebp+12]

	cmp eax, ebx
	jl .end
	mov eax, ebx

.end:
	mov esp, ebp
	pop ebp