
.data
arg1_addr: .word 0
arg2_addr: .word 0
num_args: .word 0
invalid_arg_msg: .asciiz "Invalid Arguments\n"
args_err_msg: .asciiz "Program requires exactly two arguments\n"
invalid_hand_msg: .asciiz "Loot Hand Invalid\n"
newline: .asciiz "\n"
zero: .asciiz "Zero\n"
nan: .asciiz "NaN\n"
inf_pos: .asciiz "+Inf\n"
inf_neg: .asciiz "-Inf\n"
mantissa: .asciiz ""

.text
.globl hw_main
hw_main:
    sw $a0, num_args
    sw $a1, arg1_addr
    addi $t0, $a1, 2
    sw $t0, arg2_addr
    j start_coding_here

start_coding_here:
li $t2, 2
bne $a0, $t2, error
li $t1, 1
move $s4, $a1  # $s4 has the address of first argument since I am changing the value of $a1 in the later part of program
move $s3, $t0  # $s3 has the address of second argument 
move $k1, $s3
li $t4, 0
li $t5, 32
again:
lbu $s0, 0($a1)
beq $s0, $0, done
move $s2, $s0
addi $t1, $t1,1 
addi $a1, $a1,1
j again

done:
bne $t1,$t2, error2
caseD:
li $t1, 1

addi $t3, $0, 68
bne $s2, $t3,caseL
again2:
lbu $s0, 0($t0)
beq $s0, $0, done2
addi $t2, $s0, -48
bne $t2, $0, checkForone
cont:
addi $t4, $t4,1 
addi $t0, $t0, 1
j again2
checkForone:
bne $t2, $t1, error2
j cont
done2:
bgt $t4, $t5, error2
blt $t4, $t1 , error2
move $a0, $t4

another_step:
addi $a3, $0, 1
sub $t1, $a0, $a3
addi $a0, $0, 0
addi $t6, $0, 0
whileanother:
slt $s2, $t1, $0  
bne $s2, $0, done1 
lb $t2, 0($s3)   
addi $t3, $t2, -48

slt $s7, $a0,$t4
beq $s7, $0, whileanother
if :

sllv $t5, $t3,$t1  
add $t6, $t6, $t5
addi $a0 , $a0, 1
addi $t1, $t1, -1
addi $s3, $s3, 1
j whileanother

done1:
li $v0, 1
move $a0, $t6
syscall         
j terminate

caseL:
addi $t3, $0, 76
bne $s2, $t3, caseO

li $s1, 0  # length counter for P     SO FOR THE EXAMPLE GIVEN IN THE HW IT IS 2
li $t8, 0 # length counter for M      SO FOR THE EXAMPLE GIVEN IN THE HW IT IS 4 
li $s3, 80  # checking for M
li $s4, 77  # checking for P
li $s5, 49  # checking for greater than or equal to 1
li $s6, 52 # checking for less than or equal to 4
li $s7, 51 # checking for number greater than or equal to 3
li $t6, 56  # checking for number less than or equal to 8 
li $t7, 6, #checking the length

loopForLootGame:
lb $t1, 0($k1)
lb $t2, 1($k1) 
beq $t1, $0, exitFromLoot
bne $t1, $s3, checkForM
bge $t2, $s5, checkForLowerBound
j error3
checkForLowerBound:
ble $t2, $s6, continuewithloop

j error3
continuewithloop:
addi $k1, $k1, 2
addi $s1, $s1, 1
j loopForLootGame
checkForM:
bne $t1, $s4, error3
bge $t2, $s7, checkForUpperBound
j error3
checkForUpperBound:
ble $t2, $t6, continuewithMloop
j error3
continuewithMloop:
addi $k1, $k1, 2
addi $t8, $t8 , 1
j loopForLootGame

exitFromLoot:
li $k1, 32
sll $t8, $t8, 3
add $t8, $t8, $s1
bgt $t8, $k1, subtract64
continuewithlootgame:
move $a0, $t8
li $v0, 1
syscall 
j terminate
subtract64:
addi $t8, $t8, -64
j continuewithlootgame

caseO:
checkString:
move $s4, $k1   # Storing the address of 2nd argument in s4  , so now the 2nd argument is in s0
move $t4, $s4
move $k0, $s4

li $t5, 10
li $t6, 1
li $t8, 0
li $t9, 48
li $a2, 58
li $s5, 65
li $s6, 71
li $s7, 2
li $a3, 72
li $t3, 97
li $v0, 103

li $k1, 70
beq $s2, $k1, skipCheckingX

move $k1, $s4


for:

lbu $t7 , 0($k1)  
beq $t8, $s7, again3
addi $t7 , $t7, -48
bne $t7, $0, checkForX
cont2:
addi $k1, $k1,1
addi $t8, $t8,1 
j for
checkForX:
bne $t7 , $a3, error2
j cont2


skipCheckingX:
lbu $t1, 0($s4)
beq $t1, $0, done3
j continuewitherrorchecking

again3:
lbu $t1, 2($s4)
beq $t1, $0, done3
continuewitherrorchecking:
blt $t1, $t9,error2 
blt $t1, $a2, donee1
blt $t1, $s5, error2
blt $t1, $s6, donee1
blt $t1, $t3, error2
blt $t1, $v0, donee1
bge $t1, $v0, error2

donee1:

addi $t2, $t2, 1
addi $s4, $s4, 1
beq $s2, $k1, skipCheckingX
j again3


done3:

bgt $t2, $t5 , error2
blt $t2, $t6 , error2  

li $a1, 0  # final register for string
li $v1, 0
li $a2, 0

LengthOfSecondArgument:
lbu $v0, 2($k0)
beq $v0, $0, tellTheLength
addi $a2, $a2, 1
addi $k0, $k0, 1
j LengthOfSecondArgument
tellTheLength:
beq $s2, $k1, add2
j contFinally
add2:
li $t9, 8
addi $a2, $a2, 2
bne $a2, $t9, error2
contFinally:

beq $s2, $k1, conversion_finalforPart4
j conversion_final
conversion_finalforPart4:
lbu $a0, 0($t4)
beq $a0, $0, exit_final
j continuewithconversionPart4
conversion_final:
lbu $a0, 2($t4) 
beq $a0, $0, exit_final
continuewithconversionPart4:
li $t0, 97
bge $a0, $t0, sube 

case0:
li $t0, 48
bne $a0, $t0,case1
addi $a1,$a1, 0
addi $v1, $v1,1
beq $a2, $v1, Case0cont
contwith0:
sll $a1, $a1, 4
Case0cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case1:
li $t0, 49
bne $a0, $t0, case2
addi $a1, $a1,1
addi $v1, $v1,1
beq $a2, $v1, Case1cont
sll $a1, $a1, 4
Case1cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case2:
li $t0, 50
bne $a0, $t0, case3
addi $a1, $a1,2
addi $v1, $v1,1
beq $a2, $v1, Case2cont
sll $a1, $a1, 4
Case2cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case3:
li $t0, 51
bne $a0, $t0, case4
addi $a1, $a1,3
addi $v1, $v1,1
beq $a2, $v1, Case3cont
sll $a1, $a1, 4
Case3cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case4:
li $t0, 52
bne $a0, $t0, case5
addi $a1, $a1,4
addi $v1, $v1,1
beq $a2, $v1, Case4cont
sll $a1, $a1, 4
Case4cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case5:
li $t0, 53
bne $a0, $t0, case6
addi $a1, $a1,5
addi $v1, $v1,1
beq $a2, $v1, Case5cont
sll $a1, $a1, 4
Case5cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case6:
li $t0, 54
bne $a0, $t0, case7
addi $a1, $a1,6
addi $v1, $v1,1
beq $a2, $v1, Case6cont
sll $a1, $a1, 4
Case6cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case7:
li $t0, 55
bne $a0, $t0, case8
addi $a1, $a1,7
addi $v1, $v1,1
beq $a2, $v1, Case7cont
sll $a1, $a1, 4
Case7cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case8:
li $t0, 56
bne $a0, $t0, case9
addi $a1, $a1,8
addi $v1, $v1,1
beq $a2, $v1, Case8cont
sll $a1, $a1, 4
Case8cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
case9:
li $t0, 57
bne $a0, $t0, caseA
addi $a1, $a1,9
addi $v1, $v1,1
beq $a2, $v1, Case9cont
sll $a1, $a1, 4
Case9cont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
caseA:
li $t0, 65
bne $a0, $t0, caseB
addi $a1, $a1,10
addi $v1, $v1,1
beq $a2, $v1, CaseAcont
sll $a1, $a1, 4
CaseAcont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
caseB:
li $t0, 66
bne $a0, $t0, caseC
addi $a1, $a1,11
addi $v1, $v1,1
beq $a2, $v1, CaseBcont
sll $a1, $a1, 4
CaseBcont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
caseC:
li $t0, 67
bne $a0, $t0, caseG
addi $a1, $a1,12
addi $v1, $v1,1
beq $a2, $v1, CaseCcont
sll $a1, $a1, 4
CaseCcont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
caseG:       # GIVEN NAME caseG because caseD already used 
li $t0, 68
bne $a0, $t0, caseJ
addi $a1, $a1,13
addi $v1, $v1,1
beq $a2, $v1, CaseGcont
sll $a1, $a1, 4
CaseGcont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
caseJ:         # Given name caseJ instead of caseE since it is already in use
li $t0, 69
bne $a0, $t0, caseI
addi $a1, $a1,14
addi $v1, $v1,1
beq $a2, $v1, CaseJcont
sll $a1, $a1, 4
CaseJcont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final
caseI:                    # Given name caseI instead of caseF since it is already in use
li $t0, 70
bne $a0, $t0, exitSoDone
addi $a1, $a1,15
addi $v1, $v1,1
beq $a2, $v1, CaseIcont
sll $a1, $a1, 4
CaseIcont:
addi $t4, $t4, 1
beq $s2, $k1, conversion_finalforPart4
j conversion_final

sube :
addi $a0, $a0, -32
j case0
exit_final:
addi $t3, $0, 79
bne $s2, $t3, caseS
srl $v1, $a1, 26
move $a0, $v1
li $v0, 1
syscall
j terminate
caseS:
addi $t3, $0, 83
bne $s2, $t3, caseT
sll $v1, $a1, 6
srl $v1, $v1, 27
move $a0, $v1
li $v0, 1
syscall
j terminate
caseT:
addi $t3, $0, 84
bne $s2, $t3, caseE
sll $v1, $a1, 11
srl $v1, $v1, 27
move $a0, $v1
li $v0, 1
syscall
j terminate
caseE:
addi $t3, $0, 69
bne $s2, $t3, caseH
sll $v1, $a1, 16
srl $v1, $v1, 27
move $a0, $v1
li $v0, 1
syscall
j terminate
caseH:
addi $t3, $0, 72
bne $s2, $t3, caseU
sll $v1, $a1, 21
sra $v1, $v1, 27
move $a0, $v1
li $v0, 1
syscall
j terminate
caseU:
addi $t3, $0, 85
bne $s2, $t3, caseF
sll $v1, $a1, 26
srl $v1, $v1, 26
move $a0, $v1
li $v0, 1
syscall
j terminate
caseF:
addi $t3, $0, 70
bne $s2, $t3, caseL

li $s3, 4286578688
li $s4, 2139095040
li $s5, 2139095041
li $s6, 2147483647
li $s7, -8388607
li $t1,4294967295
li $t2, 2147483648
beq $a1, $0, printZero
beq $a1, $t2, printZero
beq $a1, $s3, printInfNeg
beq $a1, $s4, printInfPos
bge $a1, $s5, checkForUpperBoundPart4

continueCheckingPart4:
bge $a1, $s7, checkForUpperBoundPart4_2

continueCheckingPart4_2:
move $a2, $a1        # Moving the contents of binary string to a2
sll $t0, $a1, 1
srl $t0, $t0, 24   # $t0 has the biased exponent part
addi $a0, $t0, -127  #  Now $a0 has the exponent part
sll $t1, $a1, 9
srl $t1, $t1, 9      # t1 has the mantissa part without 1 prepended
j continueWithProcessPart4
checkForUpperBoundPart4:
ble $a1, $s6, printNan
j continueCheckingPart4

checkForUpperBoundPart4_2:
ble $a1, $t1, printNan
j continueCheckingPart4_2

continueWithProcessPart4:


la $a1, mantissa
li $t3, 49
li $k0, 1
srl $k1, $a2, 31

beq $k1, $k0 , NeedNegativeSign

sb $t3, 0($a1)
li $t3, 46
sb $t3, 1($a1)

li $t4, 9
li $t5, 31
li $t7, 32

forLoopForPart4:
sllv $t6, $t1, $t4
srlv $t6, $t6, $t5
addi $t6, $t6, 48
sb $t6, 2($a1)     
addi $a1, $a1, 1
addi $t4, $t4, 1
beq $t4, $t7, exitFromPart4
j forLoopForPart4
#  THIS PART WORKS AND STORES THE BINARY STRING CORRECTLY 

exitFromPart4:
la $a1, mantissa

j terminate

NeedNegativeSign:
li $k1, 45
sb $k1, 0($a1)
sb $t3, 1($a1)
li $t3, 46
sb $t3, 2($a1)

li $t4, 9
li $t5, 31
li $t7, 32

forLoopForPart4Neg:
sllv $t6, $t1, $t4
srlv $t6, $t6, $t5
addi $t6, $t6, 48
sb $t6, 3($a1)
addi $a1, $a1, 1
addi $t4, $t4, 1
beq $t4, $t7, exitFromPart4Neg
j forLoopForPart4Neg
#  THIS PART WORKS AND STORES THE BINARY STRING CORRECTLY 

exitFromPart4Neg:
la $a1, mantissa

j terminate



exitSoDone:

error2:
li $v0,4
la $a0, invalid_arg_msg
syscall
j terminate
error3:
li $v0, 4
la $a0, invalid_hand_msg
syscall
j terminate
error:
li $v0, 4
la $a0, args_err_msg
syscall
j terminate
printZero:
li $v0, 4
la $a0, zero
syscall
j terminate
printInfPos:
li $v0, 4
la $a0, inf_pos
syscall
j terminate
printInfNeg:
li $v0, 4
la $a0, inf_neg
syscall
j terminate
printNan:
li $v0, 4
la $a0, nan
syscall
j terminate
terminate:
li $v0, 10
syscall
