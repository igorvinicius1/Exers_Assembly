.data
	vetorInteiros: 
		.align 2
		.space 60 # 15*4 espaços, pois 4 é o tamanho do bit inteiro
	vetorOrdenado:
		.align 2
		.space 60
	enter: .asciiz "\n"
	
	voltou: .asciiz "voltou\n"
	
	entrou: .asciiz "entrou\n"
.text

.globl main
main:

	li $t0, 0 #contador leitura
	li $t1, 60
	
	li $t2, -4 # int i 'forUm'

while:
	beq $t0, $t1 forUm
	jal lerInteiro
	move $t2, $v0
	sw $t2, vetorInteiros($t0) #guarda valor lido na posicao que o contador leitura se encontra
	addi $t0, $t0, 4 #incrementa contador
	j while 
	
	
lerInteiro:
	li $v0, 5
	syscall
	jr $ra
	
forUm:
    
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

	imprime:
		beq $t0, $t1, fimImprime
		lw $t2, vetorInteiros($t0) #carrega valor da posicao $t0 para $t2
		move $a0, $t2
		jal imprimeInteiro
		addi $t0, $t0, 4 #incrementa contador
		beq $t0, $t1, fimImprime
		la $a0, enter
		jal imprimeString
		j imprime
	fimImprime:
		li $v0, 10
		syscall

imprimeInteiro:
	li $v0, 1
	syscall
	jr $ra
imprimeString:
	li $v0, 4
	syscall
	jr $ra
