section .data
    digit db '1'      ; Character digit (ASCII '1')
    
section .text
    global _start

_start:
    ; Load the character '1' into a register
    movzx rsi, byte [digit]   ; Load the byte value of '1' into rsi (rsi = 0x31)

    ; Subtract the ASCII value of '0' (0x30) to get the integer value
    sub rsi, '0'              ; rsi = rsi - '0' (0x31 - 0x30 = 1)

    ; Exit the program
    mov rax, 60                ; Syscall number for exit
    xor rdi, rdi               ; Exit code 0
    syscall                    ; Invoke the syscall to exit
