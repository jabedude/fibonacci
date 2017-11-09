	extern	printf
	extern	puts
	extern	strtoul
	global	main			; global entry point

	section	.text
main:
	push	r15			; Command line number check
	mov	r15, rsi
	cmp	edi, 2
	jne	fib_usage

	mov	rdi, [r15 + 8]		; Convert the argument
	xor	rsi, rsi
	mov	rdx, 10
	call	strtoul
	mov	qword[num], rax

	mov	qword[tmp], rsi		; Print the argument
	mov	rdi, Echo
	mov	rsi, [num]
	xor	rax, rax
	call	printf
	mov	rsi, qword[tmp]

	xor	rax, rax		; Return value 0

Exit:
	pop	r15
	ret


fib_usage:
	mov	rdi, Usage
	xor	rax, rax
	call	puts
	mov	rax, 1
	jmp	Exit



	section	.data
Echo:
	db "Arg is: %d", 10, 0

Usage:
	db "./fibonacci <number>", 10, 0
	

	section .bss
tmp:		resq	1
num:		resq	1
