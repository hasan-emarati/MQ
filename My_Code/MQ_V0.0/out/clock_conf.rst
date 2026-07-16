                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module clock_conf
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _clock_init
                                     11 ;--------------------------------------------------------
                                     12 ; ram data
                                     13 ;--------------------------------------------------------
                                     14 	.area DATA
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area INITIALIZED
                                     19 ;--------------------------------------------------------
                                     20 ; absolute external ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DABS (ABS)
                                     23 
                                     24 ; default segment ordering for linker
                                     25 	.area HOME
                                     26 	.area GSINIT
                                     27 	.area GSFINAL
                                     28 	.area CONST
                                     29 	.area INITIALIZER
                                     30 	.area CODE
                                     31 
                                     32 ;--------------------------------------------------------
                                     33 ; global & static initialisations
                                     34 ;--------------------------------------------------------
                                     35 	.area HOME
                                     36 	.area GSINIT
                                     37 	.area GSFINAL
                                     38 	.area GSINIT
                                     39 ;--------------------------------------------------------
                                     40 ; Home
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area HOME
                                     44 ;--------------------------------------------------------
                                     45 ; code
                                     46 ;--------------------------------------------------------
                                     47 	.area CODE
                                     48 ;	lib/clock_conf.c: 4: void clock_init(void)
                                     49 ;	-----------------------------------------
                                     50 ;	 function clock_init
                                     51 ;	-----------------------------------------
      008474                         52 _clock_init:
                                     53 ;	lib/clock_conf.c: 6: CLK_ECKR |= CLK_ECKR_HSEEN;
      008474 72 10 50 C1      [ 1]   54 	bset	0x50c1, #0
                                     55 ;	lib/clock_conf.c: 7: while(!(CLK_ECKR & CLK_ECKR_HSERDY));
      008478                         56 00101$:
      008478 72 03 50 C1 FB   [ 2]   57 	btjf	0x50c1, #1, 00101$
                                     58 ;	lib/clock_conf.c: 9: CLK_SWR = CLK_SWR_HSE;
      00847D 35 B4 50 C4      [ 1]   59 	mov	0x50c4+0, #0xb4
                                     60 ;	lib/clock_conf.c: 10: CLK_SWCR |= CLK_SWCR_SWEN;
      008481 72 12 50 C5      [ 1]   61 	bset	0x50c5, #1
                                     62 ;	lib/clock_conf.c: 11: while(CLK_SWCR & CLK_SWCR_SWBSY);
      008485                         63 00104$:
      008485 72 00 50 C5 FB   [ 2]   64 	btjt	0x50c5, #0, 00104$
                                     65 ;	lib/clock_conf.c: 13: CLK_CKDIVR = 0x00;
      00848A 35 00 50 C6      [ 1]   66 	mov	0x50c6+0, #0x00
                                     67 ;	lib/clock_conf.c: 14: }
      00848E 81               [ 4]   68 	ret
                                     69 	.area CODE
                                     70 	.area CONST
                                     71 	.area INITIALIZER
                                     72 	.area CABS (ABS)
