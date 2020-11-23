.data
	fim: .asciiz "\nFim do programa"
	msg: .asciiz "O valor da soma eh: "
.text
.globl main
main:
	li		$a0, 12
	li		$a1, 10
	jal		soma
	addi		$v0, $zero, 4
	la		$a0, fim
	syscall
	addi		$v0, $zero, 10
	syscall


soma:
	addi		$sp, $sp, -4
	sw		$ra, 0($sp)
	add		$a2, $a0, $a1
	jal		imprimir
	lw		$ra, 0($sp)
	addi		$sp, $sp, 4
	jr		$ra


imprimir:
	addi		$v0, $zero, 4
	la		$a0, msg
	syscall
	addi		$v0, $zero, 1
	add		$a0, $zero, $a2
	syscall
	jr		$ra
