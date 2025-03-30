section .data
    filename db 'test.txt', 0         ; File name
    text db ' is the best'            ; Text to append
    newline db 10                      ; Newline character (\n)

section .bss
    buffer resb 256                    ; Buffer for reading the file

section .text
    global _start
    
    %macro nl 0
    
    ; Print newline after displaying content
    mov rsi, newline                    ; Address of newline character
    mov rdx, 1                           ; Number of bytes (1 byte for '\n')
    mov rax, 1                           ; syscall: write
    syscall

    %endmacro
_start:
    ; Open file (O_RDWR | O_CREAT)
    mov rdi, filename                 ; File name
    mov rsi, 66                       ; Flags: O_RDWR (2) | O_CREAT (64) = 66
    mov rdx, 0664                     ; Permissions: rw-rw-r-- (owner and group can read/write)
    mov rax, 2                         ; syscall: open
    syscall

    ; Check if file opened successfully
    cmp rax, 0
    jl exit                            ; Exit if error
    mov rdi, rax                       ; Store file descriptor in rdi

    ; Read content from file
    mov rsi, buffer                    ; Buffer to store content
    mov rdx, 256                          ; Max bytes to read
    mov rax, 0                          ; syscall: read
    syscall

    nl

    ; Display file content
    mov rdx, rax                        ; Number of bytes read
    test rdx, rdx                        ; Check if file is empty
    jz append                           ; If empty, skip reading output
    mov rsi, buffer                     ; Buffer to print
    mov rdi, 1                          ; stdout (1)
    mov rax, 1                          ; syscall: write
    syscall

append:
    ; Open file again (O_WRONLY | O_APPEND)
    mov rdi, filename                  ; File name
    mov rsi, 1025                      ; Flags: O_WRONLY (1) | O_APPEND (1024) = 1025
    mov rax, 2                          ; syscall: open
    syscall
    cmp rax, 0
    jl exit                             ; Exit if error
    mov rdi, rax                        ; Store file descriptor in rdi
    
    nl

    ; Write the text to the file
    mov rsi, text                       ; Address of new text
    mov rdx, 12                          ; Correct length of ' is the best'
    mov rax, 1                           ; syscall: write
    syscall

    ; Close file
    mov rax, 3                           ; syscall: close
    syscall

exit:
    ; Exit program
    mov rax, 60                          ; syscall: exit
    xor rdi, rdi                         ; Status 0
    syscall
