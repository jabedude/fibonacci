	extern	printf
	extern	puts
	extern	putchar
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

	call	display_fib		; DEBUG
	
	mov	rbx, 1			; Fibonacci loop
Loop:
	mov	rax, qword [one]
	add	qword [two], rax
	adc	qword [two+8], 

	inc	rbx
	cmp	rbx, [num]
	jne	Loop

	xor	rax, rax		; Return value 0

Exit:
	pop	r15
	ret

display_fib:
	mov	rdi, Fib_format
	mov	rsi, [fib_num+24]
	mov	rdx, [fib_num+16]
	mov	rcx, [fib_num+8]
	mov	r8,  [fib_num]
	xor	rax, rax
	call	printf
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

Fib_format:
	db "fib_number+24=%016llx fib_number+16=%016llx fib_number+8=%016llx fib_number=%016llx", 10, 0

fib_num:
	dq 0xdeadbeefffffffff
	dq 0
	dq 0
	dq 0

one:
	dq 0
	dq 0
	dq 0
	dq 0
	
two:
	dq 1
	dq 0
	dq 0
	dq 0

	section .bss
tmp:		resq	1
num:		resq	1
