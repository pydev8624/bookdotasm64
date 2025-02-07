section .data
    num1 dq 184467440715445113
    num2 dq 1544511315445113
    

section .bss
    result resq 1 ; 8 byte 64 bit

section .text
    global _start
_start:
    mov rax, [num1]
    mov rbx, [num2]
    add rax, rbx ; zf=0
    mov [result],rax

    ; 184467440715445113×1544511315445113 = 284888554042335236103385884419369
    ; Lower 64 bits (RAX)=284888554042335236103385884419369 mod 2^64 = 17277107872285376345
    ; Upper 64 bits (RDX)=284888554042335236103385884419369 ÷   2^64 = 15445110589888
    
    mov rax,60
    xor rdi,rdi ;zf=1
    syscall
