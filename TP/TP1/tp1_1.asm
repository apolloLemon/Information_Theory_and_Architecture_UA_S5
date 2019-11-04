global main
extern printf

; ===== DATA SECTION =====
section .data
x dd 1 ; x est un entier sur 32 bits
y dd 2 ; y est un entier sur 32 bits
msg_inf db "x inferieur a y", 10, 0
msg_sup_egal db "x superieur ou egal a y", 10, 0

; ===== CODE SECTION =====
section .text

main:
	push ebp			; entree' du sous-program
	mov ebp,esp

	pushad				; save les 8 reg genereaux

.if:
	mov eax, [x]
	mov ebx, [y]
	cmp eax, ebx		; x <,=,> y ?
	jge .else			; jump on greater or equal
.then:
	; printf
	push dword msg_inf
	call printf
	add esp, 4			;supprime le parametre msg_inf
	jmp .endif
.else:
	; printf
	push dword msg_sup_egal
	call printf
	add esp, 4
.endif:

	popad				; charge les 8 reg

	xor eax,eax			; mov eax, 0
						; return EXIT_SUCCESS

	mov esp,ebp			; sortie du sous-program
	pop ebp				
	ret
