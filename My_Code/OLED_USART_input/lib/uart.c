//uart.c
#include "uart.h"
#include <string.h>

#define SYSTEM_CLOCK 16000000UL

void uart_init(unsigned long baudrate) {
    unsigned int uart_div;
    unsigned char brr1, brr2;
    
    // Calculate UART divider
    uart_div = SYSTEM_CLOCK / (baudrate);
    
    // Disable UART during configuration
    UART1_CR2 = 0x00;
    
    // محاسبه صحیح برای STM8S
    brr1 = (unsigned char)((uart_div >> 4) & 0xFF);
    brr2 = (unsigned char)(((uart_div >> 8) & 0x0F) | (uart_div & 0x0F));
    
    UART1_BRR2 = brr2;
    UART1_BRR1 = brr1;
    
    // Configure frame format: 8 data bits, 1 stop bit, no parity
    UART1_CR1 = 0x00;
    UART1_CR3 = 0x00;
    
    // Enable transmitter and receiver
    UART1_CR2 = 0x0C;  // Bit3=TEN, Bit2=REN
}

int uart_write(const char *str) {
    unsigned char i;
    for(i = 0; i < strlen(str); i++) {
        while(!(UART1_SR & UART_SR_TXE));
        UART1_DR = str[i];
    }
    return i;
}

char uart_read(void) {
    if(UART1_SR & UART_SR_RXNE) {
        return UART1_DR;
    }
    return 0;
}