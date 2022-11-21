.data
 
    erro: .asciiz "Valor invalido."
    dois: .asciiz "2"
    pot: .asciiz "^"
    igual: .asciiz " = "
    pula: .asciiz "\n"
 
.text
 
    .globl main
 
main:
 
    li $t0, 0 // contador while "N"
    li $t1, 2 // 2 em 2
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    blt $t0, 5, invalido
    bgt $t0, 100, invalido
    
    while:
    
        bgt $t1, $t0, fim
        
        mul $s2, $t1, $t1
        
        li $v0, 1
        move $a0, $t1
        syscall
        
        li $v0, 4
        la $a0, pot
        syscall
        
        li $v0, 4
        la $a0, dois
        syscall
        
        li $v0, 4
        la $a0, igual
        syscall
        
        move $t5, $s2
        li $v0, 1
        move $a0, $t5
        syscall
        
        li $v0, 4
        la $a0, pula
        syscall
        
        addi $t1, $t1, 2
        
        j while
    
    
    invalido:
    
        li $v0, 4
        la $a0, erro
        syscall
        li $v0, 10
        syscall
        
    fim:
    
        li $v0, 10
        syscall
        


