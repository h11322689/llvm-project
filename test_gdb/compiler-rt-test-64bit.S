	.text
	.file	"compiler-rt-test.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	leaq	.L.str(%rip), %rdi
	leaq	-16(%rbp), %rsi
	leaq	-24(%rbp), %rdx
	movb	$0, %al
	callq	__isoc99_scanf@PLT
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	movl	%ecx, %edx
	divq	-24(%rbp)
	movq	%rax, %rsi
	leaq	.L.str.1(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%lld %lld"
	.size	.L.str, 10

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"64-bit division is %lld\n"
	.size	.L.str.1, 25

	.ident	"clang version 17.0.0 (https://gh.con.sh/https://github.com/h11322689/llvm-project.git f7dac5fc3dce735c19d29a6d0aef636512982e59)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
