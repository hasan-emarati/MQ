// STM8S003f3
#include "stm8.h"
#include "gpio_s3.h"
#include "delay.h"
#include "uart.h"
#include "i2c.h"
#include "oled.h"

/*=============================================
                Define Value
===============================================*/
#define LED_PORT     GPIO_PORT_PD
#define LED_PIN      PIN4

#define RELAY_PORT   GPIO_PORT_PC
#define RELAY_PIN    PIN3

#define TR_PORT      GPIO_PORT_PA
#define TR_PIN       PIN3

#define INPUT1_PORT  GPIO_PORT_PC
#define INPUT1_PIN   PIN5

#define INPUT2_PORT  GPIO_PORT_PC
#define INPUT2_PIN   PIN6

/*=============================================
                    Main
===============================================*/
int main(void)
{
    // Configure HSE clock (16MHz)
    CLK_ECKR |= CLK_ECKR_HSEEN;
    while(!(CLK_ECKR & CLK_ECKR_HSERDY));
    CLK_SWR = CLK_SWR_HSE;
    CLK_SWCR |= CLK_SWCR_SWEN;
    while(CLK_SWCR & CLK_SWCR_SWBSY);
    CLK_CKDIVR = 0x00;
    
    // Initialize I2C
    i2c_init(16000000, I2C_SPEED_STANDARD);
    
    // Initialize UART
    uart_init(9600);
    
    // Initialize GPIO
    GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
    GPIO_Init(RELAY_PORT, RELAY_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
    GPIO_Init(TR_PORT, TR_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
    GPIO_Init(INPUT1_PORT, INPUT1_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
    GPIO_Init(INPUT2_PORT, INPUT2_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
    
    // Initialize OLED
    delay_ms(200);
    oled_init();
    oled_clear();
    
    // Display startup message
    oled_set_font(FONT_5X7); 
    oled_puts_at(0, 0, "System Ready!");
    oled_puts_at(0, 8, "STM8S003F3");
    oled_puts_at(0, 16, "OLED Display");
    oled_puts_at(0, 24, "I2C Interface");
    
    // Send message via UART
    uart_write("System Ready!\r\n");
    
    while(1) 
    {
        // Check UART
        if((UART1_SR & UART_SR_RXNE)) {
            char received = UART1_DR;
            
            if(received == '1') {
                uart_write("Received: 1\r\n");
    
                // Blink LED
                GPIO_WriteLow(LED_PORT, LED_PIN);
                delay_ms(300);
                GPIO_WriteHigh(LED_PORT, LED_PIN);
            }
        }
        
        // Monitor INPUT1
        if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
            GPIO_WriteLow(LED_PORT, LED_PIN);
        } else {
            GPIO_WriteHigh(LED_PORT, LED_PIN);
        }
        
        delay_ms(100);
    }
}