.data
array: .space 50000
idBD: .word 0
numcate:	.word 0
bycate: .space 25000
bymon:	.space 25000
nummon: .word 0

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
	beq $v0,3,exclude
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
	beq $s0, $s1, menuzin
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
	beq $s3, $s1, menuzin			#somando 1 ao meu i
	j LOOP 					#pular para o loop
	
exclude:
	la $s4, array
	li $v0, 5				# leitura do ID
	syscall
	move $s7, $v0
next:
	lw $t1,($s4)
	beq $s7, $t1, find		
	addi $s4, $s4, 36			#procura de 36 em 36
	j next
find:
	addi $s5, $s4, 36
	beq $s5, $s1, corta
	lb $t1,($s4)
	lb $t2,($s5)
	sb $t1,($s5)
	sb $t2,($s4)
	addi $s4, $s4, 1
	addi $s5, $s5, 1
	beq $s5, $s1, corta
	j find
corta:
	addi $s1, $s1, -36
	j menuzin
FIM:
	j menuzin
	excluir:
	li $v0,4
	la $a0, entrouOp3
	syscall
	j menuzin
	
exibir_mensal:
	jal	dividebymon
	jal	printbymon
	j menuzin
	
exibir_categoria:
	jal	dividebycategory
	jal	sortbycatealpha
	jal	printbycate
	j menuzin
	
exibir_rank_despesa:
	jal	dividebycategory
	jal	sortbycaterank
	jal	printbycate
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
		lb	$t1,($s3)
		lb	$t2,($s4)
		slt 	$t5,$t1,$t2	#if character from stringA is greater than character from stringB
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
		lw	$t0,($sp)	#pega o retorno do strcmp
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
		addi	$s6,$s4,20	#ir pro proximo struct de bycate
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
		lw	$t1,numcate
		addi	$t1,$t1,1
		sw	$t1,numcate
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
		
printbycate:
	la	$s3,bycate	#$s3 recebe o inicio do struct por categoria
	lw	$s7,numcate	#$s7 recebe o numero de categorias
	li	$s6,0	#$s6 recebe 0 (ele vai ser o contador)
	loopprintcate:
		#print nome categoria
		la 	$a0, 0($s3)			
		li 	$v0, 4			
		syscall
		li 	$v0, 4				
		la 	$a0, Espaco
		syscall
		addi 	$s3, $s3, 16
		#print valor categoria
		l.s 	$f12, 0($s3)
		li 	$v0, 2				#
		syscall
		li 	$v0, 4
		la 	$a0, Espaco
		syscall
		li 	$v0, 4
		la 	$a0, FimDeLinha
		syscall
		addi 	$s3, $s3, 4
		addi	$s6,$s6,1		#soma 1 no contador
		beq	$s6,$s7,fimprintcate	#ve se chegou no fim
		j	loopprintcate
	fimprintcate:
		addi	$sp,$sp,-4
		sw	$ra,($sp)
		jal	zerarbycate	#zera o vetor bycate
		lw	$ra,($sp)
		addi	$sp,$sp,4
		jr 	$ra

zerarbycate:
	lw	$s7,numcate	#$s7 tem o numero de categorias
	mul	$s7,$s7,20	#$s7 tem o numero de bytes que tem que zerar
	la	$s6,bycate	#$s6 tem o inicio do bycate
	add	$s7,$s7,$s6	#$s7 tem o endereço do final do bycate
	loopzerar:
		beq	$s7,$s6,endzerar	#se for o fim do que tem que zerar
		sb	$zero,($s6)	#zera o bit
		addi	$s6,$s6,1	#anda com o registrador $s6
		j	loopzerar	
	endzerar:
		sw	$zero,numcate
		jr	$ra

sortbycatealpha:
	la	$s5,bycate		#endereço de bycate em $s5
	lw	$t1,numcate		#numero de categorias em $t1
	mul	$t1,$t1,20		#numero de bytes de bycate
	add	$s6,$s5,$t1		#$s6 tem o endereço do final de bycate
	addi	$s6,$s6,-40		#$s6 fica com o endereço de N-2
	la	$s7,($s6)		#$s7 guarda $s6, que é N-2
	loopsortalpha1:
		la	$s4,20($s7)	#$s4 tem a posição do vetor em N-1
		slt	$t1,$s5,$s4	#se i<N-1
		bnez	$t1,loopsortalpha2
		jr	$ra	#sai da função
		loopsortalpha2:
			la	$s3,($s6)	#$s3 tem a posição do vetor em j
			blt	$s3,$s5,acertarregistsalpha	#sair do loop 2 e acertar os registradores se j<i
			la	$s4,20($s6)	#$s4 tem a posição do vetor em j+1
			addi	$sp,$sp,-4
			sw	$ra,($sp)	#salva o endereço de retorno na stack
			jal	strcmp		#compara as strings
			lw	$t1,($sp)	#pega o retorno da comparação
			lw	$ra,4($sp)	#restaura o endereço de retorno
			addi	$sp,$sp,8	#restaura a stack pro inicio
			beq	$t1,3,swapalpha	#se V[j] > V[j+1], troca
			addi	$s6,$s6,-20	#j--
			j	loopsortalpha2
		
		swapalpha:
			la	$s3,($s6)	#$s3 tem a posição do vetor em j
			la	$s4,20($s6)	#$s4 tem a posição do vetor em j+1
			li	$t1,20
			sw	$t1,-4($sp)
			loopswapalpha:
				lb	$t1,($s3)	#pega o byte em $s3 e salva em $t1
				lb	$t2,($s4)	#pega o byte em $s4 e salva em $t2
				sb	$t1,($s4)	#pega o byte que era de $s3 e salva em $s4
				sb	$t2,($s3)	#pega o byte que era de $s4 e salva em $s3
				addi	$s3,$s3,1
				addi	$s4,$s4,1
				lw	$t1,-4($sp)
				addi	$t1,$t1,-1	#diminui no contador
				beqz	$t1,endswapalpha	#se for zero
				sw	$t1,-4($sp)
				j	loopswapalpha
			endswapalpha:
				addi	$s6,$s6,-20	#j--
				j	loopsortalpha2
		acertarregistsalpha:
			la	$s6,($s7)	#j=N-2
			addi	$s5,$s5,20	#i++
			j	loopsortalpha1

sortbycaterank:
	la	$s5,bycate		#endereço de bycate em $s5
	lw	$t1,numcate		#numero de categorias em $t1
	mul	$t1,$t1,20		#numero de bytes de bycate
	add	$s6,$s5,$t1		#$s6 tem o endereço do final de bycate
	addi	$s6,$s6,-40		#$s6 fica com o endereço de N-2
	la	$s7,($s6)		#$s7 guarda $s6, que é N-2
	loopsortrank1:
		la	$s4,20($s7)	#$s4 tem a posição do vetor em N-1
		slt	$t1,$s5,$s4	#se i<N-1
		bnez	$t1,loopsortrank2
		jr	$ra	#sai da função	
		loopsortrank2:
			la	$s3,($s6)	#$s3 tem a posição do vetor em j
			blt	$s3,$s5,acertarregistrank	#sair do loop 2 e acertar os registradores se j<i
			la	$s4,20($s6)	#$s4 tem a posição do vetor em j+1
			l.s	$f1,16($s3)	#$f1 tem a parte float de j
			l.s	$f2,16($s4)	#$f2 tem a parte float de j+1
			c.lt.s	$f1,$f2		#compara se a parte float de j é menor que a parte float de j+1
			bc1t	swaprank
			addi	$s6,$s6,-20	#j--
			j	loopsortrank2
		swaprank:
			la	$s3,($s6)	#$s3 tem a posição do vetor em j
			la	$s4,20($s6)	#$s4 tem a posição do vetor em j+1
			li	$t1,20
			sw	$t1,-4($sp)
			loopswaprank:
				lb	$t1,($s3)	#pega o byte em $s3 e salva em $t1
				lb	$t2,($s4)	#pega o byte em $s4 e salva em $t2
				sb	$t1,($s4)	#pega o byte que era de $s3 e salva em $s4
				sb	$t2,($s3)	#pega o byte que era de $s4 e salva em $s3
				addi	$s3,$s3,1
				addi	$s4,$s4,1
				lw	$t1,-4($sp)
				addi	$t1,$t1,-1	#diminui no contador
				beqz	$t1,endswaprank	#se for zero
				sw	$t1,-4($sp)
				j	loopswaprank
			endswaprank:
				addi	$s6,$s6,-20	#j--
				j	loopsortrank2
		acertarregistrank:
			la	$s6,($s7)	#j=N-2
			addi	$s5,$s5,20	#i++
			j	loopsortrank1
	
dividebymon:
	la	$s5,array	#$s5 tem o inicio da array
	la	$s6,bymon	#$s6 tem o inicio da divisão por mês
	divideloop2:
		la	$s4,($s6)	#$s4 tem o endereço de onde está o vetor bymon
		la	$s3,($s5)	#$s3 tem o endereço de onde está o vetor array
		beq	$s3,$s1,enddivide	#se estiver no final do vetor, terminar a função
		lw	$t1,($s4)
		beqz	$t1,newmon	#se estiver no fim de bymon, registrar novo mês
		lw	$t1,32($s3)	#pega a parte do struct que tem o ano de array
		lw	$t2,4($s4)	#pega a parte do struct que tem o ano de bymon
		beq	$t1,$t2,anosiguais	#ver se os anos são iguais
		#	diferentes
		addi	$s6,$s6,12		#anda com bymon
		j	divideloop2
		anosiguais:
			lw	$t1,28($s3)	#pega a parte do struct que tem o mes do array
			lw	$t2,($s4)	#pega a parte do struct que tem o mes de bymon
			beq	$t1,$t2,atualizarmon
			#	diferentes
			addi	$s6,$s6,12		#anda com bymon
			j	divideloop2
		newmon:
			lw	$t1,28($s3)	#pega o mes
			sw	$t1,($s4)	#salva no começo da nova celula mês
			lw	$t1,32($s3)	#pega o ano
			sw	$t1,4($s4)	#salva depois do mês da nova celula
			l.s	$f1,4($s3)	#pega a despesa
			s.s	$f1,8($s4)	#salva na parte float
			lw	$t1,nummon
			addi	$t1,$t1,1
			sw	$t1,nummon
			addi	$s5,$s5,36	#vai pro proximo endereço do array
			la	$s6,bymon	#restaura bymon pro começo
			j	divideloop2
		atualizarmon:
			l.s	$f1,4($s3)	#pega a despésa
			l.s	$f2,8($s4)	#pega os gastos do mês
			add.s	$f0,$f1,$f2	#soma as despesas
			s.s	$f0,8($s4)	#salva em bymon
			addi	$s5,$s5,36	#anda com o vetor
			la	$s6,bymon	#restaura bymon pro começo
			j	divideloop2
		
printbymon:
	la	$s3,bymon	#$s3 recebe o inicio do struct por mes
	lw	$s7,nummon	#$s7 recebe o numero de meses
	li	$s6,0	#$s6 recebe 0 (ele vai ser o contador)
		loopprintbymon:
		#printa	mes
		lw 	$a0, 0($s3)			
		li 	$v0, 1
		syscall
		li 	$v0, 4
		la 	$a0, Barra
		syscall
		addi 	$s3, $s3, 4
		#print ano
		lw 	$a0, 0($s3)			
		li 	$v0, 1
		syscall
		addi 	$s3, $s3, 4		
		li 	$v0, 4
		la 	$a0, Espaco
		syscall
		l.s 	$f12, 0($s3)
		li 	$v0, 2				#
		syscall	
		li 	$v0, 4
		la 	$a0, FimDeLinha
		syscall
		addi 	$s3, $s3, 4
		addi	$s6,$s6,1		#soma 1 no contador
		bge	$s6,$s7,fimprintmon	#ve se chegou no fim
		j	loopprintbymon
	fimprintmon:
		addi	$sp,$sp,-4
		sw	$ra,($sp)
		jal	zerarbymon	#zera o vetor bycate
		lw	$ra,($sp)
		addi	$sp,$sp,4
		jr 	$ra	
			
zerarbymon:
	lw	$s7,nummon	#$s7 tem o numero de meses
	mul	$s7,$s7,12	#$s7 tem o numero de bytes que tem que zerar
	la	$s6,bymon	#$s6 tem o inicio do bymon
	add	$s7,$s7,$s6	#$s7 tem o endereço do final do bymon
	loopzerarmon:
		beq	$s7,$s6,endzerarmon	#se for o fim do que tem que zerar
		sb	$zero,($s6)	#zera o bit
		addi	$s6,$s6,1	#anda com o registrador $s6
		j	loopzerarmon	
	endzerarmon:
		sw	$zero,nummon
		jr	$ra		
