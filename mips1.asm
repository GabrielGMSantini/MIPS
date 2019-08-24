.data
welcome:  .asciiz "welcome to the bank...!\n"
menu:     .asciiz "Choose from the following options:\n"
opt1:  .asciiz "1) register expenses\n"
opt2:  .asciiz "2) list the expenses\n"
opt3:  .asciiz "3) exclude expenses\n"
opt4:  .asciiz "4) show monthly expenses\n"
opt5:  .asciiz "5) show expenses sorted by category\n"
opt6:  .asciiz "6) rank the expenses\n"
quit:  .asciiz "7) quit\n"
tst1:  .asciiz "entrou no 1\n"
tst2:  .asciiz "entrou na 2\n"
tst3:  .asciiz "entrou no 3\n"
tst4:  .asciiz "entrou no 4\n"
tst5:  .asciiz "entrou no 5\n"
tst6:  .asciiz "entrou no 6\n\n\n\n"

.text
.globl main
main:

	li $v0, 4
	la $a0, welcome
	syscall
	li $v0,4
	la $a0, menu
	syscall
	li $v0,4
	la $a0, opt1
	syscall
	li $v0,4
	la $a0, opt2
	syscall
	li $v0,4
	la $a0, opt3
	syscall
	li $v0,4
	la $a0, opt4
	syscall
	li $v0,4
	la $a0, opt5
	syscall
	li $v0,4
	la $a0, opt6
	syscall
	li $v0,4
	la $a0, quit
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0,1,registro
	j regitrarDespesa
	beq $v0,2,listar
	beq $v0,3,excluir
	beq $v0,4,exibir_mensal
	beq $v0,5,exibir_categoria
	beq $v0,6,exibir_rank_despesa
	j main

registro:
	li $v0,4
	la $a0, tst1
	syscall
	j main
listar:
	li $v0,4
	la $a0, tst2
	syscall
	j main
excluir:
	li $v0,4
	la $a0, tst3
	syscall
	j main
exibir_mensal:
	li $v0,4
	la $a0, tst4
	syscall
	j main
exibir_categoria:
	li $v0,4
	la $a0, tst5
	syscall
	j main
exibir_rank_despesa:
	li $v0,4
	la $a0, tst6
	syscall
	j main
	
registrarDespesa:


	j main
