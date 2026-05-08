;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module oled
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _i2c_send_addr
	.globl _i2c_write
	.globl _i2c_stop
	.globl _i2c_start
	.globl _delay_ms
	.globl _oled_init
	.globl _oled_deinit
	.globl _oled_clear
	.globl _oled_clear_page
	.globl _oled_update
	.globl _oled_set_pixel
	.globl _oled_draw_line
	.globl _oled_draw_rect
	.globl _oled_fill_rect
	.globl _oled_gotoxy
	.globl _oled_putc
	.globl _oled_puts
	.globl _oled_puts_at
	.globl _oled_set_font
	.globl _oled_set_contrast
	.globl _oled_invert
	.globl _oled_normal
	.globl _oled_scroll_left
	.globl _oled_scroll_right
	.globl _oled_scroll_stop
	.globl _oled_print_number
	.globl _oled_print_hex
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_oled_buffer:
	.ds 512
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_oled_cursor_x:
	.ds 1
_oled_cursor_y:
	.ds 1
_oled_current_font:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	lib/oled.c: 120: static void oled_write_cmd(unsigned char cmd)
;	-----------------------------------------
;	 function oled_write_cmd
;	-----------------------------------------
_oled_write_cmd:
	push	a
	ld	(0x01, sp), a
;	lib/oled.c: 122: i2c_start();
	call	_i2c_start
;	lib/oled.c: 123: i2c_send_addr(OLED_ADDR);
	ld	a, #0x78
	call	_i2c_send_addr
;	lib/oled.c: 124: i2c_write(0x00);  // Command mode
	clr	a
	call	_i2c_write
;	lib/oled.c: 125: i2c_write(cmd);
	ld	a, (0x01, sp)
	call	_i2c_write
;	lib/oled.c: 126: i2c_stop();
	pop	a
	jp	_i2c_stop
;	lib/oled.c: 127: }
	pop	a
	ret
;	lib/oled.c: 129: static void oled_write_cmd_multi(unsigned char* cmds, unsigned char len)
;	-----------------------------------------
;	 function oled_write_cmd_multi
;	-----------------------------------------
_oled_write_cmd_multi:
	sub	sp, #4
	ldw	(0x02, sp), x
	ld	(0x01, sp), a
;	lib/oled.c: 132: i2c_start();
	call	_i2c_start
;	lib/oled.c: 133: i2c_send_addr(OLED_ADDR);
	ld	a, #0x78
	call	_i2c_send_addr
;	lib/oled.c: 134: i2c_write(0x00);
	clr	a
	call	_i2c_write
;	lib/oled.c: 135: for(i = 0; i < len; i++) {
	clr	(0x04, sp)
00103$:
	ld	a, (0x04, sp)
	cp	a, (0x01, sp)
	jrnc	00101$
;	lib/oled.c: 136: i2c_write(cmds[i]);
	clrw	x
	ld	a, (0x04, sp)
	ld	xl, a
	addw	x, (0x02, sp)
	ld	a, (x)
	call	_i2c_write
;	lib/oled.c: 135: for(i = 0; i < len; i++) {
	inc	(0x04, sp)
	jra	00103$
00101$:
;	lib/oled.c: 138: i2c_stop();
	addw	sp, #4
;	lib/oled.c: 139: }
	jp	_i2c_stop
;	lib/oled.c: 141: static void oled_send_buffer(void)
;	-----------------------------------------
;	 function oled_send_buffer
;	-----------------------------------------
_oled_send_buffer:
	sub	sp, #4
;	lib/oled.c: 145: for(page = 0; page < OLED_PAGES; page++) {
	clr	(0x03, sp)
00105$:
;	lib/oled.c: 147: oled_write_cmd(0xB0 | page);
	ld	a, (0x03, sp)
	or	a, #0xb0
	call	_oled_write_cmd
;	lib/oled.c: 148: oled_write_cmd(0x00);  // Low column
	clr	a
	call	_oled_write_cmd
;	lib/oled.c: 149: oled_write_cmd(0x10);  // High column
	ld	a, #0x10
	call	_oled_write_cmd
;	lib/oled.c: 152: i2c_start();
	call	_i2c_start
;	lib/oled.c: 153: i2c_send_addr(OLED_ADDR);
	ld	a, #0x78
	call	_i2c_send_addr
;	lib/oled.c: 154: i2c_write(0x40);  // Data mode
	ld	a, #0x40
	call	_i2c_write
;	lib/oled.c: 156: for(col = 0; col < OLED_WIDTH; col++) {
	clr	(0x04, sp)
00103$:
;	lib/oled.c: 157: i2c_write(oled_buffer[page * OLED_WIDTH + col]);
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	ld	a, (0x04, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	addw	x, (0x01, sp)
	ld	a, (_oled_buffer+0, x)
	call	_i2c_write
;	lib/oled.c: 156: for(col = 0; col < OLED_WIDTH; col++) {
	inc	(0x04, sp)
	ld	a, (0x04, sp)
	cp	a, #0x80
	jrc	00103$
;	lib/oled.c: 159: i2c_stop();
	call	_i2c_stop
;	lib/oled.c: 145: for(page = 0; page < OLED_PAGES; page++) {
	inc	(0x03, sp)
	ld	a, (0x03, sp)
	cp	a, #0x04
	jrc	00105$
;	lib/oled.c: 161: }
	addw	sp, #4
	ret
;	lib/oled.c: 166: void oled_init(void)
;	-----------------------------------------
;	 function oled_init
;	-----------------------------------------
_oled_init:
	sub	sp, #25
;	lib/oled.c: 168: delay_ms(100);
	ldw	x, #0x0064
	call	_delay_ms
;	lib/oled.c: 170: unsigned char init_cmds[] = {
	ldw	x, sp
	incw	x
	ld	a, #0xae
	ld	(x), a
	ld	a, #0xd5
	ld	(0x02, sp), a
	ld	a, #0x80
	ld	(0x03, sp), a
	ld	a, #0xa8
	ld	(0x04, sp), a
	ld	a, #0x1f
	ld	(0x05, sp), a
	ld	a, #0xd3
	ld	(0x06, sp), a
	clr	(0x07, sp)
	ld	a, #0x40
	ld	(0x08, sp), a
	ld	a, #0x8d
	ld	(0x09, sp), a
	ld	a, #0x14
	ld	(0x0a, sp), a
	ld	a, #0x20
	ld	(0x0b, sp), a
	clr	(0x0c, sp)
	ld	a, #0xa1
	ld	(0x0d, sp), a
	ld	a, #0xc8
	ld	(0x0e, sp), a
	ld	a, #0xda
	ld	(0x0f, sp), a
	ld	a, #0x02
	ld	(0x10, sp), a
	ld	a, #0x81
	ld	(0x11, sp), a
	ld	a, #0xcf
	ld	(0x12, sp), a
	ld	a, #0xd9
	ld	(0x13, sp), a
	ld	a, #0xf1
	ld	(0x14, sp), a
	ld	a, #0xdb
	ld	(0x15, sp), a
	ld	a, #0x40
	ld	(0x16, sp), a
	ld	a, #0xa4
	ld	(0x17, sp), a
	ld	a, #0xa6
	ld	(0x18, sp), a
	ld	a, #0xaf
	ld	(0x19, sp), a
;	lib/oled.c: 189: oled_write_cmd_multi(init_cmds, sizeof(init_cmds));
	ld	a, #0x19
	call	_oled_write_cmd_multi
;	lib/oled.c: 192: oled_clear();
	call	_oled_clear
;	lib/oled.c: 193: }
	addw	sp, #25
	ret
;	lib/oled.c: 195: void oled_deinit(void)
;	-----------------------------------------
;	 function oled_deinit
;	-----------------------------------------
_oled_deinit:
;	lib/oled.c: 197: oled_write_cmd(0xAE);  // Display OFF
	ld	a, #0xae
;	lib/oled.c: 198: }
	jp	_oled_write_cmd
;	lib/oled.c: 200: void oled_clear(void)
;	-----------------------------------------
;	 function oled_clear
;	-----------------------------------------
_oled_clear:
;	lib/oled.c: 203: for(i = 0; i < sizeof(oled_buffer); i++) {
	clrw	y
00102$:
;	lib/oled.c: 204: oled_buffer[i] = 0x00;
	ldw	x, y
	clr	((_oled_buffer+0), x)
;	lib/oled.c: 203: for(i = 0; i < sizeof(oled_buffer); i++) {
	incw	y
	ldw	x, y
	cpw	x, #0x0200
	jrc	00102$
;	lib/oled.c: 206: oled_send_buffer();
;	lib/oled.c: 207: }
	jp	_oled_send_buffer
;	lib/oled.c: 209: void oled_clear_page(unsigned char page)
;	-----------------------------------------
;	 function oled_clear_page
;	-----------------------------------------
_oled_clear_page:
	sub	sp, #2
;	lib/oled.c: 212: if(page >= OLED_PAGES) return;
	ld	yl, a
	cp	a, #0x04
;	lib/oled.c: 214: for(col = 0; col < OLED_WIDTH; col++) {
	jrnc	00109$
	clr	a
00105$:
;	lib/oled.c: 215: oled_buffer[page * OLED_WIDTH + col] = 0x00;
	clrw	x
	exg	a, xl
	ld	a, yl
	exg	a, xl
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	ld	(0x02, sp), a
	clr	(0x01, sp)
	addw	x, (0x01, sp)
	clr	((_oled_buffer+0), x)
;	lib/oled.c: 214: for(col = 0; col < OLED_WIDTH; col++) {
	inc	a
	cp	a, #0x80
	jrc	00105$
;	lib/oled.c: 219: oled_write_cmd(0xB0 | page);
	ld	a, yl
	or	a, #0xb0
	call	_oled_write_cmd
;	lib/oled.c: 220: oled_write_cmd(0x00);
	clr	a
	call	_oled_write_cmd
;	lib/oled.c: 221: oled_write_cmd(0x10);
	ld	a, #0x10
	call	_oled_write_cmd
;	lib/oled.c: 223: i2c_start();
	call	_i2c_start
;	lib/oled.c: 224: i2c_send_addr(OLED_ADDR);
	ld	a, #0x78
	call	_i2c_send_addr
;	lib/oled.c: 225: i2c_write(0x40);
	ld	a, #0x40
	call	_i2c_write
;	lib/oled.c: 226: for(col = 0; col < OLED_WIDTH; col++) {
	clr	a
00107$:
;	lib/oled.c: 227: i2c_write(0x00);
	push	a
	clr	a
	call	_i2c_write
	pop	a
;	lib/oled.c: 226: for(col = 0; col < OLED_WIDTH; col++) {
	inc	a
	cp	a, #0x80
	jrc	00107$
;	lib/oled.c: 229: i2c_stop();
	addw	sp, #2
	jp	_i2c_stop
00109$:
;	lib/oled.c: 230: }
	addw	sp, #2
	ret
;	lib/oled.c: 232: void oled_update(void)
;	-----------------------------------------
;	 function oled_update
;	-----------------------------------------
_oled_update:
;	lib/oled.c: 234: oled_send_buffer();
;	lib/oled.c: 235: }
	jp	_oled_send_buffer
;	lib/oled.c: 237: void oled_set_pixel(unsigned char x, unsigned char y, unsigned char color)
;	-----------------------------------------
;	 function oled_set_pixel
;	-----------------------------------------
_oled_set_pixel:
	sub	sp, #4
;	lib/oled.c: 241: if(x >= OLED_WIDTH || y >= OLED_HEIGHT) return;
	ld	yl, a
	cp	a, #0x80
	jrnc	00107$
	ld	a, (0x07, sp)
	cp	a, #0x20
	jrnc	00107$
;	lib/oled.c: 243: page = y / 8;
	ld	a, (0x07, sp)
	push	a
	clrw	x
	ld	xl, a
	ld	a, #0x08
	div	x, a
	pop	a
;	lib/oled.c: 244: bit = y % 8;
	and	a, #0x07
	ld	(0x04, sp), a
;	lib/oled.c: 247: oled_buffer[page * OLED_WIDTH + x] |= (1 << bit);
	clr	a
	ld	xh, a
	clr	a
	ld	yh, a
	ld	a, #0x01
	ld	(0x03, sp), a
	ld	a, (0x04, sp)
	jreq	00126$
00125$:
	sll	(0x03, sp)
	dec	a
	jrne	00125$
00126$:
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	ldw	(0x01, sp), x
	ldw	x, y
	addw	x, (0x01, sp)
;	lib/oled.c: 246: if(color) {
	tnz	(0x08, sp)
	jreq	00105$
;	lib/oled.c: 247: oled_buffer[page * OLED_WIDTH + x] |= (1 << bit);
	addw	x, #(_oled_buffer+0)
	ld	a, (x)
	or	a, (0x03, sp)
	ld	(x), a
	jra	00107$
00105$:
;	lib/oled.c: 249: oled_buffer[page * OLED_WIDTH + x] &= ~(1 << bit);
	addw	x, #(_oled_buffer+0)
	ld	a, (x)
	ld	(0x04, sp), a
	ld	a, (0x03, sp)
	cpl	a
	and	a, (0x04, sp)
	ld	(x), a
00107$:
;	lib/oled.c: 251: }
	ldw	x, (5, sp)
	addw	sp, #8
	jp	(x)
;	lib/oled.c: 253: void oled_draw_line(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char color)
;	-----------------------------------------
;	 function oled_draw_line
;	-----------------------------------------
_oled_draw_line:
	sub	sp, #12
	ld	(0x0a, sp), a
;	lib/oled.c: 257: dx = (x2 > x1) ? (x2 - x1) : (x1 - x2);
	ld	a, (0x10, sp)
	ld	(0x07, sp), a
	clr	(0x06, sp)
	ld	a, (0x0a, sp)
	ld	(0x09, sp), a
	clr	(0x08, sp)
	ld	a, (0x10, sp)
	cp	a, (0x0a, sp)
	jrule	00113$
	ldw	x, (0x06, sp)
	subw	x, (0x08, sp)
	ldw	(0x0b, sp), x
	jra	00114$
00113$:
	ldw	x, (0x08, sp)
	subw	x, (0x06, sp)
	ldw	(0x0b, sp), x
00114$:
	ldw	y, (0x0b, sp)
	ldw	(0x01, sp), y
;	lib/oled.c: 258: dy = (y2 > y1) ? (y2 - y1) : (y1 - y2);
	ld	a, (0x11, sp)
	ld	(0x07, sp), a
	clr	(0x06, sp)
	ld	a, (0x0f, sp)
	ld	(0x09, sp), a
	clr	(0x08, sp)
	ld	a, (0x11, sp)
	cp	a, (0x0f, sp)
	jrule	00115$
	ldw	x, (0x06, sp)
	subw	x, (0x08, sp)
	ldw	(0x0b, sp), x
	jra	00116$
00115$:
	ldw	x, (0x08, sp)
	subw	x, (0x06, sp)
	ldw	(0x0b, sp), x
00116$:
	ldw	y, (0x0b, sp)
	ldw	(0x03, sp), y
;	lib/oled.c: 259: sx = (x1 < x2) ? 1 : -1;
	ld	a, (0x0a, sp)
	cp	a, (0x10, sp)
	jrnc	00117$
	ld	a, #0x01
	.byte 0xc5
00117$:
	ld	a, #0xff
00118$:
	ld	(0x05, sp), a
;	lib/oled.c: 260: sy = (y1 < y2) ? 1 : -1;
	ld	a, (0x0f, sp)
	cp	a, (0x11, sp)
	jrnc	00119$
	ld	a, #0x01
	.byte 0xc5
00119$:
	ld	a, #0xff
00120$:
	ld	(0x06, sp), a
;	lib/oled.c: 261: err = dx - dy;
	ldw	x, (0x01, sp)
	subw	x, (0x03, sp)
	ldw	(0x0b, sp), x
;	lib/oled.c: 263: while(1) {
	ld	a, (0x04, sp)
	neg	a
	ld	(0x08, sp), a
	clr	a
	sbc	a, (0x03, sp)
	ld	(0x07, sp), a
00109$:
;	lib/oled.c: 264: oled_set_pixel(x1, y1, color);
	ld	a, (0x12, sp)
	push	a
	ld	a, (0x10, sp)
	push	a
	ld	a, (0x0c, sp)
	call	_oled_set_pixel
;	lib/oled.c: 265: if(x1 == x2 && y1 == y2) break;
	ld	a, (0x0a, sp)
	cp	a, (0x10, sp)
	jrne	00102$
	ld	a, (0x0f, sp)
	cp	a, (0x11, sp)
	jreq	00111$
00102$:
;	lib/oled.c: 266: e2 = 2 * err;
	ldw	x, (0x0b, sp)
	sllw	x
;	lib/oled.c: 267: if(e2 > -dy) { err -= dy; x1 += sx; }
	cpw	x, (0x07, sp)
	jrsle	00105$
	ldw	y, (0x0b, sp)
	subw	y, (0x03, sp)
	ldw	(0x0b, sp), y
	ld	a, (0x05, sp)
	ld	(0x09, sp), a
	ld	a, (0x0a, sp)
	add	a, (0x09, sp)
	ld	(0x0a, sp), a
00105$:
;	lib/oled.c: 268: if(e2 < dx) { err += dx; y1 += sy; }
	cpw	x, (0x01, sp)
	jrsge	00109$
	ldw	x, (0x0b, sp)
	addw	x, (0x01, sp)
	ldw	(0x0b, sp), x
	ld	a, (0x06, sp)
	ld	(0x09, sp), a
	ld	a, (0x0f, sp)
	add	a, (0x09, sp)
	ld	(0x0f, sp), a
	jra	00109$
00111$:
;	lib/oled.c: 270: }
	ldw	x, (13, sp)
	addw	sp, #18
	jp	(x)
;	lib/oled.c: 272: void oled_draw_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color)
;	-----------------------------------------
;	 function oled_draw_rect
;	-----------------------------------------
_oled_draw_rect:
	push	a
;	lib/oled.c: 274: oled_draw_line(x, y, x + w - 1, y, color);
	ld	xl, a
	add	a, (0x05, sp)
	dec	a
	ld	xh, a
	pushw	x
	ld	a, (0x09, sp)
	push	a
	ld	a, (0x07, sp)
	push	a
	ld	a, xh
	push	a
	ld	a, (0x09, sp)
	push	a
	ld	a, xl
	call	_oled_draw_line
	popw	x
;	lib/oled.c: 275: oled_draw_line(x, y, x, y + h - 1, color);
	ld	a, (0x04, sp)
	add	a, (0x06, sp)
	dec	a
	ld	(0x01, sp), a
	pushw	x
	ld	a, (0x09, sp)
	push	a
	ld	a, (0x04, sp)
	push	a
	ld	a, xl
	push	a
	ld	a, (0x09, sp)
	push	a
	ld	a, xl
	call	_oled_draw_line
	popw	x
;	lib/oled.c: 276: oled_draw_line(x + w - 1, y, x + w - 1, y + h - 1, color);
	pushw	x
	ld	a, (0x09, sp)
	push	a
	ld	a, (0x04, sp)
	push	a
	ld	a, xh
	push	a
	ld	a, (0x09, sp)
	push	a
	ld	a, xh
	call	_oled_draw_line
	popw	x
;	lib/oled.c: 277: oled_draw_line(x, y + h - 1, x + w - 1, y + h - 1, color);
	ld	a, (0x07, sp)
	push	a
	ld	a, (0x02, sp)
	push	a
	ld	a, xh
	push	a
	ld	a, (0x04, sp)
	push	a
	ld	a, xl
	call	_oled_draw_line
;	lib/oled.c: 278: }
	ldw	x, (2, sp)
	addw	sp, #7
	jp	(x)
;	lib/oled.c: 280: void oled_fill_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color)
;	-----------------------------------------
;	 function oled_fill_rect
;	-----------------------------------------
_oled_fill_rect:
	sub	sp, #9
;	lib/oled.c: 283: for(i = x; i < x + w; i++) {
	ld	(0x07, sp), a
	ld	(0x08, sp), a
00107$:
	ld	a, (0x07, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ld	a, (0x0d, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	ldw	x, (0x01, sp)
	addw	x, (0x03, sp)
	ldw	(0x05, sp), x
	ld	a, (0x08, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	ldw	x, (0x03, sp)
	cpw	x, (0x05, sp)
	jrsge	00109$
;	lib/oled.c: 284: for(j = y; j < y + h; j++) {
	ld	a, (0x0c, sp)
	ld	(0x09, sp), a
00104$:
	clrw	x
	ld	a, (0x0c, sp)
	ld	xl, a
	ld	a, (0x0e, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	addw	x, (0x03, sp)
	ldw	(0x05, sp), x
	ld	a, (0x09, sp)
	clrw	x
	ld	xl, a
	cpw	x, (0x05, sp)
	jrsge	00108$
;	lib/oled.c: 285: oled_set_pixel(i, j, color);
	ld	a, (0x0f, sp)
	push	a
	ld	a, (0x0a, sp)
	push	a
	ld	a, (0x0a, sp)
	call	_oled_set_pixel
;	lib/oled.c: 284: for(j = y; j < y + h; j++) {
	inc	(0x09, sp)
	jra	00104$
00108$:
;	lib/oled.c: 283: for(i = x; i < x + w; i++) {
	inc	(0x08, sp)
	jra	00107$
00109$:
;	lib/oled.c: 288: }
	ldw	x, (10, sp)
	addw	sp, #15
	jp	(x)
;	lib/oled.c: 290: void oled_gotoxy(unsigned char x, unsigned char y)
;	-----------------------------------------
;	 function oled_gotoxy
;	-----------------------------------------
_oled_gotoxy:
;	lib/oled.c: 292: if(x < OLED_WIDTH && y < OLED_HEIGHT) {
	cp	a, #0x80
	jrnc	00104$
	push	a
	ld	a, (0x04, sp)
	cp	a, #0x20
	pop	a
	jrnc	00104$
;	lib/oled.c: 293: oled_cursor_x = x;
	ld	_oled_cursor_x+0, a
;	lib/oled.c: 294: oled_cursor_y = y;
	ld	a, (0x03, sp)
	ld	_oled_cursor_y+0, a
00104$:
;	lib/oled.c: 296: }
	popw	x
	pop	a
	jp	(x)
;	lib/oled.c: 298: void oled_putc(char c)
;	-----------------------------------------
;	 function oled_putc
;	-----------------------------------------
_oled_putc:
	sub	sp, #7
;	lib/oled.c: 300: if(c == '\n') {
	cp	a, #0x0a
	jrne	00102$
;	lib/oled.c: 301: oled_cursor_x = 0;
	clr	_oled_cursor_x+0
;	lib/oled.c: 302: oled_cursor_y += 8;
	ld	a, _oled_cursor_y+0
	add	a, #0x08
	ld	_oled_cursor_y+0, a
;	lib/oled.c: 303: return;
	jra	00116$
00102$:
;	lib/oled.c: 306: if(c >= 32 && c <= 127) {
	cp	a, #0x20
	jrc	00116$
	cp	a, #0x7f
	jrugt	00116$
;	lib/oled.c: 308: unsigned char idx = c - 32;
	sub	a, #0x20
	ld	xl, a
;	lib/oled.c: 310: for(i = 0; i < 6; i++) {
	ld	a, #0x06
	mul	x, a
	addw	x, #(_font_6x8+0)
	ldw	(0x01, sp), x
	clr	(0x06, sp)
00114$:
;	lib/oled.c: 311: unsigned char data = font_6x8[idx][i];
	clrw	x
	ld	a, (0x06, sp)
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	ld	(0x03, sp), a
;	lib/oled.c: 313: for(j = 0; j < 8; j++) {
	clr	(0x07, sp)
00112$:
;	lib/oled.c: 314: if(data & (1 << j)) {
	clrw	x
	incw	x
	ld	a, (0x07, sp)
	jreq	00189$
00188$:
	sllw	x
	dec	a
	jrne	00188$
00189$:
	ld	a, (0x03, sp)
	ld	(0x05, sp), a
	clr	(0x04, sp)
	ld	a, xl
	and	a, (0x05, sp)
	ld	xl, a
	clr	a
	ld	xh, a
	tnzw	x
	jreq	00113$
;	lib/oled.c: 315: oled_set_pixel(oled_cursor_x + i, oled_cursor_y + j, 1);
	ld	a, _oled_cursor_y+0
	add	a, (0x07, sp)
	ld	xl, a
	ld	a, _oled_cursor_x+0
	add	a, (0x06, sp)
	push	#0x01
	pushw	x
	addw	sp, #1
	call	_oled_set_pixel
00113$:
;	lib/oled.c: 313: for(j = 0; j < 8; j++) {
	inc	(0x07, sp)
	ld	a, (0x07, sp)
	cp	a, #0x08
	jrc	00112$
;	lib/oled.c: 310: for(i = 0; i < 6; i++) {
	inc	(0x06, sp)
	ld	a, (0x06, sp)
	cp	a, #0x06
	jrc	00114$
;	lib/oled.c: 319: oled_cursor_x += 6;
	ld	a, _oled_cursor_x+0
	add	a, #0x06
;	lib/oled.c: 321: if(oled_cursor_x > OLED_WIDTH - 6) {
	ld	_oled_cursor_x+0, a
	cp	a, #0x7a
	jrule	00116$
;	lib/oled.c: 322: oled_cursor_x = 0;
	clr	_oled_cursor_x+0
;	lib/oled.c: 323: oled_cursor_y += 8;
	ld	a, _oled_cursor_y+0
	add	a, #0x08
	ld	_oled_cursor_y+0, a
00116$:
;	lib/oled.c: 326: }
	addw	sp, #7
	ret
;	lib/oled.c: 328: void oled_puts(const char* str)
;	-----------------------------------------
;	 function oled_puts
;	-----------------------------------------
_oled_puts:
;	lib/oled.c: 330: while(*str) {
00101$:
	ld	a, (x)
	jrne	00121$
	jp	_oled_update
00121$:
;	lib/oled.c: 331: oled_putc(*str++);
	incw	x
	pushw	x
	call	_oled_putc
	popw	x
;	lib/oled.c: 333: oled_update();
;	lib/oled.c: 334: }
	jra	00101$
;	lib/oled.c: 336: void oled_puts_at(unsigned char x, unsigned char y, const char* str)
;	-----------------------------------------
;	 function oled_puts_at
;	-----------------------------------------
_oled_puts_at:
	ld	xl, a
;	lib/oled.c: 338: oled_gotoxy(x, y);
	ld	a, (0x03, sp)
	push	a
	ld	a, xl
	call	_oled_gotoxy
;	lib/oled.c: 339: oled_puts(str);
	ldw	x, (0x04, sp)
	ldw	y, (1, sp)
	ldw	(4, sp), y
	addw	sp, #3
;	lib/oled.c: 340: }
	jp	_oled_puts
;	lib/oled.c: 342: void oled_set_font(unsigned char font_size)
;	-----------------------------------------
;	 function oled_set_font
;	-----------------------------------------
_oled_set_font:
	ld	_oled_current_font+0, a
;	lib/oled.c: 344: oled_current_font = font_size;
;	lib/oled.c: 345: }
	ret
;	lib/oled.c: 347: void oled_set_contrast(unsigned char contrast)
;	-----------------------------------------
;	 function oled_set_contrast
;	-----------------------------------------
_oled_set_contrast:
;	lib/oled.c: 349: oled_write_cmd(0x81);
	push	a
	ld	a, #0x81
	call	_oled_write_cmd
	pop	a
;	lib/oled.c: 350: oled_write_cmd(contrast);
;	lib/oled.c: 351: }
	jp	_oled_write_cmd
;	lib/oled.c: 353: void oled_invert(void)
;	-----------------------------------------
;	 function oled_invert
;	-----------------------------------------
_oled_invert:
;	lib/oled.c: 355: oled_write_cmd(0xA7);  // Invert display
	ld	a, #0xa7
;	lib/oled.c: 356: }
	jp	_oled_write_cmd
;	lib/oled.c: 358: void oled_normal(void)
;	-----------------------------------------
;	 function oled_normal
;	-----------------------------------------
_oled_normal:
;	lib/oled.c: 360: oled_write_cmd(0xA6);  // Normal display
	ld	a, #0xa6
;	lib/oled.c: 361: }
	jp	_oled_write_cmd
;	lib/oled.c: 363: void oled_scroll_left(unsigned char pages, unsigned char speed)
;	-----------------------------------------
;	 function oled_scroll_left
;	-----------------------------------------
_oled_scroll_left:
	sub	sp, #7
;	lib/oled.c: 365: if(pages > 7) pages = 7;
	ld	xl, a
	cp	a, #0x07
	jrule	00102$
	ld	a, #0x07
	ld	xl, a
00102$:
;	lib/oled.c: 366: if(speed > 7) speed = 7;
	ld	a, (0x0a, sp)
	cp	a, #0x07
	jrule	00104$
	ld	a, #0x07
	ld	(0x0a, sp), a
00104$:
;	lib/oled.c: 368: unsigned char cmd[] = {
	ld	a, #0x26
	ld	(0x01, sp), a
	clr	(0x02, sp)
	clr	(0x03, sp)
	ld	a, (0x0a, sp)
	ld	(0x04, sp), a
	ld	a, xl
	dec	a
	ld	(0x05, sp), a
	clr	(0x06, sp)
	ld	a, #0xff
	ld	(0x07, sp), a
;	lib/oled.c: 377: oled_write_cmd_multi(cmd, 7);
	ld	a, #0x07
	ldw	x, sp
	incw	x
	call	_oled_write_cmd_multi
;	lib/oled.c: 378: oled_write_cmd(0x2F);   // Activate scroll
	ld	a, #0x2f
	call	_oled_write_cmd
;	lib/oled.c: 379: }
	addw	sp, #7
	popw	x
	pop	a
	jp	(x)
;	lib/oled.c: 381: void oled_scroll_right(unsigned char pages, unsigned char speed)
;	-----------------------------------------
;	 function oled_scroll_right
;	-----------------------------------------
_oled_scroll_right:
	sub	sp, #7
;	lib/oled.c: 383: if(pages > 7) pages = 7;
	ld	xl, a
	cp	a, #0x07
	jrule	00102$
	ld	a, #0x07
	ld	xl, a
00102$:
;	lib/oled.c: 384: if(speed > 7) speed = 7;
	ld	a, (0x0a, sp)
	cp	a, #0x07
	jrule	00104$
	ld	a, #0x07
	ld	(0x0a, sp), a
00104$:
;	lib/oled.c: 386: unsigned char cmd[] = {
	ld	a, #0x27
	ld	(0x01, sp), a
	clr	(0x02, sp)
	clr	(0x03, sp)
	ld	a, (0x0a, sp)
	ld	(0x04, sp), a
	ld	a, xl
	dec	a
	ld	(0x05, sp), a
	clr	(0x06, sp)
	ld	a, #0xff
	ld	(0x07, sp), a
;	lib/oled.c: 395: oled_write_cmd_multi(cmd, 7);
	ld	a, #0x07
	ldw	x, sp
	incw	x
	call	_oled_write_cmd_multi
;	lib/oled.c: 396: oled_write_cmd(0x2F);   // Activate scroll
	ld	a, #0x2f
	call	_oled_write_cmd
;	lib/oled.c: 397: }
	addw	sp, #7
	popw	x
	pop	a
	jp	(x)
;	lib/oled.c: 399: void oled_scroll_stop(void)
;	-----------------------------------------
;	 function oled_scroll_stop
;	-----------------------------------------
_oled_scroll_stop:
;	lib/oled.c: 401: oled_write_cmd(0x2E);   // Deactivate scroll
	ld	a, #0x2e
;	lib/oled.c: 402: }
	jp	_oled_write_cmd
;	lib/oled.c: 404: void oled_print_number(unsigned int num)
;	-----------------------------------------
;	 function oled_print_number
;	-----------------------------------------
_oled_print_number:
	sub	sp, #9
;	lib/oled.c: 409: if(num == 0) {
	ldw	(0x07, sp), x
	jrne	00113$
;	lib/oled.c: 410: oled_putc('0');
	ld	a, #0x30
	call	_oled_putc
;	lib/oled.c: 411: return;
	jra	00109$
;	lib/oled.c: 414: while(num > 0) {
00113$:
	clr	a
00103$:
	ldw	x, (0x07, sp)
	jreq	00115$
;	lib/oled.c: 415: buffer[i++] = (num % 10) + '0';
	ldw	x, sp
	incw	x
	pushw	x
	clrw	x
	ld	xl, a
	addw	x, (1, sp)
	addw	sp, #2
	inc	a
	pushw	x
	ldw	x, (0x09, sp)
	ldw	y, #0x000a
	divw	x, y
	popw	x
	addw	y, #48
	push	a
	ld	a, yl
	ld	(x), a
	pop	a
;	lib/oled.c: 416: num /= 10;
	ldw	x, (0x07, sp)
	ldw	y, #0x000a
	divw	x, y
	ldw	(0x07, sp), x
	jra	00103$
;	lib/oled.c: 419: while(i > 0) {
00115$:
	ld	(0x09, sp), a
00106$:
	tnz	(0x09, sp)
	jreq	00109$
;	lib/oled.c: 420: oled_putc(buffer[--i]);
	dec	(0x09, sp)
	clrw	x
	ld	a, (0x09, sp)
	ld	xl, a
	pushw	x
	ldw	x, sp
	addw	x, #3
	addw	x, (1, sp)
	addw	sp, #2
	ld	a, (x)
	call	_oled_putc
	jra	00106$
00109$:
;	lib/oled.c: 422: }
	addw	sp, #9
	ret
;	lib/oled.c: 424: void oled_print_hex(unsigned char num)
;	-----------------------------------------
;	 function oled_print_hex
;	-----------------------------------------
_oled_print_hex:
	push	a
;	lib/oled.c: 426: unsigned char high = (num >> 4) & 0x0F;
	ld	xl, a
	swap	a
	and	a, #15
;	lib/oled.c: 427: unsigned char low = num & 0x0F;
	push	a
	ld	a, xl
	and	a, #0x0f
	ld	(0x02, sp), a
	pop	a
;	lib/oled.c: 429: oled_putc(high < 10 ? high + '0' : high - 10 + 'A');
	ld	xl, a
	cp	a, #0x0a
	jrnc	00103$
	ld	a, xl
	add	a, #0x30
	jra	00104$
00103$:
	ld	a, xl
	add	a, #0x37
00104$:
	call	_oled_putc
;	lib/oled.c: 430: oled_putc(low < 10 ? low + '0' : low - 10 + 'A');
	ld	a, (0x01, sp)
	push	a
	ld	a, (0x02, sp)
	cp	a, #0x0a
	pop	a
	jrnc	00105$
	add	a, #0x30
	jra	00106$
00105$:
	add	a, #0x37
00106$:
	addw	sp, #1
	jp	_oled_putc
;	lib/oled.c: 431: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area CONST
_font_6x8:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x7f	; 127
	.db #0x14	; 20
	.db #0x7f	; 127
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x2a	; 42
	.db #0x7f	; 127
	.db #0x2a	; 42
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x23	; 35
	.db #0x13	; 19
	.db #0x08	; 8
	.db #0x64	; 100	'd'
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x49	; 73	'I'
	.db #0x55	; 85	'U'
	.db #0x22	; 34
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x3e	; 62
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x3e	; 62
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x51	; 81	'Q'
	.db #0x49	; 73	'I'
	.db #0x45	; 69	'E'
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x61	; 97	'a'
	.db #0x51	; 81	'Q'
	.db #0x49	; 73	'I'
	.db #0x46	; 70	'F'
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x41	; 65	'A'
	.db #0x45	; 69	'E'
	.db #0x4b	; 75	'K'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x14	; 20
	.db #0x12	; 18
	.db #0x7f	; 127
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x39	; 57	'9'
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x4a	; 74	'J'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x71	; 113	'q'
	.db #0x09	; 9
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x29	; 41
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x56	; 86	'V'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x22	; 34
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x51	; 81	'Q'
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x32	; 50	'2'
	.db #0x49	; 73	'I'
	.db #0x79	; 121	'y'
	.db #0x41	; 65	'A'
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x41	; 65	'A'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x7a	; 122	'z'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x3f	; 63
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x22	; 34
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x02	; 2
	.db #0x0c	; 12
	.db #0x02	; 2
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x41	; 65	'A'
	.db #0x51	; 81	'Q'
	.db #0x21	; 33
	.db #0x5e	; 94
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x09	; 9
	.db #0x19	; 25
	.db #0x29	; 41
	.db #0x46	; 70	'F'
	.db #0x00	; 0
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x7f	; 127
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x38	; 56	'8'
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x51	; 81	'Q'
	.db #0x49	; 73	'I'
	.db #0x45	; 69	'E'
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x48	; 72	'H'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x48	; 72	'H'
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x7e	; 126
	.db #0x09	; 9
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x52	; 82	'R'
	.db #0x52	; 82	'R'
	.db #0x52	; 82	'R'
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x7d	; 125
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x44	; 68	'D'
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x18	; 24
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x3f	; 63
	.db #0x44	; 68	'D'
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x40	; 64
	.db #0x30	; 48	'0'
	.db #0x40	; 64
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x64	; 100	'd'
	.db #0x54	; 84	'T'
	.db #0x4c	; 76	'L'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x36	; 54	'6'
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x36	; 54	'6'
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x2a	; 42
	.db #0x1c	; 28
	.db #0x08	; 8
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.area CODE
	.area INITIALIZER
__xinit__oled_cursor_x:
	.db #0x00	; 0
__xinit__oled_cursor_y:
	.db #0x00	; 0
__xinit__oled_current_font:
	.db #0x01	; 1
	.area CABS (ABS)
