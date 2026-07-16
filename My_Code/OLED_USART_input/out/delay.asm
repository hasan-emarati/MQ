;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module delay
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _delay
	.globl _delay_ms
	.globl _delay_us
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
;	lib/delay.c: 5: void delay(unsigned long count) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #4
;	lib/delay.c: 6: while (count--)
	ldw	x, (0x07, sp)
00101$:
	ldw	(0x01, sp), x
	ld	a, (0x09, sp)
	ld	(0x03, sp), a
	ld	a, (0x0a, sp)
	ldw	y, (0x09, sp)
	subw	y, #0x0001
	ldw	(0x09, sp), y
	jrnc	00121$
	decw	x
00121$:
	tnz	a
	jrne	00122$
	ldw	y, (0x02, sp)
	jrne	00122$
	tnz	(0x01, sp)
	jreq	00104$
00122$:
;	lib/delay.c: 7: nop();
	nop
	jra	00101$
00104$:
;	lib/delay.c: 8: }
	ldw	x, (5, sp)
	addw	sp, #10
	jp	(x)
;	lib/delay.c: 14: void delay_ms(unsigned int ms) {
;	-----------------------------------------
;	 function delay_ms
;	-----------------------------------------
_delay_ms:
	pushw	x
;	lib/delay.c: 16: for(i = 0; i < ms; i++) {
	clrw	x
00107$:
	cpw	x, (0x01, sp)
	jrnc	00109$
;	lib/delay.c: 17: for(j = 0; j < 2000; j++) {
	ldw	y, #0x07d0
00105$:
;	lib/delay.c: 18: nop();
	nop
;	lib/delay.c: 17: for(j = 0; j < 2000; j++) {
	decw	y
	jrne	00105$
;	lib/delay.c: 16: for(i = 0; i < ms; i++) {
	incw	x
	jra	00107$
00109$:
;	lib/delay.c: 21: }
	addw	sp, #2
	ret
;	lib/delay.c: 27: void delay_us(unsigned int us) {
;	-----------------------------------------
;	 function delay_us
;	-----------------------------------------
_delay_us:
	pushw	x
;	lib/delay.c: 29: for(i = 0; i < us; i++) {
	clrw	x
00107$:
	cpw	x, (0x01, sp)
	jrnc	00109$
;	lib/delay.c: 30: for(j = 0; j < 2; j++) {
	ldw	y, #0x0002
00105$:
;	lib/delay.c: 31: nop();
	nop
;	lib/delay.c: 30: for(j = 0; j < 2; j++) {
	decw	y
	jrne	00105$
;	lib/delay.c: 29: for(i = 0; i < us; i++) {
	incw	x
	jra	00107$
00109$:
;	lib/delay.c: 34: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
