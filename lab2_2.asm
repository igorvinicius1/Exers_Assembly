.data
    frase: .asciiz " valor(es) par(es)\n"
    frase2: .asciiz " valor(es) impar(es)\n"
    frase3: .asciiz " valor(es) positivo(s)\n"
    frase4: .asciiz " valor(es) negativo(s)\n"
 
.text
    .globl main
    
main:
    
    li $t0, 1 //contador do la‡o while
    li $t2, 0 //contador positivo
    li $t3, 0 //contador negativo
    li $t4, 0 //contador impar
    li $t5, 0 //contador par
    li $t6, -1
    
    while:
    
        bgt $t0, 5, fim
        
        addi $t0, $t0, 1
        
        li $v0, 5
        syscall
        move $t1, $v0
        
        //addi $t3, $t3, 1 //negativo
        
        blt $t1, $zero, converte //negativo para positivo
        
        bgt $t1, $zero, decide
        
        blt $t1, $zero, while
        
        //addi $t2, $t2, 1 //positivo
        
        j while
        
    
    converte:
    
        mul $t1, $t1, -1
        addi $t3, $t3, 1 //negativo
        
        //li $v0, 1
        //move $a0, $t9
        //syscall
        
    decide:
    
        div $t9, $t1, 2
        mul $t8, $t9, 2
        sub $t9, $t1, $t8
        
        beq $t9, $zero, ehpar
        bgt $t9, $zero, ehimpar
        
    ehpar:
    
        addi $t5, $t5, 1
        
        j while
        
    ehimpar:
        
        addi $t4, $t4, 1
        
        j while
        
        
    fim:
        
        sub $t2, $t0, $t3
        sub $t2, $t2, 1
        
        li $v0, 1
        move $a0, $t5
        syscall
        li $v0, 4
        la $a0, frase
        syscall
        
        li $v0, 1
        move $a0, $t4
        syscall
        li $v0, 4
        la $a0, frase2
        syscall
        
        li $v0, 1
        move $a0, $t2
        syscall
        li $v0, 4
        la $a0, frase3
        syscall
        
        //sub $t3, $t3, $t2 //negativo menos positivo (ou contador do while menos negativos)
        
        li $v0, 1
        move $a0, $t3
        syscall
        li $v0, 4
        la $a0, frase4
        syscall
        

