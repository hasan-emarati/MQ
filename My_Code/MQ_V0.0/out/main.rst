                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 	.globl _uart_read
                                     12 	.globl _uart_write
                                     13 	.globl _uart_init
                                     14 	.globl _delay
                                     15 	.globl _delay_ms
                                     16 	.globl _GPIO_Read
                                     17 	.globl _GPIO_WriteLow
                                     18 	.globl _GPIO_WriteHigh
                                     19 	.globl _GPIO_Init
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
                                     28 ;--------------------------------------------------------
                                     29 ; Stack segment in internal ram
                                     30 ;--------------------------------------------------------
                                     31 	.area SSEG
      000001                         32 __start__stack:
      000001                         33 	.ds	1
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; absolute external ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area DABS (ABS)
                                     39 
                                     40 ; default segment ordering for linker
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area CONST
                                     45 	.area INITIALIZER
                                     46 	.area CODE
                                     47 
                                     48 ;--------------------------------------------------------
                                     49 ; interrupt vector
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
      008000                         52 __interrupt_vect:
      008000 82 00 80 07             53 	int s_GSINIT ; reset
                                     54 ;--------------------------------------------------------
                                     55 ; global & static initialisations
                                     56 ;--------------------------------------------------------
                                     57 	.area HOME
                                     58 	.area GSINIT
                                     59 	.area GSFINAL
                                     60 	.area GSINIT
      008007 CD 85 4D         [ 4]   61 	call	___sdcc_external_startup
      00800A 4D               [ 1]   62 	tnz	a
      00800B 27 03            [ 1]   63 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   64 	jp	__sdcc_program_startup
      008010                         65 __sdcc_init_data:
                                     66 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   67 	ldw x, #l_DATA
      008013 27 07            [ 1]   68 	jreq	00002$
      008015                         69 00001$:
      008015 72 4F 00 00      [ 1]   70 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   71 	decw x
      00801A 26 F9            [ 1]   72 	jrne	00001$
      00801C                         73 00002$:
      00801C AE 00 00         [ 2]   74 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   75 	jreq	00004$
      008021                         76 00003$:
      008021 D6 80 51         [ 1]   77 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   78 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   79 	decw	x
      008028 26 F7            [ 1]   80 	jrne	00003$
      00802A                         81 00004$:
                                     82 ; stm8_genXINIT() end
                                     83 	.area GSFINAL
      00802A CC 80 04         [ 2]   84 	jp	__sdcc_program_startup
                                     85 ;--------------------------------------------------------
                                     86 ; Home
                                     87 ;--------------------------------------------------------
                                     88 	.area HOME
                                     89 	.area HOME
      008004                         90 __sdcc_program_startup:
      008004 CC 80 52         [ 2]   91 	jp	_main
                                     92 ;	return from main will return to caller
                                     93 ;--------------------------------------------------------
                                     94 ; code
                                     95 ;--------------------------------------------------------
                                     96 	.area CODE
                                     97 ;	src/main.c: 23: int main(void)
                                     98 ;	-----------------------------------------
                                     99 ;	 function main
                                    100 ;	-----------------------------------------
      008052                        101 _main:
                                    102 ;	src/main.c: 26: CLK_ECKR |= CLK_ECKR_HSEEN;
      008052 72 10 50 C1      [ 1]  103 	bset	0x50c1, #0
                                    104 ;	src/main.c: 27: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
      008056                        105 00101$:
      008056 72 03 50 C1 FB   [ 2]  106 	btjf	0x50c1, #1, 00101$
                                    107 ;	src/main.c: 28: CLK_SWR = CLK_SWR_HSE;
      00805B 35 B4 50 C4      [ 1]  108 	mov	0x50c4+0, #0xb4
                                    109 ;	src/main.c: 29: CLK_SWCR |= CLK_SWCR_SWEN;
      00805F 72 12 50 C5      [ 1]  110 	bset	0x50c5, #1
                                    111 ;	src/main.c: 30: while(CLK_SWCR & CLK_SWCR_SWBSY);
      008063                        112 00104$:
      008063 72 00 50 C5 FB   [ 2]  113 	btjt	0x50c5, #0, 00104$
                                    114 ;	src/main.c: 31: CLK_CKDIVR = 0x00; // 16MHz system clock
      008068 35 00 50 C6      [ 1]  115 	mov	0x50c6+0, #0x00
                                    116 ;	src/main.c: 34: uart_init(9600);  
      00806C 4B 80            [ 1]  117 	push	#0x80
      00806E 4B 25            [ 1]  118 	push	#0x25
      008070 5F               [ 1]  119 	clrw	x
      008071 89               [ 2]  120 	pushw	x
      008072 CD 84 7A         [ 4]  121 	call	_uart_init
                                    122 ;	src/main.c: 37: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      008075 4B 00            [ 1]  123 	push	#0x00
      008077 4B 02            [ 1]  124 	push	#0x02
      008079 4B 10            [ 1]  125 	push	#0x10
      00807B A6 03            [ 1]  126 	ld	a, #0x03
      00807D CD 81 67         [ 4]  127 	call	_GPIO_Init
                                    128 ;	src/main.c: 38: GPIO_Init(RELAY_PORT, RELAY_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      008080 4B 00            [ 1]  129 	push	#0x00
      008082 4B 02            [ 1]  130 	push	#0x02
      008084 4B 08            [ 1]  131 	push	#0x08
      008086 A6 02            [ 1]  132 	ld	a, #0x02
      008088 CD 81 67         [ 4]  133 	call	_GPIO_Init
                                    134 ;	src/main.c: 39: GPIO_Init(TR_PORT, TR_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      00808B 4B 00            [ 1]  135 	push	#0x00
      00808D 4B 02            [ 1]  136 	push	#0x02
      00808F 4B 08            [ 1]  137 	push	#0x08
      008091 4F               [ 1]  138 	clr	a
      008092 CD 81 67         [ 4]  139 	call	_GPIO_Init
                                    140 ;	src/main.c: 40: GPIO_Init(INPUT1_PORT, INPUT1_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
      008095 4B 00            [ 1]  141 	push	#0x00
      008097 4B 01            [ 1]  142 	push	#0x01
      008099 4B 20            [ 1]  143 	push	#0x20
      00809B A6 02            [ 1]  144 	ld	a, #0x02
      00809D CD 81 67         [ 4]  145 	call	_GPIO_Init
                                    146 ;	src/main.c: 41: GPIO_Init(INPUT2_PORT, INPUT2_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
      0080A0 4B 00            [ 1]  147 	push	#0x00
      0080A2 4B 01            [ 1]  148 	push	#0x01
      0080A4 4B 40            [ 1]  149 	push	#0x40
      0080A6 A6 02            [ 1]  150 	ld	a, #0x02
      0080A8 CD 81 67         [ 4]  151 	call	_GPIO_Init
                                    152 ;	src/main.c: 44: uart_write("System Ready!\r\n");
      0080AB AE 80 2D         [ 2]  153 	ldw	x, #(___str_0+0)
      0080AE CD 84 B7         [ 4]  154 	call	_uart_write
                                    155 ;	src/main.c: 46: while(1) 
      0080B1                        156 00113$:
                                    157 ;	src/main.c: 49: char received = uart_read();
      0080B1 CD 84 E7         [ 4]  158 	call	_uart_read
                                    159 ;	src/main.c: 51: if(received == '1') {
      0080B4 A1 31            [ 1]  160 	cp	a, #0x31
      0080B6 26 1A            [ 1]  161 	jrne	00108$
                                    162 ;	src/main.c: 52: uart_write("Received number 1!\r\n");
      0080B8 AE 80 3D         [ 2]  163 	ldw	x, #(___str_1+0)
      0080BB CD 84 B7         [ 4]  164 	call	_uart_write
                                    165 ;	src/main.c: 54: GPIO_WriteLow(LED_PORT, LED_PIN);
      0080BE 4B 10            [ 1]  166 	push	#0x10
      0080C0 A6 03            [ 1]  167 	ld	a, #0x03
      0080C2 CD 83 9B         [ 4]  168 	call	_GPIO_WriteLow
                                    169 ;	src/main.c: 55: delay_ms(500);  // Using delay from delay.h
      0080C5 AE 01 F4         [ 2]  170 	ldw	x, #0x01f4
      0080C8 CD 81 3D         [ 4]  171 	call	_delay_ms
                                    172 ;	src/main.c: 56: GPIO_WriteHigh(LED_PORT, LED_PIN);
      0080CB 4B 10            [ 1]  173 	push	#0x10
      0080CD A6 03            [ 1]  174 	ld	a, #0x03
      0080CF CD 83 60         [ 4]  175 	call	_GPIO_WriteHigh
      0080D2                        176 00108$:
                                    177 ;	src/main.c: 60: if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
      0080D2 4B 20            [ 1]  178 	push	#0x20
      0080D4 A6 02            [ 1]  179 	ld	a, #0x02
      0080D6 CD 84 1A         [ 4]  180 	call	_GPIO_Read
      0080D9 4A               [ 1]  181 	dec	a
      0080DA 26 09            [ 1]  182 	jrne	00110$
                                    183 ;	src/main.c: 61: GPIO_WriteLow(LED_PORT, LED_PIN); // LED ON
      0080DC 4B 10            [ 1]  184 	push	#0x10
      0080DE A6 03            [ 1]  185 	ld	a, #0x03
      0080E0 CD 83 9B         [ 4]  186 	call	_GPIO_WriteLow
      0080E3 20 07            [ 2]  187 	jra	00111$
      0080E5                        188 00110$:
                                    189 ;	src/main.c: 63: GPIO_WriteHigh(LED_PORT, LED_PIN); // LED OFF
      0080E5 4B 10            [ 1]  190 	push	#0x10
      0080E7 A6 03            [ 1]  191 	ld	a, #0x03
      0080E9 CD 83 60         [ 4]  192 	call	_GPIO_WriteHigh
      0080EC                        193 00111$:
                                    194 ;	src/main.c: 66: delay(10000);  // Using delay from delay.h
      0080EC 4B 10            [ 1]  195 	push	#0x10
      0080EE 4B 27            [ 1]  196 	push	#0x27
      0080F0 5F               [ 1]  197 	clrw	x
      0080F1 89               [ 2]  198 	pushw	x
      0080F2 CD 81 13         [ 4]  199 	call	_delay
      0080F5 20 BA            [ 2]  200 	jra	00113$
                                    201 ;	src/main.c: 68: }
      0080F7 81               [ 4]  202 	ret
                                    203 	.area CODE
                                    204 	.area CONST
                                    205 	.area CONST
      00802D                        206 ___str_0:
      00802D 53 79 73 74 65 6D 20   207 	.ascii "System Ready!"
             52 65 61 64 79 21
      00803A 0D                     208 	.db 0x0d
      00803B 0A                     209 	.db 0x0a
      00803C 00                     210 	.db 0x00
                                    211 	.area CODE
                                    212 	.area CONST
      00803D                        213 ___str_1:
      00803D 52 65 63 65 69 76 65   214 	.ascii "Received number 1!"
             64 20 6E 75 6D 62 65
             72 20 31 21
      00804F 0D                     215 	.db 0x0d
      008050 0A                     216 	.db 0x0a
      008051 00                     217 	.db 0x00
                                    218 	.area CODE
                                    219 	.area INITIALIZER
                                    220 	.area CABS (ABS)
