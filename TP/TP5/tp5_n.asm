global ps_x87
global ps_sse
global ps_sse_u2

;float ps_x87(float *x, float *y, size_t sz) {
;    // result is sum of products
;    float sum = 0.0;
;    
;    for (size_t i = 0; i < sz; ++i) {
;        sum += x[i] * y[i];
;    }
;    
;    return sum;
;}

; x = esi
; y = edi
; sz = eax
; i = ecx
; sum = st0

ps_x87:
	push ebp
	mov ebp, esp

	push esi
	push edi

	mov esi, [ebp+8]
	mov edi, [ebp+12]
	mov eax, [ebp+16]

	fldz; sum = st0 = 0;
	xor ecx, ecx
.for:
	cmp ecx, eax
	jpe .endfor

	;sum += x[i] * y[i];
	fld dword [esi+ecx*4]
	fmul dword [edi+ecx*4]
	faddp st1, st0

	inc ecx
	jmp .for
.endfor:
	pop edi
	pop esi
	mov esp,ebp
	pop ebp
	ret

; xmm0 = sum [0:3]
; zmm1 = x[i:i+3]
; xmm2 = y

ps_sse:
	push ebp
	mov ebp, esp

	push esi
	push edi

	mov esi, [ebp+8]
	mov edi, [ebp+12]
	mov eax, [ebp+16]

	pxor xmm0, xmm0
	xor ecx, ecx
.for:
	cmp ecx, eax
	jpe .endfor

	;sum[0:3] +=...
	movaps xmm1, [esi+ecx*4]
	movaps xmm2, [edi+ecx*4]
	mulps xmm1, xmm2
	addps xmm0, xmm1
	add ecx, 4
	jmp .for
.endfor:
	haddps xmm0,xmm0
	haddps xmm0,xmm0
	sub esp, 4
	movss [esp], xmm0
	fld dword [esp]
	add esp, 4


	pop edi
	pop esi
	mov esp,ebp
	pop ebp
	ret

ps_sse_u2:
	push ebp
	mov ebp, esp

	push esi
	push edi

	mov esi, [ebp+8]
	mov edi, [ebp+12]
	mov eax, [ebp+16]

	pxor xmm0, xmm0
	pxor xmm3, xmm3
	xor ecx, ecx
.for:
	cmp ecx, eax
	jpe .endfor

	;sum[0:3] +=...
	;sum2[4:7] +=
	movaps xmm1, [esi+ecx*4]
	movaps xmm2, [edi+ecx*4]
	mulps xmm1, xmm2
	addps xmm0, xmm1
	add ecx, 4

	movaps xmm4, [esi+ecx*4]
	movaps xmm5, [edi+ecx*4]
	mulps xmm4, xmm5
	addps xmm3, xmm4
	add ecx, 4
	jmp .for
.endfor:
	haddps xmm0,xmm3
	haddps xmm0,xmm0
	haddps xmm0,xmm0
	sub esp, 4
	movss [esp], xmm0
	fld dword [esp]
	add esp, 4


	pop edi
	pop esi
	mov esp,ebp
	pop ebp
	ret



;ps_avx:
;	push ebp
;	mov ebp, esp
;
;	push esi
;	push edi
;
;	mov esi, [ebp+8]
;	mov edi, [ebp+12]
;	mov eax, [ebp+16]
;
;	vpxor ymm0, ymm0
;	xor ecx, ecx
;
;.for:
;	cmp ecx, eax
;	jpe .endfor
;
;	;sum[0:3] +=...
;	vmovaps ymm1, [esi+ecx*4]
;	vmovaps ymm2, [edi+ecx*4]
;	vmulps ymm1, ymm2
;	vaddps ymm0, ymm1
;	add ecx, 8
;	jmp .for
;
;.endfor:
;	haddps xmm0,xmm0
;	haddps xmm0,xmm0
;
;	vextract128 xmm1, ymm0, 1
;	haddps xmm1,xmm1
;	haddps xmm1,xmm1	
;
;	addps xmm0,xmm1
;
;	sub esp, 4
;	movss [esp], xmm0
;	fld dword [esp]
;	add esp, 4
;
;
;	pop edi
;	pop esi
;	mov esp,ebp
;	pop ebp
;	ret