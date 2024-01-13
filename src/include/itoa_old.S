/* * * * * * * * * * * * * * *
 * REGISTERS:
 * r0: input num
 * r1: string buffer
 * * * * * * * * * * * * * * */

.include "src/include/pow.S"

.global itoa

.section .text
itoa: 
    push    {lr}
    mov     r4, r1          // load outstr address
    mov     r9, r1          // copy to r9 
    mov     r5, r0          // load number to process

    mov     r7, #9          // Initial power of 10 
    mov     r8, #0          // init loop counter 

    // find first power of ten to use
itoa_findstart:
    pow     #10, r7         // get cur power of ten 
    mov     r6, r0          // move pow result to r6 
    cmp     r6, r5          // compare 10^x to number to print 
    ble     itoa_finddigit  // if less than number, go to printing 
    sub     r7, #1          // if still bigger than num to print, 
                            // decrement pow and try again 
    b       itoa_findstart   
    // process number and print 
itoa_finddigit:
    cmp     r5, r6          // compare remaining number to 10^x 
    blt     itoa_write      // if less than, write digit 
    add     r8, r8, #1      // increment counter 
    sub     r5, r5, r6      // subtract 10^x from remaining and go again 
    b       itoa_finddigit 
itoa_write:
    add     r8, #'0'        // add counter to ASCII zero to get number 
    strb    r8, [r4], #1    // store in outstr and increment 

    // prepare next loop 
    sub     r7, #1          // subtract one from the counter
    cmp     r7, #0          // compare expo to 0 
    blt     itoa_ex         // if expo is zero, leave loop 
    pow     #10, r7         // get next power of ten 
    mov     r6, r0          // move 10^x into r6 
    mov     r8, #0          // reset loop counter 
    b       itoa_finddigit 
itoa_ex: 
    mov     r1, r9          // put address back in r1

    pop     {r4-r9, pc}     // restore registers 

