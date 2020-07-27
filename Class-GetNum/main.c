#include "mcu.h"

/******** Define the Registers for UART ********/
#define UART0_READ_REG				0x1f800000
#define UART0_BUSY_REG				0x1f800001
#define UART0_WRITE_REG				0x1f800002
#define UART0_DATA_RDY_REG			0x1f800005
/******** Define the UART Function ********/
#define RT_UART0_Busy()				MemoryRead32(UART0_BUSY_REG)					// check tx busy
#define RT_UART0_Write(val)			MemoryWrite32(UART0_WRITE_REG,val)				// send the data
#define RT_UART0_DataReady()		MemoryRead32(UART0_DATA_RDY_REG)				// check data ready
#define RT_UART0_Read()				MemoryRead32(UART0_READ_REG)					// read the data

/**
 * @brief user_interrupt function
 */
void user_interrupt(void) { }

/**
 * @brief This function sends 1-byte data by UART0
 * 
 * @param c     1-byte data to send
 */
void RT_UART0_putchar(unsigned char c)
{
    while (RT_UART0_Busy())
        ;
    RT_UART0_Write(c);
}

/**
 * @brief This function returns 1-byte data from UART0
 * 
 * @return unsigned char	1-byte data from UART0
 */
unsigned char RT_UART0_getchar()
{
    while (!RT_UART0_DataReady())
        ;
    return RT_UART0_Read();
}

/**
 * @brief This function sends a string by UART0
 * 
 * @param string    the string to send
 */
void RT_UART0_puts(unsigned char *string)
{
    while (*string)
    {
        if (*string == '\n')
            RT_UART0_putchar('\r');
        RT_UART0_putchar(*string++);
    }
}

unsigned long get_number(void) {
    RT_UART0_puts("Insert number: \n");
    unsigned long ans = 0;
    for (int i = 0; i < 8; i ++) {
        ans *= 0x10;
        unsigned char c = RT_UART0_getchar();
        switch (c)
        {
        case '0':
            ans += 0x0;
            break;
        case '1':
            ans += 0x1;
            break;
        case '2':
            ans += 0x2;
            break;
        case '3':
            ans += 0x3;
            break;
        case '4':
            ans += 0x4;
            break;
        case '5':
            ans += 0x5;
            break;
        case '6':
            ans += 0x6;
            break;
        case '7':
            ans += 0x7;
            break;
        case '8':
            ans += 0x8;
            break;
        case '9':
            ans += 0x9;
            break;
        case 'a':
            ans += 0xa;
        case 'A':
            ans += 0xA;
        case 'b':
            ans += 0xb;
        case 'B':
            ans += 0xB;
        case 'c':
            ans += 0xc;
        case 'C':
            ans += 0xC;
        case 'd':
            ans += 0xd;
        case 'D':
            ans += 0xD;
        case 'e':
            ans += 0xe;
        case 'E':
            ans += 0xE;
        case 'f':
            ans += 0xf;
        case 'F':
            ans += 0xF;
        default:
            break;
        }
    }
    return ans;
}

char *xtoa(unsigned long num)
{
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

int main() {
	while (1) {
        unsigned long n = get_number();
        RT_UART0_puts("");
        RT_UART0_puts("The number is ");
        RT_UART0_puts(xtoa(n));
        RT_UART0_puts("\n");
	}
	return 0;
}