                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module gpio_s3
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _GPIO_Init
                                     11 	.globl _GPIO_WriteHigh
                                     12 	.globl _GPIO_WriteLow
                                     13 	.globl _GPIO_Toggle
                                     14 	.globl _GPIO_Read
                                     15 	.globl _GPIO_Write
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
                                     24 ;--------------------------------------------------------
                                     25 ; absolute external ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area DABS (ABS)
                                     28 
                                     29 ; default segment ordering for linker
                                     30 	.area HOME
                                     31 	.area GSINIT
                                     32 	.area GSFINAL
                                     33 	.area CONST
                                     34 	.area INITIALIZER
                                     35 	.area CODE
                                     36 
                                     37 ;--------------------------------------------------------
                                     38 ; global & static initialisations
                                     39 ;--------------------------------------------------------
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area GSINIT
                                     44 ;--------------------------------------------------------
                                     45 ; Home
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
                                     48 	.area HOME
                                     49 ;--------------------------------------------------------
                                     50 ; code
                                     51 ;--------------------------------------------------------
                                     52 	.area CODE
                                     53 ;	lib/gpio_s3.c: 3: void GPIO_Init(uint8_t port, uint8_t pin, GPIO_Mode mode, GPIO_Speed speed)
                                     54 ;	-----------------------------------------
                                     55 ;	 function GPIO_Init
                                     56 ;	-----------------------------------------
      0084E3                         57 _GPIO_Init:
      0084E3 52 0A            [ 2]   58 	sub	sp, #10
                                     59 ;	lib/gpio_s3.c: 7: switch(port) {
      0084E5 97               [ 1]   60 	ld	xl, a
      0084E6 26 04            [ 1]   61 	jrne	00294$
      0084E8 4C               [ 1]   62 	inc	a
      0084E9 6B 01            [ 1]   63 	ld	(0x01, sp), a
      0084EB C5                      64 	.byte 0xc5
      0084EC                         65 00294$:
      0084EC 0F 01            [ 1]   66 	clr	(0x01, sp)
      0084EE                         67 00295$:
      0084EE 9F               [ 1]   68 	ld	a, xl
      0084EF 4A               [ 1]   69 	dec	a
      0084F0 26 05            [ 1]   70 	jrne	00297$
      0084F2 A6 01            [ 1]   71 	ld	a, #0x01
      0084F4 6B 02            [ 1]   72 	ld	(0x02, sp), a
      0084F6 C5                      73 	.byte 0xc5
      0084F7                         74 00297$:
      0084F7 0F 02            [ 1]   75 	clr	(0x02, sp)
      0084F9                         76 00298$:
      0084F9 9F               [ 1]   77 	ld	a, xl
      0084FA A0 02            [ 1]   78 	sub	a, #0x02
      0084FC 26 04            [ 1]   79 	jrne	00300$
      0084FE 4C               [ 1]   80 	inc	a
      0084FF 6B 03            [ 1]   81 	ld	(0x03, sp), a
      008501 C5                      82 	.byte 0xc5
      008502                         83 00300$:
      008502 0F 03            [ 1]   84 	clr	(0x03, sp)
      008504                         85 00301$:
      008504 9F               [ 1]   86 	ld	a, xl
      008505 A1 03            [ 1]   87 	cp	a, #0x03
      008507 26 05            [ 1]   88 	jrne	00303$
      008509 A6 01            [ 1]   89 	ld	a, #0x01
      00850B 6B 04            [ 1]   90 	ld	(0x04, sp), a
      00850D C5                      91 	.byte 0xc5
      00850E                         92 00303$:
      00850E 0F 04            [ 1]   93 	clr	(0x04, sp)
      008510                         94 00304$:
      008510 0D 01            [ 1]   95 	tnz	(0x01, sp)
      008512 26 0F            [ 1]   96 	jrne	00101$
      008514 0D 02            [ 1]   97 	tnz	(0x02, sp)
      008516 26 1A            [ 1]   98 	jrne	00102$
      008518 0D 03            [ 1]   99 	tnz	(0x03, sp)
      00851A 26 25            [ 1]  100 	jrne	00103$
      00851C 0D 04            [ 1]  101 	tnz	(0x04, sp)
      00851E 26 30            [ 1]  102 	jrne	00104$
      008520 CC 86 D7         [ 2]  103 	jp	00137$
                                    104 ;	lib/gpio_s3.c: 8: case GPIO_PORT_PA:
      008523                        105 00101$:
                                    106 ;	lib/gpio_s3.c: 9: ddr = &PA_DDR;
      008523 AE 50 02         [ 2]  107 	ldw	x, #0x5002
      008526 1F 05            [ 2]  108 	ldw	(0x05, sp), x
                                    109 ;	lib/gpio_s3.c: 10: cr1 = &PA_CR1;
      008528 AE 50 03         [ 2]  110 	ldw	x, #0x5003
      00852B 1F 07            [ 2]  111 	ldw	(0x07, sp), x
                                    112 ;	lib/gpio_s3.c: 11: cr2 = &PA_CR2;
      00852D AE 50 04         [ 2]  113 	ldw	x, #0x5004
                                    114 ;	lib/gpio_s3.c: 12: break;
      008530 20 2B            [ 2]  115 	jra	00106$
                                    116 ;	lib/gpio_s3.c: 13: case GPIO_PORT_PB:
      008532                        117 00102$:
                                    118 ;	lib/gpio_s3.c: 14: ddr = &PB_DDR;
      008532 AE 50 07         [ 2]  119 	ldw	x, #0x5007
      008535 1F 05            [ 2]  120 	ldw	(0x05, sp), x
                                    121 ;	lib/gpio_s3.c: 15: cr1 = &PB_CR1;
      008537 AE 50 08         [ 2]  122 	ldw	x, #0x5008
      00853A 1F 07            [ 2]  123 	ldw	(0x07, sp), x
                                    124 ;	lib/gpio_s3.c: 16: cr2 = &PB_CR2;
      00853C AE 50 09         [ 2]  125 	ldw	x, #0x5009
                                    126 ;	lib/gpio_s3.c: 17: break;
      00853F 20 1C            [ 2]  127 	jra	00106$
                                    128 ;	lib/gpio_s3.c: 18: case GPIO_PORT_PC:
      008541                        129 00103$:
                                    130 ;	lib/gpio_s3.c: 19: ddr = &PC_DDR;
      008541 AE 50 0C         [ 2]  131 	ldw	x, #0x500c
      008544 1F 05            [ 2]  132 	ldw	(0x05, sp), x
                                    133 ;	lib/gpio_s3.c: 20: cr1 = &PC_CR1;
      008546 AE 50 0D         [ 2]  134 	ldw	x, #0x500d
      008549 1F 07            [ 2]  135 	ldw	(0x07, sp), x
                                    136 ;	lib/gpio_s3.c: 21: cr2 = &PC_CR2;
      00854B AE 50 0E         [ 2]  137 	ldw	x, #0x500e
                                    138 ;	lib/gpio_s3.c: 22: break;
      00854E 20 0D            [ 2]  139 	jra	00106$
                                    140 ;	lib/gpio_s3.c: 23: case GPIO_PORT_PD:
      008550                        141 00104$:
                                    142 ;	lib/gpio_s3.c: 24: ddr = &PD_DDR;
      008550 AE 50 11         [ 2]  143 	ldw	x, #0x5011
      008553 1F 05            [ 2]  144 	ldw	(0x05, sp), x
                                    145 ;	lib/gpio_s3.c: 25: cr1 = &PD_CR1;
      008555 AE 50 12         [ 2]  146 	ldw	x, #0x5012
      008558 1F 07            [ 2]  147 	ldw	(0x07, sp), x
                                    148 ;	lib/gpio_s3.c: 26: cr2 = &PD_CR2;
      00855A AE 50 13         [ 2]  149 	ldw	x, #0x5013
                                    150 ;	lib/gpio_s3.c: 27: break;
                                    151 ;	lib/gpio_s3.c: 28: default:
                                    152 ;	lib/gpio_s3.c: 29: return;
                                    153 ;	lib/gpio_s3.c: 30: }
      00855D                        154 00106$:
                                    155 ;	lib/gpio_s3.c: 33: *cr2 |= pin;
      00855D F6               [ 1]  156 	ld	a, (x)
                                    157 ;	lib/gpio_s3.c: 35: *cr2 &= ~pin;
      00855E 88               [ 1]  158 	push	a
      00855F 7B 0E            [ 1]  159 	ld	a, (0x0e, sp)
      008561 43               [ 1]  160 	cpl	a
      008562 6B 0A            [ 1]  161 	ld	(0x0a, sp), a
      008564 84               [ 1]  162 	pop	a
                                    163 ;	lib/gpio_s3.c: 32: if(speed == GPIO_SPEED_FAST) {
      008565 0D 0F            [ 1]  164 	tnz	(0x0f, sp)
      008567 27 05            [ 1]  165 	jreq	00108$
                                    166 ;	lib/gpio_s3.c: 33: *cr2 |= pin;
      008569 1A 0D            [ 1]  167 	or	a, (0x0d, sp)
      00856B F7               [ 1]  168 	ld	(x), a
      00856C 20 03            [ 2]  169 	jra	00109$
      00856E                        170 00108$:
                                    171 ;	lib/gpio_s3.c: 35: *cr2 &= ~pin;
      00856E 14 09            [ 1]  172 	and	a, (0x09, sp)
      008570 F7               [ 1]  173 	ld	(x), a
      008571                        174 00109$:
                                    175 ;	lib/gpio_s3.c: 38: switch(mode) {
      008571 7B 0E            [ 1]  176 	ld	a, (0x0e, sp)
      008573 A1 05            [ 1]  177 	cp	a, #0x05
      008575 23 03            [ 2]  178 	jrule	00310$
      008577 CC 86 D7         [ 2]  179 	jp	00137$
      00857A                        180 00310$:
                                    181 ;	lib/gpio_s3.c: 40: *ddr &= ~pin;
      00857A 1E 05            [ 2]  182 	ldw	x, (0x05, sp)
      00857C F6               [ 1]  183 	ld	a, (x)
      00857D 88               [ 1]  184 	push	a
      00857E 14 0A            [ 1]  185 	and	a, (0x0a, sp)
      008580 6B 0B            [ 1]  186 	ld	(0x0b, sp), a
      008582 84               [ 1]  187 	pop	a
                                    188 ;	lib/gpio_s3.c: 48: *ddr |= pin;
      008583 1A 0D            [ 1]  189 	or	a, (0x0d, sp)
                                    190 ;	lib/gpio_s3.c: 38: switch(mode) {
      008585 5F               [ 1]  191 	clrw	x
      008586 41               [ 1]  192 	exg	a, xl
      008587 7B 0E            [ 1]  193 	ld	a, (0x0e, sp)
      008589 41               [ 1]  194 	exg	a, xl
      00858A 58               [ 2]  195 	sllw	x
      00858B DE 85 8F         [ 2]  196 	ldw	x, (#00311$, x)
      00858E FC               [ 2]  197 	jp	(x)
      00858F                        198 00311$:
      00858F 85 9B                  199 	.dw	#00110$
      008591 85 AB                  200 	.dw	#00111$
      008593 85 BB                  201 	.dw	#00112$
      008595 86 05                  202 	.dw	#00118$
      008597 86 4F                  203 	.dw	#00124$
      008599 86 94                  204 	.dw	#00130$
                                    205 ;	lib/gpio_s3.c: 39: case GPIO_MODE_INPUT_FLOATING:
      00859B                        206 00110$:
                                    207 ;	lib/gpio_s3.c: 40: *ddr &= ~pin;
      00859B 1E 05            [ 2]  208 	ldw	x, (0x05, sp)
      00859D 7B 0A            [ 1]  209 	ld	a, (0x0a, sp)
      00859F F7               [ 1]  210 	ld	(x), a
                                    211 ;	lib/gpio_s3.c: 41: *cr1 &= ~pin;
      0085A0 1E 07            [ 2]  212 	ldw	x, (0x07, sp)
      0085A2 F6               [ 1]  213 	ld	a, (x)
      0085A3 14 09            [ 1]  214 	and	a, (0x09, sp)
      0085A5 1E 07            [ 2]  215 	ldw	x, (0x07, sp)
      0085A7 F7               [ 1]  216 	ld	(x), a
                                    217 ;	lib/gpio_s3.c: 42: break;
      0085A8 CC 86 D7         [ 2]  218 	jp	00137$
                                    219 ;	lib/gpio_s3.c: 43: case GPIO_MODE_INPUT_PULL_UP:
      0085AB                        220 00111$:
                                    221 ;	lib/gpio_s3.c: 44: *ddr &= ~pin;
      0085AB 1E 05            [ 2]  222 	ldw	x, (0x05, sp)
      0085AD 7B 0A            [ 1]  223 	ld	a, (0x0a, sp)
      0085AF F7               [ 1]  224 	ld	(x), a
                                    225 ;	lib/gpio_s3.c: 45: *cr1 |= pin;
      0085B0 1E 07            [ 2]  226 	ldw	x, (0x07, sp)
      0085B2 F6               [ 1]  227 	ld	a, (x)
      0085B3 1A 0D            [ 1]  228 	or	a, (0x0d, sp)
      0085B5 1E 07            [ 2]  229 	ldw	x, (0x07, sp)
      0085B7 F7               [ 1]  230 	ld	(x), a
                                    231 ;	lib/gpio_s3.c: 46: break;
      0085B8 CC 86 D7         [ 2]  232 	jp	00137$
                                    233 ;	lib/gpio_s3.c: 47: case GPIO_MODE_OUTPUT_PUSH_PULL_LOW:
      0085BB                        234 00112$:
                                    235 ;	lib/gpio_s3.c: 48: *ddr |= pin;
      0085BB 1E 05            [ 2]  236 	ldw	x, (0x05, sp)
      0085BD F7               [ 1]  237 	ld	(x), a
                                    238 ;	lib/gpio_s3.c: 49: *cr1 |= pin;
      0085BE 1E 07            [ 2]  239 	ldw	x, (0x07, sp)
      0085C0 F6               [ 1]  240 	ld	a, (x)
      0085C1 1A 0D            [ 1]  241 	or	a, (0x0d, sp)
      0085C3 1E 07            [ 2]  242 	ldw	x, (0x07, sp)
      0085C5 F7               [ 1]  243 	ld	(x), a
                                    244 ;	lib/gpio_s3.c: 50: switch(port) {
      0085C6 0D 01            [ 1]  245 	tnz	(0x01, sp)
      0085C8 26 0F            [ 1]  246 	jrne	00113$
      0085CA 0D 02            [ 1]  247 	tnz	(0x02, sp)
      0085CC 26 16            [ 1]  248 	jrne	00114$
      0085CE 0D 03            [ 1]  249 	tnz	(0x03, sp)
      0085D0 26 1D            [ 1]  250 	jrne	00115$
      0085D2 0D 04            [ 1]  251 	tnz	(0x04, sp)
      0085D4 26 24            [ 1]  252 	jrne	00116$
      0085D6 CC 86 D7         [ 2]  253 	jp	00137$
                                    254 ;	lib/gpio_s3.c: 51: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      0085D9                        255 00113$:
      0085D9 C6 50 00         [ 1]  256 	ld	a, 0x5000
      0085DC 14 09            [ 1]  257 	and	a, (0x09, sp)
      0085DE C7 50 00         [ 1]  258 	ld	0x5000, a
      0085E1 CC 86 D7         [ 2]  259 	jp	00137$
                                    260 ;	lib/gpio_s3.c: 52: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      0085E4                        261 00114$:
      0085E4 C6 50 05         [ 1]  262 	ld	a, 0x5005
      0085E7 14 09            [ 1]  263 	and	a, (0x09, sp)
      0085E9 C7 50 05         [ 1]  264 	ld	0x5005, a
      0085EC CC 86 D7         [ 2]  265 	jp	00137$
                                    266 ;	lib/gpio_s3.c: 53: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      0085EF                        267 00115$:
      0085EF C6 50 0A         [ 1]  268 	ld	a, 0x500a
      0085F2 14 09            [ 1]  269 	and	a, (0x09, sp)
      0085F4 C7 50 0A         [ 1]  270 	ld	0x500a, a
      0085F7 CC 86 D7         [ 2]  271 	jp	00137$
                                    272 ;	lib/gpio_s3.c: 54: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      0085FA                        273 00116$:
      0085FA C6 50 0F         [ 1]  274 	ld	a, 0x500f
      0085FD 14 09            [ 1]  275 	and	a, (0x09, sp)
      0085FF C7 50 0F         [ 1]  276 	ld	0x500f, a
                                    277 ;	lib/gpio_s3.c: 56: break;
      008602 CC 86 D7         [ 2]  278 	jp	00137$
                                    279 ;	lib/gpio_s3.c: 57: case GPIO_MODE_OUTPUT_PUSH_PULL_HIGH:
      008605                        280 00118$:
                                    281 ;	lib/gpio_s3.c: 58: *ddr |= pin;
      008605 1E 05            [ 2]  282 	ldw	x, (0x05, sp)
      008607 F7               [ 1]  283 	ld	(x), a
                                    284 ;	lib/gpio_s3.c: 59: *cr1 |= pin;
      008608 1E 07            [ 2]  285 	ldw	x, (0x07, sp)
      00860A F6               [ 1]  286 	ld	a, (x)
      00860B 1A 0D            [ 1]  287 	or	a, (0x0d, sp)
      00860D 1E 07            [ 2]  288 	ldw	x, (0x07, sp)
      00860F F7               [ 1]  289 	ld	(x), a
                                    290 ;	lib/gpio_s3.c: 60: switch(port) {
      008610 0D 01            [ 1]  291 	tnz	(0x01, sp)
      008612 26 0F            [ 1]  292 	jrne	00119$
      008614 0D 02            [ 1]  293 	tnz	(0x02, sp)
      008616 26 16            [ 1]  294 	jrne	00120$
      008618 0D 03            [ 1]  295 	tnz	(0x03, sp)
      00861A 26 1D            [ 1]  296 	jrne	00121$
      00861C 0D 04            [ 1]  297 	tnz	(0x04, sp)
      00861E 26 24            [ 1]  298 	jrne	00122$
      008620 CC 86 D7         [ 2]  299 	jp	00137$
                                    300 ;	lib/gpio_s3.c: 61: case GPIO_PORT_PA: PA_ODR |= pin; break;
      008623                        301 00119$:
      008623 C6 50 00         [ 1]  302 	ld	a, 0x5000
      008626 1A 0D            [ 1]  303 	or	a, (0x0d, sp)
      008628 C7 50 00         [ 1]  304 	ld	0x5000, a
      00862B CC 86 D7         [ 2]  305 	jp	00137$
                                    306 ;	lib/gpio_s3.c: 62: case GPIO_PORT_PB: PB_ODR |= pin; break;
      00862E                        307 00120$:
      00862E C6 50 05         [ 1]  308 	ld	a, 0x5005
      008631 1A 0D            [ 1]  309 	or	a, (0x0d, sp)
      008633 C7 50 05         [ 1]  310 	ld	0x5005, a
      008636 CC 86 D7         [ 2]  311 	jp	00137$
                                    312 ;	lib/gpio_s3.c: 63: case GPIO_PORT_PC: PC_ODR |= pin; break;
      008639                        313 00121$:
      008639 C6 50 0A         [ 1]  314 	ld	a, 0x500a
      00863C 1A 0D            [ 1]  315 	or	a, (0x0d, sp)
      00863E C7 50 0A         [ 1]  316 	ld	0x500a, a
      008641 CC 86 D7         [ 2]  317 	jp	00137$
                                    318 ;	lib/gpio_s3.c: 64: case GPIO_PORT_PD: PD_ODR |= pin; break;
      008644                        319 00122$:
      008644 C6 50 0F         [ 1]  320 	ld	a, 0x500f
      008647 1A 0D            [ 1]  321 	or	a, (0x0d, sp)
      008649 C7 50 0F         [ 1]  322 	ld	0x500f, a
                                    323 ;	lib/gpio_s3.c: 66: break;
      00864C CC 86 D7         [ 2]  324 	jp	00137$
                                    325 ;	lib/gpio_s3.c: 67: case GPIO_MODE_OUTPUT_OPEN_DRAIN_LOW:
      00864F                        326 00124$:
                                    327 ;	lib/gpio_s3.c: 68: *ddr |= pin;
      00864F 1E 05            [ 2]  328 	ldw	x, (0x05, sp)
      008651 F7               [ 1]  329 	ld	(x), a
                                    330 ;	lib/gpio_s3.c: 69: *cr1 &= ~pin;
      008652 1E 07            [ 2]  331 	ldw	x, (0x07, sp)
      008654 F6               [ 1]  332 	ld	a, (x)
      008655 14 09            [ 1]  333 	and	a, (0x09, sp)
      008657 1E 07            [ 2]  334 	ldw	x, (0x07, sp)
      008659 F7               [ 1]  335 	ld	(x), a
                                    336 ;	lib/gpio_s3.c: 70: switch(port) {
      00865A 0D 01            [ 1]  337 	tnz	(0x01, sp)
      00865C 26 0E            [ 1]  338 	jrne	00125$
      00865E 0D 02            [ 1]  339 	tnz	(0x02, sp)
      008660 26 14            [ 1]  340 	jrne	00126$
      008662 0D 03            [ 1]  341 	tnz	(0x03, sp)
      008664 26 1A            [ 1]  342 	jrne	00127$
      008666 0D 04            [ 1]  343 	tnz	(0x04, sp)
      008668 26 20            [ 1]  344 	jrne	00128$
      00866A 20 6B            [ 2]  345 	jra	00137$
                                    346 ;	lib/gpio_s3.c: 71: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      00866C                        347 00125$:
      00866C C6 50 00         [ 1]  348 	ld	a, 0x5000
      00866F 14 09            [ 1]  349 	and	a, (0x09, sp)
      008671 C7 50 00         [ 1]  350 	ld	0x5000, a
      008674 20 61            [ 2]  351 	jra	00137$
                                    352 ;	lib/gpio_s3.c: 72: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      008676                        353 00126$:
      008676 C6 50 05         [ 1]  354 	ld	a, 0x5005
      008679 14 09            [ 1]  355 	and	a, (0x09, sp)
      00867B C7 50 05         [ 1]  356 	ld	0x5005, a
      00867E 20 57            [ 2]  357 	jra	00137$
                                    358 ;	lib/gpio_s3.c: 73: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      008680                        359 00127$:
      008680 C6 50 0A         [ 1]  360 	ld	a, 0x500a
      008683 14 09            [ 1]  361 	and	a, (0x09, sp)
      008685 C7 50 0A         [ 1]  362 	ld	0x500a, a
      008688 20 4D            [ 2]  363 	jra	00137$
                                    364 ;	lib/gpio_s3.c: 74: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      00868A                        365 00128$:
      00868A C6 50 0F         [ 1]  366 	ld	a, 0x500f
      00868D 14 09            [ 1]  367 	and	a, (0x09, sp)
      00868F C7 50 0F         [ 1]  368 	ld	0x500f, a
                                    369 ;	lib/gpio_s3.c: 76: break;
      008692 20 43            [ 2]  370 	jra	00137$
                                    371 ;	lib/gpio_s3.c: 77: case GPIO_MODE_OUTPUT_OPEN_DRAIN_HIGH:
      008694                        372 00130$:
                                    373 ;	lib/gpio_s3.c: 78: *ddr |= pin;
      008694 1E 05            [ 2]  374 	ldw	x, (0x05, sp)
      008696 F7               [ 1]  375 	ld	(x), a
                                    376 ;	lib/gpio_s3.c: 79: *cr1 &= ~pin;
      008697 1E 07            [ 2]  377 	ldw	x, (0x07, sp)
      008699 F6               [ 1]  378 	ld	a, (x)
      00869A 14 09            [ 1]  379 	and	a, (0x09, sp)
      00869C 1E 07            [ 2]  380 	ldw	x, (0x07, sp)
      00869E F7               [ 1]  381 	ld	(x), a
                                    382 ;	lib/gpio_s3.c: 80: switch(port) {
      00869F 0D 01            [ 1]  383 	tnz	(0x01, sp)
      0086A1 26 0E            [ 1]  384 	jrne	00131$
      0086A3 0D 02            [ 1]  385 	tnz	(0x02, sp)
      0086A5 26 14            [ 1]  386 	jrne	00132$
      0086A7 0D 03            [ 1]  387 	tnz	(0x03, sp)
      0086A9 26 1A            [ 1]  388 	jrne	00133$
      0086AB 0D 04            [ 1]  389 	tnz	(0x04, sp)
      0086AD 26 20            [ 1]  390 	jrne	00134$
      0086AF 20 26            [ 2]  391 	jra	00137$
                                    392 ;	lib/gpio_s3.c: 81: case GPIO_PORT_PA: PA_ODR |= pin; break;
      0086B1                        393 00131$:
      0086B1 C6 50 00         [ 1]  394 	ld	a, 0x5000
      0086B4 1A 0D            [ 1]  395 	or	a, (0x0d, sp)
      0086B6 C7 50 00         [ 1]  396 	ld	0x5000, a
      0086B9 20 1C            [ 2]  397 	jra	00137$
                                    398 ;	lib/gpio_s3.c: 82: case GPIO_PORT_PB: PB_ODR |= pin; break;
      0086BB                        399 00132$:
      0086BB C6 50 05         [ 1]  400 	ld	a, 0x5005
      0086BE 1A 0D            [ 1]  401 	or	a, (0x0d, sp)
      0086C0 C7 50 05         [ 1]  402 	ld	0x5005, a
      0086C3 20 12            [ 2]  403 	jra	00137$
                                    404 ;	lib/gpio_s3.c: 83: case GPIO_PORT_PC: PC_ODR |= pin; break;
      0086C5                        405 00133$:
      0086C5 C6 50 0A         [ 1]  406 	ld	a, 0x500a
      0086C8 1A 0D            [ 1]  407 	or	a, (0x0d, sp)
      0086CA C7 50 0A         [ 1]  408 	ld	0x500a, a
      0086CD 20 08            [ 2]  409 	jra	00137$
                                    410 ;	lib/gpio_s3.c: 84: case GPIO_PORT_PD: PD_ODR |= pin; break;
      0086CF                        411 00134$:
      0086CF C6 50 0F         [ 1]  412 	ld	a, 0x500f
      0086D2 1A 0D            [ 1]  413 	or	a, (0x0d, sp)
      0086D4 C7 50 0F         [ 1]  414 	ld	0x500f, a
                                    415 ;	lib/gpio_s3.c: 87: }
      0086D7                        416 00137$:
                                    417 ;	lib/gpio_s3.c: 88: }
      0086D7 1E 0B            [ 2]  418 	ldw	x, (11, sp)
      0086D9 5B 0F            [ 2]  419 	addw	sp, #15
      0086DB FC               [ 2]  420 	jp	(x)
                                    421 ;	lib/gpio_s3.c: 90: void GPIO_WriteHigh(uint8_t port, uint8_t pin)
                                    422 ;	-----------------------------------------
                                    423 ;	 function GPIO_WriteHigh
                                    424 ;	-----------------------------------------
      0086DC                        425 _GPIO_WriteHigh:
                                    426 ;	lib/gpio_s3.c: 92: switch(port) {
      0086DC A1 00            [ 1]  427 	cp	a, #0x00
      0086DE 27 0E            [ 1]  428 	jreq	00101$
      0086E0 A1 01            [ 1]  429 	cp	a, #0x01
      0086E2 27 14            [ 1]  430 	jreq	00102$
      0086E4 A1 02            [ 1]  431 	cp	a, #0x02
      0086E6 27 1A            [ 1]  432 	jreq	00103$
      0086E8 A1 03            [ 1]  433 	cp	a, #0x03
      0086EA 27 20            [ 1]  434 	jreq	00104$
      0086EC 20 26            [ 2]  435 	jra	00106$
                                    436 ;	lib/gpio_s3.c: 93: case GPIO_PORT_PA: PA_ODR |= pin; break;
      0086EE                        437 00101$:
      0086EE C6 50 00         [ 1]  438 	ld	a, 0x5000
      0086F1 1A 03            [ 1]  439 	or	a, (0x03, sp)
      0086F3 C7 50 00         [ 1]  440 	ld	0x5000, a
      0086F6 20 1C            [ 2]  441 	jra	00106$
                                    442 ;	lib/gpio_s3.c: 94: case GPIO_PORT_PB: PB_ODR |= pin; break;
      0086F8                        443 00102$:
      0086F8 C6 50 05         [ 1]  444 	ld	a, 0x5005
      0086FB 1A 03            [ 1]  445 	or	a, (0x03, sp)
      0086FD C7 50 05         [ 1]  446 	ld	0x5005, a
      008700 20 12            [ 2]  447 	jra	00106$
                                    448 ;	lib/gpio_s3.c: 95: case GPIO_PORT_PC: PC_ODR |= pin; break;
      008702                        449 00103$:
      008702 C6 50 0A         [ 1]  450 	ld	a, 0x500a
      008705 1A 03            [ 1]  451 	or	a, (0x03, sp)
      008707 C7 50 0A         [ 1]  452 	ld	0x500a, a
      00870A 20 08            [ 2]  453 	jra	00106$
                                    454 ;	lib/gpio_s3.c: 96: case GPIO_PORT_PD: PD_ODR |= pin; break;
      00870C                        455 00104$:
      00870C C6 50 0F         [ 1]  456 	ld	a, 0x500f
      00870F 1A 03            [ 1]  457 	or	a, (0x03, sp)
      008711 C7 50 0F         [ 1]  458 	ld	0x500f, a
                                    459 ;	lib/gpio_s3.c: 97: }
      008714                        460 00106$:
                                    461 ;	lib/gpio_s3.c: 98: }
      008714 85               [ 2]  462 	popw	x
      008715 84               [ 1]  463 	pop	a
      008716 FC               [ 2]  464 	jp	(x)
                                    465 ;	lib/gpio_s3.c: 100: void GPIO_WriteLow(uint8_t port, uint8_t pin)
                                    466 ;	-----------------------------------------
                                    467 ;	 function GPIO_WriteLow
                                    468 ;	-----------------------------------------
      008717                        469 _GPIO_WriteLow:
      008717 88               [ 1]  470 	push	a
                                    471 ;	lib/gpio_s3.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      008718 88               [ 1]  472 	push	a
      008719 7B 05            [ 1]  473 	ld	a, (0x05, sp)
      00871B 43               [ 1]  474 	cpl	a
      00871C 6B 02            [ 1]  475 	ld	(0x02, sp), a
      00871E 84               [ 1]  476 	pop	a
                                    477 ;	lib/gpio_s3.c: 102: switch(port) {
      00871F A1 00            [ 1]  478 	cp	a, #0x00
      008721 27 0E            [ 1]  479 	jreq	00101$
      008723 A1 01            [ 1]  480 	cp	a, #0x01
      008725 27 14            [ 1]  481 	jreq	00102$
      008727 A1 02            [ 1]  482 	cp	a, #0x02
      008729 27 1A            [ 1]  483 	jreq	00103$
      00872B A1 03            [ 1]  484 	cp	a, #0x03
      00872D 27 20            [ 1]  485 	jreq	00104$
      00872F 20 26            [ 2]  486 	jra	00106$
                                    487 ;	lib/gpio_s3.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      008731                        488 00101$:
      008731 C6 50 00         [ 1]  489 	ld	a, 0x5000
      008734 14 01            [ 1]  490 	and	a, (0x01, sp)
      008736 C7 50 00         [ 1]  491 	ld	0x5000, a
      008739 20 1C            [ 2]  492 	jra	00106$
                                    493 ;	lib/gpio_s3.c: 104: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      00873B                        494 00102$:
      00873B C6 50 05         [ 1]  495 	ld	a, 0x5005
      00873E 14 01            [ 1]  496 	and	a, (0x01, sp)
      008740 C7 50 05         [ 1]  497 	ld	0x5005, a
      008743 20 12            [ 2]  498 	jra	00106$
                                    499 ;	lib/gpio_s3.c: 105: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      008745                        500 00103$:
      008745 C6 50 0A         [ 1]  501 	ld	a, 0x500a
      008748 14 01            [ 1]  502 	and	a, (0x01, sp)
      00874A C7 50 0A         [ 1]  503 	ld	0x500a, a
      00874D 20 08            [ 2]  504 	jra	00106$
                                    505 ;	lib/gpio_s3.c: 106: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      00874F                        506 00104$:
      00874F C6 50 0F         [ 1]  507 	ld	a, 0x500f
      008752 14 01            [ 1]  508 	and	a, (0x01, sp)
      008754 C7 50 0F         [ 1]  509 	ld	0x500f, a
                                    510 ;	lib/gpio_s3.c: 107: }
      008757                        511 00106$:
                                    512 ;	lib/gpio_s3.c: 108: }
      008757 84               [ 1]  513 	pop	a
      008758 85               [ 2]  514 	popw	x
      008759 84               [ 1]  515 	pop	a
      00875A FC               [ 2]  516 	jp	(x)
                                    517 ;	lib/gpio_s3.c: 110: void GPIO_Toggle(uint8_t port, uint8_t pin)
                                    518 ;	-----------------------------------------
                                    519 ;	 function GPIO_Toggle
                                    520 ;	-----------------------------------------
      00875B                        521 _GPIO_Toggle:
                                    522 ;	lib/gpio_s3.c: 112: switch(port) {
      00875B A1 00            [ 1]  523 	cp	a, #0x00
      00875D 27 0E            [ 1]  524 	jreq	00101$
      00875F A1 01            [ 1]  525 	cp	a, #0x01
      008761 27 14            [ 1]  526 	jreq	00102$
      008763 A1 02            [ 1]  527 	cp	a, #0x02
      008765 27 1A            [ 1]  528 	jreq	00103$
      008767 A1 03            [ 1]  529 	cp	a, #0x03
      008769 27 20            [ 1]  530 	jreq	00104$
      00876B 20 26            [ 2]  531 	jra	00106$
                                    532 ;	lib/gpio_s3.c: 113: case GPIO_PORT_PA: PA_ODR ^= pin; break;
      00876D                        533 00101$:
      00876D C6 50 00         [ 1]  534 	ld	a, 0x5000
      008770 18 03            [ 1]  535 	xor	a, (0x03, sp)
      008772 C7 50 00         [ 1]  536 	ld	0x5000, a
      008775 20 1C            [ 2]  537 	jra	00106$
                                    538 ;	lib/gpio_s3.c: 114: case GPIO_PORT_PB: PB_ODR ^= pin; break;
      008777                        539 00102$:
      008777 C6 50 05         [ 1]  540 	ld	a, 0x5005
      00877A 18 03            [ 1]  541 	xor	a, (0x03, sp)
      00877C C7 50 05         [ 1]  542 	ld	0x5005, a
      00877F 20 12            [ 2]  543 	jra	00106$
                                    544 ;	lib/gpio_s3.c: 115: case GPIO_PORT_PC: PC_ODR ^= pin; break;
      008781                        545 00103$:
      008781 C6 50 0A         [ 1]  546 	ld	a, 0x500a
      008784 18 03            [ 1]  547 	xor	a, (0x03, sp)
      008786 C7 50 0A         [ 1]  548 	ld	0x500a, a
      008789 20 08            [ 2]  549 	jra	00106$
                                    550 ;	lib/gpio_s3.c: 116: case GPIO_PORT_PD: PD_ODR ^= pin; break;
      00878B                        551 00104$:
      00878B C6 50 0F         [ 1]  552 	ld	a, 0x500f
      00878E 18 03            [ 1]  553 	xor	a, (0x03, sp)
      008790 C7 50 0F         [ 1]  554 	ld	0x500f, a
                                    555 ;	lib/gpio_s3.c: 117: }
      008793                        556 00106$:
                                    557 ;	lib/gpio_s3.c: 118: }
      008793 85               [ 2]  558 	popw	x
      008794 84               [ 1]  559 	pop	a
      008795 FC               [ 2]  560 	jp	(x)
                                    561 ;	lib/gpio_s3.c: 120: uint8_t GPIO_Read(uint8_t port, uint8_t pin)
                                    562 ;	-----------------------------------------
                                    563 ;	 function GPIO_Read
                                    564 ;	-----------------------------------------
      008796                        565 _GPIO_Read:
                                    566 ;	lib/gpio_s3.c: 122: switch(port) {
      008796 A1 00            [ 1]  567 	cp	a, #0x00
      008798 27 0E            [ 1]  568 	jreq	00101$
      00879A A1 01            [ 1]  569 	cp	a, #0x01
      00879C 27 16            [ 1]  570 	jreq	00102$
      00879E A1 02            [ 1]  571 	cp	a, #0x02
      0087A0 27 1E            [ 1]  572 	jreq	00103$
      0087A2 A1 03            [ 1]  573 	cp	a, #0x03
      0087A4 27 26            [ 1]  574 	jreq	00104$
      0087A6 20 2F            [ 2]  575 	jra	00105$
                                    576 ;	lib/gpio_s3.c: 123: case GPIO_PORT_PA: return ((PA_IDR & pin) != 0);
      0087A8                        577 00101$:
      0087A8 C6 50 01         [ 1]  578 	ld	a, 0x5001
      0087AB 14 03            [ 1]  579 	and	a, (0x03, sp)
      0087AD A0 01            [ 1]  580 	sub	a, #0x01
      0087AF 4F               [ 1]  581 	clr	a
      0087B0 8C               [ 1]  582 	ccf
      0087B1 49               [ 1]  583 	rlc	a
      0087B2 20 24            [ 2]  584 	jra	00107$
                                    585 ;	lib/gpio_s3.c: 124: case GPIO_PORT_PB: return ((PB_IDR & pin) != 0);
      0087B4                        586 00102$:
      0087B4 C6 50 06         [ 1]  587 	ld	a, 0x5006
      0087B7 14 03            [ 1]  588 	and	a, (0x03, sp)
      0087B9 A0 01            [ 1]  589 	sub	a, #0x01
      0087BB 4F               [ 1]  590 	clr	a
      0087BC 8C               [ 1]  591 	ccf
      0087BD 49               [ 1]  592 	rlc	a
      0087BE 20 18            [ 2]  593 	jra	00107$
                                    594 ;	lib/gpio_s3.c: 125: case GPIO_PORT_PC: return ((PC_IDR & pin) != 0);
      0087C0                        595 00103$:
      0087C0 C6 50 0B         [ 1]  596 	ld	a, 0x500b
      0087C3 14 03            [ 1]  597 	and	a, (0x03, sp)
      0087C5 A0 01            [ 1]  598 	sub	a, #0x01
      0087C7 4F               [ 1]  599 	clr	a
      0087C8 8C               [ 1]  600 	ccf
      0087C9 49               [ 1]  601 	rlc	a
      0087CA 20 0C            [ 2]  602 	jra	00107$
                                    603 ;	lib/gpio_s3.c: 126: case GPIO_PORT_PD: return ((PD_IDR & pin) != 0);
      0087CC                        604 00104$:
      0087CC C6 50 10         [ 1]  605 	ld	a, 0x5010
      0087CF 14 03            [ 1]  606 	and	a, (0x03, sp)
      0087D1 A0 01            [ 1]  607 	sub	a, #0x01
      0087D3 4F               [ 1]  608 	clr	a
      0087D4 8C               [ 1]  609 	ccf
      0087D5 49               [ 1]  610 	rlc	a
                                    611 ;	lib/gpio_s3.c: 127: default: return 0;
                                    612 ;	lib/gpio_s3.c: 128: }
      0087D6 21                     613 	.byte 0x21
      0087D7                        614 00105$:
      0087D7 4F               [ 1]  615 	clr	a
      0087D8                        616 00107$:
                                    617 ;	lib/gpio_s3.c: 129: }
      0087D8 85               [ 2]  618 	popw	x
      0087D9 5B 01            [ 2]  619 	addw	sp, #1
      0087DB FC               [ 2]  620 	jp	(x)
                                    621 ;	lib/gpio_s3.c: 131: void GPIO_Write(uint8_t port, uint8_t pin, uint8_t state)
                                    622 ;	-----------------------------------------
                                    623 ;	 function GPIO_Write
                                    624 ;	-----------------------------------------
      0087DC                        625 _GPIO_Write:
      0087DC 97               [ 1]  626 	ld	xl, a
                                    627 ;	lib/gpio_s3.c: 133: if(state) {
      0087DD 0D 04            [ 1]  628 	tnz	(0x04, sp)
      0087DF 27 09            [ 1]  629 	jreq	00102$
                                    630 ;	lib/gpio_s3.c: 134: GPIO_WriteHigh(port, pin);
      0087E1 7B 03            [ 1]  631 	ld	a, (0x03, sp)
      0087E3 88               [ 1]  632 	push	a
      0087E4 9F               [ 1]  633 	ld	a, xl
      0087E5 CD 86 DC         [ 4]  634 	call	_GPIO_WriteHigh
      0087E8 20 07            [ 2]  635 	jra	00104$
      0087EA                        636 00102$:
                                    637 ;	lib/gpio_s3.c: 136: GPIO_WriteLow(port, pin);
      0087EA 7B 03            [ 1]  638 	ld	a, (0x03, sp)
      0087EC 88               [ 1]  639 	push	a
      0087ED 9F               [ 1]  640 	ld	a, xl
      0087EE CD 87 17         [ 4]  641 	call	_GPIO_WriteLow
      0087F1                        642 00104$:
                                    643 ;	lib/gpio_s3.c: 138: }
      0087F1 1E 01            [ 2]  644 	ldw	x, (1, sp)
      0087F3 5B 04            [ 2]  645 	addw	sp, #4
      0087F5 FC               [ 2]  646 	jp	(x)
                                    647 	.area CODE
                                    648 	.area CONST
                                    649 	.area INITIALIZER
                                    650 	.area CABS (ABS)
