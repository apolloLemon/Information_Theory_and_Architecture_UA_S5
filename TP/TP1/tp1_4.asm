global main
extern printf

; ==== DATA SEDUCTION ====
section .data
msg db "la somme est %d", 10, 0

; ==== CODE SEXTION ====
section .text

main:
	push ebp			; entree' du sous-program
	mov ebp,esp

	pushad				; save les 8 reg genereaux

	mov eax, 0			; sum
	mov ebx, 15			; n
	mov ecx, 0			; i

.for:
	cmp ecx, ebx
	jge .endfor

	add eax, ecx
	inc ecx 			; add ecx, 1
	jmp .for

.endfor:

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