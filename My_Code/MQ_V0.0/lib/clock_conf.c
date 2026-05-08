#include "clock_conf.h"
#include "stm8.h"

void clock_init(void)
{
    CLK_ECKR |= CLK_ECKR_HSEEN;
    while(!(CLK_ECKR & CLK_ECKR_HSERDY));

    CLK_SWR = CLK_SWR_HSE;
    CLK_SWCR |= CLK_SWCR_SWEN;
    while(CLK_SWCR & CLK_SWCR_SWBSY);

    CLK_CKDIVR = 0x00;
}