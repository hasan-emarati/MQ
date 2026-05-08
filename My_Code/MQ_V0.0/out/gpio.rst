                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module gpio
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
                                     53 ;	lib/gpio.c: 3: void GPIO_Init(uint8_t port, uint8_t pin, GPIO_Mode mode, GPIO_Speed speed)
                                     54 ;	-----------------------------------------
                                     55 ;	 function GPIO_Init
                                     56 ;	-----------------------------------------
      008167                         57 _GPIO_Init:
      008167 52 0A            [ 2]   58 	sub	sp, #10
                                     59 ;	lib/gpio.c: 7: switch(port) {
      008169 97               [ 1]   60 	ld	xl, a
      00816A 26 04            [ 1]   61 	jrne	00294$
      00816C 4C               [ 1]   62 	inc	a
      00816D 6B 01            [ 1]   63 	ld	(0x01, sp), a
      00816F C5                      64 	.byte 0xc5
      008170                         65 00294$:
      008170 0F 01            [ 1]   66 	clr	(0x01, sp)
      008172                         67 00295$:
      008172 9F               [ 1]   68 	ld	a, xl
      008173 4A               [ 1]   69 	dec	a
      008174 26 05            [ 1]   70 	jrne	00297$
      008176 A6 01            [ 1]   71 	ld	a, #0x01
      008178 6B 02            [ 1]   72 	ld	(0x02, sp), a
      00817A C5                      73 	.byte 0xc5
      00817B                         74 00297$:
      00817B 0F 02            [ 1]   75 	clr	(0x02, sp)
      00817D                         76 00298$:
      00817D 9F               [ 1]   77 	ld	a, xl
      00817E A0 02            [ 1]   78 	sub	a, #0x02
      008180 26 04            [ 1]   79 	jrne	00300$
      008182 4C               [ 1]   80 	inc	a
      008183 6B 03            [ 1]   81 	ld	(0x03, sp), a
      008185 C5                      82 	.byte 0xc5
      008186                         83 00300$:
      008186 0F 03            [ 1]   84 	clr	(0x03, sp)
      008188                         85 00301$:
      008188 9F               [ 1]   86 	ld	a, xl
      008189 A1 03            [ 1]   87 	cp	a, #0x03
      00818B 26 05            [ 1]   88 	jrne	00303$
      00818D A6 01            [ 1]   89 	ld	a, #0x01
      00818F 6B 04            [ 1]   90 	ld	(0x04, sp), a
      008191 C5                      91 	.byte 0xc5
      008192                         92 00303$:
      008192 0F 04            [ 1]   93 	clr	(0x04, sp)
      008194                         94 00304$:
      008194 0D 01            [ 1]   95 	tnz	(0x01, sp)
      008196 26 0F            [ 1]   96 	jrne	00101$
      008198 0D 02            [ 1]   97 	tnz	(0x02, sp)
      00819A 26 1A            [ 1]   98 	jrne	00102$
      00819C 0D 03            [ 1]   99 	tnz	(0x03, sp)
      00819E 26 25            [ 1]  100 	jrne	00103$
      0081A0 0D 04            [ 1]  101 	tnz	(0x04, sp)
      0081A2 26 30            [ 1]  102 	jrne	00104$
      0081A4 CC 83 5B         [ 2]  103 	jp	00137$
                                    104 ;	lib/gpio.c: 8: case GPIO_PORT_PA:
      0081A7                        105 00101$:
                                    106 ;	lib/gpio.c: 9: ddr = &PA_DDR;
      0081A7 AE 50 02         [ 2]  107 	ldw	x, #0x5002
      0081AA 1F 05            [ 2]  108 	ldw	(0x05, sp), x
                                    109 ;	lib/gpio.c: 10: cr1 = &PA_CR1;
      0081AC AE 50 03         [ 2]  110 	ldw	x, #0x5003
      0081AF 1F 07            [ 2]  111 	ldw	(0x07, sp), x
                                    112 ;	lib/gpio.c: 11: cr2 = &PA_CR2;
      0081B1 AE 50 04         [ 2]  113 	ldw	x, #0x5004
                                    114 ;	lib/gpio.c: 12: break;
      0081B4 20 2B            [ 2]  115 	jra	00106$
                                    116 ;	lib/gpio.c: 13: case GPIO_PORT_PB:
      0081B6                        117 00102$:
                                    118 ;	lib/gpio.c: 14: ddr = &PB_DDR;
      0081B6 AE 50 07         [ 2]  119 	ldw	x, #0x5007
      0081B9 1F 05            [ 2]  120 	ldw	(0x05, sp), x
                                    121 ;	lib/gpio.c: 15: cr1 = &PB_CR1;
      0081BB AE 50 08         [ 2]  122 	ldw	x, #0x5008
      0081BE 1F 07            [ 2]  123 	ldw	(0x07, sp), x
                                    124 ;	lib/gpio.c: 16: cr2 = &PB_CR2;
      0081C0 AE 50 09         [ 2]  125 	ldw	x, #0x5009
                                    126 ;	lib/gpio.c: 17: break;
      0081C3 20 1C            [ 2]  127 	jra	00106$
                                    128 ;	lib/gpio.c: 18: case GPIO_PORT_PC:
      0081C5                        129 00103$:
                                    130 ;	lib/gpio.c: 19: ddr = &PC_DDR;
      0081C5 AE 50 0C         [ 2]  131 	ldw	x, #0x500c
      0081C8 1F 05            [ 2]  132 	ldw	(0x05, sp), x
                                    133 ;	lib/gpio.c: 20: cr1 = &PC_CR1;
      0081CA AE 50 0D         [ 2]  134 	ldw	x, #0x500d
      0081CD 1F 07            [ 2]  135 	ldw	(0x07, sp), x
                                    136 ;	lib/gpio.c: 21: cr2 = &PC_CR2;
      0081CF AE 50 0E         [ 2]  137 	ldw	x, #0x500e
                                    138 ;	lib/gpio.c: 22: break;
      0081D2 20 0D            [ 2]  139 	jra	00106$
                                    140 ;	lib/gpio.c: 23: case GPIO_PORT_PD:
      0081D4                        141 00104$:
                                    142 ;	lib/gpio.c: 24: ddr = &PD_DDR;
      0081D4 AE 50 11         [ 2]  143 	ldw	x, #0x5011
      0081D7 1F 05            [ 2]  144 	ldw	(0x05, sp), x
                                    145 ;	lib/gpio.c: 25: cr1 = &PD_CR1;
      0081D9 AE 50 12         [ 2]  146 	ldw	x, #0x5012
      0081DC 1F 07            [ 2]  147 	ldw	(0x07, sp), x
                                    148 ;	lib/gpio.c: 26: cr2 = &PD_CR2;
      0081DE AE 50 13         [ 2]  149 	ldw	x, #0x5013
                                    150 ;	lib/gpio.c: 27: break;
                                    151 ;	lib/gpio.c: 28: default:
                                    152 ;	lib/gpio.c: 29: return;
                                    153 ;	lib/gpio.c: 30: }
      0081E1                        154 00106$:
                                    155 ;	lib/gpio.c: 33: *cr2 |= pin;
      0081E1 F6               [ 1]  156 	ld	a, (x)
                                    157 ;	lib/gpio.c: 35: *cr2 &= ~pin;
      0081E2 88               [ 1]  158 	push	a
      0081E3 7B 0E            [ 1]  159 	ld	a, (0x0e, sp)
      0081E5 43               [ 1]  160 	cpl	a
      0081E6 6B 0A            [ 1]  161 	ld	(0x0a, sp), a
      0081E8 84               [ 1]  162 	pop	a
                                    163 ;	lib/gpio.c: 32: if(speed == GPIO_SPEED_FAST) {
      0081E9 0D 0F            [ 1]  164 	tnz	(0x0f, sp)
      0081EB 27 05            [ 1]  165 	jreq	00108$
                                    166 ;	lib/gpio.c: 33: *cr2 |= pin;
      0081ED 1A 0D            [ 1]  167 	or	a, (0x0d, sp)
      0081EF F7               [ 1]  168 	ld	(x), a
      0081F0 20 03            [ 2]  169 	jra	00109$
      0081F2                        170 00108$:
                                    171 ;	lib/gpio.c: 35: *cr2 &= ~pin;
      0081F2 14 09            [ 1]  172 	and	a, (0x09, sp)
      0081F4 F7               [ 1]  173 	ld	(x), a
      0081F5                        174 00109$:
                                    175 ;	lib/gpio.c: 38: switch(mode) {
      0081F5 7B 0E            [ 1]  176 	ld	a, (0x0e, sp)
      0081F7 A1 05            [ 1]  177 	cp	a, #0x05
      0081F9 23 03            [ 2]  178 	jrule	00310$
      0081FB CC 83 5B         [ 2]  179 	jp	00137$
      0081FE                        180 00310$:
                                    181 ;	lib/gpio.c: 40: *ddr &= ~pin;
      0081FE 1E 05            [ 2]  182 	ldw	x, (0x05, sp)
      008200 F6               [ 1]  183 	ld	a, (x)
      008201 88               [ 1]  184 	push	a
      008202 14 0A            [ 1]  185 	and	a, (0x0a, sp)
      008204 6B 0B            [ 1]  186 	ld	(0x0b, sp), a
      008206 84               [ 1]  187 	pop	a
                                    188 ;	lib/gpio.c: 48: *ddr |= pin;
      008207 1A 0D            [ 1]  189 	or	a, (0x0d, sp)
                                    190 ;	lib/gpio.c: 38: switch(mode) {
      008209 5F               [ 1]  191 	clrw	x
      00820A 41               [ 1]  192 	exg	a, xl
      00820B 7B 0E            [ 1]  193 	ld	a, (0x0e, sp)
      00820D 41               [ 1]  194 	exg	a, xl
      00820E 58               [ 2]  195 	sllw	x
      00820F DE 82 13         [ 2]  196 	ldw	x, (#00311$, x)
      008212 FC               [ 2]  197 	jp	(x)
      008213                        198 00311$:
      008213 82 1F                  199 	.dw	#00110$
      008215 82 2F                  200 	.dw	#00111$
      008217 82 3F                  201 	.dw	#00112$
      008219 82 89                  202 	.dw	#00118$
      00821B 82 D3                  203 	.dw	#00124$
      00821D 83 18                  204 	.dw	#00130$
                                    205 ;	lib/gpio.c: 39: case GPIO_MODE_INPUT_FLOATING:
      00821F                        206 00110$:
                                    207 ;	lib/gpio.c: 40: *ddr &= ~pin;
      00821F 1E 05            [ 2]  208 	ldw	x, (0x05, sp)
      008221 7B 0A            [ 1]  209 	ld	a, (0x0a, sp)
      008223 F7               [ 1]  210 	ld	(x), a
                                    211 ;	lib/gpio.c: 41: *cr1 &= ~pin;
      008224 1E 07            [ 2]  212 	ldw	x, (0x07, sp)
      008226 F6               [ 1]  213 	ld	a, (x)
      008227 14 09            [ 1]  214 	and	a, (0x09, sp)
      008229 1E 07            [ 2]  215 	ldw	x, (0x07, sp)
      00822B F7               [ 1]  216 	ld	(x), a
                                    217 ;	lib/gpio.c: 42: break;
      00822C CC 83 5B         [ 2]  218 	jp	00137$
                                    219 ;	lib/gpio.c: 43: case GPIO_MODE_INPUT_PULL_UP:
      00822F                        220 00111$:
                                    221 ;	lib/gpio.c: 44: *ddr &= ~pin;
      00822F 1E 05            [ 2]  222 	ldw	x, (0x05, sp)
      008231 7B 0A            [ 1]  223 	ld	a, (0x0a, sp)
      008233 F7               [ 1]  224 	ld	(x), a
                                    225 ;	lib/gpio.c: 45: *cr1 |= pin;
      008234 1E 07            [ 2]  226 	ldw	x, (0x07, sp)
      008236 F6               [ 1]  227 	ld	a, (x)
      008237 1A 0D            [ 1]  228 	or	a, (0x0d, sp)
      008239 1E 07            [ 2]  229 	ldw	x, (0x07, sp)
      00823B F7               [ 1]  230 	ld	(x), a
                                    231 ;	lib/gpio.c: 46: break;
      00823C CC 83 5B         [ 2]  232 	jp	00137$
                                    233 ;	lib/gpio.c: 47: case GPIO_MODE_OUTPUT_PUSH_PULL_LOW:
      00823F                        234 00112$:
                                    235 ;	lib/gpio.c: 48: *ddr |= pin;
      00823F 1E 05            [ 2]  236 	ldw	x, (0x05, sp)
      008241 F7               [ 1]  237 	ld	(x), a
                                    238 ;	lib/gpio.c: 49: *cr1 |= pin;
      008242 1E 07            [ 2]  239 	ldw	x, (0x07, sp)
      008244 F6               [ 1]  240 	ld	a, (x)
      008245 1A 0D            [ 1]  241 	or	a, (0x0d, sp)
      008247 1E 07            [ 2]  242 	ldw	x, (0x07, sp)
      008249 F7               [ 1]  243 	ld	(x), a
                                    244 ;	lib/gpio.c: 50: switch(port) {
      00824A 0D 01            [ 1]  245 	tnz	(0x01, sp)
      00824C 26 0F            [ 1]  246 	jrne	00113$
      00824E 0D 02            [ 1]  247 	tnz	(0x02, sp)
      008250 26 16            [ 1]  248 	jrne	00114$
      008252 0D 03            [ 1]  249 	tnz	(0x03, sp)
      008254 26 1D            [ 1]  250 	jrne	00115$
      008256 0D 04            [ 1]  251 	tnz	(0x04, sp)
      008258 26 24            [ 1]  252 	jrne	00116$
      00825A CC 83 5B         [ 2]  253 	jp	00137$
                                    254 ;	lib/gpio.c: 51: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      00825D                        255 00113$:
      00825D C6 50 00         [ 1]  256 	ld	a, 0x5000
      008260 14 09            [ 1]  257 	and	a, (0x09, sp)
      008262 C7 50 00         [ 1]  258 	ld	0x5000, a
      008265 CC 83 5B         [ 2]  259 	jp	00137$
                                    260 ;	lib/gpio.c: 52: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      008268                        261 00114$:
      008268 C6 50 05         [ 1]  262 	ld	a, 0x5005
      00826B 14 09            [ 1]  263 	and	a, (0x09, sp)
      00826D C7 50 05         [ 1]  264 	ld	0x5005, a
      008270 CC 83 5B         [ 2]  265 	jp	00137$
                                    266 ;	lib/gpio.c: 53: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      008273                        267 00115$:
      008273 C6 50 0A         [ 1]  268 	ld	a, 0x500a
      008276 14 09            [ 1]  269 	and	a, (0x09, sp)
      008278 C7 50 0A         [ 1]  270 	ld	0x500a, a
      00827B CC 83 5B         [ 2]  271 	jp	00137$
                                    272 ;	lib/gpio.c: 54: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      00827E                        273 00116$:
      00827E C6 50 0F         [ 1]  274 	ld	a, 0x500f
      008281 14 09            [ 1]  275 	and	a, (0x09, sp)
      008283 C7 50 0F         [ 1]  276 	ld	0x500f, a
                                    277 ;	lib/gpio.c: 56: break;
      008286 CC 83 5B         [ 2]  278 	jp	00137$
                                    279 ;	lib/gpio.c: 57: case GPIO_MODE_OUTPUT_PUSH_PULL_HIGH:
      008289                        280 00118$:
                                    281 ;	lib/gpio.c: 58: *ddr |= pin;
      008289 1E 05            [ 2]  282 	ldw	x, (0x05, sp)
      00828B F7               [ 1]  283 	ld	(x), a
                                    284 ;	lib/gpio.c: 59: *cr1 |= pin;
      00828C 1E 07            [ 2]  285 	ldw	x, (0x07, sp)
      00828E F6               [ 1]  286 	ld	a, (x)
      00828F 1A 0D            [ 1]  287 	or	a, (0x0d, sp)
      008291 1E 07            [ 2]  288 	ldw	x, (0x07, sp)
      008293 F7               [ 1]  289 	ld	(x), a
                                    290 ;	lib/gpio.c: 60: switch(port) {
      008294 0D 01            [ 1]  291 	tnz	(0x01, sp)
      008296 26 0F            [ 1]  292 	jrne	00119$
      008298 0D 02            [ 1]  293 	tnz	(0x02, sp)
      00829A 26 16            [ 1]  294 	jrne	00120$
      00829C 0D 03            [ 1]  295 	tnz	(0x03, sp)
      00829E 26 1D            [ 1]  296 	jrne	00121$
      0082A0 0D 04            [ 1]  297 	tnz	(0x04, sp)
      0082A2 26 24            [ 1]  298 	jrne	00122$
      0082A4 CC 83 5B         [ 2]  299 	jp	00137$
                                    300 ;	lib/gpio.c: 61: case GPIO_PORT_PA: PA_ODR |= pin; break;
      0082A7                        301 00119$:
      0082A7 C6 50 00         [ 1]  302 	ld	a, 0x5000
      0082AA 1A 0D            [ 1]  303 	or	a, (0x0d, sp)
      0082AC C7 50 00         [ 1]  304 	ld	0x5000, a
      0082AF CC 83 5B         [ 2]  305 	jp	00137$
                                    306 ;	lib/gpio.c: 62: case GPIO_PORT_PB: PB_ODR |= pin; break;
      0082B2                        307 00120$:
      0082B2 C6 50 05         [ 1]  308 	ld	a, 0x5005
      0082B5 1A 0D            [ 1]  309 	or	a, (0x0d, sp)
      0082B7 C7 50 05         [ 1]  310 	ld	0x5005, a
      0082BA CC 83 5B         [ 2]  311 	jp	00137$
                                    312 ;	lib/gpio.c: 63: case GPIO_PORT_PC: PC_ODR |= pin; break;
      0082BD                        313 00121$:
      0082BD C6 50 0A         [ 1]  314 	ld	a, 0x500a
      0082C0 1A 0D            [ 1]  315 	or	a, (0x0d, sp)
      0082C2 C7 50 0A         [ 1]  316 	ld	0x500a, a
      0082C5 CC 83 5B         [ 2]  317 	jp	00137$
                                    318 ;	lib/gpio.c: 64: case GPIO_PORT_PD: PD_ODR |= pin; break;
      0082C8                        319 00122$:
      0082C8 C6 50 0F         [ 1]  320 	ld	a, 0x500f
      0082CB 1A 0D            [ 1]  321 	or	a, (0x0d, sp)
      0082CD C7 50 0F         [ 1]  322 	ld	0x500f, a
                                    323 ;	lib/gpio.c: 66: break;
      0082D0 CC 83 5B         [ 2]  324 	jp	00137$
                                    325 ;	lib/gpio.c: 67: case GPIO_MODE_OUTPUT_OPEN_DRAIN_LOW:
      0082D3                        326 00124$:
                                    327 ;	lib/gpio.c: 68: *ddr |= pin;
      0082D3 1E 05            [ 2]  328 	ldw	x, (0x05, sp)
      0082D5 F7               [ 1]  329 	ld	(x), a
                                    330 ;	lib/gpio.c: 69: *cr1 &= ~pin;
      0082D6 1E 07            [ 2]  331 	ldw	x, (0x07, sp)
      0082D8 F6               [ 1]  332 	ld	a, (x)
      0082D9 14 09            [ 1]  333 	and	a, (0x09, sp)
      0082DB 1E 07            [ 2]  334 	ldw	x, (0x07, sp)
      0082DD F7               [ 1]  335 	ld	(x), a
                                    336 ;	lib/gpio.c: 70: switch(port) {
      0082DE 0D 01            [ 1]  337 	tnz	(0x01, sp)
      0082E0 26 0E            [ 1]  338 	jrne	00125$
      0082E2 0D 02            [ 1]  339 	tnz	(0x02, sp)
      0082E4 26 14            [ 1]  340 	jrne	00126$
      0082E6 0D 03            [ 1]  341 	tnz	(0x03, sp)
      0082E8 26 1A            [ 1]  342 	jrne	00127$
      0082EA 0D 04            [ 1]  343 	tnz	(0x04, sp)
      0082EC 26 20            [ 1]  344 	jrne	00128$
      0082EE 20 6B            [ 2]  345 	jra	00137$
                                    346 ;	lib/gpio.c: 71: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      0082F0                        347 00125$:
      0082F0 C6 50 00         [ 1]  348 	ld	a, 0x5000
      0082F3 14 09            [ 1]  349 	and	a, (0x09, sp)
      0082F5 C7 50 00         [ 1]  350 	ld	0x5000, a
      0082F8 20 61            [ 2]  351 	jra	00137$
                                    352 ;	lib/gpio.c: 72: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      0082FA                        353 00126$:
      0082FA C6 50 05         [ 1]  354 	ld	a, 0x5005
      0082FD 14 09            [ 1]  355 	and	a, (0x09, sp)
      0082FF C7 50 05         [ 1]  356 	ld	0x5005, a
      008302 20 57            [ 2]  357 	jra	00137$
                                    358 ;	lib/gpio.c: 73: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      008304                        359 00127$:
      008304 C6 50 0A         [ 1]  360 	ld	a, 0x500a
      008307 14 09            [ 1]  361 	and	a, (0x09, sp)
      008309 C7 50 0A         [ 1]  362 	ld	0x500a, a
      00830C 20 4D            [ 2]  363 	jra	00137$
                                    364 ;	lib/gpio.c: 74: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      00830E                        365 00128$:
      00830E C6 50 0F         [ 1]  366 	ld	a, 0x500f
      008311 14 09            [ 1]  367 	and	a, (0x09, sp)
      008313 C7 50 0F         [ 1]  368 	ld	0x500f, a
                                    369 ;	lib/gpio.c: 76: break;
      008316 20 43            [ 2]  370 	jra	00137$
                                    371 ;	lib/gpio.c: 77: case GPIO_MODE_OUTPUT_OPEN_DRAIN_HIGH:
      008318                        372 00130$:
                                    373 ;	lib/gpio.c: 78: *ddr |= pin;
      008318 1E 05            [ 2]  374 	ldw	x, (0x05, sp)
      00831A F7               [ 1]  375 	ld	(x), a
                                    376 ;	lib/gpio.c: 79: *cr1 &= ~pin;
      00831B 1E 07            [ 2]  377 	ldw	x, (0x07, sp)
      00831D F6               [ 1]  378 	ld	a, (x)
      00831E 14 09            [ 1]  379 	and	a, (0x09, sp)
      008320 1E 07            [ 2]  380 	ldw	x, (0x07, sp)
      008322 F7               [ 1]  381 	ld	(x), a
                                    382 ;	lib/gpio.c: 80: switch(port) {
      008323 0D 01            [ 1]  383 	tnz	(0x01, sp)
      008325 26 0E            [ 1]  384 	jrne	00131$
      008327 0D 02            [ 1]  385 	tnz	(0x02, sp)
      008329 26 14            [ 1]  386 	jrne	00132$
      00832B 0D 03            [ 1]  387 	tnz	(0x03, sp)
      00832D 26 1A            [ 1]  388 	jrne	00133$
      00832F 0D 04            [ 1]  389 	tnz	(0x04, sp)
      008331 26 20            [ 1]  390 	jrne	00134$
      008333 20 26            [ 2]  391 	jra	00137$
                                    392 ;	lib/gpio.c: 81: case GPIO_PORT_PA: PA_ODR |= pin; break;
      008335                        393 00131$:
      008335 C6 50 00         [ 1]  394 	ld	a, 0x5000
      008338 1A 0D            [ 1]  395 	or	a, (0x0d, sp)
      00833A C7 50 00         [ 1]  396 	ld	0x5000, a
      00833D 20 1C            [ 2]  397 	jra	00137$
                                    398 ;	lib/gpio.c: 82: case GPIO_PORT_PB: PB_ODR |= pin; break;
      00833F                        399 00132$:
      00833F C6 50 05         [ 1]  400 	ld	a, 0x5005
      008342 1A 0D            [ 1]  401 	or	a, (0x0d, sp)
      008344 C7 50 05         [ 1]  402 	ld	0x5005, a
      008347 20 12            [ 2]  403 	jra	00137$
                                    404 ;	lib/gpio.c: 83: case GPIO_PORT_PC: PC_ODR |= pin; break;
      008349                        405 00133$:
      008349 C6 50 0A         [ 1]  406 	ld	a, 0x500a
      00834C 1A 0D            [ 1]  407 	or	a, (0x0d, sp)
      00834E C7 50 0A         [ 1]  408 	ld	0x500a, a
      008351 20 08            [ 2]  409 	jra	00137$
                                    410 ;	lib/gpio.c: 84: case GPIO_PORT_PD: PD_ODR |= pin; break;
      008353                        411 00134$:
      008353 C6 50 0F         [ 1]  412 	ld	a, 0x500f
      008356 1A 0D            [ 1]  413 	or	a, (0x0d, sp)
      008358 C7 50 0F         [ 1]  414 	ld	0x500f, a
                                    415 ;	lib/gpio.c: 87: }
      00835B                        416 00137$:
                                    417 ;	lib/gpio.c: 88: }
      00835B 1E 0B            [ 2]  418 	ldw	x, (11, sp)
      00835D 5B 0F            [ 2]  419 	addw	sp, #15
      00835F FC               [ 2]  420 	jp	(x)
                                    421 ;	lib/gpio.c: 90: void GPIO_WriteHigh(uint8_t port, uint8_t pin)
                                    422 ;	-----------------------------------------
                                    423 ;	 function GPIO_WriteHigh
                                    424 ;	-----------------------------------------
      008360                        425 _GPIO_WriteHigh:
                                    426 ;	lib/gpio.c: 92: switch(port) {
      008360 A1 00            [ 1]  427 	cp	a, #0x00
      008362 27 0E            [ 1]  428 	jreq	00101$
      008364 A1 01            [ 1]  429 	cp	a, #0x01
      008366 27 14            [ 1]  430 	jreq	00102$
      008368 A1 02            [ 1]  431 	cp	a, #0x02
      00836A 27 1A            [ 1]  432 	jreq	00103$
      00836C A1 03            [ 1]  433 	cp	a, #0x03
      00836E 27 20            [ 1]  434 	jreq	00104$
      008370 20 26            [ 2]  435 	jra	00106$
                                    436 ;	lib/gpio.c: 93: case GPIO_PORT_PA: PA_ODR |= pin; break;
      008372                        437 00101$:
      008372 C6 50 00         [ 1]  438 	ld	a, 0x5000
      008375 1A 03            [ 1]  439 	or	a, (0x03, sp)
      008377 C7 50 00         [ 1]  440 	ld	0x5000, a
      00837A 20 1C            [ 2]  441 	jra	00106$
                                    442 ;	lib/gpio.c: 94: case GPIO_PORT_PB: PB_ODR |= pin; break;
      00837C                        443 00102$:
      00837C C6 50 05         [ 1]  444 	ld	a, 0x5005
      00837F 1A 03            [ 1]  445 	or	a, (0x03, sp)
      008381 C7 50 05         [ 1]  446 	ld	0x5005, a
      008384 20 12            [ 2]  447 	jra	00106$
                                    448 ;	lib/gpio.c: 95: case GPIO_PORT_PC: PC_ODR |= pin; break;
      008386                        449 00103$:
      008386 C6 50 0A         [ 1]  450 	ld	a, 0x500a
      008389 1A 03            [ 1]  451 	or	a, (0x03, sp)
      00838B C7 50 0A         [ 1]  452 	ld	0x500a, a
      00838E 20 08            [ 2]  453 	jra	00106$
                                    454 ;	lib/gpio.c: 96: case GPIO_PORT_PD: PD_ODR |= pin; break;
      008390                        455 00104$:
      008390 C6 50 0F         [ 1]  456 	ld	a, 0x500f
      008393 1A 03            [ 1]  457 	or	a, (0x03, sp)
      008395 C7 50 0F         [ 1]  458 	ld	0x500f, a
                                    459 ;	lib/gpio.c: 97: }
      008398                        460 00106$:
                                    461 ;	lib/gpio.c: 98: }
      008398 85               [ 2]  462 	popw	x
      008399 84               [ 1]  463 	pop	a
      00839A FC               [ 2]  464 	jp	(x)
                                    465 ;	lib/gpio.c: 100: void GPIO_WriteLow(uint8_t port, uint8_t pin)
                                    466 ;	-----------------------------------------
                                    467 ;	 function GPIO_WriteLow
                                    468 ;	-----------------------------------------
      00839B                        469 _GPIO_WriteLow:
      00839B 88               [ 1]  470 	push	a
                                    471 ;	lib/gpio.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      00839C 88               [ 1]  472 	push	a
      00839D 7B 05            [ 1]  473 	ld	a, (0x05, sp)
      00839F 43               [ 1]  474 	cpl	a
      0083A0 6B 02            [ 1]  475 	ld	(0x02, sp), a
      0083A2 84               [ 1]  476 	pop	a
                                    477 ;	lib/gpio.c: 102: switch(port) {
      0083A3 A1 00            [ 1]  478 	cp	a, #0x00
      0083A5 27 0E            [ 1]  479 	jreq	00101$
      0083A7 A1 01            [ 1]  480 	cp	a, #0x01
      0083A9 27 14            [ 1]  481 	jreq	00102$
      0083AB A1 02            [ 1]  482 	cp	a, #0x02
      0083AD 27 1A            [ 1]  483 	jreq	00103$
      0083AF A1 03            [ 1]  484 	cp	a, #0x03
      0083B1 27 20            [ 1]  485 	jreq	00104$
      0083B3 20 26            [ 2]  486 	jra	00106$
                                    487 ;	lib/gpio.c: 103: case GPIO_PORT_PA: PA_ODR &= ~pin; break;
      0083B5                        488 00101$:
      0083B5 C6 50 00         [ 1]  489 	ld	a, 0x5000
      0083B8 14 01            [ 1]  490 	and	a, (0x01, sp)
      0083BA C7 50 00         [ 1]  491 	ld	0x5000, a
      0083BD 20 1C            [ 2]  492 	jra	00106$
                                    493 ;	lib/gpio.c: 104: case GPIO_PORT_PB: PB_ODR &= ~pin; break;
      0083BF                        494 00102$:
      0083BF C6 50 05         [ 1]  495 	ld	a, 0x5005
      0083C2 14 01            [ 1]  496 	and	a, (0x01, sp)
      0083C4 C7 50 05         [ 1]  497 	ld	0x5005, a
      0083C7 20 12            [ 2]  498 	jra	00106$
                                    499 ;	lib/gpio.c: 105: case GPIO_PORT_PC: PC_ODR &= ~pin; break;
      0083C9                        500 00103$:
      0083C9 C6 50 0A         [ 1]  501 	ld	a, 0x500a
      0083CC 14 01            [ 1]  502 	and	a, (0x01, sp)
      0083CE C7 50 0A         [ 1]  503 	ld	0x500a, a
      0083D1 20 08            [ 2]  504 	jra	00106$
                                    505 ;	lib/gpio.c: 106: case GPIO_PORT_PD: PD_ODR &= ~pin; break;
      0083D3                        506 00104$:
      0083D3 C6 50 0F         [ 1]  507 	ld	a, 0x500f
      0083D6 14 01            [ 1]  508 	and	a, (0x01, sp)
      0083D8 C7 50 0F         [ 1]  509 	ld	0x500f, a
                                    510 ;	lib/gpio.c: 107: }
      0083DB                        511 00106$:
                                    512 ;	lib/gpio.c: 108: }
      0083DB 84               [ 1]  513 	pop	a
      0083DC 85               [ 2]  514 	popw	x
      0083DD 84               [ 1]  515 	pop	a
      0083DE FC               [ 2]  516 	jp	(x)
                                    517 ;	lib/gpio.c: 110: void GPIO_Toggle(uint8_t port, uint8_t pin)
                                    518 ;	-----------------------------------------
                                    519 ;	 function GPIO_Toggle
                                    520 ;	-----------------------------------------
      0083DF                        521 _GPIO_Toggle:
                                    522 ;	lib/gpio.c: 112: switch(port) {
      0083DF A1 00            [ 1]  523 	cp	a, #0x00
      0083E1 27 0E            [ 1]  524 	jreq	00101$
      0083E3 A1 01            [ 1]  525 	cp	a, #0x01
      0083E5 27 14            [ 1]  526 	jreq	00102$
      0083E7 A1 02            [ 1]  527 	cp	a, #0x02
      0083E9 27 1A            [ 1]  528 	jreq	00103$
      0083EB A1 03            [ 1]  529 	cp	a, #0x03
      0083ED 27 20            [ 1]  530 	jreq	00104$
      0083EF 20 26            [ 2]  531 	jra	00106$
                                    532 ;	lib/gpio.c: 113: case GPIO_PORT_PA: PA_ODR ^= pin; break;
      0083F1                        533 00101$:
      0083F1 C6 50 00         [ 1]  534 	ld	a, 0x5000
      0083F4 18 03            [ 1]  535 	xor	a, (0x03, sp)
      0083F6 C7 50 00         [ 1]  536 	ld	0x5000, a
      0083F9 20 1C            [ 2]  537 	jra	00106$
                                    538 ;	lib/gpio.c: 114: case GPIO_PORT_PB: PB_ODR ^= pin; break;
      0083FB                        539 00102$:
      0083FB C6 50 05         [ 1]  540 	ld	a, 0x5005
      0083FE 18 03            [ 1]  541 	xor	a, (0x03, sp)
      008400 C7 50 05         [ 1]  542 	ld	0x5005, a
      008403 20 12            [ 2]  543 	jra	00106$
                                    544 ;	lib/gpio.c: 115: case GPIO_PORT_PC: PC_ODR ^= pin; break;
      008405                        545 00103$:
      008405 C6 50 0A         [ 1]  546 	ld	a, 0x500a
      008408 18 03            [ 1]  547 	xor	a, (0x03, sp)
      00840A C7 50 0A         [ 1]  548 	ld	0x500a, a
      00840D 20 08            [ 2]  549 	jra	00106$
                                    550 ;	lib/gpio.c: 116: case GPIO_PORT_PD: PD_ODR ^= pin; break;
      00840F                        551 00104$:
      00840F C6 50 0F         [ 1]  552 	ld	a, 0x500f
      008412 18 03            [ 1]  553 	xor	a, (0x03, sp)
      008414 C7 50 0F         [ 1]  554 	ld	0x500f, a
                                    555 ;	lib/gpio.c: 117: }
      008417                        556 00106$:
                                    557 ;	lib/gpio.c: 118: }
      008417 85               [ 2]  558 	popw	x
      008418 84               [ 1]  559 	pop	a
      008419 FC               [ 2]  560 	jp	(x)
                                    561 ;	lib/gpio.c: 120: uint8_t GPIO_Read(uint8_t port, uint8_t pin)
                                    562 ;	-----------------------------------------
                                    563 ;	 function GPIO_Read
                                    564 ;	-----------------------------------------
      00841A                        565 _GPIO_Read:
                                    566 ;	lib/gpio.c: 122: switch(port) {
      00841A A1 00            [ 1]  567 	cp	a, #0x00
      00841C 27 0E            [ 1]  568 	jreq	00101$
      00841E A1 01            [ 1]  569 	cp	a, #0x01
      008420 27 16            [ 1]  570 	jreq	00102$
      008422 A1 02            [ 1]  571 	cp	a, #0x02
      008424 27 1E            [ 1]  572 	jreq	00103$
      008426 A1 03            [ 1]  573 	cp	a, #0x03
      008428 27 26            [ 1]  574 	jreq	00104$
      00842A 20 2F            [ 2]  575 	jra	00105$
                                    576 ;	lib/gpio.c: 123: case GPIO_PORT_PA: return ((PA_IDR & pin) != 0);
      00842C                        577 00101$:
      00842C C6 50 01         [ 1]  578 	ld	a, 0x5001
      00842F 14 03            [ 1]  579 	and	a, (0x03, sp)
      008431 A0 01            [ 1]  580 	sub	a, #0x01
      008433 4F               [ 1]  581 	clr	a
      008434 8C               [ 1]  582 	ccf
      008435 49               [ 1]  583 	rlc	a
      008436 20 24            [ 2]  584 	jra	00107$
                                    585 ;	lib/gpio.c: 124: case GPIO_PORT_PB: return ((PB_IDR & pin) != 0);
      008438                        586 00102$:
      008438 C6 50 06         [ 1]  587 	ld	a, 0x5006
      00843B 14 03            [ 1]  588 	and	a, (0x03, sp)
      00843D A0 01            [ 1]  589 	sub	a, #0x01
      00843F 4F               [ 1]  590 	clr	a
      008440 8C               [ 1]  591 	ccf
      008441 49               [ 1]  592 	rlc	a
      008442 20 18            [ 2]  593 	jra	00107$
                                    594 ;	lib/gpio.c: 125: case GPIO_PORT_PC: return ((PC_IDR & pin) != 0);
      008444                        595 00103$:
      008444 C6 50 0B         [ 1]  596 	ld	a, 0x500b
      008447 14 03            [ 1]  597 	and	a, (0x03, sp)
      008449 A0 01            [ 1]  598 	sub	a, #0x01
      00844B 4F               [ 1]  599 	clr	a
      00844C 8C               [ 1]  600 	ccf
      00844D 49               [ 1]  601 	rlc	a
      00844E 20 0C            [ 2]  602 	jra	00107$
                                    603 ;	lib/gpio.c: 126: case GPIO_PORT_PD: return ((PD_IDR & pin) != 0);
      008450                        604 00104$:
      008450 C6 50 10         [ 1]  605 	ld	a, 0x5010
      008453 14 03            [ 1]  606 	and	a, (0x03, sp)
      008455 A0 01            [ 1]  607 	sub	a, #0x01
      008457 4F               [ 1]  608 	clr	a
      008458 8C               [ 1]  609 	ccf
      008459 49               [ 1]  610 	rlc	a
                                    611 ;	lib/gpio.c: 127: default: return 0;
                                    612 ;	lib/gpio.c: 128: }
      00845A 21                     613 	.byte 0x21
      00845B                        614 00105$:
      00845B 4F               [ 1]  615 	clr	a
      00845C                        616 00107$:
                                    617 ;	lib/gpio.c: 129: }
      00845C 85               [ 2]  618 	popw	x
      00845D 5B 01            [ 2]  619 	addw	sp, #1
      00845F FC               [ 2]  620 	jp	(x)
                                    621 ;	lib/gpio.c: 131: void GPIO_Write(uint8_t port, uint8_t pin, uint8_t state)
                                    622 ;	-----------------------------------------
                                    623 ;	 function GPIO_Write
                                    624 ;	-----------------------------------------
      008460                        625 _GPIO_Write:
      008460 97               [ 1]  626 	ld	xl, a
                                    627 ;	lib/gpio.c: 133: if(state) {
      008461 0D 04            [ 1]  628 	tnz	(0x04, sp)
      008463 27 09            [ 1]  629 	jreq	00102$
                                    630 ;	lib/gpio.c: 134: GPIO_WriteHigh(port, pin);
      008465 7B 03            [ 1]  631 	ld	a, (0x03, sp)
      008467 88               [ 1]  632 	push	a
      008468 9F               [ 1]  633 	ld	a, xl
      008469 CD 83 60         [ 4]  634 	call	_GPIO_WriteHigh
      00846C 20 07            [ 2]  635 	jra	00104$
      00846E                        636 00102$:
                                    637 ;	lib/gpio.c: 136: GPIO_WriteLow(port, pin);
      00846E 7B 03            [ 1]  638 	ld	a, (0x03, sp)
      008470 88               [ 1]  639 	push	a
      008471 9F               [ 1]  640 	ld	a, xl
      008472 CD 83 9B         [ 4]  641 	call	_GPIO_WriteLow
      008475                        642 00104$:
                                    643 ;	lib/gpio.c: 138: }
      008475 1E 01            [ 2]  644 	ldw	x, (1, sp)
      008477 5B 04            [ 2]  645 	addw	sp, #4
      008479 FC               [ 2]  646 	jp	(x)
                                    647 	.area CODE
                                    648 	.area CONST
                                    649 	.area INITIALIZER
                                    650 	.area CABS (ABS)
