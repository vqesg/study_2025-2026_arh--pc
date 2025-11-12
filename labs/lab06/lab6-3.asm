;--------------------------------
; Программа вычисления выражения f(x) = (4 * 6 + 2) / 5
;--------------------------------

%include 'in_out.asm' ; подключение внешнего файла

SECTION .data
div: DB 'Результат: ',0
rem: DB 'Остаток от деления: ',0

SECTION .text
GLOBAL _start

_start:
    ; ---- Вычисление выражения ----
    mov eax,4       ; EAX = 4
    mov ebx,6       ; EBX = 6
    mul ebx         ; EAX = 4 * 6 = 24

    add eax,2       ; EAX = 24 + 2 = 26

    xor edx,edx     ; Обнуляем EDX перед делением
    mov ebx,5       ; EBX = 5
    div ebx         ; EAX = 26 / 5 = 5, EDX = 1 (остаток)

    mov edi,eax     ; Сохраняем результат в EDI

    ; ---- Вывод результата ----
    mov eax,div
    call sprint     ; Печать "Результат: "

    mov eax,edi
    call iprintLF   ; Печать результата (5)

    mov eax,rem
    call sprint     ; Печать "Остаток от деления: "

    mov eax,edx
    call iprintLF   ; Печать остатка (1)

    call quit       ; Завершение программы