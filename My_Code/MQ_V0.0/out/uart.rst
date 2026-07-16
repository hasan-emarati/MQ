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
                                     51 ;	lib/uart.c: 7: void uart_init(unsigned long baudrate) {
                                     52 ;	-----------------------------------------
                                     53 ;	 function uart_init
                                     54 ;	-----------------------------------------
      008E8F                         55 _uart_init:
      008E8F 88               [ 1]   56 	push	a
                                     57 ;	lib/uart.c: 12: uart_div = SYSTEM_CLOCK / (baudrate);
      008E90 1E 06            [ 2]   58 	ldw	x, (0x06, sp)
      008E92 89               [ 2]   59 	pushw	x
      008E93 1E 06            [ 2]   60 	ldw	x, (0x06, sp)
      008E95 89               [ 2]   61 	pushw	x
      008E96 4B 00            [ 1]   62 	push	#0x00
      008E98 4B 24            [ 1]   63 	push	#0x24
      008E9A 4B F4            [ 1]   64 	push	#0xf4
      008E9C 4B 00            [ 1]   65 	push	#0x00
      008E9E CD 8F 50         [ 4]   66 	call	__divulong
      008EA1 5B 08            [ 2]   67 	addw	sp, #8
                                     68 ;	lib/uart.c: 15: UART1_CR2 = 0x00;
      008EA3 35 00 52 35      [ 1]   69 	mov	0x5235+0, #0x00
                                     70 ;	lib/uart.c: 18: brr1 = (unsigned char)((uart_div >> 4) & 0xFF);
      008EA7 90 93            [ 1]   71 	ldw	y, x
      008EA9 A6 10            [ 1]   72 	ld	a, #0x10
      008EAB 90 62            [ 2]   73 	div	y, a
                                     74 ;	lib/uart.c: 19: brr2 = (unsigned char)(((uart_div >> 8) & 0x0F) | (uart_div & 0x0F));
      008EAD 9E               [ 1]   75 	ld	a, xh
      008EAE A4 0F            [ 1]   76 	and	a, #0x0f
      008EB0 6B 01            [ 1]   77 	ld	(0x01, sp), a
      008EB2 9F               [ 1]   78 	ld	a, xl
      008EB3 A4 0F            [ 1]   79 	and	a, #0x0f
      008EB5 1A 01            [ 1]   80 	or	a, (0x01, sp)
                                     81 ;	lib/uart.c: 21: UART1_BRR2 = brr2;
      008EB7 C7 52 33         [ 1]   82 	ld	0x5233, a
                                     83 ;	lib/uart.c: 22: UART1_BRR1 = brr1;
      008EBA AE 52 32         [ 2]   84 	ldw	x, #0x5232
      008EBD 90 9F            [ 1]   85 	ld	a, yl
      008EBF F7               [ 1]   86 	ld	(x), a
                                     87 ;	lib/uart.c: 25: UART1_CR1 = 0x00;
      008EC0 35 00 52 34      [ 1]   88 	mov	0x5234+0, #0x00
                                     89 ;	lib/uart.c: 26: UART1_CR3 = 0x00;
      008EC4 35 00 52 36      [ 1]   90 	mov	0x5236+0, #0x00
                                     91 ;	lib/uart.c: 29: UART1_CR2 = 0x0C;  // Bit3=TEN, Bit2=REN
      008EC8 35 0C 52 35      [ 1]   92 	mov	0x5235+0, #0x0c
                                     93 ;	lib/uart.c: 30: }
      008ECC 1E 02            [ 2]   94 	ldw	x, (2, sp)
      008ECE 5B 07            [ 2]   95 	addw	sp, #7
      008ED0 FC               [ 2]   96 	jp	(x)
                                     97 ;	lib/uart.c: 32: int uart_write(const char *str) {
                                     98 ;	-----------------------------------------
                                     99 ;	 function uart_write
                                    100 ;	-----------------------------------------
      008ED1                        101 _uart_write:
      008ED1 52 05            [ 2]  102 	sub	sp, #5
      008ED3 1F 03            [ 2]  103 	ldw	(0x03, sp), x
                                    104 ;	lib/uart.c: 34: for(i = 0; i < strlen(str); i++) {
      008ED5 0F 05            [ 1]  105 	clr	(0x05, sp)
      008ED7                        106 00106$:
      008ED7 1E 03            [ 2]  107 	ldw	x, (0x03, sp)
      008ED9 CD 8F AD         [ 4]  108 	call	_strlen
      008EDC 1F 01            [ 2]  109 	ldw	(0x01, sp), x
      008EDE 7B 05            [ 1]  110 	ld	a, (0x05, sp)
      008EE0 5F               [ 1]  111 	clrw	x
      008EE1 97               [ 1]  112 	ld	xl, a
      008EE2 13 01            [ 2]  113 	cpw	x, (0x01, sp)
      008EE4 24 14            [ 1]  114 	jrnc	00104$
                                    115 ;	lib/uart.c: 35: while(!(UART1_SR & UART_SR_TXE));
      008EE6                        116 00101$:
      008EE6 C6 52 30         [ 1]  117 	ld	a, 0x5230
      008EE9 2A FB            [ 1]  118 	jrpl	00101$
                                    119 ;	lib/uart.c: 36: UART1_DR = str[i];
      008EEB 5F               [ 1]  120 	clrw	x
      008EEC 7B 05            [ 1]  121 	ld	a, (0x05, sp)
      008EEE 97               [ 1]  122 	ld	xl, a
      008EEF 72 FB 03         [ 2]  123 	addw	x, (0x03, sp)
      008EF2 F6               [ 1]  124 	ld	a, (x)
      008EF3 C7 52 31         [ 1]  125 	ld	0x5231, a
                                    126 ;	lib/uart.c: 34: for(i = 0; i < strlen(str); i++) {
      008EF6 0C 05            [ 1]  127 	inc	(0x05, sp)
      008EF8 20 DD            [ 2]  128 	jra	00106$
      008EFA                        129 00104$:
                                    130 ;	lib/uart.c: 38: return i;
      008EFA 5F               [ 1]  131 	clrw	x
      008EFB 7B 05            [ 1]  132 	ld	a, (0x05, sp)
      008EFD 97               [ 1]  133 	ld	xl, a
                                    134 ;	lib/uart.c: 39: }
      008EFE 5B 05            [ 2]  135 	addw	sp, #5
      008F00 81               [ 4]  136 	ret
                                    137 ;	lib/uart.c: 41: char uart_read(void) {
                                    138 ;	-----------------------------------------
                                    139 ;	 function uart_read
                                    140 ;	-----------------------------------------
      008F01                        141 _uart_read:
                                    142 ;	lib/uart.c: 42: if(UART1_SR & UART_SR_RXNE) {
      008F01 72 0B 52 30 04   [ 2]  143 	btjf	0x5230, #5, 00102$
                                    144 ;	lib/uart.c: 43: return UART1_DR;
      008F06 C6 52 31         [ 1]  145 	ld	a, 0x5231
      008F09 81               [ 4]  146 	ret
      008F0A                        147 00102$:
                                    148 ;	lib/uart.c: 45: return 0;
      008F0A 4F               [ 1]  149 	clr	a
                                    150 ;	lib/uart.c: 46: }
      008F0B 81               [ 4]  151 	ret
                                    152 	.area CODE
                                    153 	.area CONST
                                    154 	.area INITIALIZER
                                    155 	.area CABS (ABS)
