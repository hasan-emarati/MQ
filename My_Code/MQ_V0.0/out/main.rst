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
                                     18 	.globl _delay
                                     19 	.globl _delay_ms
                                     20 	.globl _GPIO_Read
                                     21 	.globl _GPIO_WriteLow
                                     22 	.globl _GPIO_WriteHigh
                                     23 	.globl _GPIO_Init
                                     24 	.globl _sprintf
                                     25 	.globl _init_adc
                                     26 	.globl _analog_read_pc4
                                     27 	.globl _analog_read_pd3
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DATA
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area INITIALIZED
                                     36 ;--------------------------------------------------------
                                     37 ; Stack segment in internal ram
                                     38 ;--------------------------------------------------------
                                     39 	.area SSEG
      000204                         40 __start__stack:
      000204                         41 	.ds	1
                                     42 
                                     43 ;--------------------------------------------------------
                                     44 ; absolute external ram data
                                     45 ;--------------------------------------------------------
                                     46 	.area DABS (ABS)
                                     47 
                                     48 ; default segment ordering for linker
                                     49 	.area HOME
                                     50 	.area GSINIT
                                     51 	.area GSFINAL
                                     52 	.area CONST
                                     53 	.area INITIALIZER
                                     54 	.area CODE
                                     55 
                                     56 ;--------------------------------------------------------
                                     57 ; interrupt vector
                                     58 ;--------------------------------------------------------
                                     59 	.area HOME
      008000                         60 __interrupt_vect:
      008000 82 00 80 07             61 	int s_GSINIT ; reset
                                     62 ;--------------------------------------------------------
                                     63 ; global & static initialisations
                                     64 ;--------------------------------------------------------
                                     65 	.area HOME
                                     66 	.area GSINIT
                                     67 	.area GSFINAL
                                     68 	.area GSINIT
      008007 CD 8F AB         [ 4]   69 	call	___sdcc_external_startup
      00800A 4D               [ 1]   70 	tnz	a
      00800B 27 03            [ 1]   71 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   72 	jp	__sdcc_program_startup
      008010                         73 __sdcc_init_data:
                                     74 ; stm8_genXINIT() start
      008010 AE 02 00         [ 2]   75 	ldw x, #l_DATA
      008013 27 07            [ 1]   76 	jreq	00002$
      008015                         77 00001$:
      008015 72 4F 00 00      [ 1]   78 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   79 	decw x
      00801A 26 F9            [ 1]   80 	jrne	00001$
      00801C                         81 00002$:
      00801C AE 00 03         [ 2]   82 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   83 	jreq	00004$
      008021                         84 00003$:
      008021 D6 82 E8         [ 1]   85 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 02 00         [ 1]   86 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   87 	decw	x
      008028 26 F7            [ 1]   88 	jrne	00003$
      00802A                         89 00004$:
                                     90 ; stm8_genXINIT() end
                                     91 	.area GSFINAL
      00802A CC 80 04         [ 2]   92 	jp	__sdcc_program_startup
                                     93 ;--------------------------------------------------------
                                     94 ; Home
                                     95 ;--------------------------------------------------------
                                     96 	.area HOME
                                     97 	.area HOME
      008004                         98 __sdcc_program_startup:
      008004 CC 83 56         [ 2]   99 	jp	_main
                                    100 ;	return from main will return to caller
                                    101 ;--------------------------------------------------------
                                    102 ; code
                                    103 ;--------------------------------------------------------
                                    104 	.area CODE
                                    105 ;	src/main.c: 39: void init_adc(void) {
                                    106 ;	-----------------------------------------
                                    107 ;	 function init_adc
                                    108 ;	-----------------------------------------
      0082EC                        109 _init_adc:
                                    110 ;	src/main.c: 41: ADC_CSR = ADC_CHANNEL_PC4;
      0082EC 35 02 54 00      [ 1]  111 	mov	0x5400+0, #0x02
                                    112 ;	src/main.c: 44: ADC_CR1 = 0x00;  // Single conversion mode, no prescaler
      0082F0 35 00 54 01      [ 1]  113 	mov	0x5401+0, #0x00
                                    114 ;	src/main.c: 45: ADC_CR2 = 0x00;  // Left aligned data
      0082F4 35 00 54 02      [ 1]  115 	mov	0x5402+0, #0x00
                                    116 ;	src/main.c: 46: ADC_CR3 = 0x00;  // No data buffer
      0082F8 35 00 54 03      [ 1]  117 	mov	0x5403+0, #0x00
                                    118 ;	src/main.c: 49: ADC_CR1 |= ADC_CR1_ADON;
      0082FC 72 10 54 01      [ 1]  119 	bset	0x5401, #0
                                    120 ;	src/main.c: 51: delay(1000); // Wait for ADC stabilization
      008300 4B E8            [ 1]  121 	push	#0xe8
      008302 4B 03            [ 1]  122 	push	#0x03
      008304 5F               [ 1]  123 	clrw	x
      008305 89               [ 2]  124 	pushw	x
      008306 CD 84 8F         [ 4]  125 	call	_delay
                                    126 ;	src/main.c: 52: }
      008309 81               [ 4]  127 	ret
                                    128 ;	src/main.c: 54: uint16_t analog_read_pc4(void) {
                                    129 ;	-----------------------------------------
                                    130 ;	 function analog_read_pc4
                                    131 ;	-----------------------------------------
      00830A                        132 _analog_read_pc4:
                                    133 ;	src/main.c: 58: ADC_CSR = ADC_CHANNEL_PC4;
      00830A 35 02 54 00      [ 1]  134 	mov	0x5400+0, #0x02
                                    135 ;	src/main.c: 61: ADC_CR1 |= ADC_CR1_ADON;
      00830E 72 10 54 01      [ 1]  136 	bset	0x5401, #0
                                    137 ;	src/main.c: 64: while(!(ADC_CSR & ADC_CSR_EOC));
      008312                        138 00101$:
      008312 C6 54 00         [ 1]  139 	ld	a, 0x5400
      008315 2A FB            [ 1]  140 	jrpl	00101$
                                    141 ;	src/main.c: 67: adc_value = (ADC_DRH << 2) | (ADC_DRL >> 6);
      008317 C6 54 04         [ 1]  142 	ld	a, 0x5404
      00831A 5F               [ 1]  143 	clrw	x
      00831B 97               [ 1]  144 	ld	xl, a
      00831C 58               [ 2]  145 	sllw	x
      00831D 58               [ 2]  146 	sllw	x
      00831E C6 54 05         [ 1]  147 	ld	a, 0x5405
      008321 4E               [ 1]  148 	swap	a
      008322 A4 0F            [ 1]  149 	and	a, #0x0f
      008324 44               [ 1]  150 	srl	a
      008325 44               [ 1]  151 	srl	a
      008326 89               [ 2]  152 	pushw	x
      008327 1A 02            [ 1]  153 	or	a, (2, sp)
      008329 85               [ 2]  154 	popw	x
      00832A 97               [ 1]  155 	ld	xl, a
                                    156 ;	src/main.c: 70: ADC_CSR &= ~ADC_CSR_EOC;
      00832B 72 1F 54 00      [ 1]  157 	bres	0x5400, #7
                                    158 ;	src/main.c: 72: return adc_value;
                                    159 ;	src/main.c: 73: }
      00832F 81               [ 4]  160 	ret
                                    161 ;	src/main.c: 75: uint16_t analog_read_pd3(void) {
                                    162 ;	-----------------------------------------
                                    163 ;	 function analog_read_pd3
                                    164 ;	-----------------------------------------
      008330                        165 _analog_read_pd3:
                                    166 ;	src/main.c: 79: ADC_CSR = ADC_CHANNEL_PD3;
      008330 35 06 54 00      [ 1]  167 	mov	0x5400+0, #0x06
                                    168 ;	src/main.c: 82: ADC_CR1 |= ADC_CR1_ADON;
      008334 72 10 54 01      [ 1]  169 	bset	0x5401, #0
                                    170 ;	src/main.c: 85: while(!(ADC_CSR & ADC_CSR_EOC));
      008338                        171 00101$:
      008338 C6 54 00         [ 1]  172 	ld	a, 0x5400
      00833B 2A FB            [ 1]  173 	jrpl	00101$
                                    174 ;	src/main.c: 88: adc_value = (ADC_DRH << 2) | (ADC_DRL >> 6);
      00833D C6 54 04         [ 1]  175 	ld	a, 0x5404
      008340 5F               [ 1]  176 	clrw	x
      008341 97               [ 1]  177 	ld	xl, a
      008342 58               [ 2]  178 	sllw	x
      008343 58               [ 2]  179 	sllw	x
      008344 C6 54 05         [ 1]  180 	ld	a, 0x5405
      008347 4E               [ 1]  181 	swap	a
      008348 A4 0F            [ 1]  182 	and	a, #0x0f
      00834A 44               [ 1]  183 	srl	a
      00834B 44               [ 1]  184 	srl	a
      00834C 89               [ 2]  185 	pushw	x
      00834D 1A 02            [ 1]  186 	or	a, (2, sp)
      00834F 85               [ 2]  187 	popw	x
      008350 97               [ 1]  188 	ld	xl, a
                                    189 ;	src/main.c: 91: ADC_CSR &= ~ADC_CSR_EOC;
      008351 72 1F 54 00      [ 1]  190 	bres	0x5400, #7
                                    191 ;	src/main.c: 93: return adc_value;
                                    192 ;	src/main.c: 94: }
      008355 81               [ 4]  193 	ret
                                    194 ;	src/main.c: 98: int main(void)
                                    195 ;	-----------------------------------------
                                    196 ;	 function main
                                    197 ;	-----------------------------------------
      008356                        198 _main:
      008356 52 52            [ 2]  199 	sub	sp, #82
                                    200 ;	src/main.c: 105: CLK_ECKR |= CLK_ECKR_HSEEN;
      008358 72 10 50 C1      [ 1]  201 	bset	0x50c1, #0
                                    202 ;	src/main.c: 106: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
      00835C                        203 00101$:
      00835C 72 03 50 C1 FB   [ 2]  204 	btjf	0x50c1, #1, 00101$
                                    205 ;	src/main.c: 107: CLK_SWR = CLK_SWR_HSE;
      008361 35 B4 50 C4      [ 1]  206 	mov	0x50c4+0, #0xb4
                                    207 ;	src/main.c: 108: CLK_SWCR |= CLK_SWCR_SWEN;
      008365 72 12 50 C5      [ 1]  208 	bset	0x50c5, #1
                                    209 ;	src/main.c: 109: while(CLK_SWCR & CLK_SWCR_SWBSY);
      008369                        210 00104$:
      008369 72 00 50 C5 FB   [ 2]  211 	btjt	0x50c5, #0, 00104$
                                    212 ;	src/main.c: 110: CLK_CKDIVR = 0x00;
      00836E 35 00 50 C6      [ 1]  213 	mov	0x50c6+0, #0x00
                                    214 ;	src/main.c: 113: i2c_init(16000000, I2C_SPEED_STANDARD);
      008372 4B A0            [ 1]  215 	push	#0xa0
      008374 4B 86            [ 1]  216 	push	#0x86
      008376 4B 01            [ 1]  217 	push	#0x01
      008378 4B 00            [ 1]  218 	push	#0x00
      00837A 4B 00            [ 1]  219 	push	#0x00
      00837C 4B 24            [ 1]  220 	push	#0x24
      00837E 4B F4            [ 1]  221 	push	#0xf4
      008380 4B 00            [ 1]  222 	push	#0x00
      008382 CD 87 F6         [ 4]  223 	call	_i2c_init
                                    224 ;	src/main.c: 116: uart_init(9600);
      008385 4B 80            [ 1]  225 	push	#0x80
      008387 4B 25            [ 1]  226 	push	#0x25
      008389 5F               [ 1]  227 	clrw	x
      00838A 89               [ 2]  228 	pushw	x
      00838B CD 8E 8F         [ 4]  229 	call	_uart_init
                                    230 ;	src/main.c: 119: init_adc();
      00838E CD 82 EC         [ 4]  231 	call	_init_adc
                                    232 ;	src/main.c: 122: delay_ms(200);
      008391 AE 00 C8         [ 2]  233 	ldw	x, #0x00c8
      008394 CD 84 B9         [ 4]  234 	call	_delay_ms
                                    235 ;	src/main.c: 123: oled_init();
      008397 CD 89 FE         [ 4]  236 	call	_oled_init
                                    237 ;	src/main.c: 124: oled_clear();
      00839A CD 8A 77         [ 4]  238 	call	_oled_clear
                                    239 ;	src/main.c: 127: GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      00839D 4B 00            [ 1]  240 	push	#0x00
      00839F 4B 02            [ 1]  241 	push	#0x02
      0083A1 4B 10            [ 1]  242 	push	#0x10
      0083A3 A6 03            [ 1]  243 	ld	a, #0x03
      0083A5 CD 84 E3         [ 4]  244 	call	_GPIO_Init
                                    245 ;	src/main.c: 128: GPIO_Init(RELAY_PORT, RELAY_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      0083A8 4B 00            [ 1]  246 	push	#0x00
      0083AA 4B 02            [ 1]  247 	push	#0x02
      0083AC 4B 08            [ 1]  248 	push	#0x08
      0083AE A6 02            [ 1]  249 	ld	a, #0x02
      0083B0 CD 84 E3         [ 4]  250 	call	_GPIO_Init
                                    251 ;	src/main.c: 129: GPIO_Init(TR_PORT, TR_PIN, GPIO_MODE_OUTPUT_PUSH_PULL_LOW, GPIO_SPEED_SLOW);
      0083B3 4B 00            [ 1]  252 	push	#0x00
      0083B5 4B 02            [ 1]  253 	push	#0x02
      0083B7 4B 08            [ 1]  254 	push	#0x08
      0083B9 4F               [ 1]  255 	clr	a
      0083BA CD 84 E3         [ 4]  256 	call	_GPIO_Init
                                    257 ;	src/main.c: 130: GPIO_Init(INPUT1_PORT, INPUT1_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
      0083BD 4B 00            [ 1]  258 	push	#0x00
      0083BF 4B 01            [ 1]  259 	push	#0x01
      0083C1 4B 20            [ 1]  260 	push	#0x20
      0083C3 A6 02            [ 1]  261 	ld	a, #0x02
      0083C5 CD 84 E3         [ 4]  262 	call	_GPIO_Init
                                    263 ;	src/main.c: 131: GPIO_Init(INPUT2_PORT, INPUT2_PIN, GPIO_MODE_INPUT_PULL_UP, GPIO_SPEED_SLOW);
      0083C8 4B 00            [ 1]  264 	push	#0x00
      0083CA 4B 01            [ 1]  265 	push	#0x01
      0083CC 4B 40            [ 1]  266 	push	#0x40
      0083CE A6 02            [ 1]  267 	ld	a, #0x02
      0083D0 CD 84 E3         [ 4]  268 	call	_GPIO_Init
                                    269 ;	src/main.c: 134: oled_set_font(FONT_5X7); 
      0083D3 4F               [ 1]  270 	clr	a
      0083D4 CD 8D 70         [ 4]  271 	call	_oled_set_font
                                    272 ;	src/main.c: 135: oled_puts_at(0, 0, "System Ready!");
      0083D7 4B 2D            [ 1]  273 	push	#<(___str_0+0)
      0083D9 4B 80            [ 1]  274 	push	#((___str_0+0) >> 8)
      0083DB 4B 00            [ 1]  275 	push	#0x00
      0083DD 4F               [ 1]  276 	clr	a
      0083DE CD 8D 5D         [ 4]  277 	call	_oled_puts_at
                                    278 ;	src/main.c: 136: oled_puts_at(0, 8, "STM8S003F3");
      0083E1 4B 3B            [ 1]  279 	push	#<(___str_1+0)
      0083E3 4B 80            [ 1]  280 	push	#((___str_1+0) >> 8)
      0083E5 4B 08            [ 1]  281 	push	#0x08
      0083E7 4F               [ 1]  282 	clr	a
      0083E8 CD 8D 5D         [ 4]  283 	call	_oled_puts_at
                                    284 ;	src/main.c: 137: oled_puts_at(0, 16, "OLED Display");
      0083EB 4B 46            [ 1]  285 	push	#<(___str_2+0)
      0083ED 4B 80            [ 1]  286 	push	#((___str_2+0) >> 8)
      0083EF 4B 10            [ 1]  287 	push	#0x10
      0083F1 4F               [ 1]  288 	clr	a
      0083F2 CD 8D 5D         [ 4]  289 	call	_oled_puts_at
                                    290 ;	src/main.c: 138: oled_puts_at(0, 24, "_____ADC_____");
      0083F5 4B 53            [ 1]  291 	push	#<(___str_3+0)
      0083F7 4B 80            [ 1]  292 	push	#((___str_3+0) >> 8)
      0083F9 4B 18            [ 1]  293 	push	#0x18
      0083FB 4F               [ 1]  294 	clr	a
      0083FC CD 8D 5D         [ 4]  295 	call	_oled_puts_at
                                    296 ;	src/main.c: 141: uart_write("System Ready!\r\n");
      0083FF AE 80 61         [ 2]  297 	ldw	x, #(___str_4+0)
      008402 CD 8E D1         [ 4]  298 	call	_uart_write
                                    299 ;	src/main.c: 143: while(1) 
      008405                        300 00115$:
                                    301 ;	src/main.c: 146: adc_raw_pc4 = analog_read_pc4();
      008405 CD 83 0A         [ 4]  302 	call	_analog_read_pc4
      008408 1F 51            [ 2]  303 	ldw	(0x51, sp), x
                                    304 ;	src/main.c: 147: adc_raw_pd3 = analog_read_pd3();
      00840A CD 83 30         [ 4]  305 	call	_analog_read_pd3
                                    306 ;	src/main.c: 148: sprintf(buffer, "ADC-PC4: %4d | ADC-PD3: %4d \r\n", adc_raw_pc4, adc_raw_pd3);
      00840D 89               [ 2]  307 	pushw	x
      00840E 1E 53            [ 2]  308 	ldw	x, (0x53, sp)
      008410 89               [ 2]  309 	pushw	x
      008411 4B 71            [ 1]  310 	push	#<(___str_5+0)
      008413 4B 80            [ 1]  311 	push	#((___str_5+0) >> 8)
      008415 96               [ 1]  312 	ldw	x, sp
      008416 1C 00 07         [ 2]  313 	addw	x, #7
      008419 89               [ 2]  314 	pushw	x
      00841A CD 8F 38         [ 4]  315 	call	_sprintf
      00841D 5B 08            [ 2]  316 	addw	sp, #8
                                    317 ;	src/main.c: 149: uart_write(buffer);  
      00841F 96               [ 1]  318 	ldw	x, sp
      008420 5C               [ 1]  319 	incw	x
      008421 CD 8E D1         [ 4]  320 	call	_uart_write
                                    321 ;	src/main.c: 152: if((UART1_SR & UART_SR_RXNE))
      008424 72 0B 52 30 26   [ 2]  322 	btjf	0x5230, #5, 00110$
                                    323 ;	src/main.c: 154: char received = UART1_DR;
      008429 C6 52 31         [ 1]  324 	ld	a, 0x5231
                                    325 ;	src/main.c: 156: if(received == '1') 
      00842C A1 31            [ 1]  326 	cp	a, #0x31
      00842E 26 1F            [ 1]  327 	jrne	00110$
                                    328 ;	src/main.c: 158: uart_write("Received: 1\r\n");
      008430 AE 80 90         [ 2]  329 	ldw	x, #(___str_6+0)
      008433 CD 8E D1         [ 4]  330 	call	_uart_write
                                    331 ;	src/main.c: 159: uart_write(buffer); 
      008436 96               [ 1]  332 	ldw	x, sp
      008437 5C               [ 1]  333 	incw	x
      008438 CD 8E D1         [ 4]  334 	call	_uart_write
                                    335 ;	src/main.c: 162: GPIO_WriteLow(LED_PORT, LED_PIN);
      00843B 4B 10            [ 1]  336 	push	#0x10
      00843D A6 03            [ 1]  337 	ld	a, #0x03
      00843F CD 87 17         [ 4]  338 	call	_GPIO_WriteLow
                                    339 ;	src/main.c: 163: delay_ms(300);
      008442 AE 01 2C         [ 2]  340 	ldw	x, #0x012c
      008445 CD 84 B9         [ 4]  341 	call	_delay_ms
                                    342 ;	src/main.c: 164: GPIO_WriteHigh(LED_PORT, LED_PIN);
      008448 4B 10            [ 1]  343 	push	#0x10
      00844A A6 03            [ 1]  344 	ld	a, #0x03
      00844C CD 86 DC         [ 4]  345 	call	_GPIO_WriteHigh
      00844F                        346 00110$:
                                    347 ;	src/main.c: 169: if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
      00844F 4B 20            [ 1]  348 	push	#0x20
      008451 A6 02            [ 1]  349 	ld	a, #0x02
      008453 CD 87 96         [ 4]  350 	call	_GPIO_Read
      008456 4A               [ 1]  351 	dec	a
      008457 26 09            [ 1]  352 	jrne	00112$
                                    353 ;	src/main.c: 170: GPIO_WriteLow(LED_PORT, LED_PIN);
      008459 4B 10            [ 1]  354 	push	#0x10
      00845B A6 03            [ 1]  355 	ld	a, #0x03
      00845D CD 87 17         [ 4]  356 	call	_GPIO_WriteLow
      008460 20 07            [ 2]  357 	jra	00113$
      008462                        358 00112$:
                                    359 ;	src/main.c: 172: GPIO_WriteHigh(LED_PORT, LED_PIN);
      008462 4B 10            [ 1]  360 	push	#0x10
      008464 A6 03            [ 1]  361 	ld	a, #0x03
      008466 CD 86 DC         [ 4]  362 	call	_GPIO_WriteHigh
      008469                        363 00113$:
                                    364 ;	src/main.c: 175: delay_ms(100);
      008469 AE 00 64         [ 2]  365 	ldw	x, #0x0064
      00846C CD 84 B9         [ 4]  366 	call	_delay_ms
      00846F 20 94            [ 2]  367 	jra	00115$
                                    368 ;	src/main.c: 177: }
      008471 5B 52            [ 2]  369 	addw	sp, #82
      008473 81               [ 4]  370 	ret
                                    371 	.area CODE
                                    372 	.area CONST
                                    373 	.area CONST
      00802D                        374 ___str_0:
      00802D 53 79 73 74 65 6D 20   375 	.ascii "System Ready!"
             52 65 61 64 79 21
      00803A 00                     376 	.db 0x00
                                    377 	.area CODE
                                    378 	.area CONST
      00803B                        379 ___str_1:
      00803B 53 54 4D 38 53 30 30   380 	.ascii "STM8S003F3"
             33 46 33
      008045 00                     381 	.db 0x00
                                    382 	.area CODE
                                    383 	.area CONST
      008046                        384 ___str_2:
      008046 4F 4C 45 44 20 44 69   385 	.ascii "OLED Display"
             73 70 6C 61 79
      008052 00                     386 	.db 0x00
                                    387 	.area CODE
                                    388 	.area CONST
      008053                        389 ___str_3:
      008053 5F 5F 5F 5F 5F 41 44   390 	.ascii "_____ADC_____"
             43 5F 5F 5F 5F 5F
      008060 00                     391 	.db 0x00
                                    392 	.area CODE
                                    393 	.area CONST
      008061                        394 ___str_4:
      008061 53 79 73 74 65 6D 20   395 	.ascii "System Ready!"
             52 65 61 64 79 21
      00806E 0D                     396 	.db 0x0d
      00806F 0A                     397 	.db 0x0a
      008070 00                     398 	.db 0x00
                                    399 	.area CODE
                                    400 	.area CONST
      008071                        401 ___str_5:
      008071 41 44 43 2D 50 43 34   402 	.ascii "ADC-PC4: %4d | ADC-PD3: %4d "
             3A 20 25 34 64 20 7C
             20 41 44 43 2D 50 44
             33 3A 20 25 34 64 20
      00808D 0D                     403 	.db 0x0d
      00808E 0A                     404 	.db 0x0a
      00808F 00                     405 	.db 0x00
                                    406 	.area CODE
                                    407 	.area CONST
      008090                        408 ___str_6:
      008090 52 65 63 65 69 76 65   409 	.ascii "Received: 1"
             64 3A 20 31
      00809B 0D                     410 	.db 0x0d
      00809C 0A                     411 	.db 0x0a
      00809D 00                     412 	.db 0x00
                                    413 	.area CODE
                                    414 	.area INITIALIZER
                                    415 	.area CABS (ABS)
