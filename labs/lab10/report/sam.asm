%include 'in_out.asm'

SECTION .data
    ask_msg     db 'Как Вас зовут? ', 0h
    prefix      db 'Меня зовут ', 0h
    prefix_len  equ $ - prefix - 1
    filename    db 'name.txt', 0h
    nl          db 10

SECTION .bss
    contents    resb 255

SECTION .text
global _start

_start:
    mov eax, ask_msg
    call sprint

    mov ecx, contents
    mov edx, 255
    call sread

    mov ecx, 0777o
    mov ebx, filename
    mov eax, 8
    int 80h
    mov esi, eax

    mov eax, 4
    mov ebx, esi
    mov ecx, prefix
    mov edx, prefix_len
    int 80h

    mov eax, contents
    call slen

    test eax, eax
    jz .no_trim
    mov ebx, eax
    dec ebx
    mov bl, [contents + ebx]
    cmp bl, 10
    je .trim_ok
    cmp bl, 13
    jne .no_trim
.trim_ok:
    dec eax
.no_trim:

    mov edx, eax
    mov ecx, contents
    mov ebx, esi
    mov eax, 4
    int 80h

    mov eax, 4
    mov ebx, esi
    mov ecx, nl
    mov edx, 1
    int 80h

    mov ebx, esi
    mov eax, 6
    int 80h

    call quit
