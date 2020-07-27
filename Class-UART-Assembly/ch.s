####### ASM_putch #######
	.global ASM_putch
	.ent ASM_putch
ASM_putch:
	.set noreorder
	######### UART Write Sub #########
	UART_WRITE_:
		li		$9,		0x1f800000					# uart starting port 01 = busy port, 02 = write port
		li		$5,		0							# test uart port status 0 no busy, 1 busy
		nop											# delay slot
	UART_WAIT_:
		lw		$10,	1($9)						# uart port address 01
		or		$10,	$5,		$10
		bgtz	$10,	UART_WAIT_					# uart port 1 = busy
		nop
		sb		$4,		2($9)						# uart wt port = 02; parameter @ $4
		jr		$31									# jump to $31
		nop
		nop
	.set reorder
	.end ASM_putch
####### ASM_getch #######
	.global ASM_getch
	.ent ASM_getch
ASM_getch:
	.set noreorder
	######### UART Read Sub #########
	UART_READ_:
		li		$9,		0x1f800000					# uart starting port 01 = busy port, 02 = write port， 05 = data ready port
		nop
	UART_WRITE_WAIT_:
		lw		$10,	5($9)
		beq		$10,	$0,		UART_WRITE_WAIT_	# if $10 == $0 then UART_WRITE_WAIT_
		nop
		lw		$2,		0($9)
		jr		$31									# jump to $31
		nop
		nop
	.set reorder
	.end ASM_getch
