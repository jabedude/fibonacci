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
	
	mov	ecx, 1			; Fibonacci loop
	xor	ebx, ebx
Loop:
	cmp	ebx, 0
	jne	Switch
	mov	ebx, 1
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
	jmp	Move

Switch:
	xor	ebx, ebx
	mov	rax, qword [one]
	add	qword [two], rax
	mov	rax, qword [one+8]
	adc	qword [two+8], rax
	mov	rax, qword [one+16]
	adc	qword [two+16], rax
	mov	rax, qword [one+24]
	adc	qword [two+24], rax
	mov	rax, qword [one+32]
	adc	qword [two+32], rax
	mov	rax, qword [one+40]
	adc	qword [two+40], rax

Move:
	mov	dword[tmp2], ecx
	mov	qword[tmp], rsi		; Print the fib number
	call	display_fib
	mov	ecx, dword[tmp2]
	mov	rsi, qword[tmp]
	inc	ecx
	cmp	ecx, [num]
	jne	Loop

	xor	rax, rax		; Return value 0

Exit:
	pop	r15
	ret

display_fib:
	mov	rdi, Ans_format
	mov	rsi, [two+40]
	mov	rdx, [two+32]
	mov	rcx, [two+24]
	mov	r8,  [two+16]
	mov	r9,  [two+8]
	push	qword [two]
	xor	rax, rax
	call	printf
	pop	qword [two]
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
	db "fib_num+40=%016llx fib_num+32=%016llx fib_num+24=%016llx fib_num+16=%016llx fib_num+8=%016llx fib_num=%016llx", 10, 0

Ans_format:
	db "%016llx%016llx%016llx%016llx%016llx%016llx", 10, 0

fib_num:
	dq 0xdeadbeefffffffff
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
num:		resq	1
