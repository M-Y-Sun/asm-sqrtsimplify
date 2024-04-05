/* * * * * * * * * * * *
 * REGISTERS:
 * r0: input number to be divided
 * r1: input number to divide
 * r2: current sum
 * r3: counter
* * * * * * * * * * * */
.global div

.section .text

div:
	mov  r2, #0
	mov  r3, #0
	push {lr}

div_l:
	add r2, r2, r1
	cmp r2, r0
	bgt div_lex
	add r3, r3, #1
	b   div_l

div_lex:
	mov r0, r3
	pop {pc}

