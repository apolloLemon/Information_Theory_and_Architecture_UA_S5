; x		edx 
; out	eax
; 1 	ecx ;pas utilse avec test
popcount:
	push ebp
	mov ebp,esp

	mov edx, [ebp+8]

.while:
	;mov ecx, 1
	cmp edx, 0
	jz .endwhile
	
.if:
	test edx, 1
	;and ecx, edx
	;cmp ecx, 0
	jz .endif
	;je .endwhile
	
	inc eax
.endif:
	shl edx
	jmp .while

.endwhile
	leave
	ret


popcount_noif:
	push ebp
	mov ebp,esp

	mov edx, [ebp+8]

.while:
	cmp edx, 0
	jz .endwhile

	mov ecx,edx
	and ecx,1
	add eax,ecx
	
	shl edx
	jmp .while

.endwhile
	leave
	ret