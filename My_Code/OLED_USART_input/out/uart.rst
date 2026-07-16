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
      008DD0                         55 _uart_init:
      008DD0 88               [ 1]   56 	push	a
                                     57 ;	lib/uart.c: 12: uart_div = SYSTEM_CLOCK / (baudrate);
      008DD1 1E 06            [ 2]   58 	ldw	x, (0x06, sp)
      008DD3 89               [ 2]   59 	pushw	x
      008DD4 1E 06            [ 2]   60 	ldw	x, (0x06, sp)
      008DD6 89               [ 2]   61 	pushw	x
      008DD7 4B 00            [ 1]   62 	push	#0x00
      008DD9 4B 24            [ 1]   63 	push	#0x24
      008DDB 4B F4            [ 1]   64 	push	#0xf4
      008DDD 4B 00            [ 1]   65 	push	#0x00
      008DDF CD 8E 4D         [ 4]   66 	call	__divulong
      008DE2 5B 08            [ 2]   67 	addw	sp, #8
                                     68 ;	lib/uart.c: 15: UART1_CR2 = 0x00;
      008DE4 35 00 52 35      [ 1]   69 	mov	0x5235+0, #0x00
                                     70 ;	lib/uart.c: 18: brr1 = (unsigned char)((uart_div >> 4) & 0xFF);
      008DE8 90 93            [ 1]   71 	ldw	y, x
      008DEA A6 10            [ 1]   72 	ld	a, #0x10
      008DEC 90 62            [ 2]   73 	div	y, a
                                     74 ;	lib/uart.c: 19: brr2 = (unsigned char)(((uart_div >> 8) & 0x0F) | (uart_div & 0x0F));
      008DEE 9E               [ 1]   75 	ld	a, xh
      008DEF A4 0F            [ 1]   76 	and	a, #0x0f
      008DF1 6B 01            [ 1]   77 	ld	(0x01, sp), a
      008DF3 9F               [ 1]   78 	ld	a, xl
      008DF4 A4 0F            [ 1]   79 	and	a, #0x0f
      008DF6 1A 01            [ 1]   80 	or	a, (0x01, sp)
                                     81 ;	lib/uart.c: 21: UART1_BRR2 = brr2;
      008DF8 C7 52 33         [ 1]   82 	ld	0x5233, a
                                     83 ;	lib/uart.c: 22: UART1_BRR1 = brr1;
      008DFB AE 52 32         [ 2]   84 	ldw	x, #0x5232
      008DFE 90 9F            [ 1]   85 	ld	a, yl
      008E00 F7               [ 1]   86 	ld	(x), a
                                     87 ;	lib/uart.c: 25: UART1_CR1 = 0x00;
      008E01 35 00 52 34      [ 1]   88 	mov	0x5234+0, #0x00
                                     89 ;	lib/uart.c: 26: UART1_CR3 = 0x00;
      008E05 35 00 52 36      [ 1]   90 	mov	0x5236+0, #0x00
                                     91 ;	lib/uart.c: 29: UART1_CR2 = 0x0C;  // Bit3=TEN, Bit2=REN
      008E09 35 0C 52 35      [ 1]   92 	mov	0x5235+0, #0x0c
                                     93 ;	lib/uart.c: 30: }
      008E0D 1E 02            [ 2]   94 	ldw	x, (2, sp)
      008E0F 5B 07            [ 2]   95 	addw	sp, #7
      008E11 FC               [ 2]   96 	jp	(x)
                                     97 ;	lib/uart.c: 32: int uart_write(const char *str) {
                                     98 ;	-----------------------------------------
                                     99 ;	 function uart_write
                                    100 ;	-----------------------------------------
      008E12                        101 _uart_write:
      008E12 52 05            [ 2]  102 	sub	sp, #5
      008E14 1F 03            [ 2]  103 	ldw	(0x03, sp), x
                                    104 ;	lib/uart.c: 34: for(i = 0; i < strlen(str); i++) {
      008E16 0F 05            [ 1]  105 	clr	(0x05, sp)
      008E18                        106 00106$:
      008E18 1E 03            [ 2]  107 	ldw	x, (0x03, sp)
      008E1A CD 8E AA         [ 4]  108 	call	_strlen
      008E1D 1F 01            [ 2]  109 	ldw	(0x01, sp), x
      008E1F 7B 05            [ 1]  110 	ld	a, (0x05, sp)
      008E21 5F               [ 1]  111 	clrw	x
      008E22 97               [ 1]  112 	ld	xl, a
      008E23 13 01            [ 2]  113 	cpw	x, (0x01, sp)
      008E25 24 14            [ 1]  114 	jrnc	00104$
                                    115 ;	lib/uart.c: 35: while(!(UART1_SR & UART_SR_TXE));
      008E27                        116 00101$:
      008E27 C6 52 30         [ 1]  117 	ld	a, 0x5230
      008E2A 2A FB            [ 1]  118 	jrpl	00101$
                                    119 ;	lib/uart.c: 36: UART1_DR = str[i];
      008E2C 5F               [ 1]  120 	clrw	x
      008E2D 7B 05            [ 1]  121 	ld	a, (0x05, sp)
      008E2F 97               [ 1]  122 	ld	xl, a
      008E30 72 FB 03         [ 2]  123 	addw	x, (0x03, sp)
      008E33 F6               [ 1]  124 	ld	a, (x)
      008E34 C7 52 31         [ 1]  125 	ld	0x5231, a
                                    126 ;	lib/uart.c: 34: for(i = 0; i < strlen(str); i++) {
      008E37 0C 05            [ 1]  127 	inc	(0x05, sp)
      008E39 20 DD            [ 2]  128 	jra	00106$
      008E3B                        129 00104$:
                                    130 ;	lib/uart.c: 38: return i;
      008E3B 5F               [ 1]  131 	clrw	x
      008E3C 7B 05            [ 1]  132 	ld	a, (0x05, sp)
      008E3E 97               [ 1]  133 	ld	xl, a
                                    134 ;	lib/uart.c: 39: }
      008E3F 5B 05            [ 2]  135 	addw	sp, #5
      008E41 81               [ 4]  136 	ret
                                    137 ;	lib/uart.c: 41: char uart_read(void) {
                                    138 ;	-----------------------------------------
                                    139 ;	 function uart_read
                                    140 ;	-----------------------------------------
      008E42                        141 _uart_read:
                                    142 ;	lib/uart.c: 42: if(UART1_SR & UART_SR_RXNE) {
      008E42 72 0B 52 30 04   [ 2]  143 	btjf	0x5230, #5, 00102$
                                    144 ;	lib/uart.c: 43: return UART1_DR;
      008E47 C6 52 31         [ 1]  145 	ld	a, 0x5231
      008E4A 81               [ 4]  146 	ret
      008E4B                        147 00102$:
                                    148 ;	lib/uart.c: 45: return 0;
      008E4B 4F               [ 1]  149 	clr	a
                                    150 ;	lib/uart.c: 46: }
      008E4C 81               [ 4]  151 	ret
                                    152 	.area CODE
                                    153 	.area CONST
                                    154 	.area INITIALIZER
                                    155 	.area CABS (ABS)
