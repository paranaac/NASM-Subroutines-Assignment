;Assignment 5
;CSCI210-01
;Alejandro Parana
;3/30/2015
  
[SECTION .data]   ;Section containing initialized data
input_fmt3 db "   The time for 12-Hour Clock is %d:%d AM", 10, 0
input_fmt4 db "   The time for 12-Hour Clock is %d:%d PM", 10, 0


[SECTION .bss]
;No uninitialized data needed for this subprogram

[SECTION .text]  
	global timeConvert   ;So other programs can use it
	extern printf		 ;Tell the compiler to reference the C function library
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; 24-Hour Time Converter  ;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	timeConvert:
		push ebp			;Set up stack frame
		mov ebp, esp		;for the subprogram	

		mov ebx, [ebp+8]	;Copy paremeter to ebx
		mov eax, [ebp+12]	;Copy paremeter to eax
		mov ecx, 12			;Copy 12 to ecx
		mov edx, [eax]		;Mov the value of eax into edx
	
		cmp edx, 12			;Compare 12 to edx
		jg subtract			;Jump to subtract if greater
		jmp am				;Jump to am
		subtract: sub [eax], ecx	;Subtract ecx from eax
		jmp pm				;Jump to pm
		
		am:					;AM label
			push dword [ebx]
			push dword [eax]
			push dword input_fmt3	
			call printf				
			add esp, 8
			jmp end_
		
		pm:				   ;PM label
			push dword [ebx]
			push dword [eax]
			push dword input_fmt4
			call printf				
			add esp, 8
			jmp end_
		end_:				
		
		mov esp, ebp
		pop ebp
		ret
