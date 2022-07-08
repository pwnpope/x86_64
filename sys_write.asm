global _start                                     ; global directive is nasm specific

section .data                                     ; "section .data" holds variables and 'data'
	totem db "TOTEM ON YUH HEAD", 0x0a            ; #1 we are declaring a variable called "totem" than saying "db"
                                                  ; #2 to make sure it knows that this is a string, afterwards we
                                                  ; #3 print a newline character "0x0a"

	total equ $ - totem                           ; #1 this will get total length of the "totem" variable and store
						                          ; #2 the value into the "total" variable

section .text                   ; "section .text" holds Code segment
	_start:                     ; "_start:" tells the program where to start ( basically a 'main' function )
		mov eax, 4	            ; sys_write ( system call )
		mov ebx, 1	            ; stdout file descriptor
		mov ecx, totem	        ; bytes to write
		mov edx, total	        ; number of bytes to write
		int 0x80	            ; perform a system call
