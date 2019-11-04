section .data
	N equ 131072	;2**17
	x dd 0
	y dd 0
	z dd 0
	method dd 1
	max_itr 100

section .text

main:
	push ebp,
	mov ebp, esp
	pushad

	mov eax, [ebp+12]
	push [eax+4]
	call atoi
	add esp, 4
	mov [method]

	mov eax, [ebp+12]
	push [eax+4]
	call atoi
	add esp, 4
	mov [max_itr], eax

	mov eax, N
	shl eax, 2
	push eax
	push dword 16
	push dword x
	call posix_memalign
	add esp, 12

	mov eax, N
	shl eax, 2		;2**15
	push eax
	push dword 16
	push dword y
	call posix_memalign
	add esp, 12