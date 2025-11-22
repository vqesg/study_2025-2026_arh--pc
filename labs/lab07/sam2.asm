%include 'in_out.asm'

SECTION .data
msg_x   DB 'Введите x: ',0
msg_a   DB 'Введите a: ',0
msg_res DB 'Результат f(x): ',0

SECTION .bss
bufx RESB 80
bufa RESB 80
valx RESD 1
vala RESD 1

SECTION .text
GLOBAL _start

_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, bufx
    mov edx, 80
    call sread

    ; Ввод a
    mov eax, msg_a
    call sprint
    mov ecx, bufa
    mov edx, 80
    call sread

    ; преобразование x -> число
    mov eax, bufx
    call atoi
    mov [valx], eax

    ; преобразование a -> число
    mov eax, bufa
    call atoi
    mov [vala], eax

    ; условие: if x < a -> result = a + 10
    mov eax, [valx]    ; eax = x
    cmp eax, [vala]    ; compare x, a
    jl  less_than_a

    ; ветвь x >= a: result = x + 10
    mov eax, [valx]
    add eax, 10
    jmp print_result

less_than_a:
    mov eax, [vala]
    add eax, 10

print_result:
    ; печать результата
    mov edi, eax
    mov eax, msg_res
    call sprint
    mov eax, edi
    call iprintLF

    call quit