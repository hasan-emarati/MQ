                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module oled
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _i2c_send_addr
                                     11 	.globl _i2c_write
                                     12 	.globl _i2c_stop
                                     13 	.globl _i2c_start
                                     14 	.globl _delay_ms
                                     15 	.globl _oled_init
                                     16 	.globl _oled_deinit
                                     17 	.globl _oled_clear
                                     18 	.globl _oled_clear_page
                                     19 	.globl _oled_update
                                     20 	.globl _oled_set_pixel
                                     21 	.globl _oled_draw_line
                                     22 	.globl _oled_draw_rect
                                     23 	.globl _oled_fill_rect
                                     24 	.globl _oled_gotoxy
                                     25 	.globl _oled_putc
                                     26 	.globl _oled_puts
                                     27 	.globl _oled_puts_at
                                     28 	.globl _oled_set_font
                                     29 	.globl _oled_set_contrast
                                     30 	.globl _oled_invert
                                     31 	.globl _oled_normal
                                     32 	.globl _oled_scroll_left
                                     33 	.globl _oled_scroll_right
                                     34 	.globl _oled_scroll_stop
                                     35 	.globl _oled_print_number
                                     36 	.globl _oled_print_hex
                                     37 ;--------------------------------------------------------
                                     38 ; ram data
                                     39 ;--------------------------------------------------------
                                     40 	.area DATA
      000001                         41 _oled_buffer:
      000001                         42 	.ds 512
                                     43 ;--------------------------------------------------------
                                     44 ; ram data
                                     45 ;--------------------------------------------------------
                                     46 	.area INITIALIZED
      000201                         47 _oled_cursor_x:
      000201                         48 	.ds 1
      000202                         49 _oled_cursor_y:
      000202                         50 	.ds 1
      000203                         51 _oled_current_font:
      000203                         52 	.ds 1
                                     53 ;--------------------------------------------------------
                                     54 ; absolute external ram data
                                     55 ;--------------------------------------------------------
                                     56 	.area DABS (ABS)
                                     57 
                                     58 ; default segment ordering for linker
                                     59 	.area HOME
                                     60 	.area GSINIT
                                     61 	.area GSFINAL
                                     62 	.area CONST
                                     63 	.area INITIALIZER
                                     64 	.area CODE
                                     65 
                                     66 ;--------------------------------------------------------
                                     67 ; global & static initialisations
                                     68 ;--------------------------------------------------------
                                     69 	.area HOME
                                     70 	.area GSINIT
                                     71 	.area GSFINAL
                                     72 	.area GSINIT
                                     73 ;--------------------------------------------------------
                                     74 ; Home
                                     75 ;--------------------------------------------------------
                                     76 	.area HOME
                                     77 	.area HOME
                                     78 ;--------------------------------------------------------
                                     79 ; code
                                     80 ;--------------------------------------------------------
                                     81 	.area CODE
                                     82 ;	lib/oled.c: 120: static void oled_write_cmd(unsigned char cmd)
                                     83 ;	-----------------------------------------
                                     84 ;	 function oled_write_cmd
                                     85 ;	-----------------------------------------
      0088A4                         86 _oled_write_cmd:
      0088A4 88               [ 1]   87 	push	a
      0088A5 6B 01            [ 1]   88 	ld	(0x01, sp), a
                                     89 ;	lib/oled.c: 122: i2c_start();
      0088A7 CD 87 D7         [ 4]   90 	call	_i2c_start
                                     91 ;	lib/oled.c: 123: i2c_send_addr(OLED_ADDR);
      0088AA A6 78            [ 1]   92 	ld	a, #0x78
      0088AC CD 87 F4         [ 4]   93 	call	_i2c_send_addr
                                     94 ;	lib/oled.c: 124: i2c_write(0x00);  // Command mode
      0088AF 4F               [ 1]   95 	clr	a
      0088B0 CD 87 EB         [ 4]   96 	call	_i2c_write
                                     97 ;	lib/oled.c: 125: i2c_write(cmd);
      0088B3 7B 01            [ 1]   98 	ld	a, (0x01, sp)
      0088B5 CD 87 EB         [ 4]   99 	call	_i2c_write
                                    100 ;	lib/oled.c: 126: i2c_stop();
      0088B8 84               [ 1]  101 	pop	a
      0088B9 CC 87 E1         [ 2]  102 	jp	_i2c_stop
                                    103 ;	lib/oled.c: 127: }
      0088BC 84               [ 1]  104 	pop	a
      0088BD 81               [ 4]  105 	ret
                                    106 ;	lib/oled.c: 129: static void oled_write_cmd_multi(unsigned char* cmds, unsigned char len)
                                    107 ;	-----------------------------------------
                                    108 ;	 function oled_write_cmd_multi
                                    109 ;	-----------------------------------------
      0088BE                        110 _oled_write_cmd_multi:
      0088BE 52 04            [ 2]  111 	sub	sp, #4
      0088C0 1F 02            [ 2]  112 	ldw	(0x02, sp), x
      0088C2 6B 01            [ 1]  113 	ld	(0x01, sp), a
                                    114 ;	lib/oled.c: 132: i2c_start();
      0088C4 CD 87 D7         [ 4]  115 	call	_i2c_start
                                    116 ;	lib/oled.c: 133: i2c_send_addr(OLED_ADDR);
      0088C7 A6 78            [ 1]  117 	ld	a, #0x78
      0088C9 CD 87 F4         [ 4]  118 	call	_i2c_send_addr
                                    119 ;	lib/oled.c: 134: i2c_write(0x00);
      0088CC 4F               [ 1]  120 	clr	a
      0088CD CD 87 EB         [ 4]  121 	call	_i2c_write
                                    122 ;	lib/oled.c: 135: for(i = 0; i < len; i++) {
      0088D0 0F 04            [ 1]  123 	clr	(0x04, sp)
      0088D2                        124 00103$:
      0088D2 7B 04            [ 1]  125 	ld	a, (0x04, sp)
      0088D4 11 01            [ 1]  126 	cp	a, (0x01, sp)
      0088D6 24 0F            [ 1]  127 	jrnc	00101$
                                    128 ;	lib/oled.c: 136: i2c_write(cmds[i]);
      0088D8 5F               [ 1]  129 	clrw	x
      0088D9 7B 04            [ 1]  130 	ld	a, (0x04, sp)
      0088DB 97               [ 1]  131 	ld	xl, a
      0088DC 72 FB 02         [ 2]  132 	addw	x, (0x02, sp)
      0088DF F6               [ 1]  133 	ld	a, (x)
      0088E0 CD 87 EB         [ 4]  134 	call	_i2c_write
                                    135 ;	lib/oled.c: 135: for(i = 0; i < len; i++) {
      0088E3 0C 04            [ 1]  136 	inc	(0x04, sp)
      0088E5 20 EB            [ 2]  137 	jra	00103$
      0088E7                        138 00101$:
                                    139 ;	lib/oled.c: 138: i2c_stop();
      0088E7 5B 04            [ 2]  140 	addw	sp, #4
                                    141 ;	lib/oled.c: 139: }
      0088E9 CC 87 E1         [ 2]  142 	jp	_i2c_stop
                                    143 ;	lib/oled.c: 141: static void oled_send_buffer(void)
                                    144 ;	-----------------------------------------
                                    145 ;	 function oled_send_buffer
                                    146 ;	-----------------------------------------
      0088EC                        147 _oled_send_buffer:
      0088EC 52 04            [ 2]  148 	sub	sp, #4
                                    149 ;	lib/oled.c: 145: for(page = 0; page < OLED_PAGES; page++) {
      0088EE 0F 03            [ 1]  150 	clr	(0x03, sp)
      0088F0                        151 00105$:
                                    152 ;	lib/oled.c: 147: oled_write_cmd(0xB0 | page);
      0088F0 7B 03            [ 1]  153 	ld	a, (0x03, sp)
      0088F2 AA B0            [ 1]  154 	or	a, #0xb0
      0088F4 CD 88 A4         [ 4]  155 	call	_oled_write_cmd
                                    156 ;	lib/oled.c: 148: oled_write_cmd(0x00);  // Low column
      0088F7 4F               [ 1]  157 	clr	a
      0088F8 CD 88 A4         [ 4]  158 	call	_oled_write_cmd
                                    159 ;	lib/oled.c: 149: oled_write_cmd(0x10);  // High column
      0088FB A6 10            [ 1]  160 	ld	a, #0x10
      0088FD CD 88 A4         [ 4]  161 	call	_oled_write_cmd
                                    162 ;	lib/oled.c: 152: i2c_start();
      008900 CD 87 D7         [ 4]  163 	call	_i2c_start
                                    164 ;	lib/oled.c: 153: i2c_send_addr(OLED_ADDR);
      008903 A6 78            [ 1]  165 	ld	a, #0x78
      008905 CD 87 F4         [ 4]  166 	call	_i2c_send_addr
                                    167 ;	lib/oled.c: 154: i2c_write(0x40);  // Data mode
      008908 A6 40            [ 1]  168 	ld	a, #0x40
      00890A CD 87 EB         [ 4]  169 	call	_i2c_write
                                    170 ;	lib/oled.c: 156: for(col = 0; col < OLED_WIDTH; col++) {
      00890D 0F 04            [ 1]  171 	clr	(0x04, sp)
      00890F                        172 00103$:
                                    173 ;	lib/oled.c: 157: i2c_write(oled_buffer[page * OLED_WIDTH + col]);
      00890F 5F               [ 1]  174 	clrw	x
      008910 7B 03            [ 1]  175 	ld	a, (0x03, sp)
      008912 97               [ 1]  176 	ld	xl, a
      008913 58               [ 2]  177 	sllw	x
      008914 58               [ 2]  178 	sllw	x
      008915 58               [ 2]  179 	sllw	x
      008916 58               [ 2]  180 	sllw	x
      008917 58               [ 2]  181 	sllw	x
      008918 58               [ 2]  182 	sllw	x
      008919 58               [ 2]  183 	sllw	x
      00891A 7B 04            [ 1]  184 	ld	a, (0x04, sp)
      00891C 6B 02            [ 1]  185 	ld	(0x02, sp), a
      00891E 0F 01            [ 1]  186 	clr	(0x01, sp)
      008920 72 FB 01         [ 2]  187 	addw	x, (0x01, sp)
      008923 D6 00 01         [ 1]  188 	ld	a, (_oled_buffer+0, x)
      008926 CD 87 EB         [ 4]  189 	call	_i2c_write
                                    190 ;	lib/oled.c: 156: for(col = 0; col < OLED_WIDTH; col++) {
      008929 0C 04            [ 1]  191 	inc	(0x04, sp)
      00892B 7B 04            [ 1]  192 	ld	a, (0x04, sp)
      00892D A1 80            [ 1]  193 	cp	a, #0x80
      00892F 25 DE            [ 1]  194 	jrc	00103$
                                    195 ;	lib/oled.c: 159: i2c_stop();
      008931 CD 87 E1         [ 4]  196 	call	_i2c_stop
                                    197 ;	lib/oled.c: 145: for(page = 0; page < OLED_PAGES; page++) {
      008934 0C 03            [ 1]  198 	inc	(0x03, sp)
      008936 7B 03            [ 1]  199 	ld	a, (0x03, sp)
      008938 A1 04            [ 1]  200 	cp	a, #0x04
      00893A 25 B4            [ 1]  201 	jrc	00105$
                                    202 ;	lib/oled.c: 161: }
      00893C 5B 04            [ 2]  203 	addw	sp, #4
      00893E 81               [ 4]  204 	ret
                                    205 ;	lib/oled.c: 166: void oled_init(void)
                                    206 ;	-----------------------------------------
                                    207 ;	 function oled_init
                                    208 ;	-----------------------------------------
      00893F                        209 _oled_init:
      00893F 52 19            [ 2]  210 	sub	sp, #25
                                    211 ;	lib/oled.c: 168: delay_ms(100);
      008941 AE 00 64         [ 2]  212 	ldw	x, #0x0064
      008944 CD 83 FA         [ 4]  213 	call	_delay_ms
                                    214 ;	lib/oled.c: 170: unsigned char init_cmds[] = {
      008947 96               [ 1]  215 	ldw	x, sp
      008948 5C               [ 1]  216 	incw	x
      008949 A6 AE            [ 1]  217 	ld	a, #0xae
      00894B F7               [ 1]  218 	ld	(x), a
      00894C A6 D5            [ 1]  219 	ld	a, #0xd5
      00894E 6B 02            [ 1]  220 	ld	(0x02, sp), a
      008950 A6 80            [ 1]  221 	ld	a, #0x80
      008952 6B 03            [ 1]  222 	ld	(0x03, sp), a
      008954 A6 A8            [ 1]  223 	ld	a, #0xa8
      008956 6B 04            [ 1]  224 	ld	(0x04, sp), a
      008958 A6 1F            [ 1]  225 	ld	a, #0x1f
      00895A 6B 05            [ 1]  226 	ld	(0x05, sp), a
      00895C A6 D3            [ 1]  227 	ld	a, #0xd3
      00895E 6B 06            [ 1]  228 	ld	(0x06, sp), a
      008960 0F 07            [ 1]  229 	clr	(0x07, sp)
      008962 A6 40            [ 1]  230 	ld	a, #0x40
      008964 6B 08            [ 1]  231 	ld	(0x08, sp), a
      008966 A6 8D            [ 1]  232 	ld	a, #0x8d
      008968 6B 09            [ 1]  233 	ld	(0x09, sp), a
      00896A A6 14            [ 1]  234 	ld	a, #0x14
      00896C 6B 0A            [ 1]  235 	ld	(0x0a, sp), a
      00896E A6 20            [ 1]  236 	ld	a, #0x20
      008970 6B 0B            [ 1]  237 	ld	(0x0b, sp), a
      008972 0F 0C            [ 1]  238 	clr	(0x0c, sp)
      008974 A6 A1            [ 1]  239 	ld	a, #0xa1
      008976 6B 0D            [ 1]  240 	ld	(0x0d, sp), a
      008978 A6 C8            [ 1]  241 	ld	a, #0xc8
      00897A 6B 0E            [ 1]  242 	ld	(0x0e, sp), a
      00897C A6 DA            [ 1]  243 	ld	a, #0xda
      00897E 6B 0F            [ 1]  244 	ld	(0x0f, sp), a
      008980 A6 02            [ 1]  245 	ld	a, #0x02
      008982 6B 10            [ 1]  246 	ld	(0x10, sp), a
      008984 A6 81            [ 1]  247 	ld	a, #0x81
      008986 6B 11            [ 1]  248 	ld	(0x11, sp), a
      008988 A6 CF            [ 1]  249 	ld	a, #0xcf
      00898A 6B 12            [ 1]  250 	ld	(0x12, sp), a
      00898C A6 D9            [ 1]  251 	ld	a, #0xd9
      00898E 6B 13            [ 1]  252 	ld	(0x13, sp), a
      008990 A6 F1            [ 1]  253 	ld	a, #0xf1
      008992 6B 14            [ 1]  254 	ld	(0x14, sp), a
      008994 A6 DB            [ 1]  255 	ld	a, #0xdb
      008996 6B 15            [ 1]  256 	ld	(0x15, sp), a
      008998 A6 40            [ 1]  257 	ld	a, #0x40
      00899A 6B 16            [ 1]  258 	ld	(0x16, sp), a
      00899C A6 A4            [ 1]  259 	ld	a, #0xa4
      00899E 6B 17            [ 1]  260 	ld	(0x17, sp), a
      0089A0 A6 A6            [ 1]  261 	ld	a, #0xa6
      0089A2 6B 18            [ 1]  262 	ld	(0x18, sp), a
      0089A4 A6 AF            [ 1]  263 	ld	a, #0xaf
      0089A6 6B 19            [ 1]  264 	ld	(0x19, sp), a
                                    265 ;	lib/oled.c: 189: oled_write_cmd_multi(init_cmds, sizeof(init_cmds));
      0089A8 A6 19            [ 1]  266 	ld	a, #0x19
      0089AA CD 88 BE         [ 4]  267 	call	_oled_write_cmd_multi
                                    268 ;	lib/oled.c: 192: oled_clear();
      0089AD CD 89 B8         [ 4]  269 	call	_oled_clear
                                    270 ;	lib/oled.c: 193: }
      0089B0 5B 19            [ 2]  271 	addw	sp, #25
      0089B2 81               [ 4]  272 	ret
                                    273 ;	lib/oled.c: 195: void oled_deinit(void)
                                    274 ;	-----------------------------------------
                                    275 ;	 function oled_deinit
                                    276 ;	-----------------------------------------
      0089B3                        277 _oled_deinit:
                                    278 ;	lib/oled.c: 197: oled_write_cmd(0xAE);  // Display OFF
      0089B3 A6 AE            [ 1]  279 	ld	a, #0xae
                                    280 ;	lib/oled.c: 198: }
      0089B5 CC 88 A4         [ 2]  281 	jp	_oled_write_cmd
                                    282 ;	lib/oled.c: 200: void oled_clear(void)
                                    283 ;	-----------------------------------------
                                    284 ;	 function oled_clear
                                    285 ;	-----------------------------------------
      0089B8                        286 _oled_clear:
                                    287 ;	lib/oled.c: 203: for(i = 0; i < sizeof(oled_buffer); i++) {
      0089B8 90 5F            [ 1]  288 	clrw	y
      0089BA                        289 00102$:
                                    290 ;	lib/oled.c: 204: oled_buffer[i] = 0x00;
      0089BA 93               [ 1]  291 	ldw	x, y
      0089BB 72 4F 00 01      [ 1]  292 	clr	((_oled_buffer+0), x)
                                    293 ;	lib/oled.c: 203: for(i = 0; i < sizeof(oled_buffer); i++) {
      0089BF 90 5C            [ 1]  294 	incw	y
      0089C1 93               [ 1]  295 	ldw	x, y
      0089C2 A3 02 00         [ 2]  296 	cpw	x, #0x0200
      0089C5 25 F3            [ 1]  297 	jrc	00102$
                                    298 ;	lib/oled.c: 206: oled_send_buffer();
                                    299 ;	lib/oled.c: 207: }
      0089C7 CC 88 EC         [ 2]  300 	jp	_oled_send_buffer
                                    301 ;	lib/oled.c: 209: void oled_clear_page(unsigned char page)
                                    302 ;	-----------------------------------------
                                    303 ;	 function oled_clear_page
                                    304 ;	-----------------------------------------
      0089CA                        305 _oled_clear_page:
      0089CA 52 02            [ 2]  306 	sub	sp, #2
                                    307 ;	lib/oled.c: 212: if(page >= OLED_PAGES) return;
      0089CC 90 97            [ 1]  308 	ld	yl, a
      0089CE A1 04            [ 1]  309 	cp	a, #0x04
                                    310 ;	lib/oled.c: 214: for(col = 0; col < OLED_WIDTH; col++) {
      0089D0 24 4B            [ 1]  311 	jrnc	00109$
      0089D2 4F               [ 1]  312 	clr	a
      0089D3                        313 00105$:
                                    314 ;	lib/oled.c: 215: oled_buffer[page * OLED_WIDTH + col] = 0x00;
      0089D3 5F               [ 1]  315 	clrw	x
      0089D4 41               [ 1]  316 	exg	a, xl
      0089D5 90 9F            [ 1]  317 	ld	a, yl
      0089D7 41               [ 1]  318 	exg	a, xl
      0089D8 58               [ 2]  319 	sllw	x
      0089D9 58               [ 2]  320 	sllw	x
      0089DA 58               [ 2]  321 	sllw	x
      0089DB 58               [ 2]  322 	sllw	x
      0089DC 58               [ 2]  323 	sllw	x
      0089DD 58               [ 2]  324 	sllw	x
      0089DE 58               [ 2]  325 	sllw	x
      0089DF 6B 02            [ 1]  326 	ld	(0x02, sp), a
      0089E1 0F 01            [ 1]  327 	clr	(0x01, sp)
      0089E3 72 FB 01         [ 2]  328 	addw	x, (0x01, sp)
      0089E6 72 4F 00 01      [ 1]  329 	clr	((_oled_buffer+0), x)
                                    330 ;	lib/oled.c: 214: for(col = 0; col < OLED_WIDTH; col++) {
      0089EA 4C               [ 1]  331 	inc	a
      0089EB A1 80            [ 1]  332 	cp	a, #0x80
      0089ED 25 E4            [ 1]  333 	jrc	00105$
                                    334 ;	lib/oled.c: 219: oled_write_cmd(0xB0 | page);
      0089EF 90 9F            [ 1]  335 	ld	a, yl
      0089F1 AA B0            [ 1]  336 	or	a, #0xb0
      0089F3 CD 88 A4         [ 4]  337 	call	_oled_write_cmd
                                    338 ;	lib/oled.c: 220: oled_write_cmd(0x00);
      0089F6 4F               [ 1]  339 	clr	a
      0089F7 CD 88 A4         [ 4]  340 	call	_oled_write_cmd
                                    341 ;	lib/oled.c: 221: oled_write_cmd(0x10);
      0089FA A6 10            [ 1]  342 	ld	a, #0x10
      0089FC CD 88 A4         [ 4]  343 	call	_oled_write_cmd
                                    344 ;	lib/oled.c: 223: i2c_start();
      0089FF CD 87 D7         [ 4]  345 	call	_i2c_start
                                    346 ;	lib/oled.c: 224: i2c_send_addr(OLED_ADDR);
      008A02 A6 78            [ 1]  347 	ld	a, #0x78
      008A04 CD 87 F4         [ 4]  348 	call	_i2c_send_addr
                                    349 ;	lib/oled.c: 225: i2c_write(0x40);
      008A07 A6 40            [ 1]  350 	ld	a, #0x40
      008A09 CD 87 EB         [ 4]  351 	call	_i2c_write
                                    352 ;	lib/oled.c: 226: for(col = 0; col < OLED_WIDTH; col++) {
      008A0C 4F               [ 1]  353 	clr	a
      008A0D                        354 00107$:
                                    355 ;	lib/oled.c: 227: i2c_write(0x00);
      008A0D 88               [ 1]  356 	push	a
      008A0E 4F               [ 1]  357 	clr	a
      008A0F CD 87 EB         [ 4]  358 	call	_i2c_write
      008A12 84               [ 1]  359 	pop	a
                                    360 ;	lib/oled.c: 226: for(col = 0; col < OLED_WIDTH; col++) {
      008A13 4C               [ 1]  361 	inc	a
      008A14 A1 80            [ 1]  362 	cp	a, #0x80
      008A16 25 F5            [ 1]  363 	jrc	00107$
                                    364 ;	lib/oled.c: 229: i2c_stop();
      008A18 5B 02            [ 2]  365 	addw	sp, #2
      008A1A CC 87 E1         [ 2]  366 	jp	_i2c_stop
      008A1D                        367 00109$:
                                    368 ;	lib/oled.c: 230: }
      008A1D 5B 02            [ 2]  369 	addw	sp, #2
      008A1F 81               [ 4]  370 	ret
                                    371 ;	lib/oled.c: 232: void oled_update(void)
                                    372 ;	-----------------------------------------
                                    373 ;	 function oled_update
                                    374 ;	-----------------------------------------
      008A20                        375 _oled_update:
                                    376 ;	lib/oled.c: 234: oled_send_buffer();
                                    377 ;	lib/oled.c: 235: }
      008A20 CC 88 EC         [ 2]  378 	jp	_oled_send_buffer
                                    379 ;	lib/oled.c: 237: void oled_set_pixel(unsigned char x, unsigned char y, unsigned char color)
                                    380 ;	-----------------------------------------
                                    381 ;	 function oled_set_pixel
                                    382 ;	-----------------------------------------
      008A23                        383 _oled_set_pixel:
      008A23 52 04            [ 2]  384 	sub	sp, #4
                                    385 ;	lib/oled.c: 241: if(x >= OLED_WIDTH || y >= OLED_HEIGHT) return;
      008A25 90 97            [ 1]  386 	ld	yl, a
      008A27 A1 80            [ 1]  387 	cp	a, #0x80
      008A29 24 4B            [ 1]  388 	jrnc	00107$
      008A2B 7B 07            [ 1]  389 	ld	a, (0x07, sp)
      008A2D A1 20            [ 1]  390 	cp	a, #0x20
      008A2F 24 45            [ 1]  391 	jrnc	00107$
                                    392 ;	lib/oled.c: 243: page = y / 8;
      008A31 7B 07            [ 1]  393 	ld	a, (0x07, sp)
      008A33 88               [ 1]  394 	push	a
      008A34 5F               [ 1]  395 	clrw	x
      008A35 97               [ 1]  396 	ld	xl, a
      008A36 A6 08            [ 1]  397 	ld	a, #0x08
      008A38 62               [ 2]  398 	div	x, a
      008A39 84               [ 1]  399 	pop	a
                                    400 ;	lib/oled.c: 244: bit = y % 8;
      008A3A A4 07            [ 1]  401 	and	a, #0x07
      008A3C 6B 04            [ 1]  402 	ld	(0x04, sp), a
                                    403 ;	lib/oled.c: 247: oled_buffer[page * OLED_WIDTH + x] |= (1 << bit);
      008A3E 4F               [ 1]  404 	clr	a
      008A3F 95               [ 1]  405 	ld	xh, a
      008A40 4F               [ 1]  406 	clr	a
      008A41 90 95            [ 1]  407 	ld	yh, a
      008A43 A6 01            [ 1]  408 	ld	a, #0x01
      008A45 6B 03            [ 1]  409 	ld	(0x03, sp), a
      008A47 7B 04            [ 1]  410 	ld	a, (0x04, sp)
      008A49 27 05            [ 1]  411 	jreq	00126$
      008A4B                        412 00125$:
      008A4B 08 03            [ 1]  413 	sll	(0x03, sp)
      008A4D 4A               [ 1]  414 	dec	a
      008A4E 26 FB            [ 1]  415 	jrne	00125$
      008A50                        416 00126$:
      008A50 58               [ 2]  417 	sllw	x
      008A51 58               [ 2]  418 	sllw	x
      008A52 58               [ 2]  419 	sllw	x
      008A53 58               [ 2]  420 	sllw	x
      008A54 58               [ 2]  421 	sllw	x
      008A55 58               [ 2]  422 	sllw	x
      008A56 58               [ 2]  423 	sllw	x
      008A57 1F 01            [ 2]  424 	ldw	(0x01, sp), x
      008A59 93               [ 1]  425 	ldw	x, y
      008A5A 72 FB 01         [ 2]  426 	addw	x, (0x01, sp)
                                    427 ;	lib/oled.c: 246: if(color) {
      008A5D 0D 08            [ 1]  428 	tnz	(0x08, sp)
      008A5F 27 09            [ 1]  429 	jreq	00105$
                                    430 ;	lib/oled.c: 247: oled_buffer[page * OLED_WIDTH + x] |= (1 << bit);
      008A61 1C 00 01         [ 2]  431 	addw	x, #(_oled_buffer+0)
      008A64 F6               [ 1]  432 	ld	a, (x)
      008A65 1A 03            [ 1]  433 	or	a, (0x03, sp)
      008A67 F7               [ 1]  434 	ld	(x), a
      008A68 20 0C            [ 2]  435 	jra	00107$
      008A6A                        436 00105$:
                                    437 ;	lib/oled.c: 249: oled_buffer[page * OLED_WIDTH + x] &= ~(1 << bit);
      008A6A 1C 00 01         [ 2]  438 	addw	x, #(_oled_buffer+0)
      008A6D F6               [ 1]  439 	ld	a, (x)
      008A6E 6B 04            [ 1]  440 	ld	(0x04, sp), a
      008A70 7B 03            [ 1]  441 	ld	a, (0x03, sp)
      008A72 43               [ 1]  442 	cpl	a
      008A73 14 04            [ 1]  443 	and	a, (0x04, sp)
      008A75 F7               [ 1]  444 	ld	(x), a
      008A76                        445 00107$:
                                    446 ;	lib/oled.c: 251: }
      008A76 1E 05            [ 2]  447 	ldw	x, (5, sp)
      008A78 5B 08            [ 2]  448 	addw	sp, #8
      008A7A FC               [ 2]  449 	jp	(x)
                                    450 ;	lib/oled.c: 253: void oled_draw_line(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char color)
                                    451 ;	-----------------------------------------
                                    452 ;	 function oled_draw_line
                                    453 ;	-----------------------------------------
      008A7B                        454 _oled_draw_line:
      008A7B 52 0C            [ 2]  455 	sub	sp, #12
      008A7D 6B 0A            [ 1]  456 	ld	(0x0a, sp), a
                                    457 ;	lib/oled.c: 257: dx = (x2 > x1) ? (x2 - x1) : (x1 - x2);
      008A7F 7B 10            [ 1]  458 	ld	a, (0x10, sp)
      008A81 6B 07            [ 1]  459 	ld	(0x07, sp), a
      008A83 0F 06            [ 1]  460 	clr	(0x06, sp)
      008A85 7B 0A            [ 1]  461 	ld	a, (0x0a, sp)
      008A87 6B 09            [ 1]  462 	ld	(0x09, sp), a
      008A89 0F 08            [ 1]  463 	clr	(0x08, sp)
      008A8B 7B 10            [ 1]  464 	ld	a, (0x10, sp)
      008A8D 11 0A            [ 1]  465 	cp	a, (0x0a, sp)
      008A8F 23 09            [ 2]  466 	jrule	00113$
      008A91 1E 06            [ 2]  467 	ldw	x, (0x06, sp)
      008A93 72 F0 08         [ 2]  468 	subw	x, (0x08, sp)
      008A96 1F 0B            [ 2]  469 	ldw	(0x0b, sp), x
      008A98 20 07            [ 2]  470 	jra	00114$
      008A9A                        471 00113$:
      008A9A 1E 08            [ 2]  472 	ldw	x, (0x08, sp)
      008A9C 72 F0 06         [ 2]  473 	subw	x, (0x06, sp)
      008A9F 1F 0B            [ 2]  474 	ldw	(0x0b, sp), x
      008AA1                        475 00114$:
      008AA1 16 0B            [ 2]  476 	ldw	y, (0x0b, sp)
      008AA3 17 01            [ 2]  477 	ldw	(0x01, sp), y
                                    478 ;	lib/oled.c: 258: dy = (y2 > y1) ? (y2 - y1) : (y1 - y2);
      008AA5 7B 11            [ 1]  479 	ld	a, (0x11, sp)
      008AA7 6B 07            [ 1]  480 	ld	(0x07, sp), a
      008AA9 0F 06            [ 1]  481 	clr	(0x06, sp)
      008AAB 7B 0F            [ 1]  482 	ld	a, (0x0f, sp)
      008AAD 6B 09            [ 1]  483 	ld	(0x09, sp), a
      008AAF 0F 08            [ 1]  484 	clr	(0x08, sp)
      008AB1 7B 11            [ 1]  485 	ld	a, (0x11, sp)
      008AB3 11 0F            [ 1]  486 	cp	a, (0x0f, sp)
      008AB5 23 09            [ 2]  487 	jrule	00115$
      008AB7 1E 06            [ 2]  488 	ldw	x, (0x06, sp)
      008AB9 72 F0 08         [ 2]  489 	subw	x, (0x08, sp)
      008ABC 1F 0B            [ 2]  490 	ldw	(0x0b, sp), x
      008ABE 20 07            [ 2]  491 	jra	00116$
      008AC0                        492 00115$:
      008AC0 1E 08            [ 2]  493 	ldw	x, (0x08, sp)
      008AC2 72 F0 06         [ 2]  494 	subw	x, (0x06, sp)
      008AC5 1F 0B            [ 2]  495 	ldw	(0x0b, sp), x
      008AC7                        496 00116$:
      008AC7 16 0B            [ 2]  497 	ldw	y, (0x0b, sp)
      008AC9 17 03            [ 2]  498 	ldw	(0x03, sp), y
                                    499 ;	lib/oled.c: 259: sx = (x1 < x2) ? 1 : -1;
      008ACB 7B 0A            [ 1]  500 	ld	a, (0x0a, sp)
      008ACD 11 10            [ 1]  501 	cp	a, (0x10, sp)
      008ACF 24 03            [ 1]  502 	jrnc	00117$
      008AD1 A6 01            [ 1]  503 	ld	a, #0x01
      008AD3 C5                     504 	.byte 0xc5
      008AD4                        505 00117$:
      008AD4 A6 FF            [ 1]  506 	ld	a, #0xff
      008AD6                        507 00118$:
      008AD6 6B 05            [ 1]  508 	ld	(0x05, sp), a
                                    509 ;	lib/oled.c: 260: sy = (y1 < y2) ? 1 : -1;
      008AD8 7B 0F            [ 1]  510 	ld	a, (0x0f, sp)
      008ADA 11 11            [ 1]  511 	cp	a, (0x11, sp)
      008ADC 24 03            [ 1]  512 	jrnc	00119$
      008ADE A6 01            [ 1]  513 	ld	a, #0x01
      008AE0 C5                     514 	.byte 0xc5
      008AE1                        515 00119$:
      008AE1 A6 FF            [ 1]  516 	ld	a, #0xff
      008AE3                        517 00120$:
      008AE3 6B 06            [ 1]  518 	ld	(0x06, sp), a
                                    519 ;	lib/oled.c: 261: err = dx - dy;
      008AE5 1E 01            [ 2]  520 	ldw	x, (0x01, sp)
      008AE7 72 F0 03         [ 2]  521 	subw	x, (0x03, sp)
      008AEA 1F 0B            [ 2]  522 	ldw	(0x0b, sp), x
                                    523 ;	lib/oled.c: 263: while(1) {
      008AEC 7B 04            [ 1]  524 	ld	a, (0x04, sp)
      008AEE 40               [ 1]  525 	neg	a
      008AEF 6B 08            [ 1]  526 	ld	(0x08, sp), a
      008AF1 4F               [ 1]  527 	clr	a
      008AF2 12 03            [ 1]  528 	sbc	a, (0x03, sp)
      008AF4 6B 07            [ 1]  529 	ld	(0x07, sp), a
      008AF6                        530 00109$:
                                    531 ;	lib/oled.c: 264: oled_set_pixel(x1, y1, color);
      008AF6 7B 12            [ 1]  532 	ld	a, (0x12, sp)
      008AF8 88               [ 1]  533 	push	a
      008AF9 7B 10            [ 1]  534 	ld	a, (0x10, sp)
      008AFB 88               [ 1]  535 	push	a
      008AFC 7B 0C            [ 1]  536 	ld	a, (0x0c, sp)
      008AFE CD 8A 23         [ 4]  537 	call	_oled_set_pixel
                                    538 ;	lib/oled.c: 265: if(x1 == x2 && y1 == y2) break;
      008B01 7B 0A            [ 1]  539 	ld	a, (0x0a, sp)
      008B03 11 10            [ 1]  540 	cp	a, (0x10, sp)
      008B05 26 06            [ 1]  541 	jrne	00102$
      008B07 7B 0F            [ 1]  542 	ld	a, (0x0f, sp)
      008B09 11 11            [ 1]  543 	cp	a, (0x11, sp)
      008B0B 27 2F            [ 1]  544 	jreq	00111$
      008B0D                        545 00102$:
                                    546 ;	lib/oled.c: 266: e2 = 2 * err;
      008B0D 1E 0B            [ 2]  547 	ldw	x, (0x0b, sp)
      008B0F 58               [ 2]  548 	sllw	x
                                    549 ;	lib/oled.c: 267: if(e2 > -dy) { err -= dy; x1 += sx; }
      008B10 13 07            [ 2]  550 	cpw	x, (0x07, sp)
      008B12 2D 11            [ 1]  551 	jrsle	00105$
      008B14 16 0B            [ 2]  552 	ldw	y, (0x0b, sp)
      008B16 72 F2 03         [ 2]  553 	subw	y, (0x03, sp)
      008B19 17 0B            [ 2]  554 	ldw	(0x0b, sp), y
      008B1B 7B 05            [ 1]  555 	ld	a, (0x05, sp)
      008B1D 6B 09            [ 1]  556 	ld	(0x09, sp), a
      008B1F 7B 0A            [ 1]  557 	ld	a, (0x0a, sp)
      008B21 1B 09            [ 1]  558 	add	a, (0x09, sp)
      008B23 6B 0A            [ 1]  559 	ld	(0x0a, sp), a
      008B25                        560 00105$:
                                    561 ;	lib/oled.c: 268: if(e2 < dx) { err += dx; y1 += sy; }
      008B25 13 01            [ 2]  562 	cpw	x, (0x01, sp)
      008B27 2E CD            [ 1]  563 	jrsge	00109$
      008B29 1E 0B            [ 2]  564 	ldw	x, (0x0b, sp)
      008B2B 72 FB 01         [ 2]  565 	addw	x, (0x01, sp)
      008B2E 1F 0B            [ 2]  566 	ldw	(0x0b, sp), x
      008B30 7B 06            [ 1]  567 	ld	a, (0x06, sp)
      008B32 6B 09            [ 1]  568 	ld	(0x09, sp), a
      008B34 7B 0F            [ 1]  569 	ld	a, (0x0f, sp)
      008B36 1B 09            [ 1]  570 	add	a, (0x09, sp)
      008B38 6B 0F            [ 1]  571 	ld	(0x0f, sp), a
      008B3A 20 BA            [ 2]  572 	jra	00109$
      008B3C                        573 00111$:
                                    574 ;	lib/oled.c: 270: }
      008B3C 1E 0D            [ 2]  575 	ldw	x, (13, sp)
      008B3E 5B 12            [ 2]  576 	addw	sp, #18
      008B40 FC               [ 2]  577 	jp	(x)
                                    578 ;	lib/oled.c: 272: void oled_draw_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color)
                                    579 ;	-----------------------------------------
                                    580 ;	 function oled_draw_rect
                                    581 ;	-----------------------------------------
      008B41                        582 _oled_draw_rect:
      008B41 88               [ 1]  583 	push	a
                                    584 ;	lib/oled.c: 274: oled_draw_line(x, y, x + w - 1, y, color);
      008B42 97               [ 1]  585 	ld	xl, a
      008B43 1B 05            [ 1]  586 	add	a, (0x05, sp)
      008B45 4A               [ 1]  587 	dec	a
      008B46 95               [ 1]  588 	ld	xh, a
      008B47 89               [ 2]  589 	pushw	x
      008B48 7B 09            [ 1]  590 	ld	a, (0x09, sp)
      008B4A 88               [ 1]  591 	push	a
      008B4B 7B 07            [ 1]  592 	ld	a, (0x07, sp)
      008B4D 88               [ 1]  593 	push	a
      008B4E 9E               [ 1]  594 	ld	a, xh
      008B4F 88               [ 1]  595 	push	a
      008B50 7B 09            [ 1]  596 	ld	a, (0x09, sp)
      008B52 88               [ 1]  597 	push	a
      008B53 9F               [ 1]  598 	ld	a, xl
      008B54 CD 8A 7B         [ 4]  599 	call	_oled_draw_line
      008B57 85               [ 2]  600 	popw	x
                                    601 ;	lib/oled.c: 275: oled_draw_line(x, y, x, y + h - 1, color);
      008B58 7B 04            [ 1]  602 	ld	a, (0x04, sp)
      008B5A 1B 06            [ 1]  603 	add	a, (0x06, sp)
      008B5C 4A               [ 1]  604 	dec	a
      008B5D 6B 01            [ 1]  605 	ld	(0x01, sp), a
      008B5F 89               [ 2]  606 	pushw	x
      008B60 7B 09            [ 1]  607 	ld	a, (0x09, sp)
      008B62 88               [ 1]  608 	push	a
      008B63 7B 04            [ 1]  609 	ld	a, (0x04, sp)
      008B65 88               [ 1]  610 	push	a
      008B66 9F               [ 1]  611 	ld	a, xl
      008B67 88               [ 1]  612 	push	a
      008B68 7B 09            [ 1]  613 	ld	a, (0x09, sp)
      008B6A 88               [ 1]  614 	push	a
      008B6B 9F               [ 1]  615 	ld	a, xl
      008B6C CD 8A 7B         [ 4]  616 	call	_oled_draw_line
      008B6F 85               [ 2]  617 	popw	x
                                    618 ;	lib/oled.c: 276: oled_draw_line(x + w - 1, y, x + w - 1, y + h - 1, color);
      008B70 89               [ 2]  619 	pushw	x
      008B71 7B 09            [ 1]  620 	ld	a, (0x09, sp)
      008B73 88               [ 1]  621 	push	a
      008B74 7B 04            [ 1]  622 	ld	a, (0x04, sp)
      008B76 88               [ 1]  623 	push	a
      008B77 9E               [ 1]  624 	ld	a, xh
      008B78 88               [ 1]  625 	push	a
      008B79 7B 09            [ 1]  626 	ld	a, (0x09, sp)
      008B7B 88               [ 1]  627 	push	a
      008B7C 9E               [ 1]  628 	ld	a, xh
      008B7D CD 8A 7B         [ 4]  629 	call	_oled_draw_line
      008B80 85               [ 2]  630 	popw	x
                                    631 ;	lib/oled.c: 277: oled_draw_line(x, y + h - 1, x + w - 1, y + h - 1, color);
      008B81 7B 07            [ 1]  632 	ld	a, (0x07, sp)
      008B83 88               [ 1]  633 	push	a
      008B84 7B 02            [ 1]  634 	ld	a, (0x02, sp)
      008B86 88               [ 1]  635 	push	a
      008B87 9E               [ 1]  636 	ld	a, xh
      008B88 88               [ 1]  637 	push	a
      008B89 7B 04            [ 1]  638 	ld	a, (0x04, sp)
      008B8B 88               [ 1]  639 	push	a
      008B8C 9F               [ 1]  640 	ld	a, xl
      008B8D CD 8A 7B         [ 4]  641 	call	_oled_draw_line
                                    642 ;	lib/oled.c: 278: }
      008B90 1E 02            [ 2]  643 	ldw	x, (2, sp)
      008B92 5B 07            [ 2]  644 	addw	sp, #7
      008B94 FC               [ 2]  645 	jp	(x)
                                    646 ;	lib/oled.c: 280: void oled_fill_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color)
                                    647 ;	-----------------------------------------
                                    648 ;	 function oled_fill_rect
                                    649 ;	-----------------------------------------
      008B95                        650 _oled_fill_rect:
      008B95 52 09            [ 2]  651 	sub	sp, #9
                                    652 ;	lib/oled.c: 283: for(i = x; i < x + w; i++) {
      008B97 6B 07            [ 1]  653 	ld	(0x07, sp), a
      008B99 6B 08            [ 1]  654 	ld	(0x08, sp), a
      008B9B                        655 00107$:
      008B9B 7B 07            [ 1]  656 	ld	a, (0x07, sp)
      008B9D 6B 02            [ 1]  657 	ld	(0x02, sp), a
      008B9F 0F 01            [ 1]  658 	clr	(0x01, sp)
      008BA1 7B 0D            [ 1]  659 	ld	a, (0x0d, sp)
      008BA3 6B 04            [ 1]  660 	ld	(0x04, sp), a
      008BA5 0F 03            [ 1]  661 	clr	(0x03, sp)
      008BA7 1E 01            [ 2]  662 	ldw	x, (0x01, sp)
      008BA9 72 FB 03         [ 2]  663 	addw	x, (0x03, sp)
      008BAC 1F 05            [ 2]  664 	ldw	(0x05, sp), x
      008BAE 7B 08            [ 1]  665 	ld	a, (0x08, sp)
      008BB0 6B 04            [ 1]  666 	ld	(0x04, sp), a
      008BB2 0F 03            [ 1]  667 	clr	(0x03, sp)
      008BB4 1E 03            [ 2]  668 	ldw	x, (0x03, sp)
      008BB6 13 05            [ 2]  669 	cpw	x, (0x05, sp)
      008BB8 2E 2E            [ 1]  670 	jrsge	00109$
                                    671 ;	lib/oled.c: 284: for(j = y; j < y + h; j++) {
      008BBA 7B 0C            [ 1]  672 	ld	a, (0x0c, sp)
      008BBC 6B 09            [ 1]  673 	ld	(0x09, sp), a
      008BBE                        674 00104$:
      008BBE 5F               [ 1]  675 	clrw	x
      008BBF 7B 0C            [ 1]  676 	ld	a, (0x0c, sp)
      008BC1 97               [ 1]  677 	ld	xl, a
      008BC2 7B 0E            [ 1]  678 	ld	a, (0x0e, sp)
      008BC4 6B 04            [ 1]  679 	ld	(0x04, sp), a
      008BC6 0F 03            [ 1]  680 	clr	(0x03, sp)
      008BC8 72 FB 03         [ 2]  681 	addw	x, (0x03, sp)
      008BCB 1F 05            [ 2]  682 	ldw	(0x05, sp), x
      008BCD 7B 09            [ 1]  683 	ld	a, (0x09, sp)
      008BCF 5F               [ 1]  684 	clrw	x
      008BD0 97               [ 1]  685 	ld	xl, a
      008BD1 13 05            [ 2]  686 	cpw	x, (0x05, sp)
      008BD3 2E 0F            [ 1]  687 	jrsge	00108$
                                    688 ;	lib/oled.c: 285: oled_set_pixel(i, j, color);
      008BD5 7B 0F            [ 1]  689 	ld	a, (0x0f, sp)
      008BD7 88               [ 1]  690 	push	a
      008BD8 7B 0A            [ 1]  691 	ld	a, (0x0a, sp)
      008BDA 88               [ 1]  692 	push	a
      008BDB 7B 0A            [ 1]  693 	ld	a, (0x0a, sp)
      008BDD CD 8A 23         [ 4]  694 	call	_oled_set_pixel
                                    695 ;	lib/oled.c: 284: for(j = y; j < y + h; j++) {
      008BE0 0C 09            [ 1]  696 	inc	(0x09, sp)
      008BE2 20 DA            [ 2]  697 	jra	00104$
      008BE4                        698 00108$:
                                    699 ;	lib/oled.c: 283: for(i = x; i < x + w; i++) {
      008BE4 0C 08            [ 1]  700 	inc	(0x08, sp)
      008BE6 20 B3            [ 2]  701 	jra	00107$
      008BE8                        702 00109$:
                                    703 ;	lib/oled.c: 288: }
      008BE8 1E 0A            [ 2]  704 	ldw	x, (10, sp)
      008BEA 5B 0F            [ 2]  705 	addw	sp, #15
      008BEC FC               [ 2]  706 	jp	(x)
                                    707 ;	lib/oled.c: 290: void oled_gotoxy(unsigned char x, unsigned char y)
                                    708 ;	-----------------------------------------
                                    709 ;	 function oled_gotoxy
                                    710 ;	-----------------------------------------
      008BED                        711 _oled_gotoxy:
                                    712 ;	lib/oled.c: 292: if(x < OLED_WIDTH && y < OLED_HEIGHT) {
      008BED A1 80            [ 1]  713 	cp	a, #0x80
      008BEF 24 10            [ 1]  714 	jrnc	00104$
      008BF1 88               [ 1]  715 	push	a
      008BF2 7B 04            [ 1]  716 	ld	a, (0x04, sp)
      008BF4 A1 20            [ 1]  717 	cp	a, #0x20
      008BF6 84               [ 1]  718 	pop	a
      008BF7 24 08            [ 1]  719 	jrnc	00104$
                                    720 ;	lib/oled.c: 293: oled_cursor_x = x;
      008BF9 C7 02 01         [ 1]  721 	ld	_oled_cursor_x+0, a
                                    722 ;	lib/oled.c: 294: oled_cursor_y = y;
      008BFC 7B 03            [ 1]  723 	ld	a, (0x03, sp)
      008BFE C7 02 02         [ 1]  724 	ld	_oled_cursor_y+0, a
      008C01                        725 00104$:
                                    726 ;	lib/oled.c: 296: }
      008C01 85               [ 2]  727 	popw	x
      008C02 84               [ 1]  728 	pop	a
      008C03 FC               [ 2]  729 	jp	(x)
                                    730 ;	lib/oled.c: 298: void oled_putc(char c)
                                    731 ;	-----------------------------------------
                                    732 ;	 function oled_putc
                                    733 ;	-----------------------------------------
      008C04                        734 _oled_putc:
      008C04 52 07            [ 2]  735 	sub	sp, #7
                                    736 ;	lib/oled.c: 300: if(c == '\n') {
      008C06 A1 0A            [ 1]  737 	cp	a, #0x0a
      008C08 26 0E            [ 1]  738 	jrne	00102$
                                    739 ;	lib/oled.c: 301: oled_cursor_x = 0;
      008C0A 72 5F 02 01      [ 1]  740 	clr	_oled_cursor_x+0
                                    741 ;	lib/oled.c: 302: oled_cursor_y += 8;
      008C0E C6 02 02         [ 1]  742 	ld	a, _oled_cursor_y+0
      008C11 AB 08            [ 1]  743 	add	a, #0x08
      008C13 C7 02 02         [ 1]  744 	ld	_oled_cursor_y+0, a
                                    745 ;	lib/oled.c: 303: return;
      008C16 20 75            [ 2]  746 	jra	00116$
      008C18                        747 00102$:
                                    748 ;	lib/oled.c: 306: if(c >= 32 && c <= 127) {
      008C18 A1 20            [ 1]  749 	cp	a, #0x20
      008C1A 25 71            [ 1]  750 	jrc	00116$
      008C1C A1 7F            [ 1]  751 	cp	a, #0x7f
      008C1E 22 6D            [ 1]  752 	jrugt	00116$
                                    753 ;	lib/oled.c: 308: unsigned char idx = c - 32;
      008C20 A0 20            [ 1]  754 	sub	a, #0x20
      008C22 97               [ 1]  755 	ld	xl, a
                                    756 ;	lib/oled.c: 310: for(i = 0; i < 6; i++) {
      008C23 A6 06            [ 1]  757 	ld	a, #0x06
      008C25 42               [ 4]  758 	mul	x, a
      008C26 1C 80 7F         [ 2]  759 	addw	x, #(_font_6x8+0)
      008C29 1F 01            [ 2]  760 	ldw	(0x01, sp), x
      008C2B 0F 06            [ 1]  761 	clr	(0x06, sp)
      008C2D                        762 00114$:
                                    763 ;	lib/oled.c: 311: unsigned char data = font_6x8[idx][i];
      008C2D 5F               [ 1]  764 	clrw	x
      008C2E 7B 06            [ 1]  765 	ld	a, (0x06, sp)
      008C30 97               [ 1]  766 	ld	xl, a
      008C31 72 FB 01         [ 2]  767 	addw	x, (0x01, sp)
      008C34 F6               [ 1]  768 	ld	a, (x)
      008C35 6B 03            [ 1]  769 	ld	(0x03, sp), a
                                    770 ;	lib/oled.c: 313: for(j = 0; j < 8; j++) {
      008C37 0F 07            [ 1]  771 	clr	(0x07, sp)
      008C39                        772 00112$:
                                    773 ;	lib/oled.c: 314: if(data & (1 << j)) {
      008C39 5F               [ 1]  774 	clrw	x
      008C3A 5C               [ 1]  775 	incw	x
      008C3B 7B 07            [ 1]  776 	ld	a, (0x07, sp)
      008C3D 27 04            [ 1]  777 	jreq	00189$
      008C3F                        778 00188$:
      008C3F 58               [ 2]  779 	sllw	x
      008C40 4A               [ 1]  780 	dec	a
      008C41 26 FC            [ 1]  781 	jrne	00188$
      008C43                        782 00189$:
      008C43 7B 03            [ 1]  783 	ld	a, (0x03, sp)
      008C45 6B 05            [ 1]  784 	ld	(0x05, sp), a
      008C47 0F 04            [ 1]  785 	clr	(0x04, sp)
      008C49 9F               [ 1]  786 	ld	a, xl
      008C4A 14 05            [ 1]  787 	and	a, (0x05, sp)
      008C4C 97               [ 1]  788 	ld	xl, a
      008C4D 4F               [ 1]  789 	clr	a
      008C4E 95               [ 1]  790 	ld	xh, a
      008C4F 5D               [ 2]  791 	tnzw	x
      008C50 27 13            [ 1]  792 	jreq	00113$
                                    793 ;	lib/oled.c: 315: oled_set_pixel(oled_cursor_x + i, oled_cursor_y + j, 1);
      008C52 C6 02 02         [ 1]  794 	ld	a, _oled_cursor_y+0
      008C55 1B 07            [ 1]  795 	add	a, (0x07, sp)
      008C57 97               [ 1]  796 	ld	xl, a
      008C58 C6 02 01         [ 1]  797 	ld	a, _oled_cursor_x+0
      008C5B 1B 06            [ 1]  798 	add	a, (0x06, sp)
      008C5D 4B 01            [ 1]  799 	push	#0x01
      008C5F 89               [ 2]  800 	pushw	x
      008C60 5B 01            [ 2]  801 	addw	sp, #1
      008C62 CD 8A 23         [ 4]  802 	call	_oled_set_pixel
      008C65                        803 00113$:
                                    804 ;	lib/oled.c: 313: for(j = 0; j < 8; j++) {
      008C65 0C 07            [ 1]  805 	inc	(0x07, sp)
      008C67 7B 07            [ 1]  806 	ld	a, (0x07, sp)
      008C69 A1 08            [ 1]  807 	cp	a, #0x08
      008C6B 25 CC            [ 1]  808 	jrc	00112$
                                    809 ;	lib/oled.c: 310: for(i = 0; i < 6; i++) {
      008C6D 0C 06            [ 1]  810 	inc	(0x06, sp)
      008C6F 7B 06            [ 1]  811 	ld	a, (0x06, sp)
      008C71 A1 06            [ 1]  812 	cp	a, #0x06
      008C73 25 B8            [ 1]  813 	jrc	00114$
                                    814 ;	lib/oled.c: 319: oled_cursor_x += 6;
      008C75 C6 02 01         [ 1]  815 	ld	a, _oled_cursor_x+0
      008C78 AB 06            [ 1]  816 	add	a, #0x06
                                    817 ;	lib/oled.c: 321: if(oled_cursor_x > OLED_WIDTH - 6) {
      008C7A C7 02 01         [ 1]  818 	ld	_oled_cursor_x+0, a
      008C7D A1 7A            [ 1]  819 	cp	a, #0x7a
      008C7F 23 0C            [ 2]  820 	jrule	00116$
                                    821 ;	lib/oled.c: 322: oled_cursor_x = 0;
      008C81 72 5F 02 01      [ 1]  822 	clr	_oled_cursor_x+0
                                    823 ;	lib/oled.c: 323: oled_cursor_y += 8;
      008C85 C6 02 02         [ 1]  824 	ld	a, _oled_cursor_y+0
      008C88 AB 08            [ 1]  825 	add	a, #0x08
      008C8A C7 02 02         [ 1]  826 	ld	_oled_cursor_y+0, a
      008C8D                        827 00116$:
                                    828 ;	lib/oled.c: 326: }
      008C8D 5B 07            [ 2]  829 	addw	sp, #7
      008C8F 81               [ 4]  830 	ret
                                    831 ;	lib/oled.c: 328: void oled_puts(const char* str)
                                    832 ;	-----------------------------------------
                                    833 ;	 function oled_puts
                                    834 ;	-----------------------------------------
      008C90                        835 _oled_puts:
                                    836 ;	lib/oled.c: 330: while(*str) {
      008C90                        837 00101$:
      008C90 F6               [ 1]  838 	ld	a, (x)
      008C91 26 03            [ 1]  839 	jrne	00121$
      008C93 CC 8A 20         [ 2]  840 	jp	_oled_update
      008C96                        841 00121$:
                                    842 ;	lib/oled.c: 331: oled_putc(*str++);
      008C96 5C               [ 1]  843 	incw	x
      008C97 89               [ 2]  844 	pushw	x
      008C98 CD 8C 04         [ 4]  845 	call	_oled_putc
      008C9B 85               [ 2]  846 	popw	x
                                    847 ;	lib/oled.c: 333: oled_update();
                                    848 ;	lib/oled.c: 334: }
      008C9C 20 F2            [ 2]  849 	jra	00101$
                                    850 ;	lib/oled.c: 336: void oled_puts_at(unsigned char x, unsigned char y, const char* str)
                                    851 ;	-----------------------------------------
                                    852 ;	 function oled_puts_at
                                    853 ;	-----------------------------------------
      008C9E                        854 _oled_puts_at:
      008C9E 97               [ 1]  855 	ld	xl, a
                                    856 ;	lib/oled.c: 338: oled_gotoxy(x, y);
      008C9F 7B 03            [ 1]  857 	ld	a, (0x03, sp)
      008CA1 88               [ 1]  858 	push	a
      008CA2 9F               [ 1]  859 	ld	a, xl
      008CA3 CD 8B ED         [ 4]  860 	call	_oled_gotoxy
                                    861 ;	lib/oled.c: 339: oled_puts(str);
      008CA6 1E 04            [ 2]  862 	ldw	x, (0x04, sp)
      008CA8 16 01            [ 2]  863 	ldw	y, (1, sp)
      008CAA 17 04            [ 2]  864 	ldw	(4, sp), y
      008CAC 5B 03            [ 2]  865 	addw	sp, #3
                                    866 ;	lib/oled.c: 340: }
      008CAE CC 8C 90         [ 2]  867 	jp	_oled_puts
                                    868 ;	lib/oled.c: 342: void oled_set_font(unsigned char font_size)
                                    869 ;	-----------------------------------------
                                    870 ;	 function oled_set_font
                                    871 ;	-----------------------------------------
      008CB1                        872 _oled_set_font:
      008CB1 C7 02 03         [ 1]  873 	ld	_oled_current_font+0, a
                                    874 ;	lib/oled.c: 344: oled_current_font = font_size;
                                    875 ;	lib/oled.c: 345: }
      008CB4 81               [ 4]  876 	ret
                                    877 ;	lib/oled.c: 347: void oled_set_contrast(unsigned char contrast)
                                    878 ;	-----------------------------------------
                                    879 ;	 function oled_set_contrast
                                    880 ;	-----------------------------------------
      008CB5                        881 _oled_set_contrast:
                                    882 ;	lib/oled.c: 349: oled_write_cmd(0x81);
      008CB5 88               [ 1]  883 	push	a
      008CB6 A6 81            [ 1]  884 	ld	a, #0x81
      008CB8 CD 88 A4         [ 4]  885 	call	_oled_write_cmd
      008CBB 84               [ 1]  886 	pop	a
                                    887 ;	lib/oled.c: 350: oled_write_cmd(contrast);
                                    888 ;	lib/oled.c: 351: }
      008CBC CC 88 A4         [ 2]  889 	jp	_oled_write_cmd
                                    890 ;	lib/oled.c: 353: void oled_invert(void)
                                    891 ;	-----------------------------------------
                                    892 ;	 function oled_invert
                                    893 ;	-----------------------------------------
      008CBF                        894 _oled_invert:
                                    895 ;	lib/oled.c: 355: oled_write_cmd(0xA7);  // Invert display
      008CBF A6 A7            [ 1]  896 	ld	a, #0xa7
                                    897 ;	lib/oled.c: 356: }
      008CC1 CC 88 A4         [ 2]  898 	jp	_oled_write_cmd
                                    899 ;	lib/oled.c: 358: void oled_normal(void)
                                    900 ;	-----------------------------------------
                                    901 ;	 function oled_normal
                                    902 ;	-----------------------------------------
      008CC4                        903 _oled_normal:
                                    904 ;	lib/oled.c: 360: oled_write_cmd(0xA6);  // Normal display
      008CC4 A6 A6            [ 1]  905 	ld	a, #0xa6
                                    906 ;	lib/oled.c: 361: }
      008CC6 CC 88 A4         [ 2]  907 	jp	_oled_write_cmd
                                    908 ;	lib/oled.c: 363: void oled_scroll_left(unsigned char pages, unsigned char speed)
                                    909 ;	-----------------------------------------
                                    910 ;	 function oled_scroll_left
                                    911 ;	-----------------------------------------
      008CC9                        912 _oled_scroll_left:
      008CC9 52 07            [ 2]  913 	sub	sp, #7
                                    914 ;	lib/oled.c: 365: if(pages > 7) pages = 7;
      008CCB 97               [ 1]  915 	ld	xl, a
      008CCC A1 07            [ 1]  916 	cp	a, #0x07
      008CCE 23 03            [ 2]  917 	jrule	00102$
      008CD0 A6 07            [ 1]  918 	ld	a, #0x07
      008CD2 97               [ 1]  919 	ld	xl, a
      008CD3                        920 00102$:
                                    921 ;	lib/oled.c: 366: if(speed > 7) speed = 7;
      008CD3 7B 0A            [ 1]  922 	ld	a, (0x0a, sp)
      008CD5 A1 07            [ 1]  923 	cp	a, #0x07
      008CD7 23 04            [ 2]  924 	jrule	00104$
      008CD9 A6 07            [ 1]  925 	ld	a, #0x07
      008CDB 6B 0A            [ 1]  926 	ld	(0x0a, sp), a
      008CDD                        927 00104$:
                                    928 ;	lib/oled.c: 368: unsigned char cmd[] = {
      008CDD A6 26            [ 1]  929 	ld	a, #0x26
      008CDF 6B 01            [ 1]  930 	ld	(0x01, sp), a
      008CE1 0F 02            [ 1]  931 	clr	(0x02, sp)
      008CE3 0F 03            [ 1]  932 	clr	(0x03, sp)
      008CE5 7B 0A            [ 1]  933 	ld	a, (0x0a, sp)
      008CE7 6B 04            [ 1]  934 	ld	(0x04, sp), a
      008CE9 9F               [ 1]  935 	ld	a, xl
      008CEA 4A               [ 1]  936 	dec	a
      008CEB 6B 05            [ 1]  937 	ld	(0x05, sp), a
      008CED 0F 06            [ 1]  938 	clr	(0x06, sp)
      008CEF A6 FF            [ 1]  939 	ld	a, #0xff
      008CF1 6B 07            [ 1]  940 	ld	(0x07, sp), a
                                    941 ;	lib/oled.c: 377: oled_write_cmd_multi(cmd, 7);
      008CF3 A6 07            [ 1]  942 	ld	a, #0x07
      008CF5 96               [ 1]  943 	ldw	x, sp
      008CF6 5C               [ 1]  944 	incw	x
      008CF7 CD 88 BE         [ 4]  945 	call	_oled_write_cmd_multi
                                    946 ;	lib/oled.c: 378: oled_write_cmd(0x2F);   // Activate scroll
      008CFA A6 2F            [ 1]  947 	ld	a, #0x2f
      008CFC CD 88 A4         [ 4]  948 	call	_oled_write_cmd
                                    949 ;	lib/oled.c: 379: }
      008CFF 5B 07            [ 2]  950 	addw	sp, #7
      008D01 85               [ 2]  951 	popw	x
      008D02 84               [ 1]  952 	pop	a
      008D03 FC               [ 2]  953 	jp	(x)
                                    954 ;	lib/oled.c: 381: void oled_scroll_right(unsigned char pages, unsigned char speed)
                                    955 ;	-----------------------------------------
                                    956 ;	 function oled_scroll_right
                                    957 ;	-----------------------------------------
      008D04                        958 _oled_scroll_right:
      008D04 52 07            [ 2]  959 	sub	sp, #7
                                    960 ;	lib/oled.c: 383: if(pages > 7) pages = 7;
      008D06 97               [ 1]  961 	ld	xl, a
      008D07 A1 07            [ 1]  962 	cp	a, #0x07
      008D09 23 03            [ 2]  963 	jrule	00102$
      008D0B A6 07            [ 1]  964 	ld	a, #0x07
      008D0D 97               [ 1]  965 	ld	xl, a
      008D0E                        966 00102$:
                                    967 ;	lib/oled.c: 384: if(speed > 7) speed = 7;
      008D0E 7B 0A            [ 1]  968 	ld	a, (0x0a, sp)
      008D10 A1 07            [ 1]  969 	cp	a, #0x07
      008D12 23 04            [ 2]  970 	jrule	00104$
      008D14 A6 07            [ 1]  971 	ld	a, #0x07
      008D16 6B 0A            [ 1]  972 	ld	(0x0a, sp), a
      008D18                        973 00104$:
                                    974 ;	lib/oled.c: 386: unsigned char cmd[] = {
      008D18 A6 27            [ 1]  975 	ld	a, #0x27
      008D1A 6B 01            [ 1]  976 	ld	(0x01, sp), a
      008D1C 0F 02            [ 1]  977 	clr	(0x02, sp)
      008D1E 0F 03            [ 1]  978 	clr	(0x03, sp)
      008D20 7B 0A            [ 1]  979 	ld	a, (0x0a, sp)
      008D22 6B 04            [ 1]  980 	ld	(0x04, sp), a
      008D24 9F               [ 1]  981 	ld	a, xl
      008D25 4A               [ 1]  982 	dec	a
      008D26 6B 05            [ 1]  983 	ld	(0x05, sp), a
      008D28 0F 06            [ 1]  984 	clr	(0x06, sp)
      008D2A A6 FF            [ 1]  985 	ld	a, #0xff
      008D2C 6B 07            [ 1]  986 	ld	(0x07, sp), a
                                    987 ;	lib/oled.c: 395: oled_write_cmd_multi(cmd, 7);
      008D2E A6 07            [ 1]  988 	ld	a, #0x07
      008D30 96               [ 1]  989 	ldw	x, sp
      008D31 5C               [ 1]  990 	incw	x
      008D32 CD 88 BE         [ 4]  991 	call	_oled_write_cmd_multi
                                    992 ;	lib/oled.c: 396: oled_write_cmd(0x2F);   // Activate scroll
      008D35 A6 2F            [ 1]  993 	ld	a, #0x2f
      008D37 CD 88 A4         [ 4]  994 	call	_oled_write_cmd
                                    995 ;	lib/oled.c: 397: }
      008D3A 5B 07            [ 2]  996 	addw	sp, #7
      008D3C 85               [ 2]  997 	popw	x
      008D3D 84               [ 1]  998 	pop	a
      008D3E FC               [ 2]  999 	jp	(x)
                                   1000 ;	lib/oled.c: 399: void oled_scroll_stop(void)
                                   1001 ;	-----------------------------------------
                                   1002 ;	 function oled_scroll_stop
                                   1003 ;	-----------------------------------------
      008D3F                       1004 _oled_scroll_stop:
                                   1005 ;	lib/oled.c: 401: oled_write_cmd(0x2E);   // Deactivate scroll
      008D3F A6 2E            [ 1] 1006 	ld	a, #0x2e
                                   1007 ;	lib/oled.c: 402: }
      008D41 CC 88 A4         [ 2] 1008 	jp	_oled_write_cmd
                                   1009 ;	lib/oled.c: 404: void oled_print_number(unsigned int num)
                                   1010 ;	-----------------------------------------
                                   1011 ;	 function oled_print_number
                                   1012 ;	-----------------------------------------
      008D44                       1013 _oled_print_number:
      008D44 52 09            [ 2] 1014 	sub	sp, #9
                                   1015 ;	lib/oled.c: 409: if(num == 0) {
      008D46 1F 07            [ 2] 1016 	ldw	(0x07, sp), x
      008D48 26 07            [ 1] 1017 	jrne	00113$
                                   1018 ;	lib/oled.c: 410: oled_putc('0');
      008D4A A6 30            [ 1] 1019 	ld	a, #0x30
      008D4C CD 8C 04         [ 4] 1020 	call	_oled_putc
                                   1021 ;	lib/oled.c: 411: return;
      008D4F 20 49            [ 2] 1022 	jra	00109$
                                   1023 ;	lib/oled.c: 414: while(num > 0) {
      008D51                       1024 00113$:
      008D51 4F               [ 1] 1025 	clr	a
      008D52                       1026 00103$:
      008D52 1E 07            [ 2] 1027 	ldw	x, (0x07, sp)
      008D54 27 28            [ 1] 1028 	jreq	00115$
                                   1029 ;	lib/oled.c: 415: buffer[i++] = (num % 10) + '0';
      008D56 96               [ 1] 1030 	ldw	x, sp
      008D57 5C               [ 1] 1031 	incw	x
      008D58 89               [ 2] 1032 	pushw	x
      008D59 5F               [ 1] 1033 	clrw	x
      008D5A 97               [ 1] 1034 	ld	xl, a
      008D5B 72 FB 01         [ 2] 1035 	addw	x, (1, sp)
      008D5E 5B 02            [ 2] 1036 	addw	sp, #2
      008D60 4C               [ 1] 1037 	inc	a
      008D61 89               [ 2] 1038 	pushw	x
      008D62 1E 09            [ 2] 1039 	ldw	x, (0x09, sp)
      008D64 90 AE 00 0A      [ 2] 1040 	ldw	y, #0x000a
      008D68 65               [ 2] 1041 	divw	x, y
      008D69 85               [ 2] 1042 	popw	x
      008D6A 72 A9 00 30      [ 2] 1043 	addw	y, #48
      008D6E 88               [ 1] 1044 	push	a
      008D6F 90 9F            [ 1] 1045 	ld	a, yl
      008D71 F7               [ 1] 1046 	ld	(x), a
      008D72 84               [ 1] 1047 	pop	a
                                   1048 ;	lib/oled.c: 416: num /= 10;
      008D73 1E 07            [ 2] 1049 	ldw	x, (0x07, sp)
      008D75 90 AE 00 0A      [ 2] 1050 	ldw	y, #0x000a
      008D79 65               [ 2] 1051 	divw	x, y
      008D7A 1F 07            [ 2] 1052 	ldw	(0x07, sp), x
      008D7C 20 D4            [ 2] 1053 	jra	00103$
                                   1054 ;	lib/oled.c: 419: while(i > 0) {
      008D7E                       1055 00115$:
      008D7E 6B 09            [ 1] 1056 	ld	(0x09, sp), a
      008D80                       1057 00106$:
      008D80 0D 09            [ 1] 1058 	tnz	(0x09, sp)
      008D82 27 16            [ 1] 1059 	jreq	00109$
                                   1060 ;	lib/oled.c: 420: oled_putc(buffer[--i]);
      008D84 0A 09            [ 1] 1061 	dec	(0x09, sp)
      008D86 5F               [ 1] 1062 	clrw	x
      008D87 7B 09            [ 1] 1063 	ld	a, (0x09, sp)
      008D89 97               [ 1] 1064 	ld	xl, a
      008D8A 89               [ 2] 1065 	pushw	x
      008D8B 96               [ 1] 1066 	ldw	x, sp
      008D8C 1C 00 03         [ 2] 1067 	addw	x, #3
      008D8F 72 FB 01         [ 2] 1068 	addw	x, (1, sp)
      008D92 5B 02            [ 2] 1069 	addw	sp, #2
      008D94 F6               [ 1] 1070 	ld	a, (x)
      008D95 CD 8C 04         [ 4] 1071 	call	_oled_putc
      008D98 20 E6            [ 2] 1072 	jra	00106$
      008D9A                       1073 00109$:
                                   1074 ;	lib/oled.c: 422: }
      008D9A 5B 09            [ 2] 1075 	addw	sp, #9
      008D9C 81               [ 4] 1076 	ret
                                   1077 ;	lib/oled.c: 424: void oled_print_hex(unsigned char num)
                                   1078 ;	-----------------------------------------
                                   1079 ;	 function oled_print_hex
                                   1080 ;	-----------------------------------------
      008D9D                       1081 _oled_print_hex:
      008D9D 88               [ 1] 1082 	push	a
                                   1083 ;	lib/oled.c: 426: unsigned char high = (num >> 4) & 0x0F;
      008D9E 97               [ 1] 1084 	ld	xl, a
      008D9F 4E               [ 1] 1085 	swap	a
      008DA0 A4 0F            [ 1] 1086 	and	a, #15
                                   1087 ;	lib/oled.c: 427: unsigned char low = num & 0x0F;
      008DA2 88               [ 1] 1088 	push	a
      008DA3 9F               [ 1] 1089 	ld	a, xl
      008DA4 A4 0F            [ 1] 1090 	and	a, #0x0f
      008DA6 6B 02            [ 1] 1091 	ld	(0x02, sp), a
      008DA8 84               [ 1] 1092 	pop	a
                                   1093 ;	lib/oled.c: 429: oled_putc(high < 10 ? high + '0' : high - 10 + 'A');
      008DA9 97               [ 1] 1094 	ld	xl, a
      008DAA A1 0A            [ 1] 1095 	cp	a, #0x0a
      008DAC 24 05            [ 1] 1096 	jrnc	00103$
      008DAE 9F               [ 1] 1097 	ld	a, xl
      008DAF AB 30            [ 1] 1098 	add	a, #0x30
      008DB1 20 03            [ 2] 1099 	jra	00104$
      008DB3                       1100 00103$:
      008DB3 9F               [ 1] 1101 	ld	a, xl
      008DB4 AB 37            [ 1] 1102 	add	a, #0x37
      008DB6                       1103 00104$:
      008DB6 CD 8C 04         [ 4] 1104 	call	_oled_putc
                                   1105 ;	lib/oled.c: 430: oled_putc(low < 10 ? low + '0' : low - 10 + 'A');
      008DB9 7B 01            [ 1] 1106 	ld	a, (0x01, sp)
      008DBB 88               [ 1] 1107 	push	a
      008DBC 7B 02            [ 1] 1108 	ld	a, (0x02, sp)
      008DBE A1 0A            [ 1] 1109 	cp	a, #0x0a
      008DC0 84               [ 1] 1110 	pop	a
      008DC1 24 04            [ 1] 1111 	jrnc	00105$
      008DC3 AB 30            [ 1] 1112 	add	a, #0x30
      008DC5 20 02            [ 2] 1113 	jra	00106$
      008DC7                       1114 00105$:
      008DC7 AB 37            [ 1] 1115 	add	a, #0x37
      008DC9                       1116 00106$:
      008DC9 5B 01            [ 2] 1117 	addw	sp, #1
      008DCB CC 8C 04         [ 2] 1118 	jp	_oled_putc
                                   1119 ;	lib/oled.c: 431: }
      008DCE 84               [ 1] 1120 	pop	a
      008DCF 81               [ 4] 1121 	ret
                                   1122 	.area CODE
                                   1123 	.area CONST
                                   1124 	.area CONST
      00807F                       1125 _font_6x8:
      00807F 00                    1126 	.db #0x00	; 0
      008080 00                    1127 	.db #0x00	; 0
      008081 00                    1128 	.db #0x00	; 0
      008082 00                    1129 	.db #0x00	; 0
      008083 00                    1130 	.db #0x00	; 0
      008084 00                    1131 	.db #0x00	; 0
      008085 00                    1132 	.db #0x00	; 0
      008086 00                    1133 	.db #0x00	; 0
      008087 00                    1134 	.db #0x00	; 0
      008088 2F                    1135 	.db #0x2f	; 47
      008089 00                    1136 	.db #0x00	; 0
      00808A 00                    1137 	.db #0x00	; 0
      00808B 00                    1138 	.db #0x00	; 0
      00808C 00                    1139 	.db #0x00	; 0
      00808D 07                    1140 	.db #0x07	; 7
      00808E 00                    1141 	.db #0x00	; 0
      00808F 07                    1142 	.db #0x07	; 7
      008090 00                    1143 	.db #0x00	; 0
      008091 00                    1144 	.db #0x00	; 0
      008092 14                    1145 	.db #0x14	; 20
      008093 7F                    1146 	.db #0x7f	; 127
      008094 14                    1147 	.db #0x14	; 20
      008095 7F                    1148 	.db #0x7f	; 127
      008096 14                    1149 	.db #0x14	; 20
      008097 00                    1150 	.db #0x00	; 0
      008098 24                    1151 	.db #0x24	; 36
      008099 2A                    1152 	.db #0x2a	; 42
      00809A 7F                    1153 	.db #0x7f	; 127
      00809B 2A                    1154 	.db #0x2a	; 42
      00809C 12                    1155 	.db #0x12	; 18
      00809D 00                    1156 	.db #0x00	; 0
      00809E 23                    1157 	.db #0x23	; 35
      00809F 13                    1158 	.db #0x13	; 19
      0080A0 08                    1159 	.db #0x08	; 8
      0080A1 64                    1160 	.db #0x64	; 100	'd'
      0080A2 62                    1161 	.db #0x62	; 98	'b'
      0080A3 00                    1162 	.db #0x00	; 0
      0080A4 36                    1163 	.db #0x36	; 54	'6'
      0080A5 49                    1164 	.db #0x49	; 73	'I'
      0080A6 55                    1165 	.db #0x55	; 85	'U'
      0080A7 22                    1166 	.db #0x22	; 34
      0080A8 50                    1167 	.db #0x50	; 80	'P'
      0080A9 00                    1168 	.db #0x00	; 0
      0080AA 00                    1169 	.db #0x00	; 0
      0080AB 05                    1170 	.db #0x05	; 5
      0080AC 03                    1171 	.db #0x03	; 3
      0080AD 00                    1172 	.db #0x00	; 0
      0080AE 00                    1173 	.db #0x00	; 0
      0080AF 00                    1174 	.db #0x00	; 0
      0080B0 00                    1175 	.db #0x00	; 0
      0080B1 1C                    1176 	.db #0x1c	; 28
      0080B2 22                    1177 	.db #0x22	; 34
      0080B3 41                    1178 	.db #0x41	; 65	'A'
      0080B4 00                    1179 	.db #0x00	; 0
      0080B5 00                    1180 	.db #0x00	; 0
      0080B6 00                    1181 	.db #0x00	; 0
      0080B7 41                    1182 	.db #0x41	; 65	'A'
      0080B8 22                    1183 	.db #0x22	; 34
      0080B9 1C                    1184 	.db #0x1c	; 28
      0080BA 00                    1185 	.db #0x00	; 0
      0080BB 00                    1186 	.db #0x00	; 0
      0080BC 14                    1187 	.db #0x14	; 20
      0080BD 08                    1188 	.db #0x08	; 8
      0080BE 3E                    1189 	.db #0x3e	; 62
      0080BF 08                    1190 	.db #0x08	; 8
      0080C0 14                    1191 	.db #0x14	; 20
      0080C1 00                    1192 	.db #0x00	; 0
      0080C2 08                    1193 	.db #0x08	; 8
      0080C3 08                    1194 	.db #0x08	; 8
      0080C4 3E                    1195 	.db #0x3e	; 62
      0080C5 08                    1196 	.db #0x08	; 8
      0080C6 08                    1197 	.db #0x08	; 8
      0080C7 00                    1198 	.db #0x00	; 0
      0080C8 00                    1199 	.db #0x00	; 0
      0080C9 00                    1200 	.db #0x00	; 0
      0080CA 50                    1201 	.db #0x50	; 80	'P'
      0080CB 30                    1202 	.db #0x30	; 48	'0'
      0080CC 00                    1203 	.db #0x00	; 0
      0080CD 00                    1204 	.db #0x00	; 0
      0080CE 08                    1205 	.db #0x08	; 8
      0080CF 08                    1206 	.db #0x08	; 8
      0080D0 08                    1207 	.db #0x08	; 8
      0080D1 08                    1208 	.db #0x08	; 8
      0080D2 08                    1209 	.db #0x08	; 8
      0080D3 00                    1210 	.db #0x00	; 0
      0080D4 00                    1211 	.db #0x00	; 0
      0080D5 60                    1212 	.db #0x60	; 96
      0080D6 60                    1213 	.db #0x60	; 96
      0080D7 00                    1214 	.db #0x00	; 0
      0080D8 00                    1215 	.db #0x00	; 0
      0080D9 00                    1216 	.db #0x00	; 0
      0080DA 20                    1217 	.db #0x20	; 32
      0080DB 10                    1218 	.db #0x10	; 16
      0080DC 08                    1219 	.db #0x08	; 8
      0080DD 04                    1220 	.db #0x04	; 4
      0080DE 02                    1221 	.db #0x02	; 2
      0080DF 00                    1222 	.db #0x00	; 0
      0080E0 3E                    1223 	.db #0x3e	; 62
      0080E1 51                    1224 	.db #0x51	; 81	'Q'
      0080E2 49                    1225 	.db #0x49	; 73	'I'
      0080E3 45                    1226 	.db #0x45	; 69	'E'
      0080E4 3E                    1227 	.db #0x3e	; 62
      0080E5 00                    1228 	.db #0x00	; 0
      0080E6 00                    1229 	.db #0x00	; 0
      0080E7 42                    1230 	.db #0x42	; 66	'B'
      0080E8 7F                    1231 	.db #0x7f	; 127
      0080E9 40                    1232 	.db #0x40	; 64
      0080EA 00                    1233 	.db #0x00	; 0
      0080EB 00                    1234 	.db #0x00	; 0
      0080EC 42                    1235 	.db #0x42	; 66	'B'
      0080ED 61                    1236 	.db #0x61	; 97	'a'
      0080EE 51                    1237 	.db #0x51	; 81	'Q'
      0080EF 49                    1238 	.db #0x49	; 73	'I'
      0080F0 46                    1239 	.db #0x46	; 70	'F'
      0080F1 00                    1240 	.db #0x00	; 0
      0080F2 21                    1241 	.db #0x21	; 33
      0080F3 41                    1242 	.db #0x41	; 65	'A'
      0080F4 45                    1243 	.db #0x45	; 69	'E'
      0080F5 4B                    1244 	.db #0x4b	; 75	'K'
      0080F6 31                    1245 	.db #0x31	; 49	'1'
      0080F7 00                    1246 	.db #0x00	; 0
      0080F8 18                    1247 	.db #0x18	; 24
      0080F9 14                    1248 	.db #0x14	; 20
      0080FA 12                    1249 	.db #0x12	; 18
      0080FB 7F                    1250 	.db #0x7f	; 127
      0080FC 10                    1251 	.db #0x10	; 16
      0080FD 00                    1252 	.db #0x00	; 0
      0080FE 27                    1253 	.db #0x27	; 39
      0080FF 45                    1254 	.db #0x45	; 69	'E'
      008100 45                    1255 	.db #0x45	; 69	'E'
      008101 45                    1256 	.db #0x45	; 69	'E'
      008102 39                    1257 	.db #0x39	; 57	'9'
      008103 00                    1258 	.db #0x00	; 0
      008104 3C                    1259 	.db #0x3c	; 60
      008105 4A                    1260 	.db #0x4a	; 74	'J'
      008106 49                    1261 	.db #0x49	; 73	'I'
      008107 49                    1262 	.db #0x49	; 73	'I'
      008108 30                    1263 	.db #0x30	; 48	'0'
      008109 00                    1264 	.db #0x00	; 0
      00810A 01                    1265 	.db #0x01	; 1
      00810B 71                    1266 	.db #0x71	; 113	'q'
      00810C 09                    1267 	.db #0x09	; 9
      00810D 05                    1268 	.db #0x05	; 5
      00810E 03                    1269 	.db #0x03	; 3
      00810F 00                    1270 	.db #0x00	; 0
      008110 36                    1271 	.db #0x36	; 54	'6'
      008111 49                    1272 	.db #0x49	; 73	'I'
      008112 49                    1273 	.db #0x49	; 73	'I'
      008113 49                    1274 	.db #0x49	; 73	'I'
      008114 36                    1275 	.db #0x36	; 54	'6'
      008115 00                    1276 	.db #0x00	; 0
      008116 06                    1277 	.db #0x06	; 6
      008117 49                    1278 	.db #0x49	; 73	'I'
      008118 49                    1279 	.db #0x49	; 73	'I'
      008119 29                    1280 	.db #0x29	; 41
      00811A 1E                    1281 	.db #0x1e	; 30
      00811B 00                    1282 	.db #0x00	; 0
      00811C 00                    1283 	.db #0x00	; 0
      00811D 36                    1284 	.db #0x36	; 54	'6'
      00811E 36                    1285 	.db #0x36	; 54	'6'
      00811F 00                    1286 	.db #0x00	; 0
      008120 00                    1287 	.db #0x00	; 0
      008121 00                    1288 	.db #0x00	; 0
      008122 00                    1289 	.db #0x00	; 0
      008123 56                    1290 	.db #0x56	; 86	'V'
      008124 36                    1291 	.db #0x36	; 54	'6'
      008125 00                    1292 	.db #0x00	; 0
      008126 00                    1293 	.db #0x00	; 0
      008127 00                    1294 	.db #0x00	; 0
      008128 08                    1295 	.db #0x08	; 8
      008129 14                    1296 	.db #0x14	; 20
      00812A 22                    1297 	.db #0x22	; 34
      00812B 41                    1298 	.db #0x41	; 65	'A'
      00812C 00                    1299 	.db #0x00	; 0
      00812D 00                    1300 	.db #0x00	; 0
      00812E 14                    1301 	.db #0x14	; 20
      00812F 14                    1302 	.db #0x14	; 20
      008130 14                    1303 	.db #0x14	; 20
      008131 14                    1304 	.db #0x14	; 20
      008132 14                    1305 	.db #0x14	; 20
      008133 00                    1306 	.db #0x00	; 0
      008134 00                    1307 	.db #0x00	; 0
      008135 41                    1308 	.db #0x41	; 65	'A'
      008136 22                    1309 	.db #0x22	; 34
      008137 14                    1310 	.db #0x14	; 20
      008138 08                    1311 	.db #0x08	; 8
      008139 00                    1312 	.db #0x00	; 0
      00813A 02                    1313 	.db #0x02	; 2
      00813B 01                    1314 	.db #0x01	; 1
      00813C 51                    1315 	.db #0x51	; 81	'Q'
      00813D 09                    1316 	.db #0x09	; 9
      00813E 06                    1317 	.db #0x06	; 6
      00813F 00                    1318 	.db #0x00	; 0
      008140 32                    1319 	.db #0x32	; 50	'2'
      008141 49                    1320 	.db #0x49	; 73	'I'
      008142 79                    1321 	.db #0x79	; 121	'y'
      008143 41                    1322 	.db #0x41	; 65	'A'
      008144 3E                    1323 	.db #0x3e	; 62
      008145 00                    1324 	.db #0x00	; 0
      008146 7E                    1325 	.db #0x7e	; 126
      008147 11                    1326 	.db #0x11	; 17
      008148 11                    1327 	.db #0x11	; 17
      008149 11                    1328 	.db #0x11	; 17
      00814A 7E                    1329 	.db #0x7e	; 126
      00814B 00                    1330 	.db #0x00	; 0
      00814C 7F                    1331 	.db #0x7f	; 127
      00814D 49                    1332 	.db #0x49	; 73	'I'
      00814E 49                    1333 	.db #0x49	; 73	'I'
      00814F 49                    1334 	.db #0x49	; 73	'I'
      008150 36                    1335 	.db #0x36	; 54	'6'
      008151 00                    1336 	.db #0x00	; 0
      008152 3E                    1337 	.db #0x3e	; 62
      008153 41                    1338 	.db #0x41	; 65	'A'
      008154 41                    1339 	.db #0x41	; 65	'A'
      008155 41                    1340 	.db #0x41	; 65	'A'
      008156 22                    1341 	.db #0x22	; 34
      008157 00                    1342 	.db #0x00	; 0
      008158 7F                    1343 	.db #0x7f	; 127
      008159 41                    1344 	.db #0x41	; 65	'A'
      00815A 41                    1345 	.db #0x41	; 65	'A'
      00815B 22                    1346 	.db #0x22	; 34
      00815C 1C                    1347 	.db #0x1c	; 28
      00815D 00                    1348 	.db #0x00	; 0
      00815E 7F                    1349 	.db #0x7f	; 127
      00815F 49                    1350 	.db #0x49	; 73	'I'
      008160 49                    1351 	.db #0x49	; 73	'I'
      008161 49                    1352 	.db #0x49	; 73	'I'
      008162 41                    1353 	.db #0x41	; 65	'A'
      008163 00                    1354 	.db #0x00	; 0
      008164 7F                    1355 	.db #0x7f	; 127
      008165 09                    1356 	.db #0x09	; 9
      008166 09                    1357 	.db #0x09	; 9
      008167 09                    1358 	.db #0x09	; 9
      008168 01                    1359 	.db #0x01	; 1
      008169 00                    1360 	.db #0x00	; 0
      00816A 3E                    1361 	.db #0x3e	; 62
      00816B 41                    1362 	.db #0x41	; 65	'A'
      00816C 49                    1363 	.db #0x49	; 73	'I'
      00816D 49                    1364 	.db #0x49	; 73	'I'
      00816E 7A                    1365 	.db #0x7a	; 122	'z'
      00816F 00                    1366 	.db #0x00	; 0
      008170 7F                    1367 	.db #0x7f	; 127
      008171 08                    1368 	.db #0x08	; 8
      008172 08                    1369 	.db #0x08	; 8
      008173 08                    1370 	.db #0x08	; 8
      008174 7F                    1371 	.db #0x7f	; 127
      008175 00                    1372 	.db #0x00	; 0
      008176 00                    1373 	.db #0x00	; 0
      008177 41                    1374 	.db #0x41	; 65	'A'
      008178 7F                    1375 	.db #0x7f	; 127
      008179 41                    1376 	.db #0x41	; 65	'A'
      00817A 00                    1377 	.db #0x00	; 0
      00817B 00                    1378 	.db #0x00	; 0
      00817C 20                    1379 	.db #0x20	; 32
      00817D 40                    1380 	.db #0x40	; 64
      00817E 41                    1381 	.db #0x41	; 65	'A'
      00817F 3F                    1382 	.db #0x3f	; 63
      008180 01                    1383 	.db #0x01	; 1
      008181 00                    1384 	.db #0x00	; 0
      008182 7F                    1385 	.db #0x7f	; 127
      008183 08                    1386 	.db #0x08	; 8
      008184 14                    1387 	.db #0x14	; 20
      008185 22                    1388 	.db #0x22	; 34
      008186 41                    1389 	.db #0x41	; 65	'A'
      008187 00                    1390 	.db #0x00	; 0
      008188 7F                    1391 	.db #0x7f	; 127
      008189 40                    1392 	.db #0x40	; 64
      00818A 40                    1393 	.db #0x40	; 64
      00818B 40                    1394 	.db #0x40	; 64
      00818C 40                    1395 	.db #0x40	; 64
      00818D 00                    1396 	.db #0x00	; 0
      00818E 7F                    1397 	.db #0x7f	; 127
      00818F 02                    1398 	.db #0x02	; 2
      008190 0C                    1399 	.db #0x0c	; 12
      008191 02                    1400 	.db #0x02	; 2
      008192 7F                    1401 	.db #0x7f	; 127
      008193 00                    1402 	.db #0x00	; 0
      008194 7F                    1403 	.db #0x7f	; 127
      008195 04                    1404 	.db #0x04	; 4
      008196 08                    1405 	.db #0x08	; 8
      008197 10                    1406 	.db #0x10	; 16
      008198 7F                    1407 	.db #0x7f	; 127
      008199 00                    1408 	.db #0x00	; 0
      00819A 3E                    1409 	.db #0x3e	; 62
      00819B 41                    1410 	.db #0x41	; 65	'A'
      00819C 41                    1411 	.db #0x41	; 65	'A'
      00819D 41                    1412 	.db #0x41	; 65	'A'
      00819E 3E                    1413 	.db #0x3e	; 62
      00819F 00                    1414 	.db #0x00	; 0
      0081A0 7F                    1415 	.db #0x7f	; 127
      0081A1 09                    1416 	.db #0x09	; 9
      0081A2 09                    1417 	.db #0x09	; 9
      0081A3 09                    1418 	.db #0x09	; 9
      0081A4 06                    1419 	.db #0x06	; 6
      0081A5 00                    1420 	.db #0x00	; 0
      0081A6 3E                    1421 	.db #0x3e	; 62
      0081A7 41                    1422 	.db #0x41	; 65	'A'
      0081A8 51                    1423 	.db #0x51	; 81	'Q'
      0081A9 21                    1424 	.db #0x21	; 33
      0081AA 5E                    1425 	.db #0x5e	; 94
      0081AB 00                    1426 	.db #0x00	; 0
      0081AC 7F                    1427 	.db #0x7f	; 127
      0081AD 09                    1428 	.db #0x09	; 9
      0081AE 19                    1429 	.db #0x19	; 25
      0081AF 29                    1430 	.db #0x29	; 41
      0081B0 46                    1431 	.db #0x46	; 70	'F'
      0081B1 00                    1432 	.db #0x00	; 0
      0081B2 46                    1433 	.db #0x46	; 70	'F'
      0081B3 49                    1434 	.db #0x49	; 73	'I'
      0081B4 49                    1435 	.db #0x49	; 73	'I'
      0081B5 49                    1436 	.db #0x49	; 73	'I'
      0081B6 31                    1437 	.db #0x31	; 49	'1'
      0081B7 00                    1438 	.db #0x00	; 0
      0081B8 01                    1439 	.db #0x01	; 1
      0081B9 01                    1440 	.db #0x01	; 1
      0081BA 7F                    1441 	.db #0x7f	; 127
      0081BB 01                    1442 	.db #0x01	; 1
      0081BC 01                    1443 	.db #0x01	; 1
      0081BD 00                    1444 	.db #0x00	; 0
      0081BE 3F                    1445 	.db #0x3f	; 63
      0081BF 40                    1446 	.db #0x40	; 64
      0081C0 40                    1447 	.db #0x40	; 64
      0081C1 40                    1448 	.db #0x40	; 64
      0081C2 3F                    1449 	.db #0x3f	; 63
      0081C3 00                    1450 	.db #0x00	; 0
      0081C4 1F                    1451 	.db #0x1f	; 31
      0081C5 20                    1452 	.db #0x20	; 32
      0081C6 40                    1453 	.db #0x40	; 64
      0081C7 20                    1454 	.db #0x20	; 32
      0081C8 1F                    1455 	.db #0x1f	; 31
      0081C9 00                    1456 	.db #0x00	; 0
      0081CA 3F                    1457 	.db #0x3f	; 63
      0081CB 40                    1458 	.db #0x40	; 64
      0081CC 38                    1459 	.db #0x38	; 56	'8'
      0081CD 40                    1460 	.db #0x40	; 64
      0081CE 3F                    1461 	.db #0x3f	; 63
      0081CF 00                    1462 	.db #0x00	; 0
      0081D0 63                    1463 	.db #0x63	; 99	'c'
      0081D1 14                    1464 	.db #0x14	; 20
      0081D2 08                    1465 	.db #0x08	; 8
      0081D3 14                    1466 	.db #0x14	; 20
      0081D4 63                    1467 	.db #0x63	; 99	'c'
      0081D5 00                    1468 	.db #0x00	; 0
      0081D6 07                    1469 	.db #0x07	; 7
      0081D7 08                    1470 	.db #0x08	; 8
      0081D8 70                    1471 	.db #0x70	; 112	'p'
      0081D9 08                    1472 	.db #0x08	; 8
      0081DA 07                    1473 	.db #0x07	; 7
      0081DB 00                    1474 	.db #0x00	; 0
      0081DC 61                    1475 	.db #0x61	; 97	'a'
      0081DD 51                    1476 	.db #0x51	; 81	'Q'
      0081DE 49                    1477 	.db #0x49	; 73	'I'
      0081DF 45                    1478 	.db #0x45	; 69	'E'
      0081E0 43                    1479 	.db #0x43	; 67	'C'
      0081E1 00                    1480 	.db #0x00	; 0
      0081E2 00                    1481 	.db #0x00	; 0
      0081E3 7F                    1482 	.db #0x7f	; 127
      0081E4 41                    1483 	.db #0x41	; 65	'A'
      0081E5 41                    1484 	.db #0x41	; 65	'A'
      0081E6 00                    1485 	.db #0x00	; 0
      0081E7 00                    1486 	.db #0x00	; 0
      0081E8 02                    1487 	.db #0x02	; 2
      0081E9 04                    1488 	.db #0x04	; 4
      0081EA 08                    1489 	.db #0x08	; 8
      0081EB 10                    1490 	.db #0x10	; 16
      0081EC 20                    1491 	.db #0x20	; 32
      0081ED 00                    1492 	.db #0x00	; 0
      0081EE 00                    1493 	.db #0x00	; 0
      0081EF 41                    1494 	.db #0x41	; 65	'A'
      0081F0 41                    1495 	.db #0x41	; 65	'A'
      0081F1 7F                    1496 	.db #0x7f	; 127
      0081F2 00                    1497 	.db #0x00	; 0
      0081F3 00                    1498 	.db #0x00	; 0
      0081F4 04                    1499 	.db #0x04	; 4
      0081F5 02                    1500 	.db #0x02	; 2
      0081F6 01                    1501 	.db #0x01	; 1
      0081F7 02                    1502 	.db #0x02	; 2
      0081F8 04                    1503 	.db #0x04	; 4
      0081F9 00                    1504 	.db #0x00	; 0
      0081FA 40                    1505 	.db #0x40	; 64
      0081FB 40                    1506 	.db #0x40	; 64
      0081FC 40                    1507 	.db #0x40	; 64
      0081FD 40                    1508 	.db #0x40	; 64
      0081FE 40                    1509 	.db #0x40	; 64
      0081FF 00                    1510 	.db #0x00	; 0
      008200 00                    1511 	.db #0x00	; 0
      008201 01                    1512 	.db #0x01	; 1
      008202 02                    1513 	.db #0x02	; 2
      008203 04                    1514 	.db #0x04	; 4
      008204 00                    1515 	.db #0x00	; 0
      008205 00                    1516 	.db #0x00	; 0
      008206 20                    1517 	.db #0x20	; 32
      008207 54                    1518 	.db #0x54	; 84	'T'
      008208 54                    1519 	.db #0x54	; 84	'T'
      008209 54                    1520 	.db #0x54	; 84	'T'
      00820A 78                    1521 	.db #0x78	; 120	'x'
      00820B 00                    1522 	.db #0x00	; 0
      00820C 7F                    1523 	.db #0x7f	; 127
      00820D 48                    1524 	.db #0x48	; 72	'H'
      00820E 44                    1525 	.db #0x44	; 68	'D'
      00820F 44                    1526 	.db #0x44	; 68	'D'
      008210 38                    1527 	.db #0x38	; 56	'8'
      008211 00                    1528 	.db #0x00	; 0
      008212 38                    1529 	.db #0x38	; 56	'8'
      008213 44                    1530 	.db #0x44	; 68	'D'
      008214 44                    1531 	.db #0x44	; 68	'D'
      008215 44                    1532 	.db #0x44	; 68	'D'
      008216 20                    1533 	.db #0x20	; 32
      008217 00                    1534 	.db #0x00	; 0
      008218 38                    1535 	.db #0x38	; 56	'8'
      008219 44                    1536 	.db #0x44	; 68	'D'
      00821A 44                    1537 	.db #0x44	; 68	'D'
      00821B 48                    1538 	.db #0x48	; 72	'H'
      00821C 7F                    1539 	.db #0x7f	; 127
      00821D 00                    1540 	.db #0x00	; 0
      00821E 38                    1541 	.db #0x38	; 56	'8'
      00821F 54                    1542 	.db #0x54	; 84	'T'
      008220 54                    1543 	.db #0x54	; 84	'T'
      008221 54                    1544 	.db #0x54	; 84	'T'
      008222 18                    1545 	.db #0x18	; 24
      008223 00                    1546 	.db #0x00	; 0
      008224 08                    1547 	.db #0x08	; 8
      008225 7E                    1548 	.db #0x7e	; 126
      008226 09                    1549 	.db #0x09	; 9
      008227 01                    1550 	.db #0x01	; 1
      008228 02                    1551 	.db #0x02	; 2
      008229 00                    1552 	.db #0x00	; 0
      00822A 0C                    1553 	.db #0x0c	; 12
      00822B 52                    1554 	.db #0x52	; 82	'R'
      00822C 52                    1555 	.db #0x52	; 82	'R'
      00822D 52                    1556 	.db #0x52	; 82	'R'
      00822E 3E                    1557 	.db #0x3e	; 62
      00822F 00                    1558 	.db #0x00	; 0
      008230 7F                    1559 	.db #0x7f	; 127
      008231 08                    1560 	.db #0x08	; 8
      008232 04                    1561 	.db #0x04	; 4
      008233 04                    1562 	.db #0x04	; 4
      008234 78                    1563 	.db #0x78	; 120	'x'
      008235 00                    1564 	.db #0x00	; 0
      008236 00                    1565 	.db #0x00	; 0
      008237 44                    1566 	.db #0x44	; 68	'D'
      008238 7D                    1567 	.db #0x7d	; 125
      008239 40                    1568 	.db #0x40	; 64
      00823A 00                    1569 	.db #0x00	; 0
      00823B 00                    1570 	.db #0x00	; 0
      00823C 20                    1571 	.db #0x20	; 32
      00823D 40                    1572 	.db #0x40	; 64
      00823E 44                    1573 	.db #0x44	; 68	'D'
      00823F 3D                    1574 	.db #0x3d	; 61
      008240 00                    1575 	.db #0x00	; 0
      008241 00                    1576 	.db #0x00	; 0
      008242 7F                    1577 	.db #0x7f	; 127
      008243 10                    1578 	.db #0x10	; 16
      008244 28                    1579 	.db #0x28	; 40
      008245 44                    1580 	.db #0x44	; 68	'D'
      008246 00                    1581 	.db #0x00	; 0
      008247 00                    1582 	.db #0x00	; 0
      008248 00                    1583 	.db #0x00	; 0
      008249 41                    1584 	.db #0x41	; 65	'A'
      00824A 7F                    1585 	.db #0x7f	; 127
      00824B 40                    1586 	.db #0x40	; 64
      00824C 00                    1587 	.db #0x00	; 0
      00824D 00                    1588 	.db #0x00	; 0
      00824E 7C                    1589 	.db #0x7c	; 124
      00824F 04                    1590 	.db #0x04	; 4
      008250 18                    1591 	.db #0x18	; 24
      008251 04                    1592 	.db #0x04	; 4
      008252 78                    1593 	.db #0x78	; 120	'x'
      008253 00                    1594 	.db #0x00	; 0
      008254 7C                    1595 	.db #0x7c	; 124
      008255 08                    1596 	.db #0x08	; 8
      008256 04                    1597 	.db #0x04	; 4
      008257 04                    1598 	.db #0x04	; 4
      008258 78                    1599 	.db #0x78	; 120	'x'
      008259 00                    1600 	.db #0x00	; 0
      00825A 38                    1601 	.db #0x38	; 56	'8'
      00825B 44                    1602 	.db #0x44	; 68	'D'
      00825C 44                    1603 	.db #0x44	; 68	'D'
      00825D 44                    1604 	.db #0x44	; 68	'D'
      00825E 38                    1605 	.db #0x38	; 56	'8'
      00825F 00                    1606 	.db #0x00	; 0
      008260 7C                    1607 	.db #0x7c	; 124
      008261 14                    1608 	.db #0x14	; 20
      008262 14                    1609 	.db #0x14	; 20
      008263 14                    1610 	.db #0x14	; 20
      008264 08                    1611 	.db #0x08	; 8
      008265 00                    1612 	.db #0x00	; 0
      008266 08                    1613 	.db #0x08	; 8
      008267 14                    1614 	.db #0x14	; 20
      008268 14                    1615 	.db #0x14	; 20
      008269 18                    1616 	.db #0x18	; 24
      00826A 7C                    1617 	.db #0x7c	; 124
      00826B 00                    1618 	.db #0x00	; 0
      00826C 7C                    1619 	.db #0x7c	; 124
      00826D 08                    1620 	.db #0x08	; 8
      00826E 04                    1621 	.db #0x04	; 4
      00826F 04                    1622 	.db #0x04	; 4
      008270 08                    1623 	.db #0x08	; 8
      008271 00                    1624 	.db #0x00	; 0
      008272 48                    1625 	.db #0x48	; 72	'H'
      008273 54                    1626 	.db #0x54	; 84	'T'
      008274 54                    1627 	.db #0x54	; 84	'T'
      008275 54                    1628 	.db #0x54	; 84	'T'
      008276 20                    1629 	.db #0x20	; 32
      008277 00                    1630 	.db #0x00	; 0
      008278 04                    1631 	.db #0x04	; 4
      008279 3F                    1632 	.db #0x3f	; 63
      00827A 44                    1633 	.db #0x44	; 68	'D'
      00827B 40                    1634 	.db #0x40	; 64
      00827C 20                    1635 	.db #0x20	; 32
      00827D 00                    1636 	.db #0x00	; 0
      00827E 3C                    1637 	.db #0x3c	; 60
      00827F 40                    1638 	.db #0x40	; 64
      008280 40                    1639 	.db #0x40	; 64
      008281 20                    1640 	.db #0x20	; 32
      008282 7C                    1641 	.db #0x7c	; 124
      008283 00                    1642 	.db #0x00	; 0
      008284 1C                    1643 	.db #0x1c	; 28
      008285 20                    1644 	.db #0x20	; 32
      008286 40                    1645 	.db #0x40	; 64
      008287 20                    1646 	.db #0x20	; 32
      008288 1C                    1647 	.db #0x1c	; 28
      008289 00                    1648 	.db #0x00	; 0
      00828A 3C                    1649 	.db #0x3c	; 60
      00828B 40                    1650 	.db #0x40	; 64
      00828C 30                    1651 	.db #0x30	; 48	'0'
      00828D 40                    1652 	.db #0x40	; 64
      00828E 3C                    1653 	.db #0x3c	; 60
      00828F 00                    1654 	.db #0x00	; 0
      008290 44                    1655 	.db #0x44	; 68	'D'
      008291 28                    1656 	.db #0x28	; 40
      008292 10                    1657 	.db #0x10	; 16
      008293 28                    1658 	.db #0x28	; 40
      008294 44                    1659 	.db #0x44	; 68	'D'
      008295 00                    1660 	.db #0x00	; 0
      008296 0C                    1661 	.db #0x0c	; 12
      008297 50                    1662 	.db #0x50	; 80	'P'
      008298 50                    1663 	.db #0x50	; 80	'P'
      008299 50                    1664 	.db #0x50	; 80	'P'
      00829A 3C                    1665 	.db #0x3c	; 60
      00829B 00                    1666 	.db #0x00	; 0
      00829C 44                    1667 	.db #0x44	; 68	'D'
      00829D 64                    1668 	.db #0x64	; 100	'd'
      00829E 54                    1669 	.db #0x54	; 84	'T'
      00829F 4C                    1670 	.db #0x4c	; 76	'L'
      0082A0 44                    1671 	.db #0x44	; 68	'D'
      0082A1 00                    1672 	.db #0x00	; 0
      0082A2 00                    1673 	.db #0x00	; 0
      0082A3 08                    1674 	.db #0x08	; 8
      0082A4 36                    1675 	.db #0x36	; 54	'6'
      0082A5 41                    1676 	.db #0x41	; 65	'A'
      0082A6 00                    1677 	.db #0x00	; 0
      0082A7 00                    1678 	.db #0x00	; 0
      0082A8 00                    1679 	.db #0x00	; 0
      0082A9 00                    1680 	.db #0x00	; 0
      0082AA 7F                    1681 	.db #0x7f	; 127
      0082AB 00                    1682 	.db #0x00	; 0
      0082AC 00                    1683 	.db #0x00	; 0
      0082AD 00                    1684 	.db #0x00	; 0
      0082AE 00                    1685 	.db #0x00	; 0
      0082AF 41                    1686 	.db #0x41	; 65	'A'
      0082B0 36                    1687 	.db #0x36	; 54	'6'
      0082B1 08                    1688 	.db #0x08	; 8
      0082B2 00                    1689 	.db #0x00	; 0
      0082B3 00                    1690 	.db #0x00	; 0
      0082B4 08                    1691 	.db #0x08	; 8
      0082B5 08                    1692 	.db #0x08	; 8
      0082B6 2A                    1693 	.db #0x2a	; 42
      0082B7 1C                    1694 	.db #0x1c	; 28
      0082B8 08                    1695 	.db #0x08	; 8
      0082B9 00                    1696 	.db 0x00
      0082BA 00                    1697 	.db 0x00
      0082BB 00                    1698 	.db 0x00
      0082BC 00                    1699 	.db 0x00
      0082BD 00                    1700 	.db 0x00
      0082BE 00                    1701 	.db 0x00
                                   1702 	.area CODE
                                   1703 	.area INITIALIZER
      0082BF                       1704 __xinit__oled_cursor_x:
      0082BF 00                    1705 	.db #0x00	; 0
      0082C0                       1706 __xinit__oled_cursor_y:
      0082C0 00                    1707 	.db #0x00	; 0
      0082C1                       1708 __xinit__oled_current_font:
      0082C1 01                    1709 	.db #0x01	; 1
                                   1710 	.area CABS (ABS)
