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
      0087F6                         59 _i2c_init:
      0087F6 88               [ 1]   60 	push	a
                                     61 ;	lib/i2c.c: 14: unsigned char freq_mhz = freq_hz / 1000000;
      0087F7 4B 40            [ 1]   62 	push	#0x40
      0087F9 4B 42            [ 1]   63 	push	#0x42
      0087FB 4B 0F            [ 1]   64 	push	#0x0f
      0087FD 4B 00            [ 1]   65 	push	#0x00
      0087FF 1E 0A            [ 2]   66 	ldw	x, (0x0a, sp)
      008801 89               [ 2]   67 	pushw	x
      008802 1E 0A            [ 2]   68 	ldw	x, (0x0a, sp)
      008804 89               [ 2]   69 	pushw	x
      008805 CD 8F 50         [ 4]   70 	call	__divulong
      008808 5B 08            [ 2]   71 	addw	sp, #8
      00880A 9F               [ 1]   72 	ld	a, xl
      00880B 6B 01            [ 1]   73 	ld	(0x01, sp), a
                                     74 ;	lib/i2c.c: 17: CLK_PCKENR1 |= (1 << 0);
      00880D 72 10 50 C7      [ 1]   75 	bset	0x50c7, #0
                                     76 ;	lib/i2c.c: 20: I2C_FREQR = freq_mhz;
      008811 AE 52 12         [ 2]   77 	ldw	x, #0x5212
      008814 7B 01            [ 1]   78 	ld	a, (0x01, sp)
      008816 F7               [ 1]   79 	ld	(x), a
                                     80 ;	lib/i2c.c: 23: if(speed_hz <= 100000) {
      008817 AE 86 A0         [ 2]   81 	ldw	x, #0x86a0
      00881A 13 0A            [ 2]   82 	cpw	x, (0x0a, sp)
      00881C A6 01            [ 1]   83 	ld	a, #0x01
      00881E 12 09            [ 1]   84 	sbc	a, (0x09, sp)
      008820 4F               [ 1]   85 	clr	a
      008821 12 08            [ 1]   86 	sbc	a, (0x08, sp)
      008823 25 1F            [ 1]   87 	jrc	00102$
                                     88 ;	lib/i2c.c: 25: ccr_value = (freq_hz / (2 * speed_hz));
      008825 1E 0A            [ 2]   89 	ldw	x, (0x0a, sp)
      008827 16 08            [ 2]   90 	ldw	y, (0x08, sp)
      008829 58               [ 2]   91 	sllw	x
      00882A 90 59            [ 2]   92 	rlcw	y
      00882C 89               [ 2]   93 	pushw	x
      00882D 90 89            [ 2]   94 	pushw	y
      00882F 1E 0A            [ 2]   95 	ldw	x, (0x0a, sp)
      008831 89               [ 2]   96 	pushw	x
      008832 1E 0A            [ 2]   97 	ldw	x, (0x0a, sp)
      008834 89               [ 2]   98 	pushw	x
      008835 CD 8F 50         [ 4]   99 	call	__divulong
      008838 5B 08            [ 2]  100 	addw	sp, #8
      00883A 9F               [ 1]  101 	ld	a, xl
                                    102 ;	lib/i2c.c: 26: I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
      00883B C7 52 1B         [ 1]  103 	ld	0x521b, a
                                    104 ;	lib/i2c.c: 27: I2C_CCRH = 0x00;
      00883E 35 00 52 1C      [ 1]  105 	mov	0x521c+0, #0x00
      008842 20 27            [ 2]  106 	jra	00103$
      008844                        107 00102$:
                                    108 ;	lib/i2c.c: 30: ccr_value = (freq_hz / (3 * speed_hz));
      008844 1E 0A            [ 2]  109 	ldw	x, (0x0a, sp)
      008846 89               [ 2]  110 	pushw	x
      008847 1E 0A            [ 2]  111 	ldw	x, (0x0a, sp)
      008849 89               [ 2]  112 	pushw	x
      00884A 4B 03            [ 1]  113 	push	#0x03
      00884C 5F               [ 1]  114 	clrw	x
      00884D 89               [ 2]  115 	pushw	x
      00884E 4B 00            [ 1]  116 	push	#0x00
      008850 CD 8F BB         [ 4]  117 	call	__mullong
      008853 5B 08            [ 2]  118 	addw	sp, #8
      008855 89               [ 2]  119 	pushw	x
      008856 90 89            [ 2]  120 	pushw	y
      008858 1E 0A            [ 2]  121 	ldw	x, (0x0a, sp)
      00885A 89               [ 2]  122 	pushw	x
      00885B 1E 0A            [ 2]  123 	ldw	x, (0x0a, sp)
      00885D 89               [ 2]  124 	pushw	x
      00885E CD 8F 50         [ 4]  125 	call	__divulong
      008861 5B 08            [ 2]  126 	addw	sp, #8
      008863 9F               [ 1]  127 	ld	a, xl
                                    128 ;	lib/i2c.c: 31: I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
      008864 C7 52 1B         [ 1]  129 	ld	0x521b, a
                                    130 ;	lib/i2c.c: 32: I2C_CCRH = 0x80;  // Fast mode
      008867 35 80 52 1C      [ 1]  131 	mov	0x521c+0, #0x80
      00886B                        132 00103$:
                                    133 ;	lib/i2c.c: 36: I2C_TRISER = freq_mhz + 1;
      00886B 7B 01            [ 1]  134 	ld	a, (0x01, sp)
      00886D 4C               [ 1]  135 	inc	a
      00886E C7 52 1D         [ 1]  136 	ld	0x521d, a
                                    137 ;	lib/i2c.c: 39: PB_DDR |= (1 << 4) | (1 << 5);   // Output
      008871 C6 50 07         [ 1]  138 	ld	a, 0x5007
      008874 AA 30            [ 1]  139 	or	a, #0x30
      008876 C7 50 07         [ 1]  140 	ld	0x5007, a
                                    141 ;	lib/i2c.c: 40: PB_CR1 |= (1 << 4) | (1 << 5);   // Pull-up enabled
      008879 C6 50 08         [ 1]  142 	ld	a, 0x5008
      00887C AA 30            [ 1]  143 	or	a, #0x30
      00887E C7 50 08         [ 1]  144 	ld	0x5008, a
                                    145 ;	lib/i2c.c: 41: PB_CR2 &= ~((1 << 4) | (1 << 5)); // Slow speed
      008881 C6 50 09         [ 1]  146 	ld	a, 0x5009
      008884 A4 CF            [ 1]  147 	and	a, #0xcf
      008886 C7 50 09         [ 1]  148 	ld	0x5009, a
                                    149 ;	lib/i2c.c: 44: I2C_CR1 |= I2C_PE;
      008889 C6 52 10         [ 1]  150 	ld	a, 0x5210
      00888C AA 01            [ 1]  151 	or	a, #0x01
      00888E C7 52 10         [ 1]  152 	ld	0x5210, a
                                    153 ;	lib/i2c.c: 45: }
      008891 1E 02            [ 2]  154 	ldw	x, (2, sp)
      008893 5B 0B            [ 2]  155 	addw	sp, #11
      008895 FC               [ 2]  156 	jp	(x)
                                    157 ;	lib/i2c.c: 47: void i2c_start(void)
                                    158 ;	-----------------------------------------
                                    159 ;	 function i2c_start
                                    160 ;	-----------------------------------------
      008896                        161 _i2c_start:
                                    162 ;	lib/i2c.c: 49: I2C_CR2 |= I2C_START;
      008896 72 10 52 11      [ 1]  163 	bset	0x5211, #0
                                    164 ;	lib/i2c.c: 50: while (!(I2C_SR1 & I2C_SB));
      00889A                        165 00101$:
      00889A 72 01 52 17 FB   [ 2]  166 	btjf	0x5217, #0, 00101$
                                    167 ;	lib/i2c.c: 51: }
      00889F 81               [ 4]  168 	ret
                                    169 ;	lib/i2c.c: 53: void i2c_stop(void)
                                    170 ;	-----------------------------------------
                                    171 ;	 function i2c_stop
                                    172 ;	-----------------------------------------
      0088A0                        173 _i2c_stop:
                                    174 ;	lib/i2c.c: 55: I2C_CR2 |= I2C_STOP;
      0088A0 72 12 52 11      [ 1]  175 	bset	0x5211, #1
                                    176 ;	lib/i2c.c: 56: while (I2C_SR3 & 0x01);  // Wait for MSL bit to clear
      0088A4                        177 00101$:
      0088A4 72 00 52 19 FB   [ 2]  178 	btjt	0x5219, #0, 00101$
                                    179 ;	lib/i2c.c: 57: }
      0088A9 81               [ 4]  180 	ret
                                    181 ;	lib/i2c.c: 59: void i2c_write(unsigned char data)
                                    182 ;	-----------------------------------------
                                    183 ;	 function i2c_write
                                    184 ;	-----------------------------------------
      0088AA                        185 _i2c_write:
                                    186 ;	lib/i2c.c: 61: I2C_DR = data;
      0088AA C7 52 16         [ 1]  187 	ld	0x5216, a
                                    188 ;	lib/i2c.c: 62: while (!(I2C_SR1 & I2C_TXE));
      0088AD                        189 00101$:
      0088AD C6 52 17         [ 1]  190 	ld	a, 0x5217
      0088B0 2A FB            [ 1]  191 	jrpl	00101$
                                    192 ;	lib/i2c.c: 63: }
      0088B2 81               [ 4]  193 	ret
                                    194 ;	lib/i2c.c: 65: void i2c_send_addr(unsigned char addr)
                                    195 ;	-----------------------------------------
                                    196 ;	 function i2c_send_addr
                                    197 ;	-----------------------------------------
      0088B3                        198 _i2c_send_addr:
                                    199 ;	lib/i2c.c: 67: i2c_write(addr);
      0088B3 CD 88 AA         [ 4]  200 	call	_i2c_write
                                    201 ;	lib/i2c.c: 68: while (!(I2C_SR3 & 0x01));  // Check master mode
      0088B6                        202 00101$:
      0088B6 72 01 52 19 FB   [ 2]  203 	btjf	0x5219, #0, 00101$
                                    204 ;	lib/i2c.c: 69: }
      0088BB 81               [ 4]  205 	ret
                                    206 ;	lib/i2c.c: 71: unsigned char i2c_write_data(unsigned char addr, unsigned char* data, unsigned char len)
                                    207 ;	-----------------------------------------
                                    208 ;	 function i2c_write_data
                                    209 ;	-----------------------------------------
      0088BC                        210 _i2c_write_data:
      0088BC 52 03            [ 2]  211 	sub	sp, #3
      0088BE 1F 01            [ 2]  212 	ldw	(0x01, sp), x
                                    213 ;	lib/i2c.c: 76: i2c_start();
      0088C0 88               [ 1]  214 	push	a
      0088C1 CD 88 96         [ 4]  215 	call	_i2c_start
      0088C4 84               [ 1]  216 	pop	a
                                    217 ;	lib/i2c.c: 77: i2c_send_addr(addr);
      0088C5 CD 88 B3         [ 4]  218 	call	_i2c_send_addr
                                    219 ;	lib/i2c.c: 80: for(i = 0; i < len; i++) {
      0088C8 0F 03            [ 1]  220 	clr	(0x03, sp)
      0088CA                        221 00106$:
      0088CA 7B 03            [ 1]  222 	ld	a, (0x03, sp)
      0088CC 11 06            [ 1]  223 	cp	a, (0x06, sp)
      0088CE 24 14            [ 1]  224 	jrnc	00104$
                                    225 ;	lib/i2c.c: 81: i2c_write(data[i]);
      0088D0 5F               [ 1]  226 	clrw	x
      0088D1 7B 03            [ 1]  227 	ld	a, (0x03, sp)
      0088D3 97               [ 1]  228 	ld	xl, a
      0088D4 72 FB 01         [ 2]  229 	addw	x, (0x01, sp)
      0088D7 F6               [ 1]  230 	ld	a, (x)
      0088D8 CD 88 AA         [ 4]  231 	call	_i2c_write
                                    232 ;	lib/i2c.c: 82: while (!(I2C_SR1 & I2C_BTF));
      0088DB                        233 00101$:
      0088DB 72 05 52 17 FB   [ 2]  234 	btjf	0x5217, #2, 00101$
                                    235 ;	lib/i2c.c: 80: for(i = 0; i < len; i++) {
      0088E0 0C 03            [ 1]  236 	inc	(0x03, sp)
      0088E2 20 E6            [ 2]  237 	jra	00106$
      0088E4                        238 00104$:
                                    239 ;	lib/i2c.c: 86: i2c_stop();
      0088E4 CD 88 A0         [ 4]  240 	call	_i2c_stop
                                    241 ;	lib/i2c.c: 88: return I2C_OK;
      0088E7 4F               [ 1]  242 	clr	a
                                    243 ;	lib/i2c.c: 89: }
      0088E8 5B 03            [ 2]  244 	addw	sp, #3
      0088EA 85               [ 2]  245 	popw	x
      0088EB 5B 01            [ 2]  246 	addw	sp, #1
      0088ED FC               [ 2]  247 	jp	(x)
                                    248 ;	lib/i2c.c: 91: unsigned char i2c_read_data(unsigned char addr, unsigned char* buffer, unsigned char len)
                                    249 ;	-----------------------------------------
                                    250 ;	 function i2c_read_data
                                    251 ;	-----------------------------------------
      0088EE                        252 _i2c_read_data:
      0088EE 52 05            [ 2]  253 	sub	sp, #5
      0088F0 1F 03            [ 2]  254 	ldw	(0x03, sp), x
                                    255 ;	lib/i2c.c: 95: if(len == 0) return I2C_OK;
      0088F2 0D 08            [ 1]  256 	tnz	(0x08, sp)
      0088F4 26 03            [ 1]  257 	jrne	00102$
      0088F6 4F               [ 1]  258 	clr	a
      0088F7 20 48            [ 2]  259 	jra	00113$
      0088F9                        260 00102$:
                                    261 ;	lib/i2c.c: 98: i2c_start();
      0088F9 88               [ 1]  262 	push	a
      0088FA CD 88 96         [ 4]  263 	call	_i2c_start
      0088FD 84               [ 1]  264 	pop	a
                                    265 ;	lib/i2c.c: 99: i2c_send_addr(addr | 0x01);  // Set read bit
      0088FE AA 01            [ 1]  266 	or	a, #0x01
      008900 CD 88 B3         [ 4]  267 	call	_i2c_send_addr
                                    268 ;	lib/i2c.c: 102: for(i = 0; i < len; i++) {
      008903 0F 05            [ 1]  269 	clr	(0x05, sp)
      008905                        270 00111$:
      008905 7B 05            [ 1]  271 	ld	a, (0x05, sp)
      008907 11 08            [ 1]  272 	cp	a, (0x08, sp)
      008909 24 32            [ 1]  273 	jrnc	00109$
                                    274 ;	lib/i2c.c: 103: if(i == (len - 1)) {
      00890B 5F               [ 1]  275 	clrw	x
      00890C 7B 08            [ 1]  276 	ld	a, (0x08, sp)
      00890E 97               [ 1]  277 	ld	xl, a
      00890F 5A               [ 2]  278 	decw	x
      008910 1F 01            [ 2]  279 	ldw	(0x01, sp), x
      008912 5F               [ 1]  280 	clrw	x
      008913 7B 05            [ 1]  281 	ld	a, (0x05, sp)
      008915 97               [ 1]  282 	ld	xl, a
                                    283 ;	lib/i2c.c: 105: I2C_CR2 &= ~I2C_ACK;
      008916 C6 52 11         [ 1]  284 	ld	a, 0x5211
                                    285 ;	lib/i2c.c: 103: if(i == (len - 1)) {
      008919 13 01            [ 2]  286 	cpw	x, (0x01, sp)
      00891B 26 07            [ 1]  287 	jrne	00104$
                                    288 ;	lib/i2c.c: 105: I2C_CR2 &= ~I2C_ACK;
      00891D A4 FB            [ 1]  289 	and	a, #0xfb
      00891F C7 52 11         [ 1]  290 	ld	0x5211, a
      008922 20 05            [ 2]  291 	jra	00106$
      008924                        292 00104$:
                                    293 ;	lib/i2c.c: 108: I2C_CR2 |= I2C_ACK;
      008924 AA 04            [ 1]  294 	or	a, #0x04
      008926 C7 52 11         [ 1]  295 	ld	0x5211, a
                                    296 ;	lib/i2c.c: 111: while (!(I2C_SR1 & I2C_RXNE));
      008929                        297 00106$:
      008929 72 0D 52 17 FB   [ 2]  298 	btjf	0x5217, #6, 00106$
                                    299 ;	lib/i2c.c: 112: buffer[i] = I2C_DR;
      00892E 5F               [ 1]  300 	clrw	x
      00892F 7B 05            [ 1]  301 	ld	a, (0x05, sp)
      008931 97               [ 1]  302 	ld	xl, a
      008932 72 FB 03         [ 2]  303 	addw	x, (0x03, sp)
      008935 C6 52 16         [ 1]  304 	ld	a, 0x5216
      008938 F7               [ 1]  305 	ld	(x), a
                                    306 ;	lib/i2c.c: 102: for(i = 0; i < len; i++) {
      008939 0C 05            [ 1]  307 	inc	(0x05, sp)
      00893B 20 C8            [ 2]  308 	jra	00111$
      00893D                        309 00109$:
                                    310 ;	lib/i2c.c: 116: i2c_stop();
      00893D CD 88 A0         [ 4]  311 	call	_i2c_stop
                                    312 ;	lib/i2c.c: 118: return I2C_OK;
      008940 4F               [ 1]  313 	clr	a
      008941                        314 00113$:
                                    315 ;	lib/i2c.c: 119: }
      008941 5B 05            [ 2]  316 	addw	sp, #5
      008943 85               [ 2]  317 	popw	x
      008944 5B 01            [ 2]  318 	addw	sp, #1
      008946 FC               [ 2]  319 	jp	(x)
                                    320 ;	lib/i2c.c: 121: void i2c_reset(void)
                                    321 ;	-----------------------------------------
                                    322 ;	 function i2c_reset
                                    323 ;	-----------------------------------------
      008947                        324 _i2c_reset:
                                    325 ;	lib/i2c.c: 124: I2C_CR1 &= ~I2C_PE;
      008947 72 11 52 10      [ 1]  326 	bres	0x5210, #0
                                    327 ;	lib/i2c.c: 127: I2C_CR2 |= I2C_SWRST;
      00894B C6 52 11         [ 1]  328 	ld	a, 0x5211
      00894E AA 80            [ 1]  329 	or	a, #0x80
      008950 C7 52 11         [ 1]  330 	ld	0x5211, a
                                    331 ;	lib/i2c.c: 129: for(i = 0; i < 100; i++) nop();
      008953 AE 00 64         [ 2]  332 	ldw	x, #0x0064
      008956                        333 00104$:
      008956 9D               [ 1]  334 	nop
      008957 5A               [ 2]  335 	decw	x
      008958 26 FC            [ 1]  336 	jrne	00104$
                                    337 ;	lib/i2c.c: 130: I2C_CR2 &= ~I2C_SWRST;
      00895A 72 1F 52 11      [ 1]  338 	bres	0x5211, #7
                                    339 ;	lib/i2c.c: 133: I2C_CR1 |= I2C_PE;
      00895E 72 10 52 10      [ 1]  340 	bset	0x5210, #0
                                    341 ;	lib/i2c.c: 134: }
      008962 81               [ 4]  342 	ret
                                    343 	.area CODE
                                    344 	.area CONST
                                    345 	.area INITIALIZER
                                    346 	.area CABS (ABS)
