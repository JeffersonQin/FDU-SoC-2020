#include <mcu.h>

extern void ASM_printf();

void user_interrupt(void) { }

int main() {
    while (1) {
        ASM_printf("abcdefghijkl%s%c%d\n\r", "123456789\r", '0', 8825);
    }
    return 0;
}