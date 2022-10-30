.data
    frase: .asciiz " valores positivos "
 
.text
    .globl main
    
main:
    
    li $t0, 1
    li $t2, 0
    
    while:
    
        bgt $t0, 6, fim
        
        addi $t0, $t0, 1
        
        li $v0, 5
        syscall
        move $t1, $v0
        
        blt $t1, $zero, while
        
        addi $t2, $t2, 1
        
        j while
        
    fim:
        
        li $v0, 1
        move $a0, $t2
        syscall
        li $v0, 4
        la $a0, frase
        syscall