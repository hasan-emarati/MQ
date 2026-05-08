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
	.globl _delay_ms
	.globl _GPIO_Read
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
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
;	src/main.c: 30: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	src/main.c: 33: CLK_ECKR |= CLK_ECKR_HSEEN;
	bset	0x50c1, #0
;	src/main.c: 34: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
00101$:
	btjf	0x50c1, #1, 00101$
;	src/main.c: 35: CLK_SWR = CLK_SWR_HSE;
	mov	0x50c4+0, #0xb4
;	src/main.c: 36: CLK_SWCR |= CLK_SWCR_SWEN;
	bset	0x50c5, #1
;	src/main.c: 37: while(CLK_SWCR & CLK_SWCR_SWBSY);
00104$:
	btjt	0x50c5, #0, 00104$
;	src/main.c: 38: CLK_CKDIVR = 0x00;
	mov	0x50c6+0, #0x00
;	src/main.c: 41: i2c_init(16000000, I2C_SPEED_STANDARD);
	push	#0xa0
	push	#0x86
	push	#0x01
	push	#0x00
	push	#0x00
	push	#0x24
	push	#0xf4
	push	#0x00
	call	_i2c_init
;	src/main.c: 44: uart_init(9600);
	push	#0x80
	push	#0x25
	clrw	x
	pushw	x
	call	_uart_init
;	src/main.c: 47: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x10
	ld	a, #0x03
	call	_GPIO_Init
;	src/main.c: 48: GPIO_Init(RELAY_PORT, RELAY_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x08
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 49: GPIO_Init(TR_PORT, TR_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x08
	clr	a
	call	_GPIO_Init
;	src/main.c: 50: GPIO_Init(INPUT1_PORT, INPUT1_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x01
	push	#0x20
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 51: GPIO_Init(INPUT2_PORT, INPUT2_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x01
	push	#0x40
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 54: delay_ms(200);
	ldw	x, #0x00c8
	call	_delay_ms
;	src/main.c: 55: oled_init();
	call	_oled_init
;	src/main.c: 56: oled_clear();
	call	_oled_clear
;	src/main.c: 59: oled_set_font(FONT_5X7); 
	clr	a
	call	_oled_set_font
;	src/main.c: 60: oled_puts_at(0, 0, "System Ready!");
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
	push	#0x00
	clr	a
	call	_oled_puts_at
;	src/main.c: 61: oled_puts_at(0, 8, "STM8S003F3");
	push	#<(___str_1+0)
	push	#((___str_1+0) >> 8)
	push	#0x08
	clr	a
	call	_oled_puts_at
;	src/main.c: 62: oled_puts_at(0, 16, "OLED Display");
	push	#<(___str_2+0)
	push	#((___str_2+0) >> 8)
	push	#0x10
	clr	a
	call	_oled_puts_at
;	src/main.c: 63: oled_puts_at(0, 24, "I2C Interface");
	push	#<(___str_3+0)
	push	#((___str_3+0) >> 8)
	push	#0x18
	clr	a
	call	_oled_puts_at
;	src/main.c: 66: uart_write("System Ready!\r\n");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	src/main.c: 68: while(1) 
00115$:
;	src/main.c: 71: if((UART1_SR & UART_SR_RXNE)) {
	btjf	0x5230, #5, 00110$
;	src/main.c: 72: char received = UART1_DR;
	ld	a, 0x5231
;	src/main.c: 74: if(received == '1') {
	cp	a, #0x31
	jrne	00110$
;	src/main.c: 75: uart_write("Received: 1\r\n");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	src/main.c: 78: GPIO_WriteLow(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteLow
;	src/main.c: 79: delay_ms(300);
	ldw	x, #0x012c
	call	_delay_ms
;	src/main.c: 80: GPIO_WriteHigh(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteHigh
00110$:
;	src/main.c: 85: if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
	push	#0x20
	ld	a, #0x02
	call	_GPIO_Read
	dec	a
	jrne	00112$
;	src/main.c: 86: GPIO_WriteLow(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteLow
	jra	00113$
00112$:
;	src/main.c: 88: GPIO_WriteHigh(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteHigh
00113$:
;	src/main.c: 91: delay_ms(100);
	ldw	x, #0x0064
	call	_delay_ms
	jra	00115$
;	src/main.c: 93: }
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
	.ascii "I2C Interface"
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
	.ascii "Received: 1"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
