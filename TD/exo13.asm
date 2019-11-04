;1
mov eax, 1
mov ebx, 2
cmp eax, ebx
jge .else
i1
jmp .end
.else:
i2
.end:


;2

mov eax, 0
mov ebx, 0
mov ecx, [in]

.w:
	cmp ebx, ecx
	jg .end
	add eax, ebx
	jmp .w
.end

;3

mov eax, 0		;sum
mov ebx, 0		;i
mov ecx, [in]	;n

.w:
	cmp ebx, 10
	jle .end
	cpm ebx, ecx
	jg .end
	add eax, ebx
	inc ebx
	jmp .w
.end:


;4

msg db "%d",10,0

mov ebx, [in]	;n
mov ecx, 0		;i
mov esi, 1		;prod

.w:
	mov edx, 0		; clear for div
	xor eax, eax	; clear for div

	mov eax, ecx
	div ebx
	cmp edx, 0
	je .body
	cmp ecx, 3
	je .body
	jmp .end
.body:
	mov eax, esi
	mul ecx
	mov esi, eax
		
	inc ecx
	jmp .w

.end:
	push esi
	push msg
	call printf
	add esp, 8