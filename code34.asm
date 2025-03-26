section .data
    msg db "hello", 0xA  ; رشته برای چاپ
    len equ $-msg        ; محاسبه طول رشته

section .text
    global _start
    %include "writer.inc"
    %include "exiter.inc"

_start:
    writer msg, len  ; فراخوانی ماکروی writer
    exiter           ; فراخوانی ماکروی exiter
