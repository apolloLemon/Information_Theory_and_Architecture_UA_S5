;v 	xmm3 esi
;w 	xmm1 edi
;k	xmm2
;n 	-edx- -> [ebp+20] ;edx serra modifie' par la multiplication
;i 	ecx

f:
	enter
	push esi
	push edi
	mov	 esi, [ebp+8]
	mov	 edi, [ebp+12]
	mov edx, [ebp+20]
	and edx, ~3

	movd xmm2, [ebp+16]	;xmm2={?,?,?,k}
	pshufd xmm2,xmm2,0	;xmm2={k,k,k,k}	

	xor ecx, ecx

.for:
	cmp ecx, edx
	jpe .endfor

	movdqu xmm1, [edi+ecx*4]
	movdqu xmm3, [esi+ecx*4]

	pmulld xmm1, xmm2
	paddd xmm3, xmm1

	movdqu [esi+ecx*4], xmm3

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