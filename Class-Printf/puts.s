######## ASM_puts #######
	.global ASM_puts
	.ent ASM_puts
ASM_puts:
	.set noreorder
	li		$24, '\r'				# $24 = '\r'
	addi	$sp, $sp, -4			# $sp = $sp + -4
	sw		$31, 0($sp)
	
	PUT_CHAR_LOOP_:	
		lbu		$6, 0($4)			# $6 = 0($4)
        beq		$6, $24, END_SUB_	# if $6 == $24 then END_SUB_
        nop
        nop
        addi	$sp, $sp, -4			# $sp = $sp + -4
        sw		$4, 0($sp)
        add		$4, $0, $6		# $4 = $0 + $6
		jal		ASM_putch			# jump to ASM_putch and save position to $ra
		nop
		nop
        lw		$4, 0($sp) 
        addi	$sp, $sp, 4			# $sp = $sp + 4
		addi	$4, $4, 1			# $4 = $4 + 1
		b		PUT_CHAR_LOOP_		# branch to PUT_CHAR_LOOP_
        
		nop
		nop

    END_SUB_:
        lw		$31, 0($sp)
        addi	$sp, $sp, 4			# $sp = $sp + 4
	
	jr $31
	nop
	nop
	.set reorder
	.end ASM_puts
