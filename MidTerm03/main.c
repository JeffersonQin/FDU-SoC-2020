#include <mcu.h>

/******** TIMER Hardware addesses ********/
#define T1_CTL0_REG       			0x1f800200  							// Timer1 (32-bit)control and base
#define T1_REF_REG        			0x1f800201  							// Timer1 ref number for PWM(1)
#define T1_READ_REG       			0x1f800202  							// Timer1 value
#define T1_CLRIRQ_REG     			0x1f800203  							// Timer1 clear IRQ
#define T1_CLK_REG        			0x1f800204  							// Timer1 clk div
#define T1_CLRCNT_REG     			0x1f800205  							// Timer1 clear counter content (and PWM)
#define SYS_CTL0_REG      			0x1f800700  							// sys control digi_off - - - - - dbg inten
/******** UART0 Hardware addesses ********/
#define UART0_READ_REG       		0x1f800000
#define UART0_BUSY_REG       		0x1f800001
#define UART0_WRITE_REG      		0x1f800002
#define UART0_IRQ_ACK_REG    		0x1f800003
#define UART0_CTL_REG        		0x1f800004
#define UART0_DATA_RDY_REG   		0x1f800005
#define UART0_LIN_BREAK_REG  		0x1f800006
#define UART0_BRP_REG        		0x1f800007
/*************** UART0 Setup***************/
#define RT_UART0_Off()             	MemoryOr32(UART0_CTL_REG,0x10)        	// UART0 off
#define RT_UART0_On()              	{MemoryAnd32(UART0_CTL_REG,~0x10);}     // UART0 on
#define RT_UART0_Busy()            	MemoryRead32(UART0_BUSY_REG)            // check tx busy
#define RT_UART0_Write(val)        	MemoryWrite32(UART0_WRITE_REG,val)      // send the data
#define RT_UART0_DataReady()       	MemoryRead32(UART0_DATA_RDY_REG)        // check data ready
#define RT_UART0_Read()            	MemoryRead32(UART0_READ_REG)            // read the data
// Implementation of outputting string using UART0
void RT_UART0_putchar(unsigned char c)
{
    while (RT_UART0_Busy())
        ;
    RT_UART0_Write(c);
}
void RT_UART0_puts(unsigned char *string)
{
    while (*string)
    {
        if (*string == '\n')
            RT_UART0_putchar('\r');
        RT_UART0_putchar(*string ++);
    }
}
// Implementation of setting timer's target with unit of 100us
void RT_T1_Set100u(int n, int irq) {
	MemoryAnd32(T1_CTL0_REG, ~(1<<7));
	MemoryWrite32(T1_CLK_REG, 0xff);
	MemoryWrite32(T1_REF_REG, n);
	MemoryOr32(T1_CTL0_REG, (0x02 | (irq << 7)));
	MemoryOr32(SYS_CTL0_REG, irq);
}
// Dec -> HEX
char *xtoa(unsigned long num) {
    static char buf[12];
    int i, digit;
    buf[8] = 0;
    for (i = 7; i >= 0; --i)
    {
        digit = num & 0xf;
        buf[i] = digit + (digit < 10 ? '0' : 'A' - 10);
        num >>= 4;
    }
    return buf;
}
// Print the status of Timer
void PrintTimer(){
	int cnt;
	cnt = MemoryRead32(T1_READ_REG);
	RT_UART0_puts(xtoa(cnt));
	RT_UART0_puts("\r\n");
}

void user_interrupt(void) {
	MemoryWrite32(T1_CTL0_REG, 0);		// timer off
	RT_UART0_puts("\n interrupt --- timer: ");
	PrintTimer(); 						// print current timer value
	MemoryWrite32(T1_CLRIRQ_REG, 0);	// Clear IQR Value
	MemoryWrite32(T1_CLRCNT_REG, 0);	// Clear cnt Value
	RT_T1_Set100u(255, 1); 				// timer on， interrupt enable
}

int main(void) {
	RT_SYSINT_En();						// enable system interrupt, in mcu.h
	MemoryWrite32(T1_CLRIRQ_REG, 0);	// Clear IQR Value
	MemoryWrite32(T1_CLRCNT_REG, 0);	// Clear cnt Value
	RT_T1_Set100u(255, 1); 				// set the timer of 25.5ms, interrupt enable
	while(1) {
		RT_UART0_puts("test!\n");
	}
	return 0;
}