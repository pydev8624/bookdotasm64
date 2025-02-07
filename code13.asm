section .data
    magsoom db 10
    magsoom_alaih db 2

section .text
    global _start
_start:
    mov rax, [magsoom]
    mov rdx, 0
    mov rcx, [magsoom_alaih]
    div rcx

    mov rax,60
    xor rdi,rdi
    syscall
