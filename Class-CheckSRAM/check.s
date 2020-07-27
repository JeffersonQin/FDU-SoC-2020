############################
    .global OS_CheckSRAM
    .ent OS_CheckSRAM
OS_CheckSRAM:
    .set noreorder
    li		$9, 0xAAAAAAAA		# $9 = 0xAAAAAAAA
    add		$10, $4, $0		    # $10 = $4 + $0
    store_:
        sw      $9, 0($4)
        addi	$4, $4, 1		# $4 = $4 + 1
        ble		$4, $5, store_	# if $4 <= $5 then store_
        nop
        nop
    add		$4, $10, $0		    # $4 = $10 + $0
    check_:
        lw		$11, 0($4)
        bne		$11, $9, fail_	# if $11 != $9 then fail_
        nop
        nop
        addi	$4, $4, 1		# $4 = $4 + 1
        bgt		$4, $5, pass_	# if $4 > $5 then pass_
        nop
        nop
        ble     $4, $5, check_
        nop
        nop
    pass_:
        li		$2, 0		# $2 = 0
        jr $31
        nop
        nop
    fail_:
        li		$2, 1		# $2 = 1
        jr $31
        nop
        nop
    
    .set reorder
    .end OS_CheckSRAM
