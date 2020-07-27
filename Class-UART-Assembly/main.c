#include <mcu.h>

extern void ASM_putch();
extern unsigned char ASM_getch();

void user_interrupt(void) { }

int main() {
    while (1) {
		unsigned char c = ASM_getch();
		ASM_putch(c);
		ASM_putch(c);
	}
    return 0;
}