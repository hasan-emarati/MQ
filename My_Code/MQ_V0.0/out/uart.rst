                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module uart
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _strlen
                                     11 	.globl _uart_init
                                     12 	.globl _uart_write
                                     13 	.globl _uart_read
                                     14 ;--------------------------------------------------------
                                     15 ; ram data
                                     16 ;--------------------------------------------------------
                                     17 	.area DATA
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area INITIALIZED
                                     22 ;--------------------------------------------------------
                                     23 ; absolute external ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DABS (ABS)
                                     26 
                                     27 ; default segment ordering for linker
                                     28 	.area HOME
                                     29 	.area GSINIT
                                     30 	.area GSFINAL
                                     31 	.area CONST
                                     32 	.area INITIALIZER
                                     33 	.area CODE
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; global & static initialisations
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area GSINIT
                                     42 ;--------------------------------------------------------
                                     43 ; Home
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area HOME
                                     47 ;--------------------------------------------------------
                                     48 ; code
                                     49 ;--------------------------------------------------------
                                     50 	.area CODE
                                     51 ;	lib/uart.c: 6: void uart_init(unsigned long baudrate) {
                                     52 ;	-----------------------------------------
                                     53 ;	 function uart_init
                                     54 ;	-----------------------------------------
      00847A                         55 _uart_init:
      00847A 88               [ 1]   56 	push	a
                                     57 ;	lib/uart.c: 10: uart_div = SYSTEM_CLOCK / baudrate;
      00847B 1E 06            [ 2]   58 	ldw	x, (0x06, sp)
      00847D 89               [ 2]   59 	pushw	x
      00847E 1E 06            [ 2]   60 	ldw	x, (0x06, sp)
      008480 89               [ 2]   61 	pushw	x
      008481 4B 00            [ 1]   62 	push	#0x00
      008483 4B 24            [ 1]   63 	push	#0x24
      008485 4B F4            [ 1]   64 	push	#0xf4
      008487 4B 00            [ 1]   65 	push	#0x00
      008489 CD 84 F2         [ 4]   66 	call	__divulong
      00848C 5B 08            [ 2]   67 	addw	sp, #8
                                     68 ;	lib/uart.c: 13: UART1_CR2 = 0x00;
      00848E 35 00 52 35      [ 1]   69 	mov	0x5235+0, #0x00
                                     70 ;	lib/uart.c: 18: UART1_BRR2 = ((uart_div >> 8) & 0x0F) | (uart_div & 0x0F);
      008492 9E               [ 1]   71 	ld	a, xh
      008493 A4 0F            [ 1]   72 	and	a, #0x0f
      008495 6B 01            [ 1]   73 	ld	(0x01, sp), a
      008497 9F               [ 1]   74 	ld	a, xl
      008498 A4 0F            [ 1]   75 	and	a, #0x0f
      00849A 1A 01            [ 1]   76 	or	a, (0x01, sp)
      00849C C7 52 33         [ 1]   77 	ld	0x5233, a
                                     78 ;	lib/uart.c: 19: UART1_BRR1 = (uart_div >> 4) & 0xFF;
      00849F A6 10            [ 1]   79 	ld	a, #0x10
      0084A1 62               [ 2]   80 	div	x, a
      0084A2 9F               [ 1]   81 	ld	a, xl
      0084A3 C7 52 32         [ 1]   82 	ld	0x5232, a
                                     83 ;	lib/uart.c: 22: UART1_CR1 = 0x00;
      0084A6 35 00 52 34      [ 1]   84 	mov	0x5234+0, #0x00
                                     85 ;	lib/uart.c: 23: UART1_CR3 = 0x00;
      0084AA 35 00 52 36      [ 1]   86 	mov	0x5236+0, #0x00
                                     87 ;	lib/uart.c: 26: UART1_CR2 = 0x0C;  // Bit3=TEN, Bit2=REN
      0084AE 35 0C 52 35      [ 1]   88 	mov	0x5235+0, #0x0c
                                     89 ;	lib/uart.c: 27: }
      0084B2 1E 02            [ 2]   90 	ldw	x, (2, sp)
      0084B4 5B 07            [ 2]   91 	addw	sp, #7
      0084B6 FC               [ 2]   92 	jp	(x)
                                     93 ;	lib/uart.c: 29: int uart_write(const char *str) {
                                     94 ;	-----------------------------------------
                                     95 ;	 function uart_write
                                     96 ;	-----------------------------------------
      0084B7                         97 _uart_write:
      0084B7 52 05            [ 2]   98 	sub	sp, #5
      0084B9 1F 03            [ 2]   99 	ldw	(0x03, sp), x
                                    100 ;	lib/uart.c: 31: for(i = 0; i < strlen(str); i++) {
      0084BB 0F 05            [ 1]  101 	clr	(0x05, sp)
      0084BD                        102 00106$:
      0084BD 1E 03            [ 2]  103 	ldw	x, (0x03, sp)
      0084BF CD 85 4F         [ 4]  104 	call	_strlen
      0084C2 1F 01            [ 2]  105 	ldw	(0x01, sp), x
      0084C4 7B 05            [ 1]  106 	ld	a, (0x05, sp)
      0084C6 5F               [ 1]  107 	clrw	x
      0084C7 97               [ 1]  108 	ld	xl, a
      0084C8 13 01            [ 2]  109 	cpw	x, (0x01, sp)
      0084CA 24 14            [ 1]  110 	jrnc	00104$
                                    111 ;	lib/uart.c: 32: while(!(UART1_SR & UART_SR_TXE));
      0084CC                        112 00101$:
      0084CC C6 52 30         [ 1]  113 	ld	a, 0x5230
      0084CF 2A FB            [ 1]  114 	jrpl	00101$
                                    115 ;	lib/uart.c: 33: UART1_DR = str[i];
      0084D1 5F               [ 1]  116 	clrw	x
      0084D2 7B 05            [ 1]  117 	ld	a, (0x05, sp)
      0084D4 97               [ 1]  118 	ld	xl, a
      0084D5 72 FB 03         [ 2]  119 	addw	x, (0x03, sp)
      0084D8 F6               [ 1]  120 	ld	a, (x)
      0084D9 C7 52 31         [ 1]  121 	ld	0x5231, a
                                    122 ;	lib/uart.c: 31: for(i = 0; i < strlen(str); i++) {
      0084DC 0C 05            [ 1]  123 	inc	(0x05, sp)
      0084DE 20 DD            [ 2]  124 	jra	00106$
      0084E0                        125 00104$:
                                    126 ;	lib/uart.c: 35: return i;
      0084E0 5F               [ 1]  127 	clrw	x
      0084E1 7B 05            [ 1]  128 	ld	a, (0x05, sp)
      0084E3 97               [ 1]  129 	ld	xl, a
                                    130 ;	lib/uart.c: 36: }
      0084E4 5B 05            [ 2]  131 	addw	sp, #5
      0084E6 81               [ 4]  132 	ret
                                    133 ;	lib/uart.c: 38: char uart_read(void) {
                                    134 ;	-----------------------------------------
                                    135 ;	 function uart_read
                                    136 ;	-----------------------------------------
      0084E7                        137 _uart_read:
                                    138 ;	lib/uart.c: 39: if(UART1_SR & UART_SR_RXNE) {
      0084E7 72 0B 52 30 04   [ 2]  139 	btjf	0x5230, #5, 00102$
                                    140 ;	lib/uart.c: 40: return UART1_DR;
      0084EC C6 52 31         [ 1]  141 	ld	a, 0x5231
      0084EF 81               [ 4]  142 	ret
      0084F0                        143 00102$:
                                    144 ;	lib/uart.c: 42: return 0;
      0084F0 4F               [ 1]  145 	clr	a
                                    146 ;	lib/uart.c: 43: }
      0084F1 81               [ 4]  147 	ret
                                    148 	.area CODE
                                    149 	.area CONST
                                    150 	.area INITIALIZER
                                    151 	.area CABS (ABS)
