;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module i2c
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _i2c_init
	.globl _i2c_start
	.globl _i2c_stop
	.globl _i2c_write
	.globl _i2c_send_addr
	.globl _i2c_write_data
	.globl _i2c_read_data
	.globl _i2c_reset
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
;	lib/i2c.c: 11: void i2c_init(unsigned long freq_hz, unsigned long speed_hz)
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
	push	a
;	lib/i2c.c: 14: unsigned char freq_mhz = freq_hz / 1000000;
	push	#0x40
	push	#0x42
	push	#0x0f
	push	#0x00
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	call	__divulong
	addw	sp, #8
	ld	a, xl
	ld	(0x01, sp), a
;	lib/i2c.c: 17: CLK_PCKENR1 |= (1 << 0);
	bset	0x50c7, #0
;	lib/i2c.c: 20: I2C_FREQR = freq_mhz;
	ldw	x, #0x5212
	ld	a, (0x01, sp)
	ld	(x), a
;	lib/i2c.c: 23: if(speed_hz <= 100000) {
	ldw	x, #0x86a0
	cpw	x, (0x0a, sp)
	ld	a, #0x01
	sbc	a, (0x09, sp)
	clr	a
	sbc	a, (0x08, sp)
	jrc	00102$
;	lib/i2c.c: 25: ccr_value = (freq_hz / (2 * speed_hz));
	ldw	x, (0x0a, sp)
	ldw	y, (0x08, sp)
	sllw	x
	rlcw	y
	pushw	x
	pushw	y
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	call	__divulong
	addw	sp, #8
	ld	a, xl
;	lib/i2c.c: 26: I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
	ld	0x521b, a
;	lib/i2c.c: 27: I2C_CCRH = 0x00;
	mov	0x521c+0, #0x00
	jra	00103$
00102$:
;	lib/i2c.c: 30: ccr_value = (freq_hz / (3 * speed_hz));
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	push	#0x03
	clrw	x
	pushw	x
	push	#0x00
	call	__mullong
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	call	__divulong
	addw	sp, #8
	ld	a, xl
;	lib/i2c.c: 31: I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
	ld	0x521b, a
;	lib/i2c.c: 32: I2C_CCRH = 0x80;  // Fast mode
	mov	0x521c+0, #0x80
00103$:
;	lib/i2c.c: 36: I2C_TRISER = freq_mhz + 1;
	ld	a, (0x01, sp)
	inc	a
	ld	0x521d, a
;	lib/i2c.c: 39: PB_DDR |= (1 << 4) | (1 << 5);   // Output
	ld	a, 0x5007
	or	a, #0x30
	ld	0x5007, a
;	lib/i2c.c: 40: PB_CR1 |= (1 << 4) | (1 << 5);   // Pull-up enabled
	ld	a, 0x5008
	or	a, #0x30
	ld	0x5008, a
;	lib/i2c.c: 41: PB_CR2 &= ~((1 << 4) | (1 << 5)); // Slow speed
	ld	a, 0x5009
	and	a, #0xcf
	ld	0x5009, a
;	lib/i2c.c: 44: I2C_CR1 |= I2C_PE;
	ld	a, 0x5210
	or	a, #0x01
	ld	0x5210, a
;	lib/i2c.c: 45: }
	ldw	x, (2, sp)
	addw	sp, #11
	jp	(x)
;	lib/i2c.c: 47: void i2c_start(void)
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	lib/i2c.c: 49: I2C_CR2 |= I2C_START;
	bset	0x5211, #0
;	lib/i2c.c: 50: while (!(I2C_SR1 & I2C_SB));
00101$:
	btjf	0x5217, #0, 00101$
;	lib/i2c.c: 51: }
	ret
;	lib/i2c.c: 53: void i2c_stop(void)
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	lib/i2c.c: 55: I2C_CR2 |= I2C_STOP;
	bset	0x5211, #1
;	lib/i2c.c: 56: while (I2C_SR3 & 0x01);  // Wait for MSL bit to clear
00101$:
	btjt	0x5219, #0, 00101$
;	lib/i2c.c: 57: }
	ret
;	lib/i2c.c: 59: void i2c_write(unsigned char data)
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
;	lib/i2c.c: 61: I2C_DR = data;
	ld	0x5216, a
;	lib/i2c.c: 62: while (!(I2C_SR1 & I2C_TXE));
00101$:
	ld	a, 0x5217
	jrpl	00101$
;	lib/i2c.c: 63: }
	ret
;	lib/i2c.c: 65: void i2c_send_addr(unsigned char addr)
;	-----------------------------------------
;	 function i2c_send_addr
;	-----------------------------------------
_i2c_send_addr:
;	lib/i2c.c: 67: i2c_write(addr);
	call	_i2c_write
;	lib/i2c.c: 68: while (!(I2C_SR3 & 0x01));  // Check master mode
00101$:
	btjf	0x5219, #0, 00101$
;	lib/i2c.c: 69: }
	ret
;	lib/i2c.c: 71: unsigned char i2c_write_data(unsigned char addr, unsigned char* data, unsigned char len)
;	-----------------------------------------
;	 function i2c_write_data
;	-----------------------------------------
_i2c_write_data:
	sub	sp, #3
	ldw	(0x01, sp), x
;	lib/i2c.c: 76: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	lib/i2c.c: 77: i2c_send_addr(addr);
	call	_i2c_send_addr
;	lib/i2c.c: 80: for(i = 0; i < len; i++) {
	clr	(0x03, sp)
00106$:
	ld	a, (0x03, sp)
	cp	a, (0x06, sp)
	jrnc	00104$
;	lib/i2c.c: 81: i2c_write(data[i]);
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	call	_i2c_write
;	lib/i2c.c: 82: while (!(I2C_SR1 & I2C_BTF));
00101$:
	btjf	0x5217, #2, 00101$
;	lib/i2c.c: 80: for(i = 0; i < len; i++) {
	inc	(0x03, sp)
	jra	00106$
00104$:
;	lib/i2c.c: 86: i2c_stop();
	call	_i2c_stop
;	lib/i2c.c: 88: return I2C_OK;
	clr	a
;	lib/i2c.c: 89: }
	addw	sp, #3
	popw	x
	addw	sp, #1
	jp	(x)
;	lib/i2c.c: 91: unsigned char i2c_read_data(unsigned char addr, unsigned char* buffer, unsigned char len)
;	-----------------------------------------
;	 function i2c_read_data
;	-----------------------------------------
_i2c_read_data:
	sub	sp, #5
	ldw	(0x03, sp), x
;	lib/i2c.c: 95: if(len == 0) return I2C_OK;
	tnz	(0x08, sp)
	jrne	00102$
	clr	a
	jra	00113$
00102$:
;	lib/i2c.c: 98: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	lib/i2c.c: 99: i2c_send_addr(addr | 0x01);  // Set read bit
	or	a, #0x01
	call	_i2c_send_addr
;	lib/i2c.c: 102: for(i = 0; i < len; i++) {
	clr	(0x05, sp)
00111$:
	ld	a, (0x05, sp)
	cp	a, (0x08, sp)
	jrnc	00109$
;	lib/i2c.c: 103: if(i == (len - 1)) {
	clrw	x
	ld	a, (0x08, sp)
	ld	xl, a
	decw	x
	ldw	(0x01, sp), x
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
;	lib/i2c.c: 105: I2C_CR2 &= ~I2C_ACK;
	ld	a, 0x5211
;	lib/i2c.c: 103: if(i == (len - 1)) {
	cpw	x, (0x01, sp)
	jrne	00104$
;	lib/i2c.c: 105: I2C_CR2 &= ~I2C_ACK;
	and	a, #0xfb
	ld	0x5211, a
	jra	00106$
00104$:
;	lib/i2c.c: 108: I2C_CR2 |= I2C_ACK;
	or	a, #0x04
	ld	0x5211, a
;	lib/i2c.c: 111: while (!(I2C_SR1 & I2C_RXNE));
00106$:
	btjf	0x5217, #6, 00106$
;	lib/i2c.c: 112: buffer[i] = I2C_DR;
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, 0x5216
	ld	(x), a
;	lib/i2c.c: 102: for(i = 0; i < len; i++) {
	inc	(0x05, sp)
	jra	00111$
00109$:
;	lib/i2c.c: 116: i2c_stop();
	call	_i2c_stop
;	lib/i2c.c: 118: return I2C_OK;
	clr	a
00113$:
;	lib/i2c.c: 119: }
	addw	sp, #5
	popw	x
	addw	sp, #1
	jp	(x)
;	lib/i2c.c: 121: void i2c_reset(void)
;	-----------------------------------------
;	 function i2c_reset
;	-----------------------------------------
_i2c_reset:
;	lib/i2c.c: 124: I2C_CR1 &= ~I2C_PE;
	bres	0x5210, #0
;	lib/i2c.c: 127: I2C_CR2 |= I2C_SWRST;
	ld	a, 0x5211
	or	a, #0x80
	ld	0x5211, a
;	lib/i2c.c: 129: for(i = 0; i < 100; i++) nop();
	ldw	x, #0x0064
00104$:
	nop
	decw	x
	jrne	00104$
;	lib/i2c.c: 130: I2C_CR2 &= ~I2C_SWRST;
	bres	0x5211, #7
;	lib/i2c.c: 133: I2C_CR1 |= I2C_PE;
	bset	0x5210, #0
;	lib/i2c.c: 134: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
