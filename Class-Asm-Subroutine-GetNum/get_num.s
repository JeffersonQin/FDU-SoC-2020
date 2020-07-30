####### ASM_getnum #######
	.global ASM_getnum
	.ent ASM_getnum
ASM_getnum:
	.set noreorder
	li					$12, 	0							# $12 = 0
	li					$13, 	8							# $13 = 8
	li					$15, 	0							# $15 = 0
	add					$29, $31, $0						# $24 = $31 + $0
	READ_ONE_BIT_:
			jal 		ASM_getch
			nop
			nop
			li			$6, 	48							# $6 = 48
			sub			$14, 	$14, 	$6					# $14 = $14 - $6
			li			$4, 	9							# $4 = 9
			bgt			$14, 	$4, 	BIT_HANDLER_		# if $14 > $9 then BIT_HANDLER_
			nop
			nop
		JUMP_BACK_:
			ADD_BIT_:
				li			$4, 	16							# $4 = 16
				addi		$5, 	$15, 	0					# $5 = $15 + 0
				mult		$4, 	$5							# $4 * $5 = Hi and Lo registers
				mflo		$15									# copy Lo to $15
				
				add			$15, 	$15, 	$14					# $15 = $15 + $14
				addi		$12, 	$12, 	1					# $12 = $12 + 1
				blt			$12, 	$13, 	READ_ONE_BIT_		# if $12 < $13 then READ_ONE_BIT_
				nop
				nop
				addi		$2, 	$15, 	0					# $2 = $15 + 0
				add			$31, 	$29, 	$0					# $31 = $24 + $0
				
				jr			$31									# jump to $31
				nop
				nop

		BIT_HANDLER_:
			li			$6, 	7							# $6 = 7
			sub			$14, 	$14, 	$6					# $14 = $14 - $6
			li			$4, 	15							# $4 = 15
			bgt			$14, 	$4, 	BIT_HANDLER_2_		# if $14 > $4 then BIT_HANDLER_2_
			nop
			nop
			JUMP_BACK_2_:
				b		JUMP_BACK_							# branch to JUMP_BACK_
				nop
				nop

		BIT_HANDLER_2_:
			li			$6, 	32							# $6 = 32
			sub			$14, 	$14, 	$6					# $14 = $14 - $6
			b			JUMP_BACK_2_						# branch to JUMP_BACK_2_
			nop
			nop

	.set reorder
	.end ASM_getnum

