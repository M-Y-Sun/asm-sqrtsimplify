/* * * * * * * * * * * * * * * * * * * * * * * *
 * REGISTERS:
 * r0: input string address
 * r1: input string pointer/iterator for length
 * r2: each character of input string
 * r3: length of input string
 * r7: syscall number
* * * * * * * * * * * * * * * * * * * * * * * */
.macro stdout      str
ldr    r0, =\str
mov    r1, r0

1:
	ldrb r2, [r1]
	cmp  r2, #0
	beq  2f
	add  r1, #1
	b    1b

2:
	sub r3, r1, r0

	mov r7, #0x4
	mov r0, #1
	ldr r1, =\str
	mov r2, r3
	swi 0
	.endm

	.macro stderr      str
	ldr    r0, =\str
	mov    r1, r0

1:
	ldrb r2, [r1]
	cmp  r2, #0
	beq  2f
	add  r1, #1
	b    1b

2:
	sub r3, r1, r0

	mov r7, #0x4
	mov r0, #2
	ldr r1, =\str
	mov r2, r3
	swi 0
	.endm

/* * * * * * * * * * * * * * * * * * * * * * * *
 * REGISTERS:
 * r0: stdin file descriptor (#0)
 * r1: buffer
 * r2: buffer length
 * r7: syscall number
* * * * * * * * * * * * * * * * * * * * * * * */
	.macro stdin       buf     bufsize
	mov    r7, #0x3
	mov    r0, #0
	ldr    r1, =\buf
	ldr    r2, =\bufsize
	swi    0
	.endm
