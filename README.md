# FDU-SoC-2020

Source code for Fudan University SoC Course in Summer 2020.

## 01-SoC-HelloWorld-C

Hello World in C

## 02-SoC-HelloWorld-A

Hello World in Assembly

## 03-Timer

Timer Count

## 04-TimerInterrupt

Timer Interrupt experiment in C

## 06-DualInterrupt

Identification of interrupt by two timers

## Class-Asm-Subroutine-Puts

Implementation of 'puts' function in str.h using Assembly by writing subroutines

## Class-CheckSRAM

Write & Erase SRAM in Assembly

## Class-GetNum

Implementation of GetNum using C

## Class-GetNum-Assembly

Implementation of GetNum using Assembly

## Class-Asm-Subroutine-GetNum

Implementation of GetNum using Assembly by writing subroutines

## Class-Printf

Implementation of 'printf' in Assembly

## Class-UART

Implementation of sending and receiving by UART in C by manipulating memory instead of calling system functions

## Class-UART-Assembly

Implementation of sending and receiving by UART in Assembly

## MidTerm03

MidTerm Exam Problem 03:

请使用C语言，不使用库函数，直接使用MemoryWrite32()，MemoryRead32()对寄存器操作，实现《SOC微系统教程》实验四：中断-Timer_interrupt  的代码功能，为了节省时间，代码中PrintTimer()函数不需要实现。

Please use C without calling system functions (using `MemoryWrite32()`, `MemoryRead32()` directly to manipulate the registers) to implement the fourth experiment in the textbook (Timer_interrupt). The function `PrintTimer()` is not needed to be implemented.

## MidTerm04

请使用C语言，不使用库函数，直接使用MemoryWrite32()，MemoryRead32()对寄存器操作，每0xffffffff个timer计数值输出一个字符，输出字符完成后，继续计数输出，最后输出字符串“ABC2020”。例如，timer每计0xffffffff个数，就通过uart0输出字符‘A’，输出完毕重新启动timer，计数到0xffffffff再次输出字符‘B’。请注意字符“2”与数字 2 的区别；timer计数值远小于0xffffffff，需要通过多次循环累加实现。

## MidTerm05

使用C语言，可以使用库函数，每0xFF个timer计数值产生一次中断，在中断中输出一个字符‘A’，再重新启动计数器，退出中断。需要保证程序可以循环运行。例如，timer每计到0xFF，就产生一个中断，在中断中通过uart0输出字符‘A’，输出完毕重新启动timer，退出中断；计数到0xFF再次产生中断，在中断中通过uart0输出字符‘A’，输出完毕重新启动timer，退出中断，循环5次。

## Final-Timer

The fifth problem of final exam. Complete implmentation of Experiment 4 in Assembly.
