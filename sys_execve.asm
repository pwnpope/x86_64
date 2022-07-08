global _start


section .data
	execve_call equ 0x0b ; syscalls the kernel


section .text

	_start:
		call execve

	execve:
		push execve_call     ; SYS_EXECVE = 11
		pop eax              ; set SYS_EXECVE to eax

		xor esi, esi    ; clean esi
		push esi        ; esi is zero
		push 0x68732f2f ; push 'hs//'
		push 0x6e69622f ; push 'nib/'

		; execve("/bin//sh/", 0, 0);
		;             ^
		;            ebx
		mov ebx, esp		; program to execute = EBX

		; execve("/bin//sh/", 0, 0);
		;                     ^
		;                   ecx
		xor ecx, ecx    	; clean ecx

		; execve("/bin//sh/", 0, 0);
		;                        ^
		;                       edx
		mov edx, ecx    	; set zero to edx
		int 0x80        	; syscall execve
