%macro writer 2
    mov rax, 1       ; syscall برای sys_write
    mov rdi, 1       ; شماره فایل دیسکریپتور (stdout)
    mov rsi, %1      ; آدرس رشته
    mov rdx, %2      ; طول رشته
    syscall
%endmacro
