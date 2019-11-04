global main
extern scanf
extern printf

section .data
	a 	dd 0
	b	dd 0
	c 	dd 0
	delta dd 0
	x1 dd 0
	x2 dd 0

	quatre dd 4.0
	deux dd 2.0

	msgin "%f%f%f"
	msgo1 "x1=%f"
	msgo2 "x2=%f"



section .text

main:
	push ebp
	mov ebp, esp
	
	push c
	push b
	push a
	push dword msgin
	call scanf
	add esp, 16


	fld dword [b]
	fld dword [b]
	fmulp st1, st0
	fld dword [quatre]
	fld dword [a]
	fmulp st1, st0
	fld dowrd [c]
	fsub st1, st0
	fstp dword [delta]

	;fcomip [delta], 0.0
	;jle .end
	;je .x1

	fld dword [b]
	fchs
	fld dword [delta]
	fsqrt
	fsubp st1,st0
	fld dword [deux]
	fld dword [a]
	fmulp st1, st0
	fdivp st1, st0
	fstp dword [x2]

;.x1:
	fld dword [b]
	fchs
	fld dword [delta]
	fsqrt
	faddp st1,st0
	fld dword [deux]
	fld dword [a]
	fmulp st1, st0
	fdivp st1, st0
	fstp dword [x1]


;.end:
	sub esp, 8
	fst qword [esp]
	push dword msg
	call printf
	add esp, 12

	leave
	ret