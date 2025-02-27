section .data
    digit db '1'      ; Character digit (ASCII '1')
    buffer db ' ', 0xA  ; Buffer to hold the result and newline (10 = 0xA, 0 = Null terminator)

section .text
    global _start

_start:
    ; Load the character '1' into a register
    movzx rsi, byte [digit]   ; Load the byte value of '1' into rsi (rsi = 0x31)

    ; Subtract the ASCII value of '0' (0x30) to get the integer value
    sub rsi, '0'              ; rsi = rsi - '0' (0x31 - 0x30 = 1)

    ; Increment the value in rsi (to simulate incrementing the digit)
    inc rsi                    ; rsi = rsi + 1 (Now rsi = 1 + 1 = 2)

    ; Convert the integer back to ASCII (e.g., 2 -> '2')
    add rsi, '0'               ; rsi = rsi + '0' (2 + 0x30 = 0x32, which is ASCII '2')

    ; Move the result to the buffer
    mov [buffer], sil          ; Store the ASCII character in the buffer

    ; Print the buffer using the write syscall
    mov rdi, 1                 ; File descriptor 1 (stdout)
    mov rsi, buffer            ; Address of the buffer to print
    mov rdx, 2                 ; Length of data to print (1 character + newline)
    mov rax, 1                 ; Syscall number for write
    syscall                    ; Invoke the syscall to print the buffer

    ; Exit the program
    mov rax, 60                ; Syscall number for exit
    xor rdi, rdi               ; Exit code 0
    syscall                    ; Invoke the syscall to exit
