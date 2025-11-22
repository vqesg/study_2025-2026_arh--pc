; Наименьшее из A,B,C для варианта 15 (A=32, B=6, C=54)

%include 'in_out.asm'

SECTION .data
A dd 32
B dd 6
C dd 54
msg DB 'Наименьшее из A,B,C: ',0

SECTION .bss
minv RESD 1

SECTION .text
GLOBAL _start

_start:
    ; Сначала min = A
    mov eax, [A]
    mov [minv], eax

    ; сравнение min и B
    cmp eax, [B]
    jle check_C
    mov eax, [B]
    mov [minv], eax

check_C:
    cmp eax, [C]
    jle print_min
    mov eax, [C]
    mov [minv], eax

print_min:
    mov eax, msg
    call sprint
    mov eax, [minv]
    call iprintLF

    call quit