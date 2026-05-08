/*
 * oled.h - OLED Library for SSD1306 128x32 I2C
 */

#ifndef _OLED_H
#define _OLED_H

/*=============================================
                OLED Defines
===============================================*/
// OLED dimensions
#define OLED_WIDTH     128
#define OLED_HEIGHT    32
#define OLED_PAGES     4      // Height / 8

// OLED I2C address
#define OLED_ADDR      0x78   // 8-bit write address (0x3C << 1)

// OLED colors
#define OLED_BLACK     0
#define OLED_WHITE     1

// Font sizes (最小可读字体是 5x7，但使用 6x8 更好显示)
#define FONT_5X7       0      // 5x7 pixels - Minimum readable font
#define FONT_6X8       1      // 6x8 pixels - Standard small font (recommended)
#define FONT_8X8       2      // 8x8 pixels - Medium font
#define FONT_8X16      3      // 8x16 pixels - Large font

// Font size specifications
// FONT_5X7:  每个字符 5x7 像素，每行 25 字符 (128/5≈25)，可显示 4 行
// FONT_6X8:  每个字符 6x8 像素，每行 21 字符 (128/6≈21)，可显示 4 行
// FONT_8X8:  每个字符 8x8 像素，每行 16 字符 (128/8=16)，可显示 4 行
// FONT_8X16: 每个字符 8x16 像素，每行 16 字符 (128/8=16)，可显示 2 行

/*=============================================
                Function Prototypes
===============================================*/
// Initialization
void oled_init(void);
void oled_deinit(void);

// Basic operations
void oled_clear(void);
void oled_clear_page(unsigned char page);
void oled_update(void);

// Drawing primitives
void oled_set_pixel(unsigned char x, unsigned char y, unsigned char color);
void oled_draw_line(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char color);
void oled_draw_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color);
void oled_fill_rect(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char color);
void oled_draw_circle(unsigned char x, unsigned char y, unsigned char r, unsigned char color);

// Text functions
void oled_gotoxy(unsigned char x, unsigned char y);
void oled_putc(char c);
void oled_puts(const char* str);
void oled_puts_at(unsigned char x, unsigned char y, const char* str);
void oled_set_font(unsigned char font_size);  // Select font: FONT_5X7, FONT_6X8, FONT_8X8, FONT_8X16

// Advanced functions
void oled_draw_bitmap(const unsigned char* bitmap, unsigned char x, unsigned char y, 
                      unsigned char w, unsigned char h);
void oled_invert(void);
void oled_normal(void);
void oled_set_contrast(unsigned char contrast);
void oled_scroll_left(unsigned char pages, unsigned char speed);
void oled_scroll_right(unsigned char pages, unsigned char speed);
void oled_scroll_stop(void);

// Helper functions
void oled_write_char(unsigned char x, unsigned char y, char c);
void oled_print_number(unsigned int num);
void oled_print_hex(unsigned char num);

#endif /* _OLED_H */

/*=============================================
                Examples Usage 
===============================================

=== FONT SIZE EXAMPLES ===

// Example: Use minimum 5x7 font (smallest)
oled_set_font(FONT_5X7);
oled_puts_at(0, 0, "5x7 Font - 25 chars/line");
oled_puts_at(0, 8, "Line 2 - Very small but");
oled_puts_at(0, 16, "can fit more text per");
oled_puts_at(0, 24, "line (25 characters)");

// Example: Use standard 6x8 font (recommended for 128x32)
oled_set_font(FONT_6X8);
oled_puts_at(0, 0, "6x8 Font - 21 chars/line");
oled_puts_at(0, 8, "Best balance for 128x32");
oled_puts_at(0, 16, "Readable and efficient");
oled_puts_at(0, 24, "4 lines total");

// Example: Use 8x8 font (medium, very readable)
oled_set_font(FONT_8X8);
oled_puts_at(0, 0, "8x8 Font - 16c/line");
oled_puts_at(0, 8, "More readable but");
oled_puts_at(0, 16, "less characters per");
oled_puts_at(0, 24, "line: 16 chars");

// Example: Use 8x16 font (large, high visibility)
oled_set_font(FONT_8X16);
oled_puts_at(0, 0, "8x16 - Big!");
oled_puts_at(0, 16, "Only 2 lines");

// Example: Mix different font sizes
oled_init();
oled_clear();
oled_set_font(FONT_8X16);        // Large title
oled_puts_at(0, 0, "STATUS");
oled_set_font(FONT_5X7);         // Small details
oled_puts_at(0, 20, "Temp:25C V:3.3V");
oled_set_font(FONT_6X8);         // Standard content
oled_puts_at(0, 28, "System OK");

// Example: Dynamic font based on message importance
void show_message(const char* msg, unsigned char important) {
    if(important) {
        oled_set_font(FONT_8X16);
        oled_puts_at(0, 8, msg);
    } else {
        oled_set_font(FONT_6X8);
        oled_puts_at(0, 16, msg);
    }
}

=== BASIC FUNCTIONS ===

Example 1: Initialize and show text
 oled_init();
 oled_clear();
 oled_set_font(FONT_6X8);
 oled_puts_at(0, 0, "System Ready!")
 
Example 2: Show multiple lines
 oled_clear();
 oled_puts_at(0, 0, "Line 1");
 oled_puts_at(0, 8, "Line 2");
 oled_puts_at(0, 16, "Line 3");
 oled_puts_at(0, 24, "Line 4")
 
Example 3: Using cursor position
 oled_gotoxy(30, 16);
 oled_puts("Hello World!")
 
Example 4: Draw shapes
 oled_clear();
 oled_draw_rect(10, 5, 50, 22, OLED_WHITE);     // Draw rectangle
 oled_fill_rect(65, 5, 30, 22, OLED_WHITE);     // Fill rectangle
 oled_draw_circle(110, 16, 8, OLED_WHITE);      // Draw circl
 
Example 5: Draw line
 oled_clear();
 oled_draw_line(0, 0, 127, 31, OLED_WHITE);     // Diagonal line
 oled_draw_line(64, 0, 64, 31, OLED_WHITE);     // Vertical lin
 
Example 6: Set individual pixels
 oled_clear();
 oled_set_pixel(64, 16, OLED_WHITE);            // Single pixel
 oled_set_pixel(65, 16, OLED_WHITE);
 oled_set_pixel(64, 17, OLED_WHITE)
 
Example 7: Clear specific page
 oled_clear();                                   // Clear all
 oled_puts_at(0, 0, "Page 0");
 oled_puts_at(0, 24, "Page 3");
 oled_clear_page(0);                            // Clear only page 
 
Example 8: Invert and Normal display
 oled_clear();
 oled_puts_at(0, 0, "Normal Display");
 delay_ms(1000);
 oled_invert();                                  // Invert colors
 delay_ms(1000);
 oled_normal();                                  // Back to norma
 
Example 9: Adjust contrast
 oled_set_contrast(0x00);      // Minimum contrast
 oled_set_contrast(0x7F);      // Medium contrast
 oled_set_contrast(0xFF);      // Maximum contras
 
Example 10: Scroll text
 oled_clear();
 oled_puts_at(0, 0, "Scrolling Text");
 oled_scroll_left(4, 5);        // Scroll all 4 pages, speed 5
 delay_ms(3000);
 oled_scroll_stop();             // Stop scrollin
 
Example 11: Print numbers
 unsigned int counter = 0;
 oled_gotoxy(0, 0);
 oled_puts("Count: ");
 oled_print_number(counter);     // Displays "Count: 0
 
Example 12: Print HEX values
 unsigned char value = 0xAB;
 oled_gotoxy(0, 0);
 oled_puts("HEX: ");
 oled_print_hex(value);          // Displays "HEX: AB
 
Example 13: Draw bitmap (8x8 smiley)
 const unsigned char smiley[] = {
     0x3C,  // 00111100
     0x42,  // 01000010
     0xA5,  // 10100101
     0x81,  // 10000001
     0xA5,  // 10100101
     0x42,  // 01000010
     0x3C,  // 00111100
     0x00   // 00000000
 };
 oled_draw_bitmap(smiley, 60, 12, 8, 8)
 
Example 14: Combine text and shapes
 oled_clear();
 oled_draw_rect(0, 0, 128, 32, OLED_WHITE);     // Border
 oled_puts_at(10, 12, "STM8S003F3")
 
Example 15: Display UART received data
 if(received == '1') {
     oled_clear();
     oled_puts_at(0, 0, "UART Received:");
     oled_puts_at(0, 16, "Number: 1");
 }
 
Example 16: Show input status
 if(GPIO_Read(INPUT1_PORT, INPUT1_PIN) == 1) {
     oled_gotoxy(0, 24);
     oled_puts("IN1: HIGH");
 } else {
     oled_gotoxy(0, 24);
     oled_puts("IN1: LOW ");
 }
 
Example 17: Create menu system
 oled_clear();
 oled_puts_at(0, 0, "1. Start");
 oled_puts_at(0, 8, "2. Stop");
 oled_puts_at(0, 16, "3. Reset");
 oled_puts_at(0, 24, "4. Config");
 
Example 18: Display sensor value
 unsigned int temperature = 25;
 oled_gotoxy(0, 0);
 oled_puts("Temp: ");
 oled_print_number(temperature);
 oled_puts(" C");
 
Example 19: Animate (simple moving dot)
 for(unsigned char x = 0; x < 128; x++) {
     oled_clear();
     oled_set_pixel(x, 16, OLED_WHITE);
     delay_ms(20);
 }
 
Example 20: Countdown timer
 for(int i = 9; i >= 0; i--) {
     oled_clear();
     oled_gotoxy(60, 12);
     oled_print_number(i);
     delay_ms(1000);
 }
 oled_puts_at(50, 12, "GO!");

=== PRACTICAL APPLICATIONS ===

// Display system status
void show_system_status(unsigned int rpm, unsigned char temperature) {
    oled_clear();
    oled_set_font(FONT_8X16);
    oled_puts_at(0, 0, "STATUS");
    oled_set_font(FONT_6X8);
    oled_puts_at(0, 16, "RPM: ");
    oled_print_number(rpm);
    oled_puts_at(0, 24, "Temp: ");
    oled_print_number(temperature);
    oled_puts(" C");
}

// Show battery level with bar
void show_battery(unsigned char percent) {
    oled_clear();
    oled_draw_rect(10, 12, 108, 8, OLED_WHITE);  // Battery outline
    oled_fill_rect(12, 14, (100 * percent) / 100, 4, OLED_WHITE);  // Fill level
    oled_set_font(FONT_6X8);
    oled_puts_at(0, 0, "Battery: ");
    oled_print_number(percent);
    oled_puts("%");
}

// Display menu with selection
unsigned char current_menu = 0;
void show_menu(void) {
    oled_clear();
    oled_set_font(FONT_6X8);
    const char* menu_items[] = {"Start", "Stop", "Config", "Info"};
    for(unsigned char i = 0; i < 4; i++) {
        oled_gotoxy(10, i*8);
        if(i == current_menu) {
            oled_puts(">");
        } else {
            oled_puts(" ");
        }
        oled_puts(menu_items[i]);
    }
}
*/