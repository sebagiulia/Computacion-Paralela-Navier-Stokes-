	.file	"demo.c"
	.text
	.p2align 4
	.type	mouse_func, @function
mouse_func:
.LFB37:
	.cfi_startproc
	endbr64
	movl	%edx, mx(%rip)
	xorl	%edx, %edx
	testl	%esi, %esi
	movslq	%edi, %rdi
	sete	%dl
	leaq	mouse_down(%rip), %rax
	movl	%ecx, my(%rip)
	movl	%ecx, omx(%rip)
	movl	%edx, (%rax,%rdi,4)
	ret
	.cfi_endproc
.LFE37:
	.size	mouse_func, .-mouse_func
	.p2align 4
	.type	motion_func, @function
motion_func:
.LFB38:
	.cfi_startproc
	endbr64
	movl	%edi, mx(%rip)
	movl	%esi, my(%rip)
	ret
	.cfi_endproc
.LFE38:
	.size	motion_func, .-motion_func
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"%lf, %lf, %lf, %lf: ns per cell total, react, vel_step, dens_step\n"
	.text
	.p2align 4
	.type	idle_func, @function
idle_func:
.LFB40:
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
	pushq	%r14
	pushq	%r13
	.cfi_escape 0xf,0x3,0x76,0x68,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	call	wtime@PLT
	movl	N(%rip), %r14d
	movq	v_prev(%rip), %rbx
	leal	2(%r14), %r15d
	movl	%r15d, %ecx
	imull	%r15d, %ecx
	movq	u_prev(%rip), %r12
	movq	dens_prev(%rip), %r13
	vmovsd	%xmm0, start_t.5(%rip)
	testl	%ecx, %ecx
	je	.L23
	leal	-1(%rcx), %eax
	cmpl	$6, %eax
	jbe	.L24
	movl	%ecx, %edx
	shrl	$3, %edx
	vxorps	%xmm3, %xmm3, %xmm3
	salq	$5, %rdx
	xorl	%eax, %eax
	vmovaps	%ymm3, %ymm2
	.p2align 4,,10
	.p2align 3
.L7:
	vmovups	(%rbx,%rax), %ymm1
	vmovups	(%r12,%rax), %ymm0
	vmulps	%ymm1, %ymm1, %ymm1
	vmaxps	0(%r13,%rax), %ymm3, %ymm3
	addq	$32, %rax
	vfmadd132ps	%ymm0, %ymm1, %ymm0
	vmaxps	%ymm0, %ymm2, %ymm2
	cmpq	%rax, %rdx
	jne	.L7
	vextractf128	$0x1, %ymm3, %xmm0
	vmaxps	%xmm3, %xmm0, %xmm0
	movl	%ecx, %eax
	andl	$-8, %eax
	vmovhlps	%xmm0, %xmm0, %xmm1
	vmaxps	%xmm0, %xmm1, %xmm1
	movl	%eax, %edi
	vshufps	$85, %xmm1, %xmm1, %xmm0
	vmaxps	%xmm1, %xmm0, %xmm0
	vextractf128	$0x1, %ymm2, %xmm1
	vmaxps	%xmm2, %xmm1, %xmm1
	vmovhlps	%xmm1, %xmm1, %xmm2
	vmaxps	%xmm1, %xmm2, %xmm2
	vshufps	$85, %xmm2, %xmm2, %xmm1
	vmaxps	%xmm2, %xmm1, %xmm1
	cmpl	%eax, %ecx
	je	.L48
	vzeroupper
.L6:
	movl	%ecx, %edx
	subl	%eax, %edx
	leal	-1(%rdx), %esi
	cmpl	$2, %esi
	jbe	.L9
	vmovups	(%rbx,%rax,4), %xmm3
	vmovups	(%r12,%rax,4), %xmm2
	vmulps	%xmm3, %xmm3, %xmm3
	vshufps	$0, %xmm0, %xmm0, %xmm0
	vmaxps	0(%r13,%rax,4), %xmm0, %xmm0
	vshufps	$0, %xmm1, %xmm1, %xmm1
	movl	%edx, %esi
	vfmadd132ps	%xmm2, %xmm3, %xmm2
	andl	$-4, %esi
	addl	%esi, %edi
	vmaxps	%xmm2, %xmm1, %xmm1
	vmovhlps	%xmm0, %xmm0, %xmm2
	vmaxps	%xmm0, %xmm2, %xmm2
	vshufps	$85, %xmm2, %xmm2, %xmm0
	vmaxps	%xmm2, %xmm0, %xmm0
	vmovhlps	%xmm1, %xmm1, %xmm2
	vmaxps	%xmm1, %xmm2, %xmm2
	vshufps	$85, %xmm2, %xmm2, %xmm1
	vmaxps	%xmm2, %xmm1, %xmm1
	cmpl	%esi, %edx
	je	.L8
.L9:
	movslq	%edi, %rax
	vmovss	(%rbx,%rax,4), %xmm3
	vmovss	(%r12,%rax,4), %xmm2
	vmulss	%xmm3, %xmm3, %xmm3
	vmaxss	0(%r13,%rax,4), %xmm0, %xmm0
	leaq	0(,%rax,4), %rdx
	leal	1(%rdi), %eax
	vfmadd132ss	%xmm2, %xmm3, %xmm2
	vmaxss	%xmm2, %xmm1, %xmm1
	cmpl	%eax, %ecx
	jle	.L8
	vmovss	4(%rbx,%rdx), %xmm3
	vmovss	4(%r12,%rdx), %xmm2
	vmulss	%xmm3, %xmm3, %xmm3
	leal	2(%rdi), %eax
	vmaxss	4(%r13,%rdx), %xmm0, %xmm0
	vfmadd132ss	%xmm2, %xmm3, %xmm2
	vmaxss	%xmm2, %xmm1, %xmm1
	cmpl	%eax, %ecx
	jle	.L8
	vmovss	8(%rbx,%rdx), %xmm3
	vmovss	8(%r12,%rdx), %xmm2
	vmulss	%xmm3, %xmm3, %xmm3
	vmaxss	8(%r13,%rdx), %xmm0, %xmm0
	vfmadd132ss	%xmm2, %xmm3, %xmm2
	vmaxss	%xmm2, %xmm1, %xmm1
.L8:
	leaq	0(,%rcx,4), %rdx
	leaq	(%rbx,%rdx), %r9
	cmpq	%r9, %r13
	leaq	0(%r13,%rdx), %r8
	setnb	%sil
	cmpq	%r8, %rbx
	setnb	%al
	leaq	(%r12,%rdx), %rdi
	orl	%eax, %esi
	cmpq	%rdi, %rbx
	setnb	%al
	cmpq	%r9, %r12
	setnb	%r9b
	orl	%r9d, %eax
	testb	%al, %sil
	je	.L25
	cmpq	%r8, %r12
	setnb	%al
	cmpq	%rdi, %r13
	setnb	%sil
	orb	%sil, %al
	je	.L25
	xorl	%esi, %esi
	movq	%r13, %rdi
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
.L12:
	vmovss	.LC1(%rip), %xmm2
	vcomiss	%xmm1, %xmm2
	ja	.L5
.L13:
	vmovss	.LC3(%rip), %xmm2
	vcomiss	%xmm0, %xmm2
	jbe	.L15
	movl	%r14d, %eax
	shrl	$31, %eax
	vmovss	.LC2(%rip), %xmm0
	addl	%r14d, %eax
	sarl	%eax
	movslq	%r15d, %rdx
	cltq
	vmulss	source(%rip), %xmm0, %xmm0
	shrq	%rdx
	imulq	%rax, %rdx
	shrq	%rax
	addq	%rdx, %rax
	vmovss	%xmm0, 0(%r13,%rax,4)
.L15:
	movl	mouse_down(%rip), %ecx
	movl	8+mouse_down(%rip), %eax
	movl	%ecx, %edi
	orl	%eax, %edi
	je	.L17
	movl	mx(%rip), %edx
	vxorps	%xmm5, %xmm5, %xmm5
	vcvtsi2ssl	win_x(%rip), %xmm5, %xmm3
	vcvtsi2ssl	%edx, %xmm5, %xmm0
	vcvtsi2ssl	%r14d, %xmm5, %xmm1
	movl	win_y(%rip), %r8d
	movl	my(%rip), %edi
	vdivss	%xmm3, %xmm0, %xmm0
	movl	%r8d, %r9d
	subl	%edi, %r9d
	vcvtsi2ssl	%r8d, %xmm5, %xmm3
	vfmadd132ss	%xmm1, %xmm2, %xmm0
	vcvttss2sil	%xmm0, %esi
	vcvtsi2ssl	%r9d, %xmm5, %xmm0
	cmpl	%esi, %r14d
	vdivss	%xmm3, %xmm0, %xmm0
	setl	%r8b
	testl	%esi, %esi
	setle	%r10b
	orl	%r10d, %r8d
	vfmadd132ss	%xmm0, %xmm2, %xmm1
	vcvttss2sil	%xmm1, %r9d
	testl	%r9d, %r9d
	setle	%r10b
	orb	%r10b, %r8b
	jne	.L17
	cmpl	%r9d, %r14d
	jge	.L49
.L17:
	call	wtime@PLT
	movl	N(%rip), %eax
	vsubsd	start_t.5(%rip), %xmm0, %xmm0
	imull	%eax, %eax
	vxorpd	%xmm6, %xmm6, %xmm6
	vmulsd	.LC4(%rip), %xmm0, %xmm0
	vcvtsi2sdl	%eax, %xmm6, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vaddsd	react_ns_p_cell.4(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, react_ns_p_cell.4(%rip)
	call	wtime@PLT
	vmovsd	%xmm0, start_t.5(%rip)
	movq	v_prev(%rip), %r8
	movq	u_prev(%rip), %rcx
	movq	v(%rip), %rdx
	movq	u(%rip), %rsi
	movl	N(%rip), %edi
	vmovss	dt(%rip), %xmm1
	vmovss	visc(%rip), %xmm0
	call	vel_step@PLT
	call	wtime@PLT
	movl	N(%rip), %eax
	vsubsd	start_t.5(%rip), %xmm0, %xmm0
	imull	%eax, %eax
	vxorpd	%xmm6, %xmm6, %xmm6
	vmulsd	.LC4(%rip), %xmm0, %xmm0
	vcvtsi2sdl	%eax, %xmm6, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vaddsd	vel_ns_p_cell.3(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, vel_ns_p_cell.3(%rip)
	call	wtime@PLT
	vmovsd	%xmm0, start_t.5(%rip)
	vmovss	dt(%rip), %xmm1
	movq	v(%rip), %r8
	movq	u(%rip), %rcx
	movq	dens_prev(%rip), %rdx
	movq	dens(%rip), %rsi
	movl	N(%rip), %edi
	vmovss	diff(%rip), %xmm0
	call	dens_step@PLT
	call	wtime@PLT
	movl	N(%rip), %eax
	vsubsd	start_t.5(%rip), %xmm0, %xmm0
	imull	%eax, %eax
	vxorpd	%xmm6, %xmm6, %xmm6
	vmulsd	.LC4(%rip), %xmm0, %xmm0
	vcvtsi2sdl	%eax, %xmm6, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vaddsd	dens_ns_p_cell.2(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, dens_ns_p_cell.2(%rip)
	call	wtime@PLT
	vsubsd	one_second.1(%rip), %xmm0, %xmm0
	vmovsd	.LC5(%rip), %xmm1
	vcomisd	%xmm1, %xmm0
	ja	.L50
	movl	times.0(%rip), %eax
	incl	%eax
.L22:
	movl	win_id(%rip), %edi
	movl	%eax, times.0(%rip)
	call	glutSetWindow@PLT
	addq	$40, %rsp
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
	jmp	glutPostRedisplay@PLT
	.p2align 4,,10
	.p2align 3
.L23:
	.cfi_restore_state
	vxorps	%xmm0, %xmm0, %xmm0
.L5:
	movl	%r14d, %eax
	shrl	$31, %eax
	vmovss	.LC2(%rip), %xmm1
	addl	%r14d, %eax
	sarl	%eax
	movslq	%r15d, %rdx
	vmulss	force(%rip), %xmm1, %xmm1
	cltq
	shrq	%rdx
	imulq	%rax, %rdx
	shrq	%rax
	addq	%rdx, %rax
	vmovss	%xmm1, (%r12,%rax,4)
	vmovss	%xmm1, (%rbx,%rax,4)
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L50:
	vxorpd	%xmm6, %xmm6, %xmm6
	vcvtsi2sdl	times.0(%rip), %xmm6, %xmm0
	vmovsd	dens_ns_p_cell.2(%rip), %xmm3
	vmovsd	vel_ns_p_cell.3(%rip), %xmm2
	vmovsd	react_ns_p_cell.4(%rip), %xmm4
	vdivsd	%xmm0, %xmm1, %xmm1
	vaddsd	%xmm2, %xmm3, %xmm0
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	vaddsd	%xmm4, %xmm0, %xmm0
	movl	$4, %eax
	vmulsd	%xmm1, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm3, %xmm3
	vmulsd	%xmm1, %xmm2, %xmm2
	vmulsd	%xmm1, %xmm4, %xmm1
	call	__printf_chk@PLT
	call	wtime@PLT
	vmovsd	%xmm0, one_second.1(%rip)
	movq	$0x000000000, react_ns_p_cell.4(%rip)
	movq	$0x000000000, vel_ns_p_cell.3(%rip)
	movq	$0x000000000, dens_ns_p_cell.2(%rip)
	movl	$1, %eax
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L49:
	testl	%ecx, %ecx
	je	.L18
	movl	%esi, %ecx
	xorl	%r9d, %ecx
	movslq	%r15d, %r8
	andl	$1, %ecx
	imulq	%r8, %rcx
	movslq	%r9d, %r10
	shrq	%r8
	addq	%r10, %rcx
	imulq	%r8, %rcx
	movslq	%esi, %r8
	shrq	%r8
	addq	%r8, %rcx
	movl	%edx, %r8d
	subl	omx(%rip), %r8d
	vcvtsi2ssl	%r8d, %xmm5, %xmm0
	vmovss	force(%rip), %xmm1
	movl	omy(%rip), %r8d
	vmulss	%xmm1, %xmm0, %xmm0
	subl	%edi, %r8d
	vmovss	%xmm0, (%r12,%rcx,4)
	vcvtsi2ssl	%r8d, %xmm5, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
.L18:
	testl	%eax, %eax
	je	.L19
	movl	%esi, %eax
	xorl	%r9d, %eax
	movslq	%r15d, %r15
	andl	$1, %eax
	imulq	%r15, %rax
	movslq	%r9d, %r9
	shrq	%r15
	addq	%r9, %rax
	imulq	%r15, %rax
	movslq	%esi, %rsi
	vmovss	source(%rip), %xmm0
	shrq	%rsi
	addq	%rsi, %rax
	vmovss	%xmm0, 0(%r13,%rax,4)
.L19:
	movl	%edx, omx(%rip)
	movl	%edi, omy(%rip)
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L48:
	vzeroupper
	jmp	.L8
.L25:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L11:
	movl	$0x00000000, 0(%r13,%rax,4)
	movl	$0x00000000, (%rbx,%rax,4)
	movl	$0x00000000, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rcx
	jne	.L11
	jmp	.L12
.L24:
	vxorps	%xmm0, %xmm0, %xmm0
	xorl	%eax, %eax
	vmovaps	%xmm0, %xmm1
	xorl	%edi, %edi
	jmp	.L6
	.cfi_endproc
.LFE40:
	.size	idle_func, .-idle_func
	.p2align 4
	.type	reshape_func, @function
reshape_func:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%esi, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	win_id(%rip), %edi
	call	glutSetWindow@PLT
	movl	%ebx, %esi
	movl	%ebp, %edi
	call	glutReshapeWindow@PLT
	movl	%ebp, win_x(%rip)
	movl	%ebx, win_y(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE39:
	.size	reshape_func, .-reshape_func
	.p2align 4
	.type	display_func, @function
display_func:
.LFB41:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xorl	%esi, %esi
	xorl	%edi, %edi
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movl	win_y(%rip), %ecx
	movl	win_x(%rip), %edx
	call	glViewport@PLT
	movl	$5889, %edi
	call	glMatrixMode@PLT
	call	glLoadIdentity@PLT
	vmovsd	.LC5(%rip), %xmm1
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	%xmm1, %xmm1, %xmm3
	vmovsd	%xmm2, %xmm2, %xmm0
	call	gluOrtho2D@PLT
	vxorps	%xmm2, %xmm2, %xmm2
	vmovss	.LC3(%rip), %xmm3
	vmovaps	%xmm2, %xmm0
	vmovaps	%xmm2, %xmm1
	call	glClearColor@PLT
	movl	$16384, %edi
	call	glClear@PLT
	movl	dvel(%rip), %eax
	vxorps	%xmm2, %xmm2, %xmm2
	vcvtsi2ssl	N(%rip), %xmm2, %xmm0
	testl	%eax, %eax
	je	.L54
	vmovaps	%xmm0, %xmm1
	vmovss	.LC3(%rip), %xmm0
	movl	$1, %r13d
	vdivss	%xmm1, %xmm0, %xmm2
	vmovaps	%xmm0, %xmm1
	vmovss	%xmm2, 8(%rsp)
	vmovaps	%xmm0, %xmm2
	call	glColor3f@PLT
	vmovss	.LC3(%rip), %xmm0
	call	glLineWidth@PLT
	movl	$1, %edi
	call	glBegin@PLT
	vmovss	.LC8(%rip), %xmm2
	movl	N(%rip), %eax
	vmovss	%xmm2, 4(%rsp)
	testl	%eax, %eax
	jle	.L56
	.p2align 4,,10
	.p2align 3
.L55:
	vxorps	%xmm7, %xmm7, %xmm7
	vcvtsi2ssl	%r13d, %xmm7, %xmm0
	movl	%r13d, %r14d
	movl	%r13d, %ebp
	vsubss	4(%rsp), %xmm0, %xmm0
	vmulss	8(%rsp), %xmm0, %xmm7
	vmovd	%xmm7, %ebx
	testl	%eax, %eax
	jle	.L56
	movq	%r13, %r12
	shrq	%r12
	movl	$1, %r15d
	.p2align 4,,10
	.p2align 3
.L57:
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtsi2ssl	%r15d, %xmm6, %xmm1
	vmovd	%ebx, %xmm0
	vsubss	4(%rsp), %xmm1, %xmm1
	vmulss	8(%rsp), %xmm1, %xmm1
	vmovss	%xmm1, (%rsp)
	call	glVertex2f@PLT
	movl	N(%rip), %eax
	vmovd	%ebx, %xmm2
	leal	2(%rax), %edx
	movl	%ebp, %eax
	xorl	%r15d, %eax
	movslq	%edx, %rdx
	andl	$1, %eax
	imulq	%rdx, %rax
	shrq	%rdx
	vmovss	(%rsp), %xmm1
	addq	%r15, %rax
	imulq	%rdx, %rax
	movq	u(%rip), %rdx
	incq	%r15
	addq	%r12, %rax
	vaddss	(%rdx,%rax,4), %xmm2, %xmm0
	movq	v(%rip), %rdx
	vaddss	(%rdx,%rax,4), %xmm1, %xmm1
	call	glVertex2f@PLT
	movl	N(%rip), %eax
	cmpl	%r15d, %eax
	jge	.L57
	incl	%r14d
	cmpl	%eax, %r14d
	jg	.L56
	incq	%r13
	jmp	.L55
	.p2align 4,,10
	.p2align 3
.L54:
	vmovss	.LC3(%rip), %xmm1
	movl	$7, %edi
	vdivss	%xmm0, %xmm1, %xmm2
	vmovss	%xmm2, 8(%rsp)
	call	glBegin@PLT
	movl	N(%rip), %eax
	testl	%eax, %eax
	jns	.L72
.L56:
	call	glEnd@PLT
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
	jmp	glutSwapBuffers@PLT
	.p2align 4,,10
	.p2align 3
.L72:
	.cfi_restore_state
	vmovss	.LC8(%rip), %xmm2
	movl	$1, %r13d
	vmovss	%xmm2, 4(%rsp)
	.p2align 4,,10
	.p2align 3
.L62:
	vxorps	%xmm7, %xmm7, %xmm7
	leal	-1(%r13), %r12d
	vcvtsi2ssl	%r12d, %xmm7, %xmm0
	vmovss	8(%rsp), %xmm2
	leaq	-1(%r13), %rbp
	movq	%r13, %r14
	vsubss	4(%rsp), %xmm0, %xmm0
	movl	%r13d, %r15d
	shrq	%rbp
	vmulss	%xmm2, %xmm0, %xmm7
	shrq	%r14
	xorl	%ebx, %ebx
	vmovss	%xmm7, 12(%rsp)
	vaddss	%xmm7, %xmm2, %xmm7
	vmovss	%xmm7, 16(%rsp)
	.p2align 4,,10
	.p2align 3
.L59:
	addl	$2, %eax
	cltq
	movq	%rax, %rdx
	shrq	%rdx
	imulq	%rdx, %rax
	movl	%r12d, %ecx
	movq	%rdx, %rdi
	xorl	%ebx, %ecx
	imulq	%rbx, %rdi
	andl	$1, %ecx
	imulq	%rax, %rcx
	vxorps	%xmm4, %xmm4, %xmm4
	vcvtsi2ssl	%ebx, %xmm4, %xmm0
	movq	dens(%rip), %r8
	leaq	0(%rbp,%rdi), %r10
	addq	%r10, %rcx
	vmovss	(%r8,%rcx,4), %xmm1
	movl	%ebx, %r9d
	leal	1(%rbx), %ecx
	movl	%r12d, %r10d
	vsubss	4(%rsp), %xmm0, %xmm0
	xorl	%ecx, %r10d
	xorl	%r15d, %r9d
	xorl	%r15d, %ecx
	andl	$1, %r10d
	andl	$1, %r9d
	andl	$1, %ecx
	imulq	%rax, %r10
	imulq	%rax, %r9
	imulq	%rax, %rcx
	vmulss	8(%rsp), %xmm0, %xmm6
	addq	%rdi, %rdx
	leaq	0(%rbp,%rdx), %r11
	addq	%r14, %rdi
	addq	%r14, %rdx
	addq	%r10, %r11
	addq	%r9, %rdi
	addq	%rcx, %rdx
	vmovss	(%r8,%r11,4), %xmm4
	vmovss	(%r8,%rdi,4), %xmm5
	vmovss	(%r8,%rdx,4), %xmm3
	vmovaps	%xmm1, %xmm2
	vmovaps	%xmm1, %xmm0
	vmovss	%xmm6, (%rsp)
	vmovss	%xmm4, 28(%rsp)
	vmovss	%xmm3, 20(%rsp)
	vmovss	%xmm5, 24(%rsp)
	call	glColor3f@PLT
	vmovss	(%rsp), %xmm1
	vmovss	12(%rsp), %xmm0
	incq	%rbx
	call	glVertex2f@PLT
	vmovss	24(%rsp), %xmm5
	vmovaps	%xmm5, %xmm2
	vmovaps	%xmm5, %xmm1
	vmovaps	%xmm5, %xmm0
	call	glColor3f@PLT
	vmovss	(%rsp), %xmm1
	vmovss	16(%rsp), %xmm0
	call	glVertex2f@PLT
	vmovss	20(%rsp), %xmm3
	vmovaps	%xmm3, %xmm2
	vmovaps	%xmm3, %xmm1
	vmovaps	%xmm3, %xmm0
	call	glColor3f@PLT
	vmovss	8(%rsp), %xmm7
	vmovss	16(%rsp), %xmm0
	vaddss	(%rsp), %xmm7, %xmm3
	vmovaps	%xmm3, %xmm1
	vmovss	%xmm3, (%rsp)
	call	glVertex2f@PLT
	vmovss	28(%rsp), %xmm4
	vmovaps	%xmm4, %xmm1
	vmovaps	%xmm4, %xmm0
	vmovaps	%xmm4, %xmm2
	call	glColor3f@PLT
	vmovss	(%rsp), %xmm3
	vmovss	12(%rsp), %xmm0
	vmovaps	%xmm3, %xmm1
	call	glVertex2f@PLT
	movl	N(%rip), %eax
	cmpl	%ebx, %eax
	jge	.L59
	cmpl	%r13d, %eax
	jl	.L56
	incq	%r13
	jmp	.L62
	.cfi_endproc
.LFE41:
	.size	display_func, .-display_func
	.p2align 4
	.type	key_func, @function
key_func:
.LFB36:
	.cfi_startproc
	endbr64
	subl	$67, %edi
	cmpb	$51, %dil
	ja	.L116
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$1, %edx
	movabsq	$70368744194048, %rax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	shlx	%rdi, %rdx, %rdx
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	andq	%rdx, %rax
	jne	.L75
	movabsq	$4294967297, %rcx
	testq	%rcx, %rdx
	jne	.L76
	movabsq	$2251799814209536, %rax
	testq	%rax, %rdx
	jne	.L119
.L114:
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
.L75:
	.cfi_restore_state
	movq	u(%rip), %rdi
	testq	%rdi, %rdi
	je	.L82
	call	free@PLT
.L82:
	movq	v(%rip), %rdi
	testq	%rdi, %rdi
	je	.L83
	call	free@PLT
.L83:
	movq	u_prev(%rip), %rdi
	testq	%rdi, %rdi
	je	.L84
	call	free@PLT
.L84:
	movq	v_prev(%rip), %rdi
	testq	%rdi, %rdi
	je	.L85
	call	free@PLT
.L85:
	movq	dens(%rip), %rdi
	testq	%rdi, %rdi
	je	.L86
	call	free@PLT
.L86:
	movq	dens_prev(%rip), %rdi
	testq	%rdi, %rdi
	je	.L87
	call	free@PLT
.L87:
	xorl	%edi, %edi
	call	exit@PLT
	.p2align 4,,10
	.p2align 3
.L119:
	movl	dvel(%rip), %edx
	xorl	%eax, %eax
	testl	%edx, %edx
	sete	%al
	movl	%eax, dvel(%rip)
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
.L76:
	.cfi_restore_state
	movl	N(%rip), %ebx
	leal	2(%rbx), %edx
	imull	%edx, %edx
	testl	%edx, %edx
	je	.L114
	movq	dens_prev(%rip), %rdi
	movslq	%edx, %rcx
	movq	dens(%rip), %rbp
	leaq	0(,%rcx,4), %r12
	movq	u(%rip), %rbx
	leaq	(%rdi,%r12), %r9
	leaq	0(%rbp,%r12), %rsi
	cmpq	%rbp, %r9
	leaq	(%rbx,%r12), %r10
	movq	v_prev(%rip), %r13
	movq	%r10, 16(%rsp)
	setbe	%r10b
	cmpq	%rsi, %rdi
	movq	v(%rip), %r15
	setnb	%r8b
	orl	%r8d, %r10d
	movq	%rcx, 24(%rsp)
	cmpq	%r13, %r9
	leaq	0(%r13,%r12), %rcx
	leaq	(%r15,%r12), %r11
	setbe	%r8b
	cmpq	%rcx, %rdi
	movq	u_prev(%rip), %r14
	movq	%r11, 8(%rsp)
	setnb	%r11b
	orl	%r11d, %r8d
	leaq	(%r14,%r12), %rdx
	andl	%r10d, %r8d
	cmpq	%r14, %r9
	setbe	%r10b
	cmpq	%rdx, %rdi
	setnb	%r11b
	orl	%r11d, %r10d
	andl	%r8d, %r10d
	cmpq	%r15, %r9
	setbe	%r8b
	cmpq	8(%rsp), %rdi
	setnb	%r11b
	orl	%r11d, %r8d
	andl	%r10d, %r8d
	cmpq	%rbx, %r9
	setbe	%r9b
	cmpq	16(%rsp), %rdi
	setnb	%r10b
	orl	%r10d, %r9d
	andl	%r8d, %r9d
	cmpq	%rsi, %r13
	setnb	%r8b
	cmpq	%rcx, %rbp
	setnb	%r10b
	orl	%r10d, %r8d
	andl	%r9d, %r8d
	cmpq	%rsi, %r14
	setnb	%r9b
	cmpq	%rdx, %rbp
	setnb	%r10b
	movq	8(%rsp), %r11
	orl	%r10d, %r9d
	andl	%r8d, %r9d
	cmpq	%rsi, %r15
	setnb	%r8b
	cmpq	%r11, %rbp
	setnb	%r10b
	orl	%r10d, %r8d
	movq	16(%rsp), %r10
	andl	%r9d, %r8d
	cmpq	%rsi, %rbx
	setnb	%sil
	cmpq	%r10, %rbp
	setnb	%r9b
	orl	%r9d, %esi
	andl	%r8d, %esi
	cmpq	%rcx, %r14
	setnb	%r8b
	cmpq	%rdx, %r13
	setnb	%r9b
	orl	%r9d, %r8d
	andl	%esi, %r8d
	cmpq	%rcx, %r15
	setnb	%sil
	cmpq	%r11, %r13
	setnb	%r9b
	orl	%r9d, %esi
	andl	%esi, %r8d
	cmpq	%rcx, %rbx
	setnb	%sil
	cmpq	%r10, %r13
	setnb	%cl
	orl	%ecx, %esi
	andl	%r8d, %esi
	cmpq	%rdx, %r15
	setnb	%cl
	cmpq	%r11, %r14
	setnb	%r8b
	orl	%r8d, %ecx
	andl	%ecx, %esi
	cmpq	%rdx, %rbx
	setnb	%dl
	cmpq	%r10, %r14
	setnb	%cl
	orl	%ecx, %edx
	testb	%dl, %sil
	je	.L113
	cmpq	%r11, %rbx
	setnb	%dl
	cmpq	%r10, %r15
	setnb	%cl
	orb	%cl, %dl
	je	.L113
	movq	%r12, %rdx
	xorl	%esi, %esi
	call	memset@PLT
	movq	%r12, %rdx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	call	memset@PLT
	movq	%r12, %rdx
	movq	%r15, %rdi
	xorl	%esi, %esi
	call	memset@PLT
	movq	%r12, %rdx
	movq	%r14, %rdi
	xorl	%esi, %esi
	call	memset@PLT
	movq	%r12, %rdx
	movq	%r13, %rdi
	xorl	%esi, %esi
	call	memset@PLT
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	movq	%rbp, %rdi
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	movq	%r12, %rdx
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	xorl	%esi, %esi
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
	jmp	memset@PLT
	.p2align 4,,10
	.p2align 3
.L116:
	ret
.L113:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	24(%rsp), %rdx
	.p2align 4,,10
	.p2align 3
.L102:
	movl	$0x00000000, (%rdi,%rax,4)
	movl	$0x00000000, 0(%rbp,%rax,4)
	movl	$0x00000000, 0(%r13,%rax,4)
	movl	$0x00000000, (%r14,%rax,4)
	movl	$0x00000000, (%r15,%rax,4)
	movl	$0x00000000, (%rbx,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L102
	jmp	.L114
	.cfi_endproc
.LFE36:
	.size	key_func, .-key_func
	.section	.rodata.str1.8
	.align 8
.LC9:
	.string	"usage : %s N dt diff visc force source\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC10:
	.string	"where:\n"
.LC11:
	.string	"\t N      : grid resolution\n"
.LC12:
	.string	"\t dt     : time step\n"
	.section	.rodata.str1.8
	.align 8
.LC13:
	.string	"\t diff   : diffusion rate of the density\n"
	.align 8
.LC14:
	.string	"\t visc   : viscosity of the fluid\n"
	.align 8
.LC15:
	.string	"\t force  : scales the mouse movement that generate a force\n"
	.align 8
.LC16:
	.string	"\t source : amount of density that will be deposited\n"
	.align 8
.LC23:
	.string	"Using defaults : N=%d dt=%g diff=%g visc=%g force = %g source=%g\n"
	.section	.rodata.str1.1
.LC24:
	.string	"\n\nHow to use this demo:\n\n"
	.section	.rodata.str1.8
	.align 8
.LC25:
	.string	"\t Add densities with the right mouse button\n"
	.align 8
.LC26:
	.string	"\t Add velocities with the left mouse button and dragging the mouse\n"
	.align 8
.LC27:
	.string	"\t Toggle density/velocity display with the 'v' key\n"
	.align 8
.LC28:
	.string	"\t Clear the simulation by pressing the 'c' key\n"
	.align 8
.LC29:
	.string	"\t Quit by pressing the 'q' key\n"
	.section	.rodata.str1.1
.LC30:
	.string	"cannot allocate data\n"
.LC31:
	.string	"Alias | wavefront"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB43:
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
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	%edi, 12(%rsp)
	leaq	12(%rsp), %rdi
	call	glutInit@PLT
	movl	12(%rsp), %eax
	cmpl	$1, %eax
	je	.L121
	cmpl	$6, %eax
	je	.L121
	movq	(%rbx), %rcx
	movq	stderr(%rip), %rdi
	leaq	.LC9(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC10(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC11(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC12(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC13(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC14(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC15(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	leaq	.LC16(%rip), %rdx
.L132:
	movq	stderr(%rip), %rdi
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	$1, %edi
	call	exit@PLT
.L121:
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	.LC20(%rip), %xmm4
	vmovsd	.LC21(%rip), %xmm3
	vmovsd	.LC22(%rip), %xmm0
	movq	stderr(%rip), %rdi
	movl	$256, %ecx
	vmovsd	%xmm2, %xmm2, %xmm1
	leaq	.LC23(%rip), %rdx
	movl	$1, %esi
	movl	$5, %eax
	movl	$256, N(%rip)
	movl	$0x3dcccccd, dt(%rip)
	movl	$0x00000000, diff(%rip)
	movl	$0x00000000, visc(%rip)
	movl	$0x40a00000, force(%rip)
	movl	$0x42c80000, source(%rip)
	call	__fprintf_chk@PLT
	leaq	.LC24(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC25(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC26(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC27(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC28(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC29(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	N(%rip), %eax
	movl	$0, dvel(%rip)
	addl	$2, %eax
	imull	%eax, %eax
	movslq	%eax, %r12
	movl	%r12d, 8(%rsp)
	salq	$2, %r12
	movq	%r12, %rdi
	call	malloc@PLT
	movq	%r12, %rdi
	movq	%rax, %rbp
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
	testq	%r13, %r13
	movq	%rax, dens_prev(%rip)
	movq	%rax, %rdi
	sete	%al
	testq	%rbp, %rbp
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
	jne	.L122
	testq	%rdi, %rdi
	je	.L122
	movl	8(%rsp), %edx
	testl	%edx, %edx
	je	.L124
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
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%rbp, %rdi
	call	memset@PLT
.L124:
	movl	$2, %edi
	movl	$512, win_x(%rip)
	movl	$512, win_y(%rip)
	call	glutInitDisplayMode@PLT
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	glutInitWindowPosition@PLT
	movl	win_y(%rip), %esi
	movl	win_x(%rip), %edi
	call	glutInitWindowSize@PLT
	leaq	.LC31(%rip), %rdi
	call	glutCreateWindow@PLT
	vxorps	%xmm2, %xmm2, %xmm2
	vmovss	.LC3(%rip), %xmm3
	vmovaps	%xmm2, %xmm1
	vmovaps	%xmm2, %xmm0
	movl	%eax, win_id(%rip)
	call	glClearColor@PLT
	movl	$16384, %edi
	call	glClear@PLT
	call	glutSwapBuffers@PLT
	movl	$16384, %edi
	call	glClear@PLT
	call	glutSwapBuffers@PLT
	movl	win_y(%rip), %ecx
	movl	win_x(%rip), %edx
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	glViewport@PLT
	movl	$5889, %edi
	call	glMatrixMode@PLT
	call	glLoadIdentity@PLT
	vmovsd	.LC5(%rip), %xmm1
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	%xmm1, %xmm1, %xmm3
	vmovsd	%xmm2, %xmm2, %xmm0
	call	gluOrtho2D@PLT
	vxorps	%xmm4, %xmm4, %xmm4
	vmovss	.LC3(%rip), %xmm3
	vmovaps	%xmm4, %xmm2
	vmovaps	%xmm4, %xmm1
	vmovaps	%xmm4, %xmm0
	call	glClearColor@PLT
	movl	$16384, %edi
	call	glClear@PLT
	leaq	key_func(%rip), %rdi
	call	glutKeyboardFunc@PLT
	leaq	mouse_func(%rip), %rdi
	call	glutMouseFunc@PLT
	leaq	motion_func(%rip), %rdi
	call	glutMotionFunc@PLT
	leaq	reshape_func(%rip), %rdi
	call	glutReshapeFunc@PLT
	leaq	idle_func(%rip), %rdi
	call	glutIdleFunc@PLT
	leaq	display_func(%rip), %rdi
	call	glutDisplayFunc@PLT
	call	glutMainLoop@PLT
	xorl	%edi, %edi
	call	exit@PLT
.L122:
	leaq	.LC30(%rip), %rdx
	jmp	.L132
	.cfi_endproc
.LFE43:
	.size	main, .-main
	.data
	.align 4
	.type	times.0, @object
	.size	times.0, 4
times.0:
	.long	1
	.local	one_second.1
	.comm	one_second.1,8,8
	.local	dens_ns_p_cell.2
	.comm	dens_ns_p_cell.2,8,8
	.local	vel_ns_p_cell.3
	.comm	vel_ns_p_cell.3,8,8
	.local	react_ns_p_cell.4
	.comm	react_ns_p_cell.4,8,8
	.local	start_t.5
	.comm	start_t.5,8,8
	.local	my
	.comm	my,4,4
	.local	mx
	.comm	mx,4,4
	.local	omy
	.comm	omy,4,4
	.local	omx
	.comm	omx,4,4
	.local	mouse_down
	.comm	mouse_down,12,8
	.local	win_y
	.comm	win_y,4,4
	.local	win_x
	.comm	win_x,4,4
	.local	win_id
	.comm	win_id,4,4
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
	.local	dvel
	.comm	dvel,4,4
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
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	889599933
	.align 4
.LC2:
	.long	1092616192
	.align 4
.LC3:
	.long	1065353216
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	0
	.long	1104006501
	.align 8
.LC5:
	.long	0
	.long	1072693248
	.section	.rodata.cst4
	.align 4
.LC8:
	.long	1056964608
	.section	.rodata.cst8
	.align 8
.LC20:
	.long	0
	.long	1079574528
	.align 8
.LC21:
	.long	0
	.long	1075052544
	.align 8
.LC22:
	.long	-1610612736
	.long	1069128089
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
