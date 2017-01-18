;Assignment 5
;CSCI210-01
;Alejandro Parana
;3/30/2015

[SECTION .data]
;No initialized data needed for this subprogram

[SECTION .bss]
;No uninitialized data needed for this subprogram

[SECTION .text]
	global recFact	;So other programs can use it
	
	;;;;;;;;;;;;;;;;;;;;;;;
	;Recursive Factorial  ;
	;;;;;;;;;;;;;;;;;;;;;;;
	recFact:
		push ebp			;Set up stack frame
		mov ebp, esp		;for the subprogram
		mov eax, [ebp+8]	;Move the parameter into eax
		cmp eax, 0			;Compare eax with zero
		je baseCase			;Jump to base case if equal
		dec eax				;eax--
		push eax			;Push eax onto the stack
		call recFact		;Recursive call
		add esp, 4			;Adds the value of 4 to the stack pointer
		mul dword [ebp+8]	;Multiply the parameter
		jmp endFact			;Jump to terminate subprogram
	baseCase: 
		mov eax, 1		;Base case reached
	endFact:
		mov esp, ebp	;Destroy the subprogram
		pop ebp			;stack frame before returning
		ret				;Jump back to the caller
