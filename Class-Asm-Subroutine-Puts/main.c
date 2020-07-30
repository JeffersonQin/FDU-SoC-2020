#include <mcu.h>

extern void ASM_puts(const char *a);

void user_interrupt(void) { }

int main() {
    while (1) {
        ASM_puts("Hello World\n\r");
    }
    return 0;
}