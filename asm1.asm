global _start            ; global directive is nasm specific
_start:                  ; tell linker entry point ( like a main function )

        mov EAX, 1       ; this will move 1 into the EAX register ( 1 is the "sys_exit" sys-call)
        mov EBX, 42      ; this will move 42 into the EBX register as the exit status code
        sub EBX, 23      ; this will subtract 23 from what ever is in the EBX register
        int 0x80         ; this will trigger an interrupt notated by "int" and "0x80" the makes a sys-call