#include "str.h"
#include "mcu.h"
#include "TC1.h"

void user_interrupt(void) {}

void PrintTimer() {
	int cnt;
	cnt = RT_T1_ReadCnt(); 					// read the TC1 cnt value
	puts(xtoa(cnt));
	puts("\r\n");
}

int main(void) {
	RT_T1_Clr(); 							// clear irq and cnt value
	RT_T1_Set100u(255, 0); 					// set the timer of 25.5ms, no interrupt
	while(1) {
		while (RT_T1_Flag()) {
			RT_T1_Stop(); 					// timer off
			puts("timer: ");
			PrintTimer(); 					// print current timer value
			RT_T1_Clr(); 					// clear irq and cnt value
			RT_T1_Set100u(255, 0); 			// timer on
		}
	}
	return 0;
}