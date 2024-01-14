/* * * * * * * * * * * * * * *
 * REGISTERS:
 * r0: input num
 * r1: string buffer
 * r2: modified buffer copy
 * r3: power of 10
 * r4: loop counter
 * r5: cur power of 10
 * * * * * * * * * * * * * * */

.include "src/include/pow.S"

.global itoa

.section .text
itoa: 
    push    {r4, r5, lr}
    mov     r2, r1
    mov     r3, #9          // initial power of 10 
    mov     r4, #0
itoa_lstart:                // find first power of 10 to use
    push    {r0-r3}
    pow     #10, r3         // get cur power of ten (10^r3)
    mov     r5, r0
    pop     {r0-r3}
    cmp     r5, r0
    ble     itoa_finddigit  // if less than number, go to printing
    sub     r3, #1          // if still bigger than num to print, decr r3 and try again
    b       itoa_lstart   
itoa_finddigit:
    cmp     r0, r5
    blt     itoa_write      // if less than, write digit 
    add     r4, r4, #1      // increment counter 
    sub     r0, r0, r5
    b       itoa_finddigit 
itoa_write:
    add     r4, #'0'        // add counter to ASCII zero (not null) to get number 
    strb    r4, [r2], #1    // store in outstr and increment 

    // prepare next loop 
    sub     r3, #1
    cmp     r3, #0
    blt     itoa_ex         // if exp is zero, leave loop 
    pow     #10, r3
    mov     r5, r0          // move 10^x into r6 
    mov     r4, #0          // reset loop counter 
    b       itoa_finddigit 
itoa_ex: 
    mov     r1, r2

    pop     {r4, r5, pc}

