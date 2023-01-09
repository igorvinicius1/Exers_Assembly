.data
	vetorInteiros: 
		.align 2
		.space 60 # 15*4 espaços, pois 4 é o tamanho do bit inteiro
	enter: .asciiz "\n"
	numPessoas: .asciiz "Quantas pessoas usarão o elevador: "
	alerta: .asciiz "O programa só aceita valores entre 1 e 15, tente novamente"
	limitePessoas: .asciiz "Limite de pessoas que o elevador suporta: "
    	alertaLimite: .asciiz "O programa só aceita valores entre 2 - 10"
    	floor: .asciiz "Quantos andares o prédio possuí: "
    	instrucao: .asciiz "Agora insira o andar que cada pessoa deseja alcançar respectivamente: "
    	andarErrado: .asciiz "O andar inserido não existe, insira novamente"
    	
    	sequenciaEficiente: .asciiz "A ROTA MAIS EFICIENTE SERÁ: "
    	
    	sequenciaIneficiente: .asciiz "\nA ROTA MENOS EFICIENTE SERÁ: \n" # Esse é o caso do elevaador ignorante, que deixa uma pessoa por 
    								      # andar da forma mais ruim possível
    	terreo: .asciiz "0" 
    	
    	teste: .asciiz "t0 --> "
    	elevStart: .asciiz "[" 
    	elevEnd: .asciiz "]" 
    	space: .asciiz " -> "
.text

.globl main
main:

	la $a0, numPessoas
    	jal imprimeString
    	
    	jal lerInteiro
    	move $t1, $v0 # quantidade de pessoas que vão usar o elevador
    	
    	la $a0, enter # pula uma linha
    	jal imprimeString
    	
    	bgt $t1, 15, limite # condição do número máximo de inputs
    	blt $t1, 1, limite
	
	li $t0, 0 # contador leitura
	mul $t1, $t1, 4 # novo limite do vetor de inteiros
	move $t7, $t1 # usando o t7 no printBadSort
	
	li $t2, -4 # int i 'forUm'
	
	la $a0, limitePessoas
	jal imprimeString
	
	jal lerInteiro 
	move $v1, $v0 # armazena o peso em pessoas suportada pelo elevador
	
	la $a0, enter # pula uma linha
    	jal imprimeString
    	
    	bgt $v1, 10, limitePeso # condição 2-10 
    	blt $v1, 2, limitePeso
    	
    	la $a0, floor
    	jal imprimeString
    	
    	jal lerInteiro
    	move $t8, $v0 # armazena a quantidade de andares
    	
    	la $a0, enter # pula uma linha
    	jal imprimeString
    	
    	la $a0, instrucao
    	jal imprimeString
    	
    	la $a0, enter # pula uma linha
    	jal imprimeString

while: #abastece o vetor

	beq $t0, $t1 forUm
	jal lerInteiro
	move $t2, $v0
	bgt $t2, $t8, wrongFloor # caso o andar inserido seja maior q o limite, o programa pede para corrigir
    	ble $t2, $zero, wrongFloor
	sw $t2, vetorInteiros($t0) #guarda valor lido na posicao que o contador leitura se encontra
	addi $t0, $t0, 4 #incrementa contador
	j while 
		
	
forUm: #ordena o vetor
    
        addi $t9, $t9, 4 # i++	
        	
        li $t2, -4 # int j
        lw $t3, vetorInteiros($t9) # v[i]
        move $t5, $t3 # t5 = aux
        
        blt $t9, $t1, forDois
        j fim
        
            forDois:
            
                addi $t2, $t2, 4 # j++
                beq $t2, $t1, forUm
                
                lw $t4, vetorInteiros($t2) # v[j]
                blt $t3, $t4, Sort
                j forDois
                
                    Sort:
                    
                        sw $t3, vetorInteiros($t2)
                        sw $t4, vetorInteiros($t9)
                        lw $t3, vetorInteiros($t9) # v[i], atualiza com a nova posição alterada
                        j forDois
                    	
fim:
	li $t0, 0 # i = 0
	li $t3, 0
	
	la $a0, enter # pula linha
    	jal imprimeString
    
   	la $a0, sequenciaEficiente # rota eficiente...
   	jal imprimeString
   	
	la $a0, enter # pula linha
    	jal imprimeString
	
	imprime1:
		la $a0, elevStart # colchetes para iniciar acontecimentos de uma op do elevador
		jal imprimeString
	
	imprime:
		beq $t3, $v1, voltaTerreo2
		beq $t0, $t1, fimImprime
		lw $t2, vetorInteiros($t0) #carrega valor da posicao $t0 para $t2
		move $a0, $t2
		jal imprimeInteiro
		addi $t0, $t0, 4 #incrementa contador
		beq $t0, $t1, fimImprime
		la $a0, space # espaçador de paradas de um elevador
		jal imprimeString
		addi $t3, $t3, 1
		j imprime
		
	voltaTerreo2:
    	
    		la $a0, terreo # imprime 0
        	jal imprimeString
        	la $a0, elevEnd # colchetes para finalizar acontecimentos de uma op do elevador
		jal imprimeString
        	la $a0, enter # pula uma linha
        	jal imprimeString
        	move $t3, $zero
        	j imprime1
		
	fimImprime:
		la $a0, elevEnd # colchetes para finalizar acontecimentos de uma op do elevador
		jal imprimeString
		j printBadSort
		
printBadSort:

	li $t0, 0 # i = 0
    	li $t2, 0 # contador do limite de pessoas no elevador, determina o momento de voltar ao térreo
    	li $t5, 0
    
    	la $a0, enter # pula linha
    	jal imprimeString
    
   	la $a0, sequenciaIneficiente # rota ineficiente...
   	jal imprimeString
    
   	subi $t7, $t7, 4 # posicionado $t7 na ultima posição do vetor, é necessário subtrair 4, pois a posição inicial está em '0'
    
    	imprime1_2:
		la $a0, elevStart # colchetes para iniciar acontecimentos de uma op do elevador
		jal imprimeString
    
	imprime2:
		
		beq $t2, $v1, voltaTerreo
		beq $t0, $t1, fimImprime2 # condição que encerra a label
		
		
		lw $t3, vetorInteiros($t7)
		addi $t2, $t2, 1
		move $a0, $t3
        	jal imprimeInteiro
        	addi $t0, $t0, 4 # incrementa contador
       		subi $t7, $t7, 4
       		
       		la $a0, space # pula linha
    		jal imprimeString
       		
       		beq $t2, $v1, voltaTerreo
       		beq $t0, $t1, fimImprime2 # condição que encerra a label
       		
       		lw $t3, vetorInteiros($t5)
       		#beq $t4, $zero, imprime2
       		move $a0, $t3
       		jal imprimeInteiro
       		addi $t5, $t5, 4
       		
       		addi $t0, $t0, 4
       		beq $t0, $t1, fimImprime2
       		la $a0, space # espaçador de paradas de um elevador
       		jal imprimeString
       		addi $t2, $t2, 1
       		j imprime2
		
	voltaTerreo:
    		beq $t0, $t1, fimImprime2 # condição que encerra a label
    		la $a0, terreo # imprime 0
        	jal imprimeString
        	la $a0, elevEnd # colchetes para finalizar acontecimentos de uma op do elevador
		jal imprimeString
        	la $a0, enter # pula uma linha
        	jal imprimeString
        	move $t2, $zero
        	j imprime1_2
        	
        fimImprime2:
        	la $a0, elevEnd # colchetes para finalizar acontecimentos de uma op do elevador
		jal imprimeString
        	li $v0, 10
 		syscall
		
wrongFloor:
    	la $a0, andarErrado
    	jal imprimeString
    	la $a0, enter
    	jal imprimeString
    	j while

limite: # limite de 15 pessoas
	la $a0, enter
	jal imprimeString
	la $a0, alerta
	jal imprimeString
	li $v0, 10
 	syscall
 	
limitePeso: # máx q o elevador suporta 
	la $a0, enter
	jal imprimeString
	la $a0, alertaLimite
	jal imprimeString
	li $v0, 10
 	syscall

lerInteiro:
	li $v0, 5
	syscall
	jr $ra

imprimeInteiro:
	li $v0, 1
	syscall
	jr $ra
	
imprimeString:
	li $v0, 4
	syscall
	jr $ra
