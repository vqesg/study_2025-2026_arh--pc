%include 'in_out.asm'

SECTION .data
msg_func    db 'Функция: f(x)=6*x+13',0h
msg_res     db 'Результат: ',0h

SECTION .text
global _start
_start:
    pop ecx          ; ecx := argc
    pop edx          ; edx := argv0 (имя программы)
    sub ecx, 1       ; ecx := кол-во реальных аргументов (без имени программы)

    mov esi, 0       ; esi — накопитель суммы (32-bit)

    cmp ecx, 0
    jz .print_result

.loop_args:
    pop eax          ; eax := адрес очередного аргумента (строка)
    push ecx         ; сохранить ecx (atoi/подпрограммы могут изменить ecx)
    call atoi        ; преобразование строки (по адресу в eax) -> result в eax
                     ; теперь eax = числовое значение x
    pop ecx          ; восстановить ecx

    call _f          ; вычислить f(x), вход в eax, результат в eax

    add esi, eax     ; esi += f(x)

    loop .loop_args  ; dec ecx; если !=0 -> переход к .loop_args

.print_result:
    mov eax, msg_func
    call sprintLF

    mov eax, msg_res
    call sprint

    mov eax, esi     ; результат в eax
    call iprintLF    ; печать результата с переводом строки

    call quit

_f:
    imul eax, 6      ; eax = eax * 6
    add eax, 13      ; eax = eax + 13
    ret