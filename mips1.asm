.data
array: .space 50000
idBD: .word 0
bycate: .space 40000

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

Separacao1:      .asciiz " | "
Separacao2:	      .asciiz "- "
Barra:	.asciiz "/"
Espaco:	.asciiz " "
Ponto:	.asciiz "."
FimDeLinha:	.asciiz "\n"
Zero:	.asciiz "0"

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
	sw $t0, idBD

	sw $t0, 0($s1)

	addi $s1, $s1, 4 # andei 4 unidades com meu glorioso

#lendo valor
	li $v0, 4
	la $a0, msgOp1_1
	syscall

	li $v0, 6
	syscall
#f0 contem o valor lido
	mfc1 $a0, $f0 	#esta movendo do coprocessador1 o valor float para o registrador $a0
	s.s  $f0, 0($s1)	#gravando na pos do vetor o valor em float, esse comando é diretao sem necessidado do primeiro
	addi $s1, $s1, 4 	#andei 4 unidades com meu glorioso

	li $v0, 4
	la $a0, msgOp1_2
	syscall
	add $a0,$s1,$zero
	li $a1, 16	
	li $v0, 8
	syscall
	addi $s1, $s1, 16 	# andei 16 unidades com meu glorioso	

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
	li $v0, 5				#leitura do ano
	syscall
	move $t0, $v0	
	sw $t0, 0($s1)			#salvamento do ano
	addi $s1,$s1, 4		# andei 4 unidades
#FIM ANO
	j menuzin
	
listar:
	la $s0, array
	add $t0, $zero, $zero
	lw $t1, idBD
	sub $t1, $t1, 1
	add $s3, $s0, $zero 	#s3 tera uma copia do endereco inicial do vetor
LOOP:	
	lw $t2, 0($s3)
	add $a0, $t2,$zero 
	li $v0, 1				#print do ID
	syscall
	li $v0, 4
	la $a0, Separacao2
	syscall
	addi $s3, $s3, 4

	l.s $f12, 0($s3)
	li $v0, 2				#print do valor
	syscall
	li $v0, 4
	la $a0, Espaco
	syscall
	addi $s3, $s3, 4
	

	la $a0, 0($s3)			#print string
	li $v0, 4			
	syscall
	li $v0, 4				#print espaço
	la $a0, Espaco
	syscall
	addi $s3, $s3, 16

	lw $a0, 0($s3)			#print dia
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, Barra
	syscall
	addi $s3, $s3, 4
		
	lw $a0, 0($s3)			#print mes
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, Barra
	syscall
	addi $s3, $s3, 4
	
	lw $a0, 0($s3)			#print ano
	li $v0, 1
	syscall
	addi $s3, $s3, 4
	
	li $v0, 4
	la $a0, FimDeLinha
	syscall

	beq $t0, $t1, menuzin 	#comparando se sao iguais
	addi $t0, $t0, 1 		#somando 1 ao meu i
	j LOOP 				#pular para o loop
	
excluir:
	la $s4, array
	li $v0, 5				# leitura do ID
	syscall
	move $t0, $v0
next:
	beq $t0, $s4, find		
	add $s4, $s4, 36		#procura de 36 em 36
	j next
find:
	addi $t1, $s4, $zero	
	add $s4, $s4, 36
	j find
	
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
	la $a0, Separacao1
	syscall
	jr $ra

strcmp:			#compara duas strings,A e B, salvas em $s3 e $s4, e retorna qual vem depois, na ordem alfabetica, ou se elas são iguais
	cmpl1:
		lb 	$t2,($s3) 
		lb 	$t3,($s4)
		bne 	$t2,$t3,cmpne #if character of stringA not equal character of stringB
		
		beq 	$t2,$zero,cmpeq	#if it's the end of string
		addi 	$s3,$s3,1 #test next character
		addi 	$s4,$s4,1 #test next character
		j 	cmpl1
	cmpne:
		slt 	$t5,$s3,$s4	#if character from stringA is greater than character from stringB
		bne 	$t5,$zero,AgB
		j 	BgA	#else
	
	AgB:
		addi 	$sp,$sp,-4
		li 	$t5,2
		sw 	$t5,($sp)
		jr 	$ra
	BgA:
		addi 	$sp,$sp,-4
		li 	$t5,3
		sw 	$t5,($sp)
		jr 	$ra
	cmpeq:
		addi 	$sp,$sp,-4
		li 	$t5,0
		sw 	$t5,($sp)
		jr 	$ra
		
strcpy:
	copyloop:
		lb 	$t0,($s3)	#byte of stringA to $t0
		sb 	$t0,($s4)	#byte of t0 to stringB
		beqz 	$t0, endcpy	#if byte is \0, end
		addi 	$s3,$s3,1	#walk a step with stringA
		addi 	$s4,$s4,1	#walk a step with stringB
		j 	copyloop	#loop
	endcpy:
		jr 	$ra

dividebycategory:
	la	$s5,array	#$s5 tem o inicio da array
	la	$s6,bycate	#$s6 tem o inicio da divisão por categoria
	divideloop1:
		la	$s4,($s6)	#$s4 tem o endereço de onde está o vetor bycate
		la	$s3,($s5)	#$s3 tem o endereço de onde está o vetor array
		beq	$s3,$s1,enddivide	#se estiver no final do vetor, terminar a função
		addi	$s3,$s3,8	#chega na parte de categorias do struct despesa
		addi	$sp,$sp,-4	#anda com a stack
		sw	$ra,($sp)	#coloca o $ra na stack
		jal	strcmp		#compara pra ver se eles são iguais
		lw	$t0,($sp)	#pega o retorno do strcpy
		lw	$ra,4($sp)	#pega o endereço de retorno da stack
		addi	$sp,$sp,8	#volta para a posição inicial da stack
		la	$s4,($s6)	#$s4 tem o endereço de onde está o vetor bycate
		la	$s3,($s5)	#$s3 tem o endereço de onde está o vetor array
		addi	$s3,$s3,8	#chega na parte de categorias do struct despesa
		beqz	$t0,iguais	#se elas forem iguais
	#diferentes
		lb	$t0,($s4)
		beq	$t0,$zero,newcategory	#se estiver no final de bycate, criar nova categoria
		#senão, andar com o bycate
		addi	$s5,$s3,-8	#volta o vetor pro inicio da struct
		addi	$s6,$s4,22	#ir pro proximo struct de bycate
		j	divideloop1	
	iguais:
		addi	$s3,$s3,-4	#volta pra a parte float
		addi	$s4,$s4,16	#vai pra a parte float
		l.s	$f1,($s3)	#pega o float do array
		l.s	$f2,($s4)	#pega o float do bycate
		add.s	$f0,$f1,$f2	#soma eles
		s.s	$f0,($s4)	#salva o resultado no bycate
		la	$s6,bycate	#volta pro inicio do bycate
		addi	$s5,$s3,32	#anda com o array até a proxima posição
		j	divideloop1
	newcategory:
		addi	$sp,$sp,-4	#anda com a stack
		sw	$ra,($sp)	#coloca o endereço de retorno na stack
		jal	strcpy
		lw	$ra,($sp)	#desempilha o endereço de retorno
		addi	$sp,$sp,4	#retorna a pilha pro inicio dela
		la	$s4,($s6)	#$s4 tem o endereço de onde está o vetor bycate
		la	$s3,($s5)	#$s3 tem o endereço de onde está o vetor array
		addi	$s3,$s3,8	#chega na parte de categorias do struct despesa
		j	iguais		#como a string foi copiada, agora elas são iguais
	enddivide:
		jr	$ra		#volta pra onde chamou
