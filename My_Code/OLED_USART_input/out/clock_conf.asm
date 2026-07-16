;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module clock_conf
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _clock_init
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
;	lib/clock_conf.c: 4: void clock_init(void)
;	-----------------------------------------
;	 function clock_init
;	-----------------------------------------
_clock_init:
;	lib/clock_conf.c: 6: CLK_ECKR |= CLK_ECKR_HSEEN;
	bset	0x50c1, #0
;	lib/clock_conf.c: 7: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
00101$:
	btjf	0x50c1, #1, 00101$
;	lib/clock_conf.c: 9: CLK_SWR = CLK_SWR_HSE;
	mov	0x50c4+0, #0xb4
;	lib/clock_conf.c: 10: CLK_SWCR |= CLK_SWCR_SWEN;
	bset	0x50c5, #1
;	lib/clock_conf.c: 11: while(CLK_SWCR & CLK_SWCR_SWBSY);
00104$:
	btjt	0x50c5, #0, 00104$
;	lib/clock_conf.c: 13: CLK_CKDIVR = 0x00;
	mov	0x50c6+0, #0x00
;	lib/clock_conf.c: 14: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
