global _start

section .data
    address db " goatshitnigga", 0x0a  ; setting the variable 'address' to yellow
    length equ $ - address                  ; total length of the 'address' variable

section .text
    _start:
        mov [address], byte 'T'     ; this will move the byte representation
                                    ; of capitol 'T' into the 'address' variable
                                    ; note that the 'T' will be placed in index
                                    ; position 0 within the string

        mov [address+19], byte '!'  ; this will go to index position 19 in the
                                    ; variable 'address' and place the byte
                                    ; representation of '!'

        mov EAX, 4                  ; sys_write system call
        mov ebx, 1                  ; stdout file descriptor
        mov ecx, address            ; bytes to write
        mov edx, length             ; number of bytes to read
        int 0x80                    ; interrupt and invoke sys_call

        mov eax, 1                  ; sys_exit system call
        mov ebx, 0                  ; setting 0 as the exit status
        int 0x80                    ; interrupt and invoke sys_call
