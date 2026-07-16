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
      008424                         57 _GPIO_Init:
      008424 52 0A            [ 2]   58 	sub	sp, #10
                                     59 ;	lib/gpio_s3.c: 7: switch(port) {
      008426 97               [ 1]   60 	ld	xl, a
      008427 26 04            [ 1]   61 	jrne	00294$
      008429 4C               [ 1]   62 	inc	a
      00842A 6B 01            [ 1]   63 	ld	(0x01, sp), a
      00842C C5                      64 	.byte 0xc5
      00842D                         65 00294$:
      00842D 0F 01            [ 1]   66 	clr	(0x01, sp)
      00842F                         67 00295$:
      00842F 9F               [ 1]   68 	ld	a, xl
      008430 4A               [ 1]   69 	dec	a
      008431 26 05            [ 1]   70 	jrne	00297$
      008433 A6 01            [ 1]   71 	ld	a, #0x01
      008435 6B 02            [ 1]   72 	ld	(0x02, sp), a
      008437 C5                      73 	.byte 0xc5
      008438                         74 00297$:
      008438 0F 02            [ 1]   75 	clr	(0x02, sp)
      00843A                         76 00298$:
      00843A 9F               [ 1]   77 	ld	a, xl
      00843B A0 02            [ 1]   78 	sub	a, #0x02
      00843D 26 04            [ 1]   79 	jrne	00300$
      00843F 4C               [ 1]   80 	inc	a
      008440 6B 03            [ 1]   81 	ld	(0x03, sp), a
      008442 C5                      82 	.byte 0xc5
      008443                         83 00300$:
      008443 0F 03            [ 1]   84 	clr	(0x03, sp)
      008445                         85 00301$:
      008445 9F               [ 1]   86 	ld	a, xl
      008446 A1 03            [ 1]   87 	cp	a, #0x03
      008448 26 05            [ 1]   88 	jrne	00303$
      00844A A6 01            [ 1]   89 	ld	a, #0x01
      00844C 6B 04            [ 1]   90 	ld	(0x04, sp), a
      00844E C5                      91 	.byte 0xc5
      00844F                         92 00303$:
      00844F 0F 04            [ 1]   93 	clr	(0x04, sp)
      008451                         94 00304$:
      008451 0D 01            [ 1]   95 	tnz	(0x01, sp)
      008453 26 0F            [ 1]   96 	jrne	00101$
      008455 0D 02            [ 1]   97 	tnz	(0x02, sp)
      008457 26 1A            [ 1]   98 	jrne	00102$
      008459 0D 03            [ 1]   99 	tnz	(0x03, sp)
      00845B 26 25            [ 1]  100 	jrne	00103$
      00845D 0D 04            [ 1]  101 	tnz	(0x04, sp)
      00845F 26 30            [ 1]  102 	jrne	00104$
      008461 CC 86 18         [ 2]  103 	jp	00137$
                                    104 ;	lib/gpio_s3.c: 8: case GPIO_PORT_PA:
      008464                        105 00101$:
                                    106 ;	lib/gpio_s3.c: 9: ddr = &PA_DDR;
      008464 AE 50 02         [ 2]  107 	ldw	x, #0x5002
      008467 1F 05            [ 2]  108 	ldw	(0x05, sp), x
                                    109 ;	lib/gpio_s3.c: 10: cr1 = &PA_CR1;
      008469 AE 50 03         [ 2]  110 	ldw	x, #0x5003
      00846C 1F 07            [ 2]  111 	ldw	(0x07, sp), x
                                    112 ;	lib/gpio_s3.c: 11: cr2 = &PA_CR2;
      00846E AE 50 04         [ 2]  113 	ldw	x, #0x5004
                                    114 ;	lib/gpio_s3.c: 12: break;
      008471 20 2B            [ 2]  115 	jra	00106$
                                    116 ;	lib/gpio_s3.c: 13: case GPIO_PORT_PB:
      008473                        117 00102$:
                                    118 ;	lib/gpio_s3.c: 14: ddr = &PB_DDR;
      008473 AE 50 07         [ 2]  119 	ldw	x, #0x5007
      008476 1F 05            [ 2]  120 	ldw	(0x05, sp), x
                                    121 ;	lib/gpio_s3.c: 15: cr1 = &PB_CR1;
      008478 AE 50 08         [ 2]  122 	ldw	x, #0x5008
      00847B 1F 07            [ 2]  123 	ldw	(0x07, sp), x
                                    124 ;	lib/gpio_s3.c: 16: cr2 = &PB_CR2;
      00847D AE 50 09         [ 2]  125 	ldw	x, #0x5009
                                    126 ;	lib/gpio_s3.c: 17: break;
      008480 20 1C            [ 2]  127 	jra	00106$
                                    128 ;	lib/gpio_s3.c: 18: case GPIO_PORT_PC:
      008482                        129 00103$:
                                    130 ;	lib/gpio_s3.c: 19: ddr = &PC_DDR;
      008482 AE 50 0C         [ 2]  131 	ldw	x, #0x500c
      008485 1F 05            [ 2]  132 	ldw	(0x05, sp), x
                                    133 ;	lib/gpio_s3.c: 20: cr1 = &PC_CR1;
      008487 AE 50 0D         [ 2]  134 	ldw	x, #0x500d
      00848A 1F 07            [ 2]  135 	ldw	(0x07, sp), x
                                    136 ;	lib/gpio_s3.c: 21: cr2 = &PC_CR2;
      00848C AE 50 0E         [ 2]  137 	ldw	x, #0x500e
                                    138 ;	lib/gpio_s3.c: 22: break;
      00848F 20 0D            [ 2]  139 	jra	00106$
                                    140 ;	lib/gpio_s3.c: 23: case GPIO_PORT_PD:
      008491                        141 00104$:
                                    142 ;	lib/gpio_s3.c: 24: ddr = &PD_DDR;
      008491 AE 50 11         [ 2]  143 	ldw	x, #0x5011
      008494 1F 05            [ 2]  144 	ldw	(0x05, sp), x
                                    145 ;	lib/gpio_s3.c: 25: cr1 = &PD_CR1;
      008496 AE 50 12         [ 2]  146 	ldw	x, #0x5012
      008499 1F 07            [ 2]  147 	ldw	(0x07, sp), x
                                    148 ;	lib/gpio_s3.c: 26: cr2 = &PD_CR2;
      00849B AE 50 13         [ 2]  149 	ldw	x, #0x5013
                                    150 ;	lib/gpio_s3.c: 27: break;
                                    151 ;	lib/gpio_s3.c: 28: default:
                                    152 ;	lib/gpio_s3.c: 29: return;
                                    153 ;	lib/gpio_s3.c: 30: }
      00849E                        154 00106$:
                                    155 ;	lib/gpio_s3.c: 33: *cr2 |= pin;
      00849E F6               [ 1]  156 	ld	a, (x)
                                    157 ;	lib/gpio_s3.c: 35: *cr2 &= ~pin;
      00849F 88               [ 1]  158 	push	a
      0084A0 7B 0E            [ 1]  159 	ld	a, (0x0e, sp)
      0084A2 43               [ 1]  160 	cpl	a
      0084A3 6B 0A            [ 1]  161 	ld	(0x0a, sp), a
      0084A5 84               [ 1]  162 	pop	a
                                    163 ;	lib/gpio_s3.c: 32: if(speed == GPIO_SPEED_FAST) {
      0084A6 0D 0F            [ 1]  164 	tnz	(0x0f, sp)
      0084A8 27 05            [ 1]  165 	jreq	00108$
                                    166 ;	lib/gpio_s3.c: 33: *cr2 |= pin;
      0084AA 1A 0D            [ 1]  167 	or	a, (0x0d, sp)
      0084AC F7               [ 1]  168 	ld	(x), a
      0084AD 20 03            [ 2]  169 	jra	00109$
      0084AF                        170 00108$:
                                    171 ;	lib/gpio_s3.c: 35: *cr2 &= ~pin;
      0084AF 14 09            [ 1]  172 	and	a, (0x09, sp)
      0084B1 F7               [ 1]  173 	ld	(x), a
      0084B2                        174 00109$:
                                    175 ;	lib/gpio_s3.c: 38: switch(mode) {
      0084B2 7B 0E            [ 1]  176 	ld	a, (0x0e, sp)
      0084B4 A1 05            [ 1]  177 	cp	a, #0x05
      0084B6 23 03            [ 2]  178 	jrule	00310$
      0084B8 CC 86 18         [ 2]  179 	jp	00137$
      0084BB                        180 00310$:
                                    181 ;	lib/gpio_s3.c: 40: *ddr &= ~pin;
      0084BB 1E 05            [ 2]  182 	ldw	x, (0x05, sp)
      0084BD F6               [ 1]  183 	ld	a, (x)
      0084BE 88               [ 1]  184 	push	a
      0084BF 14 0A            [ 1]  185 	and	a, (0x0a, sp)
      0084C1 6B 0B            [ 1]  186 	ld	(0x0b, sp), a
      0084C3 84               [ 1]  187 	pop	a
                                    188 ;	lib/gpio_s3.c: 48: *ddr |= pin;
      0084C4 1A 0D            [ 1]  189 	or	a, (0x0d, sp)
                                    190 ;	lib/gpio_s3.c: 38: switch(mode) {
      0084C6 5F               [ 1]  191 	clrw	x
      0084C7 41               [ 1]  192 	exg	a, xl
      0084C8 7B 0E            [ 1]  193 	ld	a, (0x0e, sp)
      0084CA 41               [ 1]  194 	exg	a, xl
      0084CB 58               [ 2]  195 	sllw	x
      0084CC DE 84 D0         [ 2]  196 	ldw	x, (#00311$, x)
      0084CF FC               [ 2]  197 	jp	(x)
      0084D0                        198 00311$:
      0084D0 84 DC                  199 	.dw	#00110$
      0084D2 84 EC                  200 	.dw	#00111$
      0084D4 84 FC                  201 	.dw	#00112$
      0084D6 85 46                  202 	.dw	#00118$
      0084D8 85 90                  203 	.dw	#00124$
      0084DA 85 D5                  204 	.dw	#00130$
                                    205 ;	lib/gpio_s3.c: 39: case GPIO_MODE_INPUT_FLOATING:
      0084DC                        206 00110$:
                                    207 ;	lib/gpio_s3.c: 40: *ddr &= ~pin;
      0084DC 1E 05            [ 2]  208 	ldw	x, (0x05, sp)
      0084DE 7B 0A            [ 1]  209 	ld	a, (0x0a, sp)
      0084E0 F7               [ 1]  210 	ld	(x), a
                                    211 ;	lib/gpio_s3.c: 41: *cr1 &= ~pin;
      0084E1 1E 07            [ 2]  212 	ldw	x, (0x07, sp)
      0084E3 F6               [ 1]  213 	ld	a, (x)
      0084E4 14 09            [ 1]  214 	and	a, (0x09, sp)
      0084E6 1E 07            [ 2]  215 	ldw	x, (0x07, sp)
      0084E8 F7               [ 1]  216 	ld	(x), a
                                    217 ;	lib/gpio_s3.c: 42: break;
      0084E9 CC 86 18         [ 2]  218 	jp	00137$
                                    219 ;	lib/gpio_s3.c: 43: case GPIO_MODE_INPUT_PULL_UP:
      0084EC                        220 00111$:
                                    221 ;	lib/gpio_s3.c: 44: *ddr &= ~pin;
      0084EC 1E 05            [ 2]  222 	ldw	x, (0x05, sp)
      0084EE 7B 0A            [ 1]  223 	ld	a, (0x0a, sp)
      0084F0 F7               [ 1]  224 	ld	(x), a
                                    225 ;	lib/gpio_s3.c: 45: *cr1 |= pin;
      0084F1 1E 07            [ 2]  226 	ldw	x, (0x07, sp)
      0084F3 F6               [ 1]  227 	ld	a, (x)
      0084F4 1A 0D            [ 1]  228 	or	a, (0x0d, sp)
      0084F6 1E 07            [ 2]  229 	ldw	x, (0x07, sp)
      0084F8 F7               [ 1]  230 	ld	(x), a
                                    231 ;	lib/gpio_s3.c: 46: break;
      0084F9 CC 86 18         [ 2]  232 	jp	00137$
                                    233 ;	lib/gpio_s3.c: 47: case GPIO_MODE_OUTPUT_PUSH_PULL_LOW:
      0084FC                        234 00112$:
                                    235 ;	lib/gpio_s3.c: 48: *ddr |= pin;
      0084FC 1E 05            [ 2]  236 	ldw	x, (0x05, sp)
      0084FE F7               [ 1]  237 	ld	(x), a
                                    238 ;	lib/gpio_s3.c: 49: *cr1 |= pin;
      0084FF 1E 07            [ 2]  239 	ldw	x, (0x07, sp)
      008501 F6               [ 1]  240 	ld	a, (x)
      008502 1A 0D            [ 1]  241 	or	a, (0x0d, sp)
      008504 1E 07            [ 2]  242 	ldw	x, (0x07, sp)
      008506 F7               [ 1]  243 	ld	(x), a
                                    244 ;	lib/gpio_s3.c: 50: switch(port) {
      008507 0D 01            [ 1]  245 	tnz	(0x01, sp)
      008509 26 0F            [ 1]  246 	jrne	00113$
      00850B 0D 02            [ 1]  247 	tnz	(0x02, sp)
      00850D 26 16            [ 1]  248 	jrne	00114$
      00850F 0D 03            [ 1]  249 	tnz	(0x03, sp)
      008511 26 1D            [ 1]  250 	jrne	00115$
      008513 0D 04            [ 1]  251 	tnz	(0x04, sp)
      008515 26 24            [ 1]  252 	jrne	00116$
      008517 CC 86 18         [ 2]  253 	jp	00137$
                                    254 ;	lib/gpio_s3.c: 51: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      00851A                        255 00113$:
      00851A C6 50 00         [ 1]  256 	ld	a, 0x5000
      00851D 14 09            [ 1]  257 	and	a, (0x09, sp)
      00851F C7 50 00         [ 1]  258 	ld	0x5000, a
      008522 CC 86 18         [ 2]  259 	jp	00137$
                                    260 ;	lib/gpio_s3.c: 52: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      008525                        261 00114$:
      008525 C6 50 05         [ 1]  262 	ld	a, 0x5005
      008528 14 09            [ 1]  263 	and	a, (0x09, sp)
      00852A C7 50 05         [ 1]  264 	ld	0x5005, a
      00852D CC 86 18         [ 2]  265 	jp	00137$
                                    266 ;	lib/gpio_s3.c: 53: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      008530                        267 00115$:
      008530 C6 50 0A         [ 1]  268 	ld	a, 0x500a
      008533 14 09            [ 1]  269 	and	a, (0x09, sp)
      008535 C7 50 0A         [ 1]  270 	ld	0x500a, a
      008538 CC 86 18         [ 2]  271 	jp	00137$
                                    272 ;	lib/gpio_s3.c: 54: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      00853B                        273 00116$:
      00853B C6 50 0F         [ 1]  274 	ld	a, 0x500f
      00853E 14 09            [ 1]  275 	and	a, (0x09, sp)
      008540 C7 50 0F         [ 1]  276 	ld	0x500f, a
                                    277 ;	lib/gpio_s3.c: 56: break;
      008543 CC 86 18         [ 2]  278 	jp	00137$
                                    279 ;	lib/gpio_s3.c: 57: case GPIO_MODE_OUTPUT_PUSH_PULL_HIGH:
      008546                        280 00118$:
                                    281 ;	lib/gpio_s3.c: 58: *ddr |= pin;
      008546 1E 05            [ 2]  282 	ldw	x, (0x05, sp)
      008548 F7               [ 1]  283 	ld	(x), a
                                    284 ;	lib/gpio_s3.c: 59: *cr1 |= pin;
      008549 1E 07            [ 2]  285 	ldw	x, (0x07, sp)
      00854B F6               [ 1]  286 	ld	a, (x)
      00854C 1A 0D            [ 1]  287 	or	a, (0x0d, sp)
      00854E 1E 07            [ 2]  288 	ldw	x, (0x07, sp)
      008550 F7               [ 1]  289 	ld	(x), a
                                    290 ;	lib/gpio_s3.c: 60: switch(port) {
      008551 0D 01            [ 1]  291 	tnz	(0x01, sp)
      008553 26 0F            [ 1]  292 	jrne	00119$
      008555 0D 02            [ 1]  293 	tnz	(0x02, sp)
      008557 26 16            [ 1]  294 	jrne	00120$
      008559 0D 03            [ 1]  295 	tnz	(0x03, sp)
      00855B 26 1D            [ 1]  296 	jrne	00121$
      00855D 0D 04            [ 1]  297 	tnz	(0x04, sp)
      00855F 26 24            [ 1]  298 	jrne	00122$
      008561 CC 86 18         [ 2]  299 	jp	00137$
                                    300 ;	lib/gpio_s3.c: 61: case GPIO_PORT_PA: PA_ODR |= pin; break;
      008564                        301 00119$:
      008564 C6 50 00         [ 1]  302 	ld	a, 0x5000
      008567 1A 0D            [ 1]  303 	or	a, (0x0d, sp)
      008569 C7 50 00         [ 1]  304 	ld	0x5000, a
      00856C CC 86 18         [ 2]  305 	jp	00137$
                                    306 ;	lib/gpio_s3.c: 62: case GPIO_PORT_PB: PB_ODR |= pin; break;
      00856F                        307 00120$:
      00856F C6 50 05         [ 1]  308 	ld	a, 0x5005
      008572 1A 0D            [ 1]  309 	or	a, (0x0d, sp)
      008574 C7 50 05         [ 1]  310 	ld	0x5005, a
      008577 CC 86 18         [ 2]  311 	jp	00137$
                                    312 ;	lib/gpio_s3.c: 63: case GPIO_PORT_PC: PC_ODR |= pin; break;
      00857A                        313 00121$:
      00857A C6 50 0A         [ 1]  314 	ld	a, 0x500a
      00857D 1A 0D            [ 1]  315 	or	a, (0x0d, sp)
      00857F C7 50 0A         [ 1]  316 	ld	0x500a, a
      008582 CC 86 18         [ 2]  317 	jp	00137$
                                    318 ;	lib/gpio_s3.c: 64: case GPIO_PORT_PD: PD_ODR |= pin; break;
      008585                        319 00122$:
      008585 C6 50 0F         [ 1]  320 	ld	a, 0x500f
      008588 1A 0D            [ 1]  321 	or	a, (0x0d, sp)
      00858A C7 50 0F         [ 1]  322 	ld	0x500f, a
                                    323 ;	lib/gpio_s3.c: 66: break;
      00858D CC 86 18         [ 2]  324 	jp	00137$
                                    325 ;	lib/gpio_s3.c: 67: case GPIO_MODE_OUTPUT_OPEN_DRAIN_LOW:
      008590                        326 00124$:
                                    327 ;	lib/gpio_s3.c: 68: *ddr |= pin;
      008590 1E 05            [ 2]  328 	ldw	x, (0x05, sp)
      008592 F7               [ 1]  329 	ld	(x), a
                                    330 ;	lib/gpio_s3.c: 69: *cr1 &= ~pin;
      008593 1E 07            [ 2]  331 	ldw	x, (0x07, sp)
      008595 F6               [ 1]  332 	ld	a, (x)
      008596 14 09            [ 1]  333 	and	a, (0x09, sp)
      008598 1E 07            [ 2]  334 	ldw	x, (0x07, sp)
      00859A F7               [ 1]  335 	ld	(x), a
                                    336 ;	lib/gpio_s3.c: 70: switch(port) {
      00859B 0D 01            [ 1]  337 	tnz	(0x01, sp)
      00859D 26 0E            [ 1]  338 	jrne	00125$
      00859F 0D 02            [ 1]  339 	tnz	(0x02, sp)
      0085A1 26 14            [ 1]  340 	jrne	00126$
      0085A3 0D 03            [ 1]  341 	tnz	(0x03, sp)
      0085A5 26 1A            [ 1]  342 	jrne	00127$
      0085A7 0D 04            [ 1]  343 	tnz	(0x04, sp)
      0085A9 26 20            [ 1]  344 	jrne	00128$
      0085AB 20 6B            [ 2]  345 	jra	00137$
                                    346 ;	lib/gpio_s3.c: 71: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      0085AD                        347 00125$:
      0085AD C6 50 00         [ 1]  348 	ld	a, 0x5000
      0085B0 14 09            [ 1]  349 	and	a, (0x09, sp)
      0085B2 C7 50 00         [ 1]  350 	ld	0x5000, a
      0085B5 20 61            [ 2]  351 	jra	00137$
                                    352 ;	lib/gpio_s3.c: 72: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      0085B7                        353 00126$:
      0085B7 C6 50 05         [ 1]  354 	ld	a, 0x5005
      0085BA 14 09            [ 1]  355 	and	a, (0x09, sp)
      0085BC C7 50 05         [ 1]  356 	ld	0x5005, a
      0085BF 20 57            [ 2]  357 	jra	00137$
                                    358 ;	lib/gpio_s3.c: 73: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      0085C1                        359 00127$:
      0085C1 C6 50 0A         [ 1]  360 	ld	a, 0x500a
      0085C4 14 09            [ 1]  361 	and	a, (0x09, sp)
      0085C6 C7 50 0A         [ 1]  362 	ld	0x500a, a
      0085C9 20 4D            [ 2]  363 	jra	00137$
                                    364 ;	lib/gpio_s3.c: 74: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      0085CB                        365 00128$:
      0085CB C6 50 0F         [ 1]  366 	ld	a, 0x500f
      0085CE 14 09            [ 1]  367 	and	a, (0x09, sp)
      0085D0 C7 50 0F         [ 1]  368 	ld	0x500f, a
                                    369 ;	lib/gpio_s3.c: 76: break;
      0085D3 20 43            [ 2]  370 	jra	00137$
                                    371 ;	lib/gpio_s3.c: 77: case GPIO_MODE_OUTPUT_OPEN_DRAIN_HIGH:
      0085D5                        372 00130$:
                                    373 ;	lib/gpio_s3.c: 78: *ddr |= pin;
      0085D5 1E 05            [ 2]  374 	ldw	x, (0x05, sp)
      0085D7 F7               [ 1]  375 	ld	(x), a
                                    376 ;	lib/gpio_s3.c: 79: *cr1 &= ~pin;
      0085D8 1E 07            [ 2]  377 	ldw	x, (0x07, sp)
      0085DA F6               [ 1]  378 	ld	a, (x)
      0085DB 14 09            [ 1]  379 	and	a, (0x09, sp)
      0085DD 1E 07            [ 2]  380 	ldw	x, (0x07, sp)
      0085DF F7               [ 1]  381 	ld	(x), a
                                    382 ;	lib/gpio_s3.c: 80: switch(port) {
      0085E0 0D 01            [ 1]  383 	tnz	(0x01, sp)
      0085E2 26 0E            [ 1]  384 	jrne	00131$
      0085E4 0D 02            [ 1]  385 	tnz	(0x02, sp)
      0085E6 26 14            [ 1]  386 	jrne	00132$
      0085E8 0D 03            [ 1]  387 	tnz	(0x03, sp)
      0085EA 26 1A            [ 1]  388 	jrne	00133$
      0085EC 0D 04            [ 1]  389 	tnz	(0x04, sp)
      0085EE 26 20            [ 1]  390 	jrne	00134$
      0085F0 20 26            [ 2]  391 	jra	00137$
                                    392 ;	lib/gpio_s3.c: 81: case GPIO_PORT_PA: PA_ODR |= pin; break;
      0085F2                        393 00131$:
      0085F2 C6 50 00         [ 1]  394 	ld	a, 0x5000
      0085F5 1A 0D            [ 1]  395 	or	a, (0x0d, sp)
      0085F7 C7 50 00         [ 1]  396 	ld	0x5000, a
      0085FA 20 1C            [ 2]  397 	jra	00137$
                                    398 ;	lib/gpio_s3.c: 82: case GPIO_PORT_PB: PB_ODR |= pin; break;
      0085FC                        399 00132$:
      0085FC C6 50 05         [ 1]  400 	ld	a, 0x5005
      0085FF 1A 0D            [ 1]  401 	or	a, (0x0d, sp)
      008601 C7 50 05         [ 1]  402 	ld	0x5005, a
      008604 20 12            [ 2]  403 	jra	00137$
                                    404 ;	lib/gpio_s3.c: 83: case GPIO_PORT_PC: PC_ODR |= pin; break;
      008606                        405 00133$:
      008606 C6 50 0A         [ 1]  406 	ld	a, 0x500a
      008609 1A 0D            [ 1]  407 	or	a, (0x0d, sp)
      00860B C7 50 0A         [ 1]  408 	ld	0x500a, a
      00860E 20 08            [ 2]  409 	jra	00137$
                                    410 ;	lib/gpio_s3.c: 84: case GPIO_PORT_PD: PD_ODR |= pin; break;
      008610                        411 00134$:
      008610 C6 50 0F         [ 1]  412 	ld	a, 0x500f
      008613 1A 0D            [ 1]  413 	or	a, (0x0d, sp)
      008615 C7 50 0F         [ 1]  414 	ld	0x500f, a
                                    415 ;	lib/gpio_s3.c: 87: }
      008618                        416 00137$:
                                    417 ;	lib/gpio_s3.c: 88: }
      008618 1E 0B            [ 2]  418 	ldw	x, (11, sp)
      00861A 5B 0F            [ 2]  419 	addw	sp, #15
      00861C FC               [ 2]  420 	jp	(x)
                                    421 ;	lib/gpio_s3.c: 90: void GPIO_WriteHigh(uint8_t port, uint8_t pin)
                                    422 ;	-----------------------------------------
                                    423 ;	 function GPIO_WriteHigh
                                    424 ;	-----------------------------------------
      00861D                        425 _GPIO_WriteHigh:
                                    426 ;	lib/gpio_s3.c: 92: switch(port) {
      00861D A1 00            [ 1]  427 	cp	a, #0x00
      00861F 27 0E            [ 1]  428 	jreq	00101$
      008621 A1 01            [ 1]  429 	cp	a, #0x01
      008623 27 14            [ 1]  430 	jreq	00102$
      008625 A1 02            [ 1]  431 	cp	a, #0x02
      008627 27 1A            [ 1]  432 	jreq	00103$
      008629 A1 03            [ 1]  433 	cp	a, #0x03
      00862B 27 20            [ 1]  434 	jreq	00104$
      00862D 20 26            [ 2]  435 	jra	00106$
                                    436 ;	lib/gpio_s3.c: 93: case GPIO_PORT_PA: PA_ODR |= pin; break;
      00862F                        437 00101$:
      00862F C6 50 00         [ 1]  438 	ld	a, 0x5000
      008632 1A 03            [ 1]  439 	or	a, (0x03, sp)
      008634 C7 50 00         [ 1]  440 	ld	0x5000, a
      008637 20 1C            [ 2]  441 	jra	00106$
                                    442 ;	lib/gpio_s3.c: 94: case GPIO_PORT_PB: PB_ODR |= pin; break;
      008639                        443 00102$:
      008639 C6 50 05         [ 1]  444 	ld	a, 0x5005
      00863C 1A 03            [ 1]  445 	or	a, (0x03, sp)
      00863E C7 50 05         [ 1]  446 	ld	0x5005, a
      008641 20 12            [ 2]  447 	jra	00106$
                                    448 ;	lib/gpio_s3.c: 95: case GPIO_PORT_PC: PC_ODR |= pin; break;
      008643                        449 00103$:
      008643 C6 50 0A         [ 1]  450 	ld	a, 0x500a
      008646 1A 03            [ 1]  451 	or	a, (0x03, sp)
      008648 C7 50 0A         [ 1]  452 	ld	0x500a, a
      00864B 20 08            [ 2]  453 	jra	00106$
                                    454 ;	lib/gpio_s3.c: 96: case GPIO_PORT_PD: PD_ODR |= pin; break;
      00864D                        455 00104$:
      00864D C6 50 0F         [ 1]  456 	ld	a, 0x500f
      008650 1A 03            [ 1]  457 	or	a, (0x03, sp)
      008652 C7 50 0F         [ 1]  458 	ld	0x500f, a
                                    459 ;	lib/gpio_s3.c: 97: }
      008655                        460 00106$:
                                    461 ;	lib/gpio_s3.c: 98: }
      008655 85               [ 2]  462 	popw	x
      008656 84               [ 1]  463 	pop	a
      008657 FC               [ 2]  464 	jp	(x)
                                    465 ;	lib/gpio_s3.c: 100: void GPIO_WriteLow(uint8_t port, uint8_t pin)
                                    466 ;	-----------------------------------------
                                    467 ;	 function GPIO_WriteLow
                                    468 ;	-----------------------------------------
      008658                        469 _GPIO_WriteLow:
      008658 88               [ 1]  470 	push	a
                                    471 ;	lib/gpio_s3.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      008659 88               [ 1]  472 	push	a
      00865A 7B 05            [ 1]  473 	ld	a, (0x05, sp)
      00865C 43               [ 1]  474 	cpl	a
      00865D 6B 02            [ 1]  475 	ld	(0x02, sp), a
      00865F 84               [ 1]  476 	pop	a
                                    477 ;	lib/gpio_s3.c: 102: switch(port) {
      008660 A1 00            [ 1]  478 	cp	a, #0x00
      008662 27 0E            [ 1]  479 	jreq	00101$
      008664 A1 01            [ 1]  480 	cp	a, #0x01
      008666 27 14            [ 1]  481 	jreq	00102$
      008668 A1 02            [ 1]  482 	cp	a, #0x02
      00866A 27 1A            [ 1]  483 	jreq	00103$
      00866C A1 03            [ 1]  484 	cp	a, #0x03
      00866E 27 20            [ 1]  485 	jreq	00104$
      008670 20 26            [ 2]  486 	jra	00106$
                                    487 ;	lib/gpio_s3.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      008672                        488 00101$:
      008672 C6 50 00         [ 1]  489 	ld	a, 0x5000
      008675 14 01            [ 1]  490 	and	a, (0x01, sp)
      008677 C7 50 00         [ 1]  491 	ld	0x5000, a
      00867A 20 1C            [ 2]  492 	jra	00106$
                                    493 ;	lib/gpio_s3.c: 104: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      00867C                        494 00102$:
      00867C C6 50 05         [ 1]  495 	ld	a, 0x5005
      00867F 14 01            [ 1]  496 	and	a, (0x01, sp)
      008681 C7 50 05         [ 1]  497 	ld	0x5005, a
      008684 20 12            [ 2]  498 	jra	00106$
                                    499 ;	lib/gpio_s3.c: 105: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      008686                        500 00103$:
      008686 C6 50 0A         [ 1]  501 	ld	a, 0x500a
      008689 14 01            [ 1]  502 	and	a, (0x01, sp)
      00868B C7 50 0A         [ 1]  503 	ld	0x500a, a
      00868E 20 08            [ 2]  504 	jra	00106$
                                    505 ;	lib/gpio_s3.c: 106: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      008690                        506 00104$:
      008690 C6 50 0F         [ 1]  507 	ld	a, 0x500f
      008693 14 01            [ 1]  508 	and	a, (0x01, sp)
      008695 C7 50 0F         [ 1]  509 	ld	0x500f, a
                                    510 ;	lib/gpio_s3.c: 107: }
      008698                        511 00106$:
                                    512 ;	lib/gpio_s3.c: 108: }
      008698 84               [ 1]  513 	pop	a
      008699 85               [ 2]  514 	popw	x
      00869A 84               [ 1]  515 	pop	a
      00869B FC               [ 2]  516 	jp	(x)
                                    517 ;	lib/gpio_s3.c: 110: void GPIO_Toggle(uint8_t port, uint8_t pin)
                                    518 ;	-----------------------------------------
                                    519 ;	 function GPIO_Toggle
                                    520 ;	-----------------------------------------
      00869C                        521 _GPIO_Toggle:
                                    522 ;	lib/gpio_s3.c: 112: switch(port) {
      00869C A1 00            [ 1]  523 	cp	a, #0x00
      00869E 27 0E            [ 1]  524 	jreq	00101$
      0086A0 A1 01            [ 1]  525 	cp	a, #0x01
      0086A2 27 14            [ 1]  526 	jreq	00102$
      0086A4 A1 02            [ 1]  527 	cp	a, #0x02
      0086A6 27 1A            [ 1]  528 	jreq	00103$
      0086A8 A1 03            [ 1]  529 	cp	a, #0x03
      0086AA 27 20            [ 1]  530 	jreq	00104$
      0086AC 20 26            [ 2]  531 	jra	00106$
                                    532 ;	lib/gpio_s3.c: 113: case GPIO_PORT_PA: PA_ODR ^= pin; break;
      0086AE                        533 00101$:
      0086AE C6 50 00         [ 1]  534 	ld	a, 0x5000
      0086B1 18 03            [ 1]  535 	xor	a, (0x03, sp)
      0086B3 C7 50 00         [ 1]  536 	ld	0x5000, a
      0086B6 20 1C            [ 2]  537 	jra	00106$
                                    538 ;	lib/gpio_s3.c: 114: case GPIO_PORT_PB: PB_ODR ^= pin; break;
      0086B8                        539 00102$:
      0086B8 C6 50 05         [ 1]  540 	ld	a, 0x5005
      0086BB 18 03            [ 1]  541 	xor	a, (0x03, sp)
      0086BD C7 50 05         [ 1]  542 	ld	0x5005, a
      0086C0 20 12            [ 2]  543 	jra	00106$
                                    544 ;	lib/gpio_s3.c: 115: case GPIO_PORT_PC: PC_ODR ^= pin; break;
      0086C2                        545 00103$:
      0086C2 C6 50 0A         [ 1]  546 	ld	a, 0x500a
      0086C5 18 03            [ 1]  547 	xor	a, (0x03, sp)
      0086C7 C7 50 0A         [ 1]  548 	ld	0x500a, a
      0086CA 20 08            [ 2]  549 	jra	00106$
                                    550 ;	lib/gpio_s3.c: 116: case GPIO_PORT_PD: PD_ODR ^= pin; break;
      0086CC                        551 00104$:
      0086CC C6 50 0F         [ 1]  552 	ld	a, 0x500f
      0086CF 18 03            [ 1]  553 	xor	a, (0x03, sp)
      0086D1 C7 50 0F         [ 1]  554 	ld	0x500f, a
                                    555 ;	lib/gpio_s3.c: 117: }
      0086D4                        556 00106$:
                                    557 ;	lib/gpio_s3.c: 118: }
      0086D4 85               [ 2]  558 	popw	x
      0086D5 84               [ 1]  559 	pop	a
      0086D6 FC               [ 2]  560 	jp	(x)
                                    561 ;	lib/gpio_s3.c: 120: uint8_t GPIO_Read(uint8_t port, uint8_t pin)
                                    562 ;	-----------------------------------------
                                    563 ;	 function GPIO_Read
                                    564 ;	-----------------------------------------
      0086D7                        565 _GPIO_Read:
                                    566 ;	lib/gpio_s3.c: 122: switch(port) {
      0086D7 A1 00            [ 1]  567 	cp	a, #0x00
      0086D9 27 0E            [ 1]  568 	jreq	00101$
      0086DB A1 01            [ 1]  569 	cp	a, #0x01
      0086DD 27 16            [ 1]  570 	jreq	00102$
      0086DF A1 02            [ 1]  571 	cp	a, #0x02
      0086E1 27 1E            [ 1]  572 	jreq	00103$
      0086E3 A1 03            [ 1]  573 	cp	a, #0x03
      0086E5 27 26            [ 1]  574 	jreq	00104$
      0086E7 20 2F            [ 2]  575 	jra	00105$
                                    576 ;	lib/gpio_s3.c: 123: case GPIO_PORT_PA: return ((PA_IDR & pin) != 0);
      0086E9                        577 00101$:
      0086E9 C6 50 01         [ 1]  578 	ld	a, 0x5001
      0086EC 14 03            [ 1]  579 	and	a, (0x03, sp)
      0086EE A0 01            [ 1]  580 	sub	a, #0x01
      0086F0 4F               [ 1]  581 	clr	a
      0086F1 8C               [ 1]  582 	ccf
      0086F2 49               [ 1]  583 	rlc	a
      0086F3 20 24            [ 2]  584 	jra	00107$
                                    585 ;	lib/gpio_s3.c: 124: case GPIO_PORT_PB: return ((PB_IDR & pin) != 0);
      0086F5                        586 00102$:
      0086F5 C6 50 06         [ 1]  587 	ld	a, 0x5006
      0086F8 14 03            [ 1]  588 	and	a, (0x03, sp)
      0086FA A0 01            [ 1]  589 	sub	a, #0x01
      0086FC 4F               [ 1]  590 	clr	a
      0086FD 8C               [ 1]  591 	ccf
      0086FE 49               [ 1]  592 	rlc	a
      0086FF 20 18            [ 2]  593 	jra	00107$
                                    594 ;	lib/gpio_s3.c: 125: case GPIO_PORT_PC: return ((PC_IDR & pin) != 0);
      008701                        595 00103$:
      008701 C6 50 0B         [ 1]  596 	ld	a, 0x500b
      008704 14 03            [ 1]  597 	and	a, (0x03, sp)
      008706 A0 01            [ 1]  598 	sub	a, #0x01
      008708 4F               [ 1]  599 	clr	a
      008709 8C               [ 1]  600 	ccf
      00870A 49               [ 1]  601 	rlc	a
      00870B 20 0C            [ 2]  602 	jra	00107$
                                    603 ;	lib/gpio_s3.c: 126: case GPIO_PORT_PD: return ((PD_IDR & pin) != 0);
      00870D                        604 00104$:
      00870D C6 50 10         [ 1]  605 	ld	a, 0x5010
      008710 14 03            [ 1]  606 	and	a, (0x03, sp)
      008712 A0 01            [ 1]  607 	sub	a, #0x01
      008714 4F               [ 1]  608 	clr	a
      008715 8C               [ 1]  609 	ccf
      008716 49               [ 1]  610 	rlc	a
                                    611 ;	lib/gpio_s3.c: 127: default: return 0;
                                    612 ;	lib/gpio_s3.c: 128: }
      008717 21                     613 	.byte 0x21
      008718                        614 00105$:
      008718 4F               [ 1]  615 	clr	a
      008719                        616 00107$:
                                    617 ;	lib/gpio_s3.c: 129: }
      008719 85               [ 2]  618 	popw	x
      00871A 5B 01            [ 2]  619 	addw	sp, #1
      00871C FC               [ 2]  620 	jp	(x)
                                    621 ;	lib/gpio_s3.c: 131: void GPIO_Write(uint8_t port, uint8_t pin, uint8_t state)
                                    622 ;	-----------------------------------------
                                    623 ;	 function GPIO_Write
                                    624 ;	-----------------------------------------
      00871D                        625 _GPIO_Write:
      00871D 97               [ 1]  626 	ld	xl, a
                                    627 ;	lib/gpio_s3.c: 133: if(state) {
      00871E 0D 04            [ 1]  628 	tnz	(0x04, sp)
      008720 27 09            [ 1]  629 	jreq	00102$
                                    630 ;	lib/gpio_s3.c: 134: GPIO_WriteHigh(port, pin);
      008722 7B 03            [ 1]  631 	ld	a, (0x03, sp)
      008724 88               [ 1]  632 	push	a
      008725 9F               [ 1]  633 	ld	a, xl
      008726 CD 86 1D         [ 4]  634 	call	_GPIO_WriteHigh
      008729 20 07            [ 2]  635 	jra	00104$
      00872B                        636 00102$:
                                    637 ;	lib/gpio_s3.c: 136: GPIO_WriteLow(port, pin);
      00872B 7B 03            [ 1]  638 	ld	a, (0x03, sp)
      00872D 88               [ 1]  639 	push	a
      00872E 9F               [ 1]  640 	ld	a, xl
      00872F CD 86 58         [ 4]  641 	call	_GPIO_WriteLow
      008732                        642 00104$:
                                    643 ;	lib/gpio_s3.c: 138: }
      008732 1E 01            [ 2]  644 	ldw	x, (1, sp)
      008734 5B 04            [ 2]  645 	addw	sp, #4
      008736 FC               [ 2]  646 	jp	(x)
                                    647 	.area CODE
                                    648 	.area CONST
                                    649 	.area INITIALIZER
                                    650 	.area CABS (ABS)
