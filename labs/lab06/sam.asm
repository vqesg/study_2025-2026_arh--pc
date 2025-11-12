;--------------------------------
; Программа вычисления выражения
;--------------------------------
%include 'in_out.asm' ; подключение внешнего файла

SECTION .data
msg1: DB 'Вычисление выражения: f(x) = (5 + x)^2 - 3',0
msg2: DB 'Введите значение x: ',0
msg3: DB 'Результат: ',0

SECTION .bss
x: RESB 80 ; буфер для ввода

SECTION .text
GLOBAL _start

_start:
    ; ---- Вывод выражения ----
    mov eax, msg1
    call sprintLF

    ; ---- Ввод x ----
    mov eax, msg2
    call sprint
    mov ecx, x
    mov edx, 80
    call sread

    mov eax, x
    call atoi        ; преобразование строки в число, результат в EAX

    ; ---- Вычисление f(x) = (5 + x)^2 - 3 ----
    add eax, 5       ; EAX = 5 + x
    mov ebx, eax     ; EBX = (5 + x)
    mul ebx          ; EAX = (5 + x)^2
    sub eax, 3       ; EAX = (5 + x)^2 - 3
    mov edi, eax     ; сохранить результат

    ; ---- Вывод результата ----
    mov eax, msg3
    call sprint
    mov eax, edi
    call iprintLF

    ; ---- Завершение ----
    call quit