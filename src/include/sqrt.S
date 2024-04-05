/* * * * * * * * * * * * * * *
 * REGISTERS:
 * r0: input number
 * r1: counter
 * r2: square of counter
 * r3: number to return
* * * * * * * * * * * * * * */
.global sqrt

.section .text

sqrt:
	push {lr}

	cmp   r0, #0
	moveq r3, #0
	movlt r3, #-1
	ble   sqrt_ret
	cmp   r0, #1
	moveq r3, #1
	beq   sqrt_ret

	mov r1, #2

sqrt_l:
	mul r2, r1, r1
	cmp r2, r0
	bgt sqrt_lex
	add r1, #1
	b   sqrt_l

sqrt_lex:
	sub r1, #1
	mov r3, r1

sqrt_ret:
	mov r0, r3
	pop {pc}

