.data
array: .space 50000
idBD: .word 0

welcome:  .asciiz "\nwelcome to the bank...!\n"
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
msgOp1_2:   .asciiz "Digite o nome da categoria do gasto\n"

msgOp1_3:   .asciiz "Digite o dia \n"
msgOp1_4:   .asciiz "Digite o mes \n"
msgOp1_5:   .asciiz "Digite o ano \n"

Separacao:      .asciiz " | "
Barra:		.asciiz "/"
Espaco:		.asciiz " "
Ponto:		.asciiz "."
FimDeLinha:	.asciiz "\n"
Zero:		.asciiz "0"

tamArray: .byte 40
posAtualArray: .byte 4


.text
.globl main
main:
	la  $s0, array #carreguei em s0 o end inicial do vetor
	la  $s1, array #carreguei em s1 o end final do vetor
	
menuzin:	
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
	j menuzin

registro:
	#Msg de entrada na func
	li $v0, 4
	la $a0, entrouOp1
	syscall
	#fim da gloriosa
	

	#ler ID 
	lw $t0, idBD
	addi $t0, $t0, 1
	
	sw $t0, 0($s1)
	
	addi $s1, $s1, 4 # andei 4 unidades com meu glorioso
	
	#lendo valor
	li $v0, 4
	la $a0, msgOp1_1
	syscall
	
	li $v0, 6
	syscall
	#f0 contem o valor lido
	#mfc1 $a0, $f0 #esta movendo do coprocessador1 o valor float para o registrador $a0
	s.s  $f0, 0($s1)#gravando na pos do vetor o valor em float, esse comando é diretao sem necessidado do primeiro
	
	addi $s1, $s1, 4 # andei 4 unidades com meu glorioso
	
	li $v0, 4
	la $a0, msgOp1_2
	syscall
	add $a0,$zero, $s1
	li $a1, 16	
	li $v0, 8
	syscall
	addi $s1, $s1, 16 # andei 16 unidades com meu glorioso
	
	
	#FIM da categoria
	li $v0, 4
	la $a0, msgOp1_3
	syscall
	
	li $v0, 5 # leitura do dia
	syscall
	move $t0, $v0
	sw $t0, 0($s1)	# salvamento do dia
	addi $s1,$s1, 4	# andei 4 unidades
	#FIM DIA
	li $v0, 4
	la $a0, msgOp1_4
	syscall
	li $v0, 5	# leitura do mes
	syscall
	move $t0, $v0
	sw $t0, 0($s1)	# salvamento do mes
	addi $s1,$s1, 4	# andei 4 unidades
	#FIM MES
	li $v0, 4
	la $a0, msgOp1_5
	syscall
	li $v0, 5	#leitura do ano
	syscall
	move $t0, $v0	
	sw $t0, 0($s1)	#salvamento do ano
	addi $s1,$s1, 4	# andei 4 unidades
	#FIM ANO
	j menuzin
listar:
	li $v0,4
	la $a0, entrouOp2
	syscall
	
	add $t0, $zero, $zero
	lw $t1, idBD
	add $s3, $s0, $zero #s3 tera uma copia do endereco inicial do vetor
LOOP:	
	lw $t2, 0($s3)
	add $a0, $t2,$zero 
	li $v0, 1	#print do ID
	syscall
	
	l.s $f12, 4($s3)
	li $v0, 2	#print do valor
	syscall
	
	lw $a0, 20($s3)
	
	
	li $v0, 4	#print string
	syscall
	
	beq $t0, $t1, FIM #comparando se sao iguais
	addi $t0, $t0, 1 #somando 1 ao meu i
	j LOOP #pular para o loop
	
	
FIM:

j menuzin
excluir:
	li $v0,4
	la $a0, entrouOp3
	syscall
	j menuzin
exibir_mensal:
	li $v0,4
	la $a0, entrouOp4
	syscall
	j menuzin
exibir_categoria:
	li $v0,4
	la $a0, entrouOp5
	syscall
	j menuzin
exibir_rank_despesa:
	li $v0,4
	la $a0, entrouOp6
	syscall
	j menuzin
	
	
PrintaEspaco:
	li $v0, 4
	la $a0, Espaco
	syscall
	jr $ra
	
PrintaBarra:
	li $v0, 4
	la $a0, Barra
	syscall
	jr $ra
	
PrintaPonto:
	li $v0, 4
	la $a0, Ponto
	syscall
	jr $ra
	
PrintaSeparacao:
	li $v0, 4
	la $a0, Separacao
	syscall
	jr $ra
