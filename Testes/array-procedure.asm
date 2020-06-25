.data
	tam:	  .byte  3
	pad:	  .space 3		# preenchimento
	array_a:  .space 12
	array_b:  .space 12
	array_r:  .space 12
	in:       .asciiz "Entre com o valor ["
	in_a:	  .asciiz "Entre com os valores de A\n"
	in_b:	  .asciiz "Entre com os valores de B\n"
	abre:	  .asciiz "["
	fecha:    .asciiz "] = "
	new_line: .asciiz "\n"
	out:      .asciiz "Vetor resultado soma A+B: "
.text 
.globl main
	j 	main
	
	ler_array:			# args	->   a1 = tamanho, a2 = endereco para salvar
		addi	$v1, $zero, 0
		LOOP_IN:
			slt	$v0, $v1, $a1
			beq	$v0, $zero, EXIT_IN
			addi	$v0, $zero, 4
			la	$a0, in
			syscall
			addi	$v0, $zero, 1
			add	$a0, $zero, $v1
			syscall
			addi	$v0, $zero, 4
			la	$a0, fecha
			syscall
			addi	$v0, $zero, 5
			syscall
			sw	$v0, 0($a2)
			addi	$a2, $a2, 4
			addi	$v1, $v1, 1
			j	LOOP_IN
		EXIT_IN:
			jr	$ra
			
	soma_arrays:	# args	->   a1 = tam, a2 = endereco de a, a3 = endereco de b, a0 = endereco para salvar
		beqz	$a2, EXIT_SUM
		beqz	$a3, EXIT_SUM
		LOOP_SUM:
		  	lw	$v0, 0($a2)
		  	lw	$v1, 0($a3)
		  	add	$v0, $v0, $v1
		  	sw	$v0, 0($a0)
		  	addi	$a0, $a0, 4	
		  	addi	$a2, $a2, 4
		  	addi	$a3, $a3, 4
		  	subi	$a1, $a1, 1
		  	bne	$a1, $zero, LOOP_SUM
		  	j	EXIT_SUM
		EXIT_SUM:
			jr	$ra
			
	imprime_array:			# args	->   a1 = tam, a2 = endereco array
		addi	$v1, $zero, 0
		LOOP_PRT:
			slt	$v0, $v1, $a1
			beq	$v0, $zero, EXIT_PRT
			addi	$v0, $zero, 4
			la	$a0, new_line
			syscall
			la	$a0, abre
			syscall
			addi	$v0, $zero, 1
			add	$a0, $zero, $v1
			syscall
			addi	$v0, $zero, 4
			la	$a0, fecha
			syscall
			addi	$v0, $zero, 1
			lw	$t0, 0($a2)
			add	$a0, $zero, $t0
			syscall
			addi	$v1, $v1, 1
			addi	$a2, $a2, 4
			j	LOOP_PRT
		EXIT_PRT:
			jr	$ra	
	main:
		la	$s0, tam
		lw	$a1, 0($s0)
		la	$a2, array_a
		addi	$v0, $zero, 4
		la	$a0, in_a
		syscall
		jal	ler_array
		la	$a2, array_b
		addi	$v0, $zero, 4
		la	$a0, new_line
		syscall
		la	$a0, in_b
		syscall
		jal	ler_array
		la	$a2, array_a
		la	$a3, array_b
		la	$a0, array_r
		jal	soma_arrays
		addi	$v0, $zero, 4
		la	$a0, new_line
		syscall
		la	$a0, out
		syscall
		lw	$a1, 0($s0)
		la	$a2, array_r
		jal	imprime_array
