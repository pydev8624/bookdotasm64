section .data
    num dq    11                            ; Binary number to convert
    buffer db '                    ', 0xA ; Buffer to store the ASCII result, newline at the end
    ten dq 10                              ; Constant for division

section .text
    global _start

_start:
    mov rax, qword [num]        ; Load the number to convert
    mov rdi, buffer+19          ; Point to the last digit position

convert_loop:
    xor rdx, rdx                  ; Clear RDX before division
    div qword [ten]             ; RAX = RAX / 10, RDX = RAX % 10
    add dl, '0'                 ; Convert remainder to ASCII
    mov [rdi], dl               ; Store ASCII digit in buffer
    dec rdi                     ; Move to the next position
    cmp rax, 0               ; Check if quotient is zero
    jnz convert_loop            ; Repeat if more digits remain

    ; Adjust rsi to point to the first non-space character
    lea rsi, [rdi+1]            ; rdi is one byte before the first digit, so move rsi forward          

    ; Now, write the result to stdout
    mov rax, 1                  ; Write syscall
    mov rdi, 1                  ; File descriptor 1 (stdout)
    syscall                     ; Perform the write syscall

    ; Exit program
    mov rax, 60                 ; Exit syscall
    xor rdi, rdi                ; Status 0
    syscall
