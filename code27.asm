section .data
    d1 db '1'       ; First digit
    d2 db '2'       ; Second digit
    sum db ' ', 0xA ; Buffer for result (1 byte for digit, 1 for newline)

section .text
    global _start

_start:
    ; Load and convert first digit
    movzx rax, byte [d1]   
    sub rax, '0'           
    
    ; Load and convert second digit
    movzx rbx, byte [d2]   
    sub rbx, '0'
    
    ; Add both digits
    add rax, rbx          
    add al, '0'          ; Convert back to ASCII
    
    ; Store result in sum
    mov [sum], al       
    
    ; Write result to stdout
    mov rax, 1           ; syscall: sys_write
    mov rdi, 1           ; file descriptor: stdout
    mov rsi, sum         ; address of output buffer
    mov rdx, 2           ; write 2 bytes (digit + newline)
    syscall             

    ; Exit program
    mov rax, 60         ; syscall: sys_exit
    xor rdi, rdi        ; status 0
    syscall             
