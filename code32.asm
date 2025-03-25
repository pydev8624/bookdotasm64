section .data
    message db "Hello", 10
    message_len equ $ - message

section .text
    global _start
    
    ; Function prototype: void hello()
hello:
    push rbp            ; Save old base pointer
    mov rbp, rsp        ; Set up new base pointer

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, message    ; message to write
    mov rdx, message_len ; message length
    syscall             ; invoke syscall
    
    pop rbp             ; Restore old base pointer
    ret                 ; Return to caller

_start:
    call hello          ; Call hello function

    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status: 0
    syscall             ; invoke syscall

