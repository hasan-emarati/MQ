#ifndef UART_H
#define UART_H

#include "stm8.h"

void uart_init(unsigned long baudrate);
int uart_write(const char *str);
char uart_read(void);

#endif