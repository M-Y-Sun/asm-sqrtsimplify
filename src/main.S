/* * * * * * * * * * * * * * * * * * * * * * * *
 * REGISTERS
 * r0, r1, r2, r3: function & macro parameters
 * r4:  input number
 * r5:  remainder inside root
 * r6:  coefficient of root
 * r7:  sqrt of the greatest perfect square less than the number (loop counter)
 * r8:  number to divide
 * r9:  value of remainder / div
 * r10: value of modulus
 * * * * * * * * * * * * * * * * * * * * * * * */


.include "src/include/stdio.S"
.include "src/include/atoi.S"
.include "src/include/itoa.S"
.include "src/include/sqrt.S"
.include "src/include/div.S"

.global _start
.section .text

_start:
    stdout  intromsg        // print message
    stdin   innum, #8

    ldr     r0, =innum
    bl      atoi            // returns in r3
    mov     r4, r3
    
    mov     r5, r4
    mov     r6, #1

    mov     r0, r4
    bl      sqrt
    mov     r3, r7
lcompute:
    cmp     r7, #1
    blt     lcomputeex
    cmp     r5, #1
    beq     lcomputeex
    
    mul     r8, r7, r7
    // a % n = a - floor(a / n) * n
    mov     r0, r5
    mov     r1, r8
    bl      div             // r5 / r8
    mov     r3, r9
    mul     r10, r9, r8
    sub     r10, r5, r10
    cmp     r10, #0
    bne     lcompute
    mov     r5, r9          // r5 = r5 / r8
    mul     r6, r7
    b       lcompute
lcomputeex:
    mov     r7, #0x4
    mov     r0, #1
    ldr     r1, =sqrtsymbol
    mov     r2, #1
    swi     0

    mov     r0, r4
    ldr     r1, =innum
    bl      itoa
    stdout  innum
    
    ldr     r1, =eqsign
    mov     r2, #3
    swi     0

    cmp     r6, #1
    beq     noout
    cmp     r5, #1
    beq     noin

    mov     r0, r6
    ldr     r1, =innum
    bl      itoa
    stdout  innum
    
    ldr     r1, =sqrtsymbol
    mov     r2, #1
    swi     0

    mov     r0, r5
    ldr     r1, =innum
    bl      itoa
    stdout  innum

    mov     r1, #'\n'
    swi     0

    b       progex
noout:
    mov     r7, #0x4
    mov     r0, #1
    ldr     r1, =sqrtsymbol
    mov     r2, #1
    swi     0

    mov     r0, r5
    ldr     r1, =innum
    bl      itoa
    stdout  innum

    mov     r1, #'\n'
    swi     0
    
    b       progex
noin:
    mov     r0, r6
    ldr     r1, =innum
    stdout  innum

    mov     r7, #0x4
    mov     r0, #1
    mov     r1, #'\n'
    mov     r2, #1
    swi     0
progex:
    mov     r7, #0x1
    mov     r0, #0
    swi     0

.section .data
innum:      .fill   9   // 8 digits and newline

.section .rodata
intromsg:   .asciz  "sqrt of what number\n\t> "

errmsg:     .asciz  "invalid input: nonnegative integer expected\n"

eq0msg:     .asciz  "\u221a0 = 0\n"

eq1msg:     .asciz  "\u221a1 = 1\n"

sqrtsymbol: .asciz  "\u221a"

eqsign:     .asciz  " = "
