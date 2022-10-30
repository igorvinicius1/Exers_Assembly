.data
    
    frase: .asciiz "Maior: "
    frase2: .asciiz "Maior: "
    frase3: .asciiz "Maior: "
 
.text
 
    .globl    main
main:
 
    li $v0, 5
    syscall
    move $t0, $v0
    
    li $v0, 5
    syscall
    move $t1, $v0
    
    li $v0, 5
    syscall
    move $t2, $v0
 
    bgt $t0, $t1, Alfa
    bgt $t1, $t0, Bravo
    bgt $t2, $t0, Charlie
    
    
    Alfa:
        bgt $t0, $t2, Alfa2
        blt $t0, $t2, Charlie2
        
    Alfa2:
        li $v0, 4
        la $a0, frase
        syscall
        move $s0, $t0
        li $v0, 1
        move $a0, $s0
        syscall
        li $v0, 10
        syscall
    
    Bravo:
        bgt $t1, $t2, Bravo2
        blt $t1, $t2, Charlie
        
    Bravo2:
        li $v0, 4
        la $a0, frase2
        syscall
        move $s0, $t1
        li $v0, 1
        move $a0, $s0
        syscall
        li $v0, 10
        syscall
        
    Charlie:
        bgt $t2, $t1, Charlie2
        
    Charlie2:
        li $v0, 4
        la $a0, frase3
        syscall
        move $s0, $t2
        li $v0, 1
        move $a0, $s0
        syscall
        li $v0, 10
        syscall