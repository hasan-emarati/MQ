#include "ssd1306.h"
#include "stm8.h"
#include <string.h>

// External I2C functions (from i2c.c)
extern void i2c_start_(void);
extern void i2c_write_(unsigned char ch);
extern void i2c_addr_(unsigned char addr);
extern void i2c_stop_(void);

// Display buffer (128x64 = 1024 bytes)
static uint8_t display_buffer[SSD1306_WIDTH * SSD1306_HEIGHT / 8];

// 5x8 font data (ASCII 32-127)
static const uint8_t font5x8[][5] = {
    {0x00, 0x00, 0x00, 0x00, 0x00}, // 32 space
    {0x00, 0x00, 0x5F, 0x00, 0x00}, // 33 !
    {0x00, 0x07, 0x00, 0x07, 0x00}, // 34 "
    {0x14, 0x7F, 0x14, 0x7F, 0x14}, // 35 #
    {0x24, 0x2A, 0x7F, 0x2A, 0x12}, // 36 $
    {0x23, 0x13, 0x08, 0x64, 0x62}, // 37 %
    {0x36, 0x49, 0x55, 0x22, 0x50}, // 38 &
    {0x00, 0x05, 0x03, 0x00, 0x00}, // 39 '
    {0x00, 0x1C, 0x22, 0x41, 0x00}, // 40 (
    {0x00, 0x41, 0x22, 0x1C, 0x00}, // 41 )
    {0x14, 0x08, 0x3E, 0x08, 0x14}, // 42 *
    {0x08, 0x08, 0x3E, 0x08, 0x08}, // 43 +
    {0x00, 0x50, 0x30, 0x00, 0x00}, // 44 ,
    {0x08, 0x08, 0x08, 0x08, 0x08}, // 45 -
    {0x00, 0x60, 0x60, 0x00, 0x00}, // 46 .
    {0x20, 0x10, 0x08, 0x04, 0x02}, // 47 /
    {0x3E, 0x51, 0x49, 0x45, 0x3E}, // 48 0
    {0x00, 0x42, 0x7F, 0x40, 0x00}, // 49 1
    {0x42, 0x61, 0x51, 0x49, 0x46}, // 50 2
    {0x21, 0x41, 0x45, 0x4B, 0x31}, // 51 3
    {0x18, 0x14, 0x12, 0x7F, 0x10}, // 52 4
    {0x27, 0x45, 0x45, 0x45, 0x39}, // 53 5
    {0x3C, 0x4A, 0x49, 0x49, 0x30}, // 54 6
    {0x01, 0x71, 0x09, 0x05, 0x03}, // 55 7
    {0x36, 0x49, 0x49, 0x49, 0x36}, // 56 8
    {0x06, 0x49, 0x49, 0x29, 0x1E}, // 57 9
    {0x00, 0x36, 0x36, 0x00, 0x00}, // 58 :
    {0x00, 0x56, 0x36, 0x00, 0x00}, // 59 ;
    {0x08, 0x14, 0x22, 0x41, 0x00}, // 60 <
    {0x14, 0x14, 0x14, 0x14, 0x14}, // 61 =
    {0x00, 0x41, 0x22, 0x14, 0x08}, // 62 >
    {0x02, 0x01, 0x51, 0x09, 0x06}, // 63 ?
    {0x32, 0x49, 0x79, 0x41, 0x3E}, // 64 @
    {0x7E, 0x11, 0x11, 0x11, 0x7E}, // 65 A
    {0x7F, 0x49, 0x49, 0x49, 0x36}, // 66 B
    {0x3E, 0x41, 0x41, 0x41, 0x22}, // 67 C
    {0x7F, 0x41, 0x41, 0x22, 0x1C}, // 68 D
    {0x7F, 0x49, 0x49, 0x49, 0x41}, // 69 E
    {0x7F, 0x09, 0x09, 0x09, 0x01}, // 70 F
    {0x3E, 0x41, 0x49, 0x49, 0x7A}, // 71 G
    {0x7F, 0x08, 0x08, 0x08, 0x7F}, // 72 H
    {0x00, 0x41, 0x7F, 0x41, 0x00}, // 73 I
    {0x20, 0x40, 0x41, 0x3F, 0x01}, // 74 J
    {0x7F, 0x08, 0x14, 0x22, 0x41}, // 75 K
    {0x7F, 0x40, 0x40, 0x40, 0x40}, // 76 L
    {0x7F, 0x02, 0x0C, 0x02, 0x7F}, // 77 M
    {0x7F, 0x04, 0x08, 0x10, 0x7F}, // 78 N
    {0x3E, 0x41, 0x41, 0x41, 0x3E}, // 79 O
    {0x7F, 0x09, 0x09, 0x09, 0x06}, // 80 P
    {0x3E, 0x41, 0x51, 0x21, 0x5E}, // 81 Q
    {0x7F, 0x09, 0x19, 0x29, 0x46}, // 82 R
    {0x46, 0x49, 0x49, 0x49, 0x31}, // 83 S
    {0x01, 0x01, 0x7F, 0x01, 0x01}, // 84 T
    {0x3F, 0x40, 0x40, 0x40, 0x3F}, // 85 U
    {0x1F, 0x20, 0x40, 0x20, 0x1F}, // 86 V
    {0x3F, 0x40, 0x38, 0x40, 0x3F}, // 87 W
    {0x63, 0x14, 0x08, 0x14, 0x63}, // 88 X
    {0x07, 0x08, 0x70, 0x08, 0x07}, // 89 Y
    {0x61, 0x51, 0x49, 0x45, 0x43}  // 90 Z
};

void ssd1306_send_command(uint8_t cmd)
{
    i2c_start_();
    i2c_addr_(SSD1306_I2C_ADDR);
    i2c_write_(SSD1306_CTRL_CMD);
    i2c_write_(cmd);
    i2c_stop_();
}

void ssd1306_send_data(uint8_t data)
{
    i2c_start_();
    i2c_addr_(SSD1306_I2C_ADDR);
    i2c_write_(SSD1306_CTRL_DATA);
    i2c_write_(data);
    i2c_stop_();
}

void ssd1306_set_page(uint8_t page)
{
    if (page < SSD1306_PAGES) {
        ssd1306_send_command(SSD1306_SET_PAGE_START | (page & 0x07));
    }
}

void ssd1306_set_column(uint8_t column)
{
    if (column < SSD1306_WIDTH) {
        ssd1306_send_command(0x00 | (column & 0x0F));
        ssd1306_send_command(0x10 | ((column >> 4) & 0x0F));
    }
}

void ssd1306_clear_display(void)
{
    memset(display_buffer, 0, sizeof(display_buffer));
}

void ssd1306_update_screen(void)
{
    uint8_t page, col;
    
    for (page = 0; page < SSD1306_PAGES; page++) {
        ssd1306_set_page(page);
        ssd1306_set_column(0);
        
        i2c_start_();
        i2c_addr_(SSD1306_I2C_ADDR);
        i2c_write_(SSD1306_CTRL_DATA);
        
        for (col = 0; col < SSD1306_WIDTH; col++) {
            i2c_write_(display_buffer[page * SSD1306_WIDTH + col]);
        }
        
        i2c_stop_();
    }
}

void ssd1306_draw_char(uint8_t x, uint8_t y, char c, uint8_t color)
{
    uint8_t i, j;
    uint8_t col_data;
    int font_index;
    
    if (c < 32 || c > 127) return;
    font_index = c - 32;
    
    for (i = 0; i < 5; i++) {
        col_data = font5x8[font_index][i];
        for (j = 0; j < 8; j++) {
            if (col_data & (1 << j)) {
                uint16_t index = x + i + ((y + j) / 8) * SSD1306_WIDTH;
                uint8_t bit = 1 << ((y + j) % 8);
                if (color) {
                    display_buffer[index] |= bit;
                } else {
                    display_buffer[index] &= ~bit;
                }
            }
        }
    }
}

void ssd1306_draw_string(uint8_t x, uint8_t y, const char *str, uint8_t color)
{
    while (*str) {
        ssd1306_draw_char(x, y, *str, color);
        x += 6;  // 5 pixels width + 1 pixel space
        str++;
        if (x > SSD1306_WIDTH - 5) {
            x = 0;
            y += 8;
        }
    }
}

void ssd1306_display_on(void)
{
    ssd1306_send_command(SSD1306_DISPLAY_ON);
}

void ssd1306_display_off(void)
{
    ssd1306_send_command(SSD1306_DISPLAY_OFF);
}

void ssd1306_init(void)
{
    // Initialize OLED with proper sequence
    ssd1306_send_command(SSD1306_DISPLAY_OFF);
    ssd1306_send_command(0xA8);  // Set multiplex ratio
    ssd1306_send_command(0x3F);  // 64 lines
    ssd1306_send_command(0xD3);  // Set display offset
    ssd1306_send_command(0x00);
    ssd1306_send_command(0x40);  // Set start line
    ssd1306_send_command(0xA0);  // Segment remap
    ssd1306_send_command(0xC0);  // COM scan direction
    ssd1306_send_command(0xDA);  // COM pins
    ssd1306_send_command(0x12);
    ssd1306_send_command(0x81);  // Contrast
    ssd1306_send_command(0x7F);
    ssd1306_send_command(0xA4);  // Display all on resume
    ssd1306_send_command(0xA6);  // Normal display
    ssd1306_send_command(0xD5);  // Display clock
    ssd1306_send_command(0x80);
    ssd1306_send_command(0x8D);  // Charge pump
    ssd1306_send_command(0x14);  // Enable charge pump
    
    ssd1306_clear_display();
    ssd1306_display_on();
}