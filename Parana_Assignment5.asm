;Assignment 5
;CSCI210-01
;Alejandro Parana
;3/30/2015
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Use subprograms to make a 24-hour time converter, recursive factorial, and populating arrays;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[SECTION .text]				;Section containing code
	extern printf			;Tell the compiler to reference the C function library for printf
	extern scanf			;Tell the compiler to reference the C function library for scanf
	extern recFact			;Tell the compiler to link to this subprogram
	extern timeConvert		;Tell the compiler to link to this subprogram
	extern arrayInput		;Tell the compiler to link to this subprogram
	global main				;Required so linker can find entry point
	
	main:					;Entry point of program
		push ebp			;Sets up the stack frame
		mov ebp, esp		;Program must preserve the value
		push ebx			;of the registers ebp,
		push esi			;ebx esi, and edi
		push edi			;End of top portion of boilerplate
			
			push dword Name		;Pushes the address of the string Name
			call printf			;Prints the string Name to the screen
			add esp, 4			;Adds the value of 4 to the stack pointer
			
			push dword p1	     	;Pushes the address of the string p1
			call printf				;Prints the string Prompt1 to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer
			
			push dword Prompt1	    ;Pushes the address of the string Prompt1
			call printf				;Prints the string Prompt1 to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer
			
			push dword hours		;Pushes the address of the integer buffer - hours
			push dword input_fmt	;Pushes the address of the input format string - input_fmt
			call scanf				;Scans in an integer value from the keyboard
			add esp, 8				;Adds the value of 8 to the stack pointer
			
			push dword Prompt2	    ;Pushes the address of the string Prompt2
			call printf				;Prints the string Prompt1 to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer
			
			push dword minutes 		;Pushes the address of the integer buffer - minutes
			push dword input_fmt	;Pushes the address of the input format string - input_fmt
			call scanf				;Scans in an integer value from the keyboard
			add esp, 8				;Adds the value of 8 to the stack pointer
			
			push dword hours		;Pushes the parameter for timeConvert
			push dword minutes		;Pushes the parameter for timeConvert
			call timeConvert		;Invokes the timeConvert Subprogram
			add esp, 8				;Adds the value of 8 to the stack pointer

			push dword Blank		;Pushes the address of the empty string Blank
			call printf				;Prints a blank line to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer

			push dword p2	     	;Pushes the address of the string p2
			call printf				;Prints the string Prompt1 to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer

			push dword Prompt3	    ;Pushes the address of the string Prompt3
			call printf				;Prints the string Prompt1 to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer

			push dword number		;Pushes the address of the integer buffer - number
			push dword input_fmt	;Pushes the address of the input format string - input_fmt
			call scanf				;Scans in an integer value from the keyboard
			add esp, 8				;Adds the value of 8 to the stack pointer

			mov ebx, [number]		;Move the value of number into ebx register
			push dword [number]		;Pushes the parameter for factorial subprogram
			call recFact			;Invokes the factorial recursive subprogram
			add esp, 4				;Adds the value of 4 to the stack pointer
			
			push eax				;Pushes the %d argument for printf
			push ebx				;Pushes the %d argument for printf
			push dword factResult	;Pushes the address of the string factResult
			call printf				;Prints the string factResult to the screen
			add esp, 8				;Adds the value of 8 to the stack pointer
	
		    push dword Blank		;Pushes the address of the empty string Blank
			call printf				;Prints a blank line to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer

			push dword p3	     	;Pushes the address of the string p3
			call printf				;Prints the string Prompt1 to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer

			push dword 6			;Push the length of the array
			push dword array1		;Push the address of the array to populate
			call arrayInput			;Call the array subprogram to read user input
		
			;Print out the array values (for testing)
			push dword [array1+20]
			push dword [array1+16]
			push dword [array1+12]
			push dword [array1+8]
			push dword [array1+4]
			push dword [array1]
			push dword ArrayValues
			call printf
			add esp, 28
		
			xor edx, edx		;Index counter
			xor eax, eax		;Array counter
			mov ecx, 7			;Loop counter
			mov ebx, [array1]	;Copy array value to ebx
		
			;Find the largest element in the array
			maxnum:
				mov ebx, [array1+eax*4]
				inc edx
				loop loop	
			loop:
				inc eax
				cmp ebx, [array1+eax*4]
				jle maxnum
				loop loop
			return_max:
				mov [max], ebx
				dec edx ; Index starts at 0
				mov [index], edx
			exit:

			push dword [index]			;Pushes the %d argument for printf
			push dword [max]			;Pushes the %d argument for printf
			push dword LargestElement	;Pushes the address of LargestElement
			call printf					;Prints the string LargestElement to the screen
			add esp, 12					;Adds the value of 12 to the stack pointer

			push dword Success		;Pushes the address of the string Success
			call printf				;Prints the string Success to the screen
			add esp, 4				;Adds the value of 4 to the stack pointer

		pop edi			;Program restores saved register values by 
		pop esi			;popping them from the stack as they
		pop ebx			;were pushed from the beginning
		mov esp, ebp	;Destroys stack frame before returning
		pop ebp			;End of bottom portion of boilerplate
		ret				;Returns the control to LINUX
	
	
		
	
[SECTION .bss]	;Section containing unitiazlied data
	hours resd 1
	minutes resd 1
	number resd 1
	array1 resd 24
	max resd 1
	index resd 1
	
[SECTION .data]	;Section containing initialized data
	Blank db "", 10, 0	
	Name db "Alejandro Parana", 10, 0
	Success db "***Successful Program Termination***", 10, 0
	p1 db "24-Hour Time Converter Subprogram:", 10 , 0
	Prompt1 db "   Please enter the hours: ", 0, 0
	Prompt2 db "   Please enter the minutes: ", 0, 0
	input_fmt db "%d\n", 10 , 0
	input_fmt2 db "%d ", 0
    p2 db "Factorial Subprogram:", 10 , 0
	Prompt3 db "   Please enter a number: ", 0, 0
	factResult db "   The result of %d! is: %d ", 10, 0
	p3 db "Array Subprogram:", 10 , 0
	ArrayValues db "   Array values: %d %d %d %d %d %d", 10, 0
	LargestElement db "   The largest element in the array is %d at index %d", 10, 0

