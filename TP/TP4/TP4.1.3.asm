
puissance:
	push ebp
	mov ebp, esp

	fld 1
	mov ecx, [ebp+12]
.while:
	cmp ecx, 0
	jle .endwhile

	fmulp dword [ebp+8]

	dec ecx
	jmp .while

.endwhile:
	mov esp, ebp
	pop ebp

	ret




calcul:
	push ebp
	mov ebp, esp



	xor ecx, ecx
.for
	cmp ecx, [n]
	jge .end

	push n
	push x
	call puissance
	add esp, 12

	add [sum], puis(x,n)

	inc ecx
	jmp .for

.end:

	leave
	ret