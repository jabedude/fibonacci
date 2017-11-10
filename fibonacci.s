	extern	printf
	extern	puts
	extern	strtoul
	global	main			; global entry point

	section	.text
main:
	push	r15			; Command line number check
	mov	r15, rsi
	cmp	edi, 2
	jne	Fib_usage

	mov	rdi, [r15 + 8]		; Convert the argument
	xor	rsi, rsi
	mov	rdx, 10
	call	strtoul
	mov	qword[input], rax

	cmp	qword[input], 0		; Handle input of 0
	je	Edge_fib
	cmp	qword[input], 1		; Handle input of 1
	je	Edge_fib

	mov	qword[tmp], rsi		; Print the argument
	mov	rdi, Echo
	mov	rsi, [input]
	xor	rax, rax
	call	printf
	mov	rsi, qword[tmp]

	mov	ecx, 1			; Fibonacci loop
Loop:
	mov	rax, qword [two]
	add	qword [one], rax
	mov	rax, qword [two+8]
	adc	qword [one+8], rax
	mov	rax, qword [two+16]
	adc	qword [one+16], rax
	mov	rax, qword [two+24]
	adc	qword [one+24], rax
	mov	rax, qword [two+32]
	adc	qword [one+32], rax
	mov	rax, qword [two+40]
	adc	qword [one+40], rax

	mov	dword[tmp2], ecx
	mov	dword[tmp3], ebx
	mov	qword[tmp], rsi		; Print the fib number
	call	Copy_next
	mov	ecx, dword[tmp2]
	mov	ebx, dword[tmp3]
	mov	rsi, qword[tmp]
	inc	ecx
	cmp	ecx, [input]
	jne	Loop
	call	Display_fib

	xor	rax, rax		; Return value 0

Exit:
	pop	r15
	ret

Edge_fib:
	mov	r14, [input]
	mov	[fib_num], r14
	call	Display_fib
	jmp	Exit

Display_fib:
	mov	rdi, Ans_format
	mov	rsi, [fib_num+40]
	mov	rdx, [fib_num+32]
	mov	rcx, [fib_num+24]
	mov	r8,  [fib_num+16]
	mov	r9,  [fib_num+8]
	push	qword [fib_num]
	xor	rax, rax
	call	printf
	pop	qword [fib_num]
	ret

Fib_usage:
	mov	rdi, Usage
	xor	rax, rax
	call	puts
	mov	rax, 1
	jmp	Exit

Copy_next:
	push	rax			; Save rax
	mov	rax, [one+40]		; fib_num = one
	mov	[fib_num+40], rax
	mov	rax, [one+32]
	mov	[fib_num+32], rax
	mov	rax, [one+24]
	mov	[fib_num+24], rax
	mov	rax, [one+16]
	mov	[fib_num+16], rax
	mov	rax, [one+8]
	mov	[fib_num+8], rax
	mov	rax, [one]
	mov	[fib_num], rax

	mov	rax, [two+40]		; one = two
	mov	[one+40], rax
	mov	rax, [two+32]
	mov	[one+32], rax
	mov	rax, [two+24]
	mov	[one+24], rax
	mov	rax, [two+16]
	mov	[one+16], rax
	mov	rax, [two+8]
	mov	[one+8], rax
	mov	rax, [two]
	mov	[one], rax

	mov	rax, [fib_num+40]	; two = fib_num
	mov	[two+40], rax
	mov	rax, [fib_num+32]
	mov	[two+32], rax
	mov	rax, [fib_num+24]
	mov	[two+24], rax
	mov	rax, [fib_num+16]
	mov	[two+16], rax
	mov	rax, [fib_num+8]
	mov	[two+8], rax
	mov	rax, [fib_num]
	mov	[two], rax

	pop	rax			; restore rax
	ret

	section	.data
Echo:
	db "Arg is: %d", 10, 0

Usage:
	db "./fibonacci <number>", 10, 0

Ans_format:
	db "0x%016llx%016llx%016llx%016llx%016llx%016llx", 10, 0

fib_num:
	dq 0
	dq 0
	dq 0
	dq 0
	dq 0
	dq 0

one:
	dq 0
	dq 0
	dq 0
	dq 0
	dq 0
	dq 0
	
two:
	dq 1
	dq 0
	dq 0
	dq 0
	dq 0
	dq 0

	section .bss
tmp:		resq	1
tmp2:		resd	1
tmp3:		resq	1
input:		resq	1
