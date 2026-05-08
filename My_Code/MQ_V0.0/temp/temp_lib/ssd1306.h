#ifndef __SSD1306_H
#define __SSD1306_H

#include <stdint.h>

// SSD1306 I2C address
#define SSD1306_I2C_ADDR        0x78

// SSD1306 control bytes
#define SSD1306_CTRL_CMD        0x00
#define SSD1306_CTRL_DATA       0x40

// SSD1306 commands
#define SSD1306_SET_CONTRAST    0x81
#define SSD1306_DISPLAY_ALL_ON_RESUME 0xA4
#define SSD1306_DISPLAY_ALL_ON  0xA5
#define SSD1306_NORMAL_DISPLAY  0xA6
#define SSD1306_INVERSE_DISPLAY 0xA7
#define SSD1306_DISPLAY_OFF     0xAE
#define SSD1306_DISPLAY_ON      0xAF
#define SSD1306_SET_PAGE_START  0xB0

// Display dimensions
#define SSD1306_WIDTH           128
#define SSD1306_HEIGHT          64
#define SSD1306_PAGES           8

// Function prototypes
void ssd1306_init(void);
void ssd1306_send_command(uint8_t cmd);
void ssd1306_send_data(uint8_t data);
void ssd1306_set_page(uint8_t page);
void ssd1306_set_column(uint8_t column);
void ssd1306_clear_display(void);
void ssd1306_update_screen(void);
void ssd1306_draw_string(uint8_t x, uint8_t y, const char *str, uint8_t color);
void ssd1306_display_on(void);
void ssd1306_display_off(void);

#endif