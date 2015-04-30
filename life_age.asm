.data

.globl main

.align 0
BANNER:
	.ascii "*************************************\n"
	.ascii "****    Game of Life with Age    ****\n"
	.asciiz "*************************************\n"
BORDER_CORNER:
	.asciiz "+"
BORDER_TOP:
	.asciiz "-"
BORDER_SIDE:
	.asciiz "|"

GEN_BANNER_START:
	.asciiz "\n====    GENERATION "
GEN_BANNER_END:
	.asciiz "    ====\n"
	 
.align 2
BOARD_1:
	.byte 0		#size
	.byte 0		#generation
	.space 900 #900 cells possible in 30x30 board

BOARD_2:	
	.byte 0		#size
	.byte 0		#generation
	.space 900 #900 cells possible in 30x30 board

COORDS:
	.space 1800 #900 cells two coords for each = 1800



.text
#name:			memset
#description:	set all bytes in an array to 0
#parameters:	$a0: start address of array
#				$a1: number of bytes to set
#				$a2: value to set
memset:
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)

	move	$s0, $a0 
	move	$s1, $a1
	move	$s2, $a2
	j		meset_loop

meset_loop:
	beq		$s1, $0, return

	addi	$s0, $s0, $s2 #set value

	addi	$s0, $s0, 1 #next byte
	addi	$s1, $s1, -1 #index - 1
	j memset_loop



#Name:			print_banner
#Desc:			print the banner displaying the generation
#Params:		$a0, generation number to print
#Returns:		None
#
print_banner:	
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)

	move	$t1, $a0 #save param

	la		$t0, GEN_BANNER_START #start printing banner
	lb		$a0, 0($t0)
	li		$v0, 4
	syscall

	move	$a0, $t1 #print number
	li		$v0, 1
	syscall 

	la		$t0, GEN_BANNER_END #finish printing banner 
	lb		$a0, 0($t0)
	li		$v0, 4
	syscall

	j		return

print_main_banner:
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)

	la		$t0, BANNER
	lb		$a0, 0($t0)
	li		$v0, 4		#print banner
	syscall
	
	j		return 


#name:			input_size
#descripiton:	from stdout get the size of the board
#params:		None
#return:		$v0 - value read in from stdout
input_size:
	#TODO


#name			input_generation
#description:	from stdin get number of generations to run
#params:		None
#return:		$v0 - value read in from stdout
input_generation:
	#TODO:


#name:			is_occupied
#description:	check if a space is occupied
#params:		$a0: board	
#				$a1: x
#				$a2: y
#return:		$v0: 1 if occupied, 0 if not
is_occupied:	
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)

	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2
	
	lb		$t2, 0($s0) #size
	addi	$s0, $s0, 2 #2 bytes are in front of the board, skip them
	rem		$s1, $s1, $t0 #ensure coord is bounds

	rem		$s2, $s2, $t0 
	mul		$s2, $s2, $t0
	add		$t0, $s1, $s2 #index = x + (y*size) 
	
	add		$s0, $s0, $t0 #goto index and and get val
	lb		$v0, 0($s0)
	
	j		return		

#name:			advance_gen
#description:	advance the game of life one generation
#params:		
#				$a0 board struct to read
#				$a1 board struct to write
advance_gen:
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)

	move	$s0, $a0
	move	$s1, $s1
	
	lb		$s7, 0($s0) #size

	addi	$s2, $s2, 0 #index
	mul		$s3, $s7, $s7 #maxsize

	jal		reset_board #reset board for writing
	
	j advance_gen_loop 

advance_gen_loop:
	beq		$s2, $s3, return
	
	move	$a0, $s0 #board
	rem		$a2, $s2, $s7 #x
	div		$a3, $s2, $s7 #y
	
	jal		find_neighbors
	move	$t1, $v0 #current value	
	add		$t0, $s1, $s2 #current write address = arr + index	

	li		$t2, 2 #compare value
	blt		$t1, $t2, cell_die	
	beq		$t1, $t2, cell_remain	

	li		$t2, 3
	blt		$t2, $t1, cell_die
	beq		$t2, $t1, cell_birth
	
	j		advance_gen_loop

cell_die:
	sb		$0, 0($t0)
	addi	$s2, $s2, 1 #next index
	j		advance_gen_loop

cell_remain:
	sb		$t1, 0($t0)
	addi	$s2, $s2, 1 #next index
	j		advance_gen_loop

cell_birth:	
	li		$t7, 1
	sb		$t7, 0($t0)
	addi	$s2, $s2, 1 #next index
	j		advance_gen_loop

#name:			find_neighbors
#description:	get the number of neighbors around a coordinate
#params:		#a0 board struct to check		
#				$a1 x
#				$a2 y
#return:		$v0: number of neighbors sorrounding x,y
find_neighbors:	
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)
	#TODO: verify this will not destroy registers
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $s2 	

	li		$s3, 0 #adjacent things
	
	addi	$s2, $s2, -1 #first row 
	
	addi	$s1, $s1, -1 #x- y-
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	addi	$s3, $s3, $v0 

	addi	$s1, $s1, 1 #x y-
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	add		$s3, $s3, $v0

	addi	$s1, $s1 1 #x+ y-
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	add		$s3, $s3, $v0

	addi	$s1, $s1, -2 #reset
	addi	$s2, $s2, 1 #second row
		
	addi	$s1, $s1, -1 #x- y
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	addi	$s3, $s3, $v0 

	addi	$s1, $s1 1 #x+ y
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	add		$s3, $s3, $v0

	addi	$s1, $s1, -2 #reset
	addi	$s2, $s2, 1 #third row
		
	addi	$s1, $s1, -1 #x- y+
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	addi	$s3, $s3, $v0 

	addi	$s1, $s1, 1 #x y+
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	add		$s3, $s3, $v0

	addi	$s1, $s1 1 #x+ y+
	move	$a0, $s0
	move	$a1, $s1
	jal		is_occupied
	add		$s3, $s3, $v0

	move	$v0, $s3 
	j		return 
		
#name:			reset_board
#description:	transfer one board to another 
#params:		
#				$a0 board to read
#				$a1 board to reset
#
reset_board:
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)
	
	#TODO: make this only reset the used bytes
	lb			$t0, 0($a0) #get info
	lb			$t1, 1($a0)

	sb			$t0, 0($a1) #copy info over
	sb			$t0, 1($a1)

	addi		$a1, $a1, 2 #goto array
 
	move		$a0, $a1 #setup memset function and reset array to 0
	li			$a1, 900
	li			$a2, 0
	jal			memset
	
	j			return
	
#name:			return
#description:	generic restoration of stack and returning to $ra
#params:		none
#return:		determined by calling function. otherwise none
#
return:	
	lw		$ra, 0($sp)
	lw		$s0, 4($sp)
	lw		$s1, 8($sp)
	lw		$s2, 12($sp)
	lw		$s3, 16($sp)
	lw		$s4, 20($sp)
	lw		$s5, 24($sp)
	lw		$s6, 28($sp)
	lw		$s7, 32($sp)
	addi	$sp, $sp, 36

	jr		$ra


#name:			print_board
#description:	print out the board to stdout
#params:		$a0: board to print
#return:		NONE
print_board:
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)
		
	#TODO
	j		return

#name:			input_coords
#description:	from std input input coordinates into an array
#params:		$a0: array to write to
#return:		$v0: number of coordinates read
input_coords:
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)
	#TODO

#name:			populate
#description:	populate from a list of coordinates a game board
#params:		$a0: board to populate
#				$a1: number of coordinates
populate:
	addi	$sp, $sp, -36
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	sw		$s2, 12($sp)
	sw		$s3, 16($sp)
	sw		$s4, 20($sp)
	sw		$s5, 24($sp)
	sw		$s6, 28($sp)
	sw		$s7, 32($sp)
	#TODO

main:
	jal		print_main_banner

	la		$a0, BOARD_1
	li		$a1, 902
	li		$a2, 0
	jal		memset
	
	la		$a0, BOARD_2
	li		$a1, 902
	li		$a2, 0
	jal		memset

	la		$a0, COORDS
	li		$a1, 1800
	li		$a2, 0
	jal		memset
	
	jal		get_size
	move	$s0, $v0

	jal		get_generation
	move	$s1, $v0

	la		$a0, COORDS
	jal		input_coords

	la		$a1, BOARD_1
	la		$a2, COORDS
	jal		populate

	j		main_loop_1
	#$s0 
	#run loop

main_loop_1:
	beq		$s1, $zero, main_end
	move	$a0, $s1
	jal		print_banner #TODO: this will count down not up

	la		$a0, BOARD_1
	la		$a1, BOARD_2
	jal		reset_board #TODO: make these functiosn params match up	
	jal		advance_gen
	jal		print_board
		
	addi	$s1, $s1, -1
	j		main_loop_2


main_loop_2:
	beq		$s1, $zero, main_end
	move	$a0, $s1
	jal		print_banner #TODO: this will count down not up

	la		$a0, BOARD_2
	la		$a1, BOARD_1
	jal		reset_board #TODO: make these functiosn params match up	
	jal		advance_gen
	jal		print_board
		
	addi	$s1, $s1, -1
	j		main_loop_2


main_end:
	
