	.text
	.file	"compiler-rt-test.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$44, %esp
	.cfi_offset %esi, -20
	.cfi_offset %edi, -16
	.cfi_offset %ebx, -12
	calll	.L0$pb
.L0$pb:
	popl	%ebx
.Ltmp0:
	addl	$_GLOBAL_OFFSET_TABLE_+(.Ltmp0-.L0$pb), %ebx
	movl	%ebx, -36(%ebp)                 # 4-byte Spill
	movl	$0, -16(%ebp)
	movl	$0, -20(%ebp)
	movl	$0, -24(%ebp)
	movl	$0, -28(%ebp)
	movl	$0, -32(%ebp)
	movl	%esp, %eax
	leal	-32(%ebp), %ecx
	movl	%ecx, 8(%eax)
	leal	-24(%ebp), %ecx
	movl	%ecx, 4(%eax)
	leal	.L.str@GOTOFF(%ebx), %ecx
	movl	%ecx, (%eax)
	calll	__isoc99_scanf@PLT
	movl	-36(%ebp), %ebx                 # 4-byte Reload
	movl	-24(%ebp), %ecx
	movl	-20(%ebp), %edx
	movl	-32(%ebp), %esi
	movl	-28(%ebp), %edi
	movl	%esp, %eax
	movl	%edi, 12(%eax)
	movl	%esi, 8(%eax)
	movl	%edx, 4(%eax)
	movl	%ecx, (%eax)
	calll	__udivdi3@PLT
	movl	-36(%ebp), %ebx                 # 4-byte Reload
	movl	%eax, %ecx
	leal	.L.str.1@GOTOFF(%ebx), %eax
	movl	%esp, %eax
	movl	%edx, 8(%eax)
	movl	%ecx, 4(%eax)
	leal	.L.str.1@GOTOFF(%ebx), %ecx
	movl	%ecx, (%eax)
	calll	printf@PLT
	xorl	%eax, %eax
	addl	$44, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	.cfi_def_cfa %esp, 4
	retl
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
