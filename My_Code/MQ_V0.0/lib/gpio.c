#include "gpio.h"

void GPIO_Init(uint8_t port, uint8_t pin, GPIO_Mode mode, GPIO_Speed speed)
{
    volatile uint8_t *ddr, *cr1, *cr2;
    
    switch(port) {
        case GPIO_PORT_PA:
            ddr = &PA_DDR;
            cr1 = &PA_CR1;
            cr2 = &PA_CR2;
            break;
        case GPIO_PORT_PB:
            ddr = &PB_DDR;
            cr1 = &PB_CR1;
            cr2 = &PB_CR2;
            break;
        case GPIO_PORT_PC:
            ddr = &PC_DDR;
            cr1 = &PC_CR1;
            cr2 = &PC_CR2;
            break;
        case GPIO_PORT_PD:
            ddr = &PD_DDR;
            cr1 = &PD_CR1;
            cr2 = &PD_CR2;
            break;
        default:
            return;
    }
    
    if(speed == GPIO_SPEED_FAST) {
        *cr2 |= pin;
    } else {
        *cr2 &= ~pin;
    }
    
    switch(mode) {
        case GPIO_MODE_INPUT_FLOATING:
            *ddr &= ~pin;
            *cr1 &= ~pin;
            break;
        case GPIO_MODE_INPUT_PULL_UP:
            *ddr &= ~pin;
            *cr1 |= pin;
            break;
        case GPIO_MODE_OUTPUT_PUSH_PULL_LOW:
            *ddr |= pin;
            *cr1 |= pin;
            switch(port) {
                case GPIO_PORT_PA: PA_ODR &= ~pin; break;
                case GPIO_PORT_PB: PB_ODR &= ~pin; break;
                case GPIO_PORT_PC: PC_ODR &= ~pin; break;
                case GPIO_PORT_PD: PD_ODR &= ~pin; break;
            }
            break;
        case GPIO_MODE_OUTPUT_PUSH_PULL_HIGH:
            *ddr |= pin;
            *cr1 |= pin;
            switch(port) {
                case GPIO_PORT_PA: PA_ODR |= pin; break;
                case GPIO_PORT_PB: PB_ODR |= pin; break;
                case GPIO_PORT_PC: PC_ODR |= pin; break;
                case GPIO_PORT_PD: PD_ODR |= pin; break;
            }
            break;
        case GPIO_MODE_OUTPUT_OPEN_DRAIN_LOW:
            *ddr |= pin;
            *cr1 &= ~pin;
            switch(port) {
                case GPIO_PORT_PA: PA_ODR &= ~pin; break;
                case GPIO_PORT_PB: PB_ODR &= ~pin; break;
                case GPIO_PORT_PC: PC_ODR &= ~pin; break;
                case GPIO_PORT_PD: PD_ODR &= ~pin; break;
            }
            break;
        case GPIO_MODE_OUTPUT_OPEN_DRAIN_HIGH:
            *ddr |= pin;
            *cr1 &= ~pin;
            switch(port) {
                case GPIO_PORT_PA: PA_ODR |= pin; break;
                case GPIO_PORT_PB: PB_ODR |= pin; break;
                case GPIO_PORT_PC: PC_ODR |= pin; break;
                case GPIO_PORT_PD: PD_ODR |= pin; break;
            }
            break;
    }
}

void GPIO_WriteHigh(uint8_t port, uint8_t pin)
{
    switch(port) {
        case GPIO_PORT_PA: PA_ODR |= pin; break;
        case GPIO_PORT_PB: PB_ODR |= pin; break;
        case GPIO_PORT_PC: PC_ODR |= pin; break;
        case GPIO_PORT_PD: PD_ODR |= pin; break;
    }
}

void GPIO_WriteLow(uint8_t port, uint8_t pin)
{
    switch(port) {
        case GPIO_PORT_PA: PA_ODR &= ~pin; break;
        case GPIO_PORT_PB: PB_ODR &= ~pin; break;
        case GPIO_PORT_PC: PC_ODR &= ~pin; break;
        case GPIO_PORT_PD: PD_ODR &= ~pin; break;
    }
}

void GPIO_Toggle(uint8_t port, uint8_t pin)
{
    switch(port) {
        case GPIO_PORT_PA: PA_ODR ^= pin; break;
        case GPIO_PORT_PB: PB_ODR ^= pin; break;
        case GPIO_PORT_PC: PC_ODR ^= pin; break;
        case GPIO_PORT_PD: PD_ODR ^= pin; break;
    }
}

uint8_t GPIO_Read(uint8_t port, uint8_t pin)
{
    switch(port) {
        case GPIO_PORT_PA: return ((PA_IDR & pin) != 0);
        case GPIO_PORT_PB: return ((PB_IDR & pin) != 0);
        case GPIO_PORT_PC: return ((PC_IDR & pin) != 0);
        case GPIO_PORT_PD: return ((PD_IDR & pin) != 0);
        default: return 0;
    }
}

void GPIO_Write(uint8_t port, uint8_t pin, uint8_t state)
{
    if(state) {
        GPIO_WriteHigh(port, pin);
    } else {
        GPIO_WriteLow(port, pin);
    }
}