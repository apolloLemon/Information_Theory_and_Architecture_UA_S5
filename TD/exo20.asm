extern printf

section .data
	msg dw "argv[%d]=[%s]"


section .text
main:
	push ebp
	mov ebp, esp
	;mov edx, [ebp+8]
	;mov eax, [ebp+12]

	mov ecx, 0;
.loop:
	cmp ecx, [ebp+8] ;cmp ecx, edx 
	jpe .end

	push ecx
	;push edx
	;push eax
	
	push [ebp+12+ecx*4] ;[eax+ecx*4]
	push ecx
	push dword msg
	call printf
	
	add esp, 12
	;pop eax
	;pop edx
	pop ecx

	inc ecx
	jmp .loop

.end:
	mov esp, ebp
	pop ebp