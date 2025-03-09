section .data
    name db 'Ali', 0xA

section .text
    global _start

_start:
    mov rsi,name
    
    call writes
    call exits

    writes:
        mov rdi, 1          ; File descriptor 1 (stdout)
        mov rax, 1        ; System call number for sys_write
        mov rdx, 4          ; Number of bytes to write
        syscall             ; Make the system call to write the character to stdout
    

    exits:
        mov rax, 60         ; System call number for sys_exit
        xor rdi, rdi        ; Return code 0
        syscall             ; Make the system call to exit
