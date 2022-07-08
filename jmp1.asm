global _start
    section .text
        _start:
            mov EBX, 42       ; exit status code as 42
            mov eax, 1        ; sys_exit system call ( takes a status code )
            jmp skip          ; jump to "skip" label
            add ebx, 13       ; add 13 to ebx ( this should not be ran because of the 'jmp' instruction above )

        skip:                 ; setting a new function named 'skip'
            int 0x80          ; making an interrupt and preforming a system call