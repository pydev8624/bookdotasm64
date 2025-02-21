section .data
    num db 123       ; The number we want to print (123)

section .bss
    buffer resb 4             ; Buffer to store ASCII digits

section .text
    global _start

_start:
    ; Load the value to print into AL (since it is a byte)
    mov al, [num]    ; Load 123 into AL

    ; Convert the number into ASCII digits
    mov bl, 10               ; Divider: 10 (for extracting digits)
    mov rsi, buffer + 4      ; Start from the end of the buffer

extract_digits:
    xor ah, ah               ; clear AH before division
    div bl                   ; Divide AL by 10 (quotient in AL, remainder in AH)
    add ah, '0'              ; Convert remainder (digit) to ASCII ('0' + digit)
    dec rsi                  ; Move buffer pointer backward
    mov [rsi], ah            ; Store digit in buffer
    cmp al, 0              ; Check if quotient is zero
    jnz extract_digits       ; Repeat if there are more digits

    ; Calculate string length: length = buffer + 4 - rsi
    mov rdx, 4      ; lenght of '123 '
    ; Print the number (buffer is in reverse order)
    mov rax, 1               ; Syscall number for sys_write
    mov rdi, 1               ; File descriptor 1 (stdout)
    syscall                  ; Invoke sys_write

    ; Exit the program (Linux syscall)
    mov rax, 60              ; Syscall number for exit
    xor rdi, rdi             ; Status code 0
    syscall                  ; Invoke syscall
