#ifndef GPIO_H
#define GPIO_H

#include <stdint.h>
#include "stm8.h"

#define GPIO_PORT_PA  0
#define GPIO_PORT_PB  1
#define GPIO_PORT_PC  2
#define GPIO_PORT_PD  3

#define PIN0  (1 << 0)
#define PIN1  (1 << 1)
#define PIN2  (1 << 2)
#define PIN3  (1 << 3)
#define PIN4  (1 << 4)
#define PIN5  (1 << 5)
#define PIN6  (1 << 6)
#define PIN7  (1 << 7)

typedef enum {
    GPIO_MODE_INPUT_FLOATING = 0,
    GPIO_MODE_INPUT_PULL_UP,
    GPIO_MODE_OUTPUT_PUSH_PULL_LOW,
    GPIO_MODE_OUTPUT_PUSH_PULL_HIGH,
    GPIO_MODE_OUTPUT_OPEN_DRAIN_LOW,
    GPIO_MODE_OUTPUT_OPEN_DRAIN_HIGH
} GPIO_Mode;

typedef enum {
    GPIO_SPEED_SLOW = 0,
    GPIO_SPEED_FAST = 1
} GPIO_Speed;

void GPIO_Init(uint8_t port, uint8_t pin, GPIO_Mode mode, GPIO_Speed speed);
void GPIO_WriteHigh(uint8_t port, uint8_t pin);
void GPIO_WriteLow(uint8_t port, uint8_t pin);
void GPIO_Toggle(uint8_t port, uint8_t pin);
uint8_t GPIO_Read(uint8_t port, uint8_t pin);
void GPIO_Write(uint8_t port, uint8_t pin, uint8_t state);

#endif