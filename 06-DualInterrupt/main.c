#include "mcu.h"
#include "str.h"
#include "TC0.h"
#include "TC1.h"
#include "TC2.h"

void PrintTimer() {
	int cnt;
	cnt = RT_T2_ReadCnt(); 			// read the TC2 cnt value
	puts(xtoa(cnt)); 				// output the value in octal format
	puts("\r\n");
}

void user_interrupt(void) {
	int intSrc = (RT_SYSINT_Flag())& 0xff;
	switch (intSrc) {
	case 0x2:
		puts("\nTC0 interrupt\n");
		RT_T0_Stop(); 				// tc0 timer off
		RT_T0_Clr();
		PrintTimer();
		RT_T0_Set100u(255,1); 		//reset tc0
		break;
	case 0x4:
		puts("\nTC1 interrupt\n");
		RT_T1_Stop(); 				// tc0 timer off
		RT_T1_Clr();
		PrintTimer();
		RT_T1_Set100u(100,1); 		//reset tc1
		break;
	default:
		puts("\nerror!\n");
		break;
	}
}

int main(void) {
	RT_T0_Set100u(255,1); 			// set tc0 timer to 25.5ms, interrupt enable
	RT_T1_Set100u(100,1);			// set tc1 timer to 10ms, interrupt enable
	RT_T0_Clr();
	RT_T1_Clr();
	RT_T2_SetCtr(255);
	while(1) ;
	return 0;
}