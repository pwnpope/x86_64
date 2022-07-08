; this will loop through the "_loop" label 4 times and than make a sys_exit
global _start

section .text
    _start:
        mov EBX, 1   ; starts ebx at 1
        mov ECX, 4   ; number of iterations
        call _loop   ; calling the '_loop' label

    _loop:
        add EBX, EBX ; EBX += EBX  ( adds what ever's in EBX to EBX )
        dec ECX      ; decrement EBX by -1
        cmp ECX, 0   ; compare ECX to 0
        jg _loop     ; conditional jump instruction jumping to the '_loop' label if ECX is greater than 0
        mov eax, 1   ; this will sys_exit after 4 iterations
        int 0x80     ; interrupt & invoke a sys_call