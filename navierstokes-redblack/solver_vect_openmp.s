	.file	"solver_vect_openmp.c"
	.text
	.p2align 4
	.type	set_bnd, @function
set_bnd:
.LFB29:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edi, %edi
	movq	%rdi, %rcx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	shrq	%rcx
	movq	%rdi, %rax
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
	leal	2(%rdi), %ebx
	movq	%rbx, %r10
	shrq	%r10
	movl	%esi, -56(%rsp)
	movq	%rdx, %rsi
	leal	1(%rdi), %edx
	movl	%edi, -76(%rsp)
	movq	%rbx, -64(%rsp)
	movq	%rdi, -24(%rsp)
	movl	%edx, -52(%rsp)
	movq	%rdx, -8(%rsp)
	movq	%rcx, -48(%rsp)
	imulq	%r10, %rdi
	movq	%rdx, %rcx
	imulq	%r10, %rbx
	imulq	%r10, %rdx
	shrq	%rcx
	movq	%rcx, -40(%rsp)
	movq	%rdi, -16(%rsp)
	movq	%rdx, -32(%rsp)
	movq	%rbx, %r13
	testl	%eax, %eax
	je	.L6
	vmovss	.LC1(%rip), %xmm1
	movl	$1, %edi
	vmovaps	%xmm1, %xmm2
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L3:
	vmovss	%xmm0, (%r9)
	vmovss	(%r15), %xmm0
	cmpl	$2, -56(%rsp)
	vmovss	%xmm0, (%r14)
	jne	.L4
	imulq	%r10, %rbp
	addq	%rax, %rbx
	addq	-16(%rsp), %rbx
	addq	-72(%rsp), %rbp
	vmovss	(%rsi,%rbp,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%r12)
	vmovss	(%rsi,%rbx,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
.L5:
	addq	%r8, %rax
	addq	-32(%rsp), %rax
	incl	%edi
	vmovss	%xmm0, (%rsi,%rax,4)
	cmpl	%edi, -76(%rsp)
	jb	.L6
.L2:
	movl	-76(%rsp), %edx
	movl	%edi, %eax
	xorl	%edi, %edx
	andl	$1, %edx
	movq	%rax, %r11
	imulq	%r10, %r11
	movq	%rdx, %rbx
	imulq	%r13, %rbx
	movq	-48(%rsp), %r14
	movl	%edi, %ecx
	leaq	(%r11,%r14), %r8
	addq	%rbx, %r8
	leaq	(%rsi,%r8,4), %r15
	movl	-52(%rsp), %r8d
	movq	-64(%rsp), %rbp
	xorl	%edi, %r8d
	andl	$1, %r8d
	notl	%ecx
	imulq	%r13, %r8
	movq	-40(%rsp), %r14
	andl	$1, %ecx
	imulq	%rcx, %rbp
	leaq	(%r11,%r14), %r9
	addq	%r8, %r9
	leaq	(%rsi,%r9,4), %r14
	leaq	0(%rbp,%rax), %r9
	imulq	%r10, %r9
	shrq	%rax
	vmovss	(%rsi,%r9,4), %xmm0
	leaq	(%rax,%r10), %r9
	movq	%r9, -72(%rsp)
	movl	%edi, %r9d
	andl	$1, %r9d
	imulq	%r13, %r9
	leaq	(%r9,%rax), %r12
	addq	%r11, %r9
	cmpl	$1, -56(%rsp)
	leaq	(%rsi,%r12,4), %r12
	leaq	(%rsi,%r9,4), %r9
	jne	.L3
	vxorps	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%r9)
	vmovss	(%r15), %xmm0
	vxorps	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%r14)
.L4:
	imulq	-64(%rsp), %rdx
	imulq	%r13, %rcx
	addq	-24(%rsp), %rdx
	imulq	%r10, %rdx
	addq	-72(%rsp), %rcx
	vmovss	(%rsi,%rcx,4), %xmm0
	addq	%rax, %rdx
	vmovss	%xmm0, (%r12)
	vmovss	(%rsi,%rdx,4), %xmm0
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L6:
	movl	-52(%rsp), %r15d
	leaq	(%r10,%r13), %rax
	vmovss	(%rsi,%rax,4), %xmm0
	movl	%r15d, %ecx
	movq	-64(%rsp), %rdi
	movl	-76(%rsp), %r14d
	vaddss	(%rsi,%r13,4), %xmm0, %xmm0
	notl	%ecx
	vmovss	.LC0(%rip), %xmm1
	andl	$1, %ecx
	imulq	%rdi, %rcx
	movl	%r14d, %edx
	movq	-8(%rsp), %rbx
	vmulss	%xmm1, %xmm0, %xmm0
	andl	$1, %edx
	imulq	%rdi, %rdx
	movq	-24(%rsp), %r11
	leaq	0(,%r10,4), %r8
	leaq	(%rcx,%rbx), %r9
	imulq	%r8, %r9
	addq	%rdx, %r11
	vmovss	%xmm0, (%rsi)
	imulq	%r8, %r11
	vmovss	(%rsi,%r9), %xmm0
	movl	%r15d, %eax
	vaddss	(%rsi,%r11), %xmm0, %xmm0
	andl	$1, %eax
	imulq	%rdi, %rax
	vmulss	%xmm1, %xmm0, %xmm0
	imulq	%r10, %rcx
	leaq	(%rax,%rbx), %rdi
	imulq	%r8, %rdi
	movq	-40(%rsp), %rbx
	imulq	%r10, %rdx
	vmovss	%xmm0, (%rsi,%rdi)
	leaq	(%r10,%rbx), %rdi
	addq	%rdi, %rcx
	movq	-48(%rsp), %rdi
	vmovss	(%rsi,%rcx,4), %xmm0
	addq	%rdi, %rdx
	vaddss	(%rsi,%rdx,4), %xmm0, %xmm0
	imulq	%r10, %rax
	movq	%rbx, %rcx
	vmulss	%xmm1, %xmm0, %xmm0
	addq	%rbx, %rax
	vmovss	%xmm0, (%rsi,%rax,4)
	movl	%r14d, %eax
	xorl	%r15d, %eax
	andl	$1, %eax
	imulq	%r13, %rax
	movq	-32(%rsp), %r15
	addq	%rax, %rdi
	movq	%rdi, %rdx
	addq	%r15, %rdx
	vmovss	(%rsi,%rdx,4), %xmm0
	addq	%rbx, %rax
	addq	-16(%rsp), %rax
	vaddss	(%rsi,%rax,4), %xmm0, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	vmulss	%xmm1, %xmm0, %xmm0
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	addq	%r15, %rcx
	popq	%r14
	.cfi_def_cfa_offset 16
	vmovss	%xmm0, (%rsi,%rcx,4)
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE29:
	.size	set_bnd, .-set_bnd
	.p2align 4
	.type	add_source._omp_fn.0, @function
add_source._omp_fn.0:
.LFB5510:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	.cfi_offset 3, -48
	movl	20(%rdi), %ebx
	andq	$-32, %rsp
	testl	%ebx, %ebx
	je	.L39
	movq	%rdi, %r13
	call	omp_get_num_threads@PLT
	movl	%eax, %r12d
	call	omp_get_thread_num@PLT
	movl	%eax, %ecx
	xorl	%edx, %edx
	movl	%ebx, %eax
	divl	%r12d
	cmpl	%edx, %ecx
	jb	.L16
.L27:
	imull	%eax, %ecx
	addl	%ecx, %edx
	leal	(%rax,%rdx), %r10d
	cmpl	%r10d, %edx
	jnb	.L39
	movq	0(%r13), %rdi
	movl	%edx, %r11d
	movq	8(%r13), %r9
	leaq	0(,%r11,4), %rcx
	leaq	(%rdi,%rcx), %rsi
	leaq	4(%rcx), %rbx
	leaq	(%r9,%rbx), %r14
	movq	%rsi, %r12
	subq	%r14, %r12
	vmovss	16(%r13), %xmm1
	leal	-1(%rax), %r8d
	leaq	1(%r11), %r13
	cmpq	$24, %r12
	jbe	.L18
	cmpl	$2, %r8d
	jbe	.L18
	cmpl	$6, %r8d
	jbe	.L28
	movl	%eax, %r8d
	shrl	$3, %r8d
	leaq	(%r9,%rcx), %rbx
	vbroadcastss	%xmm1, %ymm2
	salq	$5, %r8
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L20:
	vmovups	(%rbx,%rcx), %ymm0
	vfmadd213ps	(%rsi,%rcx), %ymm2, %ymm0
	vmovups	%ymm0, (%rsi,%rcx)
	addq	$32, %rcx
	cmpq	%r8, %rcx
	jne	.L20
	movl	%eax, %ecx
	andl	$-8, %ecx
	addl	%ecx, %edx
	cmpl	%ecx, %eax
	je	.L37
	subl	%ecx, %eax
	leal	-1(%rax), %esi
	cmpl	$2, %esi
	jbe	.L41
	vzeroupper
.L19:
	addq	%r11, %rcx
	leaq	(%rdi,%rcx,4), %rsi
	vmovups	(%rsi), %xmm3
	vshufps	$0, %xmm1, %xmm1, %xmm0
	vfmadd132ps	(%r9,%rcx,4), %xmm3, %xmm0
	movl	%eax, %ecx
	andl	$-4, %ecx
	addl	%ecx, %edx
	vmovups	%xmm0, (%rsi)
	cmpl	%ecx, %eax
	je	.L39
.L23:
	movl	%edx, %ecx
	vmovss	(%r9,%rcx,4), %xmm0
	leaq	(%rdi,%rcx,4), %rax
	vfmadd213ss	(%rax), %xmm1, %xmm0
	vmovss	%xmm0, (%rax)
	leal	1(%rdx), %eax
	cmpl	%eax, %r10d
	jbe	.L39
	vmovss	(%r9,%rax,4), %xmm0
	leaq	(%rdi,%rax,4), %rcx
	vfmadd213ss	(%rcx), %xmm1, %xmm0
	addl	$2, %edx
	vmovss	%xmm0, (%rcx)
	cmpl	%edx, %r10d
	jbe	.L39
	leaq	(%rdi,%rdx,4), %rax
	vmovss	(%rax), %xmm4
	vfmadd132ss	(%r9,%rdx,4), %xmm4, %xmm1
	vmovss	%xmm1, (%rax)
.L39:
	leaq	-32(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L16:
	.cfi_restore_state
	incl	%eax
	xorl	%edx, %edx
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L18:
	movl	%r8d, %eax
	addq	%r13, %rax
	salq	$2, %rax
	jmp	.L25
	.p2align 4,,10
	.p2align 3
.L42:
	addq	$4, %rbx
.L25:
	vmovss	(%r9,%rcx), %xmm0
	vfmadd213ss	(%rdi,%rcx), %xmm1, %xmm0
	vmovss	%xmm0, (%rdi,%rcx)
	movq	%rbx, %rcx
	cmpq	%rax, %rbx
	jne	.L42
	jmp	.L39
.L37:
	vzeroupper
	jmp	.L39
.L28:
	xorl	%ecx, %ecx
	jmp	.L19
.L41:
	vzeroupper
	jmp	.L23
	.cfi_endproc
.LFE5510:
	.size	add_source._omp_fn.0, .-add_source._omp_fn.0
	.p2align 4
	.type	advect._omp_fn.0, @function
advect._omp_fn.0:
.LFB5512:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	32(%rdi), %ebx
	leal	1(%rbx), %eax
	movl	%eax, 56(%rsp)
	cmpl	$1, %eax
	jbe	.L64
	movq	%rdi, %rbp
	call	omp_get_num_threads@PLT
	movl	%eax, %r12d
	call	omp_get_thread_num@PLT
	movl	%eax, %ecx
	xorl	%edx, %edx
	movl	%ebx, %eax
	divl	%r12d
	cmpl	%edx, %ecx
	jb	.L45
.L59:
	imull	%eax, %ecx
	addl	%ecx, %edx
	addl	%edx, %eax
	cmpl	%eax, %edx
	jnb	.L64
	movq	24(%rbp), %rdi
	incl	%eax
	vxorps	%xmm3, %xmm3, %xmm3
	vcvtsi2ssq	%rbx, %xmm3, %xmm6
	movl	%eax, 60(%rsp)
	leal	2(%rbx), %eax
	movq	%rax, %r14
	movq	%rdi, 24(%rsp)
	movq	16(%rbp), %rdi
	movq	0(%rbp), %rcx
	vmovss	.LC0(%rip), %xmm2
	shrq	%r14
	movq	%rdi, 32(%rsp)
	movq	%rax, 48(%rsp)
	leal	1(%rdx), %edi
	imulq	%r14, %rax
	movq	%rcx, 40(%rsp)
	movl	%edi, 4(%rsp)
	vaddss	%xmm2, %xmm6, %xmm6
	vmovss	36(%rbp), %xmm4
	movq	8(%rbp), %r11
	vmovss	.LC2(%rip), %xmm7
	movq	%rax, %r15
	.p2align 4,,10
	.p2align 3
.L58:
	movl	4(%rsp), %eax
	movl	$1, %r10d
	vcvtsi2ssq	%rax, %xmm3, %xmm5
	movq	%rax, 16(%rsp)
	movl	56(%rsp), %eax
	movq	%rax, 8(%rsp)
	jmp	.L57
	.p2align 4,,10
	.p2align 3
.L67:
	vminss	%xmm1, %xmm6, %xmm1
	vcvttss2sil	%xmm1, %eax
	vcvtsi2ssl	%eax, %xmm3, %xmm8
	leal	1(%rax), %ebp
	movslq	%ebp, %rbx
	movslq	%eax, %r8
	vsubss	%xmm8, %xmm1, %xmm9
	shrq	%rbx
	vsubss	%xmm1, %xmm7, %xmm1
	shrq	%r8
	vcomiss	%xmm0, %xmm2
	vaddss	%xmm8, %xmm1, %xmm1
	ja	.L61
.L68:
	vminss	%xmm0, %xmm6, %xmm0
	vcvttss2sil	%xmm0, %esi
	vcvtsi2ssl	%esi, %xmm3, %xmm8
	movl	%esi, %edi
	movl	%esi, %ecx
	leal	1(%rsi), %edx
	vsubss	%xmm8, %xmm0, %xmm10
	vsubss	%xmm0, %xmm7, %xmm0
	movslq	%esi, %rsi
	imulq	%r14, %rsi
	vaddss	%xmm8, %xmm0, %xmm8
	xorl	%eax, %edi
	leaq	(%rsi,%r8), %r13
	leaq	(%r14,%rsi), %r9
	xorl	%ebp, %ecx
	addq	%rbx, %rsi
.L54:
	xorl	%edx, %eax
	xorl	%ebp, %edx
	andl	$1, %eax
	andl	$1, %edx
	imulq	%r15, %rax
	imulq	%r15, %rdx
	addq	%r9, %r8
	addq	%rbx, %r9
	addq	%rax, %r8
	addq	%rdx, %r9
	vmulss	(%r11,%r8,4), %xmm10, %xmm0
	andl	$1, %edi
	vmulss	(%r11,%r9,4), %xmm10, %xmm10
	andl	$1, %ecx
	imulq	%r15, %rdi
	imulq	%r15, %rcx
	movq	40(%rsp), %rax
	addq	%r13, %rdi
	addq	%rsi, %rcx
	vfmadd231ss	(%r11,%rdi,4), %xmm8, %xmm0
	vfmadd132ss	(%r11,%rcx,4), %xmm10, %xmm8
	incq	%r10
	vmulss	%xmm9, %xmm8, %xmm8
	vfmadd231ss	%xmm1, %xmm0, %xmm8
	vmovss	%xmm8, (%rax,%r12)
	cmpq	8(%rsp), %r10
	je	.L66
.L57:
	movl	4(%rsp), %eax
	movq	%r10, %rdx
	xorl	%r10d, %eax
	andl	$1, %eax
	imulq	48(%rsp), %rax
	shrq	%rdx
	movq	32(%rsp), %rbx
	addq	16(%rsp), %rax
	imulq	%r14, %rax
	movq	24(%rsp), %rsi
	vmovaps	%xmm4, %xmm0
	addq	%rdx, %rax
	movl	%r10d, %edx
	vcvtsi2ssq	%rdx, %xmm3, %xmm1
	vfnmadd132ss	(%rsi,%rax,4), %xmm5, %xmm0
	leaq	0(,%rax,4), %r12
	vfnmadd231ss	(%rbx,%rax,4), %xmm4, %xmm1
	vcomiss	%xmm1, %xmm2
	jbe	.L67
	xorl	%r8d, %r8d
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	vcomiss	%xmm0, %xmm2
	vmovaps	%xmm2, %xmm1
	vmovaps	%xmm2, %xmm9
	movl	$1, %ebp
	jbe	.L68
.L61:
	movq	%rbx, %rsi
	movq	%r14, %r9
	movq	%r8, %r13
	movl	%ebp, %ecx
	movl	%eax, %edi
	vmovaps	%xmm2, %xmm8
	vmovaps	%xmm2, %xmm10
	movl	$1, %edx
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L66:
	incl	4(%rsp)
	movl	4(%rsp), %eax
	cmpl	%eax, 60(%rsp)
	ja	.L58
.L64:
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
.L45:
	.cfi_restore_state
	incl	%eax
	xorl	%edx, %edx
	jmp	.L59
	.cfi_endproc
.LFE5512:
	.size	advect._omp_fn.0, .-advect._omp_fn.0
	.p2align 4
	.type	project._omp_fn.0, @function
project._omp_fn.0:
.LFB5513:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movl	32(%rdi), %r14d
	leal	1(%r14), %eax
	cmpl	$1, %eax
	jbe	.L82
	movq	%rdi, %rbx
	call	omp_get_num_threads@PLT
	movl	%eax, %ebp
	call	omp_get_thread_num@PLT
	movl	%eax, %ecx
	xorl	%edx, %edx
	movl	%r14d, %eax
	divl	%ebp
	cmpl	%edx, %ecx
	jb	.L71
.L78:
	imull	%eax, %ecx
	addl	%ecx, %edx
	addl	%edx, %eax
	cmpl	%eax, %edx
	jnb	.L82
	incl	%eax
	movl	%eax, 44(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	movl	%r14d, %eax
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	vmovss	.LC3(%rip), %xmm2
	movq	24(%rbx), %rsi
	leal	2(%r14), %r15d
	vdivss	%xmm0, %xmm2, %xmm2
	leal	2(%rdx), %eax
	movq	%rsi, 16(%rsp)
	movq	%rax, (%rsp)
	movq	16(%rbx), %rsi
	movq	8(%rbx), %r13
	movq	(%rbx), %r12
	movq	%r15, %rbp
	leal	1(%rdx), %ebx
	leal	-1(%r14), %eax
	movl	%ebx, 40(%rsp)
	shrq	%rbp
	movq	%r15, %rbx
	addq	$3, %rax
	movq	%rsi, 24(%rsp)
	imulq	%rbp, %rbx
	movq	%rax, 32(%rsp)
	.p2align 4,,10
	.p2align 3
.L76:
	movl	40(%rsp), %r10d
	movl	$2, %esi
	movq	%r10, %rax
	movl	%eax, %r11d
	incl	%eax
	movl	%eax, 40(%rsp)
	leal	-1(%r11), %eax
	imulq	%rbp, %r10
	movq	%rax, 8(%rsp)
	movq	%rax, %r14
	.p2align 4,,10
	.p2align 3
.L75:
	leal	-1(%rsi), %eax
	movl	%r11d, %edi
	xorl	%eax, %edi
	movl	%r11d, %ecx
	xorl	%esi, %ecx
	andl	$1, %edi
	leaq	-1(%rsi), %r8
	imulq	%rbx, %rdi
	andl	$1, %ecx
	shrq	%r8
	imulq	%rbx, %rcx
	leaq	(%r8,%r10), %rdx
	addq	%rdx, %rdi
	movq	%rsi, %rdx
	shrq	%rdx
	addq	%r10, %rcx
	addq	%rdx, %rcx
	movl	%r11d, %edx
	xorl	%esi, %edx
	andl	$1, %edx
	imulq	%rbx, %rdx
	leaq	-2(%rsi), %r9
	vmovss	(%r12,%rcx,4), %xmm0
	shrq	%r9
	addq	%r10, %rdx
	addq	%r9, %rdx
	vsubss	(%r12,%rdx,4), %xmm0, %xmm0
	movl	40(%rsp), %edx
	incq	%rsi
	xorl	%eax, %edx
	andl	$1, %edx
	imulq	%r15, %rdx
	xorl	%r14d, %eax
	andl	$1, %eax
	imulq	%r15, %rax
	addq	(%rsp), %rdx
	imulq	%rbp, %rdx
	addq	8(%rsp), %rax
	imulq	%rbp, %rax
	addq	%r8, %rdx
	vmovss	0(%r13,%rdx,4), %xmm1
	addq	%r8, %rax
	vsubss	0(%r13,%rax,4), %xmm1, %xmm1
	movq	16(%rsp), %rax
	vaddss	%xmm1, %xmm0, %xmm0
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rax,%rdi,4)
	movq	24(%rsp), %rax
	movl	$0x00000000, (%rax,%rdi,4)
	cmpq	%rsi, 32(%rsp)
	jne	.L75
	movl	40(%rsp), %esi
	incq	(%rsp)
	cmpl	%esi, 44(%rsp)
	ja	.L76
.L82:
	addq	$56, %rsp
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
.L71:
	.cfi_restore_state
	incl	%eax
	xorl	%edx, %edx
	jmp	.L78
	.cfi_endproc
.LFE5513:
	.size	project._omp_fn.0, .-project._omp_fn.0
	.p2align 4
	.type	project._omp_fn.1, @function
project._omp_fn.1:
.LFB5514:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movl	24(%rdi), %ebx
	leal	1(%rbx), %eax
	cmpl	$1, %eax
	jbe	.L97
	movq	%rdi, %rbp
	call	omp_get_num_threads@PLT
	movl	%eax, %r12d
	call	omp_get_thread_num@PLT
	movl	%eax, %ecx
	xorl	%edx, %edx
	movl	%ebx, %eax
	divl	%r12d
	cmpl	%edx, %ecx
	jb	.L86
.L93:
	imull	%eax, %ecx
	addl	%ecx, %edx
	addl	%edx, %eax
	cmpl	%eax, %edx
	jnb	.L97
	incl	%eax
	movl	%eax, 44(%rsp)
	vxorps	%xmm1, %xmm1, %xmm1
	movl	%ebx, %eax
	vcvtsi2ssq	%rax, %xmm1, %xmm1
	movq	8(%rbp), %rdi
	leal	2(%rbx), %r15d
	leal	2(%rdx), %eax
	movq	%rdi, 16(%rsp)
	movq	%rax, (%rsp)
	movq	0(%rbp), %rdi
	movq	%r15, %r13
	leal	-1(%rbx), %eax
	vmulss	.LC0(%rip), %xmm1, %xmm1
	movq	16(%rbp), %r9
	shrq	%r13
	movq	%r15, %rbp
	addq	$3, %rax
	movq	%rdi, 24(%rsp)
	imulq	%r13, %rbp
	movq	%rax, 32(%rsp)
	leal	1(%rdx), %r14d
	.p2align 4,,10
	.p2align 3
.L91:
	movl	%r14d, %ebx
	movl	%r14d, %r11d
	leal	-1(%rbx), %eax
	imulq	%r13, %r11
	movl	%eax, 40(%rsp)
	movq	%rax, 8(%rsp)
	incl	%r14d
	movl	$2, %edi
	.p2align 4,,10
	.p2align 3
.L90:
	leal	-1(%rdi), %eax
	movl	%ebx, %edx
	xorl	%eax, %edx
	andl	$1, %edx
	leaq	-1(%rdi), %r8
	imulq	%rbp, %rdx
	shrq	%r8
	leaq	(%r8,%r11), %rcx
	movq	24(%rsp), %rsi
	addq	%rcx, %rdx
	salq	$2, %rdx
	leaq	(%rsi,%rdx), %r12
	movl	%ebx, %esi
	xorl	%edi, %esi
	andl	$1, %esi
	imulq	%rbp, %rsi
	movq	%rdi, %rcx
	shrq	%rcx
	addq	%r11, %rsi
	addq	%rcx, %rsi
	movl	%ebx, %ecx
	xorl	%edi, %ecx
	andl	$1, %ecx
	imulq	%rbp, %rcx
	leaq	-2(%rdi), %r10
	vmovss	(%r9,%rsi,4), %xmm0
	shrq	%r10
	addq	%r11, %rcx
	addq	%r10, %rcx
	vsubss	(%r9,%rcx,4), %xmm0, %xmm0
	movl	%eax, %ecx
	xorl	%r14d, %ecx
	andl	$1, %ecx
	imulq	%r15, %rcx
	xorl	40(%rsp), %eax
	andl	$1, %eax
	vfnmadd213ss	(%r12), %xmm1, %xmm0
	imulq	%r15, %rax
	addq	(%rsp), %rcx
	imulq	%r13, %rcx
	addq	8(%rsp), %rax
	imulq	%r13, %rax
	vmovss	%xmm0, (%r12)
	addq	%r8, %rcx
	vmovss	(%r9,%rcx,4), %xmm0
	addq	%r8, %rax
	vsubss	(%r9,%rax,4), %xmm0, %xmm0
	addq	16(%rsp), %rdx
	incq	%rdi
	vfnmadd213ss	(%rdx), %xmm1, %xmm0
	vmovss	%xmm0, (%rdx)
	cmpq	%rdi, 32(%rsp)
	jne	.L90
	incq	(%rsp)
	cmpl	%r14d, 44(%rsp)
	ja	.L91
.L97:
	addq	$56, %rsp
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
.L86:
	.cfi_restore_state
	incl	%eax
	xorl	%edx, %edx
	jmp	.L93
	.cfi_endproc
.LFE5514:
	.size	project._omp_fn.1, .-project._omp_fn.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"solver_vect_openmp.c"
.LC6:
	.string	"threads <= n"
	.text
	.p2align 4
	.type	lin_solve._omp_fn.0, @function
lin_solve._omp_fn.0:
.LFB5511:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	addq	$-128, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	16(%rdi), %rdx
	vmovss	48(%rdi), %xmm3
	movq	%rdx, 8(%rsp)
	movq	(%rdi), %rdx
	movl	40(%rdi), %eax
	movq	%rdx, 24(%rsp)
	movl	44(%rdi), %edx
	movq	32(%rdi), %rbx
	movl	%edx, 96(%rsp)
	movq	24(%rdi), %r12
	movq	8(%rdi), %r15
	movl	52(%rdi), %r13d
	vmovss	%xmm3, 112(%rsp)
	movl	%eax, 100(%rsp)
	call	omp_get_thread_num@PLT
	movl	%eax, %r14d
	call	omp_get_max_threads@PLT
	movl	100(%rsp), %esi
	movl	%eax, %ecx
	cmpl	%eax, %esi
	jb	.L100
	xorl	%edx, %edx
	movl	%esi, %eax
	divl	%ecx
	vmovss	.LC2(%rip), %xmm2
	vmovss	112(%rsp), %xmm3
	movl	$20, 20(%rsp)
	vmovd	%r13d, %xmm6
	vdivss	%xmm6, %xmm2, %xmm2
	movl	%r14d, %ecx
	vbroadcastss	%xmm3, %ymm3
	vmovaps	%ymm3, 32(%rsp)
	imull	%eax, %ecx
	leal	(%rax,%rcx), %edx
	addl	%edx, %eax
	cmpl	%eax, %esi
	movl	%esi, %eax
	cmovb	%esi, %edx
	addl	$2, %eax
	shrl	%eax
	movl	%eax, %r14d
	movl	%ecx, %eax
	imull	%r14d, %eax
	subl	%ecx, %edx
	movl	%edx, 124(%rsp)
	salq	$2, %rax
	leal	-1(%r14), %edx
	movq	%rax, (%rsp)
	movl	%edx, 120(%rsp)
	vbroadcastss	%xmm2, %ymm2
	addq	%rax, %r12
	addq	%rax, %rbx
	addq	%rax, %r15
	vmovaps	%ymm2, 64(%rsp)
	.p2align 4,,10
	.p2align 3
.L102:
	movl	124(%rsp), %eax
	testl	%eax, %eax
	je	.L103
	movl	%r14d, %eax
	movq	%rax, 112(%rsp)
	vmovaps	64(%rsp), %ymm2
	vmovaps	32(%rsp), %ymm3
	xorl	%r11d, %r11d
	movl	$1, %r9d
	movl	$1, %r13d
	.p2align 4,,10
	.p2align 3
.L104:
	movl	120(%rsp), %eax
	leal	(%r11,%rax), %r10d
	cmpl	%r11d, %r10d
	jbe	.L108
	movl	%r13d, %r8d
	imulq	112(%rsp), %r8
	movl	%r11d, %edx
	.p2align 4,,10
	.p2align 3
.L105:
	movl	%edx, %eax
	addq	%r8, %rax
	movslq	%eax, %rcx
	movl	%eax, %edi
	leal	(%r9,%rax), %esi
	addl	%r14d, %eax
	movslq	%esi, %rsi
	movl	%eax, %eax
	vmovups	(%rbx,%rsi,4), %ymm0
	vmovups	(%rbx,%rax,4), %ymm4
	subl	%r14d, %edi
	vaddps	(%rbx,%rdi,4), %ymm0, %ymm0
	vaddps	(%rbx,%rcx,4), %ymm4, %ymm1
	addl	$8, %edx
	vaddps	%ymm1, %ymm0, %ymm0
	vfmadd213ps	(%r15,%rcx,4), %ymm3, %ymm0
	vmulps	%ymm0, %ymm2, %ymm0
	vmovups	%ymm0, (%r12,%rcx,4)
	cmpl	%edx, %r10d
	ja	.L105
.L108:
	movl	$1, %eax
	subl	%r11d, %eax
	incl	%r13d
	negl	%r9d
	movl	%eax, %r11d
	cmpl	%r13d, 124(%rsp)
	jnb	.L104
	vzeroupper
	call	GOMP_barrier@PLT
	movq	8(%rsp), %rax
	movq	(%rsp), %rdx
	movl	$1, %ecx
	movq	112(%rsp), %r9
	vmovaps	64(%rsp), %ymm2
	vmovaps	32(%rsp), %ymm3
	movq	%r15, 104(%rsp)
	movl	$1, %r13d
	movl	$-1, %r8d
	leaq	(%rax,%rdx), %r11
	movl	%ecx, %r15d
	.p2align 4,,10
	.p2align 3
.L114:
	movl	120(%rsp), %eax
	movl	%r13d, %edx
	leal	0(%r13,%rax), %r10d
	cmpl	%r13d, %r10d
	jbe	.L111
	.p2align 4,,10
	.p2align 3
.L109:
	movl	%edx, %eax
	addq	%r9, %rax
	movslq	%eax, %rcx
	movl	%eax, %edi
	leal	(%r8,%rax), %esi
	addl	%r14d, %eax
	movslq	%esi, %rsi
	movl	%eax, %eax
	vmovups	(%r12,%rsi,4), %ymm0
	vmovups	(%r12,%rax,4), %ymm5
	subl	%r14d, %edi
	vaddps	(%r12,%rdi,4), %ymm0, %ymm0
	vaddps	(%r12,%rcx,4), %ymm5, %ymm1
	addl	$8, %edx
	vaddps	%ymm1, %ymm0, %ymm0
	vfmadd213ps	(%r11,%rcx,4), %ymm3, %ymm0
	vmulps	%ymm0, %ymm2, %ymm0
	vmovups	%ymm0, (%rbx,%rcx,4)
	cmpl	%r10d, %edx
	jb	.L109
.L111:
	movl	$1, %edx
	subl	%r13d, %edx
	leal	1(%r15), %eax
	negl	%r8d
	movl	%edx, %r13d
	addq	112(%rsp), %r9
	cmpl	%r15d, 124(%rsp)
	je	.L121
	movl	%eax, %r15d
	jmp	.L114
	.p2align 4,,10
	.p2align 3
.L121:
	movq	104(%rsp), %r15
	vzeroupper
.L110:
	call	GOMP_barrier@PLT
	movq	24(%rsp), %rdx
	movl	96(%rsp), %esi
	movl	100(%rsp), %edi
	call	set_bnd
	decl	20(%rsp)
	jne	.L102
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L103:
	.cfi_restore_state
	vzeroupper
	call	GOMP_barrier@PLT
	jmp	.L110
.L100:
	leaq	__PRETTY_FUNCTION__.0(%rip), %rcx
	movl	$89, %edx
	leaq	.LC5(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	call	__assert_fail@PLT
	.cfi_endproc
.LFE5511:
	.size	lin_solve._omp_fn.0, .-lin_solve._omp_fn.0
	.p2align 4
	.type	set_bnd.constprop.0, @function
set_bnd.constprop.0:
.LFB5515:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edi, %eax
	movq	%rsi, %rcx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leal	1(%rax), %esi
	movq	%rsi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leal	2(%rax), %r13d
	movq	%r13, %r11
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	shrq	%r11
	movq	%rax, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%r13, %rbp
	imulq	%r11, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rax, %rbx
	shrq	%r12
	movq	%rax, -16(%rsp)
	movl	%esi, -28(%rsp)
	movq	%rsi, -8(%rsp)
	imulq	%r11, %rax
	imulq	%r11, %rsi
	shrq	%r14
	movq	%rax, -24(%rsp)
	movq	%rsi, %r15
	movl	$1, %r8d
	testl	%ebx, %ebx
	je	.L127
	.p2align 4,,10
	.p2align 3
.L126:
	movl	%r8d, %edi
	notl	%edi
	andl	$1, %edi
	imulq	%r13, %rdi
	movl	%r8d, %esi
	movl	%r8d, %r10d
	leaq	(%rsi,%rdi), %rax
	movl	%ebx, %edx
	imulq	%r11, %rax
	movq	%rsi, %r9
	xorl	%r8d, %edx
	andl	$1, %r10d
	imulq	%r11, %r9
	imulq	%rbp, %r10
	andl	$1, %edx
	imulq	%rbp, %rdx
	vmovss	(%rcx,%rax,4), %xmm0
	leaq	(%r9,%r10), %rax
	vmovss	%xmm0, (%rcx,%rax,4)
	leaq	(%r9,%rdx), %rax
	addq	%r12, %rax
	vmovss	(%rcx,%rax,4), %xmm0
	movl	-28(%rsp), %eax
	imulq	%r11, %rdi
	xorl	%r8d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	shrq	%rsi
	addq	%rsi, %r10
	addq	%rax, %r9
	addq	%r14, %r9
	vmovss	%xmm0, (%rcx,%r9,4)
	leaq	(%rsi,%r11), %r9
	addq	%rdi, %r9
	vmovss	(%rcx,%r9,4), %xmm0
	addq	%rsi, %rdx
	vmovss	%xmm0, (%rcx,%r10,4)
	addq	-24(%rsp), %rdx
	vmovss	(%rcx,%rdx,4), %xmm0
	addq	%rsi, %rax
	addq	%r15, %rax
	incl	%r8d
	vmovss	%xmm0, (%rcx,%rax,4)
	cmpl	%r8d, %ebx
	jnb	.L126
.L127:
	movl	-28(%rsp), %edi
	leaq	(%r11,%rbp), %rax
	vmovss	(%rcx,%rax,4), %xmm0
	movl	%edi, %esi
	vaddss	(%rcx,%rbp,4), %xmm0, %xmm0
	movl	%edi, %eax
	notl	%esi
	vmovss	.LC0(%rip), %xmm1
	andl	$1, %esi
	andl	$1, %eax
	imulq	%r13, %rsi
	imulq	%r13, %rax
	movl	%ebx, %edx
	movq	-8(%rsp), %r8
	vmulss	%xmm1, %xmm0, %xmm0
	andl	$1, %edx
	imulq	%r13, %rdx
	leaq	0(,%r11,4), %r9
	leaq	(%rax,%r8), %rdi
	leaq	(%rsi,%r8), %r10
	movq	-16(%rsp), %r8
	imulq	%r9, %r10
	addq	%rdx, %r8
	vmovss	%xmm0, (%rcx)
	imulq	%r9, %r8
	vmovss	(%rcx,%r10), %xmm0
	imulq	%r9, %rdi
	vaddss	(%rcx,%r8), %xmm0, %xmm0
	imulq	%r11, %rsi
	imulq	%r11, %rdx
	vmulss	%xmm1, %xmm0, %xmm0
	xorl	-28(%rsp), %ebx
	addq	%r12, %rdx
	andl	$1, %ebx
	imulq	%rbp, %rbx
	vmovss	%xmm0, (%rcx,%rdi)
	leaq	(%r11,%r14), %rdi
	addq	%rdi, %rsi
	vmovss	(%rcx,%rsi,4), %xmm0
	imulq	%r11, %rax
	vaddss	(%rcx,%rdx,4), %xmm0, %xmm0
	addq	%rbx, %r12
	addq	%r14, %rax
	vmulss	%xmm1, %xmm0, %xmm0
	addq	%r15, %r12
	addq	%r14, %rbx
	addq	-24(%rsp), %rbx
	vmovss	%xmm0, (%rcx,%rax,4)
	vmovss	(%rcx,%r12,4), %xmm0
	leaq	(%r14,%r15), %rax
	vaddss	(%rcx,%rbx,4), %xmm0, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	vmulss	%xmm1, %xmm0, %xmm0
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	vmovss	%xmm0, (%rcx,%rax,4)
	ret
	.cfi_endproc
.LFE5515:
	.size	set_bnd.constprop.0, .-set_bnd.constprop.0
	.p2align 4
	.type	project, @function
project:
.LFB5507:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	vmovq	%rsi, %xmm1
	vpinsrq	$1, %rdx, %xmm1, %xmm0
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%r8, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rcx, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	leaq	16(%rsp), %r15
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movq	%rcx, 32(%rsp)
	movq	%rdx, 24(%rsp)
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rsi, 16(%rsp)
	movl	%edi, 48(%rsp)
	movq	%r15, %rsi
	leaq	project._omp_fn.0(%rip), %rdi
	movq	%r8, 40(%rsp)
	vmovdqa	%xmm0, (%rsp)
	call	GOMP_parallel@PLT
	movq	%r12, %rsi
	movl	%ebp, %edi
	call	set_bnd.constprop.0
	movq	%rbx, %rsi
	movl	%ebp, %edi
	call	set_bnd.constprop.0
	leal	2(%rbp), %edx
	movl	%edx, %eax
	shrl	%eax
	imull	%edx, %eax
	xorl	%ecx, %ecx
	movq	%r15, %rsi
	salq	$2, %rax
	leaq	(%rbx,%rax), %rdx
	addq	%r12, %rax
	movq	%rax, 32(%rsp)
	movq	.LC7(%rip), %rax
	movq	%rdx, 48(%rsp)
	leaq	lin_solve._omp_fn.0(%rip), %rdi
	xorl	%edx, %edx
	movq	%rax, 64(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%r12, 24(%rsp)
	movq	%rbx, 16(%rsp)
	movl	$0, 60(%rsp)
	movl	%ebp, 56(%rsp)
	call	GOMP_parallel@PLT
	vmovdqa	(%rsp), %xmm0
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	movq	%r15, %rsi
	leaq	project._omp_fn.1(%rip), %rdi
	movq	%rbx, 32(%rsp)
	movl	%ebp, 40(%rsp)
	vmovdqa	%xmm0, 16(%rsp)
	call	GOMP_parallel@PLT
	movq	%r13, %rdx
	movl	$1, %esi
	movl	%ebp, %edi
	call	set_bnd
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L140
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	%ebp, %edi
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	movq	%r14, %rdx
	popq	%r14
	.cfi_def_cfa_offset 16
	movl	$2, %esi
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	set_bnd
.L140:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5507:
	.size	project, .-project
	.p2align 4
	.globl	dens_step
	.type	dens_step, @function
dens_step:
.LFB5508:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	vmovq	%rsi, %xmm4
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%r8, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leal	2(%rdi), %ebx
	leaq	add_source._omp_fn.0(%rip), %rdi
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%rcx, (%rsp)
	vmovss	%xmm0, 12(%rsp)
	leaq	16(%rsp), %r15
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	%ebx, %eax
	imull	%ebx, %eax
	vpinsrq	$1, %rdx, %xmm4, %xmm0
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%r15, %rsi
	movl	%eax, 36(%rsp)
	vmovss	%xmm1, 8(%rsp)
	vmovss	%xmm1, 32(%rsp)
	vmovdqa	%xmm0, 16(%rsp)
	call	GOMP_parallel@PLT
	movl	%ebp, %eax
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtsi2ssq	%rax, %xmm1, %xmm1
	vmovss	8(%rsp), %xmm3
	movl	%ebx, %eax
	vmulss	12(%rsp), %xmm3, %xmm0
	vmulss	%xmm1, %xmm1, %xmm2
	shrl	%eax
	imull	%ebx, %eax
	xorl	%ecx, %ecx
	movq	%r15, %rsi
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	.LC8(%rip), %xmm2
	salq	$2, %rax
	leaq	(%r14,%rax), %rdx
	movq	%rdx, 48(%rsp)
	vfmadd213ss	.LC2(%rip), %xmm0, %xmm2
	addq	%r12, %rax
	xorl	%edx, %edx
	leaq	lin_solve._omp_fn.0(%rip), %rdi
	movq	%rax, 32(%rsp)
	vunpcklps	%xmm2, %xmm0, %xmm0
	vmovss	%xmm1, 12(%rsp)
	movq	%r14, 40(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r14, 16(%rsp)
	movl	$0, 60(%rsp)
	movl	%ebp, 56(%rsp)
	vmovlps	%xmm0, 64(%rsp)
	call	GOMP_parallel@PLT
	vmovss	12(%rsp), %xmm1
	movq	(%rsp), %rax
	vmulss	8(%rsp), %xmm1, %xmm1
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%r15, %rsi
	leaq	advect._omp_fn.0(%rip), %rdi
	movq	%rax, 32(%rsp)
	movq	%r13, 40(%rsp)
	movq	%r14, 24(%rsp)
	movq	%r12, 16(%rsp)
	movl	%ebp, 48(%rsp)
	vmovss	%xmm1, 52(%rsp)
	call	GOMP_parallel@PLT
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L147
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	%ebp, %edi
	popq	%rbp
	.cfi_def_cfa_offset 40
	movq	%r12, %rdx
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	xorl	%esi, %esi
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	set_bnd
.L147:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5508:
	.size	dens_step, .-dens_step
	.p2align 4
	.globl	vel_step
	.type	vel_step, @function
vel_step:
.LFB5509:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	vmovq	%rsi, %xmm4
	movq	%rsi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdx, %r13
	xorl	%edx, %edx
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rcx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%r8, %rbx
	leal	2(%rdi), %r8d
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	vmovss	%xmm0, 12(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	movl	%r8d, %eax
	imull	%r8d, %eax
	leaq	32(%rsp), %r14
	vpinsrq	$1, %rcx, %xmm4, %xmm0
	movq	%r14, %rsi
	xorl	%ecx, %ecx
	leaq	add_source._omp_fn.0(%rip), %rdi
	movl	%r8d, 16(%rsp)
	movl	%eax, 52(%rsp)
	movl	%eax, 24(%rsp)
	vmovss	%xmm1, 8(%rsp)
	vmovss	%xmm1, 48(%rsp)
	vmovdqa	%xmm0, 32(%rsp)
	call	GOMP_parallel@PLT
	vmovq	%r13, %xmm5
	movl	24(%rsp), %eax
	vmovss	8(%rsp), %xmm1
	vpinsrq	$1, %rbx, %xmm5, %xmm0
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%r14, %rsi
	leaq	add_source._omp_fn.0(%rip), %rdi
	movl	%eax, 52(%rsp)
	vmovss	%xmm1, 48(%rsp)
	vmovdqa	%xmm0, 32(%rsp)
	call	GOMP_parallel@PLT
	movl	%ebp, %eax
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	vmovss	8(%rsp), %xmm1
	movl	16(%rsp), %r8d
	vmulss	12(%rsp), %xmm1, %xmm1
	vmulss	%xmm0, %xmm0, %xmm2
	movl	%r8d, %eax
	shrl	%eax
	imull	%r8d, %eax
	xorl	%ecx, %ecx
	vmulss	%xmm2, %xmm1, %xmm1
	vmovss	.LC8(%rip), %xmm2
	salq	$2, %rax
	leaq	(%r12,%rax), %rdx
	movq	%rdx, 64(%rsp)
	vfmadd213ss	.LC2(%rip), %xmm1, %xmm2
	leaq	(%r15,%rax), %rdx
	movq	%rdx, 48(%rsp)
	movq	%r14, %rsi
	xorl	%edx, %edx
	vunpcklps	%xmm2, %xmm1, %xmm3
	leaq	lin_solve._omp_fn.0(%rip), %rdi
	vmovlps	%xmm3, 80(%rsp)
	vmovss	%xmm0, 28(%rsp)
	movq	%rax, 16(%rsp)
	vmovss	%xmm2, 24(%rsp)
	vmovss	%xmm1, 12(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r15, 40(%rsp)
	movq	%r12, 32(%rsp)
	movl	$1, 76(%rsp)
	movl	%ebp, 72(%rsp)
	call	GOMP_parallel@PLT
	movq	16(%rsp), %rax
	vmovss	24(%rsp), %xmm2
	vmovss	12(%rsp), %xmm1
	leaq	(%rbx,%rax), %rdx
	xorl	%ecx, %ecx
	addq	%r13, %rax
	movq	%rdx, 64(%rsp)
	movq	%r14, %rsi
	xorl	%edx, %edx
	leaq	lin_solve._omp_fn.0(%rip), %rdi
	movq	%rax, 48(%rsp)
	vmovss	%xmm2, 84(%rsp)
	vmovss	%xmm1, 80(%rsp)
	movq	%rbx, 56(%rsp)
	movq	%r13, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movl	$2, 76(%rsp)
	movl	%ebp, 72(%rsp)
	call	GOMP_parallel@PLT
	movq	%r13, %r8
	movq	%r15, %rcx
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movl	%ebp, %edi
	call	project
	vmovss	28(%rsp), %xmm0
	leaq	advect._omp_fn.0(%rip), %r8
	vmulss	8(%rsp), %xmm0, %xmm0
	xorl	%ecx, %ecx
	movq	%r8, %rdi
	xorl	%edx, %edx
	movq	%r14, %rsi
	vmovss	%xmm0, 68(%rsp)
	vmovss	%xmm0, 8(%rsp)
	movq	%rbx, 56(%rsp)
	movq	%r12, 48(%rsp)
	movq	%r12, 40(%rsp)
	movq	%r15, 32(%rsp)
	movl	%ebp, 64(%rsp)
	call	GOMP_parallel@PLT
	movq	%r15, %rdx
	movl	$1, %esi
	movl	%ebp, %edi
	call	set_bnd
	vmovss	8(%rsp), %xmm0
	leaq	advect._omp_fn.0(%rip), %r8
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	movq	%r14, %rsi
	movq	%r8, %rdi
	movq	%rbx, 56(%rsp)
	movq	%r12, 48(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%r13, 32(%rsp)
	movl	%ebp, 64(%rsp)
	vmovss	%xmm0, 68(%rsp)
	call	GOMP_parallel@PLT
	movq	%r13, %rdx
	movl	$2, %esi
	movl	%ebp, %edi
	call	set_bnd
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L154
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %r8
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	%ebp, %edi
	popq	%rbp
	.cfi_def_cfa_offset 40
	movq	%r12, %rcx
	popq	%r12
	.cfi_def_cfa_offset 32
	movq	%r13, %rdx
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	movq	%r15, %rsi
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	project
.L154:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5509:
	.size	vel_step, .-vel_step
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.0, @object
	.size	__PRETTY_FUNCTION__.0, 10
__PRETTY_FUNCTION__.0:
	.string	"lin_solve"
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1056964608
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.long	-2147483648
	.long	0
	.long	0
	.long	0
	.set	.LC2,.LC7
	.section	.rodata.cst4
	.align 4
.LC3:
	.long	-1090519040
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC7:
	.long	1065353216
	.long	1082130432
	.set	.LC8,.LC7+4
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
