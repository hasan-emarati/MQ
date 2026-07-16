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
      008963                         86 _oled_write_cmd:
      008963 88               [ 1]   87 	push	a
      008964 6B 01            [ 1]   88 	ld	(0x01, sp), a
                                     89 ;	lib/oled.c: 122: i2c_start();
      008966 CD 88 96         [ 4]   90 	call	_i2c_start
                                     91 ;	lib/oled.c: 123: i2c_send_addr(OLED_ADDR);
      008969 A6 78            [ 1]   92 	ld	a, #0x78
      00896B CD 88 B3         [ 4]   93 	call	_i2c_send_addr
                                     94 ;	lib/oled.c: 124: i2c_write(0x00);  // Command mode
      00896E 4F               [ 1]   95 	clr	a
      00896F CD 88 AA         [ 4]   96 	call	_i2c_write
                                     97 ;	lib/oled.c: 125: i2c_write(cmd);
      008972 7B 01            [ 1]   98 	ld	a, (0x01, sp)
      008974 CD 88 AA         [ 4]   99 	call	_i2c_write
                                    100 ;	lib/oled.c: 126: i2c_stop();
      008977 84               [ 1]  101 	pop	a
      008978 CC 88 A0         [ 2]  102 	jp	_i2c_stop
                                    103 ;	lib/oled.c: 127: }
      00897B 84               [ 1]  104 	pop	a
      00897C 81               [ 4]  105 	ret
                                    106 ;	lib/oled.c: 129: static void oled_write_cmd_multi(unsigned char* cmds, unsigned char len)
                                    107 ;	-----------------------------------------
                                    108 ;	 function oled_write_cmd_multi
                                    109 ;	-----------------------------------------
      00897D                        110 _oled_write_cmd_multi:
      00897D 52 04            [ 2]  111 	sub	sp, #4
      00897F 1F 02            [ 2]  112 	ldw	(0x02, sp), x
      008981 6B 01            [ 1]  113 	ld	(0x01, sp), a
                                    114 ;	lib/oled.c: 132: i2c_start();
      008983 CD 88 96         [ 4]  115 	call	_i2c_start
                                    116 ;	lib/oled.c: 133: i2c_send_addr(OLED_ADDR);
      008986 A6 78            [ 1]  117 	ld	a, #0x78
      008988 CD 88 B3         [ 4]  118 	call	_i2c_send_addr
                                    119 ;	lib/oled.c: 134: i2c_write(0x00);
      00898B 4F               [ 1]  120 	clr	a
      00898C CD 88 AA         [ 4]  121 	call	_i2c_write
                                    122 ;	lib/oled.c: 135: for(i = 0; i < len; i++) {
      00898F 0F 04            [ 1]  123 	clr	(0x04, sp)
      008991                        124 00103$:
      008991 7B 04            [ 1]  125 	ld	a, (0x04, sp)
      008993 11 01            [ 1]  126 	cp	a, (0x01, sp)
      008995 24 0F            [ 1]  127 	jrnc	00101$
                                    128 ;	lib/oled.c: 136: i2c_write(cmds[i]);
      008997 5F               [ 1]  129 	clrw	x
      008998 7B 04            [ 1]  130 	ld	a, (0x04, sp)
      00899A 97               [ 1]  131 	ld	xl, a
      00899B 72 FB 02         [ 2]  132 	addw	x, (0x02, sp)
      00899E F6               [ 1]  133 	ld	a, (x)
      00899F CD 88 AA         [ 4]  134 	call	_i2c_write
                                    135 ;	lib/oled.c: 135: for(i = 0; i < len; i++) {
      0089A2 0C 04            [ 1]  136 	inc	(0x04, sp)
      0089A4 20 EB            [ 2]  137 	jra	00103$
      0089A6                        138 00101$:
                                    139 ;	lib/oled.c: 138: i2c_stop();
      0089A6 5B 04            [ 2]  140 	addw	sp, #4
                                    141 ;	lib/oled.c: 139: }
      0089A8 CC 88 A0         [ 2]  142 	jp	_i2c_stop
                                    143 ;	lib/oled.c: 141: static void oled_send_buffer(void)
                                    144 ;	-----------------------------------------
                                    145 ;	 function oled_send_buffer
                                    146 ;	-----------------------------------------
      0089AB                        147 _oled_send_buffer:
      0089AB 52 04            [ 2]  148 	sub	sp, #4
                                    149 ;	lib/oled.c: 145: for(page = 0; page < OLED_PAGES; page++) {
      0089AD 0F 03            [ 1]  150 	clr	(0x03, sp)
      0089AF                        151 00105$:
                                    152 ;	lib/oled.c: 147: oled_write_cmd(0xB0 | page);
      0089AF 7B 03            [ 1]  153 	ld	a, (0x03, sp)
      0089B1 AA B0            [ 1]  154 	or	a, #0xb0
      0089B3 CD 89 63         [ 4]  155 	call	_oled_write_cmd
                                    156 ;	lib/oled.c: 148: oled_write_cmd(0x00);  // Low column
      0089B6 4F               [ 1]  157 	clr	a
      0089B7 CD 89 63         [ 4]  158 	call	_oled_write_cmd
                                    159 ;	lib/oled.c: 149: oled_write_cmd(0x10);  // High column
      0089BA A6 10            [ 1]  160 	ld	a, #0x10
      0089BC CD 89 63         [ 4]  161 	call	_oled_write_cmd
                                    162 ;	lib/oled.c: 152: i2c_start();
      0089BF CD 88 96         [ 4]  163 	call	_i2c_start
                                    164 ;	lib/oled.c: 153: i2c_send_addr(OLED_ADDR);
      0089C2 A6 78            [ 1]  165 	ld	a, #0x78
      0089C4 CD 88 B3         [ 4]  166 	call	_i2c_send_addr
                                    167 ;	lib/oled.c: 154: i2c_write(0x40);  // Data mode
      0089C7 A6 40            [ 1]  168 	ld	a, #0x40
      0089C9 CD 88 AA         [ 4]  169 	call	_i2c_write
                                    170 ;	lib/oled.c: 156: for(col = 0; col < OLED_WIDTH; col++) {
      0089CC 0F 04            [ 1]  171 	clr	(0x04, sp)
      0089CE                        172 00103$:
                                    173 ;	lib/oled.c: 157: i2c_write(oled_buffer[page * OLED_WIDTH + col]);
      0089CE 5F               [ 1]  174 	clrw	x
      0089CF 7B 03            [ 1]  175 	ld	a, (0x03, sp)
      0089D1 97               [ 1]  176 	ld	xl, a
      0089D2 58               [ 2]  177 	sllw	x
      0089D3 58               [ 2]  178 	sllw	x
      0089D4 58               [ 2]  179 	sllw	x
      0089D5 58               [ 2]  180 	sllw	x
      0089D6 58               [ 2]  181 	sllw	x
      0089D7 58               [ 2]  182 	sllw	x
      0089D8 58               [ 2]  183 	sllw	x
      0089D9 7B 04            [ 1]  184 	ld	a, (0x04, sp)
      0089DB 6B 02            [ 1]  185 	ld	(0x02, sp), a
      0089DD 0F 01            [ 1]  186 	clr	(0x01, sp)
      0089DF 72 FB 01         [ 2]  187 	addw	x, (0x01, sp)
      0089E2 D6 00 01         [ 1]  188 	ld	a, (_oled_buffer+0, x)
      0089E5 CD 88 AA         [ 4]  189 	call	_i2c_write
                                    190 ;	lib/oled.c: 156: for(col = 0; col < OLED_WIDTH; col++) {
      0089E8 0C 04            [ 1]  191 	inc	(0x04, sp)
      0089EA 7B 04            [ 1]  192 	ld	a, (0x04, sp)
      0089EC A1 80            [ 1]  193 	cp	a, #0x80
      0089EE 25 DE            [ 1]  194 	jrc	00103$
                                    195 ;	lib/oled.c: 159: i2c_stop();
      0089F0 CD 88 A0         [ 4]  196 	call	_i2c_stop
                                    197 ;	lib/oled.c: 145: for(page = 0; page < OLED_PAGES; page++) {
      0089F3 0C 03            [ 1]  198 	inc	(0x03, sp)
      0089F5 7B 03            [ 1]  199 	ld	a, (0x03, sp)
      0089F7 A1 04            [ 1]  200 	cp	a, #0x04
      0089F9 25 B4            [ 1]  201 	jrc	00105$
                                    202 ;	lib/oled.c: 161: }
      0089FB 5B 04            [ 2]  203 	addw	sp, #4
      0089FD 81               [ 4]  204 	ret
                                    205 ;	lib/oled.c: 166: void oled_init(void)
                                    206 ;	-----------------------------------------
                                    207 ;	 function oled_init
                                    208 ;	-----------------------------------------
      0089FE                        209 _oled_init:
      0089FE 52 19            [ 2]  210 	sub	sp, #25
                                    211 ;	lib/oled.c: 168: delay_ms(100);
      008A00 AE 00 64         [ 2]  212 	ldw	x, #0x0064
      008A03 CD 84 B9         [ 4]  213 	call	_delay_ms
                                    214 ;	lib/oled.c: 170: unsigned char init_cmds[] = {
      008A06 96               [ 1]  215 	ldw	x, sp
      008A07 5C               [ 1]  216 	incw	x
      008A08 A6 AE            [ 1]  217 	ld	a, #0xae
      008A0A F7               [ 1]  218 	ld	(x), a
      008A0B A6 D5            [ 1]  219 	ld	a, #0xd5
      008A0D 6B 02            [ 1]  220 	ld	(0x02, sp), a
      008A0F A6 80            [ 1]  221 	ld	a, #0x80
      008A11 6B 03            [ 1]  222 	ld	(0x03, sp), a
      008A13 A6 A8            [ 1]  223 	ld	a, #0xa8
      008A15 6B 04            [ 1]  224 	ld	(0x04, sp), a
      008A17 A6 1F            [ 1]  225 	ld	a, #0x1f
      008A19 6B 05            [ 1]  226 	ld	(0x05, sp), a
      008A1B A6 D3            [ 1]  227 	ld	a, #0xd3
      008A1D 6B 06            [ 1]  228 	ld	(0x06, sp), a
      008A1F 0F 07            [ 1]  229 	clr	(0x07, sp)
      008A21 A6 40            [ 1]  230 	ld	a, #0x40
      008A23 6B 08            [ 1]  231 	ld	(0x08, sp), a
      008A25 A6 8D            [ 1]  232 	ld	a, #0x8d
      008A27 6B 09            [ 1]  233 	ld	(0x09, sp), a
      008A29 A6 14            [ 1]  234 	ld	a, #0x14
      008A2B 6B 0A            [ 1]  235 	ld	(0x0a, sp), a
      008A2D A6 20            [ 1]  236 	ld	a, #0x20
      008A2F 6B 0B            [ 1]  237 	ld	(0x0b, sp), a
      008A31 0F 0C            [ 1]  238 	clr	(0x0c, sp)
      008A33 A6 A1            [ 1]  239 	ld	a, #0xa1
      008A35 6B 0D            [ 1]  240 	ld	(0x0d, sp), a
      008A37 A6 C8            [ 1]  241 	ld	a, #0xc8
      008A39 6B 0E            [ 1]  242 	ld	(0x0e, sp), a
      008A3B A6 DA            [ 1]  243 	ld	a, #0xda
      008A3D 6B 0F            [ 1]  244 	ld	(0x0f, sp), a
      008A3F A6 02            [ 1]  245 	ld	a, #0x02
      008A41 6B 10            [ 1]  246 	ld	(0x10, sp), a
      008A43 A6 81            [ 1]  247 	ld	a, #0x81
      008A45 6B 11            [ 1]  248 	ld	(0x11, sp), a
      008A47 A6 CF            [ 1]  249 	ld	a, #0xcf
      008A49 6B 12            [ 1]  250 	ld	(0x12, sp), a
      008A4B A6 D9            [ 1]  251 	ld	a, #0xd9
      008A4D 6B 13            [ 1]  252 	ld	(0x13, sp), a
      008A4F A6 F1            [ 1]  253 	ld	a, #0xf1
      008A51 6B 14            [ 1]  254 	ld	(0x14, sp), a
      008A53 A6 DB            [ 1]  255 	ld	a, #0xdb
      008A55 6B 15            [ 1]  256 	ld	(0x15, sp), a
      008A57 A6 40            [ 1]  257 	ld	a, #0x40
      008A59 6B 16            [ 1]  258 	ld	(0x16, sp), a
      008A5B A6 A4            [ 1]  259 	ld	a, #0xa4
      008A5D 6B 17            [ 1]  260 	ld	(0x17, sp), a
      008A5F A6 A6            [ 1]  261 	ld	a, #0xa6
      008A61 6B 18            [ 1]  262 	ld	(0x18, sp), a
      008A63 A6 AF            [ 1]  263 	ld	a, #0xaf
      008A65 6B 19            [ 1]  264 	ld	(0x19, sp), a
                                    265 ;	lib/oled.c: 189: oled_write_cmd_multi(init_cmds, sizeof(init_cmds));
      008A67 A6 19            [ 1]  266 	ld	a, #0x19
      008A69 CD 89 7D         [ 4]  267 	call	_oled_write_cmd_multi
                                    268 ;	lib/oled.c: 192: oled_clear();
      008A6C CD 8A 77         [ 4]  269 	call	_oled_clear
                                    270 ;	lib/oled.c: 193: }
      008A6F 5B 19            [ 2]  271 	addw	sp, #25
      008A71 81               [ 4]  272 	ret
                                    273 ;	lib/oled.c: 195: void oled_deinit(void)
                                    274 ;	-----------------------------------------
                                    275 ;	 function oled_deinit
                                    276 ;	-----------------------------------------
      008A72                        277 _oled_deinit:
                                    278 ;	lib/oled.c: 197: oled_write_cmd(0xAE);  // Display OFF
      008A72 A6 AE            [ 1]  279 	ld	a, #0xae
                                    280 ;	lib/oled.c: 198: }
      008A74 CC 89 63         [ 2]  281 	jp	_oled_write_cmd
                                    282 ;	lib/oled.c: 200: void oled_clear(void)
                                    283 ;	-----------------------------------------
                                    284 ;	 function oled_clear
                                    285 ;	-----------------------------------------
      008A77                        286 _oled_clear:
                                    287 ;	lib/oled.c: 203: for(i = 0; i < sizeof(oled_buffer); i++) {
      008A77 90 5F            [ 1]  288 	clrw	y
      008A79                        289 00102$:
                                    290 ;	lib/oled.c: 204: oled_buffer[i] = 0x00;
      008A79 93               [ 1]  291 	ldw	x, y
      008A7A 72 4F 00 01      [ 1]  292 	clr	((_oled_buffer+0), x)
                                    293 ;	lib/oled.c: 203: for(i = 0; i < sizeof(oled_buffer); i++) {
      008A7E 90 5C            [ 1]  294 	incw	y
      008A80 93               [ 1]  295 	ldw	x, y
      008A81 A3 02 00         [ 2]  296 	cpw	x, #0x0200
      008A84 25 F3            [ 1]  297 	jrc	00102$
                                    298 ;	lib/oled.c: 206: oled_send_buffer();
                                    299 ;	lib/oled.c: 207: }
      008A86 CC 89 AB         [ 2]  300 	jp	_oled_send_buffer
                                    301 ;	lib/oled.c: 209: void oled_clear_page(unsigned char page)
                                    302 ;	-----------------------------------------
                                    303 ;	 function oled_clear_page
                                    304 ;	-----------------------------------------
      008A89                        305 _oled_clear_page:
      008A89 52 02            [ 2]  306 	sub	sp, #2
                                    307 ;	lib/oled.c: 212: if(page >= OLED_PAGES) return;
      008A8B 90 97            [ 1]  308 	ld	yl, a
      008A8D A1 04            [ 1]  309 	cp	a, #0x04
                                    310 ;	lib/oled.c: 214: for(col = 0; col < OLED_WIDTH; col++) {
      008A8F 24 4B            [ 1]  311 	jrnc	00109$
      008A91 4F               [ 1]  312 	clr	a
      008A92                        313 00105$:
                                    314 ;	lib/oled.c: 215: oled_buffer[page * OLED_WIDTH + col] = 0x00;
      008A92 5F               [ 1]  315 	clrw	x
      008A93 41               [ 1]  316 	exg	a, xl
      008A94 90 9F            [ 1]  317 	ld	a, yl
      008A96 41               [ 1]  318 	exg	a, xl
      008A97 58               [ 2]  319 	sllw	x
      008A98 58               [ 2]  320 	sllw	x
      008A99 58               [ 2]  321 	sllw	x
      008A9A 58               [ 2]  322 	sllw	x
      008A9B 58               [ 2]  323 	sllw	x
      008A9C 58               [ 2]  324 	sllw	x
      008A9D 58               [ 2]  325 	sllw	x
      008A9E 6B 02            [ 1]  326 	ld	(0x02, sp), a
      008AA0 0F 01            [ 1]  327 	clr	(0x01, sp)
      008AA2 72 FB 01         [ 2]  328 	addw	x, (0x01, sp)
      008AA5 72 4F 00 01      [ 1]  329 	clr	((_oled_buffer+0), x)
                                    330 ;	lib/oled.c: 214: for(col = 0; col < OLED_WIDTH; col++) {
      008AA9 4C               [ 1]  331 	inc	a
      008AAA A1 80            [ 1]  332 	cp	a, #0x80
      008AAC 25 E4            [ 1]  333 	jrc	00105$
                                    334 ;	lib/oled.c: 219: oled_write_cmd(0xB0 | page);
      008AAE 90 9F            [ 1]  335 	ld	a, yl
      008AB0 AA B0            [ 1]  336 	or	a, #0xb0
      008AB2 CD 89 63         [ 4]  337 	call	_oled_write_cmd
                                    338 ;	lib/oled.c: 220: oled_write_cmd(0x00);
      008AB5 4F               [ 1]  339 	clr	a
      008AB6 CD 89 63         [ 4]  340 	call	_oled_write_cmd
                                    341 ;	lib/oled.c: 221: oled_write_cmd(0x10);
      008AB9 A6 10            [ 1]  342 	ld	a, #0x10
      008ABB CD 89 63         [ 4]  343 	call	_oled_write_cmd
                                    344 ;	lib/oled.c: 223: i2c_start();
      008ABE CD 88 96         [ 4]  345 	call	_i2c_start
                                    346 ;	lib/oled.c: 224: i2c_send_addr(OLED_ADDR);
      008AC1 A6 78            [ 1]  347 	ld	a, #0x78
      008AC3 CD 88 B3         [ 4]  348 	call	_i2c_send_addr
                                    349 ;	lib/oled.c: 225: i2c_write(0x40);
      008AC6 A6 40            [ 1]  350 	ld	a, #0x40
      008AC8 CD 88 AA         [ 4]  351 	call	_i2c_write
                                    352 ;	lib/oled.c: 226: for(col = 0; col < OLED_WIDTH; col++) {
      008ACB 4F               [ 1]  353 	clr	a
      008ACC                        354 00107$:
                                    355 ;	lib/oled.c: 227: i2c_write(0x00);
      008ACC 88               [ 1]  356 	push	a
      008ACD 4F               [ 1]  357 	clr	a
      008ACE CD 88 AA         [ 4]  358 	call	_i2c_write
      008AD1 84               [ 1]  359 	pop	a
                                    360 ;	lib/oled.c: 226: for(col = 0; col < OLED_WIDTH; col++) {
      008AD2 4C               [ 1]  361 	inc	a
      008AD3 A1 80            [ 1]  362 	cp	a, #0x80
      008AD5 25 F5            [ 1]  363 	jrc	00107$
                                    364 ;	lib/oled.c: 229: i2c_stop();
      008AD7 5B 02            [ 2]  365 	addw	sp, #2
      008AD9 CC 88 A0         [ 2]  366 	jp	_i2c_stop
      008ADC                        367 00109$:
                                    368 ;	lib/oled.c: 230: }
      008ADC 5B 02            [ 2]  369 	addw	sp, #2
      008ADE 81               [ 4]  370 	ret
                                    371 ;	lib/oled.c: 232: void oled_update(void)
                                    372 ;	-----------------------------------------
                                    373 ;	 function oled_update
                                    374 ;	-----------------------------------------
      008ADF                        375 _oled_update:
                                    376 ;	lib/oled.c: 234: oled_send_buffer();
                                    377 ;	lib/oled.c: 235: }
      008ADF CC 89 AB         [ 2]  378 	jp	_oled_send_buffer
                                    379 ;	lib/oled.c: 237: void oled_set_pixel(unsigned char x, unsigned char y, unsigned char color)
                                    380 ;	-----------------------------------------
                                    381 ;	 function oled_set_pixel
                                    382 ;	-----------------------------------------
      008AE2                        383 _oled_set_pixel:
      008AE2 52 04            [ 2]  384 	sub	sp, #4
                                    385 ;	lib/oled.c: 241: if(x >= OLED_WIDTH || y >= OLED_HEIGHT) return;
      008AE4 90 97            [ 1]  386 	ld	yl, a
      008AE6 A1 80            [ 1]  387 	cp	a, #0x80
      008AE8 24 4B            [ 1]  388 	jrnc	00107$
      008AEA 7B 07            [ 1]  389 	ld	a, (0x07, sp)
      008AEC A1 20            [ 1]  390 	cp	a, #0x20
      008AEE 24 45            [ 1]  391 	jrnc	00107$
                                    392 ;	lib/oled.c: 243: page = y / 8;
      008AF0 7B 07            [ 1]  393 	ld	a, (0x07, sp)
      008AF2 88               [ 1]  394 	push	a
      008AF3 5F               [ 1]  395 	clrw	x
      008AF4 97               [ 1]  396 	ld	xl, a
      008AF5 A6 08            [ 1]  397 	ld	a, #0x08
      008AF7 62               [ 2]  398 	div	x, a
      008AF8 84               [ 1]  399 	pop	a
                                    400 ;	lib/oled.c: 244: bit = y % 8;
      008AF9 A4 07            [ 1]  401 	and	a, #0x07
      008AFB 6B 04            [ 1]  402 	ld	(0x04, sp), a
                                    403 ;	lib/oled.c: 247: oled_buffer[page * OLED_WIDTH + x] |= (1 << bit);
      008AFD 4F               [ 1]  404 	clr	a
      008AFE 95               [ 1]  405 	ld	xh, a
      008AFF 4F               [ 1]  406 	clr	a
      008B00 90 95            [ 1]  407 	ld	yh, a
      008B02 A6 01            [ 1]  408 	ld	a, #0x01
      008B04 6B 03            [ 1]  409 	ld	(0x03, sp), a
      008B06 7B 04            [ 1]  410 	ld	a, (0x04, sp)
      008B08 27 05            [ 1]  411 	jreq	00126$
      008B0A                        412 00125$:
      008B0A 08 03            [ 1]  413 	sll	(0x03, sp)
      008B0C 4A               [ 1]  414 	dec	a
      008B0D 26 FB            [ 1]  415 	jrne	00125$
      008B0F                        416 00126$:
      008B0F 58               [ 2]  417 	sllw	x
      008B10 58               [ 2]  418 	sllw	x
      008B11 58               [ 2]  419 	sllw	x
      008B12 58               [ 2]  420 	sllw	x
      008B13 58               [ 2]  421 	sllw	x
      008B14 58               [ 2]  422 	sllw	x
      008B15 58               [ 2]  423 	sllw	x
      008B16 1F 01            [ 2]  424 	ldw	(0x01, sp), x
      008B18 93               [ 1]  425 	ldw	x, y
      008B19 72 FB 01         [ 2]  426 	addw	x, (0x01, sp)
                                    427 ;	lib/oled.c: 246: if(color) {
      008B1C 0D 08            [ 1]  428 	tnz	(0x08, sp)
      008B1E 27 09            [ 1]  429 	jreq	00105$
                                    430 ;	lib/oled.c: 247: oled_buffer[page * OLED_WIDTH + x] |= (1 << bit);
      008B20 1C 00 01         [ 2]  431 	addw	x, #(_oled_buffer+0)
      008B23 F6               [ 1]  432 	ld	a, (x)
      008B24 1A 03            [ 1]  433 	or	a, (0x03, sp)
      008B26 F7               [ 1]  434 	ld	(x), a
      008B27 20 0C            [ 2]  435 	jra	00107$
      008B29                        436 00105$:
                                    437 ;	lib/oled.c: 249: oled_buffer[page * OLED_WIDTH + x] &= ~(1 << bit);
      008B29 1C 00 01         [ 2]  438 	addw	x, #(_oled_buffer+0)
      008B2C F6               [ 1]  439 	ld	a, (x)
      008B2D 6B 04            [ 1]  440 	ld	(0x04, sp), a
      008B2F 7B 03            [ 1]  441 	ld	a, (0x03, sp)
      008B31 43               [ 1]  442 	cpl	a
      008B32 14 04            [ 1]  443 	and	a, (0x04, sp)
      008B34 F7               [ 1]  444 	ld	(x), a
      008B35                        445 00107$:
                                    446 ;	lib/oled.c: 251: }
      008B35 1E 05            [ 2]  447 	ldw	x, (5, sp)
      008B37 5B 08            [ 2]  448 	addw	sp, #8
      008B39 FC               [ 2]  449 	jp	(x)
                                    450 ;	lib/oled.c: 253: void oled_draw_line(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char color)
                                    451 ;	-----------------------------------------
                                    452 ;	 function oled_draw_line
                                    453 ;	-----------------------------------------
      008B3A                        454 _oled_draw_line:
      008B3A 52 0C            [ 2]  455 	sub	sp, #12
      008B3C 6B 0A            [ 1]  456 	ld	(0x0a, sp), a
                                    457 ;	lib/oled.c: 257: dx = (x2 > x1) ? (x2 - x1) : (x1 - x2);
      008B3E 7B 10            [ 1]  458 	ld	a, (0x10, sp)
      008B40 6B 07            [ 1]  459 	ld	(0x07, sp), a
      008B42 0F 06            [ 1]  460 	clr	(0x06, sp)
      008B44 7B 0A            [ 1]  461 	ld	a, (0x0a, sp)
      008B46 6B 09            [ 1]  462 	ld	(0x09, sp), a
      008B48 0F 08            [ 1]  463 	clr	(0x08, sp)
      008B4A 7B 10            [ 1]  464 	ld	a, (0x10, sp)
      008B4C 11 0A            [ 1]  465 	cp	a, (0x0a, sp)
      008B4E 23 09            [ 2]  466 	jrule	00113$
      008B50 1E 06            [ 2]  467 	ldw	x, (0x06, sp)
      008B52 72 F0 08         [ 2]  468 	subw	x, (0x08, sp)
      008B55 1F 0B            [ 2]  469 	ldw	(0x0b, sp), x
      008B57 20 07            [ 2]  470 	jra	00114$
      008B59                        471 00113$:
      008B59 1E 08            [ 2]  472 	ldw	x, (0x08, sp)
      008B5B 72 F0 06         [ 2]  473 	subw	x, (0x06, sp)
      008B5E 1F 0B            [ 2]  474 	ldw	(0x0b, sp), x
      008B60                        475 00114$:
      008B60 16 0B            [ 2]  476 	ldw	y, (0x0b, sp)
      008B62 17 01            [ 2]  477 	ldw	(0x01, sp), y
                                    478 ;	lib/oled.c: 258: dy = (y2 > y1) ? (y2 - y1) : (y1 - y2);
      008B64 7B 11            [ 1]  479 	ld	a, (0x11, sp)
      008B66 6B 07            [ 1]  480 	ld	(0x07, sp), a
      008B68 0F 06            [ 1]  481 	clr	(0x06, sp)
      008B6A 7B 0F            [ 1]  482 	ld	a, (0x0f, sp)
      008B6C 6B 09            [ 1]  483 	ld	(0x09, sp), a
      008B6E 0F 08            [ 1]  484 	clr	(0x08, sp)
      008B70 7B 11            [ 1]  485 	ld	a, (0x11, sp)
      008B72 11 0F            [ 1]  486 	cp	a, (0x0f, sp)
      008B74 23 09            [ 2]  487 	jrule	00115$
      008B76 1E 06            [ 2]  488 	ldw	x, (0x06, sp)
      008B78 72 F0 08         [ 2]  489 	subw	x, (0x08, sp)
      008B7B 1F 0B            [ 2]  490 	ldw	(0x0b, sp), x
      008B7D 20 07            [ 2]  491 	jra	00116$
      008B7F                        492 00115$:
      008B7F 1E 08            [ 2]  493 	ldw	x, (0x08, sp)
      008B81 72 F0 06         [ 2]  494 	subw	x, (0x06, sp)
      008B84 1F 0B            [ 2]  495 	ldw	(0x0b, sp), x
      008B86                        496 00116$:
      008B86 16 0B            [ 2]  497 	ldw	y, (0x0b, sp)
      008B88 17 03            [ 2]  498 	ldw	(0x03, sp), y
                                    499 ;	lib/oled.c: 259: sx = (x1 < x2) ? 1 : -1;
      008B8A 7B 0A            [ 1]  500 	ld	a, (0x0a, sp)
      008B8C 11 10            [ 1]  501 	cp	a, (0x10, sp)
      008B8E 24 03            [ 1]  502 	jrnc	00117$
      008B90 A6 01            [ 1]  503 	ld	a, #0x01
      008B92 C5                     504 	.byte 0xc5
      008B93                        505 00117$:
      008B93 A6 FF            [ 1]  506 	ld	a, #0xff
      008B95                        507 00118$:
      008B95 6B 05            [ 1]  508 	ld	(0x05, sp), a
                                    509 ;	lib/oled.c: 260: sy = (y1 < y2) ? 1 : -1;
      008B97 7B 0F            [ 1]  510 	ld	a, (0x0f, sp)
      008B99 11 11            [ 1]  511 	cp	a, (0x11, sp)
      008B9B 24 03            [ 1]  512 	jrnc	00119$
      008B9D A6 01            [ 1]  513 	ld	a, #0x01
      008B9F C5                     514 	.byte 0xc5
      008BA0                        515 00119$:
      008BA0 A6 FF            [ 1]  516 	ld	a, #0xff
      008BA2                        517 00120$:
      008BA2 6B 06            [ 1]  518 	ld	(0x06, sp), a
                                    519 ;	lib/oled.c: 261: err = dx - dy;
      008BA4 1E 01            [ 2]  520 	ldw	x, (0x01, sp)
      008BA6 72 F0 03         [ 2]  521 	subw	x, (0x03, sp)
      008BA9 1F 0B            [ 2]  522 	ldw	(0x0b, sp), x
                                    523 ;	lib/oled.c: 263: while(1) {
      008BAB 7B 04            [ 1]  524 	ld	a, (0x04, sp)
      008BAD 40               [ 1]  525 	neg	a
      008BAE 6B 08            [ 1]  526 	ld	(0x08, sp), a
      008BB0 4F               [ 1]  527 	clr	a
      008BB1 12 03            [ 1]  528 	sbc	a, (0x03, sp)
      008BB3 6B 07            [ 1]  529 	ld	(0x07, sp), a
      008BB5                        530 00109$:
                                    531 ;	lib/oled.c: 264: oled_set_pixel(x1, y1, color);
      008BB5 7B 12            [ 1]  532 	ld	a, (0x12, sp)
      008BB7 88               [ 1]  533 	push	a
      008BB8 7B 10            [ 1]  534 	ld	a, (0x10, sp)
      008BBA 88               [ 1]  535 	push	a
      008BBB 7B 0C            [ 1]  536 	ld	a, (0x0c, sp)
      008BBD CD 8A E2         [ 4]  537 	call	_oled_set_pixel
                                    538 ;	lib/oled.c: 265: if(x1 == x2 && y1 == y2) break;
      008BC0 7B 0A            [ 1]  539 	ld	a, (0x0a, sp)
      008BC2 11 10            [ 1]  540 	cp	a, (0x10, sp)
      008BC4 26 06            [ 1]  541 	jrne	00102$
      008BC6 7B 0F            [ 1]  542 	ld	a, (0x0f, sp)
      008BC8 11 11            [ 1]  543 	cp	a, (0x11, sp)
      008BCA 27 2F            [ 1]  544 	jreq	00111$
      008BCC                        545 00102$:
                                    546 ;	lib/oled.c: 266: e2 = 2 * err;
      008BCC 1E 0B            [ 2]  547 	ldw	x, (0x0b, sp)
      008BCE 58               [ 2]  548 	sllw	x
                                    549 ;	lib/oled.c: 267: if(e2 > -dy) { err -= dy; x1 += sx; }
      008BCF 13 07            [ 2]  550 	cpw	x, (0x07, sp)
      008BD1 2D 11            [ 1]  551 	jrsle	00105$
      008BD3 16 0B            [ 2]  552 	ldw	y, (0x0b, sp)
      008BD5 72 F2 03         [ 2]  553 	subw	y, (0x03, sp)
      008BD8 17 0B            [ 2]  554 	ldw	(0x0b, sp), y
      008BDA 7B 05            [ 1]  555 	ld	a, (0x05, sp)
      008BDC 6B 09            [ 1]  556 	ld	(0x09, sp), a
      008BDE 7B 0A            [ 1]  557 	ld	a, (0x0a, sp)
      008BE0 1B 09            [ 1]  558 	add	a, (0x09, sp)
      008BE2 6B 0A            [ 1]  559 	ld	(0x0a, sp), a
      008BE4                        560 00105$:
                                    561 ;	lib/oled.c: 268: if(e2 < dx) { err += dx; y1 += sy; }
      008BE4 13 01            [ 2]  562 	cpw	x, (0x01, sp)
      008BE6 2E CD            [ 1]  563 	jrsge	00109$
      008BE8 1E 0B            [ 2]  564 	ldw	x, (0x0b, sp)
      008BEA 72 FB 01         [ 2]  565 	addw	x, (0x01, sp)
      008BED 1F 0B            [ 2]  566 	ldw	(0x0b, sp), x
      008BEF 7B 06            [ 1]  567 	ld	a, (0x06, sp)
      008BF1 6B 09            [ 1]  568 	ld	(0x09, sp), a
      008BF3 7B 0F            [ 1]  569 	ld	a, (0x0f, sp)
      008BF5 1B 09            [ 1]  570 	add	a, (0x09, sp)
      008BF7 6B 0F            [ 1]  571 	ld	(0x0f, sp), a
      008BF9 20 BA            [ 2]  572 	jra	00109$
      008BFB                        573 00111$:
                                    574 ;	lib/oled.c: 270: }
      008BFB 1E 0D            [ 2]  575 	ldw	x, (13, sp)
      008BFD 5B 12            [ 2]  576 	addw	sp, #18
      008BFF FC               [ 2]  577 	jp	(x)
                                    578 ;	lib/oled.c: 272: void oled_draw_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color)
                                    579 ;	-----------------------------------------
                                    580 ;	 function oled_draw_rect
                                    581 ;	-----------------------------------------
      008C00                        582 _oled_draw_rect:
      008C00 88               [ 1]  583 	push	a
                                    584 ;	lib/oled.c: 274: oled_draw_line(x, y, x + w - 1, y, color);
      008C01 97               [ 1]  585 	ld	xl, a
      008C02 1B 05            [ 1]  586 	add	a, (0x05, sp)
      008C04 4A               [ 1]  587 	dec	a
      008C05 95               [ 1]  588 	ld	xh, a
      008C06 89               [ 2]  589 	pushw	x
      008C07 7B 09            [ 1]  590 	ld	a, (0x09, sp)
      008C09 88               [ 1]  591 	push	a
      008C0A 7B 07            [ 1]  592 	ld	a, (0x07, sp)
      008C0C 88               [ 1]  593 	push	a
      008C0D 9E               [ 1]  594 	ld	a, xh
      008C0E 88               [ 1]  595 	push	a
      008C0F 7B 09            [ 1]  596 	ld	a, (0x09, sp)
      008C11 88               [ 1]  597 	push	a
      008C12 9F               [ 1]  598 	ld	a, xl
      008C13 CD 8B 3A         [ 4]  599 	call	_oled_draw_line
      008C16 85               [ 2]  600 	popw	x
                                    601 ;	lib/oled.c: 275: oled_draw_line(x, y, x, y + h - 1, color);
      008C17 7B 04            [ 1]  602 	ld	a, (0x04, sp)
      008C19 1B 06            [ 1]  603 	add	a, (0x06, sp)
      008C1B 4A               [ 1]  604 	dec	a
      008C1C 6B 01            [ 1]  605 	ld	(0x01, sp), a
      008C1E 89               [ 2]  606 	pushw	x
      008C1F 7B 09            [ 1]  607 	ld	a, (0x09, sp)
      008C21 88               [ 1]  608 	push	a
      008C22 7B 04            [ 1]  609 	ld	a, (0x04, sp)
      008C24 88               [ 1]  610 	push	a
      008C25 9F               [ 1]  611 	ld	a, xl
      008C26 88               [ 1]  612 	push	a
      008C27 7B 09            [ 1]  613 	ld	a, (0x09, sp)
      008C29 88               [ 1]  614 	push	a
      008C2A 9F               [ 1]  615 	ld	a, xl
      008C2B CD 8B 3A         [ 4]  616 	call	_oled_draw_line
      008C2E 85               [ 2]  617 	popw	x
                                    618 ;	lib/oled.c: 276: oled_draw_line(x + w - 1, y, x + w - 1, y + h - 1, color);
      008C2F 89               [ 2]  619 	pushw	x
      008C30 7B 09            [ 1]  620 	ld	a, (0x09, sp)
      008C32 88               [ 1]  621 	push	a
      008C33 7B 04            [ 1]  622 	ld	a, (0x04, sp)
      008C35 88               [ 1]  623 	push	a
      008C36 9E               [ 1]  624 	ld	a, xh
      008C37 88               [ 1]  625 	push	a
      008C38 7B 09            [ 1]  626 	ld	a, (0x09, sp)
      008C3A 88               [ 1]  627 	push	a
      008C3B 9E               [ 1]  628 	ld	a, xh
      008C3C CD 8B 3A         [ 4]  629 	call	_oled_draw_line
      008C3F 85               [ 2]  630 	popw	x
                                    631 ;	lib/oled.c: 277: oled_draw_line(x, y + h - 1, x + w - 1, y + h - 1, color);
      008C40 7B 07            [ 1]  632 	ld	a, (0x07, sp)
      008C42 88               [ 1]  633 	push	a
      008C43 7B 02            [ 1]  634 	ld	a, (0x02, sp)
      008C45 88               [ 1]  635 	push	a
      008C46 9E               [ 1]  636 	ld	a, xh
      008C47 88               [ 1]  637 	push	a
      008C48 7B 04            [ 1]  638 	ld	a, (0x04, sp)
      008C4A 88               [ 1]  639 	push	a
      008C4B 9F               [ 1]  640 	ld	a, xl
      008C4C CD 8B 3A         [ 4]  641 	call	_oled_draw_line
                                    642 ;	lib/oled.c: 278: }
      008C4F 1E 02            [ 2]  643 	ldw	x, (2, sp)
      008C51 5B 07            [ 2]  644 	addw	sp, #7
      008C53 FC               [ 2]  645 	jp	(x)
                                    646 ;	lib/oled.c: 280: void oled_fill_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color)
                                    647 ;	-----------------------------------------
                                    648 ;	 function oled_fill_rect
                                    649 ;	-----------------------------------------
      008C54                        650 _oled_fill_rect:
      008C54 52 09            [ 2]  651 	sub	sp, #9
                                    652 ;	lib/oled.c: 283: for(i = x; i < x + w; i++) {
      008C56 6B 07            [ 1]  653 	ld	(0x07, sp), a
      008C58 6B 08            [ 1]  654 	ld	(0x08, sp), a
      008C5A                        655 00107$:
      008C5A 7B 07            [ 1]  656 	ld	a, (0x07, sp)
      008C5C 6B 02            [ 1]  657 	ld	(0x02, sp), a
      008C5E 0F 01            [ 1]  658 	clr	(0x01, sp)
      008C60 7B 0D            [ 1]  659 	ld	a, (0x0d, sp)
      008C62 6B 04            [ 1]  660 	ld	(0x04, sp), a
      008C64 0F 03            [ 1]  661 	clr	(0x03, sp)
      008C66 1E 01            [ 2]  662 	ldw	x, (0x01, sp)
      008C68 72 FB 03         [ 2]  663 	addw	x, (0x03, sp)
      008C6B 1F 05            [ 2]  664 	ldw	(0x05, sp), x
      008C6D 7B 08            [ 1]  665 	ld	a, (0x08, sp)
      008C6F 6B 04            [ 1]  666 	ld	(0x04, sp), a
      008C71 0F 03            [ 1]  667 	clr	(0x03, sp)
      008C73 1E 03            [ 2]  668 	ldw	x, (0x03, sp)
      008C75 13 05            [ 2]  669 	cpw	x, (0x05, sp)
      008C77 2E 2E            [ 1]  670 	jrsge	00109$
                                    671 ;	lib/oled.c: 284: for(j = y; j < y + h; j++) {
      008C79 7B 0C            [ 1]  672 	ld	a, (0x0c, sp)
      008C7B 6B 09            [ 1]  673 	ld	(0x09, sp), a
      008C7D                        674 00104$:
      008C7D 5F               [ 1]  675 	clrw	x
      008C7E 7B 0C            [ 1]  676 	ld	a, (0x0c, sp)
      008C80 97               [ 1]  677 	ld	xl, a
      008C81 7B 0E            [ 1]  678 	ld	a, (0x0e, sp)
      008C83 6B 04            [ 1]  679 	ld	(0x04, sp), a
      008C85 0F 03            [ 1]  680 	clr	(0x03, sp)
      008C87 72 FB 03         [ 2]  681 	addw	x, (0x03, sp)
      008C8A 1F 05            [ 2]  682 	ldw	(0x05, sp), x
      008C8C 7B 09            [ 1]  683 	ld	a, (0x09, sp)
      008C8E 5F               [ 1]  684 	clrw	x
      008C8F 97               [ 1]  685 	ld	xl, a
      008C90 13 05            [ 2]  686 	cpw	x, (0x05, sp)
      008C92 2E 0F            [ 1]  687 	jrsge	00108$
                                    688 ;	lib/oled.c: 285: oled_set_pixel(i, j, color);
      008C94 7B 0F            [ 1]  689 	ld	a, (0x0f, sp)
      008C96 88               [ 1]  690 	push	a
      008C97 7B 0A            [ 1]  691 	ld	a, (0x0a, sp)
      008C99 88               [ 1]  692 	push	a
      008C9A 7B 0A            [ 1]  693 	ld	a, (0x0a, sp)
      008C9C CD 8A E2         [ 4]  694 	call	_oled_set_pixel
                                    695 ;	lib/oled.c: 284: for(j = y; j < y + h; j++) {
      008C9F 0C 09            [ 1]  696 	inc	(0x09, sp)
      008CA1 20 DA            [ 2]  697 	jra	00104$
      008CA3                        698 00108$:
                                    699 ;	lib/oled.c: 283: for(i = x; i < x + w; i++) {
      008CA3 0C 08            [ 1]  700 	inc	(0x08, sp)
      008CA5 20 B3            [ 2]  701 	jra	00107$
      008CA7                        702 00109$:
                                    703 ;	lib/oled.c: 288: }
      008CA7 1E 0A            [ 2]  704 	ldw	x, (10, sp)
      008CA9 5B 0F            [ 2]  705 	addw	sp, #15
      008CAB FC               [ 2]  706 	jp	(x)
                                    707 ;	lib/oled.c: 290: void oled_gotoxy(unsigned char x, unsigned char y)
                                    708 ;	-----------------------------------------
                                    709 ;	 function oled_gotoxy
                                    710 ;	-----------------------------------------
      008CAC                        711 _oled_gotoxy:
                                    712 ;	lib/oled.c: 292: if(x < OLED_WIDTH && y < OLED_HEIGHT) {
      008CAC A1 80            [ 1]  713 	cp	a, #0x80
      008CAE 24 10            [ 1]  714 	jrnc	00104$
      008CB0 88               [ 1]  715 	push	a
      008CB1 7B 04            [ 1]  716 	ld	a, (0x04, sp)
      008CB3 A1 20            [ 1]  717 	cp	a, #0x20
      008CB5 84               [ 1]  718 	pop	a
      008CB6 24 08            [ 1]  719 	jrnc	00104$
                                    720 ;	lib/oled.c: 293: oled_cursor_x = x;
      008CB8 C7 02 01         [ 1]  721 	ld	_oled_cursor_x+0, a
                                    722 ;	lib/oled.c: 294: oled_cursor_y = y;
      008CBB 7B 03            [ 1]  723 	ld	a, (0x03, sp)
      008CBD C7 02 02         [ 1]  724 	ld	_oled_cursor_y+0, a
      008CC0                        725 00104$:
                                    726 ;	lib/oled.c: 296: }
      008CC0 85               [ 2]  727 	popw	x
      008CC1 84               [ 1]  728 	pop	a
      008CC2 FC               [ 2]  729 	jp	(x)
                                    730 ;	lib/oled.c: 298: void oled_putc(char c)
                                    731 ;	-----------------------------------------
                                    732 ;	 function oled_putc
                                    733 ;	-----------------------------------------
      008CC3                        734 _oled_putc:
      008CC3 52 07            [ 2]  735 	sub	sp, #7
                                    736 ;	lib/oled.c: 300: if(c == '\n') {
      008CC5 A1 0A            [ 1]  737 	cp	a, #0x0a
      008CC7 26 0E            [ 1]  738 	jrne	00102$
                                    739 ;	lib/oled.c: 301: oled_cursor_x = 0;
      008CC9 72 5F 02 01      [ 1]  740 	clr	_oled_cursor_x+0
                                    741 ;	lib/oled.c: 302: oled_cursor_y += 8;
      008CCD C6 02 02         [ 1]  742 	ld	a, _oled_cursor_y+0
      008CD0 AB 08            [ 1]  743 	add	a, #0x08
      008CD2 C7 02 02         [ 1]  744 	ld	_oled_cursor_y+0, a
                                    745 ;	lib/oled.c: 303: return;
      008CD5 20 75            [ 2]  746 	jra	00116$
      008CD7                        747 00102$:
                                    748 ;	lib/oled.c: 306: if(c >= 32 && c <= 127) {
      008CD7 A1 20            [ 1]  749 	cp	a, #0x20
      008CD9 25 71            [ 1]  750 	jrc	00116$
      008CDB A1 7F            [ 1]  751 	cp	a, #0x7f
      008CDD 22 6D            [ 1]  752 	jrugt	00116$
                                    753 ;	lib/oled.c: 308: unsigned char idx = c - 32;
      008CDF A0 20            [ 1]  754 	sub	a, #0x20
      008CE1 97               [ 1]  755 	ld	xl, a
                                    756 ;	lib/oled.c: 310: for(i = 0; i < 6; i++) {
      008CE2 A6 06            [ 1]  757 	ld	a, #0x06
      008CE4 42               [ 4]  758 	mul	x, a
      008CE5 1C 80 9E         [ 2]  759 	addw	x, #(_font_6x8+0)
      008CE8 1F 01            [ 2]  760 	ldw	(0x01, sp), x
      008CEA 0F 06            [ 1]  761 	clr	(0x06, sp)
      008CEC                        762 00114$:
                                    763 ;	lib/oled.c: 311: unsigned char data = font_6x8[idx][i];
      008CEC 5F               [ 1]  764 	clrw	x
      008CED 7B 06            [ 1]  765 	ld	a, (0x06, sp)
      008CEF 97               [ 1]  766 	ld	xl, a
      008CF0 72 FB 01         [ 2]  767 	addw	x, (0x01, sp)
      008CF3 F6               [ 1]  768 	ld	a, (x)
      008CF4 6B 03            [ 1]  769 	ld	(0x03, sp), a
                                    770 ;	lib/oled.c: 313: for(j = 0; j < 8; j++) {
      008CF6 0F 07            [ 1]  771 	clr	(0x07, sp)
      008CF8                        772 00112$:
                                    773 ;	lib/oled.c: 314: if(data & (1 << j)) {
      008CF8 5F               [ 1]  774 	clrw	x
      008CF9 5C               [ 1]  775 	incw	x
      008CFA 7B 07            [ 1]  776 	ld	a, (0x07, sp)
      008CFC 27 04            [ 1]  777 	jreq	00189$
      008CFE                        778 00188$:
      008CFE 58               [ 2]  779 	sllw	x
      008CFF 4A               [ 1]  780 	dec	a
      008D00 26 FC            [ 1]  781 	jrne	00188$
      008D02                        782 00189$:
      008D02 7B 03            [ 1]  783 	ld	a, (0x03, sp)
      008D04 6B 05            [ 1]  784 	ld	(0x05, sp), a
      008D06 0F 04            [ 1]  785 	clr	(0x04, sp)
      008D08 9F               [ 1]  786 	ld	a, xl
      008D09 14 05            [ 1]  787 	and	a, (0x05, sp)
      008D0B 97               [ 1]  788 	ld	xl, a
      008D0C 4F               [ 1]  789 	clr	a
      008D0D 95               [ 1]  790 	ld	xh, a
      008D0E 5D               [ 2]  791 	tnzw	x
      008D0F 27 13            [ 1]  792 	jreq	00113$
                                    793 ;	lib/oled.c: 315: oled_set_pixel(oled_cursor_x + i, oled_cursor_y + j, 1);
      008D11 C6 02 02         [ 1]  794 	ld	a, _oled_cursor_y+0
      008D14 1B 07            [ 1]  795 	add	a, (0x07, sp)
      008D16 97               [ 1]  796 	ld	xl, a
      008D17 C6 02 01         [ 1]  797 	ld	a, _oled_cursor_x+0
      008D1A 1B 06            [ 1]  798 	add	a, (0x06, sp)
      008D1C 4B 01            [ 1]  799 	push	#0x01
      008D1E 89               [ 2]  800 	pushw	x
      008D1F 5B 01            [ 2]  801 	addw	sp, #1
      008D21 CD 8A E2         [ 4]  802 	call	_oled_set_pixel
      008D24                        803 00113$:
                                    804 ;	lib/oled.c: 313: for(j = 0; j < 8; j++) {
      008D24 0C 07            [ 1]  805 	inc	(0x07, sp)
      008D26 7B 07            [ 1]  806 	ld	a, (0x07, sp)
      008D28 A1 08            [ 1]  807 	cp	a, #0x08
      008D2A 25 CC            [ 1]  808 	jrc	00112$
                                    809 ;	lib/oled.c: 310: for(i = 0; i < 6; i++) {
      008D2C 0C 06            [ 1]  810 	inc	(0x06, sp)
      008D2E 7B 06            [ 1]  811 	ld	a, (0x06, sp)
      008D30 A1 06            [ 1]  812 	cp	a, #0x06
      008D32 25 B8            [ 1]  813 	jrc	00114$
                                    814 ;	lib/oled.c: 319: oled_cursor_x += 6;
      008D34 C6 02 01         [ 1]  815 	ld	a, _oled_cursor_x+0
      008D37 AB 06            [ 1]  816 	add	a, #0x06
                                    817 ;	lib/oled.c: 321: if(oled_cursor_x > OLED_WIDTH - 6) {
      008D39 C7 02 01         [ 1]  818 	ld	_oled_cursor_x+0, a
      008D3C A1 7A            [ 1]  819 	cp	a, #0x7a
      008D3E 23 0C            [ 2]  820 	jrule	00116$
                                    821 ;	lib/oled.c: 322: oled_cursor_x = 0;
      008D40 72 5F 02 01      [ 1]  822 	clr	_oled_cursor_x+0
                                    823 ;	lib/oled.c: 323: oled_cursor_y += 8;
      008D44 C6 02 02         [ 1]  824 	ld	a, _oled_cursor_y+0
      008D47 AB 08            [ 1]  825 	add	a, #0x08
      008D49 C7 02 02         [ 1]  826 	ld	_oled_cursor_y+0, a
      008D4C                        827 00116$:
                                    828 ;	lib/oled.c: 326: }
      008D4C 5B 07            [ 2]  829 	addw	sp, #7
      008D4E 81               [ 4]  830 	ret
                                    831 ;	lib/oled.c: 328: void oled_puts(const char* str)
                                    832 ;	-----------------------------------------
                                    833 ;	 function oled_puts
                                    834 ;	-----------------------------------------
      008D4F                        835 _oled_puts:
                                    836 ;	lib/oled.c: 330: while(*str) {
      008D4F                        837 00101$:
      008D4F F6               [ 1]  838 	ld	a, (x)
      008D50 26 03            [ 1]  839 	jrne	00121$
      008D52 CC 8A DF         [ 2]  840 	jp	_oled_update
      008D55                        841 00121$:
                                    842 ;	lib/oled.c: 331: oled_putc(*str++);
      008D55 5C               [ 1]  843 	incw	x
      008D56 89               [ 2]  844 	pushw	x
      008D57 CD 8C C3         [ 4]  845 	call	_oled_putc
      008D5A 85               [ 2]  846 	popw	x
                                    847 ;	lib/oled.c: 333: oled_update();
                                    848 ;	lib/oled.c: 334: }
      008D5B 20 F2            [ 2]  849 	jra	00101$
                                    850 ;	lib/oled.c: 336: void oled_puts_at(unsigned char x, unsigned char y, const char* str)
                                    851 ;	-----------------------------------------
                                    852 ;	 function oled_puts_at
                                    853 ;	-----------------------------------------
      008D5D                        854 _oled_puts_at:
      008D5D 97               [ 1]  855 	ld	xl, a
                                    856 ;	lib/oled.c: 338: oled_gotoxy(x, y);
      008D5E 7B 03            [ 1]  857 	ld	a, (0x03, sp)
      008D60 88               [ 1]  858 	push	a
      008D61 9F               [ 1]  859 	ld	a, xl
      008D62 CD 8C AC         [ 4]  860 	call	_oled_gotoxy
                                    861 ;	lib/oled.c: 339: oled_puts(str);
      008D65 1E 04            [ 2]  862 	ldw	x, (0x04, sp)
      008D67 16 01            [ 2]  863 	ldw	y, (1, sp)
      008D69 17 04            [ 2]  864 	ldw	(4, sp), y
      008D6B 5B 03            [ 2]  865 	addw	sp, #3
                                    866 ;	lib/oled.c: 340: }
      008D6D CC 8D 4F         [ 2]  867 	jp	_oled_puts
                                    868 ;	lib/oled.c: 342: void oled_set_font(unsigned char font_size)
                                    869 ;	-----------------------------------------
                                    870 ;	 function oled_set_font
                                    871 ;	-----------------------------------------
      008D70                        872 _oled_set_font:
      008D70 C7 02 03         [ 1]  873 	ld	_oled_current_font+0, a
                                    874 ;	lib/oled.c: 344: oled_current_font = font_size;
                                    875 ;	lib/oled.c: 345: }
      008D73 81               [ 4]  876 	ret
                                    877 ;	lib/oled.c: 347: void oled_set_contrast(unsigned char contrast)
                                    878 ;	-----------------------------------------
                                    879 ;	 function oled_set_contrast
                                    880 ;	-----------------------------------------
      008D74                        881 _oled_set_contrast:
                                    882 ;	lib/oled.c: 349: oled_write_cmd(0x81);
      008D74 88               [ 1]  883 	push	a
      008D75 A6 81            [ 1]  884 	ld	a, #0x81
      008D77 CD 89 63         [ 4]  885 	call	_oled_write_cmd
      008D7A 84               [ 1]  886 	pop	a
                                    887 ;	lib/oled.c: 350: oled_write_cmd(contrast);
                                    888 ;	lib/oled.c: 351: }
      008D7B CC 89 63         [ 2]  889 	jp	_oled_write_cmd
                                    890 ;	lib/oled.c: 353: void oled_invert(void)
                                    891 ;	-----------------------------------------
                                    892 ;	 function oled_invert
                                    893 ;	-----------------------------------------
      008D7E                        894 _oled_invert:
                                    895 ;	lib/oled.c: 355: oled_write_cmd(0xA7);  // Invert display
      008D7E A6 A7            [ 1]  896 	ld	a, #0xa7
                                    897 ;	lib/oled.c: 356: }
      008D80 CC 89 63         [ 2]  898 	jp	_oled_write_cmd
                                    899 ;	lib/oled.c: 358: void oled_normal(void)
                                    900 ;	-----------------------------------------
                                    901 ;	 function oled_normal
                                    902 ;	-----------------------------------------
      008D83                        903 _oled_normal:
                                    904 ;	lib/oled.c: 360: oled_write_cmd(0xA6);  // Normal display
      008D83 A6 A6            [ 1]  905 	ld	a, #0xa6
                                    906 ;	lib/oled.c: 361: }
      008D85 CC 89 63         [ 2]  907 	jp	_oled_write_cmd
                                    908 ;	lib/oled.c: 363: void oled_scroll_left(unsigned char pages, unsigned char speed)
                                    909 ;	-----------------------------------------
                                    910 ;	 function oled_scroll_left
                                    911 ;	-----------------------------------------
      008D88                        912 _oled_scroll_left:
      008D88 52 07            [ 2]  913 	sub	sp, #7
                                    914 ;	lib/oled.c: 365: if(pages > 7) pages = 7;
      008D8A 97               [ 1]  915 	ld	xl, a
      008D8B A1 07            [ 1]  916 	cp	a, #0x07
      008D8D 23 03            [ 2]  917 	jrule	00102$
      008D8F A6 07            [ 1]  918 	ld	a, #0x07
      008D91 97               [ 1]  919 	ld	xl, a
      008D92                        920 00102$:
                                    921 ;	lib/oled.c: 366: if(speed > 7) speed = 7;
      008D92 7B 0A            [ 1]  922 	ld	a, (0x0a, sp)
      008D94 A1 07            [ 1]  923 	cp	a, #0x07
      008D96 23 04            [ 2]  924 	jrule	00104$
      008D98 A6 07            [ 1]  925 	ld	a, #0x07
      008D9A 6B 0A            [ 1]  926 	ld	(0x0a, sp), a
      008D9C                        927 00104$:
                                    928 ;	lib/oled.c: 368: unsigned char cmd[] = {
      008D9C A6 26            [ 1]  929 	ld	a, #0x26
      008D9E 6B 01            [ 1]  930 	ld	(0x01, sp), a
      008DA0 0F 02            [ 1]  931 	clr	(0x02, sp)
      008DA2 0F 03            [ 1]  932 	clr	(0x03, sp)
      008DA4 7B 0A            [ 1]  933 	ld	a, (0x0a, sp)
      008DA6 6B 04            [ 1]  934 	ld	(0x04, sp), a
      008DA8 9F               [ 1]  935 	ld	a, xl
      008DA9 4A               [ 1]  936 	dec	a
      008DAA 6B 05            [ 1]  937 	ld	(0x05, sp), a
      008DAC 0F 06            [ 1]  938 	clr	(0x06, sp)
      008DAE A6 FF            [ 1]  939 	ld	a, #0xff
      008DB0 6B 07            [ 1]  940 	ld	(0x07, sp), a
                                    941 ;	lib/oled.c: 377: oled_write_cmd_multi(cmd, 7);
      008DB2 A6 07            [ 1]  942 	ld	a, #0x07
      008DB4 96               [ 1]  943 	ldw	x, sp
      008DB5 5C               [ 1]  944 	incw	x
      008DB6 CD 89 7D         [ 4]  945 	call	_oled_write_cmd_multi
                                    946 ;	lib/oled.c: 378: oled_write_cmd(0x2F);   // Activate scroll
      008DB9 A6 2F            [ 1]  947 	ld	a, #0x2f
      008DBB CD 89 63         [ 4]  948 	call	_oled_write_cmd
                                    949 ;	lib/oled.c: 379: }
      008DBE 5B 07            [ 2]  950 	addw	sp, #7
      008DC0 85               [ 2]  951 	popw	x
      008DC1 84               [ 1]  952 	pop	a
      008DC2 FC               [ 2]  953 	jp	(x)
                                    954 ;	lib/oled.c: 381: void oled_scroll_right(unsigned char pages, unsigned char speed)
                                    955 ;	-----------------------------------------
                                    956 ;	 function oled_scroll_right
                                    957 ;	-----------------------------------------
      008DC3                        958 _oled_scroll_right:
      008DC3 52 07            [ 2]  959 	sub	sp, #7
                                    960 ;	lib/oled.c: 383: if(pages > 7) pages = 7;
      008DC5 97               [ 1]  961 	ld	xl, a
      008DC6 A1 07            [ 1]  962 	cp	a, #0x07
      008DC8 23 03            [ 2]  963 	jrule	00102$
      008DCA A6 07            [ 1]  964 	ld	a, #0x07
      008DCC 97               [ 1]  965 	ld	xl, a
      008DCD                        966 00102$:
                                    967 ;	lib/oled.c: 384: if(speed > 7) speed = 7;
      008DCD 7B 0A            [ 1]  968 	ld	a, (0x0a, sp)
      008DCF A1 07            [ 1]  969 	cp	a, #0x07
      008DD1 23 04            [ 2]  970 	jrule	00104$
      008DD3 A6 07            [ 1]  971 	ld	a, #0x07
      008DD5 6B 0A            [ 1]  972 	ld	(0x0a, sp), a
      008DD7                        973 00104$:
                                    974 ;	lib/oled.c: 386: unsigned char cmd[] = {
      008DD7 A6 27            [ 1]  975 	ld	a, #0x27
      008DD9 6B 01            [ 1]  976 	ld	(0x01, sp), a
      008DDB 0F 02            [ 1]  977 	clr	(0x02, sp)
      008DDD 0F 03            [ 1]  978 	clr	(0x03, sp)
      008DDF 7B 0A            [ 1]  979 	ld	a, (0x0a, sp)
      008DE1 6B 04            [ 1]  980 	ld	(0x04, sp), a
      008DE3 9F               [ 1]  981 	ld	a, xl
      008DE4 4A               [ 1]  982 	dec	a
      008DE5 6B 05            [ 1]  983 	ld	(0x05, sp), a
      008DE7 0F 06            [ 1]  984 	clr	(0x06, sp)
      008DE9 A6 FF            [ 1]  985 	ld	a, #0xff
      008DEB 6B 07            [ 1]  986 	ld	(0x07, sp), a
                                    987 ;	lib/oled.c: 395: oled_write_cmd_multi(cmd, 7);
      008DED A6 07            [ 1]  988 	ld	a, #0x07
      008DEF 96               [ 1]  989 	ldw	x, sp
      008DF0 5C               [ 1]  990 	incw	x
      008DF1 CD 89 7D         [ 4]  991 	call	_oled_write_cmd_multi
                                    992 ;	lib/oled.c: 396: oled_write_cmd(0x2F);   // Activate scroll
      008DF4 A6 2F            [ 1]  993 	ld	a, #0x2f
      008DF6 CD 89 63         [ 4]  994 	call	_oled_write_cmd
                                    995 ;	lib/oled.c: 397: }
      008DF9 5B 07            [ 2]  996 	addw	sp, #7
      008DFB 85               [ 2]  997 	popw	x
      008DFC 84               [ 1]  998 	pop	a
      008DFD FC               [ 2]  999 	jp	(x)
                                   1000 ;	lib/oled.c: 399: void oled_scroll_stop(void)
                                   1001 ;	-----------------------------------------
                                   1002 ;	 function oled_scroll_stop
                                   1003 ;	-----------------------------------------
      008DFE                       1004 _oled_scroll_stop:
                                   1005 ;	lib/oled.c: 401: oled_write_cmd(0x2E);   // Deactivate scroll
      008DFE A6 2E            [ 1] 1006 	ld	a, #0x2e
                                   1007 ;	lib/oled.c: 402: }
      008E00 CC 89 63         [ 2] 1008 	jp	_oled_write_cmd
                                   1009 ;	lib/oled.c: 404: void oled_print_number(unsigned int num)
                                   1010 ;	-----------------------------------------
                                   1011 ;	 function oled_print_number
                                   1012 ;	-----------------------------------------
      008E03                       1013 _oled_print_number:
      008E03 52 09            [ 2] 1014 	sub	sp, #9
                                   1015 ;	lib/oled.c: 409: if(num == 0) {
      008E05 1F 07            [ 2] 1016 	ldw	(0x07, sp), x
      008E07 26 07            [ 1] 1017 	jrne	00113$
                                   1018 ;	lib/oled.c: 410: oled_putc('0');
      008E09 A6 30            [ 1] 1019 	ld	a, #0x30
      008E0B CD 8C C3         [ 4] 1020 	call	_oled_putc
                                   1021 ;	lib/oled.c: 411: return;
      008E0E 20 49            [ 2] 1022 	jra	00109$
                                   1023 ;	lib/oled.c: 414: while(num > 0) {
      008E10                       1024 00113$:
      008E10 4F               [ 1] 1025 	clr	a
      008E11                       1026 00103$:
      008E11 1E 07            [ 2] 1027 	ldw	x, (0x07, sp)
      008E13 27 28            [ 1] 1028 	jreq	00115$
                                   1029 ;	lib/oled.c: 415: buffer[i++] = (num % 10) + '0';
      008E15 96               [ 1] 1030 	ldw	x, sp
      008E16 5C               [ 1] 1031 	incw	x
      008E17 89               [ 2] 1032 	pushw	x
      008E18 5F               [ 1] 1033 	clrw	x
      008E19 97               [ 1] 1034 	ld	xl, a
      008E1A 72 FB 01         [ 2] 1035 	addw	x, (1, sp)
      008E1D 5B 02            [ 2] 1036 	addw	sp, #2
      008E1F 4C               [ 1] 1037 	inc	a
      008E20 89               [ 2] 1038 	pushw	x
      008E21 1E 09            [ 2] 1039 	ldw	x, (0x09, sp)
      008E23 90 AE 00 0A      [ 2] 1040 	ldw	y, #0x000a
      008E27 65               [ 2] 1041 	divw	x, y
      008E28 85               [ 2] 1042 	popw	x
      008E29 72 A9 00 30      [ 2] 1043 	addw	y, #48
      008E2D 88               [ 1] 1044 	push	a
      008E2E 90 9F            [ 1] 1045 	ld	a, yl
      008E30 F7               [ 1] 1046 	ld	(x), a
      008E31 84               [ 1] 1047 	pop	a
                                   1048 ;	lib/oled.c: 416: num /= 10;
      008E32 1E 07            [ 2] 1049 	ldw	x, (0x07, sp)
      008E34 90 AE 00 0A      [ 2] 1050 	ldw	y, #0x000a
      008E38 65               [ 2] 1051 	divw	x, y
      008E39 1F 07            [ 2] 1052 	ldw	(0x07, sp), x
      008E3B 20 D4            [ 2] 1053 	jra	00103$
                                   1054 ;	lib/oled.c: 419: while(i > 0) {
      008E3D                       1055 00115$:
      008E3D 6B 09            [ 1] 1056 	ld	(0x09, sp), a
      008E3F                       1057 00106$:
      008E3F 0D 09            [ 1] 1058 	tnz	(0x09, sp)
      008E41 27 16            [ 1] 1059 	jreq	00109$
                                   1060 ;	lib/oled.c: 420: oled_putc(buffer[--i]);
      008E43 0A 09            [ 1] 1061 	dec	(0x09, sp)
      008E45 5F               [ 1] 1062 	clrw	x
      008E46 7B 09            [ 1] 1063 	ld	a, (0x09, sp)
      008E48 97               [ 1] 1064 	ld	xl, a
      008E49 89               [ 2] 1065 	pushw	x
      008E4A 96               [ 1] 1066 	ldw	x, sp
      008E4B 1C 00 03         [ 2] 1067 	addw	x, #3
      008E4E 72 FB 01         [ 2] 1068 	addw	x, (1, sp)
      008E51 5B 02            [ 2] 1069 	addw	sp, #2
      008E53 F6               [ 1] 1070 	ld	a, (x)
      008E54 CD 8C C3         [ 4] 1071 	call	_oled_putc
      008E57 20 E6            [ 2] 1072 	jra	00106$
      008E59                       1073 00109$:
                                   1074 ;	lib/oled.c: 422: }
      008E59 5B 09            [ 2] 1075 	addw	sp, #9
      008E5B 81               [ 4] 1076 	ret
                                   1077 ;	lib/oled.c: 424: void oled_print_hex(unsigned char num)
                                   1078 ;	-----------------------------------------
                                   1079 ;	 function oled_print_hex
                                   1080 ;	-----------------------------------------
      008E5C                       1081 _oled_print_hex:
      008E5C 88               [ 1] 1082 	push	a
                                   1083 ;	lib/oled.c: 426: unsigned char high = (num >> 4) & 0x0F;
      008E5D 97               [ 1] 1084 	ld	xl, a
      008E5E 4E               [ 1] 1085 	swap	a
      008E5F A4 0F            [ 1] 1086 	and	a, #15
                                   1087 ;	lib/oled.c: 427: unsigned char low = num & 0x0F;
      008E61 88               [ 1] 1088 	push	a
      008E62 9F               [ 1] 1089 	ld	a, xl
      008E63 A4 0F            [ 1] 1090 	and	a, #0x0f
      008E65 6B 02            [ 1] 1091 	ld	(0x02, sp), a
      008E67 84               [ 1] 1092 	pop	a
                                   1093 ;	lib/oled.c: 429: oled_putc(high < 10 ? high + '0' : high - 10 + 'A');
      008E68 97               [ 1] 1094 	ld	xl, a
      008E69 A1 0A            [ 1] 1095 	cp	a, #0x0a
      008E6B 24 05            [ 1] 1096 	jrnc	00103$
      008E6D 9F               [ 1] 1097 	ld	a, xl
      008E6E AB 30            [ 1] 1098 	add	a, #0x30
      008E70 20 03            [ 2] 1099 	jra	00104$
      008E72                       1100 00103$:
      008E72 9F               [ 1] 1101 	ld	a, xl
      008E73 AB 37            [ 1] 1102 	add	a, #0x37
      008E75                       1103 00104$:
      008E75 CD 8C C3         [ 4] 1104 	call	_oled_putc
                                   1105 ;	lib/oled.c: 430: oled_putc(low < 10 ? low + '0' : low - 10 + 'A');
      008E78 7B 01            [ 1] 1106 	ld	a, (0x01, sp)
      008E7A 88               [ 1] 1107 	push	a
      008E7B 7B 02            [ 1] 1108 	ld	a, (0x02, sp)
      008E7D A1 0A            [ 1] 1109 	cp	a, #0x0a
      008E7F 84               [ 1] 1110 	pop	a
      008E80 24 04            [ 1] 1111 	jrnc	00105$
      008E82 AB 30            [ 1] 1112 	add	a, #0x30
      008E84 20 02            [ 2] 1113 	jra	00106$
      008E86                       1114 00105$:
      008E86 AB 37            [ 1] 1115 	add	a, #0x37
      008E88                       1116 00106$:
      008E88 5B 01            [ 2] 1117 	addw	sp, #1
      008E8A CC 8C C3         [ 2] 1118 	jp	_oled_putc
                                   1119 ;	lib/oled.c: 431: }
      008E8D 84               [ 1] 1120 	pop	a
      008E8E 81               [ 4] 1121 	ret
                                   1122 	.area CODE
                                   1123 	.area CONST
                                   1124 	.area CONST
      00809E                       1125 _font_6x8:
      00809E 00                    1126 	.db #0x00	; 0
      00809F 00                    1127 	.db #0x00	; 0
      0080A0 00                    1128 	.db #0x00	; 0
      0080A1 00                    1129 	.db #0x00	; 0
      0080A2 00                    1130 	.db #0x00	; 0
      0080A3 00                    1131 	.db #0x00	; 0
      0080A4 00                    1132 	.db #0x00	; 0
      0080A5 00                    1133 	.db #0x00	; 0
      0080A6 00                    1134 	.db #0x00	; 0
      0080A7 2F                    1135 	.db #0x2f	; 47
      0080A8 00                    1136 	.db #0x00	; 0
      0080A9 00                    1137 	.db #0x00	; 0
      0080AA 00                    1138 	.db #0x00	; 0
      0080AB 00                    1139 	.db #0x00	; 0
      0080AC 07                    1140 	.db #0x07	; 7
      0080AD 00                    1141 	.db #0x00	; 0
      0080AE 07                    1142 	.db #0x07	; 7
      0080AF 00                    1143 	.db #0x00	; 0
      0080B0 00                    1144 	.db #0x00	; 0
      0080B1 14                    1145 	.db #0x14	; 20
      0080B2 7F                    1146 	.db #0x7f	; 127
      0080B3 14                    1147 	.db #0x14	; 20
      0080B4 7F                    1148 	.db #0x7f	; 127
      0080B5 14                    1149 	.db #0x14	; 20
      0080B6 00                    1150 	.db #0x00	; 0
      0080B7 24                    1151 	.db #0x24	; 36
      0080B8 2A                    1152 	.db #0x2a	; 42
      0080B9 7F                    1153 	.db #0x7f	; 127
      0080BA 2A                    1154 	.db #0x2a	; 42
      0080BB 12                    1155 	.db #0x12	; 18
      0080BC 00                    1156 	.db #0x00	; 0
      0080BD 23                    1157 	.db #0x23	; 35
      0080BE 13                    1158 	.db #0x13	; 19
      0080BF 08                    1159 	.db #0x08	; 8
      0080C0 64                    1160 	.db #0x64	; 100	'd'
      0080C1 62                    1161 	.db #0x62	; 98	'b'
      0080C2 00                    1162 	.db #0x00	; 0
      0080C3 36                    1163 	.db #0x36	; 54	'6'
      0080C4 49                    1164 	.db #0x49	; 73	'I'
      0080C5 55                    1165 	.db #0x55	; 85	'U'
      0080C6 22                    1166 	.db #0x22	; 34
      0080C7 50                    1167 	.db #0x50	; 80	'P'
      0080C8 00                    1168 	.db #0x00	; 0
      0080C9 00                    1169 	.db #0x00	; 0
      0080CA 05                    1170 	.db #0x05	; 5
      0080CB 03                    1171 	.db #0x03	; 3
      0080CC 00                    1172 	.db #0x00	; 0
      0080CD 00                    1173 	.db #0x00	; 0
      0080CE 00                    1174 	.db #0x00	; 0
      0080CF 00                    1175 	.db #0x00	; 0
      0080D0 1C                    1176 	.db #0x1c	; 28
      0080D1 22                    1177 	.db #0x22	; 34
      0080D2 41                    1178 	.db #0x41	; 65	'A'
      0080D3 00                    1179 	.db #0x00	; 0
      0080D4 00                    1180 	.db #0x00	; 0
      0080D5 00                    1181 	.db #0x00	; 0
      0080D6 41                    1182 	.db #0x41	; 65	'A'
      0080D7 22                    1183 	.db #0x22	; 34
      0080D8 1C                    1184 	.db #0x1c	; 28
      0080D9 00                    1185 	.db #0x00	; 0
      0080DA 00                    1186 	.db #0x00	; 0
      0080DB 14                    1187 	.db #0x14	; 20
      0080DC 08                    1188 	.db #0x08	; 8
      0080DD 3E                    1189 	.db #0x3e	; 62
      0080DE 08                    1190 	.db #0x08	; 8
      0080DF 14                    1191 	.db #0x14	; 20
      0080E0 00                    1192 	.db #0x00	; 0
      0080E1 08                    1193 	.db #0x08	; 8
      0080E2 08                    1194 	.db #0x08	; 8
      0080E3 3E                    1195 	.db #0x3e	; 62
      0080E4 08                    1196 	.db #0x08	; 8
      0080E5 08                    1197 	.db #0x08	; 8
      0080E6 00                    1198 	.db #0x00	; 0
      0080E7 00                    1199 	.db #0x00	; 0
      0080E8 00                    1200 	.db #0x00	; 0
      0080E9 50                    1201 	.db #0x50	; 80	'P'
      0080EA 30                    1202 	.db #0x30	; 48	'0'
      0080EB 00                    1203 	.db #0x00	; 0
      0080EC 00                    1204 	.db #0x00	; 0
      0080ED 08                    1205 	.db #0x08	; 8
      0080EE 08                    1206 	.db #0x08	; 8
      0080EF 08                    1207 	.db #0x08	; 8
      0080F0 08                    1208 	.db #0x08	; 8
      0080F1 08                    1209 	.db #0x08	; 8
      0080F2 00                    1210 	.db #0x00	; 0
      0080F3 00                    1211 	.db #0x00	; 0
      0080F4 60                    1212 	.db #0x60	; 96
      0080F5 60                    1213 	.db #0x60	; 96
      0080F6 00                    1214 	.db #0x00	; 0
      0080F7 00                    1215 	.db #0x00	; 0
      0080F8 00                    1216 	.db #0x00	; 0
      0080F9 20                    1217 	.db #0x20	; 32
      0080FA 10                    1218 	.db #0x10	; 16
      0080FB 08                    1219 	.db #0x08	; 8
      0080FC 04                    1220 	.db #0x04	; 4
      0080FD 02                    1221 	.db #0x02	; 2
      0080FE 00                    1222 	.db #0x00	; 0
      0080FF 3E                    1223 	.db #0x3e	; 62
      008100 51                    1224 	.db #0x51	; 81	'Q'
      008101 49                    1225 	.db #0x49	; 73	'I'
      008102 45                    1226 	.db #0x45	; 69	'E'
      008103 3E                    1227 	.db #0x3e	; 62
      008104 00                    1228 	.db #0x00	; 0
      008105 00                    1229 	.db #0x00	; 0
      008106 42                    1230 	.db #0x42	; 66	'B'
      008107 7F                    1231 	.db #0x7f	; 127
      008108 40                    1232 	.db #0x40	; 64
      008109 00                    1233 	.db #0x00	; 0
      00810A 00                    1234 	.db #0x00	; 0
      00810B 42                    1235 	.db #0x42	; 66	'B'
      00810C 61                    1236 	.db #0x61	; 97	'a'
      00810D 51                    1237 	.db #0x51	; 81	'Q'
      00810E 49                    1238 	.db #0x49	; 73	'I'
      00810F 46                    1239 	.db #0x46	; 70	'F'
      008110 00                    1240 	.db #0x00	; 0
      008111 21                    1241 	.db #0x21	; 33
      008112 41                    1242 	.db #0x41	; 65	'A'
      008113 45                    1243 	.db #0x45	; 69	'E'
      008114 4B                    1244 	.db #0x4b	; 75	'K'
      008115 31                    1245 	.db #0x31	; 49	'1'
      008116 00                    1246 	.db #0x00	; 0
      008117 18                    1247 	.db #0x18	; 24
      008118 14                    1248 	.db #0x14	; 20
      008119 12                    1249 	.db #0x12	; 18
      00811A 7F                    1250 	.db #0x7f	; 127
      00811B 10                    1251 	.db #0x10	; 16
      00811C 00                    1252 	.db #0x00	; 0
      00811D 27                    1253 	.db #0x27	; 39
      00811E 45                    1254 	.db #0x45	; 69	'E'
      00811F 45                    1255 	.db #0x45	; 69	'E'
      008120 45                    1256 	.db #0x45	; 69	'E'
      008121 39                    1257 	.db #0x39	; 57	'9'
      008122 00                    1258 	.db #0x00	; 0
      008123 3C                    1259 	.db #0x3c	; 60
      008124 4A                    1260 	.db #0x4a	; 74	'J'
      008125 49                    1261 	.db #0x49	; 73	'I'
      008126 49                    1262 	.db #0x49	; 73	'I'
      008127 30                    1263 	.db #0x30	; 48	'0'
      008128 00                    1264 	.db #0x00	; 0
      008129 01                    1265 	.db #0x01	; 1
      00812A 71                    1266 	.db #0x71	; 113	'q'
      00812B 09                    1267 	.db #0x09	; 9
      00812C 05                    1268 	.db #0x05	; 5
      00812D 03                    1269 	.db #0x03	; 3
      00812E 00                    1270 	.db #0x00	; 0
      00812F 36                    1271 	.db #0x36	; 54	'6'
      008130 49                    1272 	.db #0x49	; 73	'I'
      008131 49                    1273 	.db #0x49	; 73	'I'
      008132 49                    1274 	.db #0x49	; 73	'I'
      008133 36                    1275 	.db #0x36	; 54	'6'
      008134 00                    1276 	.db #0x00	; 0
      008135 06                    1277 	.db #0x06	; 6
      008136 49                    1278 	.db #0x49	; 73	'I'
      008137 49                    1279 	.db #0x49	; 73	'I'
      008138 29                    1280 	.db #0x29	; 41
      008139 1E                    1281 	.db #0x1e	; 30
      00813A 00                    1282 	.db #0x00	; 0
      00813B 00                    1283 	.db #0x00	; 0
      00813C 36                    1284 	.db #0x36	; 54	'6'
      00813D 36                    1285 	.db #0x36	; 54	'6'
      00813E 00                    1286 	.db #0x00	; 0
      00813F 00                    1287 	.db #0x00	; 0
      008140 00                    1288 	.db #0x00	; 0
      008141 00                    1289 	.db #0x00	; 0
      008142 56                    1290 	.db #0x56	; 86	'V'
      008143 36                    1291 	.db #0x36	; 54	'6'
      008144 00                    1292 	.db #0x00	; 0
      008145 00                    1293 	.db #0x00	; 0
      008146 00                    1294 	.db #0x00	; 0
      008147 08                    1295 	.db #0x08	; 8
      008148 14                    1296 	.db #0x14	; 20
      008149 22                    1297 	.db #0x22	; 34
      00814A 41                    1298 	.db #0x41	; 65	'A'
      00814B 00                    1299 	.db #0x00	; 0
      00814C 00                    1300 	.db #0x00	; 0
      00814D 14                    1301 	.db #0x14	; 20
      00814E 14                    1302 	.db #0x14	; 20
      00814F 14                    1303 	.db #0x14	; 20
      008150 14                    1304 	.db #0x14	; 20
      008151 14                    1305 	.db #0x14	; 20
      008152 00                    1306 	.db #0x00	; 0
      008153 00                    1307 	.db #0x00	; 0
      008154 41                    1308 	.db #0x41	; 65	'A'
      008155 22                    1309 	.db #0x22	; 34
      008156 14                    1310 	.db #0x14	; 20
      008157 08                    1311 	.db #0x08	; 8
      008158 00                    1312 	.db #0x00	; 0
      008159 02                    1313 	.db #0x02	; 2
      00815A 01                    1314 	.db #0x01	; 1
      00815B 51                    1315 	.db #0x51	; 81	'Q'
      00815C 09                    1316 	.db #0x09	; 9
      00815D 06                    1317 	.db #0x06	; 6
      00815E 00                    1318 	.db #0x00	; 0
      00815F 32                    1319 	.db #0x32	; 50	'2'
      008160 49                    1320 	.db #0x49	; 73	'I'
      008161 79                    1321 	.db #0x79	; 121	'y'
      008162 41                    1322 	.db #0x41	; 65	'A'
      008163 3E                    1323 	.db #0x3e	; 62
      008164 00                    1324 	.db #0x00	; 0
      008165 7E                    1325 	.db #0x7e	; 126
      008166 11                    1326 	.db #0x11	; 17
      008167 11                    1327 	.db #0x11	; 17
      008168 11                    1328 	.db #0x11	; 17
      008169 7E                    1329 	.db #0x7e	; 126
      00816A 00                    1330 	.db #0x00	; 0
      00816B 7F                    1331 	.db #0x7f	; 127
      00816C 49                    1332 	.db #0x49	; 73	'I'
      00816D 49                    1333 	.db #0x49	; 73	'I'
      00816E 49                    1334 	.db #0x49	; 73	'I'
      00816F 36                    1335 	.db #0x36	; 54	'6'
      008170 00                    1336 	.db #0x00	; 0
      008171 3E                    1337 	.db #0x3e	; 62
      008172 41                    1338 	.db #0x41	; 65	'A'
      008173 41                    1339 	.db #0x41	; 65	'A'
      008174 41                    1340 	.db #0x41	; 65	'A'
      008175 22                    1341 	.db #0x22	; 34
      008176 00                    1342 	.db #0x00	; 0
      008177 7F                    1343 	.db #0x7f	; 127
      008178 41                    1344 	.db #0x41	; 65	'A'
      008179 41                    1345 	.db #0x41	; 65	'A'
      00817A 22                    1346 	.db #0x22	; 34
      00817B 1C                    1347 	.db #0x1c	; 28
      00817C 00                    1348 	.db #0x00	; 0
      00817D 7F                    1349 	.db #0x7f	; 127
      00817E 49                    1350 	.db #0x49	; 73	'I'
      00817F 49                    1351 	.db #0x49	; 73	'I'
      008180 49                    1352 	.db #0x49	; 73	'I'
      008181 41                    1353 	.db #0x41	; 65	'A'
      008182 00                    1354 	.db #0x00	; 0
      008183 7F                    1355 	.db #0x7f	; 127
      008184 09                    1356 	.db #0x09	; 9
      008185 09                    1357 	.db #0x09	; 9
      008186 09                    1358 	.db #0x09	; 9
      008187 01                    1359 	.db #0x01	; 1
      008188 00                    1360 	.db #0x00	; 0
      008189 3E                    1361 	.db #0x3e	; 62
      00818A 41                    1362 	.db #0x41	; 65	'A'
      00818B 49                    1363 	.db #0x49	; 73	'I'
      00818C 49                    1364 	.db #0x49	; 73	'I'
      00818D 7A                    1365 	.db #0x7a	; 122	'z'
      00818E 00                    1366 	.db #0x00	; 0
      00818F 7F                    1367 	.db #0x7f	; 127
      008190 08                    1368 	.db #0x08	; 8
      008191 08                    1369 	.db #0x08	; 8
      008192 08                    1370 	.db #0x08	; 8
      008193 7F                    1371 	.db #0x7f	; 127
      008194 00                    1372 	.db #0x00	; 0
      008195 00                    1373 	.db #0x00	; 0
      008196 41                    1374 	.db #0x41	; 65	'A'
      008197 7F                    1375 	.db #0x7f	; 127
      008198 41                    1376 	.db #0x41	; 65	'A'
      008199 00                    1377 	.db #0x00	; 0
      00819A 00                    1378 	.db #0x00	; 0
      00819B 20                    1379 	.db #0x20	; 32
      00819C 40                    1380 	.db #0x40	; 64
      00819D 41                    1381 	.db #0x41	; 65	'A'
      00819E 3F                    1382 	.db #0x3f	; 63
      00819F 01                    1383 	.db #0x01	; 1
      0081A0 00                    1384 	.db #0x00	; 0
      0081A1 7F                    1385 	.db #0x7f	; 127
      0081A2 08                    1386 	.db #0x08	; 8
      0081A3 14                    1387 	.db #0x14	; 20
      0081A4 22                    1388 	.db #0x22	; 34
      0081A5 41                    1389 	.db #0x41	; 65	'A'
      0081A6 00                    1390 	.db #0x00	; 0
      0081A7 7F                    1391 	.db #0x7f	; 127
      0081A8 40                    1392 	.db #0x40	; 64
      0081A9 40                    1393 	.db #0x40	; 64
      0081AA 40                    1394 	.db #0x40	; 64
      0081AB 40                    1395 	.db #0x40	; 64
      0081AC 00                    1396 	.db #0x00	; 0
      0081AD 7F                    1397 	.db #0x7f	; 127
      0081AE 02                    1398 	.db #0x02	; 2
      0081AF 0C                    1399 	.db #0x0c	; 12
      0081B0 02                    1400 	.db #0x02	; 2
      0081B1 7F                    1401 	.db #0x7f	; 127
      0081B2 00                    1402 	.db #0x00	; 0
      0081B3 7F                    1403 	.db #0x7f	; 127
      0081B4 04                    1404 	.db #0x04	; 4
      0081B5 08                    1405 	.db #0x08	; 8
      0081B6 10                    1406 	.db #0x10	; 16
      0081B7 7F                    1407 	.db #0x7f	; 127
      0081B8 00                    1408 	.db #0x00	; 0
      0081B9 3E                    1409 	.db #0x3e	; 62
      0081BA 41                    1410 	.db #0x41	; 65	'A'
      0081BB 41                    1411 	.db #0x41	; 65	'A'
      0081BC 41                    1412 	.db #0x41	; 65	'A'
      0081BD 3E                    1413 	.db #0x3e	; 62
      0081BE 00                    1414 	.db #0x00	; 0
      0081BF 7F                    1415 	.db #0x7f	; 127
      0081C0 09                    1416 	.db #0x09	; 9
      0081C1 09                    1417 	.db #0x09	; 9
      0081C2 09                    1418 	.db #0x09	; 9
      0081C3 06                    1419 	.db #0x06	; 6
      0081C4 00                    1420 	.db #0x00	; 0
      0081C5 3E                    1421 	.db #0x3e	; 62
      0081C6 41                    1422 	.db #0x41	; 65	'A'
      0081C7 51                    1423 	.db #0x51	; 81	'Q'
      0081C8 21                    1424 	.db #0x21	; 33
      0081C9 5E                    1425 	.db #0x5e	; 94
      0081CA 00                    1426 	.db #0x00	; 0
      0081CB 7F                    1427 	.db #0x7f	; 127
      0081CC 09                    1428 	.db #0x09	; 9
      0081CD 19                    1429 	.db #0x19	; 25
      0081CE 29                    1430 	.db #0x29	; 41
      0081CF 46                    1431 	.db #0x46	; 70	'F'
      0081D0 00                    1432 	.db #0x00	; 0
      0081D1 46                    1433 	.db #0x46	; 70	'F'
      0081D2 49                    1434 	.db #0x49	; 73	'I'
      0081D3 49                    1435 	.db #0x49	; 73	'I'
      0081D4 49                    1436 	.db #0x49	; 73	'I'
      0081D5 31                    1437 	.db #0x31	; 49	'1'
      0081D6 00                    1438 	.db #0x00	; 0
      0081D7 01                    1439 	.db #0x01	; 1
      0081D8 01                    1440 	.db #0x01	; 1
      0081D9 7F                    1441 	.db #0x7f	; 127
      0081DA 01                    1442 	.db #0x01	; 1
      0081DB 01                    1443 	.db #0x01	; 1
      0081DC 00                    1444 	.db #0x00	; 0
      0081DD 3F                    1445 	.db #0x3f	; 63
      0081DE 40                    1446 	.db #0x40	; 64
      0081DF 40                    1447 	.db #0x40	; 64
      0081E0 40                    1448 	.db #0x40	; 64
      0081E1 3F                    1449 	.db #0x3f	; 63
      0081E2 00                    1450 	.db #0x00	; 0
      0081E3 1F                    1451 	.db #0x1f	; 31
      0081E4 20                    1452 	.db #0x20	; 32
      0081E5 40                    1453 	.db #0x40	; 64
      0081E6 20                    1454 	.db #0x20	; 32
      0081E7 1F                    1455 	.db #0x1f	; 31
      0081E8 00                    1456 	.db #0x00	; 0
      0081E9 3F                    1457 	.db #0x3f	; 63
      0081EA 40                    1458 	.db #0x40	; 64
      0081EB 38                    1459 	.db #0x38	; 56	'8'
      0081EC 40                    1460 	.db #0x40	; 64
      0081ED 3F                    1461 	.db #0x3f	; 63
      0081EE 00                    1462 	.db #0x00	; 0
      0081EF 63                    1463 	.db #0x63	; 99	'c'
      0081F0 14                    1464 	.db #0x14	; 20
      0081F1 08                    1465 	.db #0x08	; 8
      0081F2 14                    1466 	.db #0x14	; 20
      0081F3 63                    1467 	.db #0x63	; 99	'c'
      0081F4 00                    1468 	.db #0x00	; 0
      0081F5 07                    1469 	.db #0x07	; 7
      0081F6 08                    1470 	.db #0x08	; 8
      0081F7 70                    1471 	.db #0x70	; 112	'p'
      0081F8 08                    1472 	.db #0x08	; 8
      0081F9 07                    1473 	.db #0x07	; 7
      0081FA 00                    1474 	.db #0x00	; 0
      0081FB 61                    1475 	.db #0x61	; 97	'a'
      0081FC 51                    1476 	.db #0x51	; 81	'Q'
      0081FD 49                    1477 	.db #0x49	; 73	'I'
      0081FE 45                    1478 	.db #0x45	; 69	'E'
      0081FF 43                    1479 	.db #0x43	; 67	'C'
      008200 00                    1480 	.db #0x00	; 0
      008201 00                    1481 	.db #0x00	; 0
      008202 7F                    1482 	.db #0x7f	; 127
      008203 41                    1483 	.db #0x41	; 65	'A'
      008204 41                    1484 	.db #0x41	; 65	'A'
      008205 00                    1485 	.db #0x00	; 0
      008206 00                    1486 	.db #0x00	; 0
      008207 02                    1487 	.db #0x02	; 2
      008208 04                    1488 	.db #0x04	; 4
      008209 08                    1489 	.db #0x08	; 8
      00820A 10                    1490 	.db #0x10	; 16
      00820B 20                    1491 	.db #0x20	; 32
      00820C 00                    1492 	.db #0x00	; 0
      00820D 00                    1493 	.db #0x00	; 0
      00820E 41                    1494 	.db #0x41	; 65	'A'
      00820F 41                    1495 	.db #0x41	; 65	'A'
      008210 7F                    1496 	.db #0x7f	; 127
      008211 00                    1497 	.db #0x00	; 0
      008212 00                    1498 	.db #0x00	; 0
      008213 04                    1499 	.db #0x04	; 4
      008214 02                    1500 	.db #0x02	; 2
      008215 01                    1501 	.db #0x01	; 1
      008216 02                    1502 	.db #0x02	; 2
      008217 04                    1503 	.db #0x04	; 4
      008218 00                    1504 	.db #0x00	; 0
      008219 40                    1505 	.db #0x40	; 64
      00821A 40                    1506 	.db #0x40	; 64
      00821B 40                    1507 	.db #0x40	; 64
      00821C 40                    1508 	.db #0x40	; 64
      00821D 40                    1509 	.db #0x40	; 64
      00821E 00                    1510 	.db #0x00	; 0
      00821F 00                    1511 	.db #0x00	; 0
      008220 01                    1512 	.db #0x01	; 1
      008221 02                    1513 	.db #0x02	; 2
      008222 04                    1514 	.db #0x04	; 4
      008223 00                    1515 	.db #0x00	; 0
      008224 00                    1516 	.db #0x00	; 0
      008225 20                    1517 	.db #0x20	; 32
      008226 54                    1518 	.db #0x54	; 84	'T'
      008227 54                    1519 	.db #0x54	; 84	'T'
      008228 54                    1520 	.db #0x54	; 84	'T'
      008229 78                    1521 	.db #0x78	; 120	'x'
      00822A 00                    1522 	.db #0x00	; 0
      00822B 7F                    1523 	.db #0x7f	; 127
      00822C 48                    1524 	.db #0x48	; 72	'H'
      00822D 44                    1525 	.db #0x44	; 68	'D'
      00822E 44                    1526 	.db #0x44	; 68	'D'
      00822F 38                    1527 	.db #0x38	; 56	'8'
      008230 00                    1528 	.db #0x00	; 0
      008231 38                    1529 	.db #0x38	; 56	'8'
      008232 44                    1530 	.db #0x44	; 68	'D'
      008233 44                    1531 	.db #0x44	; 68	'D'
      008234 44                    1532 	.db #0x44	; 68	'D'
      008235 20                    1533 	.db #0x20	; 32
      008236 00                    1534 	.db #0x00	; 0
      008237 38                    1535 	.db #0x38	; 56	'8'
      008238 44                    1536 	.db #0x44	; 68	'D'
      008239 44                    1537 	.db #0x44	; 68	'D'
      00823A 48                    1538 	.db #0x48	; 72	'H'
      00823B 7F                    1539 	.db #0x7f	; 127
      00823C 00                    1540 	.db #0x00	; 0
      00823D 38                    1541 	.db #0x38	; 56	'8'
      00823E 54                    1542 	.db #0x54	; 84	'T'
      00823F 54                    1543 	.db #0x54	; 84	'T'
      008240 54                    1544 	.db #0x54	; 84	'T'
      008241 18                    1545 	.db #0x18	; 24
      008242 00                    1546 	.db #0x00	; 0
      008243 08                    1547 	.db #0x08	; 8
      008244 7E                    1548 	.db #0x7e	; 126
      008245 09                    1549 	.db #0x09	; 9
      008246 01                    1550 	.db #0x01	; 1
      008247 02                    1551 	.db #0x02	; 2
      008248 00                    1552 	.db #0x00	; 0
      008249 0C                    1553 	.db #0x0c	; 12
      00824A 52                    1554 	.db #0x52	; 82	'R'
      00824B 52                    1555 	.db #0x52	; 82	'R'
      00824C 52                    1556 	.db #0x52	; 82	'R'
      00824D 3E                    1557 	.db #0x3e	; 62
      00824E 00                    1558 	.db #0x00	; 0
      00824F 7F                    1559 	.db #0x7f	; 127
      008250 08                    1560 	.db #0x08	; 8
      008251 04                    1561 	.db #0x04	; 4
      008252 04                    1562 	.db #0x04	; 4
      008253 78                    1563 	.db #0x78	; 120	'x'
      008254 00                    1564 	.db #0x00	; 0
      008255 00                    1565 	.db #0x00	; 0
      008256 44                    1566 	.db #0x44	; 68	'D'
      008257 7D                    1567 	.db #0x7d	; 125
      008258 40                    1568 	.db #0x40	; 64
      008259 00                    1569 	.db #0x00	; 0
      00825A 00                    1570 	.db #0x00	; 0
      00825B 20                    1571 	.db #0x20	; 32
      00825C 40                    1572 	.db #0x40	; 64
      00825D 44                    1573 	.db #0x44	; 68	'D'
      00825E 3D                    1574 	.db #0x3d	; 61
      00825F 00                    1575 	.db #0x00	; 0
      008260 00                    1576 	.db #0x00	; 0
      008261 7F                    1577 	.db #0x7f	; 127
      008262 10                    1578 	.db #0x10	; 16
      008263 28                    1579 	.db #0x28	; 40
      008264 44                    1580 	.db #0x44	; 68	'D'
      008265 00                    1581 	.db #0x00	; 0
      008266 00                    1582 	.db #0x00	; 0
      008267 00                    1583 	.db #0x00	; 0
      008268 41                    1584 	.db #0x41	; 65	'A'
      008269 7F                    1585 	.db #0x7f	; 127
      00826A 40                    1586 	.db #0x40	; 64
      00826B 00                    1587 	.db #0x00	; 0
      00826C 00                    1588 	.db #0x00	; 0
      00826D 7C                    1589 	.db #0x7c	; 124
      00826E 04                    1590 	.db #0x04	; 4
      00826F 18                    1591 	.db #0x18	; 24
      008270 04                    1592 	.db #0x04	; 4
      008271 78                    1593 	.db #0x78	; 120	'x'
      008272 00                    1594 	.db #0x00	; 0
      008273 7C                    1595 	.db #0x7c	; 124
      008274 08                    1596 	.db #0x08	; 8
      008275 04                    1597 	.db #0x04	; 4
      008276 04                    1598 	.db #0x04	; 4
      008277 78                    1599 	.db #0x78	; 120	'x'
      008278 00                    1600 	.db #0x00	; 0
      008279 38                    1601 	.db #0x38	; 56	'8'
      00827A 44                    1602 	.db #0x44	; 68	'D'
      00827B 44                    1603 	.db #0x44	; 68	'D'
      00827C 44                    1604 	.db #0x44	; 68	'D'
      00827D 38                    1605 	.db #0x38	; 56	'8'
      00827E 00                    1606 	.db #0x00	; 0
      00827F 7C                    1607 	.db #0x7c	; 124
      008280 14                    1608 	.db #0x14	; 20
      008281 14                    1609 	.db #0x14	; 20
      008282 14                    1610 	.db #0x14	; 20
      008283 08                    1611 	.db #0x08	; 8
      008284 00                    1612 	.db #0x00	; 0
      008285 08                    1613 	.db #0x08	; 8
      008286 14                    1614 	.db #0x14	; 20
      008287 14                    1615 	.db #0x14	; 20
      008288 18                    1616 	.db #0x18	; 24
      008289 7C                    1617 	.db #0x7c	; 124
      00828A 00                    1618 	.db #0x00	; 0
      00828B 7C                    1619 	.db #0x7c	; 124
      00828C 08                    1620 	.db #0x08	; 8
      00828D 04                    1621 	.db #0x04	; 4
      00828E 04                    1622 	.db #0x04	; 4
      00828F 08                    1623 	.db #0x08	; 8
      008290 00                    1624 	.db #0x00	; 0
      008291 48                    1625 	.db #0x48	; 72	'H'
      008292 54                    1626 	.db #0x54	; 84	'T'
      008293 54                    1627 	.db #0x54	; 84	'T'
      008294 54                    1628 	.db #0x54	; 84	'T'
      008295 20                    1629 	.db #0x20	; 32
      008296 00                    1630 	.db #0x00	; 0
      008297 04                    1631 	.db #0x04	; 4
      008298 3F                    1632 	.db #0x3f	; 63
      008299 44                    1633 	.db #0x44	; 68	'D'
      00829A 40                    1634 	.db #0x40	; 64
      00829B 20                    1635 	.db #0x20	; 32
      00829C 00                    1636 	.db #0x00	; 0
      00829D 3C                    1637 	.db #0x3c	; 60
      00829E 40                    1638 	.db #0x40	; 64
      00829F 40                    1639 	.db #0x40	; 64
      0082A0 20                    1640 	.db #0x20	; 32
      0082A1 7C                    1641 	.db #0x7c	; 124
      0082A2 00                    1642 	.db #0x00	; 0
      0082A3 1C                    1643 	.db #0x1c	; 28
      0082A4 20                    1644 	.db #0x20	; 32
      0082A5 40                    1645 	.db #0x40	; 64
      0082A6 20                    1646 	.db #0x20	; 32
      0082A7 1C                    1647 	.db #0x1c	; 28
      0082A8 00                    1648 	.db #0x00	; 0
      0082A9 3C                    1649 	.db #0x3c	; 60
      0082AA 40                    1650 	.db #0x40	; 64
      0082AB 30                    1651 	.db #0x30	; 48	'0'
      0082AC 40                    1652 	.db #0x40	; 64
      0082AD 3C                    1653 	.db #0x3c	; 60
      0082AE 00                    1654 	.db #0x00	; 0
      0082AF 44                    1655 	.db #0x44	; 68	'D'
      0082B0 28                    1656 	.db #0x28	; 40
      0082B1 10                    1657 	.db #0x10	; 16
      0082B2 28                    1658 	.db #0x28	; 40
      0082B3 44                    1659 	.db #0x44	; 68	'D'
      0082B4 00                    1660 	.db #0x00	; 0
      0082B5 0C                    1661 	.db #0x0c	; 12
      0082B6 50                    1662 	.db #0x50	; 80	'P'
      0082B7 50                    1663 	.db #0x50	; 80	'P'
      0082B8 50                    1664 	.db #0x50	; 80	'P'
      0082B9 3C                    1665 	.db #0x3c	; 60
      0082BA 00                    1666 	.db #0x00	; 0
      0082BB 44                    1667 	.db #0x44	; 68	'D'
      0082BC 64                    1668 	.db #0x64	; 100	'd'
      0082BD 54                    1669 	.db #0x54	; 84	'T'
      0082BE 4C                    1670 	.db #0x4c	; 76	'L'
      0082BF 44                    1671 	.db #0x44	; 68	'D'
      0082C0 00                    1672 	.db #0x00	; 0
      0082C1 00                    1673 	.db #0x00	; 0
      0082C2 08                    1674 	.db #0x08	; 8
      0082C3 36                    1675 	.db #0x36	; 54	'6'
      0082C4 41                    1676 	.db #0x41	; 65	'A'
      0082C5 00                    1677 	.db #0x00	; 0
      0082C6 00                    1678 	.db #0x00	; 0
      0082C7 00                    1679 	.db #0x00	; 0
      0082C8 00                    1680 	.db #0x00	; 0
      0082C9 7F                    1681 	.db #0x7f	; 127
      0082CA 00                    1682 	.db #0x00	; 0
      0082CB 00                    1683 	.db #0x00	; 0
      0082CC 00                    1684 	.db #0x00	; 0
      0082CD 00                    1685 	.db #0x00	; 0
      0082CE 41                    1686 	.db #0x41	; 65	'A'
      0082CF 36                    1687 	.db #0x36	; 54	'6'
      0082D0 08                    1688 	.db #0x08	; 8
      0082D1 00                    1689 	.db #0x00	; 0
      0082D2 00                    1690 	.db #0x00	; 0
      0082D3 08                    1691 	.db #0x08	; 8
      0082D4 08                    1692 	.db #0x08	; 8
      0082D5 2A                    1693 	.db #0x2a	; 42
      0082D6 1C                    1694 	.db #0x1c	; 28
      0082D7 08                    1695 	.db #0x08	; 8
      0082D8 00                    1696 	.db 0x00
      0082D9 00                    1697 	.db 0x00
      0082DA 00                    1698 	.db 0x00
      0082DB 00                    1699 	.db 0x00
      0082DC 00                    1700 	.db 0x00
      0082DD 00                    1701 	.db 0x00
                                   1702 	.area CODE
                                   1703 	.area INITIALIZER
      0082E9                       1704 __xinit__oled_cursor_x:
      0082E9 00                    1705 	.db #0x00	; 0
      0082EA                       1706 __xinit__oled_cursor_y:
      0082EA 00                    1707 	.db #0x00	; 0
      0082EB                       1708 __xinit__oled_current_font:
      0082EB 01                    1709 	.db #0x01	; 1
                                   1710 	.area CABS (ABS)
