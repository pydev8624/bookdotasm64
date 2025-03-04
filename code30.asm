section .data
    array db 'a', ' ', 'd', 0xA  ; Define the array of characters

section .text
    global _start

_start:
    ; Print each character
    mov rsi, array  ; Load the address of the array into RSI

.loop:
    mov al, byte [rsi]  ; Load the current character from the array into AL
    test al, al         ; Check if it's the null terminator (end of the string)
    jz .done            ; If it's the null terminator, we are done
    mov rdi, 1          ; File descriptor 1 (stdout)
    mov rax, 1        ; System call number for sys_write
    mov rdx, 1          ; Number of bytes to write
    syscall             ; Make the system call to write the character to stdout
    inc rsi             ; Move to the next character in the array
    jmp .loop           ; Repeat the loop

.done:
    mov rax, 60         ; System call number for sys_exit
    xor rdi, rdi        ; Return code 0
    syscall             ; Make the system call to exit
