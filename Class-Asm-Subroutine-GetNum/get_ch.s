####### ASM_getch #######
    .global ASM_getch
    .ent ASM_getch
ASM_getch:
    .set noreorder
    li			$9,		0x1f800000					# uart starting port 01 = busy port, 02 = write port， 05 = data ready port
    nop
    UART_WRITE_WAIT_:
        lw			$10,	5($9)
        beq			$10,	$0,		UART_WRITE_WAIT_	# if $10 == $0 then UART_WRITE_WAIT_
        nop
        nop												# delay slot
        lw			$14,	0($9)						# $14 = 0($9)

    jr $31

    .set reorder
    .end ASM_getch
