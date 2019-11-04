; 	rdi a
;	rsi	b
;	rdx c
; 	rcx N

;	r8	i
;	r9	j
;	r10	k
;	r11 sum


section .text

prod:

	mov [rsp-8], rdx	;edx modifie' par mul
	xor r8, r8
.fori
	cmp r8, rcx
	jge .endi

	xor r9, r9
.forj
	cmp r9, rcx
	jge .endj

	xor r11, r11		;sum=0
	
	mov eax, ecx
	mul r8d
	shl eax, 2
	mov r12, rdi
	add r12, rax
	
	lea r13, [rsi+r9*4]
	
	xor r10, r10
.fork
	cmp r10, rcx
	jge .endk

	mov eax, [r12]
	mul [r13d]
	add r11d, eax

	add r12, 4
	;mov eax, ecx
	;shl eax, 2
	;add r13, rax
	lea r13, [r13+rcx*4]

	inc r10
	jmp .fork

.endk:
	
	mov eax, ecx
	mul r8d
	add eax, r9d

	mov rdx, [rsp-8]	;recharger c

	mov [rdx+eax*4], r11d

	inc r9
	jmp .forj

.endj:

	inc r8
	jmp .fori
.endi: