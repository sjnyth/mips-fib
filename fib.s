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