	.file	"solver_vect_openmp.c"
	.text
	.p2align 4
	.type	set_bnd.constprop.0, @function
set_bnd.constprop.0:
.LFB5516:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%ecx, %r9d
	leal	-1(%rsi), %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %r14d
	movq	%r15, %rcx
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	shrq	%r15
	leal	-2(%rdi), %r8d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%esi, %r12d
	shrq	%r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%r14, %rbp
	imulq	%r12, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	leal	-2(%rsi), %edx
	movq	%rdx, %r13
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	shrq	%rdx
	testl	%r9d, %r9d
	jne	.L2
	testl	%r13d, %r13d
	je	.L9
	movl	$1, %edi
	vmovss	.LC0(%rip), %xmm1
	.p2align 4,,10
	.p2align 3
.L4:
	movl	%edi, %r9d
	movl	%edi, %r10d
	andl	$1, %r9d
	notl	%r10d
	imulq	%rbp, %r9
	andl	$1, %r10d
	movl	%edi, %eax
	imulq	%rbp, %r10
	shrq	%rax
	addq	%rax, %r9
	addq	%r12, %rax
	addq	%r10, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	incl	%edi
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%r9,4)
	cmpl	%r13d, %edi
	jbe	.L4
	movq	%rdx, %r10
.L3:
	leaq	1(%r14), %rax
	imulq	%r12, %rax
	vmovss	.LC1(%rip), %xmm1
	leaq	(%r12,%r15), %r9
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%esi, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	vaddss	(%rbx,%rbp,4), %xmm0, %xmm0
	movl	%ecx, %edi
	addq	%rax, %r9
	movl	%esi, %eax
	vmulss	%xmm1, %xmm0, %xmm0
	andl	$1, %eax
	imulq	%r12, %rax
	andl	$1, %edi
	imulq	%rbp, %rdi
	imulq	%r14, %rax
	vmovss	%xmm0, (%rbx)
	vmovss	(%rbx,%r9,4), %xmm0
	addq	%r10, %rax
	vaddss	(%rbx,%rax,4), %xmm0, %xmm0
	addq	%r15, %rdi
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdi,4)
.L6:
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L5:
	movl	%esi, %eax
	notl	%eax
	andl	$1, %eax
	imulq	%r14, %rax
	movl	%esi, %r9d
	movq	%r9, %rdi
	addq	%r9, %rax
	imulq	%r12, %rax
	imulq	%r12, %rdi
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%esi, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%rdi,%rdx), %r9
	addq	%rdi, %rax
	vmovss	%xmm0, (%rbx,%rax,4)
	movl	%esi, %eax
	xorl	%r13d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	addq	%r15, %rdi
	addq	%r9, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%esi, %eax
	xorl	%ecx, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	incl	%esi
	addq	%rax, %rdi
	vmovss	%xmm0, (%rbx,%rdi,4)
	cmpl	%r8d, %esi
	jbe	.L5
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	.cfi_restore_state
	movl	%r9d, 28(%rsp)
	movl	%edi, 16(%rsp)
	movq	%rdx, 8(%rsp)
	movl	%r8d, (%rsp)
	movl	%ecx, 24(%rsp)
	call	omp_get_num_threads@PLT
	movl	28(%rsp), %r9d
	decl	%eax
	cmpl	%eax, %r9d
	movl	24(%rsp), %ecx
	movl	(%rsp), %r8d
	movq	8(%rsp), %rdx
	movl	16(%rsp), %edi
	jne	.L6
	movl	%r8d, %esi
	leal	-1(%rdi), %r11d
	movq	%rsi, 8(%rsp)
	movl	%r11d, 24(%rsp)
	testl	%r13d, %r13d
	je	.L10
	movl	%ecx, (%rsp)
	movq	%rdx, 16(%rsp)
	movl	$1, %r9d
	vmovss	.LC0(%rip), %xmm1
	movl	%r11d, %ecx
	movq	%rsi, %rdx
	.p2align 4,,10
	.p2align 3
.L8:
	movl	%r9d, %esi
	xorl	%r8d, %esi
	andl	$1, %esi
	movl	%r9d, %eax
	imulq	%r14, %rsi
	xorl	%ecx, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	addq	%rdx, %rsi
	imulq	%r12, %rsi
	movl	%r9d, %r10d
	shrq	%r10
	addq	%r11, %rax
	imulq	%r12, %rax
	addq	%r10, %rsi
	vmovss	(%rbx,%rsi,4), %xmm0
	addq	%r10, %rax
	vxorps	%xmm1, %xmm0, %xmm0
	incl	%r9d
	vmovss	%xmm0, (%rbx,%rax,4)
	cmpl	%r13d, %r9d
	jbe	.L8
	movq	16(%rsp), %rdx
	movl	(%rsp), %ecx
	movl	24(%rsp), %r10d
	movq	%rdx, (%rsp)
	xorl	%r13d, %r10d
.L7:
	movl	24(%rsp), %eax
	leaq	0(,%r12,4), %rsi
	andl	$1, %eax
	imulq	%r14, %rax
	movq	%r11, %r9
	vmovss	.LC1(%rip), %xmm1
	addq	%r11, %rax
	imulq	%rsi, %rax
	imulq	%r12, %r9
	andl	$1, %r10d
	movq	%rax, 16(%rsp)
	movl	%edi, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	andl	$1, %edi
	imulq	%r14, %rdi
	addq	%r11, %rax
	movq	8(%rsp), %r11
	imulq	%rsi, %rax
	addq	%r11, %rdi
	imulq	%rsi, %rdi
	vmovss	(%rbx,%rax), %xmm0
	movl	24(%rsp), %eax
	vaddss	(%rbx,%rdi), %xmm0, %xmm0
	xorl	%ecx, %eax
	andl	$1, %eax
	vmulss	%xmm1, %xmm0, %xmm0
	imulq	%rbp, %rax
	movq	16(%rsp), %rsi
	imulq	%rbp, %r10
	movq	(%rsp), %rdi
	vmovss	%xmm0, (%rbx,%rsi)
	leaq	(%r9,%r15), %rsi
	addq	%rax, %rsi
	movl	%ecx, %eax
	xorl	%r8d, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	addq	%r9, %rdi
	addq	%r10, %rdi
	addq	%r11, %rax
	imulq	%r12, %rax
	addq	%r15, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	vaddss	(%rbx,%rdi,4), %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rsi,4)
	jmp	.L6
.L9:
	xorl	%r10d, %r10d
	jmp	.L3
.L10:
	movq	$0, (%rsp)
	movl	%r11d, %r10d
	jmp	.L7
	.cfi_endproc
.LFE5516:
	.size	set_bnd.constprop.0, .-set_bnd.constprop.0
	.p2align 4
	.type	set_bnd.constprop.1, @function
set_bnd.constprop.1:
.LFB5517:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%ecx, %r9d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%esi, %r12d
	movq	%r12, %r8
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leal	-1(%r8), %r15d
	shrq	%r12
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%r14, %rbp
	movq	%rdx, %rbx
	leal	-2(%r8), %edx
	movq	%r15, %rcx
	movq	%rdx, %r13
	imulq	%r12, %rbp
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	shrq	%r15
	leal	-2(%rdi), %esi
	shrq	%rdx
	testl	%r9d, %r9d
	jne	.L17
	testl	%r13d, %r13d
	je	.L24
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L19:
	movl	%eax, %edi
	notl	%edi
	andl	$1, %edi
	movl	%eax, %r9d
	imulq	%rbp, %rdi
	shrq	%r9
	leaq	(%r9,%r12), %r10
	addq	%r10, %rdi
	vmovss	(%rbx,%rdi,4), %xmm0
	movl	%eax, %edi
	andl	$1, %edi
	imulq	%rbp, %rdi
	incl	%eax
	addq	%r9, %rdi
	vmovss	%xmm0, (%rbx,%rdi,4)
	cmpl	%r13d, %eax
	jbe	.L19
	movq	%rdx, %r10
.L18:
	leaq	1(%r14), %rax
	imulq	%r12, %rax
	vmovss	.LC1(%rip), %xmm1
	leaq	(%r12,%r15), %r9
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%r8d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	vaddss	(%rbx,%rbp,4), %xmm0, %xmm0
	movl	%ecx, %edi
	addq	%rax, %r9
	movl	%r8d, %eax
	vmulss	%xmm1, %xmm0, %xmm0
	andl	$1, %eax
	imulq	%r12, %rax
	andl	$1, %edi
	imulq	%rbp, %rdi
	imulq	%r14, %rax
	vmovss	%xmm0, (%rbx)
	vmovss	(%rbx,%r9,4), %xmm0
	addq	%r10, %rax
	vaddss	(%rbx,%rax,4), %xmm0, %xmm0
	addq	%r15, %rdi
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdi,4)
.L21:
	xorl	%edi, %edi
	vmovss	.LC0(%rip), %xmm1
	.p2align 4,,10
	.p2align 3
.L20:
	movl	%edi, %eax
	notl	%eax
	andl	$1, %eax
	imulq	%r14, %rax
	movl	%edi, %r10d
	movl	%edi, %r9d
	addq	%r10, %rax
	imulq	%r12, %rax
	movq	%r10, %r8
	andl	$1, %r9d
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%edi, %eax
	imulq	%r12, %r8
	imulq	%rbp, %r9
	xorl	%ecx, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	addq	%r8, %r9
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%r9,4)
	leaq	(%r8,%r15), %r9
	addq	%rax, %r9
	movl	%edi, %eax
	xorl	%r13d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	addq	%rdx, %r8
	incl	%edi
	addq	%rax, %r8
	vmovss	(%rbx,%r8,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%r9,4)
	cmpl	%esi, %edi
	jbe	.L20
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L17:
	.cfi_restore_state
	movl	%r9d, 28(%rsp)
	movl	%edi, 16(%rsp)
	movq	%rdx, 8(%rsp)
	movl	%esi, (%rsp)
	movl	%ecx, 24(%rsp)
	call	omp_get_num_threads@PLT
	movl	28(%rsp), %r9d
	decl	%eax
	cmpl	%eax, %r9d
	movl	24(%rsp), %ecx
	movl	(%rsp), %esi
	movq	8(%rsp), %rdx
	movl	16(%rsp), %edi
	jne	.L21
	leal	-1(%rdi), %r10d
	movl	%r10d, 24(%rsp)
	movl	%esi, %r11d
	testl	%r13d, %r13d
	je	.L25
	movq	%rdx, (%rsp)
	movl	$1, %r8d
	movl	%r10d, %edx
	.p2align 4,,10
	.p2align 3
.L23:
	movl	%r8d, %eax
	xorl	%esi, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	movl	%r8d, %r9d
	shrq	%r9
	addq	%r11, %rax
	imulq	%r12, %rax
	addq	%r9, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%r8d, %eax
	xorl	%edx, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	incl	%r8d
	addq	%r10, %rax
	imulq	%r12, %rax
	addq	%r9, %rax
	vmovss	%xmm0, (%rbx,%rax,4)
	cmpl	%r13d, %r8d
	jbe	.L23
	movl	24(%rsp), %eax
	movq	(%rsp), %rdx
	xorl	%r13d, %eax
	movl	%eax, (%rsp)
	movq	%rdx, 8(%rsp)
.L22:
	movl	24(%rsp), %eax
	leaq	0(,%r12,4), %r8
	andl	$1, %eax
	imulq	%r14, %rax
	vmovss	.LC1(%rip), %xmm1
	movq	%r10, %r9
	addq	%r10, %rax
	imulq	%r8, %rax
	imulq	%r12, %r9
	movq	%rax, 16(%rsp)
	movl	%edi, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	andl	$1, %edi
	imulq	%r14, %rdi
	addq	%r10, %rax
	imulq	%r8, %rax
	addq	%r11, %rdi
	imulq	%r8, %rdi
	vmovss	(%rbx,%rax), %xmm0
	movl	24(%rsp), %eax
	vaddss	(%rbx,%rdi), %xmm0, %xmm0
	xorl	%ecx, %eax
	andl	$1, %eax
	vmulss	%xmm1, %xmm0, %xmm0
	imulq	%rbp, %rax
	movq	16(%rsp), %rdi
	movl	(%rsp), %r10d
	movq	8(%rsp), %r8
	vmovss	%xmm0, (%rbx,%rdi)
	leaq	(%r9,%r15), %rdi
	addq	%rax, %rdi
	movl	%ecx, %eax
	xorl	%esi, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	andl	$1, %r10d
	imulq	%rbp, %r10
	addq	%r11, %rax
	imulq	%r12, %rax
	addq	%r9, %r8
	addq	%r10, %r8
	addq	%r15, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	vaddss	(%rbx,%r8,4), %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdi,4)
	jmp	.L21
.L24:
	xorl	%r10d, %r10d
	jmp	.L18
.L25:
	movl	%r10d, (%rsp)
	movq	$0, 8(%rsp)
	jmp	.L22
	.cfi_endproc
.LFE5517:
	.size	set_bnd.constprop.1, .-set_bnd.constprop.1
	.p2align 4
	.type	set_bnd.constprop.2, @function
set_bnd.constprop.2:
.LFB5518:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%ecx, %r9d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%esi, %r12d
	movq	%r12, %r8
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leal	-1(%r8), %r15d
	shrq	%r12
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%r14, %rbp
	movq	%rdx, %rbx
	leal	-2(%r8), %edx
	movq	%r15, %rcx
	movq	%rdx, %r13
	imulq	%r12, %rbp
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	shrq	%r15
	leal	-2(%rdi), %esi
	shrq	%rdx
	testl	%r9d, %r9d
	jne	.L31
	testl	%r13d, %r13d
	je	.L38
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L33:
	movl	%eax, %edi
	notl	%edi
	andl	$1, %edi
	movl	%eax, %r9d
	imulq	%rbp, %rdi
	shrq	%r9
	leaq	(%r9,%r12), %r10
	addq	%r10, %rdi
	vmovss	(%rbx,%rdi,4), %xmm0
	movl	%eax, %edi
	andl	$1, %edi
	imulq	%rbp, %rdi
	incl	%eax
	addq	%r9, %rdi
	vmovss	%xmm0, (%rbx,%rdi,4)
	cmpl	%r13d, %eax
	jbe	.L33
	movq	%rdx, %r10
.L32:
	leaq	1(%r14), %rax
	imulq	%r12, %rax
	vmovss	.LC1(%rip), %xmm1
	leaq	(%r12,%r15), %r9
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%r8d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	vaddss	(%rbx,%rbp,4), %xmm0, %xmm0
	movl	%ecx, %edi
	addq	%rax, %r9
	movl	%r8d, %eax
	vmulss	%xmm1, %xmm0, %xmm0
	andl	$1, %eax
	imulq	%r12, %rax
	andl	$1, %edi
	imulq	%rbp, %rdi
	imulq	%r14, %rax
	vmovss	%xmm0, (%rbx)
	vmovss	(%rbx,%r9,4), %xmm0
	addq	%r10, %rax
	vaddss	(%rbx,%rax,4), %xmm0, %xmm0
	addq	%r15, %rdi
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdi,4)
.L35:
	xorl	%edi, %edi
	.p2align 4,,10
	.p2align 3
.L34:
	movl	%edi, %eax
	notl	%eax
	andl	$1, %eax
	imulq	%r14, %rax
	movl	%edi, %r9d
	movq	%r9, %r8
	addq	%r9, %rax
	imulq	%r12, %rax
	imulq	%r12, %r8
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%edi, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%r8,%rdx), %r9
	addq	%r8, %rax
	vmovss	%xmm0, (%rbx,%rax,4)
	movl	%edi, %eax
	xorl	%r13d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	addq	%r15, %r8
	addq	%r9, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%edi, %eax
	xorl	%ecx, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	incl	%edi
	addq	%rax, %r8
	vmovss	%xmm0, (%rbx,%r8,4)
	cmpl	%esi, %edi
	jbe	.L34
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	.cfi_restore_state
	movl	%r9d, 28(%rsp)
	movl	%edi, 16(%rsp)
	movq	%rdx, 8(%rsp)
	movl	%esi, (%rsp)
	movl	%ecx, 24(%rsp)
	call	omp_get_num_threads@PLT
	movl	28(%rsp), %r9d
	decl	%eax
	cmpl	%eax, %r9d
	movl	24(%rsp), %ecx
	movl	(%rsp), %esi
	movq	8(%rsp), %rdx
	movl	16(%rsp), %edi
	jne	.L35
	leal	-1(%rdi), %r10d
	movl	%r10d, 24(%rsp)
	movl	%esi, %r11d
	testl	%r13d, %r13d
	je	.L39
	movq	%rdx, (%rsp)
	movl	$1, %r8d
	movl	%r10d, %edx
	.p2align 4,,10
	.p2align 3
.L37:
	movl	%r8d, %eax
	xorl	%esi, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	movl	%r8d, %r9d
	shrq	%r9
	addq	%r11, %rax
	imulq	%r12, %rax
	addq	%r9, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%r8d, %eax
	xorl	%edx, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	incl	%r8d
	addq	%r10, %rax
	imulq	%r12, %rax
	addq	%r9, %rax
	vmovss	%xmm0, (%rbx,%rax,4)
	cmpl	%r13d, %r8d
	jbe	.L37
	movl	24(%rsp), %eax
	movq	(%rsp), %rdx
	xorl	%r13d, %eax
	movl	%eax, (%rsp)
	movq	%rdx, 8(%rsp)
.L36:
	movl	24(%rsp), %eax
	leaq	0(,%r12,4), %r8
	andl	$1, %eax
	imulq	%r14, %rax
	vmovss	.LC1(%rip), %xmm1
	movq	%r10, %r9
	addq	%r10, %rax
	imulq	%r8, %rax
	imulq	%r12, %r9
	movq	%rax, 16(%rsp)
	movl	%edi, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	andl	$1, %edi
	imulq	%r14, %rdi
	addq	%r10, %rax
	imulq	%r8, %rax
	addq	%r11, %rdi
	imulq	%r8, %rdi
	vmovss	(%rbx,%rax), %xmm0
	movl	24(%rsp), %eax
	vaddss	(%rbx,%rdi), %xmm0, %xmm0
	xorl	%ecx, %eax
	andl	$1, %eax
	vmulss	%xmm1, %xmm0, %xmm0
	imulq	%rbp, %rax
	movq	16(%rsp), %rdi
	movl	(%rsp), %r10d
	movq	8(%rsp), %r8
	vmovss	%xmm0, (%rbx,%rdi)
	leaq	(%r9,%r15), %rdi
	addq	%rax, %rdi
	movl	%ecx, %eax
	xorl	%esi, %eax
	andl	$1, %eax
	imulq	%r14, %rax
	andl	$1, %r10d
	imulq	%rbp, %r10
	addq	%r11, %rax
	imulq	%r12, %rax
	addq	%r9, %r8
	addq	%r10, %r8
	addq	%r15, %rax
	vmovss	(%rbx,%rax,4), %xmm0
	vaddss	(%rbx,%r8,4), %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdi,4)
	jmp	.L35
.L38:
	xorl	%r10d, %r10d
	jmp	.L32
.L39:
	movl	%r10d, (%rsp)
	movq	$0, 8(%rsp)
	jmp	.L36
	.cfi_endproc
.LFE5518:
	.size	set_bnd.constprop.2, .-set_bnd.constprop.2
	.p2align 4
	.type	lin_solve.constprop.2, @function
lin_solve.constprop.2:
.LFB5519:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	vmovaps	%xmm0, %xmm3
	movl	%edi, %eax
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	vbroadcastss	%xmm3, %ymm3
	pushq	%r14
	pushq	%r13
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	movq	%rcx, %r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	andq	$-32, %rsp
	subq	$96, %rsp
	vmovss	.LC2(%rip), %xmm0
	movl	%esi, 80(%rsp)
	vdivss	%xmm1, %xmm0, %xmm0
	shrl	%esi
	imull	%esi, %eax
	movl	%edi, 92(%rsp)
	movl	%r8d, 76(%rsp)
	salq	$2, %rax
	movq	%rax, 64(%rsp)
	leaq	(%rdx,%rax), %r15
	leal	-1(%rsi), %eax
	movl	$20, 84(%rsp)
	movl	%eax, 88(%rsp)
	movl	%esi, %r14d
	vbroadcastss	%xmm0, %ymm2
	.p2align 4,,10
	.p2align 3
.L54:
	movl	92(%rsp), %eax
	testl	%eax, %eax
	je	.L46
	movl	%r14d, %eax
	movq	%rax, 32(%rsp)
	xorl	%r11d, %r11d
	movl	$1, %r9d
	movl	$1, %r12d
	.p2align 4,,10
	.p2align 3
.L48:
	movl	88(%rsp), %eax
	leal	(%r11,%rax), %r10d
	cmpl	%r11d, %r10d
	jbe	.L51
	movl	%r12d, %r8d
	imulq	32(%rsp), %r8
	movl	%r11d, %edx
	.p2align 4,,10
	.p2align 3
.L47:
	movl	%edx, %eax
	addq	%r8, %rax
	movslq	%eax, %rcx
	movl	%eax, %edi
	leal	(%r9,%rax), %esi
	addl	%r14d, %eax
	movslq	%esi, %rsi
	movl	%eax, %eax
	vmovups	(%r15,%rsi,4), %ymm0
	vmovups	(%r15,%rax,4), %ymm4
	subl	%r14d, %edi
	vaddps	(%r15,%rdi,4), %ymm0, %ymm0
	vaddps	(%r15,%rcx,4), %ymm4, %ymm1
	addl	$8, %edx
	vaddps	%ymm1, %ymm0, %ymm0
	vfmadd213ps	0(%r13,%rcx,4), %ymm3, %ymm0
	vmulps	%ymm2, %ymm0, %ymm0
	vmovups	%ymm0, (%rbx,%rcx,4)
	cmpl	%r10d, %edx
	jb	.L47
.L51:
	movl	$1, %eax
	subl	%r11d, %eax
	incl	%r12d
	negl	%r9d
	movl	%eax, %r11d
	cmpl	%r12d, 92(%rsp)
	jnb	.L48
	movq	64(%rsp), %rax
	movl	$1, %edx
	movq	32(%rsp), %r9
	movq	%r13, (%rsp)
	leaq	0(%r13,%rax), %r11
	movl	$1, %r12d
	movl	$-1, %r8d
	movl	%edx, %r13d
	.p2align 4,,10
	.p2align 3
.L49:
	movl	88(%rsp), %eax
	movl	%r12d, %edx
	leal	(%r12,%rax), %r10d
	cmpl	%r12d, %r10d
	jbe	.L53
	.p2align 4,,10
	.p2align 3
.L52:
	movl	%edx, %eax
	addq	%r9, %rax
	movslq	%eax, %rcx
	movl	%eax, %edi
	leal	(%r8,%rax), %esi
	addl	%r14d, %eax
	movslq	%esi, %rsi
	movl	%eax, %eax
	vmovups	(%rbx,%rsi,4), %ymm0
	vmovups	(%rbx,%rax,4), %ymm5
	subl	%r14d, %edi
	vaddps	(%rbx,%rdi,4), %ymm0, %ymm0
	vaddps	(%rbx,%rcx,4), %ymm5, %ymm1
	addl	$8, %edx
	vaddps	%ymm1, %ymm0, %ymm0
	vfmadd213ps	(%r11,%rcx,4), %ymm3, %ymm0
	vmulps	%ymm2, %ymm0, %ymm0
	vmovups	%ymm0, (%r15,%rcx,4)
	cmpl	%r10d, %edx
	jb	.L52
.L53:
	movl	$1, %edx
	subl	%r12d, %edx
	leal	1(%r13), %eax
	negl	%r8d
	movl	%edx, %r12d
	addq	32(%rsp), %r9
	cmpl	%r13d, 92(%rsp)
	je	.L61
	movl	%eax, %r13d
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L61:
	movq	(%rsp), %r13
.L46:
	movl	76(%rsp), %ecx
	movl	80(%rsp), %esi
	movl	92(%rsp), %edi
	movq	%rbx, %rdx
	vmovaps	%ymm3, (%rsp)
	vmovaps	%ymm2, 32(%rsp)
	vzeroupper
	call	set_bnd.constprop.2
	decl	84(%rsp)
	vmovaps	32(%rsp), %ymm2
	vmovaps	(%rsp), %ymm3
	jne	.L54
	vzeroupper
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5519:
	.size	lin_solve.constprop.2, .-lin_solve.constprop.2
	.p2align 4
	.type	project, @function
project:
.LFB5513:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdx, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%r8, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movl	144(%rsp), %eax
	movl	%edi, 64(%rsp)
	movl	%eax, 60(%rsp)
	movl	%esi, %eax
	subl	$2, %eax
	movl	%esi, 68(%rsp)
	movq	%rcx, 32(%rsp)
	movq	%r9, 40(%rsp)
	movl	%eax, 56(%rsp)
	je	.L65
	movl	%esi, %eax
	movq	%rax, %rbx
	movl	%edi, %ecx
	shrq	%rbx
	movq	%rcx, 72(%rsp)
	imulq	%rbx, %rcx
	vxorps	%xmm2, %xmm2, %xmm2
	subl	$2, %edi
	vcvtsi2ssq	%rax, %xmm2, %xmm0
	movl	%edi, 8(%rsp)
	movq	%rcx, %rbp
	je	.L84
	vmovss	.LC3(%rip), %xmm3
	movq	%r8, 48(%rsp)
	vdivss	%xmm0, %xmm3, %xmm3
	vmovss	.LC4(%rip), %xmm4
	movq	32(%rsp), %r13
	movq	72(%rsp), %r12
	movl	$1, %r14d
	.p2align 4,,10
	.p2align 3
.L68:
	leal	1(%r14), %eax
	movl	%r14d, %r10d
	movq	%rax, %r14
	shrq	%rax
	movq	%rax, 24(%rsp)
	leal	-1(%r10), %eax
	movl	%eax, 12(%rsp)
	shrq	%rax
	movq	%rax, 16(%rsp)
	movq	%r10, %r11
	movl	$1, %edi
	shrq	%r10
	movl	$1, %esi
	.p2align 4,,10
	.p2align 3
.L70:
	movl	%edi, %eax
	xorl	%r14d, %eax
	imulq	%rbx, %rsi
	andl	$1, %eax
	imulq	%rbp, %rax
	movq	24(%rsp), %rcx
	leaq	(%rcx,%rsi), %rdx
	addq	%rax, %rdx
	movl	12(%rsp), %eax
	movq	16(%rsp), %rcx
	xorl	%edi, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%rcx,%rsi), %r9
	vmovss	(%r15,%rdx,4), %xmm1
	addq	%rax, %r9
	movl	%edi, %eax
	incl	%edi
	leal	-1(%rax), %r8d
	movl	%edi, %ecx
	xorl	%r11d, %eax
	andl	$1, %eax
	xorl	%r11d, %ecx
	imulq	%rbp, %rax
	andl	$1, %ecx
	movl	%r8d, %edx
	imulq	%r12, %rcx
	xorl	%r11d, %edx
	addq	%r10, %rsi
	andl	$1, %edx
	addq	%rsi, %rax
	imulq	%r12, %rdx
	movl	%edi, %esi
	addq	%rsi, %rcx
	imulq	%rbx, %rcx
	addq	%r8, %rdx
	imulq	%rbx, %rdx
	addq	%r10, %rcx
	vmovss	0(%r13,%rcx,4), %xmm0
	addq	%r10, %rdx
	vsubss	0(%r13,%rdx,4), %xmm0, %xmm0
	vsubss	(%r15,%r9,4), %xmm1, %xmm1
	movq	40(%rsp), %rcx
	vaddss	%xmm1, %xmm0, %xmm0
	vfmadd132ss	%xmm3, %xmm4, %xmm0
	vmovss	%xmm0, (%rcx,%rax,4)
	movq	48(%rsp), %rcx
	movl	$0x00000000, (%rcx,%rax,4)
	cmpl	8(%rsp), %edi
	jbe	.L70
	cmpl	%r14d, 56(%rsp)
	jnb	.L68
	movl	68(%rsp), %r13d
	movl	64(%rsp), %r14d
	movq	%rcx, %r12
	movq	40(%rsp), %rdx
	movl	60(%rsp), %ecx
	movl	%r13d, %esi
	movl	%r14d, %edi
	call	set_bnd.constprop.2
	movl	60(%rsp), %ecx
	movq	%r12, %rdx
	movl	%r13d, %esi
	movl	%r14d, %edi
	call	set_bnd.constprop.2
	vmovss	.LC6(%rip), %xmm1
	movl	60(%rsp), %r8d
	vmovss	.LC2(%rip), %xmm0
	movq	40(%rsp), %rcx
	movq	%r12, %rdx
	movl	%r13d, %esi
	movl	%r14d, %edi
	call	lin_solve.constprop.2
	movl	56(%rsp), %eax
	vxorps	%xmm2, %xmm2, %xmm2
	vcvtsi2ssq	%rax, %xmm2, %xmm1
	movq	$0, 24(%rsp)
	movq	%r15, 16(%rsp)
	movq	72(%rsp), %r9
	vmulss	.LC1(%rip), %xmm1, %xmm1
	movl	$1, %r11d
	.p2align 4,,10
	.p2align 3
.L77:
	movq	24(%rsp), %rax
	movl	%r11d, %r8d
	leal	1(%r11), %r10d
	movl	%eax, 12(%rsp)
	movl	%r8d, %edi
	shrq	%rax
	movq	%r10, %r11
	movq	%rax, %r13
	shrq	%r10
	shrq	%rdi
	movl	$1, %esi
	movl	$1, %r15d
	.p2align 4,,10
	.p2align 3
.L72:
	movl	%r8d, %eax
	xorl	%esi, %eax
	imulq	%rbx, %r15
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%rdi,%r15), %rdx
	movq	16(%rsp), %rcx
	addq	%rdx, %rax
	movl	%esi, %edx
	xorl	%r11d, %edx
	andl	$1, %edx
	imulq	%rbp, %rdx
	salq	$2, %rax
	leaq	(%rcx,%rax), %r14
	leaq	(%r10,%r15), %rcx
	addq	%rdx, %rcx
	movl	12(%rsp), %edx
	vmovss	(%r12,%rcx,4), %xmm0
	xorl	%esi, %edx
	andl	$1, %edx
	imulq	%rbp, %rdx
	addq	%r13, %r15
	addq	32(%rsp), %rax
	addq	%rdx, %r15
	vsubss	(%r12,%r15,4), %xmm0, %xmm0
	leal	1(%rsi), %r15d
	movl	%r15d, %ecx
	vfnmadd213ss	(%r14), %xmm1, %xmm0
	xorl	%r8d, %ecx
	andl	$1, %ecx
	imulq	%r9, %rcx
	vmovss	%xmm0, (%r14)
	movl	%esi, %r14d
	decl	%r14d
	movl	%r14d, %edx
	xorl	%r8d, %edx
	andl	$1, %edx
	imulq	%r9, %rdx
	addq	%r15, %rcx
	imulq	%rbx, %rcx
	addq	%r14, %rdx
	imulq	%rbx, %rdx
	addq	%rdi, %rcx
	vmovss	(%r12,%rcx,4), %xmm0
	addq	%rdi, %rdx
	vsubss	(%r12,%rdx,4), %xmm0, %xmm0
	movq	%r15, %rsi
	vfnmadd213ss	(%rax), %xmm1, %xmm0
	vmovss	%xmm0, (%rax)
	cmpl	8(%rsp), %r15d
	jbe	.L72
	incq	24(%rsp)
	cmpl	%r11d, 56(%rsp)
	jnb	.L77
	movq	16(%rsp), %r15
.L74:
	movl	60(%rsp), %ebp
	movl	68(%rsp), %r14d
	movl	64(%rsp), %ebx
	movl	%ebp, %ecx
	movq	%r15, %rdx
	movl	%r14d, %esi
	movl	%ebx, %edi
	call	set_bnd.constprop.1
	movq	32(%rsp), %rdx
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebx, %edi
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	%ebp, %ecx
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	movl	%r14d, %esi
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	set_bnd.constprop.0
.L65:
	.cfi_restore_state
	movl	60(%rsp), %r14d
	movl	%edi, %ebx
	movq	%r9, %rdx
	movl	%r14d, %ecx
	movl	$2, %esi
	movq	%r9, %rbp
	call	set_bnd.constprop.2
	movl	%r14d, %ecx
	movq	%r12, %rdx
	movl	%ebx, %edi
	movl	$2, %esi
	call	set_bnd.constprop.2
	vmovss	.LC6(%rip), %xmm1
	vmovss	.LC2(%rip), %xmm0
	movl	%r14d, %r8d
	movq	%rbp, %rcx
	movq	%r12, %rdx
	movl	$2, %esi
	movl	%ebx, %edi
	call	lin_solve.constprop.2
	jmp	.L74
.L84:
	movl	60(%rsp), %r14d
	movl	%esi, %ebx
	movq	%r9, %rdx
	movl	%r14d, %ecx
	movl	$2, %edi
	movq	%r9, %rbp
	call	set_bnd.constprop.2
	movl	%r14d, %ecx
	movq	%r12, %rdx
	movl	%ebx, %esi
	movl	$2, %edi
	call	set_bnd.constprop.2
	vmovss	.LC6(%rip), %xmm1
	vmovss	.LC2(%rip), %xmm0
	movl	%r14d, %r8d
	movq	%rbp, %rcx
	movq	%r12, %rdx
	movl	%ebx, %esi
	movl	$2, %edi
	call	lin_solve.constprop.2
	jmp	.L74
	.cfi_endproc
.LFE5513:
	.size	project, .-project
	.p2align 4
	.type	advect, @function
advect:
.LFB5512:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%esi, %eax
	vxorps	%xmm3, %xmm3, %xmm3
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leal	-2(%rax), %ebx
	vcvtsi2ssq	%rbx, %xmm3, %xmm7
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	%eax, 56(%rsp)
	shrq	%rax
	movq	%rax, %r15
	movl	%edi, 60(%rsp)
	movq	%rcx, 8(%rsp)
	movl	%ebx, 40(%rsp)
	movq	%rbx, 48(%rsp)
	movq	%rbx, %rcx
	movl	%edi, %ebx
	subl	$2, %edi
	movq	%rbx, 16(%rsp)
	movq	%rbx, %rax
	vmulss	%xmm0, %xmm7, %xmm4
	movl	%edx, 44(%rsp)
	movq	%r9, 32(%rsp)
	movl	%edi, 28(%rsp)
	imulq	%r15, %rbx
	testl	%ecx, %ecx
	je	.L88
	testl	%edi, %edi
	je	.L89
	vcvtsi2ssq	%rax, %xmm3, %xmm8
	vmovss	.LC1(%rip), %xmm2
	movl	$1, 24(%rsp)
	vaddss	%xmm2, %xmm7, %xmm7
	vaddss	%xmm2, %xmm8, %xmm8
	vmovss	.LC2(%rip), %xmm6
	.p2align 4,,10
	.p2align 3
.L99:
	movl	24(%rsp), %eax
	movl	$1, %r10d
	movq	%rax, %rcx
	shrq	%rcx
	vcvtsi2ssq	%rax, %xmm3, %xmm5
	movq	%rcx, (%rsp)
	jmp	.L98
	.p2align 4,,10
	.p2align 3
.L139:
	vminss	%xmm9, %xmm7, %xmm9
	vcvttss2sil	%xmm9, %edx
	vcvtsi2ssl	%edx, %xmm3, %xmm1
	leal	1(%rdx), %r12d
	movslq	%r12d, %rbp
	movslq	%edx, %rdi
	vsubss	%xmm1, %xmm9, %xmm10
	shrq	%rbp
	vsubss	%xmm9, %xmm6, %xmm9
	shrq	%rdi
	vcomiss	%xmm0, %xmm2
	vaddss	%xmm1, %xmm9, %xmm1
	ja	.L116
.L140:
	vminss	%xmm0, %xmm8, %xmm0
	vcvttss2sil	%xmm0, %eax
	vsubss	%xmm0, %xmm6, %xmm9
	vcvtsi2ssl	%eax, %xmm3, %xmm11
	movslq	%eax, %r11
	imulq	%r15, %r11
	movl	%eax, %esi
	vaddss	%xmm11, %xmm9, %xmm9
	vsubss	%xmm11, %xmm0, %xmm11
	leaq	(%r11,%rdi), %r14
	leal	1(%rax), %ecx
	leaq	(%r11,%r15), %r9
	xorl	%edx, %esi
	xorl	%r12d, %eax
	addq	%rbp, %r11
.L95:
	xorl	%ecx, %edx
	xorl	%r12d, %ecx
	andl	$1, %edx
	andl	$1, %ecx
	imulq	%rbx, %rdx
	imulq	%rbx, %rcx
	addq	%r9, %rdi
	addq	%rbp, %r9
	addq	%rdx, %rdi
	addq	%rcx, %r9
	vmulss	(%r8,%rdi,4), %xmm11, %xmm0
	andl	$1, %esi
	vmulss	(%r8,%r9,4), %xmm11, %xmm11
	andl	$1, %eax
	imulq	%rbx, %rsi
	imulq	%rbx, %rax
	incl	%r10d
	addq	%r14, %rsi
	addq	%r11, %rax
	vfmadd231ss	(%r8,%rsi,4), %xmm9, %xmm0
	vfmadd132ss	(%r8,%rax,4), %xmm11, %xmm9
	movq	8(%rsp), %rax
	vmulss	%xmm10, %xmm9, %xmm9
	vfmadd132ss	%xmm0, %xmm9, %xmm1
	vmovss	%xmm1, (%rax,%r13)
	cmpl	28(%rsp), %r10d
	ja	.L138
.L98:
	movl	24(%rsp), %eax
	movl	%r10d, %edx
	xorl	%r10d, %eax
	andl	$1, %eax
	imulq	16(%rsp), %rax
	movq	32(%rsp), %rsi
	vmovaps	%xmm4, %xmm9
	addq	%rdx, %rax
	imulq	%r15, %rax
	vcvtsi2ssq	%rdx, %xmm3, %xmm0
	movq	128(%rsp), %rdi
	addq	(%rsp), %rax
	vfnmadd132ss	(%rsi,%rax,4), %xmm5, %xmm9
	vfnmadd231ss	(%rdi,%rax,4), %xmm4, %xmm0
	leaq	0(,%rax,4), %r13
	vcomiss	%xmm9, %xmm2
	jbe	.L139
	xorl	%edi, %edi
	xorl	%ebp, %ebp
	xorl	%edx, %edx
	vcomiss	%xmm0, %xmm2
	vmovaps	%xmm2, %xmm1
	vmovaps	%xmm2, %xmm10
	movl	$1, %r12d
	jbe	.L140
.L116:
	movq	%rbp, %r11
	movl	%r12d, %eax
	movq	%r15, %r9
	movq	%rdi, %r14
	movl	%edx, %esi
	vmovaps	%xmm2, %xmm11
	movl	$1, %ecx
	vmovaps	%xmm2, %xmm9
	jmp	.L95
	.p2align 4,,10
	.p2align 3
.L138:
	incl	24(%rsp)
	movl	24(%rsp), %eax
	cmpl	%eax, 40(%rsp)
	jnb	.L99
.L89:
	movl	136(%rsp), %eax
	testl	%eax, %eax
	jne	.L141
	cmpl	$2, 44(%rsp)
	je	.L117
	movl	40(%rsp), %r8d
	movq	8(%rsp), %rdi
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L101:
	movl	%eax, %edx
	notl	%edx
	andl	$1, %edx
	movl	%eax, %ecx
	imulq	%rbx, %rdx
	shrq	%rcx
	leaq	(%rcx,%r15), %rsi
	addq	%rsi, %rdx
	vmovss	(%rdi,%rdx,4), %xmm0
	movl	%eax, %edx
	andl	$1, %edx
	imulq	%rbx, %rdx
	incl	%eax
	addq	%rcx, %rdx
	vmovss	%xmm0, (%rdi,%rdx,4)
	cmpl	%eax, %r8d
	jnb	.L101
.L102:
	movq	16(%rsp), %r11
	movl	56(%rsp), %r10d
	leaq	1(%r11), %rax
	imulq	%r15, %rax
	movq	8(%rsp), %r14
	movl	%r10d, %esi
	vmovss	(%r14,%rax,4), %xmm0
	andl	$1, %esi
	imulq	%rbx, %rsi
	leal	-1(%r10), %eax
	vaddss	(%r14,%rbx,4), %xmm0, %xmm0
	movq	%rax, %rdx
	shrq	%rax
	vmovss	.LC1(%rip), %xmm1
	leaq	(%rax,%r15), %r8
	addq	%rsi, %r8
	movl	%r10d, %esi
	vmulss	%xmm1, %xmm0, %xmm0
	andl	$1, %esi
	imulq	%r15, %rsi
	movq	48(%rsp), %rcx
	movl	%edx, %edi
	imulq	%r11, %rsi
	vmovss	%xmm0, (%r14)
	vmovss	(%r14,%r8,4), %xmm0
	shrq	%rcx
	addq	%rcx, %rsi
	vaddss	(%r14,%rsi,4), %xmm0, %xmm0
	andl	$1, %edi
	imulq	%rbx, %rdi
	vmulss	%xmm1, %xmm0, %xmm0
	addq	%rax, %rdi
	vmovss	%xmm0, (%r14,%rdi,4)
.L106:
	cmpl	$1, 44(%rsp)
	je	.L118
	movl	40(%rsp), %r10d
	movl	28(%rsp), %r11d
	movq	8(%rsp), %r9
	movq	16(%rsp), %rbp
	xorl	%r8d, %r8d
	.p2align 4,,10
	.p2align 3
.L104:
	movl	%r8d, %edi
	notl	%edi
	andl	$1, %edi
	imulq	%rbp, %rdi
	movl	%r8d, %esi
	addq	%rsi, %rdi
	imulq	%r15, %rdi
	imulq	%r15, %rsi
	vmovss	(%r9,%rdi,4), %xmm0
	movl	%r8d, %edi
	andl	$1, %edi
	imulq	%rbx, %rdi
	leaq	(%rcx,%rsi), %r12
	addq	%rsi, %rdi
	vmovss	%xmm0, (%r9,%rdi,4)
	movl	%r10d, %edi
	xorl	%r8d, %edi
	andl	$1, %edi
	imulq	%rbx, %rdi
	addq	%rax, %rsi
	addq	%r12, %rdi
	vmovss	(%r9,%rdi,4), %xmm0
	movl	%r8d, %edi
	xorl	%edx, %edi
	andl	$1, %edi
	imulq	%rbx, %rdi
	incl	%r8d
	addq	%rdi, %rsi
	vmovss	%xmm0, (%r9,%rsi,4)
	cmpl	%r11d, %r8d
	jbe	.L104
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L117:
	.cfi_restore_state
	movl	40(%rsp), %r8d
	movq	8(%rsp), %rdi
	movl	$1, %edx
	vmovss	.LC0(%rip), %xmm1
	.p2align 4,,10
	.p2align 3
.L100:
	movl	%edx, %ecx
	movl	%edx, %esi
	andl	$1, %ecx
	notl	%esi
	imulq	%rbx, %rcx
	andl	$1, %esi
	movl	%edx, %eax
	imulq	%rbx, %rsi
	shrq	%rax
	addq	%rax, %rcx
	addq	%r15, %rax
	addq	%rsi, %rax
	vmovss	(%rdi,%rax,4), %xmm0
	incl	%edx
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rdi,%rcx,4)
	cmpl	%edx, %r8d
	jnb	.L100
	jmp	.L102
.L118:
	movl	40(%rsp), %r11d
	movl	28(%rsp), %ebp
	movq	8(%rsp), %r10
	movq	16(%rsp), %r12
	xorl	%edi, %edi
	vmovss	.LC0(%rip), %xmm1
	.p2align 4,,10
	.p2align 3
.L103:
	movl	%edi, %esi
	notl	%esi
	andl	$1, %esi
	imulq	%r12, %rsi
	movl	%edi, %r13d
	movl	%edi, %r9d
	addq	%r13, %rsi
	imulq	%r15, %rsi
	movq	%r13, %r8
	andl	$1, %r9d
	vmovss	(%r10,%rsi,4), %xmm0
	movl	%edi, %esi
	imulq	%r15, %r8
	imulq	%rbx, %r9
	xorl	%edx, %esi
	andl	$1, %esi
	imulq	%rbx, %rsi
	addq	%r8, %r9
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%r10,%r9,4)
	leaq	(%rax,%r8), %r9
	addq	%rsi, %r9
	movl	%r11d, %esi
	xorl	%edi, %esi
	andl	$1, %esi
	imulq	%rbx, %rsi
	addq	%rcx, %r8
	incl	%edi
	addq	%rsi, %r8
	vmovss	(%r10,%r8,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%r10,%r9,4)
	cmpl	%ebp, %edi
	jbe	.L103
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L141:
	.cfi_restore_state
	call	omp_get_num_threads@PLT
	movl	56(%rsp), %edx
	movl	%eax, %r8d
	movq	48(%rsp), %rcx
	leal	-1(%rdx), %eax
	leal	-1(%r8), %esi
	movq	%rax, %rdx
	shrq	%rcx
	shrq	%rax
	cmpl	%esi, 136(%rsp)
	jne	.L106
	movl	60(%rsp), %edi
	movl	28(%rsp), %r11d
	leal	-1(%rdi), %r10d
	cmpl	$2, 44(%rsp)
	movq	%r11, %r14
	movq	%r10, %rbp
	je	.L119
	movl	40(%rsp), %r13d
	movq	8(%rsp), %r9
	movq	16(%rsp), %r12
	movl	$1, %edi
.L107:
	movl	%edi, %esi
	xorl	%r14d, %esi
	andl	$1, %esi
	imulq	%r12, %rsi
	movl	%edi, %r8d
	shrq	%r8
	addq	%r11, %rsi
	imulq	%r15, %rsi
	addq	%r8, %rsi
	vmovss	(%r9,%rsi,4), %xmm0
	movl	%ebp, %esi
	xorl	%edi, %esi
	andl	$1, %esi
	imulq	%r12, %rsi
	incl	%edi
	addq	%r10, %rsi
	imulq	%r15, %rsi
	addq	%r8, %rsi
	vmovss	%xmm0, (%r9,%rsi,4)
	cmpl	%edi, %r13d
	jnb	.L107
.L108:
	movq	16(%rsp), %r14
	movl	%ebp, %esi
	andl	$1, %esi
	imulq	%r14, %rsi
	movl	60(%rsp), %r13d
	movq	%r10, %rdi
	addq	%r10, %rsi
	imulq	%r15, %rsi
	movl	%r13d, %r8d
	andl	$1, %r8d
	movq	%rsi, %r9
	movl	%r13d, %esi
	andl	$1, %esi
	imulq	%r14, %rsi
	imulq	%r14, %r8
	imulq	%r15, %rdi
	addq	%r10, %rsi
	imulq	%r15, %rsi
	movq	%r14, %r10
	movq	8(%rsp), %r14
	addq	%r11, %r8
	vmovss	(%r14,%rsi,4), %xmm0
	movl	%edx, %esi
	imulq	%r15, %r8
	xorl	%ebp, %esi
	andl	$1, %esi
	imulq	%rbx, %rsi
	vaddss	(%r14,%r8,4), %xmm0, %xmm0
	vmovss	.LC1(%rip), %xmm1
	leaq	(%rax,%rdi), %r8
	addq	%rsi, %r8
	movl	28(%rsp), %esi
	vmulss	%xmm1, %xmm0, %xmm0
	xorl	%edx, %esi
	andl	$1, %esi
	imulq	%r10, %rsi
	addq	%rcx, %rdi
	vmovss	%xmm0, (%r14,%r9,4)
	movl	40(%rsp), %r9d
	addq	%r11, %rsi
	imulq	%r15, %rsi
	xorl	%ebp, %r9d
	andl	$1, %r9d
	imulq	%rbx, %r9
	addq	%rax, %rsi
	vmovss	(%r14,%rsi,4), %xmm0
	addq	%r9, %rdi
	vaddss	(%r14,%rdi,4), %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%r14,%r8,4)
	jmp	.L106
.L88:
	movl	136(%rsp), %edx
	testl	%edx, %edx
	je	.L102
	call	omp_get_num_threads@PLT
	decl	%eax
	cmpl	%eax, 136(%rsp)
	je	.L113
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	movl	$1, %edx
	jmp	.L106
.L119:
	movq	8(%rsp), %r12
	movq	16(%rsp), %r13
	movl	$1, %r8d
	vmovss	.LC0(%rip), %xmm1
.L109:
	movl	%r8d, %edi
	xorl	%r14d, %edi
	andl	$1, %edi
	movl	%r8d, %esi
	imulq	%r13, %rdi
	xorl	%ebp, %esi
	andl	$1, %esi
	imulq	%r13, %rsi
	addq	%r11, %rdi
	imulq	%r15, %rdi
	movl	%r8d, %r9d
	shrq	%r9
	addq	%r10, %rsi
	imulq	%r15, %rsi
	addq	%r9, %rdi
	vmovss	(%r12,%rdi,4), %xmm0
	addq	%r9, %rsi
	vxorps	%xmm1, %xmm0, %xmm0
	incl	%r8d
	vmovss	%xmm0, (%r12,%rsi,4)
	cmpl	%r8d, 40(%rsp)
	jnb	.L109
	jmp	.L108
.L113:
	movl	60(%rsp), %eax
	movl	28(%rsp), %r11d
	leal	-1(%rax), %r10d
	movq	%r10, %rbp
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	movl	$1, %edx
	jmp	.L108
	.cfi_endproc
.LFE5512:
	.size	advect, .-advect
	.p2align 4
	.globl	dens_step
	.type	dens_step, @function
dens_step:
.LFB5514:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	vmulss	%xmm0, %xmm1, %xmm3
	vmovaps	%xmm1, %xmm2
	leaq	16(%rsp), %r13
	.cfi_def_cfa 13, 0
	andq	$-32, %rsp
	pushq	-8(%r13)
	movq	%r13, %rax
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	movl	%esi, %r15d
	pushq	%r14
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	movq	%r9, %r14
	pushq	%r13
	.cfi_escape 0xf,0x3,0x76,0x68,0x6
	movq	%r8, %r13
	pushq	%r12
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	movq	%rdx, %r12
	movl	%edi, %edx
	pushq	%rbx
	imull	%esi, %edx
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	movq	%rcx, %rbx
	subq	$40, %rsp
	movl	(%rax), %r8d
	testl	%edx, %edx
	je	.L157
	leaq	4(%rbx), %rsi
	movq	%r12, %rax
	subq	%rsi, %rax
	leal	-1(%rdx), %ecx
	cmpq	$24, %rax
	jbe	.L146
	cmpl	$2, %ecx
	jbe	.L146
	cmpl	$6, %ecx
	jbe	.L163
	movl	%edx, %esi
	shrl	$3, %esi
	vbroadcastss	%xmm1, %ymm1
	salq	$5, %rsi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L148:
	vmovups	(%rbx,%rax), %ymm0
	vfmadd213ps	(%r12,%rax), %ymm1, %ymm0
	vmovups	%ymm0, (%r12,%rax)
	addq	$32, %rax
	cmpq	%rsi, %rax
	jne	.L148
	movl	%edx, %eax
	andl	$-8, %eax
	testb	$7, %dl
	je	.L149
	movl	%edx, %r9d
	subl	%eax, %r9d
	leal	-1(%r9), %esi
	cmpl	$2, %esi
	jbe	.L150
.L147:
	movl	%eax, %r10d
	leaq	(%r12,%r10,4), %rsi
	vmovups	(%rsi), %xmm4
	vshufps	$0, %xmm2, %xmm2, %xmm0
	vfmadd132ps	(%rbx,%r10,4), %xmm4, %xmm0
	vmovups	%xmm0, (%rsi)
	movl	%r9d, %esi
	andl	$-4, %esi
	addl	%esi, %eax
	cmpl	%esi, %r9d
	je	.L149
.L150:
	movl	%eax, %r9d
	vmovss	(%rbx,%r9,4), %xmm0
	leaq	(%r12,%r9,4), %rsi
	vfmadd213ss	(%rsi), %xmm2, %xmm0
	vmovss	%xmm0, (%rsi)
	leal	1(%rax), %esi
	cmpl	%esi, %edx
	jbe	.L149
	vmovss	(%rbx,%rsi,4), %xmm0
	leaq	(%r12,%rsi,4), %r9
	vfmadd213ss	(%r9), %xmm2, %xmm0
	addl	$2, %eax
	vmovss	%xmm0, (%r9)
	cmpl	%eax, %edx
	jbe	.L149
	vmovss	(%rbx,%rax,4), %xmm0
	leaq	(%r12,%rax,4), %rsi
	vfmadd213ss	(%rsi), %xmm2, %xmm0
	vmovss	%xmm0, (%rsi)
.L149:
	cmpl	$6, %ecx
	jbe	.L164
	movl	%edx, %ecx
	shrl	$3, %ecx
	vbroadcastss	%xmm2, %ymm1
	salq	$5, %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L155:
	vmovups	(%rbx,%rax), %ymm0
	vfmadd213ps	(%r12,%rax), %ymm1, %ymm0
	vmovups	%ymm0, (%r12,%rax)
	addq	$32, %rax
	cmpq	%rcx, %rax
	jne	.L155
	movl	%edx, %eax
	andl	$-8, %eax
	testb	$7, %dl
	je	.L179
	movl	%edx, %r9d
	subl	%eax, %r9d
	leal	-1(%r9), %ecx
	cmpl	$2, %ecx
	jbe	.L159
.L154:
	movl	%eax, %esi
	leaq	(%r12,%rsi,4), %rcx
	vmovups	(%rcx), %xmm5
	vshufps	$0, %xmm2, %xmm2, %xmm0
	vfmadd132ps	(%rbx,%rsi,4), %xmm5, %xmm0
	vmovups	%xmm0, (%rcx)
	movl	%r9d, %ecx
	andl	$-4, %ecx
	addl	%ecx, %eax
	cmpl	%ecx, %r9d
	je	.L179
.L159:
	movl	%eax, %esi
	vmovss	(%rbx,%rsi,4), %xmm0
	leaq	(%r12,%rsi,4), %rcx
	vfmadd213ss	(%rcx), %xmm2, %xmm0
	vmovss	%xmm0, (%rcx)
	leal	1(%rax), %ecx
	cmpl	%ecx, %edx
	jbe	.L179
	vmovss	(%rbx,%rcx,4), %xmm0
	leaq	(%r12,%rcx,4), %rsi
	vfmadd213ss	(%rsi), %xmm2, %xmm0
	addl	$2, %eax
	vmovss	%xmm0, (%rsi)
	cmpl	%edx, %eax
	jnb	.L179
	vmovss	(%rbx,%rax,4), %xmm0
	leaq	(%r12,%rax,4), %rdx
	vfmadd213ss	(%rdx), %xmm2, %xmm0
	vmovss	%xmm0, (%rdx)
	vzeroupper
.L157:
	movl	%r15d, %eax
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	vmovss	.LC6(%rip), %xmm1
	movq	%r12, %rcx
	movq	%rbx, %rdx
	vmulss	%xmm0, %xmm0, %xmm0
	movl	%r15d, %esi
	movl	%r8d, -56(%rbp)
	movl	%edi, -52(%rbp)
	vmovss	%xmm2, -60(%rbp)
	vmulss	%xmm3, %xmm0, %xmm0
	vfmadd213ss	.LC2(%rip), %xmm0, %xmm1
	call	lin_solve.constprop.2
	movl	-56(%rbp), %r8d
	vmovss	-60(%rbp), %xmm2
	pushq	%r8
	movl	-52(%rbp), %edi
	movq	%r13, %r9
	pushq	%r14
	movq	%rbx, %r8
	movq	%r12, %rcx
	xorl	%edx, %edx
	movl	%r15d, %esi
	vmovaps	%xmm2, %xmm0
	call	advect
	popq	%rax
	popq	%rdx
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-16(%r13), %rsp
	.cfi_def_cfa 7, 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	GOMP_barrier@PLT
	.p2align 4,,10
	.p2align 3
.L179:
	.cfi_restore_state
	vzeroupper
	jmp	.L157
	.p2align 4,,10
	.p2align 3
.L146:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L152:
	vmovss	(%rbx,%rax,4), %xmm0
	vfmadd213ss	(%r12,%rax,4), %xmm2, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L152
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L161:
	vmovss	(%rbx,%rax,4), %xmm0
	vfmadd213ss	(%r12,%rax,4), %xmm2, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rdx, %rax
	jne	.L161
	jmp	.L157
.L163:
	movl	%edx, %r9d
	xorl	%eax, %eax
	jmp	.L147
.L164:
	movl	%edx, %r9d
	xorl	%eax, %eax
	jmp	.L154
	.cfi_endproc
.LFE5514:
	.size	dens_step, .-dens_step
	.p2align 4
	.globl	vel_step
	.type	vel_step, @function
vel_step:
.LFB5515:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	16(%rsp), %r13
	.cfi_def_cfa 13, 0
	andq	$-32, %rsp
	pushq	-8(%r13)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	movq	%r9, %r15
	pushq	%r14
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	movq	%rdx, %r14
	pushq	%r13
	.cfi_escape 0xf,0x3,0x76,0x68,0x6
	pushq	%r12
	pushq	%rbx
	subq	$136, %rsp
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	movl	0(%r13), %eax
	vmovss	%xmm1, -156(%rbp)
	movl	%eax, -80(%rbp)
	movl	%edi, %eax
	imull	%esi, %eax
	vmulss	%xmm1, %xmm0, %xmm1
	movl	%edi, -52(%rbp)
	movl	%esi, -76(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%r8, -72(%rbp)
	testl	%eax, %eax
	je	.L198
	leal	-1(%rax), %esi
	cmpl	$2, %esi
	movq	%r8, %rcx
	seta	%dil
	addq	$4, %rcx
	subq	%rcx, %rdx
	cmpq	$24, %rdx
	jbe	.L186
	testb	%dil, %dil
	je	.L186
	cmpl	$6, %esi
	jbe	.L223
	movl	%eax, %ecx
	shrl	$3, %ecx
	vbroadcastss	-156(%rbp), %ymm2
	salq	$5, %rcx
	xorl	%edx, %edx
.L188:
	movq	-72(%rbp), %rbx
	vmovups	(%rbx,%rdx), %ymm0
	vfmadd213ps	(%r14,%rdx), %ymm2, %ymm0
	vmovups	%ymm0, (%r14,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rcx
	jne	.L188
	movl	%eax, %edx
	andl	$-8, %edx
	testb	$7, %al
	je	.L193
	movl	%eax, %ecx
	subl	%edx, %ecx
	leal	-1(%rcx), %r8d
	cmpl	$2, %r8d
	jbe	.L190
.L187:
	movl	%edx, %r9d
	leaq	(%r14,%r9,4), %r8
	vmovups	(%r8), %xmm7
	vbroadcastss	-156(%rbp), %xmm0
	movq	-72(%rbp), %rbx
	vfmadd132ps	(%rbx,%r9,4), %xmm7, %xmm0
	vmovups	%xmm0, (%r8)
	movl	%ecx, %r8d
	andl	$-4, %r8d
	addl	%r8d, %edx
	cmpl	%r8d, %ecx
	je	.L193
.L190:
	movl	%edx, %r8d
	leaq	(%r14,%r8,4), %rcx
	vmovss	-156(%rbp), %xmm5
	vmovss	(%rcx), %xmm7
	movq	-72(%rbp), %rbx
	vmovaps	%xmm5, %xmm4
	vfmadd132ss	(%rbx,%r8,4), %xmm7, %xmm4
	vmovss	%xmm4, (%rcx)
	leal	1(%rdx), %ecx
	cmpl	%ecx, %eax
	jbe	.L193
	leaq	(%r14,%rcx,4), %r8
	vmovaps	%xmm5, %xmm0
	vmovaps	%xmm5, %xmm4
	vmovss	(%r8), %xmm5
	addl	$2, %edx
	vfmadd132ss	(%rbx,%rcx,4), %xmm5, %xmm0
	vmovss	%xmm0, (%r8)
	cmpl	%edx, %eax
	jbe	.L193
	leaq	(%r14,%rdx,4), %rcx
	vmovss	(%rcx), %xmm5
	vfmadd132ss	(%rbx,%rdx,4), %xmm5, %xmm4
	vmovss	%xmm4, (%rcx)
.L193:
	movq	-64(%rbp), %rbx
	leaq	4(%r15), %rcx
	movq	%rbx, %rdx
	subq	%rcx, %rdx
	cmpq	$24, %rdx
	jbe	.L194
	testb	%dil, %dil
	je	.L194
	cmpl	$6, %esi
	jbe	.L224
	movl	%eax, %ecx
	shrl	$3, %ecx
	vbroadcastss	-156(%rbp), %ymm2
	salq	$5, %rcx
	xorl	%edx, %edx
	movq	%rbx, %rsi
.L196:
	vmovups	(%r15,%rdx), %ymm0
	vfmadd213ps	(%rsi,%rdx), %ymm2, %ymm0
	vmovups	%ymm0, (%rsi,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rcx
	jne	.L196
	movl	%eax, %edx
	andl	$-8, %edx
	testb	$7, %al
	je	.L198
	movl	%eax, %ecx
	subl	%edx, %ecx
	leal	-1(%rcx), %esi
	cmpl	$2, %esi
	jbe	.L200
.L195:
	movq	-64(%rbp), %rsi
	movl	%edx, %edi
	leaq	(%rsi,%rdi,4), %rsi
	vmovups	(%rsi), %xmm4
	vbroadcastss	-156(%rbp), %xmm0
	vfmadd132ps	(%r15,%rdi,4), %xmm4, %xmm0
	vmovups	%xmm0, (%rsi)
	movl	%ecx, %esi
	andl	$-4, %esi
	addl	%esi, %edx
	cmpl	%esi, %ecx
	je	.L198
.L200:
	movq	-64(%rbp), %rdi
	movl	%edx, %esi
	leaq	(%rdi,%rsi,4), %rcx
	vmovss	-156(%rbp), %xmm7
	vmovss	(%rcx), %xmm5
	vmovaps	%xmm7, %xmm6
	vfmadd132ss	(%r15,%rsi,4), %xmm5, %xmm6
	vmovss	%xmm6, (%rcx)
	leal	1(%rdx), %ecx
	cmpl	%ecx, %eax
	jbe	.L198
	leaq	(%rdi,%rcx,4), %rsi
	vmovaps	%xmm7, %xmm0
	vmovaps	%xmm7, %xmm6
	vmovss	(%rsi), %xmm7
	addl	$2, %edx
	vfmadd132ss	(%r15,%rcx,4), %xmm7, %xmm0
	vmovss	%xmm0, (%rsi)
	cmpl	%edx, %eax
	jbe	.L198
	movl	%edx, %eax
	leaq	(%rdi,%rax,4), %rdx
	vmovss	(%rdx), %xmm4
	vfmadd132ss	(%r15,%rax,4), %xmm4, %xmm6
	vmovss	%xmm6, (%rdx)
.L198:
	movl	-76(%rbp), %eax
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	movq	%rax, %rdi
	movl	-52(%rbp), %eax
	shrl	%edi
	vmulss	%xmm0, %xmm0, %xmm0
	imull	%edi, %eax
	movl	$20, -56(%rbp)
	movq	%r15, -168(%rbp)
	salq	$2, %rax
	vmulss	%xmm1, %xmm0, %xmm1
	vmovss	.LC2(%rip), %xmm0
	movq	%rax, -152(%rbp)
	leaq	(%r14,%rax), %rbx
	leal	-1(%rdi), %eax
	vmovaps	%xmm1, %xmm2
	vfmadd132ss	.LC6(%rip), %xmm0, %xmm2
	movl	%edi, %r12d
	vbroadcastss	%xmm1, %ymm1
	movl	%eax, %r15d
	vdivss	%xmm2, %xmm0, %xmm2
	vbroadcastss	%xmm2, %ymm2
	.p2align 4,,10
	.p2align 3
.L185:
	movl	-52(%rbp), %esi
	testl	%esi, %esi
	je	.L205
	movl	%r12d, %eax
	movq	%rax, -112(%rbp)
	xorl	%edx, %edx
	movl	$1, %r10d
	movl	$1, %esi
	.p2align 4,,10
	.p2align 3
.L207:
	leal	(%rdx,%r15), %r11d
	cmpl	%edx, %r11d
	jbe	.L210
	movl	%esi, %r9d
	imulq	-112(%rbp), %r9
	movl	%edx, %ecx
	.p2align 4,,10
	.p2align 3
.L206:
	movl	%ecx, %eax
	addq	%r9, %rax
	movslq	%eax, %rdi
	movl	%eax, %r13d
	leal	(%r10,%rax), %r8d
	addl	%r12d, %eax
	movl	%eax, %eax
	movslq	%r8d, %r8
	vmovups	(%rbx,%rax,4), %ymm4
	vmovups	(%rbx,%r8,4), %ymm0
	subl	%r12d, %r13d
	vaddps	(%rbx,%r13,4), %ymm0, %ymm0
	vaddps	(%rbx,%rdi,4), %ymm4, %ymm3
	movq	-72(%rbp), %rax
	addl	$8, %ecx
	vaddps	%ymm3, %ymm0, %ymm0
	vfmadd213ps	(%rax,%rdi,4), %ymm1, %ymm0
	vmulps	%ymm0, %ymm2, %ymm0
	vmovups	%ymm0, (%r14,%rdi,4)
	cmpl	%r11d, %ecx
	jb	.L206
.L210:
	movl	$1, %eax
	subl	%edx, %eax
	incl	%esi
	negl	%r10d
	movl	%eax, %edx
	cmpl	%esi, -52(%rbp)
	jnb	.L207
	movq	-72(%rbp), %rax
	movq	-152(%rbp), %rcx
	movq	-112(%rbp), %r9
	addq	%rcx, %rax
	movq	%rax, -144(%rbp)
	movl	$1, %edx
	movl	$-1, %r8d
	movl	$1, %r10d
	.p2align 4,,10
	.p2align 3
.L208:
	leal	(%rdx,%r15), %r11d
	movl	%edx, %ecx
	cmpl	%edx, %r11d
	jbe	.L212
	.p2align 4,,10
	.p2align 3
.L211:
	movl	%ecx, %eax
	addq	%r9, %rax
	movslq	%eax, %rsi
	movl	%eax, %r13d
	leal	(%r8,%rax), %edi
	addl	%r12d, %eax
	movl	%eax, %eax
	movslq	%edi, %rdi
	vmovups	(%r14,%rax,4), %ymm5
	vmovups	(%r14,%rdi,4), %ymm0
	subl	%r12d, %r13d
	vaddps	(%r14,%r13,4), %ymm0, %ymm0
	vaddps	(%r14,%rsi,4), %ymm5, %ymm3
	movq	-144(%rbp), %rax
	addl	$8, %ecx
	vaddps	%ymm3, %ymm0, %ymm0
	vfmadd213ps	(%rax,%rsi,4), %ymm1, %ymm0
	vmulps	%ymm0, %ymm2, %ymm0
	vmovups	%ymm0, (%rbx,%rsi,4)
	cmpl	%r11d, %ecx
	jb	.L211
.L212:
	movl	$1, %edi
	subl	%edx, %edi
	leal	1(%r10), %eax
	negl	%r8d
	movl	%edi, %edx
	addq	-112(%rbp), %r9
	cmpl	%r10d, -52(%rbp)
	je	.L205
	movl	%eax, %r10d
	jmp	.L208
	.p2align 4,,10
	.p2align 3
.L205:
	movl	-80(%rbp), %ecx
	movl	-76(%rbp), %esi
	movl	-52(%rbp), %edi
	movq	%r14, %rdx
	vmovaps	%ymm1, -144(%rbp)
	vmovaps	%ymm2, -112(%rbp)
	vzeroupper
	call	set_bnd.constprop.1
	decl	-56(%rbp)
	vmovaps	-112(%rbp), %ymm2
	vmovaps	-144(%rbp), %ymm1
	jne	.L185
	movq	-168(%rbp), %r15
	movq	-152(%rbp), %rax
	movl	$20, -56(%rbp)
	leaq	(%r15,%rax), %rbx
	leal	-1(%r12), %eax
	movq	%r14, -168(%rbp)
	movl	%eax, %r14d
	.p2align 4,,10
	.p2align 3
.L222:
	movl	-52(%rbp), %ecx
	testl	%ecx, %ecx
	je	.L214
	movl	%r12d, %eax
	movq	%rax, -112(%rbp)
	xorl	%edx, %edx
	movl	$1, %r10d
	movl	$1, %esi
	.p2align 4,,10
	.p2align 3
.L216:
	leal	(%rdx,%r14), %r11d
	cmpl	%edx, %r11d
	jbe	.L219
	movl	%esi, %r9d
	imulq	-112(%rbp), %r9
	movl	%edx, %ecx
	.p2align 4,,10
	.p2align 3
.L215:
	movl	%ecx, %eax
	addq	%r9, %rax
	movslq	%eax, %rdi
	movl	%eax, %r13d
	leal	(%r10,%rax), %r8d
	addl	%r12d, %eax
	movl	%eax, %eax
	movslq	%r8d, %r8
	vmovups	(%rbx,%rax,4), %ymm6
	vmovups	(%rbx,%r8,4), %ymm0
	subl	%r12d, %r13d
	vaddps	(%rbx,%r13,4), %ymm0, %ymm0
	vaddps	(%rbx,%rdi,4), %ymm6, %ymm3
	movq	-64(%rbp), %rax
	addl	$8, %ecx
	vaddps	%ymm3, %ymm0, %ymm0
	vfmadd213ps	(%rax,%rdi,4), %ymm1, %ymm0
	vmulps	%ymm0, %ymm2, %ymm0
	vmovups	%ymm0, (%r15,%rdi,4)
	cmpl	%ecx, %r11d
	ja	.L215
.L219:
	movl	$1, %eax
	subl	%edx, %eax
	incl	%esi
	negl	%r10d
	movl	%eax, %edx
	cmpl	%esi, -52(%rbp)
	jnb	.L216
	movq	-64(%rbp), %rax
	movq	-152(%rbp), %rcx
	movq	-112(%rbp), %r9
	addq	%rcx, %rax
	movq	%rax, -144(%rbp)
	movl	$1, %edx
	movl	$-1, %r8d
	movl	$1, %r10d
	.p2align 4,,10
	.p2align 3
.L217:
	leal	(%rdx,%r14), %r11d
	movl	%edx, %ecx
	cmpl	%edx, %r11d
	jbe	.L221
	.p2align 4,,10
	.p2align 3
.L220:
	movl	%ecx, %eax
	addq	%r9, %rax
	movslq	%eax, %rsi
	movl	%eax, %r13d
	leal	(%r8,%rax), %edi
	addl	%r12d, %eax
	movl	%eax, %eax
	movslq	%edi, %rdi
	vmovups	(%r15,%rax,4), %ymm7
	vmovups	(%r15,%rdi,4), %ymm0
	subl	%r12d, %r13d
	vaddps	(%r15,%r13,4), %ymm0, %ymm0
	vaddps	(%r15,%rsi,4), %ymm7, %ymm3
	movq	-144(%rbp), %rax
	addl	$8, %ecx
	vaddps	%ymm3, %ymm0, %ymm0
	vfmadd213ps	(%rax,%rsi,4), %ymm1, %ymm0
	vmulps	%ymm0, %ymm2, %ymm0
	vmovups	%ymm0, (%rbx,%rsi,4)
	cmpl	%ecx, %r11d
	ja	.L220
.L221:
	movl	$1, %edi
	subl	%edx, %edi
	leal	1(%r10), %eax
	negl	%r8d
	movl	%edi, %edx
	addq	-112(%rbp), %r9
	cmpl	%r10d, -52(%rbp)
	je	.L214
	movl	%eax, %r10d
	jmp	.L217
	.p2align 4,,10
	.p2align 3
.L214:
	movl	-80(%rbp), %ecx
	movl	-76(%rbp), %esi
	movl	-52(%rbp), %edi
	movq	%r15, %rdx
	vmovaps	%ymm1, -144(%rbp)
	vmovaps	%ymm2, -112(%rbp)
	vzeroupper
	call	set_bnd.constprop.0
	decl	-56(%rbp)
	vmovaps	-112(%rbp), %ymm2
	vmovaps	-144(%rbp), %ymm1
	jne	.L222
	movl	-80(%rbp), %r13d
	subq	$8, %rsp
	pushq	%r13
	movq	-168(%rbp), %r14
	movq	-72(%rbp), %rbx
	movl	-52(%rbp), %r12d
	movq	-64(%rbp), %r9
	movl	-76(%rbp), %esi
	movq	%r14, %r8
	movq	%r15, %rcx
	movq	%rbx, %rdx
	movl	%r12d, %edi
	vzeroupper
	call	project
	pushq	%r13
	vmovss	-156(%rbp), %xmm0
	movl	-76(%rbp), %esi
	pushq	%r15
	movq	%rbx, %r9
	movq	%rbx, %r8
	movq	%r14, %rcx
	movl	%r12d, %edi
	movl	$1, %edx
	call	advect
	addq	$32, %rsp
	pushq	%r13
	vmovss	-156(%rbp), %xmm0
	movq	-64(%rbp), %rcx
	pushq	%r15
	movl	-76(%rbp), %esi
	movq	%rbx, %r9
	movq	%r15, %r8
	movl	%r12d, %edi
	movl	$2, %edx
	call	advect
	movq	-64(%rbp), %rcx
	movl	-76(%rbp), %esi
	movq	%r14, %rdx
	movq	%r15, %r9
	movq	%rbx, %r8
	movl	%r12d, %edi
	movl	%r13d, (%rsp)
	call	project
	popq	%rax
	popq	%rdx
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-16(%r13), %rsp
	.cfi_def_cfa 7, 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	GOMP_barrier@PLT
.L194:
	.cfi_restore_state
	movl	%eax, %eax
	xorl	%edx, %edx
.L202:
	movq	-64(%rbp), %rcx
	vmovss	-156(%rbp), %xmm0
	vmovss	(%rcx,%rdx,4), %xmm6
	vfmadd132ss	(%r15,%rdx,4), %xmm6, %xmm0
	vmovss	%xmm0, (%rcx,%rdx,4)
	incq	%rdx
	cmpq	%rax, %rdx
	jne	.L202
	jmp	.L198
.L186:
	movl	%eax, %ecx
	xorl	%edx, %edx
.L192:
	vmovss	(%r14,%rdx,4), %xmm7
	movq	-72(%rbp), %rbx
	vmovss	-156(%rbp), %xmm0
	vfmadd132ss	(%rbx,%rdx,4), %xmm7, %xmm0
	vmovss	%xmm0, (%r14,%rdx,4)
	incq	%rdx
	cmpq	%rdx, %rcx
	jne	.L192
	jmp	.L193
.L223:
	movl	%eax, %ecx
	xorl	%edx, %edx
	jmp	.L187
.L224:
	movl	%eax, %ecx
	xorl	%edx, %edx
	jmp	.L195
	.cfi_endproc
.LFE5515:
	.size	vel_step, .-vel_step
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	-2147483648
	.long	0
	.long	0
	.long	0
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	1056964608
	.align 4
.LC2:
	.long	1065353216
	.align 4
.LC3:
	.long	-1090519040
	.align 4
.LC4:
	.long	-1073741824
	.align 4
.LC6:
	.long	1082130432
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
