/* * * * * * * * * * * *
 * REGISTERS:
 * r0: input number to be divided
 * r1: input number to divide
 * r2: current product
 * r3: counter
 * * * * * * * * * * * */

.global div
.section .text

div:
    push    {lr}
lmul:
    mul     r2, r1, r3
    cmp     r2, r0
    bgt     lmulex
    add     r3, r3, #1
    b       lmul
lmulex:
    sub     r3, r3, #1
    pop     {lr}
    push    {r3}
    bx      lr

