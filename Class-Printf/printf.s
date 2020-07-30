######### ASM_printf #########
    .global ASM_printf
    .ent ASM_printf
ASM_printf:
    .set noreorder
    li		$24, '\r'		                    # $24 = '\r'
    li		$10, '%'		                    # $10 = '%'
    li		$11, 0		                        # $11 = 0
    
    addi	$sp, $sp, -4			            # $sp = $sp + -4
    sw		$ra, 0($sp)
    
    PUT_CHAR_LOOP_PRINTF_:
        lbu     $8, 0($4)                       # $8 = 0($4)
        beq		$8, $24, END_SUB_PRINTF	        # if $8 == $24 then END_SUB_PRINTF
        nop
        nop

        beq		$8, $10, print_with_parameter	# if $8 == $10 then print_with_parameter
        nop
        nop
        
        print_normal:
            li		$25, 1		                # $25 = 1
            b		ASM_STACK_SAVE_			    # branch to ASM_STACK_SAVE_
            nop
            nop
            printf_save_point_1:
            add		$4, $8, $0		            # $4 = $8 + $0
            jal		ASM_putch				    # jump to ASM_putch and save position to $ra
            nop
            nop
            b		ASM_STACK_LOAD_			    # branch to ASM_STACK_LOAD_
            nop
            nop
            printf_load_point_1:
                addi	$4, $4, 1			    # $4 = $4 + 1
                b		PUT_CHAR_LOOP_PRINTF_	# branch to PUT_CHAR_LOOP_PRINTF_
                nop
                nop

        
        print_with_parameter:
            addi	$4, $4, 1			        # $4 = $4 + 1
            lbu     $8, 0($4)
            li		$15, 0		                # $15 = 0
            beq		$11, $15, get_par_5	        # if $11 == $15 then get_par_5
            nop
            nop
            li		$15, 1		                # $15 = 1
            beq		$11, $15, get_par_6	        # if $11 == $15 then get_par_6
            nop
            nop
            li		$15, 2		                # $15 = 2
            beq		$11, $15, get_par_7	        # if $11 == $15 then get_par_7
            nop
            nop
            get_par_5:
                addi	$9, $5, 0			    # $9 = $5 + 0
                b		get_par_end			    # branch to get_par_end
                nop
                nop
            get_par_6:
                addi	$9, $6, 0			    # $9 = $6 + 0
                b		get_par_end			    # branch to get_par_end
                nop
                nop
            get_par_7:
                addi	$9, $7, 0			    # $9 = $7 + 0
                b		get_par_end			    # branch to get_par_end
                nop
                nop
            
            get_par_end:
                addi	$11, $11, 1			    # $11 = $11 + 1

            li		$14, 's'		            # $14 = 's'
            beq		$8, $14, print_string	    # if $8 == $14 then print_string
            nop
            nop
            li		$14, 'd'		            # $14 = 'd'
            beq		$8, $14, print_integer	    # if $8 == $14 then print_integer
            nop
            nop
            li		$14, 'c'		            # $14 = 'c'
            beq		$8, $14, print_character	# if $8 == $14 then print_character
            nop
            nop

            print_string:
                li		$25, 2		            # $25 = 2
                b		ASM_STACK_SAVE_			# branch to ASM_STACK_SAVE_
                nop
                nop
                printf_save_point_2:
                add		$4, $9, $0		        # $4 = $9 + $0
                add		$9, $0, $0		        # $9 = $0 + $0
                jal       ASM_puts
                nop
                nop
                b		ASM_STACK_LOAD_			# branch to ASM_STACK_LOAD_
                nop
                nop
                printf_load_point_2:
                    b		print_end			# branch to print_end
                    nop
                    nop
            print_integer:
                li		$25, 3		            # $25 = 3
                b		ASM_STACK_SAVE_			# branch to ASM_STACK_SAVE_
                nop
                nop
                printf_save_point_3:
                    printf_integer_sub:
                        addi    $sp,    $sp,    -12
                        sw      $ra,    8($sp)
                        sw      $s0,    4($sp)          # arg
                        sw      $s1,    0($sp)          # saver

                        move    $s0,    $9             # get argument int val

                        # test positive
                        bgt     $s0,    $zero,  printf_integer_stackop
                        nop
                        li      $a0,    '-'
                        jal     ASM_putch
                        nop
                        sub     $s0,    $zero,  $s0
                    printf_integer_stackop:
                        move    $s1,    $sp             
                        li      $t0,    10
                    printf_integer_print_loop:
                        div     $s0,    $t0
                        mfhi    $t1                     
                        addi    $t1,    $t1,    '0'     
                        addi    $sp,    $sp,    -4      
                        sw      $t1,    0($sp)          
                        mflo    $s0
                        bgtz    $s0,    printf_integer_print_loop       
                        nop
                    printf_integer_pop:
                        beq     $sp,    $s1,    printf_integer_sub_end
                        nop
                        lw      $a0,    0($sp)
                        jal     ASM_putch
                        nop
                        addi    $sp,    $sp,    4
                        j       printf_integer_pop
                        nop
                    printf_integer_sub_end:
                        lw      $ra,    8($sp)
                        lw      $s0,    4($sp)
                        lw      $s1,    0($sp)
                        addi    $sp,    $sp,    12
                        nop
                        jr      $ra
                        nop
                b		ASM_STACK_LOAD_			# branch to ASM_STACK_LOAD_
                nop
                nop
                printf_load_point_3:

                b		print_end			    # branch to print_end
                nop
                nop
            print_character:
                li		$25, 4		            # $25 = 4
                b		ASM_STACK_SAVE_			# branch to ASM_STACK_SAVE_
                nop
                nop
                printf_save_point_4:
                add		$4, $9, $0		        # $4 = $9 + $0
                add		$9, $0, $0		        # $9 = $0 + $0
                jal     ASM_putch
                nop
                nop
                b		ASM_STACK_LOAD_			# branch to ASM_STACK_LOAD_
                nop
                nop
                printf_load_point_4:
                    b		print_end			# branch to print_end
                    nop
                    nop
            print_end:
                addi	$4, $4, 1			    # $4 = $4 + 1
                b		PUT_CHAR_LOOP_PRINTF_	# branch to PUT_CHAR_LOOP_PRINTF_
                nop
                nop


    END_SUB_PRINTF:
        lw		$ra, 0($sp)
        addi	$sp, $sp, 4			            # $sp = $sp + 4
        jr		$ra					            # jump to $ra
        nop
        nop
    .set reorder
    .end ASM_printf



######## ASM_STACK_OP_ #######
	.global ASM_STACK_SAVE_
	.ent ASM_STACK_SAVE_
ASM_STACK_SAVE_:
    .set noreorder
    addi	$sp, $sp, -64			# $sp = $sp + -64
    sw		$v0, 0($sp)
    sw		$v1, 4($sp)
    sw		$a0, 8($sp)
    sw		$a1, 12($sp)
    sw		$a2, 16($sp)
    sw		$a3, 20($sp)
    sw		$t0, 24($sp)
    sw		$t1, 28($sp)
    sw		$t2, 32($sp)
    sw		$t3, 36($sp)
    sw		$t4, 40($sp)
    sw		$t5, 44($sp)
    sw		$t6, 48($sp)
    sw		$t7, 52($sp)
    sw		$t8, 56($sp)
    sw		$t9, 60($sp)
    
    li		$15, 1		# $15 = 1
    beq		$25, $15, printf_save_point_1	# if $25 == $15 then printf_save_point_1
    nop
    nop
    li		$15, 2		# $15 = 2
    beq		$25, $15, printf_save_point_2	# if $25 == $15 then printf_save_point_2
    nop
    nop
    li		$15, 3		# $15 = 3
    beq		$25, $15, printf_save_point_3	# if $25 == $15 then printf_save_point_3
    nop
    nop
    li		$15, 4		# $15 = 4
    beq		$25, $15, printf_save_point_4	# if $25 == $15 then printf_save_point_4
    nop
    nop

    nop
    nop
    .end ASM_STACK_SAVE_

	.global ASM_STACK_LOAD_
	.ent ASM_STACK_LOAD_
ASM_STACK_LOAD_:
    .set noreorder
    lw		$v0, 0($sp)
    lw		$v1, 4($sp)
    lw		$a0, 8($sp)
    lw		$a1, 12($sp)
    lw		$a2, 16($sp)
    lw		$a3, 20($sp)
    lw		$t0, 24($sp)
    lw		$t1, 28($sp)
    lw		$t2, 32($sp)
    lw		$t3, 36($sp)
    lw		$t4, 40($sp)
    lw		$t5, 44($sp)
    lw		$t6, 48($sp)
    lw		$t7, 52($sp)
    lw		$t8, 56($sp)
    lw		$t9, 60($sp)
    addi	$sp, $sp, 64			# $sp = $sp + 64
    li		$15, 1		# $15 = 1
    beq		$25, $15, printf_load_point_1	# if $25 == $15 then printf_save_point_1
    nop
    nop
    li		$15, 2		# $15 = 2
    beq		$25, $15, printf_load_point_2	# if $25 == $15 then printf_load_point_2
    nop
    nop
    li		$15, 3		# $15 = 3
    beq		$25, $15, printf_load_point_3	# if $25 == $15 then printf_load_point_3
    nop
    nop
    li		$15, 4		# $15 = 4
    beq		$25, $15, printf_load_point_4	# if $25 == $15 then printf_load_point_4
    nop
    nop

    nop
    nop
    .end ASM_STACK_LOAD_

