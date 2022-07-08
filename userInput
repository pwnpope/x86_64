; user input

section .data
        input db "> "
        result db "result : "

section .bss
        reservedbytes resb 20

section .text
        global _start

_start:
        call _textOne
        call _userInput
        call _textTwo
        call _printResult
        call _exit

_exit:
        mov rax, 60 ; sys_exit
        mov rdi, 0  ; 
        syscall

_userInput:
        mov rax, 0
        mov rdi, 0
        mov rsi, reservedbytes
        mov rdx, 20
        syscall
        ret

_textOne:
        mov rax, 1
        mov rdi, 1
        mov rsi, input
        mov rdx, 2
        syscall
        ret

_textTwo:
        mov rax, 1
        mov rdi, 1
        mov rsi, result
        mov rdx, 9
        syscall
        ret

_printResult:
        mov rax, 1
        mov rdi, 1
        mov rsi, reservedbytes
        mov rdx, 16
        syscall
        ret
