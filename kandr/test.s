	.file	"test.c"
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "iterating\0"
LC1:
	.ascii "C is %d\12\0"
LC2:
	.ascii "EOF is %d\12\0"
LC3:
	.ascii "Tabs are %d\12\0"
LC4:
	.ascii "Spaces are %d\12\0"
	.align 4
LC5:
	.ascii "Digraphs are very <: <% %> %: cool\12\0"
	.align 4
LC6:
	.ascii "Trigraphs are they worse ??= ??/ ??' ??! ??< ??> ??-\0"
	.align 4
LC7:
	.ascii "diAgraphs triAgraphs are not spelled that way, mkeii?! You stupid idiot!\0"
	.text
.globl _main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	call	___main
	movl	$5, 28(%esp)
	jmp	L2
L3:
	movl	$LC0, (%esp)
	call	_puts
	movl	28(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_printf
	movl	$-1, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$4, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$4, 4(%esp)
	movl	$LC4, (%esp)
	call	_printf
	movl	$LC5, (%esp)
	call	_printf
	movl	$LC6, (%esp)
	call	_puts
	movl	$LC7, (%esp)
	call	_puts
L2:
	subl	$1, 28(%esp)
	cmpl	$1, 28(%esp)
	je	L3
	subl	$1, 28(%esp)
	cmpl	$3, 28(%esp)
	je	L3
	subl	$1, 28(%esp)
	cmpl	$2, 28(%esp)
	je	L3
	movl	$0, %eax
	leave
	ret
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
