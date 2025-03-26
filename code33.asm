section .data
    msg db "hello", 0xA  ; رشته برای چاپ
    len equ $-msg        ; محاسبه طول رشته

section .text
    global _start

    %macro writer 2
        mov rax, 1       ; syscall برای sys_write
        mov rdi, 1       ; شماره فایل دیسکریپتور (stdout)
        mov rsi, %1      ; آدرس رشته
        mov rdx, %2      ; طول رشته
        syscall
    %endmacro

    %macro exiter 0
        mov rax, 60      ; syscall برای خروج
        xor rdi, rdi     ; مقدار بازگشتی ۰
        syscall
    %endmacro

_start:
    writer msg, len  ; فراخوانی ماکروی writer
    exiter           ; فراخوانی ماکروی exiter
