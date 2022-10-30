.data
    frase1: .asciiz "Maior nivel: velocidade "
    frase2: .asciiz ": velocidade invalida\n"
    frase3: .asciiz ": valor invalido.\n"
    frase4: .asciiz "Maior nivel: velocidade 1\n"
    frase5: .asciiz "Maior nivel: velocidade 2\n"
    frase6: .asciiz "Maior nivel: velocidade 3\n"
    pula: .asciiz "\n"
 
.text
    .globl main
    
main:
    
    li $t0, 0 //limite do laço while
    li $t1, 1 //contador do laço while
    li $t2, 0 //contador da velocidade
    
    li $v0, 5 //leitura do limite do laço
    syscall
    move $t0, $v0
    
    while:
    
        bgt $t1, $t0, fim
        
        li $v0, 5 //leitura da velo
        syscall
        move $t9, $v0
        
        addi $t1, $t1, 1 //inclementa cont do laço
        
        bgt $t9, $t2, nova_velocidade
        
        j while
        
    nova_velocidade:
    
        move $t2, $t9
        
        j while
        
    fim:
    
        bgt $t0, 30, lesmas_invalida
        
        //li $v0, 1
        //move $a0, $t2
        //syscall
        
        bgt $t2, 50, vel_invalida 
        
        blt $t2, 10, nivel_um
        blt $t2, 20, nivel_dois
        blt $t2, 51, nivel_tres
        
        //li $v0, 10
        //syscall
    
    nivel_um:
        
        li $v0, 4
        la $a0, frase4
        syscall
        li $v0, 10
        syscall
        
    nivel_dois:
        
        li $v0, 4
        la $a0, frase5
        syscall
        li $v0, 10
        syscall
        
    nivel_tres:
        
        li $v0, 4
        la $a0, frase6
        syscall
        li $v0, 10
        syscall
        
    vel_invalida:
        
        li $v0, 1
        move $a0, $t2
        syscall
        
        li $v0, 4
        la $a0, frase2
        syscall
        
        li $v0, 4
        la $a0, frase6
        syscall
        li $v0, 10
        syscall
        
        
    lesmas_invalida:
    
        li $v0, 1
        move $a0, $t0
        syscall
        li $v0, 4
        la $a0, frase3
        syscall
        li $v0, 10
        syscall