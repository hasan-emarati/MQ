;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _uart_read
	.globl _uart_write
	.globl _uart_init
	.globl _delay
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
;	src/main.c: 23: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	src/main.c: 26: CLK_ECKR |= CLK_ECKR_HSEEN;
	bset	0x50c1, #0
;	src/main.c: 27: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
00101$:
	btjf	0x50c1, #1, 00101$
;	src/main.c: 28: CLK_SWR = CLK_SWR_HSE;
	mov	0x50c4+0, #0xb4
;	src/main.c: 29: CLK_SWCR |= CLK_SWCR_SWEN;
	bset	0x50c5, #1
;	src/main.c: 30: while(CLK_SWCR & CLK_SWCR_SWBSY);
00104$:
	btjt	0x50c5, #0, 00104$
;	src/main.c: 31: CLK_CKDIVR = 0x00; // 16MHz system clock
	mov	0x50c6+0, #0x00
;	src/main.c: 34: uart_init(9600);  
	push	#0x80
	push	#0x25
	clrw	x
	pushw	x
	call	_uart_init
;	src/main.c: 37: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x10
	ld	a, #0x03
	call	_GPIO_Init
;	src/main.c: 38: GPIO_Init(RELAY_PORT, RELAY_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x08
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 39: GPIO_Init(TR_PORT, TR_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x02
	push	#0x08
	clr	a
	call	_GPIO_Init
;	src/main.c: 40: GPIO_Init(INPUT1_PORT, INPUT1_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x01
	push	#0x20
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 41: GPIO_Init(INPUT2_PORT, INPUT2_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
	push	#0x00
	push	#0x01
	push	#0x40
	ld	a, #0x02
	call	_GPIO_Init
;	src/main.c: 44: uart_write("System Ready!\r\n");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	src/main.c: 46: while(1) 
00113$:
;	src/main.c: 49: char received = uart_read();
	call	_uart_read
;	src/main.c: 51: if(received == '1') {
	cp	a, #0x31
	jrne	00108$
;	src/main.c: 52: uart_write("Received number 1!\r\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	src/main.c: 54: GPIO_WriteLow(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteLow
;	src/main.c: 55: delay_ms(500);  // Using delay from delay.h
	ldw	x, #0x01f4
	call	_delay_ms
;	src/main.c: 56: GPIO_WriteHigh(LED_PORT, LED_PIN);
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteHigh
00108$:
;	src/main.c: 60: if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
	push	#0x20
	ld	a, #0x02
	call	_GPIO_Read
	dec	a
	jrne	00110$
;	src/main.c: 61: GPIO_WriteLow(LED_PORT, LED_PIN); // LED ON
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteLow
	jra	00111$
00110$:
;	src/main.c: 63: GPIO_WriteHigh(LED_PORT, LED_PIN); // LED OFF
	push	#0x10
	ld	a, #0x03
	call	_GPIO_WriteHigh
00111$:
;	src/main.c: 66: delay(10000);  // Using delay from delay.h
	push	#0x10
	push	#0x27
	clrw	x
	pushw	x
	call	_delay
	jra	00113$
;	src/main.c: 68: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "System Ready!"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "Received number 1!"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
