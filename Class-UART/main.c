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

int main() {
	while (1) {
		unsigned char c = RT_UART0_getchar();
		RT_UART0_putchar(c);
		RT_UART0_putchar(c);
	}
	return 0;
}