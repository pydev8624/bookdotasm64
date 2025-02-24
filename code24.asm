section .bss
    buffer resb 100    ; Reserve 100 bytes for input



section .text
    global _start

_start:
    ; Read user input
    mov rax, 0       ; syscall: sys_read
    mov rdi, 0       ; file descriptor: stdin
    mov rsi, buffer  ; buffer to store input
    mov rdx, 100     ; number of bytes to read
    syscall

    ; Write user input back to stdout
    mov rax, 1       ; syscall: sys_write
    mov rdi, 1       ; file descriptor: stdout
    mov rsi, buffer  ; buffer containing input
    mov rdx, 100     ; number of bytes to write
    syscall

    ; Exit program
    mov rax, 60      ; syscall: sys_exit
    xor rdi, rdi     ; status 0
    syscall
