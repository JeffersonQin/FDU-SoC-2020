.text
############################

# function: uart_putd
# description: print dec number to pc
# arguments: $a0 - int
# return value: none
.global  uart_putd
.ent    uart_putd
uart_putd:
.set    noreorder
    addi    $sp,    $sp,    -12
    sw      $ra,    8($sp)
    sw      $s0,    4($sp)					# arg
    sw      $s1,    0($sp)					# saver

    move    $s0,    $a0						# get argument int val
    # push chars to stack
    move    $s1,    $sp						# save current sp
    li      $t0,    10
putd_loop:
    div     $s0,    $t0
    mfhi    $t1								# save s0 % 10 to t1
    addi    $t1,    $t1,    '0'				# get digit's ASCII
    addi    $sp,    $sp,    -4				# align 4
    sw      $t1,    0($sp)					# push
    mflo    $s0								# s0 = s0 / 10
    bgtz    $s0,    putd_loop       
    nop
	nop
putd_pops:
    beq     $sp,    $s1,    uart_putd_end
    nop
	nop
    lw      $a0,    0($sp)					# pop char
    jal     uart_send
    nop
	nop
    addi    $sp,    $sp,    4
    j       putd_pops
    nop
	nop
uart_putd_end:
    lw      $ra,    8($sp)
    lw      $s0,    4($sp)
    lw      $s1,    0($sp)
    addi    $sp,    $sp,    12
    nop
	nop
    jr      $ra
    nop
	nop

.set    reorder
.end    uart_putd

# function: user_interrupt
# description: implementation of user_interrupt
# arguments: null
# return value: null
.global		user_interrupt
.ent 		user_interrupt
user_interrupt:
.set 		noreorder
	addi	$sp, $sp, -4					# $sp = $sp + -4
	sw		$ra, 0($sp)
	# Stop timer
	li		$s1, 0x1f800200					# T1 Control Register: $s1 = 0x1f800200
	sb		$zero, 0($s1)					# MemoryWrite32(T1_CTL0_REG, 0);
	# Print Interrupt Message
	li		$a0, '\n'						# $a0 = '\n'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, ' '						# $a0 = ' '
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'i'						# $a0 = 'i'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'n'						# $a0 = 'n'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 't'						# $a0 = 't'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'e'						# $a0 = 'e'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'r'						# $a0 = 'r'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'r'						# $a0 = 'r'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'u'						# $a0 = 'u'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'p'						# $a0 = 'p'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 't'						# $a0 = 't'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, ' '						# $a0 = ' '
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, '-'						# $a0 = '-'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, '-'						# $a0 = '-'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, '-'						# $a0 = '-'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, ' '						# $a0 = ' '
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 't'						# $a0 = 't'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'i'						# $a0 = 'i'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'm'						# $a0 = 'm'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'e'						# $a0 = 'e'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, 'r'						# $a0 = 'r'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	li		$a0, ':'						# $a0 = ':'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	lw		$a0, 2($s1)						# read value of T1 to $a0
	jal 	uart_putd
	nop
	nop
	li		$a0, '\n'						# $a0 = '\n'
	jal		uart_send						# jump to uart_send and save position to $ra
	nop
	nop										# delay slot
	jal		timer_init
	nop
	nop
	lw		$ra, 0($sp)
	addi	$sp, $sp, 4						# $sp = $sp + 4
	jr		$ra					# jump to $ra
	nop
	nop
.set 		reorder
.end 		user_interrupt

# function: timer_init
# decription: Initialize the Timer
# detailed description:
#		Clear count & IRQ
#		Enables IRQ
#		Set Interval to 25500us ( 25.5ms )
# callers: user_interrupt, main
# arguments: null
# return value: null
.global 	timer_init
.ent		timer_init
timer_init:
.set		noreorder
	li		$s0, 0x1f800700						# System Control Register: $s0 = 0x1f800700
	li		$s1, 0x1f800200						# T1 Control Register: $s1 = 0x1f800200
	# Clear T1 IRQ Value
	sb		$zero, 3($s1)
	# Clear T1 CNT Value
	sb		$zero, 5($s1)
	# Set T1 Interval
	lb		$t1, 0($s1)							# load T1 Control Register value to $t1
	andi	$t1, $t1, 127						# $t1 = ~(1 << 7)
	sb		$t1, 0($s1)							# MemoryAnd32(T1_CTL0_REG, ~(1 << 7));
	li		$t1, 255							# $t1 = 0xff ( 255 )
	sb		$t1, 4($s1)							# MemoryWrite32(T1_CLK_REG, 0xff);
	sb		$t1, 1($s1)							# Set the interval of T1 to 255
	lb		$t1, 0($s0)							# load System Control Register value to $t1
	ori		$t1, $t1, 1							# $t1 = $t1 | 1
	sb		$t1, 0($s0)							# SYS_CTL0_REG
	lb		$t1, 0($s1)							# load T1 Control Register value to $t1
	ori		$t1, $t1, 130						# $t1 = $t1 | ((0x02 | (irq << 7))
	sb		$t1, 0($s1)							# MemoryOr32(T1_CTL0_REG, (0x02 | (irq << 7)));
	# return
	jr		$ra									# jump to $ra
	nop
	nop											# delay slot
	nop
	nop
.set		reorder
.end		timer_init

# function: uart_send
# description: send character to computer through uart
# arguments: $a0 - char for transmission
# return value: none
.global		uart_send
.ent		uart_send
uart_send:
.set		noreorder
    li      $t1,    0x1f800000					# same as uart_recv
    li      $t2,    1
    lw      $t0,    1($t1)						# load BUSY_REG
    bne     $t0,    $t2,    uart_send_ready		# check if Tx is buzy
    nop
	nop
    j       uart_send							# wait 
    nop
	nop
uart_send_ready:
    sb      $a0,    2($t1)						# send char to computer
    jr      $ra									# return to function caller
    nop
	nop
.set		reorder
.end		uart_send

# function: main
# description: implementation of main, start of the program
# detailed description: 
#		Initialize the Timer & System Register
#		Waiting for the interrupt & output text
# arguments: null
# return value: null
	.global 	main
	.ent 		main
main:
	.set 		noreorder
	# Initialization Process
	li		$s0, 0x1f800700						# System Control Register: $s0 = 0x1f800700
	li		$s1, 0x1f800200						# T1 Control Register: $s1 = 0x1f800200
	li		$t1, 1								# $t1 = 1
	sb		$t1, 0($s0)							# Enable system interrupt
	# Initialize the Timer
	jal		timer_init							# jump to timer_init and save position to $ra
	nop
	nop											# delay slot
	# loop: print "test"
	print_loop:
		li		$a0, 't'						# $a0 = 't'
		jal		uart_send						# jump to uart_send and save position to $ra
		nop
		nop										# delay slot
		li		$a0, 'e'						# $a0 = 'e'
		jal		uart_send						# jump to uart_send and save position to $ra
		nop
		nop										# delay slot
		li		$a0, 's'						# $a0 = 's'
		jal		uart_send						# jump to uart_send and save position to $ra
		nop
		nop										# delay slot
		li		$a0, 't'						# $a0 = 't'
		jal		uart_send						# jump to uart_send and save position to $ra
		nop
		nop										# delay slot
		li		$a0, '\n'						# $a0 = '\n'
		jal		uart_send						# jump to uart_send and save position to $ra
		nop
		nop										# delay slot
		j		print_loop						# jump to print_loop
		nop
		nop
	.set 		reorder
.end 			main
# ----------- END OF PROGRAMME -----------
