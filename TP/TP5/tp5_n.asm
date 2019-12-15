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

	mov esi, [ebp+8]					;esi <- get the pointer to the first element of the array x
	mov edi, [ebp+12]					;edi <- and of y
	mov eax, [ebp+16]					;eax <- gets the size of the arrays 

	fldz								;sum = st0 = 0;
	xor ecx, ecx						;i <- 0
.for:
	cmp ecx, eax
	jge .endfor							;while(ecx < eax)

										;sum += x[i] * y[i];
	fld dword [esi+ecx*4]				;st0 <- x[i] //push onto "floating point stack"
	fmul dword [edi+ecx*4]				;st0 *= y[i] //multiplies the top of stack by the arg 
	faddp st1, st0						;st1 <- st0  //BUT ALSO pops off st0, moving st1 to the top of the stack. This is good, because the top of the floating point stack is where the return value should be

	inc ecx								;i++
	jmp .for							;when we start this loop again, we'll put push x[i] on to the stack, putting our sum back in st1 so that line (this-3) works
.endfor:
	pop edi								;normal get the hell outta here shit
	pop esi
	mov esp,ebp
	pop ebp
	ret

; xmm0 = sum [0:3]
; zmm1 = x[i:i+3]
; xmm2 = y

ps_sse:									;now for some fun
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov esi, [ebp+8]
	mov edi, [ebp+12]
	mov eax, [ebp+16]					;ok now the fun really starts, that was all the same as before

	pxor xmm0, xmm0						;so now our result is in xmm0 (SSE regs), instead of st0 (FPU stack regs) ...but it seems we but it in there at the end anyway
	xor ecx, ecx						; g u e s s
.for:
	cmp ecx, eax
	jge .endfor							; f u c k  y o u  t h a t ' s  w h y

	;sum[0:3] +=...
	movaps xmm1, [esi+ecx*4]			;here we move into xmm1 the 4 values x[i], to x[i+3]
	movaps xmm2, [edi+ecx*4]			; s a m e : xmm2[0] <- y[i], xmm2[1] <- y[i+1], xmm2[2] <- my fucking will to live, etc.
	mulps xmm1, xmm2					;xmm1[i]*=xmm2[i], so 4 multiplications at once
	addps xmm0, xmm1					;now imagine multiplying but instead it's adding
	add ecx, 4							;i+=4 because we just took care of 4 vals
	jmp .for
.endfor:
	haddps xmm0,xmm0					;this command is fun and should be seen as a picture, I could try to explain it in one line like this.. well.. I'll try.. So HorizontalADDParralelShit DEST, SOURCE, makes DEST[0]=SOURCE[0]+SOURCE[1], DEST[1]=SOURCE[2]+SOURCE[3], THEN DEST[2]=DEST[0]+De.. okok it add the 0 and 1 of both DST and SRC, and put them in ... just look at a picture it's actually simple 
	haddps xmm0,xmm0					;now sum is in xmm0[0]
	sub esp, 4
	movss [esp], xmm0
	fld dword [esp]						;now it's in st0
	add esp, 4


	pop edi								;yeet
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
	jge .endfor

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
;	jge .endfor
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