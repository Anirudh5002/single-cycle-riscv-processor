.section .text
.globl _start

_start:

    addi x1, x0, 5
    addi x2, x0, 67

    add  x3, x1, x2
    sub  x4, x3, x1

    and  x5, x1, x2
    or   x6, x1, x2
    xor  x7, x1, x2

    andi x8, x2, 15

    sw   x3, 0(x0)
    lw   x9, 0(x0)

    beq  x9, x3, beq_taken

    addi x10, x0, 111

beq_taken:

    bne  x4, x3, bne_taken

    addi x11, x0, 222

bne_taken:

    jal  x12, jal_target

    addi x13, x0, 99

jal_target:

    addi x14, x0, 123

stop:
    jal  x0, stop
