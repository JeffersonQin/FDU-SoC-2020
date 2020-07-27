#include <str.h>
#include <mcu.h>

void user_interrupt() {}

extern int OS_CheckSRAM();

int main() {
	long a;
    a = OS_CheckSRAM(0x01001f00, 0x01001fff);
    if (a == 1)             puts("fail");
    else if (a == 0)        puts("pass");
    else                    puts(xtoa(a));
	return 0;
}
