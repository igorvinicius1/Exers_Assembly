.data
    
    frase: .asciiz "Enter the number and wait for the result... "
    frasee: .asciiz "Enter the number and wait for the result... Invalid number.
"
    
.text
    .globl    main
main:
 
    li $v0, 5
    syscall
    
    move $t0, $v0
 
    bgt $t0, $zero, imprimeMaior
    beq $t0, $zero, Nada
        
 
    imprimeMaior:
 
        li $v0, 4
        la $a0, frase
        syscall
        add $s0, $t0, $t0
        li $v0, 1
        move $a0, $s0
        syscall
        li $v0, 10
        syscall
        
    
    Nada:
        li $v0, 4
        la $a0, frasee
        syscall
        li $v0, 10
        syscall


















