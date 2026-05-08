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
                                     11 	.globl _oled_set_font
                                     12 	.globl _oled_puts_at
                                     13 	.globl _oled_clear
                                     14 	.globl _oled_init
                                     15 	.globl _i2c_init
                                     16 	.globl _uart_write
                                     17 	.globl _uart_init
                                     18 	.globl _delay_ms
                                     19 	.globl _GPIO_Read
                                     20 	.globl _GPIO_WriteLow
                                     21 	.globl _GPIO_WriteHigh
                                     22 	.globl _GPIO_Init
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area INITIALIZED
                                     31 ;--------------------------------------------------------
                                     32 ; Stack segment in internal ram
                                     33 ;--------------------------------------------------------
                                     34 	.area SSEG
      000204                         35 __start__stack:
      000204                         36 	.ds	1
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; absolute external ram data
                                     40 ;--------------------------------------------------------
                                     41 	.area DABS (ABS)
                                     42 
                                     43 ; default segment ordering for linker
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area CONST
                                     48 	.area INITIALIZER
                                     49 	.area CODE
                                     50 
                                     51 ;--------------------------------------------------------
                                     52 ; interrupt vector
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
      008000                         55 __interrupt_vect:
      008000 82 00 80 07             56 	int s_GSINIT ; reset
                                     57 ;--------------------------------------------------------
                                     58 ; global & static initialisations
                                     59 ;--------------------------------------------------------
                                     60 	.area HOME
                                     61 	.area GSINIT
                                     62 	.area GSFINAL
                                     63 	.area GSINIT
      008007 CD 8E A3         [ 4]   64 	call	___sdcc_external_startup
      00800A 4D               [ 1]   65 	tnz	a
      00800B 27 03            [ 1]   66 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   67 	jp	__sdcc_program_startup
      008010                         68 __sdcc_init_data:
                                     69 ; stm8_genXINIT() start
      008010 AE 02 00         [ 2]   70 	ldw x, #l_DATA
      008013 27 07            [ 1]   71 	jreq	00002$
      008015                         72 00001$:
      008015 72 4F 00 00      [ 1]   73 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   74 	decw x
      00801A 26 F9            [ 1]   75 	jrne	00001$
      00801C                         76 00002$:
      00801C AE 00 03         [ 2]   77 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   78 	jreq	00004$
      008021                         79 00003$:
      008021 D6 82 BE         [ 1]   80 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 02 00         [ 1]   81 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   82 	decw	x
      008028 26 F7            [ 1]   83 	jrne	00003$
      00802A                         84 00004$:
                                     85 ; stm8_genXINIT() end
                                     86 	.area GSFINAL
      00802A CC 80 04         [ 2]   87 	jp	__sdcc_program_startup
                                     88 ;--------------------------------------------------------
                                     89 ; Home
                                     90 ;--------------------------------------------------------
                                     91 	.area HOME
                                     92 	.area HOME
      008004                         93 __sdcc_program_startup:
      008004 CC 82 C2         [ 2]   94 	jp	_main
                                     95 ;	return from main will return to caller
                                     96 ;--------------------------------------------------------
                                     97 ; code
                                     98 ;--------------------------------------------------------
                                     99 	.area CODE
                                    100 ;	src/main.c: 30: int main(void)
                                    101 ;	-----------------------------------------
                                    102 ;	 function main
                                    103 ;	-----------------------------------------
      0082C2                        104 _main:
                                    105 ;	src/main.c: 33: CLK_ECKR |= CLK_ECKR_HSEEN;
      0082C2 72 10 50 C1      [ 1]  106 	bset	0x50c1, #0
                                    107 ;	src/main.c: 34: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
      0082C6                        108 00101$:
      0082C6 72 03 50 C1 FB   [ 2]  109 	btjf	0x50c1, #1, 00101$
                                    110 ;	src/main.c: 35: CLK_SWR = CLK_SWR_HSE;
      0082CB 35 B4 50 C4      [ 1]  111 	mov	0x50c4+0, #0xb4
                                    112 ;	src/main.c: 36: CLK_SWCR |= CLK_SWCR_SWEN;
      0082CF 72 12 50 C5      [ 1]  113 	bset	0x50c5, #1
                                    114 ;	src/main.c: 37: while(CLK_SWCR & CLK_SWCR_SWBSY);
      0082D3                        115 00104$:
      0082D3 72 00 50 C5 FB   [ 2]  116 	btjt	0x50c5, #0, 00104$
                                    117 ;	src/main.c: 38: CLK_CKDIVR = 0x00;
      0082D8 35 00 50 C6      [ 1]  118 	mov	0x50c6+0, #0x00
                                    119 ;	src/main.c: 41: i2c_init(16000000, I2C_SPEED_STANDARD);
      0082DC 4B A0            [ 1]  120 	push	#0xa0
      0082DE 4B 86            [ 1]  121 	push	#0x86
      0082E0 4B 01            [ 1]  122 	push	#0x01
      0082E2 4B 00            [ 1]  123 	push	#0x00
      0082E4 4B 00            [ 1]  124 	push	#0x00
      0082E6 4B 24            [ 1]  125 	push	#0x24
      0082E8 4B F4            [ 1]  126 	push	#0xf4
      0082EA 4B 00            [ 1]  127 	push	#0x00
      0082EC CD 87 37         [ 4]  128 	call	_i2c_init
                                    129 ;	src/main.c: 44: uart_init(9600);
      0082EF 4B 80            [ 1]  130 	push	#0x80
      0082F1 4B 25            [ 1]  131 	push	#0x25
      0082F3 5F               [ 1]  132 	clrw	x
      0082F4 89               [ 2]  133 	pushw	x
      0082F5 CD 8D D0         [ 4]  134 	call	_uart_init
                                    135 ;	src/main.c: 47: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      0082F8 4B 00            [ 1]  136 	push	#0x00
      0082FA 4B 02            [ 1]  137 	push	#0x02
      0082FC 4B 10            [ 1]  138 	push	#0x10
      0082FE A6 03            [ 1]  139 	ld	a, #0x03
      008300 CD 84 24         [ 4]  140 	call	_GPIO_Init
                                    141 ;	src/main.c: 48: GPIO_Init(RELAY_PORT, RELAY_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      008303 4B 00            [ 1]  142 	push	#0x00
      008305 4B 02            [ 1]  143 	push	#0x02
      008307 4B 08            [ 1]  144 	push	#0x08
      008309 A6 02            [ 1]  145 	ld	a, #0x02
      00830B CD 84 24         [ 4]  146 	call	_GPIO_Init
                                    147 ;	src/main.c: 49: GPIO_Init(TR_PORT, TR_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      00830E 4B 00            [ 1]  148 	push	#0x00
      008310 4B 02            [ 1]  149 	push	#0x02
      008312 4B 08            [ 1]  150 	push	#0x08
      008314 4F               [ 1]  151 	clr	a
      008315 CD 84 24         [ 4]  152 	call	_GPIO_Init
                                    153 ;	src/main.c: 50: GPIO_Init(INPUT1_PORT, INPUT1_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
      008318 4B 00            [ 1]  154 	push	#0x00
      00831A 4B 01            [ 1]  155 	push	#0x01
      00831C 4B 20            [ 1]  156 	push	#0x20
      00831E A6 02            [ 1]  157 	ld	a, #0x02
      008320 CD 84 24         [ 4]  158 	call	_GPIO_Init
                                    159 ;	src/main.c: 51: GPIO_Init(INPUT2_PORT, INPUT2_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
      008323 4B 00            [ 1]  160 	push	#0x00
      008325 4B 01            [ 1]  161 	push	#0x01
      008327 4B 40            [ 1]  162 	push	#0x40
      008329 A6 02            [ 1]  163 	ld	a, #0x02
      00832B CD 84 24         [ 4]  164 	call	_GPIO_Init
                                    165 ;	src/main.c: 54: delay_ms(200);
      00832E AE 00 C8         [ 2]  166 	ldw	x, #0x00c8
      008331 CD 83 FA         [ 4]  167 	call	_delay_ms
                                    168 ;	src/main.c: 55: oled_init();
      008334 CD 89 3F         [ 4]  169 	call	_oled_init
                                    170 ;	src/main.c: 56: oled_clear();
      008337 CD 89 B8         [ 4]  171 	call	_oled_clear
                                    172 ;	src/main.c: 59: oled_set_font(FONT_5X7); 
      00833A 4F               [ 1]  173 	clr	a
      00833B CD 8C B1         [ 4]  174 	call	_oled_set_font
                                    175 ;	src/main.c: 60: oled_puts_at(0, 0, "System Ready!");
      00833E 4B 2D            [ 1]  176 	push	#<(___str_0+0)
      008340 4B 80            [ 1]  177 	push	#((___str_0+0) >> 8)
      008342 4B 00            [ 1]  178 	push	#0x00
      008344 4F               [ 1]  179 	clr	a
      008345 CD 8C 9E         [ 4]  180 	call	_oled_puts_at
                                    181 ;	src/main.c: 61: oled_puts_at(0, 8, "STM8S003F3");
      008348 4B 3B            [ 1]  182 	push	#<(___str_1+0)
      00834A 4B 80            [ 1]  183 	push	#((___str_1+0) >> 8)
      00834C 4B 08            [ 1]  184 	push	#0x08
      00834E 4F               [ 1]  185 	clr	a
      00834F CD 8C 9E         [ 4]  186 	call	_oled_puts_at
                                    187 ;	src/main.c: 62: oled_puts_at(0, 16, "OLED Display");
      008352 4B 46            [ 1]  188 	push	#<(___str_2+0)
      008354 4B 80            [ 1]  189 	push	#((___str_2+0) >> 8)
      008356 4B 10            [ 1]  190 	push	#0x10
      008358 4F               [ 1]  191 	clr	a
      008359 CD 8C 9E         [ 4]  192 	call	_oled_puts_at
                                    193 ;	src/main.c: 63: oled_puts_at(0, 24, "I2C Interface");
      00835C 4B 53            [ 1]  194 	push	#<(___str_3+0)
      00835E 4B 80            [ 1]  195 	push	#((___str_3+0) >> 8)
      008360 4B 18            [ 1]  196 	push	#0x18
      008362 4F               [ 1]  197 	clr	a
      008363 CD 8C 9E         [ 4]  198 	call	_oled_puts_at
                                    199 ;	src/main.c: 66: uart_write("System Ready!\r\n");
      008366 AE 80 61         [ 2]  200 	ldw	x, #(___str_4+0)
      008369 CD 8E 0D         [ 4]  201 	call	_uart_write
                                    202 ;	src/main.c: 68: while(1) 
      00836C                        203 00115$:
                                    204 ;	src/main.c: 71: if((UART1_SR & UART_SR_RXNE)) {
      00836C 72 0B 52 30 21   [ 2]  205 	btjf	0x5230, #5, 00110$
                                    206 ;	src/main.c: 72: char received = UART1_DR;
      008371 C6 52 31         [ 1]  207 	ld	a, 0x5231
                                    208 ;	src/main.c: 74: if(received == '1') {
      008374 A1 31            [ 1]  209 	cp	a, #0x31
      008376 26 1A            [ 1]  210 	jrne	00110$
                                    211 ;	src/main.c: 75: uart_write("Received: 1\r\n");
      008378 AE 80 71         [ 2]  212 	ldw	x, #(___str_5+0)
      00837B CD 8E 0D         [ 4]  213 	call	_uart_write
                                    214 ;	src/main.c: 78: GPIO_WriteLow(LED_PORT, LED_PIN);
      00837E 4B 10            [ 1]  215 	push	#0x10
      008380 A6 03            [ 1]  216 	ld	a, #0x03
      008382 CD 86 58         [ 4]  217 	call	_GPIO_WriteLow
                                    218 ;	src/main.c: 79: delay_ms(300);
      008385 AE 01 2C         [ 2]  219 	ldw	x, #0x012c
      008388 CD 83 FA         [ 4]  220 	call	_delay_ms
                                    221 ;	src/main.c: 80: GPIO_WriteHigh(LED_PORT, LED_PIN);
      00838B 4B 10            [ 1]  222 	push	#0x10
      00838D A6 03            [ 1]  223 	ld	a, #0x03
      00838F CD 86 1D         [ 4]  224 	call	_GPIO_WriteHigh
      008392                        225 00110$:
                                    226 ;	src/main.c: 85: if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
      008392 4B 20            [ 1]  227 	push	#0x20
      008394 A6 02            [ 1]  228 	ld	a, #0x02
      008396 CD 86 D7         [ 4]  229 	call	_GPIO_Read
      008399 4A               [ 1]  230 	dec	a
      00839A 26 09            [ 1]  231 	jrne	00112$
                                    232 ;	src/main.c: 86: GPIO_WriteLow(LED_PORT, LED_PIN);
      00839C 4B 10            [ 1]  233 	push	#0x10
      00839E A6 03            [ 1]  234 	ld	a, #0x03
      0083A0 CD 86 58         [ 4]  235 	call	_GPIO_WriteLow
      0083A3 20 07            [ 2]  236 	jra	00113$
      0083A5                        237 00112$:
                                    238 ;	src/main.c: 88: GPIO_WriteHigh(LED_PORT, LED_PIN);
      0083A5 4B 10            [ 1]  239 	push	#0x10
      0083A7 A6 03            [ 1]  240 	ld	a, #0x03
      0083A9 CD 86 1D         [ 4]  241 	call	_GPIO_WriteHigh
      0083AC                        242 00113$:
                                    243 ;	src/main.c: 91: delay_ms(100);
      0083AC AE 00 64         [ 2]  244 	ldw	x, #0x0064
      0083AF CD 83 FA         [ 4]  245 	call	_delay_ms
      0083B2 20 B8            [ 2]  246 	jra	00115$
                                    247 ;	src/main.c: 93: }
      0083B4 81               [ 4]  248 	ret
                                    249 	.area CODE
                                    250 	.area CONST
                                    251 	.area CONST
      00802D                        252 ___str_0:
      00802D 53 79 73 74 65 6D 20   253 	.ascii "System Ready!"
             52 65 61 64 79 21
      00803A 00                     254 	.db 0x00
                                    255 	.area CODE
                                    256 	.area CONST
      00803B                        257 ___str_1:
      00803B 53 54 4D 38 53 30 30   258 	.ascii "STM8S003F3"
             33 46 33
      008045 00                     259 	.db 0x00
                                    260 	.area CODE
                                    261 	.area CONST
      008046                        262 ___str_2:
      008046 4F 4C 45 44 20 44 69   263 	.ascii "OLED Display"
             73 70 6C 61 79
      008052 00                     264 	.db 0x00
                                    265 	.area CODE
                                    266 	.area CONST
      008053                        267 ___str_3:
      008053 49 32 43 20 49 6E 74   268 	.ascii "I2C Interface"
             65 72 66 61 63 65
      008060 00                     269 	.db 0x00
                                    270 	.area CODE
                                    271 	.area CONST
      008061                        272 ___str_4:
      008061 53 79 73 74 65 6D 20   273 	.ascii "System Ready!"
             52 65 61 64 79 21
      00806E 0D                     274 	.db 0x0d
      00806F 0A                     275 	.db 0x0a
      008070 00                     276 	.db 0x00
                                    277 	.area CODE
                                    278 	.area CONST
      008071                        279 ___str_5:
      008071 52 65 63 65 69 76 65   280 	.ascii "Received: 1"
             64 3A 20 31
      00807C 0D                     281 	.db 0x0d
      00807D 0A                     282 	.db 0x0a
      00807E 00                     283 	.db 0x00
                                    284 	.area CODE
                                    285 	.area INITIALIZER
                                    286 	.area CABS (ABS)
