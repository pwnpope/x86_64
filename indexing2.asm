global _start

section .text
    _start:
        add esp, 5
        mov [esp],   byte 'H'    ; moving 'H' into index position 0, in the esp register
        mov [esp+1], byte 'e'    ; moving 'e' into index position 1, in the esp register
        mov [esp+2], byte 'l'    ; moving 'l' into index position 2, in the esp register
        mov [esp+3], byte 'l'    ; moving 'l' into index position 3, in the esp register
        mov [esp+4], byte 'o'    ; moving 'o' into index position 4, in the esp register

        mov eax, 4             ; sys_write system call
        mov ebx, 1             ; setting 1 as the file descriptor
        mov ecx, esp           ; bytes to write to stdout
        mov edx, 5             ; number of bytes the string to write is
        int 0x80               ; interrupt and invoke a system call

        mov eax, 1
        mov ebx, 0
        int 0x80