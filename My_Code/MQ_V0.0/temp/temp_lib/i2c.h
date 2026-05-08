#ifndef __I2C_H
#define __I2C_H

#include "stm8.h"
#include <stdint.h>

// Bits not defined in stm8.h
#ifndef I2C_SB
#define I2C_SB       (1 << 0)
#endif

#ifndef I2C_ADDR
#define I2C_ADDR     (1 << 1)
#endif

#ifndef I2C_BTF
#define I2C_BTF      (1 << 2)
#endif

#ifndef I2C_TXE
#define I2C_TXE      (1 << 7)
#endif

#ifndef I2C_START
#define I2C_START    (1 << 0)
#endif

#ifndef I2C_STOP
#define I2C_STOP     (1 << 1)
#endif

#ifndef I2C_ACK
#define I2C_ACK      (1 << 2)
#endif

#ifndef I2C_PE
#define I2C_PE       (1 << 0)
#endif

#ifndef I2C_MSL
#define I2C_MSL      (1 << 0)
#endif

#ifndef I2C_BUSY
#define I2C_BUSY     (1 << 1)
#endif

// Function prototypes
void i2c_init(uint32_t clock_hz, uint32_t i2c_clock_hz);
void i2c_start(void);
void i2c_stop(void);
void i2c_write_byte(uint8_t data);
uint8_t i2c_read_byte(uint8_t ack);
uint8_t i2c_send_address(uint8_t addr, uint8_t read);
uint8_t i2c_write_data(uint8_t dev_addr, uint8_t reg_addr, uint8_t *data, uint8_t len);
uint8_t i2c_read_data(uint8_t dev_addr, uint8_t reg_addr, uint8_t *data, uint8_t len);
uint8_t i2c_is_busy(void);
void i2c_wait_bus_free(void);

// Legacy functions (underscore version) for SSD1306
void i2c_start_(void);
void i2c_stop_(void);
void i2c_write_(unsigned char ch);
void i2c_addr_(unsigned char addr);

#endif