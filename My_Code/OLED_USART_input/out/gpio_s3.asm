;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module gpio_s3
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _GPIO_Init
	.globl _GPIO_WriteHigh
	.globl _GPIO_WriteLow
	.globl _GPIO_Toggle
	.globl _GPIO_Read
	.globl _GPIO_Write
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
;	lib/gpio_s3.c: 3: void GPIO_Init(uint8_t port, uint8_t pin, GPIO_Mode mode, GPIO_Speed speed)
;	-----------------------------------------
;	 function GPIO_Init
;	-----------------------------------------
_GPIO_Init:
	sub	sp, #10
;	lib/gpio_s3.c: 7: switch(port) {
	ld	xl, a
	jrne	00294$
	inc	a
	ld	(0x01, sp), a
	.byte 0xc5
00294$:
	clr	(0x01, sp)
00295$:
	ld	a, xl
	dec	a
	jrne	00297$
	ld	a, #0x01
	ld	(0x02, sp), a
	.byte 0xc5
00297$:
	clr	(0x02, sp)
00298$:
	ld	a, xl
	sub	a, #0x02
	jrne	00300$
	inc	a
	ld	(0x03, sp), a
	.byte 0xc5
00300$:
	clr	(0x03, sp)
00301$:
	ld	a, xl
	cp	a, #0x03
	jrne	00303$
	ld	a, #0x01
	ld	(0x04, sp), a
	.byte 0xc5
00303$:
	clr	(0x04, sp)
00304$:
	tnz	(0x01, sp)
	jrne	00101$
	tnz	(0x02, sp)
	jrne	00102$
	tnz	(0x03, sp)
	jrne	00103$
	tnz	(0x04, sp)
	jrne	00104$
	jp	00137$
;	lib/gpio_s3.c: 8: case GPIO_PORT_PA:
00101$:
;	lib/gpio_s3.c: 9: ddr = &PA_DDR;
	ldw	x, #0x5002
	ldw	(0x05, sp), x
;	lib/gpio_s3.c: 10: cr1 = &PA_CR1;
	ldw	x, #0x5003
	ldw	(0x07, sp), x
;	lib/gpio_s3.c: 11: cr2 = &PA_CR2;
	ldw	x, #0x5004
;	lib/gpio_s3.c: 12: break;
	jra	00106$
;	lib/gpio_s3.c: 13: case GPIO_PORT_PB:
00102$:
;	lib/gpio_s3.c: 14: ddr = &PB_DDR;
	ldw	x, #0x5007
	ldw	(0x05, sp), x
;	lib/gpio_s3.c: 15: cr1 = &PB_CR1;
	ldw	x, #0x5008
	ldw	(0x07, sp), x
;	lib/gpio_s3.c: 16: cr2 = &PB_CR2;
	ldw	x, #0x5009
;	lib/gpio_s3.c: 17: break;
	jra	00106$
;	lib/gpio_s3.c: 18: case GPIO_PORT_PC:
00103$:
;	lib/gpio_s3.c: 19: ddr = &PC_DDR;
	ldw	x, #0x500c
	ldw	(0x05, sp), x
;	lib/gpio_s3.c: 20: cr1 = &PC_CR1;
	ldw	x, #0x500d
	ldw	(0x07, sp), x
;	lib/gpio_s3.c: 21: cr2 = &PC_CR2;
	ldw	x, #0x500e
;	lib/gpio_s3.c: 22: break;
	jra	00106$
;	lib/gpio_s3.c: 23: case GPIO_PORT_PD:
00104$:
;	lib/gpio_s3.c: 24: ddr = &PD_DDR;
	ldw	x, #0x5011
	ldw	(0x05, sp), x
;	lib/gpio_s3.c: 25: cr1 = &PD_CR1;
	ldw	x, #0x5012
	ldw	(0x07, sp), x
;	lib/gpio_s3.c: 26: cr2 = &PD_CR2;
	ldw	x, #0x5013
;	lib/gpio_s3.c: 27: break;
;	lib/gpio_s3.c: 28: default:
;	lib/gpio_s3.c: 29: return;
;	lib/gpio_s3.c: 30: }
00106$:
;	lib/gpio_s3.c: 33: *cr2 |= pin;
	ld	a, (x)
;	lib/gpio_s3.c: 35: *cr2 &= ~pin;
	push	a
	ld	a, (0x0e, sp)
	cpl	a
	ld	(0x0a, sp), a
	pop	a
;	lib/gpio_s3.c: 32: if(speed == GPIO_SPEED_FAST) {
	tnz	(0x0f, sp)
	jreq	00108$
;	lib/gpio_s3.c: 33: *cr2 |= pin;
	or	a, (0x0d, sp)
	ld	(x), a
	jra	00109$
00108$:
;	lib/gpio_s3.c: 35: *cr2 &= ~pin;
	and	a, (0x09, sp)
	ld	(x), a
00109$:
;	lib/gpio_s3.c: 38: switch(mode) {
	ld	a, (0x0e, sp)
	cp	a, #0x05
	jrule	00310$
	jp	00137$
00310$:
;	lib/gpio_s3.c: 40: *ddr &= ~pin;
	ldw	x, (0x05, sp)
	ld	a, (x)
	push	a
	and	a, (0x0a, sp)
	ld	(0x0b, sp), a
	pop	a
;	lib/gpio_s3.c: 48: *ddr |= pin;
	or	a, (0x0d, sp)
;	lib/gpio_s3.c: 38: switch(mode) {
	clrw	x
	exg	a, xl
	ld	a, (0x0e, sp)
	exg	a, xl
	sllw	x
	ldw	x, (#00311$, x)
	jp	(x)
00311$:
	.dw	#00110$
	.dw	#00111$
	.dw	#00112$
	.dw	#00118$
	.dw	#00124$
	.dw	#00130$
;	lib/gpio_s3.c: 39: case GPIO_MODE_INPUT_FLOATING:
00110$:
;	lib/gpio_s3.c: 40: *ddr &= ~pin;
	ldw	x, (0x05, sp)
	ld	a, (0x0a, sp)
	ld	(x), a
;	lib/gpio_s3.c: 41: *cr1 &= ~pin;
	ldw	x, (0x07, sp)
	ld	a, (x)
	and	a, (0x09, sp)
	ldw	x, (0x07, sp)
	ld	(x), a
;	lib/gpio_s3.c: 42: break;
	jp	00137$
;	lib/gpio_s3.c: 43: case GPIO_MODE_INPUT_PULL_UP:
00111$:
;	lib/gpio_s3.c: 44: *ddr &= ~pin;
	ldw	x, (0x05, sp)
	ld	a, (0x0a, sp)
	ld	(x), a
;	lib/gpio_s3.c: 45: *cr1 |= pin;
	ldw	x, (0x07, sp)
	ld	a, (x)
	or	a, (0x0d, sp)
	ldw	x, (0x07, sp)
	ld	(x), a
;	lib/gpio_s3.c: 46: break;
	jp	00137$
;	lib/gpio_s3.c: 47: case GPIO_MODE_OUTPUT_PUSH_PULL_LOW:
00112$:
;	lib/gpio_s3.c: 48: *ddr |= pin;
	ldw	x, (0x05, sp)
	ld	(x), a
;	lib/gpio_s3.c: 49: *cr1 |= pin;
	ldw	x, (0x07, sp)
	ld	a, (x)
	or	a, (0x0d, sp)
	ldw	x, (0x07, sp)
	ld	(x), a
;	lib/gpio_s3.c: 50: switch(port) {
	tnz	(0x01, sp)
	jrne	00113$
	tnz	(0x02, sp)
	jrne	00114$
	tnz	(0x03, sp)
	jrne	00115$
	tnz	(0x04, sp)
	jrne	00116$
	jp	00137$
;	lib/gpio_s3.c: 51: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
00113$:
	ld	a, 0x5000
	and	a, (0x09, sp)
	ld	0x5000, a
	jp	00137$
;	lib/gpio_s3.c: 52: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
00114$:
	ld	a, 0x5005
	and	a, (0x09, sp)
	ld	0x5005, a
	jp	00137$
;	lib/gpio_s3.c: 53: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
00115$:
	ld	a, 0x500a
	and	a, (0x09, sp)
	ld	0x500a, a
	jp	00137$
;	lib/gpio_s3.c: 54: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
00116$:
	ld	a, 0x500f
	and	a, (0x09, sp)
	ld	0x500f, a
;	lib/gpio_s3.c: 56: break;
	jp	00137$
;	lib/gpio_s3.c: 57: case GPIO_MODE_OUTPUT_PUSH_PULL_HIGH:
00118$:
;	lib/gpio_s3.c: 58: *ddr |= pin;
	ldw	x, (0x05, sp)
	ld	(x), a
;	lib/gpio_s3.c: 59: *cr1 |= pin;
	ldw	x, (0x07, sp)
	ld	a, (x)
	or	a, (0x0d, sp)
	ldw	x, (0x07, sp)
	ld	(x), a
;	lib/gpio_s3.c: 60: switch(port) {
	tnz	(0x01, sp)
	jrne	00119$
	tnz	(0x02, sp)
	jrne	00120$
	tnz	(0x03, sp)
	jrne	00121$
	tnz	(0x04, sp)
	jrne	00122$
	jp	00137$
;	lib/gpio_s3.c: 61: case GPIO_PORT_PA: PA_ODR |= pin; break;
00119$:
	ld	a, 0x5000
	or	a, (0x0d, sp)
	ld	0x5000, a
	jp	00137$
;	lib/gpio_s3.c: 62: case GPIO_PORT_PB: PB_ODR |= pin; break;
00120$:
	ld	a, 0x5005
	or	a, (0x0d, sp)
	ld	0x5005, a
	jp	00137$
;	lib/gpio_s3.c: 63: case GPIO_PORT_PC: PC_ODR |= pin; break;
00121$:
	ld	a, 0x500a
	or	a, (0x0d, sp)
	ld	0x500a, a
	jp	00137$
;	lib/gpio_s3.c: 64: case GPIO_PORT_PD: PD_ODR |= pin; break;
00122$:
	ld	a, 0x500f
	or	a, (0x0d, sp)
	ld	0x500f, a
;	lib/gpio_s3.c: 66: break;
	jp	00137$
;	lib/gpio_s3.c: 67: case GPIO_MODE_OUTPUT_OPEN_DRAIN_LOW:
00124$:
;	lib/gpio_s3.c: 68: *ddr |= pin;
	ldw	x, (0x05, sp)
	ld	(x), a
;	lib/gpio_s3.c: 69: *cr1 &= ~pin;
	ldw	x, (0x07, sp)
	ld	a, (x)
	and	a, (0x09, sp)
	ldw	x, (0x07, sp)
	ld	(x), a
;	lib/gpio_s3.c: 70: switch(port) {
	tnz	(0x01, sp)
	jrne	00125$
	tnz	(0x02, sp)
	jrne	00126$
	tnz	(0x03, sp)
	jrne	00127$
	tnz	(0x04, sp)
	jrne	00128$
	jra	00137$
;	lib/gpio_s3.c: 71: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
00125$:
	ld	a, 0x5000
	and	a, (0x09, sp)
	ld	0x5000, a
	jra	00137$
;	lib/gpio_s3.c: 72: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
00126$:
	ld	a, 0x5005
	and	a, (0x09, sp)
	ld	0x5005, a
	jra	00137$
;	lib/gpio_s3.c: 73: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
00127$:
	ld	a, 0x500a
	and	a, (0x09, sp)
	ld	0x500a, a
	jra	00137$
;	lib/gpio_s3.c: 74: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
00128$:
	ld	a, 0x500f
	and	a, (0x09, sp)
	ld	0x500f, a
;	lib/gpio_s3.c: 76: break;
	jra	00137$
;	lib/gpio_s3.c: 77: case GPIO_MODE_OUTPUT_OPEN_DRAIN_HIGH:
00130$:
;	lib/gpio_s3.c: 78: *ddr |= pin;
	ldw	x, (0x05, sp)
	ld	(x), a
;	lib/gpio_s3.c: 79: *cr1 &= ~pin;
	ldw	x, (0x07, sp)
	ld	a, (x)
	and	a, (0x09, sp)
	ldw	x, (0x07, sp)
	ld	(x), a
;	lib/gpio_s3.c: 80: switch(port) {
	tnz	(0x01, sp)
	jrne	00131$
	tnz	(0x02, sp)
	jrne	00132$
	tnz	(0x03, sp)
	jrne	00133$
	tnz	(0x04, sp)
	jrne	00134$
	jra	00137$
;	lib/gpio_s3.c: 81: case GPIO_PORT_PA: PA_ODR |= pin; break;
00131$:
	ld	a, 0x5000
	or	a, (0x0d, sp)
	ld	0x5000, a
	jra	00137$
;	lib/gpio_s3.c: 82: case GPIO_PORT_PB: PB_ODR |= pin; break;
00132$:
	ld	a, 0x5005
	or	a, (0x0d, sp)
	ld	0x5005, a
	jra	00137$
;	lib/gpio_s3.c: 83: case GPIO_PORT_PC: PC_ODR |= pin; break;
00133$:
	ld	a, 0x500a
	or	a, (0x0d, sp)
	ld	0x500a, a
	jra	00137$
;	lib/gpio_s3.c: 84: case GPIO_PORT_PD: PD_ODR |= pin; break;
00134$:
	ld	a, 0x500f
	or	a, (0x0d, sp)
	ld	0x500f, a
;	lib/gpio_s3.c: 87: }
00137$:
;	lib/gpio_s3.c: 88: }
	ldw	x, (11, sp)
	addw	sp, #15
	jp	(x)
;	lib/gpio_s3.c: 90: void GPIO_WriteHigh(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function GPIO_WriteHigh
;	-----------------------------------------
_GPIO_WriteHigh:
;	lib/gpio_s3.c: 92: switch(port) {
	cp	a, #0x00
	jreq	00101$
	cp	a, #0x01
	jreq	00102$
	cp	a, #0x02
	jreq	00103$
	cp	a, #0x03
	jreq	00104$
	jra	00106$
;	lib/gpio_s3.c: 93: case GPIO_PORT_PA: PA_ODR |= pin; break;
00101$:
	ld	a, 0x5000
	or	a, (0x03, sp)
	ld	0x5000, a
	jra	00106$
;	lib/gpio_s3.c: 94: case GPIO_PORT_PB: PB_ODR |= pin; break;
00102$:
	ld	a, 0x5005
	or	a, (0x03, sp)
	ld	0x5005, a
	jra	00106$
;	lib/gpio_s3.c: 95: case GPIO_PORT_PC: PC_ODR |= pin; break;
00103$:
	ld	a, 0x500a
	or	a, (0x03, sp)
	ld	0x500a, a
	jra	00106$
;	lib/gpio_s3.c: 96: case GPIO_PORT_PD: PD_ODR |= pin; break;
00104$:
	ld	a, 0x500f
	or	a, (0x03, sp)
	ld	0x500f, a
;	lib/gpio_s3.c: 97: }
00106$:
;	lib/gpio_s3.c: 98: }
	popw	x
	pop	a
	jp	(x)
;	lib/gpio_s3.c: 100: void GPIO_WriteLow(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function GPIO_WriteLow
;	-----------------------------------------
_GPIO_WriteLow:
	push	a
;	lib/gpio_s3.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
	push	a
	ld	a, (0x05, sp)
	cpl	a
	ld	(0x02, sp), a
	pop	a
;	lib/gpio_s3.c: 102: switch(port) {
	cp	a, #0x00
	jreq	00101$
	cp	a, #0x01
	jreq	00102$
	cp	a, #0x02
	jreq	00103$
	cp	a, #0x03
	jreq	00104$
	jra	00106$
;	lib/gpio_s3.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
00101$:
	ld	a, 0x5000
	and	a, (0x01, sp)
	ld	0x5000, a
	jra	00106$
;	lib/gpio_s3.c: 104: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
00102$:
	ld	a, 0x5005
	and	a, (0x01, sp)
	ld	0x5005, a
	jra	00106$
;	lib/gpio_s3.c: 105: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
00103$:
	ld	a, 0x500a
	and	a, (0x01, sp)
	ld	0x500a, a
	jra	00106$
;	lib/gpio_s3.c: 106: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
00104$:
	ld	a, 0x500f
	and	a, (0x01, sp)
	ld	0x500f, a
;	lib/gpio_s3.c: 107: }
00106$:
;	lib/gpio_s3.c: 108: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	lib/gpio_s3.c: 110: void GPIO_Toggle(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function GPIO_Toggle
;	-----------------------------------------
_GPIO_Toggle:
;	lib/gpio_s3.c: 112: switch(port) {
	cp	a, #0x00
	jreq	00101$
	cp	a, #0x01
	jreq	00102$
	cp	a, #0x02
	jreq	00103$
	cp	a, #0x03
	jreq	00104$
	jra	00106$
;	lib/gpio_s3.c: 113: case GPIO_PORT_PA: PA_ODR ^= pin; break;
00101$:
	ld	a, 0x5000
	xor	a, (0x03, sp)
	ld	0x5000, a
	jra	00106$
;	lib/gpio_s3.c: 114: case GPIO_PORT_PB: PB_ODR ^= pin; break;
00102$:
	ld	a, 0x5005
	xor	a, (0x03, sp)
	ld	0x5005, a
	jra	00106$
;	lib/gpio_s3.c: 115: case GPIO_PORT_PC: PC_ODR ^= pin; break;
00103$:
	ld	a, 0x500a
	xor	a, (0x03, sp)
	ld	0x500a, a
	jra	00106$
;	lib/gpio_s3.c: 116: case GPIO_PORT_PD: PD_ODR ^= pin; break;
00104$:
	ld	a, 0x500f
	xor	a, (0x03, sp)
	ld	0x500f, a
;	lib/gpio_s3.c: 117: }
00106$:
;	lib/gpio_s3.c: 118: }
	popw	x
	pop	a
	jp	(x)
;	lib/gpio_s3.c: 120: uint8_t GPIO_Read(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function GPIO_Read
;	-----------------------------------------
_GPIO_Read:
;	lib/gpio_s3.c: 122: switch(port) {
	cp	a, #0x00
	jreq	00101$
	cp	a, #0x01
	jreq	00102$
	cp	a, #0x02
	jreq	00103$
	cp	a, #0x03
	jreq	00104$
	jra	00105$
;	lib/gpio_s3.c: 123: case GPIO_PORT_PA: return ((PA_IDR & pin) != 0);
00101$:
	ld	a, 0x5001
	and	a, (0x03, sp)
	sub	a, #0x01
	clr	a
	ccf
	rlc	a
	jra	00107$
;	lib/gpio_s3.c: 124: case GPIO_PORT_PB: return ((PB_IDR & pin) != 0);
00102$:
	ld	a, 0x5006
	and	a, (0x03, sp)
	sub	a, #0x01
	clr	a
	ccf
	rlc	a
	jra	00107$
;	lib/gpio_s3.c: 125: case GPIO_PORT_PC: return ((PC_IDR & pin) != 0);
00103$:
	ld	a, 0x500b
	and	a, (0x03, sp)
	sub	a, #0x01
	clr	a
	ccf
	rlc	a
	jra	00107$
;	lib/gpio_s3.c: 126: case GPIO_PORT_PD: return ((PD_IDR & pin) != 0);
00104$:
	ld	a, 0x5010
	and	a, (0x03, sp)
	sub	a, #0x01
	clr	a
	ccf
	rlc	a
;	lib/gpio_s3.c: 127: default: return 0;
;	lib/gpio_s3.c: 128: }
	.byte 0x21
00105$:
	clr	a
00107$:
;	lib/gpio_s3.c: 129: }
	popw	x
	addw	sp, #1
	jp	(x)
;	lib/gpio_s3.c: 131: void GPIO_Write(uint8_t port, uint8_t pin, uint8_t state)
;	-----------------------------------------
;	 function GPIO_Write
;	-----------------------------------------
_GPIO_Write:
	ld	xl, a
;	lib/gpio_s3.c: 133: if(state) {
	tnz	(0x04, sp)
	jreq	00102$
;	lib/gpio_s3.c: 134: GPIO_WriteHigh(port, pin);
	ld	a, (0x03, sp)
	push	a
	ld	a, xl
	call	_GPIO_WriteHigh
	jra	00104$
00102$:
;	lib/gpio_s3.c: 136: GPIO_WriteLow(port, pin);
	ld	a, (0x03, sp)
	push	a
	ld	a, xl
	call	_GPIO_WriteLow
00104$:
;	lib/gpio_s3.c: 138: }
	ldw	x, (1, sp)
	addw	sp, #4
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
