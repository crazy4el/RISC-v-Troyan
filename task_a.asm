# Практическая работа по RISC-V. Группа 126, номер в списке 9.
# Задача а: вывести 1, если введённое x равно 9, иначе 0.
.eqv N 9

.text
.globl main
main:
    li a7, 5               # Прочитать целое число x в a0
    ecall

    li t0, N               # Номер студента
    beq a0, t0, equal      # Если x == N, перейти к equal

    li a0, 0               # Числа не совпали
    j print_result

equal:
    li a0, 1               # Числа совпали

print_result:
    li a7, 1               # Вывести результат из a0
    ecall

    li a0, 10              # Перевод строки
    li a7, 11
    ecall

    li a7, 10              # Завершить программу
    ecall
