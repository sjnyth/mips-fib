.data
    input: .asciiz "Please enter an integer that is greater or equal to 25: "
    output: .asciiz "\nYou typed this number "
    error_message: .asciiz "Number is less than 25! Please enter again\n"
    add_space: .asciiz "  "

.text
main:
    li $v0, 4   # calls prompt to take an input integer
    la $a0, input  # loads address and puts the interger value in register $a0
    syscall  

    li $v0, 5  
    syscall
    move $t0, $v0
    bgt $t0, 24, exit
    li $v0, 4
    la $a0, error_message
    syscall
    j main

exit:
    move $a0, $v0
    jal fib

fib:
    li $t0, 0
    li $t1, 1
    li $t2, 1
    move $t3, $a0
    sub $t4, $t3, 2
    li $v0, 1

    li $t5, 0
    beq $t3, 0, done
    bne $t3, 1, else

else:
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, add_space
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, add_space
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, add_space
    syscall

loop:
    beq $t5, $t4, done
    add $t0, $t1, $t2
    add $t1, $zero, $t2
    add $t2, $zero, $t0
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, add_space
    syscall
    addi $t5, $t5, 1
    j loop

done:
    li $v0, 10
    syscall