/*
 * i2c.h - I2C Library for STM8S003F3
 */

#ifndef _I2C_H
#define _I2C_H

/*=============================================
                I2C Defines
===============================================*/
// I2C Speed modes
#define I2C_SPEED_STANDARD   100000  // 100 kHz
#define I2C_SPEED_FAST       400000  // 400 kHz

// I2C Status codes
#define I2C_OK          0
#define I2C_ERROR       1
#define I2C_TIMEOUT     2
#define I2C_BUSY        3

/*=============================================
                Function Prototypes
===============================================*/
// Initialization
void i2c_init(unsigned long freq_hz, unsigned long speed_hz);

// Basic operations (same as your original functions)
void i2c_start(void);
void i2c_stop(void);
void i2c_write(unsigned char data);
void i2c_send_addr(unsigned char addr);

// High-level operations
unsigned char i2c_write_data(unsigned char addr, unsigned char* data, unsigned char len);
unsigned char i2c_read_data(unsigned char addr, unsigned char* buffer, unsigned char len);

// Utility functions
void i2c_reset(void);

#endif /* _I2C_H */