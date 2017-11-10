	extern	printf
	global	main			; global entry point

	section	.text
main:
	push	r15			; Command line number check
	mov	r15, rsi
	cmp	edi, 2
	jne	Fib_usage

	push	rsi			; Convert input from string
	mov	rsi, [r15+8]
	call	Atoi
	pop	rsi
	mov	qword[input], rax

	cmp	qword[input], 1		; Handle inputs less than 2
	jle	Edge_fib

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
	cmp	ecx, [input]		; Check if counter equals input
	jne	Loop
	call	Display_fib

	xor	rax, rax		; Return value 0

Exit:
	pop	r15
	ret

Edge_fib:
	mov	r14, [input]
	cmp	r14, 0			; Check if input is negative
	jl	Fib_usage
	mov	[fib_num], r14
	call	Display_fib
	jmp	Exit

Display_fib:
	mov	rdi, ans_format
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
	mov	rdx, usage_len		; Set up for the system call
	mov	rcx, usage_msg
	mov	rbx, 1
	mov	rax, 4			; sys_write sys call
	int	0x80
	mov	rax, 1			; Return 1
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

Atoi:
	push	rbx			; Save registers
	push	rdx
	push	rsi

	xor	rax, rax

	Nxt_char:
		mov	rbx, 0
		mov	bl, [rsi]
		inc	rsi

		cmp	bl, '0'
		jb	Inval
		cmp	bl, '9'
		ja	Inval

		sub	bl, '0'
		mov	r14, 10
		mul	r14
		add	rax, rbx
		jmp	Nxt_char

	Inval:
		pop	rsi
		pop	rdx
		pop	rbx
		ret


	section	.data
usage_msg	db "./fibonacci <number 0-500>", 10, 0

usage_len	equ $ - usage_msg

ans_format	db "0x%016llx%016llx%016llx%016llx%016llx%016llx", 10, 0

fib_num		dq 0,0,0,0,0,0

one		dq 0,0,0,0,0,0
	
two		dq 1,0,0,0,0,0

	section .bss
tmp:		resq	1
tmp2:		resd	1
tmp3:		resq	1
input:		resq	1
