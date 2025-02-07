section .data
    num1 dq 184467440715445113
    num2 dq 1544511315445113
    newline db 10     ; Newline character for formatting

section .bss
    result resq 1     ; 8-byte (64-bit) result storage
    buffer resb 32    ; Buffer for storing converted number

section .text
    global _start

_start:
    ; Load numbers into registers
    mov rax, [num1]
    mov rbx, [num2]
    add rax, rbx      ; Perform addition
    mov [result], rax ; Store result

    ; Convert the number in RAX to a string
    mov rdi, buffer   ; Destination buffer
    call int_to_str

    ; Print the result
    mov rsi, rdi      ; Pointer to string
    call print_string

    ; Print newline
    mov rsi, newline
    mov rdx, 1        ; Length = 1
    call print_string

    ; Exit program
    mov rax, 60
    xor rdi, rdi
    syscall

; -----------------------
; Print a null-terminated string
; Input: RSI -> Address of string
;        RDX -> Length of string
; -----------------------
print_string:
    mov rax, 1         ; syscall: sys_write
    mov rdi, 1         ; file descriptor: stdout
    syscall
    ret

; -----------------------
; Convert unsigned integer in RAX to string
; Output: RDI -> Pointer to converted string
; -----------------------
int_to_str:
    mov rbx, 10         ; Base 10
    mov rcx, buffer + 31 ; Point to end of buffer
    mov byte [rcx], 0   ; Null-terminate string

convert_loop:
    dec rcx
    mov rdx, 0
    div rbx             ; RAX / 10, remainder in RDX
    add dl, '0'         ; Convert remainder to ASCII
    mov [rcx], dl
    test rax, rax       ; If RAX is zero, stop
    jnz convert_loop

    mov rdi, rcx        ; Return pointer to start of string
    ret
