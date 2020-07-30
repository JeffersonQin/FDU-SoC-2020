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
		sb		$6,		2($9)						# uart wt port = 02; parameter @ $6
		jr		$31									# jump to $31
		nop
		nop
	.set reorder
	.end ASM_putch
