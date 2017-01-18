;Assignment 5
;CSCI210-01
;Alejandro Parana
;3/30/2015

[SECTION .data]	 ;Section containing initialized data
	PromptNum db "   Please enter 6 numbers to fill an array: ", 0, 0
	int_fmt db "%d", 0

[SECTION .bss]	;Section containing unitialized data
	input1 resd 1

[SECTION .text]
	global arrayInput	;So other programs can use it
	extern scanf		;Tell the compiler to reference the C function library
	extern getchar		;Tell the compiler to reference the C function library
	extern printf		;Tell the compiler to reference the C function library
	
	;;;;;;;;;;;;;;;;;;;;;;;
	;  Array Subprogram   ;
	;;;;;;;;;;;;;;;;;;;;;;;
	arrayInput:
		push ebp
		mov ebp, esp
		
			push dword PromptNum
			call printf
			add esp, 4
			
			mov edi, [ebp+8]  ;array address
			mov ebx, [ebp+12] ;length = 6
			
			push esi
			xor esi, esi
			
			while:
				cmp esi, ebx ;esi >= ebx (6) ?
				jge end	     ;end while loop
				inc esi		 ;esi++
			
			push dword input1
			call get_int
			add esp, 4
			mov eax, [input1]
			mov [edi], eax
			add edi, 4		;Add 4 to move to next element
			jmp while
			
			end:
	
		mov esp, ebp
		pop ebp
		ret
		
	get_int:	;Use to get value from the user
		push ebp
		mov ebp, esp
			push dword [ebp+8]
			push dword int_fmt
			call scanf
			add esp, 8
			call getchar
			mov esp, ebp
		pop ebp
		ret
