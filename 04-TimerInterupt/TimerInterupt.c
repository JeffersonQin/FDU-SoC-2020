#include <str.h>
#include <mcu.h>
#include <TC1.h>

void PrintTimer(){
	int cnt;
	cnt = RT_T1_ReadCnt();
	puts(xtoa(cnt));
	puts("\r\n");
}

void user_interrupt(void){
	RT_T1_Stop(); // timer off
	puts("\n interrupt --- timer: ");
	PrintTimer(); // print current timer value
	RT_T1_Clr(); // clear irq and cnt value
	RT_T1_Set100u(255, 1) // timer on， interrupt enable
}

int main(void) {
	RT_SYSINT_En(); // enable system interrupt, in mcu.h
	RT_T1_Clr(); // clear irq and cnt value
	RT_T1_Set100u(255,1); // set the timer of 25.5ms, interrupt enable
	while(1) {
		puts("test!\n");
	}
	return 0;
}