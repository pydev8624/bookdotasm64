section .text
global _start

_start:
    ; --------------------------------------------
    ; Step 1: get current program break (brk(0))
    ; --------------------------------------------
    mov rax, 12        ; syscall number for brk
    xor rdi, rdi       ; rdi = 0 → get current program break
    syscall
    mov r12, rax       ; save current break in r12

    ; --------------------------------------------
    ; Step 2: allocate 4096 bytes (brk(new_addr))
    ; --------------------------------------------
    mov rdi, r12       ; start address
    add rdi, 10500      ; increase by 4 KB
    mov rax, 12        ; syscall brk again
    syscall
    ; حالا r12 تا rax منطقه حافظه رزرو شده است

    ; --------------------------------------------
    ; Step 3: write something into heap
    ; --------------------------------------------
    mov byte [r12], '5'     ; نوشتن عدد '5' در اولین بایت از حافظه جدید

    ; --------------------------------------------
    ; Step 4: print it to stdout using write
    ; --------------------------------------------
    mov rax, 1         ; syscall write
    mov rdi, 1         ; fd = 1 (stdout)
    mov rsi, r12       ; address of char
    mov rdx, 1         ; length = 1
    syscall

    ; --------------------------------------------
    ; Step 5: restore heap if needed (optional)
    mov rax, 12
    mov rdi, r12
    syscall

    ; --------------------------------------------
    ; Exit
    ; --------------------------------------------
    mov rax, 60        ; syscall exit
    xor rdi, rdi       ; status = 0
    syscall
