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
entrouOp1:  .asciiz "entrou no 1\n"
entrouOp2:  .asciiz "entrou na 2\n"
entrouOp3:  .asciiz "entrou no 3\n"
entrouOp4:  .asciiz "entrou no 4\n"
entrouOp5:  .asciiz "entrou no 5\n"
entrouOp6:  .asciiz "entrou no 6\n\n\n\n"
msgOp1_1:   .asciiz "Digite o valor da em reais da despesa\n"
idBD: .byte 4

array: .space 50000
tamArray: .byte 40
posAtualArray: .byte 4


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
	beq $v0,2,listar
	beq $v0,3,excluir
	beq $v0,4,exibir_mensal
	beq $v0,5,exibir_categoria
	beq $v0,6,exibir_rank_despesa
	j main

registro:
	#Msg de entrada na func
	li $v0, 4
	la $a0, entrouOp1
	syscall
	#fim da gloriosa
	
	li $v0, 4
	la $a0, msgOp1_1
	syscall
	#lendo valor
	
	li $v0, 6
	syscall
	
	#f0 contem o valor lido
	la  $t0, array #carreguei em t0 o end do vetor
	
	#mfc1 $a0, $f0 #esta movendo do coprocessador1 o valor float para o registrador $a0

	
	s.s  $f0, -1($t0)#gravando na pos 0
	
	
	#li $v0, 2
	#l.s $f12, 0($t0) #carreguei um float direto do vetor na posicao 
	#syscall
	

	
	j main
listar:
	li $v0,4
	la $a0, entrouOp2
	syscall
	j main
excluir:
	li $v0,4
	la $a0, entrouOp3
	syscall
	j main
exibir_mensal:
	li $v0,4
	la $a0, entrouOp4
	syscall
	j main
exibir_categoria:
	li $v0,4
	la $a0, entrouOp5
	syscall
	j main
exibir_rank_despesa:
	li $v0,4
	la $a0, entrouOp6
	syscall
	j main
	
