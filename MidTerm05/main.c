#include <str.h>
#include <mcu.h>
#include <TC1.h>

int start_cnt = 0;

void clr_and_start_timer(void) {
	RT_T1_Clr();                        // clear irq and cnt value
	RT_T1_Set100u(255, 1)               // timer on， interrupt enable
    start_cnt ++;                       // Add 1 to count variable
}

void user_interrupt(void) {
	RT_T1_Stop();                       // timer off
	puts("A\n");
    if (start_cnt >= 5) return 0;       // Stop repeating after 5 times
    clr_and_start_timer();
}

int main(void) {
	RT_SYSINT_En();                     // enable system interrupt, in mcu.h
	clr_and_start_timer();
    while(1) ;
	return 0;
}