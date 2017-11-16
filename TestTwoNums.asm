;		This program prompts the user to enter two
;		Numbers and then checks if the first number
;		is grater than, less than or equal.
;
;		By Josh Crotty
;
;
;
section .data
		GreaterThan: db "Num1 > Num2",10
		GreaterLen: equ $-GreaterThan

		LessThan: db "Num1 < Num2",10
		LessLen: equ $-LessThan

		Equal: db "Num1 == Num2",10
		EqualLen: equ $-Equal

section .bss
		Num1: resb 2 						; 2 byte buffer for num 0-9 and EOL
		Num2: resb 2						; 2 byte buffer for num 0-9 and EOL
		NumLen: equ $-Num2 					; Used for both nums cause there (same size)

section .text
		global _start

_start:

read1:
		mov eax,3							; sys_call read
		mov ebx,0							; file descriptor
		mov ecx,Num1 						; read into
		mov edx,NumLen 						; read length
		int 80h 							; sys_interrupt

		cmp eax,-1 							; error handler
		je exitError

read2:
		mov eax,3							; sys_call read
		mov ebx,0							; file descriptor
		mov ecx,Num2 						; read into
		mov edx,NumLen 						; read length
		int 80h 	 						; sys_interrupt

		cmp eax,-1 							; error handler
		je exitError

check:
		mov ah,byte [Num1]
		mov al,byte [Num2]
		cmp ah,al
		jg writeG 							; jump if greater
		jl writeL 							; jump if less
		je writeE 							; jump if equal
		jmp exitError 						; something went wrong jump exitError

writeG:
		mov eax,4 							; sys_call write
		mov ebx,1 							; file descriptor 1: standard output
		mov ecx,GreaterThan 				; memory address, start of GreaterThan
		mov edx,GreaterLen 					; GreaterLen
		int 80h 							; sys_interrupt
		jmp done

writeL:
		mov eax,4 							; sys_call write
		mov ebx,1 							; file descriptor 1: standard output
		mov ecx,LessThan 					; memory address, start of LessThan
		mov edx,LessLen 					; LessLen
		int 80h 							; sys_interrupt
		jmp done

writeE:
		mov eax,4 							; sys_call write
		mov ebx,1 							; file descriptor 1: standard output
		mov ecx,Equal 						; memory address, start of Equal
		mov edx,EqualLen 					; EqualLen
		int 80h 							; sys_interrupt
		jmp done

done:
		mov eax,1 							; sys_call exit
		mov ebx,0 							; exit status 1
		int 80h 							; sys_interrupt

exitError:
		mov eax,1 							; sys_call exit
		mov ebx,-1 							; exit status -1
		int 80h  							; sys_interrupt