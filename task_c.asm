# Практическая работа по RISC-V. Группа 126, номер в списке 9.
# Задача в: массив из 16 + 9 = 25 целых чисел (25 * 4 = 100 байт).
# Ноль завершает ввод и не сохраняется в массиве.
.eqv N 9
.eqv ARRAY_BYTES 100

.data
.align 2
array:      .space ARRAY_BYTES
count:      .word 0
count_msg:  .asciz "Count: "
array_msg:  .asciz "Array: "

.text
.globl main
main:
    la t0, array           # Адрес следующего свободного элемента
    li t1, N
    addi t1, t1, 16        # Вместимость: 16 + 9 = 25
    li t2, 0               # Количество сохранённых элементов

read_loop:
    bge t2, t1, read_done  # После 25 элементов больше не читать

    li a7, 5               # Прочитать одно целое число
    ecall
    beq a0, zero, read_done  # Ноль — сигнал завершения ввода

    sw a0, 0(t0)           # Сохранить число в текущем элементе
    addi t0, t0, 4         # Следующий элемент: смещение на 4 байта
    addi t2, t2, 1         # Увеличить счётчик элементов
    j read_loop

read_done:
    la t3, count
    sw t2, 0(t3)           # Сохранить длину заполненной части в памяти

    # Вывести количество и содержимое для проверки заполнения.
    la a0, count_msg
    li a7, 4
    ecall
    mv a0, t2
    li a7, 1
    ecall
    li a0, 10
    li a7, 11
    ecall

    la a0, array_msg
    li a7, 4
    ecall

    la t0, array           # Адрес первого элемента
    li t3, 0               # Индекс выводимого элемента

print_loop:
    bge t3, t2, finish     # Выводить только сохранённые элементы
    lw a0, 0(t0)           # Прочитать элемент из памяти
    li a7, 1
    ecall
    li a0, 32              # Пробел между числами
    li a7, 11
    ecall
    addi t0, t0, 4
    addi t3, t3, 1
    j print_loop

finish:
    li a0, 10              # Перевод строки
    li a7, 11
    ecall
    li a7, 10
    ecall
