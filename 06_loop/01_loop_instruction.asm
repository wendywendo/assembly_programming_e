section .data
    message db "Hello, Assembly!", 10
    length equ $ - message

section .text
    global _start

_start:
    mov rcx, 5                  ; Repeat 5 times

repeat:
    ; Print the message
    mov rax, 1              
    mov rdi, 1                  
    mov rsi, message
    mov rdx, length
    syscall ; In x86-64 Linux, syscall overwrites RCX with the address of the next instruction.

    loop repeat    

    
    mov rax, 60          
    xor rdi, rdi
    syscall

    