                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module i2c
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _i2c_init
                                     11 	.globl _i2c_start
                                     12 	.globl _i2c_stop
                                     13 	.globl _i2c_write
                                     14 	.globl _i2c_send_addr
                                     15 	.globl _i2c_write_data
                                     16 	.globl _i2c_read_data
                                     17 	.globl _i2c_reset
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; absolute external ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DABS (ABS)
                                     30 
                                     31 ; default segment ordering for linker
                                     32 	.area HOME
                                     33 	.area GSINIT
                                     34 	.area GSFINAL
                                     35 	.area CONST
                                     36 	.area INITIALIZER
                                     37 	.area CODE
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; global & static initialisations
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area GSINIT
                                     46 ;--------------------------------------------------------
                                     47 ; Home
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area HOME
                                     51 ;--------------------------------------------------------
                                     52 ; code
                                     53 ;--------------------------------------------------------
                                     54 	.area CODE
                                     55 ;	lib/i2c.c: 11: void i2c_init(unsigned long freq_hz, unsigned long speed_hz)
                                     56 ;	-----------------------------------------
                                     57 ;	 function i2c_init
                                     58 ;	-----------------------------------------
      008737                         59 _i2c_init:
      008737 88               [ 1]   60 	push	a
                                     61 ;	lib/i2c.c: 14: unsigned char freq_mhz = freq_hz / 1000000;
      008738 4B 40            [ 1]   62 	push	#0x40
      00873A 4B 42            [ 1]   63 	push	#0x42
      00873C 4B 0F            [ 1]   64 	push	#0x0f
      00873E 4B 00            [ 1]   65 	push	#0x00
      008740 1E 0A            [ 2]   66 	ldw	x, (0x0a, sp)
      008742 89               [ 2]   67 	pushw	x
      008743 1E 0A            [ 2]   68 	ldw	x, (0x0a, sp)
      008745 89               [ 2]   69 	pushw	x
      008746 CD 8E 4D         [ 4]   70 	call	__divulong
      008749 5B 08            [ 2]   71 	addw	sp, #8
      00874B 9F               [ 1]   72 	ld	a, xl
      00874C 6B 01            [ 1]   73 	ld	(0x01, sp), a
                                     74 ;	lib/i2c.c: 17: CLK_PCKENR1 |= (1 << 0);
      00874E 72 10 50 C7      [ 1]   75 	bset	0x50c7, #0
                                     76 ;	lib/i2c.c: 20: I2C_FREQR = freq_mhz;
      008752 AE 52 12         [ 2]   77 	ldw	x, #0x5212
      008755 7B 01            [ 1]   78 	ld	a, (0x01, sp)
      008757 F7               [ 1]   79 	ld	(x), a
                                     80 ;	lib/i2c.c: 23: if(speed_hz <= 100000) {
      008758 AE 86 A0         [ 2]   81 	ldw	x, #0x86a0
      00875B 13 0A            [ 2]   82 	cpw	x, (0x0a, sp)
      00875D A6 01            [ 1]   83 	ld	a, #0x01
      00875F 12 09            [ 1]   84 	sbc	a, (0x09, sp)
      008761 4F               [ 1]   85 	clr	a
      008762 12 08            [ 1]   86 	sbc	a, (0x08, sp)
      008764 25 1F            [ 1]   87 	jrc	00102$
                                     88 ;	lib/i2c.c: 25: ccr_value = (freq_hz / (2 * speed_hz));
      008766 1E 0A            [ 2]   89 	ldw	x, (0x0a, sp)
      008768 16 08            [ 2]   90 	ldw	y, (0x08, sp)
      00876A 58               [ 2]   91 	sllw	x
      00876B 90 59            [ 2]   92 	rlcw	y
      00876D 89               [ 2]   93 	pushw	x
      00876E 90 89            [ 2]   94 	pushw	y
      008770 1E 0A            [ 2]   95 	ldw	x, (0x0a, sp)
      008772 89               [ 2]   96 	pushw	x
      008773 1E 0A            [ 2]   97 	ldw	x, (0x0a, sp)
      008775 89               [ 2]   98 	pushw	x
      008776 CD 8E 4D         [ 4]   99 	call	__divulong
      008779 5B 08            [ 2]  100 	addw	sp, #8
      00877B 9F               [ 1]  101 	ld	a, xl
                                    102 ;	lib/i2c.c: 26: I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
      00877C C7 52 1B         [ 1]  103 	ld	0x521b, a
                                    104 ;	lib/i2c.c: 27: I2C_CCRH = 0x00;
      00877F 35 00 52 1C      [ 1]  105 	mov	0x521c+0, #0x00
      008783 20 27            [ 2]  106 	jra	00103$
      008785                        107 00102$:
                                    108 ;	lib/i2c.c: 30: ccr_value = (freq_hz / (3 * speed_hz));
      008785 1E 0A            [ 2]  109 	ldw	x, (0x0a, sp)
      008787 89               [ 2]  110 	pushw	x
      008788 1E 0A            [ 2]  111 	ldw	x, (0x0a, sp)
      00878A 89               [ 2]  112 	pushw	x
      00878B 4B 03            [ 1]  113 	push	#0x03
      00878D 5F               [ 1]  114 	clrw	x
      00878E 89               [ 2]  115 	pushw	x
      00878F 4B 00            [ 1]  116 	push	#0x00
      008791 CD 8E B8         [ 4]  117 	call	__mullong
      008794 5B 08            [ 2]  118 	addw	sp, #8
      008796 89               [ 2]  119 	pushw	x
      008797 90 89            [ 2]  120 	pushw	y
      008799 1E 0A            [ 2]  121 	ldw	x, (0x0a, sp)
      00879B 89               [ 2]  122 	pushw	x
      00879C 1E 0A            [ 2]  123 	ldw	x, (0x0a, sp)
      00879E 89               [ 2]  124 	pushw	x
      00879F CD 8E 4D         [ 4]  125 	call	__divulong
      0087A2 5B 08            [ 2]  126 	addw	sp, #8
      0087A4 9F               [ 1]  127 	ld	a, xl
                                    128 ;	lib/i2c.c: 31: I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
      0087A5 C7 52 1B         [ 1]  129 	ld	0x521b, a
                                    130 ;	lib/i2c.c: 32: I2C_CCRH = 0x80;  // Fast mode
      0087A8 35 80 52 1C      [ 1]  131 	mov	0x521c+0, #0x80
      0087AC                        132 00103$:
                                    133 ;	lib/i2c.c: 36: I2C_TRISER = freq_mhz + 1;
      0087AC 7B 01            [ 1]  134 	ld	a, (0x01, sp)
      0087AE 4C               [ 1]  135 	inc	a
      0087AF C7 52 1D         [ 1]  136 	ld	0x521d, a
                                    137 ;	lib/i2c.c: 39: PB_DDR |= (1 << 4) | (1 << 5);   // Output
      0087B2 C6 50 07         [ 1]  138 	ld	a, 0x5007
      0087B5 AA 30            [ 1]  139 	or	a, #0x30
      0087B7 C7 50 07         [ 1]  140 	ld	0x5007, a
                                    141 ;	lib/i2c.c: 40: PB_CR1 |= (1 << 4) | (1 << 5);   // Pull-up enabled
      0087BA C6 50 08         [ 1]  142 	ld	a, 0x5008
      0087BD AA 30            [ 1]  143 	or	a, #0x30
      0087BF C7 50 08         [ 1]  144 	ld	0x5008, a
                                    145 ;	lib/i2c.c: 41: PB_CR2 &= ~((1 << 4) | (1 << 5)); // Slow speed
      0087C2 C6 50 09         [ 1]  146 	ld	a, 0x5009
      0087C5 A4 CF            [ 1]  147 	and	a, #0xcf
      0087C7 C7 50 09         [ 1]  148 	ld	0x5009, a
                                    149 ;	lib/i2c.c: 44: I2C_CR1 |= I2C_PE;
      0087CA C6 52 10         [ 1]  150 	ld	a, 0x5210
      0087CD AA 01            [ 1]  151 	or	a, #0x01
      0087CF C7 52 10         [ 1]  152 	ld	0x5210, a
                                    153 ;	lib/i2c.c: 45: }
      0087D2 1E 02            [ 2]  154 	ldw	x, (2, sp)
      0087D4 5B 0B            [ 2]  155 	addw	sp, #11
      0087D6 FC               [ 2]  156 	jp	(x)
                                    157 ;	lib/i2c.c: 47: void i2c_start(void)
                                    158 ;	-----------------------------------------
                                    159 ;	 function i2c_start
                                    160 ;	-----------------------------------------
      0087D7                        161 _i2c_start:
                                    162 ;	lib/i2c.c: 49: I2C_CR2 |= I2C_START;
      0087D7 72 10 52 11      [ 1]  163 	bset	0x5211, #0
                                    164 ;	lib/i2c.c: 50: while (!(I2C_SR1 & I2C_SB));
      0087DB                        165 00101$:
      0087DB 72 01 52 17 FB   [ 2]  166 	btjf	0x5217, #0, 00101$
                                    167 ;	lib/i2c.c: 51: }
      0087E0 81               [ 4]  168 	ret
                                    169 ;	lib/i2c.c: 53: void i2c_stop(void)
                                    170 ;	-----------------------------------------
                                    171 ;	 function i2c_stop
                                    172 ;	-----------------------------------------
      0087E1                        173 _i2c_stop:
                                    174 ;	lib/i2c.c: 55: I2C_CR2 |= I2C_STOP;
      0087E1 72 12 52 11      [ 1]  175 	bset	0x5211, #1
                                    176 ;	lib/i2c.c: 56: while (I2C_SR3 & 0x01);  // Wait for MSL bit to clear
      0087E5                        177 00101$:
      0087E5 72 00 52 19 FB   [ 2]  178 	btjt	0x5219, #0, 00101$
                                    179 ;	lib/i2c.c: 57: }
      0087EA 81               [ 4]  180 	ret
                                    181 ;	lib/i2c.c: 59: void i2c_write(unsigned char data)
                                    182 ;	-----------------------------------------
                                    183 ;	 function i2c_write
                                    184 ;	-----------------------------------------
      0087EB                        185 _i2c_write:
                                    186 ;	lib/i2c.c: 61: I2C_DR = data;
      0087EB C7 52 16         [ 1]  187 	ld	0x5216, a
                                    188 ;	lib/i2c.c: 62: while (!(I2C_SR1 & I2C_TXE));
      0087EE                        189 00101$:
      0087EE C6 52 17         [ 1]  190 	ld	a, 0x5217
      0087F1 2A FB            [ 1]  191 	jrpl	00101$
                                    192 ;	lib/i2c.c: 63: }
      0087F3 81               [ 4]  193 	ret
                                    194 ;	lib/i2c.c: 65: void i2c_send_addr(unsigned char addr)
                                    195 ;	-----------------------------------------
                                    196 ;	 function i2c_send_addr
                                    197 ;	-----------------------------------------
      0087F4                        198 _i2c_send_addr:
                                    199 ;	lib/i2c.c: 67: i2c_write(addr);
      0087F4 CD 87 EB         [ 4]  200 	call	_i2c_write
                                    201 ;	lib/i2c.c: 68: while (!(I2C_SR3 & 0x01));  // Check master mode
      0087F7                        202 00101$:
      0087F7 72 01 52 19 FB   [ 2]  203 	btjf	0x5219, #0, 00101$
                                    204 ;	lib/i2c.c: 69: }
      0087FC 81               [ 4]  205 	ret
                                    206 ;	lib/i2c.c: 71: unsigned char i2c_write_data(unsigned char addr, unsigned char* data, unsigned char len)
                                    207 ;	-----------------------------------------
                                    208 ;	 function i2c_write_data
                                    209 ;	-----------------------------------------
      0087FD                        210 _i2c_write_data:
      0087FD 52 03            [ 2]  211 	sub	sp, #3
      0087FF 1F 01            [ 2]  212 	ldw	(0x01, sp), x
                                    213 ;	lib/i2c.c: 76: i2c_start();
      008801 88               [ 1]  214 	push	a
      008802 CD 87 D7         [ 4]  215 	call	_i2c_start
      008805 84               [ 1]  216 	pop	a
                                    217 ;	lib/i2c.c: 77: i2c_send_addr(addr);
      008806 CD 87 F4         [ 4]  218 	call	_i2c_send_addr
                                    219 ;	lib/i2c.c: 80: for(i = 0; i < len; i++) {
      008809 0F 03            [ 1]  220 	clr	(0x03, sp)
      00880B                        221 00106$:
      00880B 7B 03            [ 1]  222 	ld	a, (0x03, sp)
      00880D 11 06            [ 1]  223 	cp	a, (0x06, sp)
      00880F 24 14            [ 1]  224 	jrnc	00104$
                                    225 ;	lib/i2c.c: 81: i2c_write(data[i]);
      008811 5F               [ 1]  226 	clrw	x
      008812 7B 03            [ 1]  227 	ld	a, (0x03, sp)
      008814 97               [ 1]  228 	ld	xl, a
      008815 72 FB 01         [ 2]  229 	addw	x, (0x01, sp)
      008818 F6               [ 1]  230 	ld	a, (x)
      008819 CD 87 EB         [ 4]  231 	call	_i2c_write
                                    232 ;	lib/i2c.c: 82: while (!(I2C_SR1 & I2C_BTF));
      00881C                        233 00101$:
      00881C 72 05 52 17 FB   [ 2]  234 	btjf	0x5217, #2, 00101$
                                    235 ;	lib/i2c.c: 80: for(i = 0; i < len; i++) {
      008821 0C 03            [ 1]  236 	inc	(0x03, sp)
      008823 20 E6            [ 2]  237 	jra	00106$
      008825                        238 00104$:
                                    239 ;	lib/i2c.c: 86: i2c_stop();
      008825 CD 87 E1         [ 4]  240 	call	_i2c_stop
                                    241 ;	lib/i2c.c: 88: return I2C_OK;
      008828 4F               [ 1]  242 	clr	a
                                    243 ;	lib/i2c.c: 89: }
      008829 5B 03            [ 2]  244 	addw	sp, #3
      00882B 85               [ 2]  245 	popw	x
      00882C 5B 01            [ 2]  246 	addw	sp, #1
      00882E FC               [ 2]  247 	jp	(x)
                                    248 ;	lib/i2c.c: 91: unsigned char i2c_read_data(unsigned char addr, unsigned char* buffer, unsigned char len)
                                    249 ;	-----------------------------------------
                                    250 ;	 function i2c_read_data
                                    251 ;	-----------------------------------------
      00882F                        252 _i2c_read_data:
      00882F 52 05            [ 2]  253 	sub	sp, #5
      008831 1F 03            [ 2]  254 	ldw	(0x03, sp), x
                                    255 ;	lib/i2c.c: 95: if(len == 0) return I2C_OK;
      008833 0D 08            [ 1]  256 	tnz	(0x08, sp)
      008835 26 03            [ 1]  257 	jrne	00102$
      008837 4F               [ 1]  258 	clr	a
      008838 20 48            [ 2]  259 	jra	00113$
      00883A                        260 00102$:
                                    261 ;	lib/i2c.c: 98: i2c_start();
      00883A 88               [ 1]  262 	push	a
      00883B CD 87 D7         [ 4]  263 	call	_i2c_start
      00883E 84               [ 1]  264 	pop	a
                                    265 ;	lib/i2c.c: 99: i2c_send_addr(addr | 0x01);  // Set read bit
      00883F AA 01            [ 1]  266 	or	a, #0x01
      008841 CD 87 F4         [ 4]  267 	call	_i2c_send_addr
                                    268 ;	lib/i2c.c: 102: for(i = 0; i < len; i++) {
      008844 0F 05            [ 1]  269 	clr	(0x05, sp)
      008846                        270 00111$:
      008846 7B 05            [ 1]  271 	ld	a, (0x05, sp)
      008848 11 08            [ 1]  272 	cp	a, (0x08, sp)
      00884A 24 32            [ 1]  273 	jrnc	00109$
                                    274 ;	lib/i2c.c: 103: if(i == (len - 1)) {
      00884C 5F               [ 1]  275 	clrw	x
      00884D 7B 08            [ 1]  276 	ld	a, (0x08, sp)
      00884F 97               [ 1]  277 	ld	xl, a
      008850 5A               [ 2]  278 	decw	x
      008851 1F 01            [ 2]  279 	ldw	(0x01, sp), x
      008853 5F               [ 1]  280 	clrw	x
      008854 7B 05            [ 1]  281 	ld	a, (0x05, sp)
      008856 97               [ 1]  282 	ld	xl, a
                                    283 ;	lib/i2c.c: 105: I2C_CR2 &= ~I2C_ACK;
      008857 C6 52 11         [ 1]  284 	ld	a, 0x5211
                                    285 ;	lib/i2c.c: 103: if(i == (len - 1)) {
      00885A 13 01            [ 2]  286 	cpw	x, (0x01, sp)
      00885C 26 07            [ 1]  287 	jrne	00104$
                                    288 ;	lib/i2c.c: 105: I2C_CR2 &= ~I2C_ACK;
      00885E A4 FB            [ 1]  289 	and	a, #0xfb
      008860 C7 52 11         [ 1]  290 	ld	0x5211, a
      008863 20 05            [ 2]  291 	jra	00106$
      008865                        292 00104$:
                                    293 ;	lib/i2c.c: 108: I2C_CR2 |= I2C_ACK;
      008865 AA 04            [ 1]  294 	or	a, #0x04
      008867 C7 52 11         [ 1]  295 	ld	0x5211, a
                                    296 ;	lib/i2c.c: 111: while (!(I2C_SR1 & I2C_RXNE));
      00886A                        297 00106$:
      00886A 72 0D 52 17 FB   [ 2]  298 	btjf	0x5217, #6, 00106$
                                    299 ;	lib/i2c.c: 112: buffer[i] = I2C_DR;
      00886F 5F               [ 1]  300 	clrw	x
      008870 7B 05            [ 1]  301 	ld	a, (0x05, sp)
      008872 97               [ 1]  302 	ld	xl, a
      008873 72 FB 03         [ 2]  303 	addw	x, (0x03, sp)
      008876 C6 52 16         [ 1]  304 	ld	a, 0x5216
      008879 F7               [ 1]  305 	ld	(x), a
                                    306 ;	lib/i2c.c: 102: for(i = 0; i < len; i++) {
      00887A 0C 05            [ 1]  307 	inc	(0x05, sp)
      00887C 20 C8            [ 2]  308 	jra	00111$
      00887E                        309 00109$:
                                    310 ;	lib/i2c.c: 116: i2c_stop();
      00887E CD 87 E1         [ 4]  311 	call	_i2c_stop
                                    312 ;	lib/i2c.c: 118: return I2C_OK;
      008881 4F               [ 1]  313 	clr	a
      008882                        314 00113$:
                                    315 ;	lib/i2c.c: 119: }
      008882 5B 05            [ 2]  316 	addw	sp, #5
      008884 85               [ 2]  317 	popw	x
      008885 5B 01            [ 2]  318 	addw	sp, #1
      008887 FC               [ 2]  319 	jp	(x)
                                    320 ;	lib/i2c.c: 121: void i2c_reset(void)
                                    321 ;	-----------------------------------------
                                    322 ;	 function i2c_reset
                                    323 ;	-----------------------------------------
      008888                        324 _i2c_reset:
                                    325 ;	lib/i2c.c: 124: I2C_CR1 &= ~I2C_PE;
      008888 72 11 52 10      [ 1]  326 	bres	0x5210, #0
                                    327 ;	lib/i2c.c: 127: I2C_CR2 |= I2C_SWRST;
      00888C C6 52 11         [ 1]  328 	ld	a, 0x5211
      00888F AA 80            [ 1]  329 	or	a, #0x80
      008891 C7 52 11         [ 1]  330 	ld	0x5211, a
                                    331 ;	lib/i2c.c: 129: for(i = 0; i < 100; i++) nop();
      008894 AE 00 64         [ 2]  332 	ldw	x, #0x0064
      008897                        333 00104$:
      008897 9D               [ 1]  334 	nop
      008898 5A               [ 2]  335 	decw	x
      008899 26 FC            [ 1]  336 	jrne	00104$
                                    337 ;	lib/i2c.c: 130: I2C_CR2 &= ~I2C_SWRST;
      00889B 72 1F 52 11      [ 1]  338 	bres	0x5211, #7
                                    339 ;	lib/i2c.c: 133: I2C_CR1 |= I2C_PE;
      00889F 72 10 52 10      [ 1]  340 	bset	0x5210, #0
                                    341 ;	lib/i2c.c: 134: }
      0088A3 81               [ 4]  342 	ret
                                    343 	.area CODE
                                    344 	.area CONST
                                    345 	.area INITIALIZER
                                    346 	.area CABS (ABS)
