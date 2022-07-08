global _start


section .data
	filename db "pwn.txt", 0  ; creating a filename variable with a 0 terminated string
	text db "PwnThaPlanet"    ; creating a variable called text holding a string
	length equ $ - text       ; grabbing the length of the 'text' variable


section .text
	_start:
		call open
		call write
		call close
		call exit

	open:
		mov RAX, 2                 ; sys_open system call
		mov RDI, filename          ; giving the file a name
		mov RSI, 64+1              ; ( O_CREAT+O_WRONLY )
		mov RDX, 0644o             ; giving 0644 permissions to the file and signalling to nasm that the 'o' is the octal value
		syscall

	write:
		push RAX         ; pushing RAX onto the stack
		mov RDI, RAX     ; moving RAX into RDI
		mov RAX, 1       ; sys_write system call
		mov RSI, text    ; bytes to write to the file
		mov RDX, length  ; bytes to read to the file
		syscall

	close:
		mov RAX, 3   ; sys_close system call
		pop RDI      ; popping RDI of the stack
		syscall

	exit:
		mov RAX, 60  ; sys_exit system call
		mov EDI, 0   ; exit status is now 0
		syscall

