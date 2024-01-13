/* * * * * * * * * * * * * * *
 * REGISTERS:
 * r0: PARAM: input string
 * r1: final result
 * r2: input string pointer
 * r3: counter
 *
 * RETURN:
 * push r0 on the stack
 *
 * ALGORITHM (PDL):
 * numstr = "58666"
 * int num = 0;
 * cnt = 0
 * byte = index 0 or numstr
 * DO WHILE bit is not equal to ascii 0 (null byte)
 *     num = num * 10 + byte - 48
 * END DO
 * * * * * * * * * * * * * */

.global atoi

.section .text
atoi:
    push    {lr}                // save return address

    mov     r1, #0              // final result
atoi_l:
    ldrb    r2, [r0], #1        // char
    cmp     r2, #0xa            // newline ('\n') means end of input
    beq     atoi_lex
    push    {r0}
    bl      atoi_mul10
    pop     {r0}
    add     r1, r2
    sub     r1, #48
    b       atoi_l
atoi_lex:
    mov     r0, r1              // returns in r4
    pop     {pc}                // return
atoi_mul10:                     // multiplies the number in r1 by 10
    mov     r0, r1, lsl #3
    lsl     r1, #1
    add     r1, r0
    bx      lr

