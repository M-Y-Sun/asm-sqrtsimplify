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
	stdout intromsg  // print message
	stdin  innum, #8

	ldr r0, =innum
	bl  atoi       // returns in r0
	mov r4, r0

	// check for invalid input
	cmp r4, #1
	beq eq1
	cmp r4, #0
	beq eq0
	blt err

	mov r5, r4
	mov r6, #1
	mov r0, r4
	bl  sqrt
	mov r7, r0
	add r7, #1 // incr so it can be decr at the beginning

lcompute:
	sub r7, r7, #1 // decr r7 at the beginning for simplicity
	cmp r7, #1
	ble lcomputeex
	cmp r5, #1
	beq lcomputeex

	mul r8, r7, r7

	// a % n = a - floor(a / n) * n
	mov r0, r5
	mov r1, r8
	bl  div          // r5 / r8
	mov r9, r0
	mul r10, r9, r8
	sub r10, r5, r10
	cmp r10, #0
	bne lcompute
	mov r5, r9       // r5 = r5 / r8
	mul r6, r7
	b   lcompute

lcomputeex:
	stdout eqsign

	cmp r6, #1
	beq noout
	cmp r5, #1
	beq noin

	mov    r0, r6
	ldr    r1, =outbuf
	bl     itoa
	stdout outbuf

	stdout sqrtchar

	mov    r0, r5
	ldr    r1, =inbuf
	bl     itoa
	stdout inbuf

	b prmex

noout:
	stdout sqrtchar
	mov    r0, r5
	ldr    r1, =inbuf
	bl     itoa
	stdout inbuf
	b      prmex

noin:
	mov    r0, r6
	ldr    r1, =outbuf
	bl     itoa
	stdout outbuf
	b      prmex

err:
	stdout errmsg
	mov    r7, #0x1
	mov    r0, #1
	swi    0

	// program should not reach this point without a branch
eq1:
	stdout eq1msg
	b      prmex

eq0:
	stdout eq0msg

prmex:
	stdout newline

	mov r7, #0x1
	mov r0, #0
	swi 0

	.section .data

innum:
	.fill 9 // 8 digits and newline

inbuf:
	.fill 8 // number inside root

outbuf:
	.fill 8 // coefficient of root

	.section .rodata

intromsg:
	.asciz "sqrt of what number\n\t> "

errmsg:
	.asciz "invalid input: nonnegative integer expected\n"

eq0msg:
	.asciz "= 0"

eq1msg:
	.asciz "= 1"

sqrtchar:
	.asciz "sqrt"

eqsign:
	.asciz "= "

newline:
	.asciz "\n"

