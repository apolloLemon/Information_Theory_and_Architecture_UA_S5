global main
extern printf

; ==== DATA SEDUCTION ====
section .data

	MAXI EQU 20 		; const maxi = 20
	tab times MAXI dd 0
	msg db "la somme est %d", 10, 0

; ==== CODE SEXTION ====
section .text

calc_sum:
	push ebp			; entree' du sous-program
	mov ebp,esp

	push ebx			; save ebx car il ne doit pas
						; etre modif

	mov ebx, [ebp+8]	; t
	mov edx, [ebp+12]	; n

	mov eax, 0			; sum
	mov ecx, 0			; i
	
.for:
	cmp ecx, edx
	jge .endfor

	add eax, [ebx+ecx*4] ; sum += *(t+i)

	inc ecx
	jmp .for

.endfor:
	pop ebx
	mov esp,ebp			; sortie du sous-program
	pop ebp				
	ret


main:
	push ebp			; entree' du sous-program
	mov ebp,esp

	pushad				; save les 8 reg genereaux

	xor ecx, ecx
.for_i:
	cmp ecx, MAXI
	jge .endfor_i

	;add eax, ecx
	lea ebx, [ecx*2]
	mov [tab+ecx*4], ebx


	inc ecx 			; add ecx, 1
	jmp .for_i

.endfor_i:

	push MAXI
	push tab
	call calc_sum
	add esp, 8

	push eax
	push dword msg
	call printf
	add esp,8

	popad				; charge les 8 reg
	xor eax,eax			; mov eax, 0
						; return EXIT_SUCCESS

	mov esp,ebp			; sortie du sous-program
	pop ebp				
	ret