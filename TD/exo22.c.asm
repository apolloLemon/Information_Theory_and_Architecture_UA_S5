mini:
	push ebp,
	mov ebp, esp

	mov eax, [ebp+8]
	mov ebx, [ebp+12]

	cmp eax, ebx
	cmovg eax, ebx ;conditional move

.end:
	mov esp, ebp
	pop ebp