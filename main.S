// REGISTERS
// r0, r1, r2, r3: function & macro parameters

.include "stdio.S"
.include "atoi.S"

.global _start
.section .text

_start:
    stdout  intromsg        // print message
    stdin   innum, #8

    ldr     r0, =innum
    bl      atoi            // result is pushed onto the stack

    pop     {r0}
    
progex:
    mov     r7, #0x1
    mov     r0, #0
    swi     0

.section .data
intromsg:   .asciz  "sqrt of what number\n\t> "

errmsg:     .asciz  "invalid input: nonnegative integer expected\n"

eq0msg:     .asciz  "\u221a0 = 0\n"

eq1msg:     .asciz  "\u221a1 = 1\n"

innum:      .fill   9
