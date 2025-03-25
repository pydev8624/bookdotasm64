section .data
    msg db "hello", 0xA
    len equ 6

section .text
    global _start

hello:
    push rbp
    mov rbp, rsp
    ;sub rsp,8  ; stack aligment : cpu management

    mov rax,1
    mov rdi,1
    mov rsi,msg
    mov rdx,len
    syscall

    pop rbp
    ret

_start:
    call hello

    mov rax,60
    xor rdi,rdi
    syscall
