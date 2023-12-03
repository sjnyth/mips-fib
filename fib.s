.data
    input: .asciiz "Please enter an integer that is greater or equal to 25: "
    output: .asciiz "\nYou typed this number "
    error_message: .asciiz "Number is less than 25! Please enter again\n"
    add_space: .asciiz "  "

.text
main:
    # prompt user to enter an integer
    li $v0, 4   # syscall code for printing string
    la $a0, input  # loads address and puts the interger value in register $a0
    syscall  

    # read integer input 
    li $v0, 5  # system call code for reading integer
    syscall

    # Check if the input is greater than or equal to 25
    move $t0, $v0 # store user input in $t0
    bgt $t0, 24, exit # branch if greater than or equal to 25
    li $v0, 4 
    la $a0, error_message
    syscall
    j main # jump back to main if input is less than 25

exit:
    # Call the fib function with user input as argument
    move $a0, $v0
    jal fib

fib:
    # Fibonacci sequence calculation
    li $t0, 0
    li $t1, 1
    li $t2, 1
    move $t3, $a0
    sub $t4, $t3, 2
    li $v0, 1   # system call code for printing integer

    li $t5, 0
    beq $t3, 0, done    # if n is 0, jump to done
    bne $t3, 1, else    # if n is 1, jump to else

else:
    # Print the first two Fibonacci numbers (0 and 1)
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
    # Fibonacci sequence calculation loop   
    beq $t5, $t4, done  # if counter equals n-2, jump to done
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
    # Exit the program
    li $v0, 10
    syscall