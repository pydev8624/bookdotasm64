section .data
    num1 dq 10
    num2 dq 3
    newline db 10   ; Newline character
    result_str db "Result: ", 0  ; Prefix for output

section .bss
    result resq 1       ; Storage for result
    buffer resb 20      ; Buffer to store the number string

section .text
    global _start
    extern printf   ; Required for calling printf

_start:
    ; Load values and perform addition
    mov rax, [num1]
    mov rbx, [num2]
    add rax, rbx
    mov [result], rax  ; Store result

    ; Convert integer to string
    mov rdi, buffer    ; Destination buffer
    mov rsi, rax       ; Number to convert
    call int_to_str    ; Convert number to string

    ; Print "Result: "
    mov rax, 1         ; syscall: sys_write
    mov rdi, 1         ; File descriptor: stdout
    mov rsi, result_str
    mov rdx, 8         ; Length of "Result: "
    syscall

    ; Print the result string
    mov rax, 1         ; syscall: sys_write
    mov rdi, 1         ; File descriptor: stdout
    mov rsi, buffer
    mov rdx, 20        ; Buffer length
    syscall

    ; Print newline
    mov rax, 1         ; syscall: sys_write
    mov rdi, 1         ; stdout
    mov rsi, newline
    mov rdx, 1         ; Length = 1
    syscall

    ; Exit program
    mov rax, 60        ; syscall: exit
    xor rdi, rdi
    syscall

; Function: int_to_str
; Converts a number in RSI to a null-terminated string in RDI
int_to_str:
    mov rcx, 10         ; Base 10
    mov rbx, rdi        ; Save original buffer pointer
    add rdi, 19         ; Move to end of buffer
    mov byte [rdi], 0   ; Null-terminate the string
    dec rdi

.convert_loop:
    xor rdx, rdx
    div rcx             ; RAX /= 10, RDX = remainder
    add dl, '0'         ; Convert to ASCII
    mov [rdi], dl       ; Store digit
    dec rdi
    test rax, rax       ; Check if RAX is zero
    jnz .convert_loop

    inc rdi             ; Point to first digit
    ret
