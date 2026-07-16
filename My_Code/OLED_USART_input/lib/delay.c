#include "delay.h"

// Simple delay using NOP operations
// 1 NOP = 1 clock cycle at 16MHz = 62.5ns
void delay(unsigned long count) {
    while (count--)
        nop();
}

// Delay in milliseconds at 16MHz
// Calculated: 16,000,000 cycles/sec = 16,000 cycles/ms
// Each loop iteration takes approximately 8 cycles (count--, compare, jump)
// So 16,000 / 8 = 2,000 iterations per ms
void delay_ms(unsigned int ms) {
    unsigned int i, j;
    for(i = 0; i < ms; i++) {
        for(j = 0; j < 2000; j++) {
            nop();
        }
    }
}

// Delay in microseconds at 16MHz
// 16 cycles per microsecond at 16MHz
// Each loop iteration takes approximately 8 cycles
// So 16 / 8 = 2 iterations per microsecond
void delay_us(unsigned int us) {
    unsigned int i, j;
    for(i = 0; i < us; i++) {
        for(j = 0; j < 2; j++) {
            nop();
        }
    }
}

/* EXAMPLE USAGE:
   =============
   
   #include "delay.h"
   
   void main(void) {
       // Simple delay with custom count
       delay(100000);     // ~6.25ms at 16MHz
       
       // Millisecond delay (more accurate)
       delay_ms(1000);    // 1 second delay
       delay_ms(500);     // 500ms delay
       
       // Microsecond delay
       delay_us(100);     // 100 microseconds
       delay_us(1000);    // 1 millisecond (1000us)
       
       // Blink LED example
       while(1) {
           GPIO_WriteLow(LED_PORT, LED_PIN);
           delay_ms(500);  // LED ON for 500ms
           
           GPIO_WriteHigh(LED_PORT, LED_PIN);
           delay_ms(500);  // LED OFF for 500ms
       }
   }
   
   NOTES:
   - All delays are calibrated for 16MHz system clock
   - If you change clock speed, recalculate delay values
   - For critical timing, use timer peripherals instead
   - delay_ms() and delay_us() are more accurate than delay()
*/