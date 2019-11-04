; 	[ebp+8] 	a
;	[ebp+12]	b
;	[ebp+16]	c
; 	[ebp+20]	N

;	[ebp-4]		i
;	[ebp-8]		j
;	ecx			k
;	ebx			sum
;	esi			addr_a
;	edi 		addr_b

section .text

prod:
	push ebp
	mov ebp, esp

	sub esp, 8		;faire de la place pour i j

	push ebx
	push esi
	push edi

	mov dword [ebp-4], 0
	;xor eax, eax
	;mov [ebp-4], eax
.fori:
	mov eax, [ebp-4]
	cmp eax, [ebp+20]
	jge .endi

.forj:
	mov edx, [ebp-8]
	cmp edx, [ebp+20]
	jge .endj

	xor ebx, ebx
	
	push edx
	mul dword [ebp+20]
	pop edx
	
	shl eax, 2
	mov esi, [ebp+8]
	add esi, eax

	mov eax, edx
	shl eax, 2
	mov edi, [ebp+12]
	add edi, eax

	xor ecx, ecx
.fork:
	cmp ecx, [ebp+20]
	jge .endk

	mov eax, [esi]
	push edx
	mul dword [edi]
	pop edx
	add ebx,eax

	inc ecx
	jmp .fork
.endk:

	;c[i][j]=sum

	inc dword [ebp-8]
	jmp .forj
.endj:

	inc dword [ebp-4]
	jmp .fori
.endi: