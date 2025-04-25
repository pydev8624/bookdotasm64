; mmap.asm
section .text
global _start

%define SYS_MMAP         9
%define PROT_READ        1
%define PROT_WRITE       2
%define MAP_PRIVATE      2
%define MAP_ANONYMOUS    32

_start:
    ; ----------------------------------------
    ; Step 1: mmap to allocate 4096 bytes
    ; ----------------------------------------
    xor rdi, rdi               ; addr = NULL (let kernel choose)
    mov rsi, 4096              ; length = 4KB
    mov rdx, PROT_READ | PROT_WRITE
    mov r10, MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, -1                 ; fd = -1 (anonymous)
    xor r9, r9                 ; offset = 0
    mov rax, SYS_MMAP
    syscall
    ; Result: rax = address of new memory
    mov r12, rax               ; save pointer

    ; ----------------------------------------
    ; Step 2: Write a char into mapped memory
    ; ----------------------------------------
    mov byte [r12], 'A'        ; write 'A' to the first byte

    ; ----------------------------------------
    ; Step 3: Write to stdout
    ; ----------------------------------------
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; fd = stdout
    mov rsi, r12               ; pointer to memory
    mov rdx, 1                 ; length = 1
    syscall

    ; ----------------------------------------
    ; Exit program
    ; ----------------------------------------
    mov rax, 60                ; syscall: exit
    xor rdi, rdi               ; status = 0
    syscall
