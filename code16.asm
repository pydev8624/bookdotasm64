section .data
    msg db "Hello", 0xA  ; "Hello" followed by a newline (ASCII 10)
    len equ $ - msg      ; Length of the message

section .bss

section .text
    global _start

_start:
    mov rcx, 5           ; Loop counter (5 times)

loop_start:
    ; Write syscall: write(1, msg, len)
    mov rax, 1           ; syscall number for sys_write
    mov rdi, 1           ; file descriptor (stdout)
    mov rsi, msg         ; pointer to message
    mov rdx, len         ; message length
    syscall              ; invoke syscall

    loop loop_start      ; Decrease rcx and jump if rcx > 0

    ; Exit syscall: exit(0)
    mov rax, 60          ; syscall number for sys_exit
    xor rdi, rdi         ; exit code 0
    syscall              ; invoke syscall
