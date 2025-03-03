section .data
    digit db '18446744073709551610', 0  ; Null-terminated string of digits
    ten dq 10                           ; Store 10 for division
    result db '', 0xA         ; Buffer for output (20 digits max + newline)


section .text
    global _start

_start:
    xor rax, rax            ; Clear RAX (will store final number)
    xor rcx, rcx            ; Clear RCX (used for iteration)
    
convert_loop:
    movzx rbx, byte [digit + rcx] ; Load next character
    test rbx, rbx           ; Check if it's null terminator
    jz done_conversion      ; If null, stop conversion
    sub rbx, '0'            ; Convert ASCII to integer
    imul rax, rax, [ten]       ; Multiply previous number by 10
    add rax, rbx            ; Add current digit
    inc rcx                 ; Move to next character
    jmp convert_loop        ; Repeat

done_conversion:
    add rax, 1              ; Increment number by 1

    ; Convert number to string (reverse order)
    mov rsi, result + 19    ; Start from the end of the buffer
    mov byte [rsi], 0xA     ; Store newline at the end
    dec rsi                 ; Move backward

extract_digits:
    xor rdx, rdx            ; Clear RDX before division
    div qword [ten]         ; RAX / 10, quotient in RAX, remainder in RDX
    add dl, '0'             ; Convert remainder to ASCII
    mov [rsi], dl           ; Store digit
    dec rsi                 ; Move pointer backward
    test rax, rax           ; Check if quotient is zero
    jnz extract_digits      ; Repeat if more digits

    inc rsi                 ; Adjust pointer to valid string start

    ; Calculate string length: result + 20 - rsi
    mov rdx, result + 20
    sub rdx, rsi

    ; Print result
    mov rax, 1              ; Syscall: sys_write
    mov rdi, 1              ; File descriptor: stdout
    mov rsi, rsi            ; Buffer with digits
    syscall                 ; Call kernel

    ; Exit
    mov rax, 60             ; Syscall: exit
    xor rdi, rdi            ; Status 0
    syscall
