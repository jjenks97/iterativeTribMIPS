.data
	trib0Text: .asciiz "Enter tribonacci(0): "
	trib1Text: .asciiz "Enter tribonacci(1): "
	trib2Text: .asciiz "Enter tribonacci(2): "
	nTermText: .asciiz "Enter n: "
	tribNTextStart: .asciiz "tribonacci("
	tribNTextEnd: .asciiz "): "

.text
#prompts user for tribonacci(0)
trib0:
li $v0, 4
la $a0, trib0Text
syscall

#takes and stores the user's input, the branch makes sure trib0 >= 0
li $v0, 5
syscall

move $s0, $v0

blt $s0, $zero, trib0

#prompts user for tribonacci(1)
trib1:
li $v0, 4
la $a0, trib1Text
syscall

#takes and stores the user's input, the branch makes sure trib1 >= 0
li $v0, 5
syscall

move $s1, $v0

blt $s1, $zero, trib1


#prompts user for tribonacci(2)
trib2:
li $v0, 4
la $a0, trib2Text
syscall

#takes and stores the user's input, the branch makes sure trib2 >= 0
li $v0, 5
syscall

move $s2, $v0

blt $s2, $zero, trib2


#prompts user for n
nTerm:
li $v0, 4
la $a0, nTermText
syscall

#takes and stores the user's input, the branch makes sure n >= 0
li $v0, 5
syscall

move $s3, $v0

blt $s3, $zero, nTerm

#in case the user sets n as 0, 1, or 2
ble $s3, 2, nLessThan3


#$s7 = 0
#subtracts 2 from n to account for the first 3 terms
move $s7, $zero
addi $s5, $s3, -2 
tribAdd:
bge $s7, $s5, end
#only executes while $s7 < n

#adds trib 1, 2, and 3 and stores in $s4
add $s4, $s0, $s1
add $s4, $s4, $s2

#sets trib0 = trib1, trib1 = trib2, and trib3 = $t4
add $s0, $s1, $zero
add $s1, $s2, $zero
add $s2, $s4, $zero

#i++
addi $s7, $s7, 1

#loops back to beginning
b tribAdd








#in case user enters a value for n that is less than 3

nLessThan3:
beq $s3, 2, nEquals2
beq $s3, 1, nEquals1
beq $s3, 0, nEquals0

nEquals2:
move $s4, $s2
b end

nEquals1:
move $s4, $s1
b end

nEquals0:
move $s4, $s0
b end


#prints the results
end:

li $v0, 4
la $a0, tribNTextStart
syscall

li $v0, 1
move $a0, $s3
syscall

li $v0, 4
la $a0, tribNTextEnd
syscall

li $v0, 1
move $a0, $s4
syscall

li $v0, 10
syscall
