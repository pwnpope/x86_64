global _start

section .text
    _start:
        mov ECX, 99     ; set ecx to 99
        mov EBX, 42     ; exit status is 42
        mov EAX, 1      ; sys_exit system call
        cmp ECX, 100    ; compare ecx to 100
        jl _skip        ; jump if less than to _skip label
                        
                        ; if ECX is less than 100 it will jump to the _skip label

        sub EBX, 30     ; we subtract 30 from the EBX register which won't
                        ; happen because of the 'jmp skip' instruction above

    _skip:              ; declaring this label as "_skip"
        int 0x80        ; interrupt & than invoke a sys call