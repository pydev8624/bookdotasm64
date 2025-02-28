section .data
    digit db '12'         ; String '12'
    ten dq 10             ; Store 10 as a byte for division
    result db '  ',0xA


section .text
    global _start

_start:
    ; Convert the first character ('1') to integer
    xor rax,rax
    mov al, byte [digit]   ; Load '1' (ASCII 49) into al
    sub al, '0'             ; Convert ASCII to integer (49 - 48 = 1)

    ; Convert the second character ('2') to integer
    xor rbx,rbx
    mov bl, byte [digit + 1] ; Load '2' (ASCII 50) into bl
    sub bl, '0'             ; Convert ASCII to integer (50 - 48 = 2)

    ; Multiply the first digit by 10 and add the second digit
    imul  rax, [ten]       ; rax = 1 * 10 = 10
    add rax, rbx            ; rax = 10 + 2 = 12

    ; Add 1 to the result (12 + 1)
    add rax, 1              ; rax = 12 + 1 = 13

    mov rsi, result + 2      ; Start from the end of the buffer

extract_digits:
    xor ah, ah               ; clear AH before division
    div byte [ten]                   ; Divide AL by 10 (quotient in AL, remainder in AH)
    add ah, '0'              ; Convert remainder (digit) to ASCII ('0' + digit)
    dec rsi                  ; Move buffer pointer backward
    mov [rsi], ah            ; Store digit in buffer
    cmp al, 0              ; Check if quotient is zero
    jnz extract_digits       ; Repeat if there are more digits

    ; Calculate string length: length = buffer + 4 - rsi
    mov rdx, 3      ; lenght of '12 '
    ; Print the number (buffer is in reverse order)
    mov rax, 1               ; Syscall number for sys_write
    mov rdi, 1               ; File descriptor 1 (stdout)
    syscall                  ; Invoke sys_write

    

    ; Exit the program (for Linux system)
    mov rax, 60             ; Syscall number for exit
    xor rdi, rdi            ; Status 0
    syscall
