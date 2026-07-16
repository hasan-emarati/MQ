                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module delay
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _delay
                                     11 	.globl _delay_ms
                                     12 	.globl _delay_us
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; absolute external ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DABS (ABS)
                                     25 
                                     26 ; default segment ordering for linker
                                     27 	.area HOME
                                     28 	.area GSINIT
                                     29 	.area GSFINAL
                                     30 	.area CONST
                                     31 	.area INITIALIZER
                                     32 	.area CODE
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; global & static initialisations
                                     36 ;--------------------------------------------------------
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area GSINIT
                                     41 ;--------------------------------------------------------
                                     42 ; Home
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area HOME
                                     46 ;--------------------------------------------------------
                                     47 ; code
                                     48 ;--------------------------------------------------------
                                     49 	.area CODE
                                     50 ;	lib/delay.c: 5: void delay(unsigned long count) {
                                     51 ;	-----------------------------------------
                                     52 ;	 function delay
                                     53 ;	-----------------------------------------
      00848F                         54 _delay:
      00848F 52 04            [ 2]   55 	sub	sp, #4
                                     56 ;	lib/delay.c: 6: while (count--)
      008491 1E 07            [ 2]   57 	ldw	x, (0x07, sp)
      008493                         58 00101$:
      008493 1F 01            [ 2]   59 	ldw	(0x01, sp), x
      008495 7B 09            [ 1]   60 	ld	a, (0x09, sp)
      008497 6B 03            [ 1]   61 	ld	(0x03, sp), a
      008499 7B 0A            [ 1]   62 	ld	a, (0x0a, sp)
      00849B 16 09            [ 2]   63 	ldw	y, (0x09, sp)
      00849D 72 A2 00 01      [ 2]   64 	subw	y, #0x0001
      0084A1 17 09            [ 2]   65 	ldw	(0x09, sp), y
      0084A3 24 01            [ 1]   66 	jrnc	00121$
      0084A5 5A               [ 2]   67 	decw	x
      0084A6                         68 00121$:
      0084A6 4D               [ 1]   69 	tnz	a
      0084A7 26 08            [ 1]   70 	jrne	00122$
      0084A9 16 02            [ 2]   71 	ldw	y, (0x02, sp)
      0084AB 26 04            [ 1]   72 	jrne	00122$
      0084AD 0D 01            [ 1]   73 	tnz	(0x01, sp)
      0084AF 27 03            [ 1]   74 	jreq	00104$
      0084B1                         75 00122$:
                                     76 ;	lib/delay.c: 7: nop();
      0084B1 9D               [ 1]   77 	nop
      0084B2 20 DF            [ 2]   78 	jra	00101$
      0084B4                         79 00104$:
                                     80 ;	lib/delay.c: 8: }
      0084B4 1E 05            [ 2]   81 	ldw	x, (5, sp)
      0084B6 5B 0A            [ 2]   82 	addw	sp, #10
      0084B8 FC               [ 2]   83 	jp	(x)
                                     84 ;	lib/delay.c: 14: void delay_ms(unsigned int ms) {
                                     85 ;	-----------------------------------------
                                     86 ;	 function delay_ms
                                     87 ;	-----------------------------------------
      0084B9                         88 _delay_ms:
      0084B9 89               [ 2]   89 	pushw	x
                                     90 ;	lib/delay.c: 16: for(i = 0; i < ms; i++) {
      0084BA 5F               [ 1]   91 	clrw	x
      0084BB                         92 00107$:
      0084BB 13 01            [ 2]   93 	cpw	x, (0x01, sp)
      0084BD 24 0C            [ 1]   94 	jrnc	00109$
                                     95 ;	lib/delay.c: 17: for(j = 0; j < 2000; j++) {
      0084BF 90 AE 07 D0      [ 2]   96 	ldw	y, #0x07d0
      0084C3                         97 00105$:
                                     98 ;	lib/delay.c: 18: nop();
      0084C3 9D               [ 1]   99 	nop
                                    100 ;	lib/delay.c: 17: for(j = 0; j < 2000; j++) {
      0084C4 90 5A            [ 2]  101 	decw	y
      0084C6 26 FB            [ 1]  102 	jrne	00105$
                                    103 ;	lib/delay.c: 16: for(i = 0; i < ms; i++) {
      0084C8 5C               [ 1]  104 	incw	x
      0084C9 20 F0            [ 2]  105 	jra	00107$
      0084CB                        106 00109$:
                                    107 ;	lib/delay.c: 21: }
      0084CB 5B 02            [ 2]  108 	addw	sp, #2
      0084CD 81               [ 4]  109 	ret
                                    110 ;	lib/delay.c: 27: void delay_us(unsigned int us) {
                                    111 ;	-----------------------------------------
                                    112 ;	 function delay_us
                                    113 ;	-----------------------------------------
      0084CE                        114 _delay_us:
      0084CE 89               [ 2]  115 	pushw	x
                                    116 ;	lib/delay.c: 29: for(i = 0; i < us; i++) {
      0084CF 5F               [ 1]  117 	clrw	x
      0084D0                        118 00107$:
      0084D0 13 01            [ 2]  119 	cpw	x, (0x01, sp)
      0084D2 24 0C            [ 1]  120 	jrnc	00109$
                                    121 ;	lib/delay.c: 30: for(j = 0; j < 2; j++) {
      0084D4 90 AE 00 02      [ 2]  122 	ldw	y, #0x0002
      0084D8                        123 00105$:
                                    124 ;	lib/delay.c: 31: nop();
      0084D8 9D               [ 1]  125 	nop
                                    126 ;	lib/delay.c: 30: for(j = 0; j < 2; j++) {
      0084D9 90 5A            [ 2]  127 	decw	y
      0084DB 26 FB            [ 1]  128 	jrne	00105$
                                    129 ;	lib/delay.c: 29: for(i = 0; i < us; i++) {
      0084DD 5C               [ 1]  130 	incw	x
      0084DE 20 F0            [ 2]  131 	jra	00107$
      0084E0                        132 00109$:
                                    133 ;	lib/delay.c: 34: }
      0084E0 5B 02            [ 2]  134 	addw	sp, #2
      0084E2 81               [ 4]  135 	ret
                                    136 	.area CODE
                                    137 	.area CONST
                                    138 	.area INITIALIZER
                                    139 	.area CABS (ABS)
