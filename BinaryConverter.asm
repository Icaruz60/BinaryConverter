#declare values
li $s1, 31  #maximum bit position for a 32-bit number
li $t2, 0   #flag to start printing once a 1 is encountered

#seed data
.data
WelcomeTxt: .asciiz "input integer to convert to binary: "
OutPutTxt1: .asciiz "\nthe binary representation of "
OutPutTxt2: .asciiz " is "

.text

#print the welcome message 
la $a0, WelcomeTxt
li $v0, 4
syscall

#get input of the integer
li $v0, 5
syscall
move $t0, $v0

#print the first output message 
la $a0, OutPutTxt1
li $v0, 4
syscall

#print the input value
li $v0, 1
move $a0, $t0
syscall

#print the second output message 
la $a0, OutPutTxt2
li $v0, 4
syscall

#print the binary representation of the value
CONVERT:
    	bltz $s1, ENDCONVERT #exit loop when all bits are processed

    	#shift $t0 left by $s1 bits and extract the msb
    	srlv $t1, $t0, $s1 
    	andi $t1, $t1, 1

    	#skip all unnecessary zeros and start printing at the first 1 
   	beq $t2, 1, PRINTBIT
    	beq $t1, 0, SKIPBIT
    	li $t2, 1
    
PRINTBIT:
    	#convert the bit to ascii ('0' or '1') for printing
    	li $a0, 48
    	add $a0, $a0, $t1         

    	#print the character
    	li $v0, 11
    	syscall

SKIPBIT:
	#move to the next bit position (decrement $s1)
	sub $s1, $s1, 1
	j CONVERT

ENDCONVERT:
	#if no '1' was found, the input must be 0, so print a single '0'
	beq $t2, 1, EXIT
	li $a0, 48         
	li $v0, 11
	syscall

EXIT:
li $v0, 10
syscall  

