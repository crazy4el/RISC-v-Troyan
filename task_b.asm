# Практическая работа по RISC-V. Группа 126, номер в списке 9.
# Задача б: диапазон min(x,126)...max(x,126) с шагом 9.
.eqv N 9
.eqv Y 126

.text
.globl main
main:
    li a7, 5               # Прочитать x
    ecall
    mv t0, a0              # t0 = x
    li t1, Y               # t1 = y
    li t2, N               # t2 = h = 9

    bge zero, t2, finish   # Защита от неположительного шага
    bge t1, t0, bounds_ready  # Если y >= x, границы уже упорядочены

    mv t3, t0              # Обмен значений x и y
    mv t0, t1
    mv t1, t3

bounds_ready:              # t0 = min(x,y), t1 = max(x,y)
print_loop:
    blt t1, t0, finish     # Текущее число превысило верхнюю границу

    mv a0, t0
    li a7, 1               # Вывести текущее число
    ecall

    li a0, 32              # Пробел между числами
    li a7, 11
    ecall

    add t3, t0, t2         # Следующее число = текущее + 9
    blt t3, t0, finish     # Защита от знакового переполнения RV32
    mv t0, t3
    j print_loop

finish:
    li a0, 10              # Перевод строки
    li a7, 11
    ecall

    li a7, 10
    ecall
