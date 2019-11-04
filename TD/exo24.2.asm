;v 	esi
;w 	edi
;k	ebi		
;n 	-edx- -> [ebp+20] ;edx serra modifie' par la multiplication
;i 	ecx

f:
	enter
	push esi
	push edi
	push ebx
	mov	 esi, [ebp+8]
	mov	 edi, [ebp+12]
	mov	 ebx, [ebp+16]

	mov edx, [ebp+20]
	and edx, ~3

	xor ecx, ecx

.for:
	cmp ecx, edx
	jpe .endfor

	push edx

	mov eax, [edi+ecx*4]	;w[i]
	mul ebx					;*k
	add [esi+ecx*4], eax
	
	mov eax, [edi+ecx*4+4]	;w[i+1]
	mul ebx					;*k
	add [esi+ecx*4+4], eax
	
	mov eax, [edi+ecx*4+8]	;w[i+2]
	mul ebx					;*k
	add [esi+ecx*4+8], eax
	
	mov eax, [edi+ecx*4+12]	;w[i+3]
	mul ebx					;*k
	add [esi+ecx*4+12], eax

	pop edx
	add ecx, 4

	jmp .for

.endfor:
	mov edx, [ebp+20]
	
.while:
	cmp ecx, edx

	jpe .endwhile

	mov eax, [edi+ecx*4]	;w[i]
	mul ebx					;*k
	;add eax, [esi+ecx*4] 		;remplace' par l+2
	;mov [esi+ecx*4], eax 		;remplace' par l+1
	add [esi+ecx*4], eax

	inc ecx
	jmp .while


.endwhile:
	pop ebx
	pop edi
	pop esi
	leave
	ret