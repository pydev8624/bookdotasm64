%macro exiter 0
    mov rax, 60      ; syscall برای خروج
    xor rdi, rdi     ; مقدار بازگشتی ۰
    syscall
%endmacro
