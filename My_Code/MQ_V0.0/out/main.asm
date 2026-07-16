;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _oled_set_font
	.globl _oled_puts_at
	.globl _oled_clear
	.globl _oled_init
	.globl _i2c_init
	.globl _uart_write
	.globl _uart_init
	.globl _delay
	.globl _delay_ms
	.globl _GPIO_Read
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _sprintf
	.globl _init_adc
	.globl _analog_read_pc4
	.globl _analog_read_pd3
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/main.c: 39: void init_adc(void) {
;	-----------------------------------------
;	 function init_adc
;	-----------------------------------------
_init_adc:
;	src/main.c: 41: ADC_CSR = ADC_CHANNEL_PC4;
	mov	0x5400+0, #0x02
;	src/main.c: 44: ADC_CR1 = 0x00;  // Single conversion mode, no prescaler
	mov	0x5401+0, #0x00
;	src/main.c: 45: ADC_CR2 = 0x00;  // Left aligned data
	mov	0x5402+0, #0x00
;	src/main.c: 46: ADC_CR3 = 0x00;  // No data buffer
	mov	0x5403+0, #0x00
;	src/main.c: 49: ADC_CR1 |= ADC_CR1_ADON;
	bset	0x5401, #0
;	src/main.c: 51: delay(1000); // Wait for ADC stabilization
	push	#0xe8
	push	#0x03
	clrw	x
	pushw	x
	call	_delay
;	src/main.c: 52: }
	ret
;	src/main.c: 54: uint16_t analog_read_pc4(void) {
;	-----------------------------------------
;	 function analog_read_pc4
;	-----------------------------------------
_analog_read_pc4:
;	src/main.c: 58: ADC_CSR = ADC_CHANNEL_PC4;
	mov	0x5400+0, #0x02
;	src/main.c: 61: ADC_CR1 |= ADC_CR1_ADON;
	bset	0x5401, #0
;	src/main.c: 64: while(!(ADC_CSR & ADC_CSR_EOC));
00101$:
	ld	a, 0x5400
	jrpl	00101$
;	src/main.c: 67: adc_value = (ADC_DRH << 2) | (ADC_DRL >> 6);
	ld	a, 0x5404
	clrw	x
	ld	xl, a
	sllw	x
	sllw	x
	ld	a, 0x5405
	swap	a
	and	a, #0x0f
	srl	a
	srl	a
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	xl, a
;	src/main.c: 70: ADC_CSR &= ~ADC_CSR_EOC;
	bres	0x5400, #7
;	src/main.c: 72: return adc_value;
;	src/main.c: 73: }
	ret
;	src/main.c: 75: uint16_t analog_read_pd3(void) {
;	-----------------------------------------
;	 function analog_read_pd3
;	-----------------------------------------
_analog_read_pd3:
;	src/main.c: 79: ADC_CSR = ADC_CHANNEL_PD3;
	mov	0x5400+0, #0x06
;	src/main.c: 82: ADC_CR1 |= ADC_CR1_ADON;
	bset	0x5401, #0
;	src/main.c: 85: while(!(ADC_CSR & ADC_CSR_EOC));
00101$:
	ld	a, 0x5400
	jrpl	00101$
;	src/main.c: 88: adc_value = (ADC_DRH << 2) | (ADC_DRL >> 6);
	ld	a, 0x5404
	clrw	x
	ld	xl, a
	sllw	x
	sllw	x
	ld	a, 0x5405
	swap	a
	and	a, #0x0f
	srl	a
	srl	a
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	xl, a
;	src/main.c: 91: ADC_CSR &= ~ADC_CSR_EOC;
	bres	0x5400, #7
;	src/main.c: 93: return adc_value;
;	src/main.c: 94: }
	ret
;	src/main.c: 98: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #82
;	src/main.c: 105: CLK_ECKR |= CLK_ECKR_HSEEN;
	bset	0x50c1, #0
;	src/main.c: 106: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
00101$:
	btjf	0x50c1, #1, 00101$
;	src/main.c: 107: CLK_SWR = CLK_SWR_HSE;
	mov	0x50c4+0, #0xb4
;	src/main.c: 108: CLK_SWCR |= CLK_SWCR_SWEN;
	bset	0x50c5, #1
;	src/main.c: 109: while(CLK_SWCR & CLK_SWCR_SWBSY);
00104$:
	btjt	0x50c5, #0, 00104$
;	src/main.c: 110: CLK_CKDIVR = 0x00;
	mov	0x50c6+0, #0x00
;	src/main.c: 113: i2c_init(16000000, I2C_SPEED_STANDARD);
	push	#0xa0
	push	#0x86
	push	#0x01
	push	#0x00
	push	#0x00
	push	#0x24
	push	#0xf4
	push	#0x00
	call	_i2c_init
;	src/main.c: 116: uart_init(9600);
	push	#0x80
	push	#0x25
	clrw	x
	pushw	x
	call	_uart_init
;	src/main.c: 119: init_adc();
	call	_init_adc
;	src/main.c: 122: delay_ms(200);
	ldw	x, #0x00c8
	call	_delay_ms
;	src/main.c: 123: oled_init();
	call	_oled_init
;	src/main.c: 124: oled_clear();
	call	_oled_clear
;	src/main.c: 127: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x10
	ld	a, #0x03
	call	_GPIO_Init
;	src/main.c: 128: GPIO_Init(RELAY_PORT, RELAY_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x08
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 129: GPIO_Init(TR_PORT, TR_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x08
	clr	a
	call	_GPIO_Init
;	src/main.c: 130: GPIO_Init(INPUT1_PORT, INPUT1_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x01
	push	#0x20
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 131: GPIO_Init(INPUT2_PORT, INPUT2_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x01
	push	#0x40
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 134: oled_set_font(FONT_5X7); 
	clr	a
	call	_oled_set_font
;	src/main.c: 135: oled_puts_at(0, 0, "System Ready!");
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
	push	#0x00
	clr	a
	call	_oled_puts_at
;	src/main.c: 136: oled_puts_at(0, 8, "STM8S003F3");
	push	#<(___str_1+0)
	push	#((___str_1+0) >> 8)
	push	#0x08
	clr	a
	call	_oled_puts_at
;	src/main.c: 137: oled_puts_at(0, 16, "OLED Display");
	push	#<(___str_2+0)
	push	#((___str_2+0) >> 8)
	push	#0x10
	clr	a
	call	_oled_puts_at
;	src/main.c: 138: oled_puts_at(0, 24, "_____ADC_____");
	push	#<(___str_3+0)
	push	#((___str_3+0) >> 8)
	push	#0x18
	clr	a
	call	_oled_puts_at
;	src/main.c: 141: uart_write("System Ready!\r\n");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	src/main.c: 143: while(1) 
00115$:
;	src/main.c: 146: adc_raw_pc4 = analog_read_pc4();
	call	_analog_read_pc4
	ldw	(0x51, sp), x
;	src/main.c: 147: adc_raw_pd3 = analog_read_pd3();
	call	_analog_read_pd3
;	src/main.c: 148: sprintf(buffer, "ADC-PC4: %4d | ADC-PD3: %4d \r\n", adc_raw_pc4, adc_raw_pd3);
	pushw	x
	ldw	x, (0x53, sp)
	pushw	x
	push	#<(___str_5+0)
	push	#((___str_5+0) >> 8)
	ldw	x, sp
	addw	x, #7
	pushw	x
	call	_sprintf
	addw	sp, #8
;	src/main.c: 149: uart_write(buffer);  
	ldw	x, sp
	incw	x
	call	_uart_write
;	src/main.c: 152: if((UART1_SR & UART_SR_RXNE))
	btjf	0x5230, #5, 00110$
;	src/main.c: 154: char received = UART1_DR;
	ld	a, 0x5231
;	src/main.c: 156: if(received == '1') 
	cp	a, #0x31
	jrne	00110$
;	src/main.c: 158: uart_write("Received: 1\r\n");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	src/main.c: 159: uart_write(buffer); 
	ldw	x, sp
	incw	x
	call	_uart_write
;	src/main.c: 162: GPIO_WriteLow(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteLow
;	src/main.c: 163: delay_ms(300);
	ldw	x, #0x012c
	call	_delay_ms
;	src/main.c: 164: GPIO_WriteHigh(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteHigh
00110$:
;	src/main.c: 169: if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
	push	#0x20
	ld	a, #0x02
	call	_GPIO_Read
	dec	a
	jrne	00112$
;	src/main.c: 170: GPIO_WriteLow(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteLow
	jra	00113$
00112$:
;	src/main.c: 172: GPIO_WriteHigh(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteHigh
00113$:
;	src/main.c: 175: delay_ms(100);
	ldw	x, #0x0064
	call	_delay_ms
	jra	00115$
;	src/main.c: 177: }
	addw	sp, #82
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "System Ready!"
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "STM8S003F3"
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "OLED Display"
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "_____ADC_____"
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "System Ready!"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "ADC-PC4: %4d | ADC-PD3: %4d "
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_6:
	.ascii "Received: 1"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
