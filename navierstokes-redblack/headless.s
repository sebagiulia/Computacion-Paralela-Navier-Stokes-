	.file	"headless.c"
	.text
	.p2align 4
	.type	one_step._omp_fn.0, @function
one_step._omp_fn.0:
.LFB34:
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
	movl	$1, %r13d
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
	call	omp_get_thread_num@PLT
	movl	%eax, %r14d
	testl	%eax, %eax
	js	.L13
.L2:
	leal	0(%r13,%r14), %eax
	movl	%eax, 32(%rsp)
	cmpl	%r14d, %eax
	jle	.L8
	movq	v_prev(%rip), %rax
	vmovss	visc(%rip), %xmm4
	movq	%rax, 40(%rsp)
	movq	u_prev(%rip), %rax
	vmovss	%xmm4, 36(%rsp)
	movq	%rax, 48(%rsp)
	call	omp_get_num_threads@PLT
	movl	N(%rip), %ecx
	movl	%eax, %edi
	movl	%eax, 60(%rsp)
	movl	%ecx, %eax
	cltd
	idivl	%edi
	movq	dens_prev(%rip), %r13
	vxorps	%xmm0, %xmm0, %xmm0
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	%xmm2, (%rsp)
	movl	%eax, %r12d
	imull	%eax, %eax
	movl	%r12d, %r15d
	imull	%r14d, %r15d
	vcvtsi2sdl	%eax, %xmm0, %xmm0
	leal	-1(%rdi), %eax
	movl	%r15d, %edi
	movl	%eax, 56(%rsp)
	vmulsd	.LC1(%rip), %xmm0, %xmm5
	movq	%r13, %r15
	movl	%ecx, %eax
	movl	%r14d, %r13d
	movl	%edi, %r14d
	vmovsd	%xmm5, 8(%rsp)
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L14:
	movl	%r12d, %ebp
.L6:
	vmovsd	%xmm2, 24(%rsp)
	movslq	%ebx, %rbx
	call	wtime@PLT
	movq	48(%rsp), %rax
	salq	$2, %rbx
	leaq	(%rax,%rbx), %rcx
	movq	v(%rip), %rdx
	movq	40(%rsp), %rax
	movq	u(%rip), %rsi
	vmovss	dt(%rip), %xmm1
	vmovsd	%xmm0, 16(%rsp)
	vmovss	36(%rsp), %xmm0
	leaq	(%rax,%rbx), %r8
	addq	%rbx, %rdx
	addq	%rbx, %rsi
	movl	%ebp, %edi
	call	vel_step@PLT
	call	wtime@PLT
	vsubsd	16(%rsp), %xmm0, %xmm0
	vmovsd	8(%rsp), %xmm3
	incl	%r13d
	vdivsd	%xmm0, %xmm3, %xmm0
	addl	%r12d, %r14d
	vaddsd	(%rsp), %xmm0, %xmm5
	vmovsd	%xmm5, (%rsp)
	call	wtime@PLT
	movq	u(%rip), %rcx
	vmovss	dt(%rip), %xmm1
	addq	%rbx, %rcx
	movq	dens(%rip), %rsi
	vmovsd	%xmm0, 16(%rsp)
	addq	v(%rip), %rbx
	vmovss	diff(%rip), %xmm0
	movq	%rbx, %r8
	movq	%r15, %rdx
	movl	%ebp, %edi
	call	dens_step@PLT
	call	wtime@PLT
	vsubsd	16(%rsp), %xmm0, %xmm0
	vmovsd	8(%rsp), %xmm3
	vmovsd	24(%rsp), %xmm2
	vdivsd	%xmm0, %xmm3, %xmm0
	vaddsd	%xmm0, %xmm2, %xmm2
	cmpl	%r13d, 32(%rsp)
	je	.L3
	movl	N(%rip), %eax
.L5:
	movl	%r14d, %ebx
	imull	%eax, %ebx
	cmpl	56(%rsp), %r13d
	jne	.L14
	cltd
	idivl	60(%rsp)
	movl	%edx, %ebp
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L8:
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	%xmm2, (%rsp)
.L3:
	vmovsd	%xmm2, 8(%rsp)
	call	GOMP_atomic_start@PLT
	vmovsd	(%rsp), %xmm1
	vmovsd	8(%rsp), %xmm2
	vaddsd	vel_ns_p_cell.5(%rip), %xmm1, %xmm0
	vaddsd	dens_ns_p_cell.4(%rip), %xmm2, %xmm2
	vmovsd	%xmm0, vel_ns_p_cell.5(%rip)
	vmovsd	%xmm2, dens_ns_p_cell.4(%rip)
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
	jmp	GOMP_atomic_end@PLT
	.p2align 4,,10
	.p2align 3
.L13:
	.cfi_restore_state
	addl	%r14d, %r14d
	movl	$2, %r13d
	jmp	.L2
	.cfi_endproc
.LFE34:
	.size	one_step._omp_fn.0, .-one_step._omp_fn.0
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"usage : %s N dt diff visc force source\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"where:\n"
.LC5:
	.string	"\t N      : grid resolution\n"
.LC6:
	.string	"\t dt     : time step\n"
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"\t diff   : diffusion rate of the density\n"
	.align 8
.LC8:
	.string	"\t visc   : viscosity of the fluid\n"
	.align 8
.LC9:
	.string	"\t force  : scales the mouse movement that generate a force\n"
	.align 8
.LC10:
	.string	"\t source : amount of density that will be deposited\n"
	.align 8
.LC17:
	.string	"Using: N=%d dt=%g diff=%g visc=%g force = %g source=%g\n"
	.section	.rodata.str1.1
.LC18:
	.string	"cannot allocate data\n"
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"%lf | %lf | %lf | %lf: cell per ns total, react, vel_step, dens_step\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB33:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	subq	$32, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movq	stderr(%rip), %r8
	cmpl	$1, %edi
	je	.L16
	cmpl	$7, %edi
	je	.L16
	movq	(%rsi), %rcx
	movq	%r8, %rdi
	leaq	.LC3(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC4(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC5(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC6(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC7(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC8(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC9(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	leaq	.LC10(%rip), %rdx
.L83:
	movq	stderr(%rip), %rdi
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	$1, %edi
	call	exit@PLT
.L16:
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	.LC14(%rip), %xmm4
	vmovsd	.LC15(%rip), %xmm3
	vmovsd	.LC16(%rip), %xmm0
	movl	$256, %ecx
	movq	%r8, %rdi
	vmovsd	%xmm2, %xmm2, %xmm1
	movl	$1, %esi
	leaq	.LC17(%rip), %rdx
	movl	$5, %eax
	movl	$256, N(%rip)
	movl	$0x3dcccccd, dt(%rip)
	movl	$0x00000000, diff(%rip)
	movl	$0x00000000, visc(%rip)
	movl	$0x40a00000, force(%rip)
	movl	$0x42c80000, source(%rip)
	call	__fprintf_chk@PLT
	movl	N(%rip), %eax
	leal	2(%rax), %edx
	imull	%edx, %edx
	movslq	%edx, %r12
	salq	$2, %r12
	movq	%r12, %rdi
	movl	%edx, -60(%rbp)
	call	malloc@PLT
	movq	%r12, %rdi
	movq	%rax, -56(%rbp)
	movq	%rax, u(%rip)
	call	malloc@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
	movq	%rax, v(%rip)
	call	malloc@PLT
	movq	%r12, %rdi
	movq	%rax, %r14
	movq	%rax, u_prev(%rip)
	call	malloc@PLT
	movq	%r12, %rdi
	movq	%rax, %r15
	movq	%rax, v_prev(%rip)
	call	malloc@PLT
	movq	%r12, %rdi
	movq	%rax, %rbx
	movq	%rax, dens(%rip)
	call	malloc@PLT
	cmpq	$0, -56(%rbp)
	movq	%rax, dens_prev(%rip)
	movq	%rax, %rdi
	sete	%al
	testq	%r13, %r13
	sete	%cl
	orl	%ecx, %eax
	testq	%r14, %r14
	sete	%cl
	orl	%ecx, %eax
	testq	%r15, %r15
	sete	%cl
	orl	%ecx, %eax
	testq	%rbx, %rbx
	sete	%cl
	orb	%cl, %al
	jne	.L17
	testq	%rdi, %rdi
	je	.L17
	movl	-60(%rbp), %edx
	testl	%edx, %edx
	je	.L20
	movq	%r12, %rdx
	xorl	%esi, %esi
	call	memset@PLT
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	memset@PLT
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%r15, %rdi
	call	memset@PLT
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%r14, %rdi
	call	memset@PLT
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%r13, %rdi
	call	memset@PLT
	movq	-56(%rbp), %rdi
	movq	%r12, %rdx
	xorl	%esi, %esi
	call	memset@PLT
.L20:
	movl	$2048, -68(%rbp)
	.p2align 4,,10
	.p2align 3
.L19:
	call	wtime@PLT
	movl	N(%rip), %r15d
	movq	v_prev(%rip), %rbx
	leal	2(%r15), %r13d
	movl	%r13d, %esi
	imull	%r13d, %esi
	movq	u_prev(%rip), %r12
	movq	dens_prev(%rip), %r14
	vmovsd	%xmm0, start_t.3(%rip)
	testl	%esi, %esi
	je	.L43
	leal	-1(%rsi), %eax
	cmpl	$6, %eax
	jbe	.L44
	movl	%esi, %edx
	shrl	$3, %edx
	vxorps	%xmm3, %xmm3, %xmm3
	salq	$5, %rdx
	xorl	%eax, %eax
	vmovaps	%ymm3, %ymm2
	.p2align 4,,10
	.p2align 3
.L23:
	vmovups	(%rbx,%rax), %ymm1
	vmovups	(%r12,%rax), %ymm0
	vmulps	%ymm1, %ymm1, %ymm1
	vmaxps	(%r14,%rax), %ymm3, %ymm3
	addq	$32, %rax
	vfmadd132ps	%ymm0, %ymm1, %ymm0
	vmaxps	%ymm0, %ymm2, %ymm2
	cmpq	%rax, %rdx
	jne	.L23
	vextractf128	$0x1, %ymm3, %xmm0
	vmaxps	%xmm3, %xmm0, %xmm0
	movl	%esi, %edx
	andl	$-8, %edx
	vmovhlps	%xmm0, %xmm0, %xmm1
	vmaxps	%xmm0, %xmm1, %xmm1
	movl	%edx, %eax
	vshufps	$85, %xmm1, %xmm1, %xmm0
	vmaxps	%xmm1, %xmm0, %xmm0
	vextractf128	$0x1, %ymm2, %xmm1
	vmaxps	%xmm2, %xmm1, %xmm1
	vmovhlps	%xmm1, %xmm1, %xmm2
	vmaxps	%xmm1, %xmm2, %xmm2
	vshufps	$85, %xmm2, %xmm2, %xmm1
	vmaxps	%xmm2, %xmm1, %xmm1
	cmpl	%edx, %esi
	je	.L84
	vzeroupper
.L22:
	movl	%esi, %edi
	subl	%edx, %edi
	leal	-1(%rdi), %r8d
	cmpl	$2, %r8d
	jbe	.L25
	vmovups	(%rbx,%rdx,4), %xmm3
	vmovups	(%r12,%rdx,4), %xmm2
	vmulps	%xmm3, %xmm3, %xmm3
	vshufps	$0, %xmm0, %xmm0, %xmm0
	vmaxps	(%r14,%rdx,4), %xmm0, %xmm0
	vshufps	$0, %xmm1, %xmm1, %xmm1
	movl	%edi, %edx
	vfmadd132ps	%xmm2, %xmm3, %xmm2
	andl	$-4, %edx
	addl	%edx, %eax
	vmaxps	%xmm2, %xmm1, %xmm1
	vmovhlps	%xmm0, %xmm0, %xmm2
	vmaxps	%xmm0, %xmm2, %xmm2
	vshufps	$85, %xmm2, %xmm2, %xmm0
	vmaxps	%xmm2, %xmm0, %xmm0
	vmovhlps	%xmm1, %xmm1, %xmm2
	vmaxps	%xmm1, %xmm2, %xmm2
	vshufps	$85, %xmm2, %xmm2, %xmm1
	vmaxps	%xmm2, %xmm1, %xmm1
	cmpl	%edx, %edi
	je	.L24
.L25:
	movslq	%eax, %rdi
	vmovss	(%rbx,%rdi,4), %xmm3
	vmovss	(%r12,%rdi,4), %xmm2
	vmulss	%xmm3, %xmm3, %xmm3
	vmaxss	(%r14,%rdi,4), %xmm0, %xmm0
	leaq	0(,%rdi,4), %rdx
	leal	1(%rax), %edi
	vfmadd132ss	%xmm2, %xmm3, %xmm2
	vmaxss	%xmm2, %xmm1, %xmm1
	cmpl	%edi, %esi
	jle	.L24
	vmovss	4(%rbx,%rdx), %xmm3
	vmovss	4(%r12,%rdx), %xmm2
	vmulss	%xmm3, %xmm3, %xmm3
	addl	$2, %eax
	vmaxss	4(%r14,%rdx), %xmm0, %xmm0
	vfmadd132ss	%xmm2, %xmm3, %xmm2
	vmaxss	%xmm2, %xmm1, %xmm1
	cmpl	%eax, %esi
	jle	.L24
	vmovss	8(%rbx,%rdx), %xmm3
	vmovss	8(%r12,%rdx), %xmm2
	vmulss	%xmm3, %xmm3, %xmm3
	vmaxss	8(%r14,%rdx), %xmm0, %xmm0
	vfmadd132ss	%xmm2, %xmm3, %xmm2
	vmaxss	%xmm2, %xmm1, %xmm1
.L24:
	movl	%esi, %eax
	leaq	0(,%rax,4), %rdx
	leaq	(%rbx,%rdx), %r8
	cmpq	%r12, %r8
	leaq	(%r12,%rdx), %r9
	setbe	%dil
	cmpq	%rbx, %r9
	setbe	%sil
	leaq	(%r14,%rdx), %r10
	orl	%esi, %edi
	cmpq	%r10, %rbx
	setnb	%sil
	cmpq	%r14, %r8
	setbe	%r8b
	orl	%r8d, %esi
	testb	%sil, %dil
	je	.L45
	cmpq	%r10, %r12
	setnb	%sil
	cmpq	%r14, %r9
	setbe	%dil
	orb	%dil, %sil
	je	.L45
	xorl	%esi, %esi
	movq	%r14, %rdi
	vmovss	%xmm1, -64(%rbp)
	vmovss	%xmm0, -60(%rbp)
	movq	%rdx, -56(%rbp)
	call	memset@PLT
	movq	-56(%rbp), %rdx
	xorl	%esi, %esi
	movq	%r12, %rdi
	call	memset@PLT
	movq	-56(%rbp), %rdx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	memset@PLT
	vmovss	-60(%rbp), %xmm0
	vmovss	-64(%rbp), %xmm1
.L28:
	vmovss	.LC19(%rip), %xmm7
	vcomiss	%xmm1, %xmm7
	ja	.L21
.L29:
	vmovss	.LC21(%rip), %xmm6
	vcomiss	%xmm0, %xmm6
	jbe	.L31
	movl	%r15d, %edx
	shrl	$31, %edx
	vmovss	.LC20(%rip), %xmm6
	addl	%r15d, %edx
	sarl	%edx
	movslq	%r13d, %rax
	movslq	%edx, %rdx
	vmulss	source(%rip), %xmm6, %xmm0
	shrq	%rax
	imulq	%rdx, %rax
	shrq	%rdx
	addq	%rdx, %rax
	vmovss	%xmm0, (%r14,%rax,4)
.L31:
	imull	%r15d, %r15d
	call	wtime@PLT
	vxorpd	%xmm5, %xmm5, %xmm5
	vmovsd	%xmm0, %xmm0, %xmm1
	vcvtsi2sdl	%r15d, %xmm5, %xmm0
	vsubsd	start_t.3(%rip), %xmm1, %xmm1
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	vmulsd	.LC1(%rip), %xmm0, %xmm0
	xorl	%esi, %esi
	leaq	one_step._omp_fn.0(%rip), %rdi
	vdivsd	%xmm1, %xmm0, %xmm0
	vaddsd	react_ns_p_cell.2(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, react_ns_p_cell.2(%rip)
	call	GOMP_parallel@PLT
	call	wtime@PLT
	vsubsd	one_second.1(%rip), %xmm0, %xmm0
	vcomisd	.LC22(%rip), %xmm0
	ja	.L85
	incl	times.0(%rip)
	decl	-68(%rbp)
	jne	.L19
.L36:
	movq	u(%rip), %rdi
	testq	%rdi, %rdi
	je	.L37
	call	free@PLT
.L37:
	movq	v(%rip), %rdi
	testq	%rdi, %rdi
	je	.L38
	call	free@PLT
.L38:
	movq	u_prev(%rip), %rdi
	testq	%rdi, %rdi
	je	.L39
	call	free@PLT
.L39:
	movq	v_prev(%rip), %rdi
	testq	%rdi, %rdi
	je	.L40
	call	free@PLT
.L40:
	movq	dens(%rip), %rdi
	testq	%rdi, %rdi
	je	.L41
	call	free@PLT
.L41:
	movq	dens_prev(%rip), %rdi
	testq	%rdi, %rdi
	je	.L42
	call	free@PLT
.L42:
	xorl	%edi, %edi
	call	exit@PLT
	.p2align 4,,10
	.p2align 3
.L43:
	vxorps	%xmm0, %xmm0, %xmm0
.L21:
	movl	%r15d, %eax
	shrl	$31, %eax
	vmovss	.LC20(%rip), %xmm7
	addl	%r15d, %eax
	sarl	%eax
	movslq	%r13d, %rdx
	vmulss	force(%rip), %xmm7, %xmm1
	cltq
	shrq	%rdx
	imulq	%rax, %rdx
	shrq	%rax
	addq	%rdx, %rax
	vmovss	%xmm1, (%r12,%rax,4)
	vmovss	%xmm1, (%rbx,%rax,4)
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L85:
	vxorpd	%xmm5, %xmm5, %xmm5
	vcvtsi2sdl	times.0(%rip), %xmm5, %xmm0
	vmovsd	.LC22(%rip), %xmm4
	vmovsd	dens_ns_p_cell.4(%rip), %xmm3
	vmovsd	vel_ns_p_cell.5(%rip), %xmm2
	vdivsd	%xmm0, %xmm4, %xmm0
	vaddsd	%xmm2, %xmm3, %xmm4
	vmovsd	react_ns_p_cell.2(%rip), %xmm1
	leaq	.LC23(%rip), %rsi
	vaddsd	%xmm1, %xmm4, %xmm4
	movl	$1, %edi
	movl	$4, %eax
	vmulsd	%xmm0, %xmm4, %xmm4
	vmulsd	%xmm0, %xmm3, %xmm3
	vmulsd	%xmm0, %xmm2, %xmm2
	vmulsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm4, %xmm4, %xmm0
	call	__printf_chk@PLT
	call	wtime@PLT
	decl	-68(%rbp)
	movq	$0x000000000, react_ns_p_cell.2(%rip)
	movq	$0x000000000, vel_ns_p_cell.5(%rip)
	movq	$0x000000000, dens_ns_p_cell.4(%rip)
	movl	$1, times.0(%rip)
	vmovsd	%xmm0, one_second.1(%rip)
	jne	.L19
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L84:
	vzeroupper
	jmp	.L24
.L44:
	vxorps	%xmm0, %xmm0, %xmm0
	xorl	%edx, %edx
	vmovaps	%xmm0, %xmm1
	xorl	%eax, %eax
	jmp	.L22
.L45:
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L27:
	movl	$0x00000000, (%r14,%rdx,4)
	movl	$0x00000000, (%rbx,%rdx,4)
	movl	$0x00000000, (%r12,%rdx,4)
	incq	%rdx
	cmpq	%rdx, %rax
	jne	.L27
	jmp	.L28
.L17:
	leaq	.LC18(%rip), %rdx
	jmp	.L83
	.cfi_endproc
.LFE33:
	.size	main, .-main
	.data
	.align 4
	.type	times.0, @object
	.size	times.0, 4
times.0:
	.long	1
	.local	one_second.1
	.comm	one_second.1,8,8
	.local	react_ns_p_cell.2
	.comm	react_ns_p_cell.2,8,8
	.local	start_t.3
	.comm	start_t.3,8,8
	.local	dens_ns_p_cell.4
	.comm	dens_ns_p_cell.4,8,8
	.local	vel_ns_p_cell.5
	.comm	vel_ns_p_cell.5,8,8
	.local	dens_prev
	.comm	dens_prev,8,8
	.local	dens
	.comm	dens,8,8
	.local	v_prev
	.comm	v_prev,8,8
	.local	u_prev
	.comm	u_prev,8,8
	.local	v
	.comm	v,8,8
	.local	u
	.comm	u,8,8
	.local	source
	.comm	source,4,4
	.local	force
	.comm	force,4,4
	.local	visc
	.comm	visc,4,4
	.local	diff
	.comm	diff,4,4
	.local	dt
	.comm	dt,4,4
	.local	N
	.comm	N,4,4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	-1598689907
	.long	1051772663
	.align 8
.LC14:
	.long	0
	.long	1079574528
	.align 8
.LC15:
	.long	0
	.long	1075052544
	.align 8
.LC16:
	.long	-1610612736
	.long	1069128089
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC19:
	.long	889599933
	.align 4
.LC20:
	.long	1092616192
	.align 4
.LC21:
	.long	1065353216
	.section	.rodata.cst8
	.align 8
.LC22:
	.long	0
	.long	1072693248
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
