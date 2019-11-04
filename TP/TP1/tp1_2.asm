global main
extern printf
extern scanf

; ===== DATA SECTION =====
section .data
x dd 1 ; x est un entier sur 32 bits
y dd 2 ; y est un entier sur 32 bits

msg_inf db "%d inferieur a %d", 10, 0
msg_sup_egal db "%d superieur ou egal a %d", 10, 0

msg_x db "saisir x= ", 0
msg_y db "saisir y= ", 0
msg_scanf db "%d", 0

; ===== CODE SECTION =====
section .text

main:
	push ebp			; entree' du sous-program
	mov ebp,esp

	pushad				; save les 8 reg genereaux

	; printf("saisir x")
	push dword msg_x
	call printf
	add esp, 4
	; scanf("%d", &x)
	push dword x
	push dword msg_scanf
	call scanf
	add esp, 8
	; printf("saisir y")
	push dword msg_y
	call printf
	add esp, 4
	; scanf("%d", &y)
	push dword y
	push dword msg_scanf
	call scanf
	add esp, 8

.if:
	mov eax, [x]
	mov ebx, [y]
	cmp eax, ebx		; x <,=,> y ?
	
	push ebx 			; push dword [x]
	push eax
	
	jge .else			; jump on greater or equal
.then:
	; printf
	push dword msg_inf
	call printf
	add esp, 12			;supprime le parametre msg_inf
	jmp .endif
.else:
	; printf
	push dword msg_sup_egal
	call printf
	add esp, 12
.endif:

	popad				; charge les 8 reg

	xor eax,eax			; mov eax, 0
						; return EXIT_SUCCESS

	mov esp,ebp			; sortie du sous-program
	pop ebp				
	ret