section .data
    num db 25      ; The number to display (change it to test other values)
    buffer db 3, 0xA    ; A buffer to hold the number string (2 digits + null terminator)

section .text
    global _start

_start:
    ; Convert the number to a string (2 digits)
    mov al, [num]        ; Load the number into al
    mov bl, 10           ; We need to divide by 10
    div bl               ; Divide al by 10, quotient in al, remainder in ah

    add al, '0'          ; Convert the tens digit to ASCII
    mov [buffer], al     ; Store the tens digit in buffer

    add ah, '0'          ; Convert the ones digit to ASCII
    mov [buffer + 1], ah ; Store the ones digit in buffer

    ; Print the number string
    mov rsi, buffer      ; Address of the buffer (string)
    mov rdx, 3           ; Length of the number string (2 digits)
    mov rax, 0x1         ; sys_write system call
    mov rdi, 1           ; File descriptor (stdout)
    syscall

    ; Exit program
    mov rax, 60          ; sys_exit
    xor rdi, rdi         ; Exit code 0
    syscall
