.macro      pow     base, exp 
    mov     r0, \base   // load base 
    mov     r1, \exp    // load expo
    cmp     r1, #0      // see if expo is zero 
    moveq   r2, #1      // if yes, total will be 1 
    beq     2f
    mov     r2, r0      // copy base to total
    sub     r1, #1      // sub one off expo because we copied base 
1: 
    cmp     r1, #0      // test if we need to multiply again 
    ble     2f          // leave if eq or less than 0 
    mul     r2, r0 ,r2  // multiply total by base and store in total 
    sub     r1, #1      // decrement expo 
    b       1b 
2:
    mov     r0, r2      // move result to r0
.endm

