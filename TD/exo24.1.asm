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
	xor ecx, ecx

.for:
	cmp ecx, [ebp+20]
	jpe .endfor

	mov eax, [edi+ecx*4]	;w[i]
	mul ebx					;*k
	;add eax, [esi+ecx*4] 		;remplace' par l+2
	;mov [esi+ecx*4], eax 		;remplace' par l+1
	add [esi+ecx*4], eax

	inc ecx
	jmp .for

.endfor:
	pop ebx
	pop edi
	pop esi
	leave
	ret