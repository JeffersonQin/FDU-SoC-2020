#include <mcu.h>
#include <str.h>

extern unsigned long ASM_getnum();

void user_interrupt(void) { }

int main() {
    while (1) {
        unsigned long n = ASM_getnum();
        puts("Input number: ");
        puts(xtoa(n));
        puts("\n");
    }
    return 0;
}