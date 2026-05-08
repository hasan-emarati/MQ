#ifndef DELAY_H
#define DELAY_H

#include "stm8.h"

// Function prototypes
void delay_ms(unsigned int ms);
void delay_us(unsigned int us);
void delay(unsigned long count);  // Original delay function for backward compatibility

#endif /* DELAY_H */