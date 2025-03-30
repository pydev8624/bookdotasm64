section .data
    filename db "newfile.txt", 0
    O_CREAT_WRONLY equ 0x41   ; ایجاد فایل و باز کردن در حالت نوشتن
    permissions equ 0644      ; مجوزهای فایل (rw-r--r--)

section .bss
    fd resq 1

section .text
    global _start

_start:
    ; ایجاد و باز کردن فایل
    mov rax, 2
    mov rdi, filename
    mov rsi, O_CREAT_WRONLY
    mov rdx, permissions
    syscall
    mov [fd], rax

    ; نوشتن در فایل
    mov rax, 1
    mov rdi, [fd]
    mov rsi, filename
    mov rdx, 12
    syscall

    ; بستن فایل
    mov rax, 3
    mov rdi, [fd]
    syscall

    ; خروج از برنامه
    mov rax, 60
    xor rdi, rdi
    syscall
