section .data
    text db "Hello from mmap!", 0x0A  ; Text with a newline character at the end
    text_len equ $ - text             ; Calculate the length of the text

section .text
    global _start

_start:

    ; === mmap syscall ===
    ; void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
    ; 
    ; syscall number: 9
    ; 
    ; rdi = addr  = 0          (NULL, let the kernel choose the address)
    ; rsi = length = 4096      (allocate 4096 bytes = 1 memory page)
    ; rdx = prot  = 3          (PROT_READ | PROT_WRITE)
    ;      => PROT_READ  = 1   (Page can be read)
    ;      => PROT_WRITE = 2   (Page can be written)
    ;      => 1 + 2 = 3
    ;
    ; r10 = flags = 34         (MAP_PRIVATE | MAP_ANONYMOUS)
    ;      => MAP_PRIVATE  = 2 (Changes are private to the process)
    ;      => MAP_ANONYMOUS = 32 (Not backed by a file)
    ;      => 2 + 32 = 34
    ;
    ; r8 = fd = -1             (No file descriptor since MAP_ANONYMOUS)
    ; r9 = offset = 0          (Offset in the file, irrelevant here)

    mov rax, 9          ; syscall number for mmap
    xor rdi, rdi        ; addr = 0 (NULL)
    mov rsi, 4096       ; length = 4096 bytes
    mov rdx, 3          ; prot = 3 (PROT_READ | PROT_WRITE)
    mov r10, 34         ; flags = 34 (MAP_PRIVATE | MAP_ANONYMOUS)
    mov r8, -1          ; fd = -1 (no file)
    xor r9, r9          ; offset = 0
    syscall

    ; mmap returns the mapped memory address in rax
    mov rbx, rax        ; Save the mmap'd address into rbx for later use

    ; === Copy "Hello from mmap!" into the mapped memory ===
    mov rcx, text       ; rcx points to our source text
    mov rsi, rbx        ; rsi points to the destination (mmap'd memory)
    mov rdi, text_len   ; rdi is used as a counter for text length

.copy_loop:
    cmp rdi, 0
    je .write_done      ; Exit the loop if all characters are copied
    mov al, byte [rcx]  ; Load byte from [rcx]
    mov byte [rsi], al  ; Store byte into [rsi]
    inc rcx             ; Move to next source byte
    inc rsi             ; Move to next destination byte
    dec rdi             ; Decrease counter
    jmp .copy_loop      ; Repeat

.write_done:

    ; === write syscall ===
    ; ssize_t write(int fd, const void *buf, size_t count);
    ;
    ; syscall number: 1
    ; rdi = fd = 1 (stdout)
    ; rsi = buf = address to write (mmap'd memory)
    ; rdx = count = text length

    mov rax, 1          ; syscall number for write
    mov rdi, 1          ; file descriptor 1 = stdout
    mov rsi, rbx        ; buffer to write (our mmap'd memory)
    mov rdx, text_len   ; number of bytes to write
    syscall

    ; === exit syscall ===
    ; void exit(int status);
    ;
    ; syscall number: 60
    ; rdi = exit code (0 = success)

    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; status = 0
    syscall
