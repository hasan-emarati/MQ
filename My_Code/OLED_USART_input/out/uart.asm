;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module uart
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
	.globl _uart_init
	.globl _uart_write
	.globl _uart_read
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	lib/uart.c: 7: void uart_init(unsigned long baudrate) {
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
	push	a
;	lib/uart.c: 12: uart_div = SYSTEM_CLOCK / (baudrate);
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, (0x06, sp)
	pushw	x
	push	#0x00
	push	#0x24
	push	#0xf4
	push	#0x00
	call	__divulong
	addw	sp, #8
;	lib/uart.c: 15: UART1_CR2 = 0x00;
	mov	0x5235+0, #0x00
;	lib/uart.c: 18: brr1 = (unsigned char)((uart_div >> 4) & 0xFF);
	ldw	y, x
	ld	a, #0x10
	div	y, a
;	lib/uart.c: 19: brr2 = (unsigned char)(((uart_div >> 8) & 0x0F) | (uart_div & 0x0F));
	ld	a, xh
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	and	a, #0x0f
	or	a, (0x01, sp)
;	lib/uart.c: 21: UART1_BRR2 = brr2;
	ld	0x5233, a
;	lib/uart.c: 22: UART1_BRR1 = brr1;
	ldw	x, #0x5232
	ld	a, yl
	ld	(x), a
;	lib/uart.c: 25: UART1_CR1 = 0x00;
	mov	0x5234+0, #0x00
;	lib/uart.c: 26: UART1_CR3 = 0x00;
	mov	0x5236+0, #0x00
;	lib/uart.c: 29: UART1_CR2 = 0x0C;  // Bit3=TEN, Bit2=REN
	mov	0x5235+0, #0x0c
;	lib/uart.c: 30: }
	ldw	x, (2, sp)
	addw	sp, #7
	jp	(x)
;	lib/uart.c: 32: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #5
	ldw	(0x03, sp), x
;	lib/uart.c: 34: for(i = 0; i < strlen(str); i++) {
	clr	(0x05, sp)
00106$:
	ldw	x, (0x03, sp)
	call	_strlen
	ldw	(0x01, sp), x
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
	cpw	x, (0x01, sp)
	jrnc	00104$
;	lib/uart.c: 35: while(!(UART1_SR & UART_SR_TXE));
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	lib/uart.c: 36: UART1_DR = str[i];
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	ld	0x5231, a
;	lib/uart.c: 34: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00106$
00104$:
;	lib/uart.c: 38: return i;
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
;	lib/uart.c: 39: }
	addw	sp, #5
	ret
;	lib/uart.c: 41: char uart_read(void) {
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
;	lib/uart.c: 42: if(UART1_SR & UART_SR_RXNE) {
	btjf	0x5230, #5, 00102$
;	lib/uart.c: 43: return UART1_DR;
	ld	a, 0x5231
	ret
00102$:
;	lib/uart.c: 45: return 0;
	clr	a
;	lib/uart.c: 46: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
