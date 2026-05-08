/*
 * i2c.c
 * I2C library implementation for STM8S003F3
 */

#include "i2c.h"

void i2c_init(uint32_t clock_hz, uint32_t i2c_clock_hz)
{
    // 1. Disable I2C peripheral
    I2C_CR1 &= ~I2C_PE;
    
    // 2. Set input clock frequency (MHz)
    uint8_t freq = clock_hz / 1000000;
    I2C_FREQR = freq;
    
    // 3. Configure clock control register for 100kHz or 400kHz speed
    uint16_t ccr;
    if (i2c_clock_hz == 400000) {
        // Fast mode (400kHz)
        ccr = freq / (2 * (i2c_clock_hz / 100000));
        I2C_CCRH = 0x80;  // Fast mode
    } else {
        // Standard mode (100kHz)
        ccr = freq / (2 * (i2c_clock_hz / 100000));
        I2C_CCRH = 0x00;  // Standard mode
    }
    
    I2C_CCRL = ccr & 0xFF;
    I2C_CCRH |= (ccr >> 8) & 0xFF;
    
    // 4. Configure TRISE (maximum rise time)
    if (i2c_clock_hz == 400000) {
        I2C_TRISER = (freq * 300 / 1000) + 1;  // 300ns for fast mode
    } else {
        I2C_TRISER = freq + 1;  // 1000ns for standard mode
    }
    
    // 5. Set own device address (for slave mode - optional)
    I2C_OARH = 0x40;  // 7-bit address
    I2C_OARL = 0x00;
    
    // 6. Enable automatic ACK for Master mode
    I2C_CR2 |= I2C_ACK;
    
    // 7. Enable I2C peripheral
    I2C_CR1 |= I2C_PE;
    
    // 8. Short delay for stabilization
    for (uint8_t i = 0; i < 10; i++) {
        __asm__("nop");
    }
}

void i2c_start(void)
{
    // Wait for bus to be free
    i2c_wait_bus_free();
    
    // Generate START condition
    I2C_CR2 |= I2C_START;
    
    // Wait for START bit to be sent (SB flag)
    while (!(I2C_SR1 & I2C_SB));
}

void i2c_stop(void)
{
    // Generate STOP condition
    I2C_CR2 |= I2C_STOP;
    
    // Wait for return to Slave mode
    while (I2C_SR3 & I2C_MSL);
}

void i2c_write_byte(uint8_t data)
{
    // Send data to buffer
    I2C_DR = data;
    
    // Wait for TX buffer to be empty
    while (!(I2C_SR1 & I2C_TXE));
}

uint8_t i2c_read_byte(uint8_t ack)
{
    uint8_t data;
    
    // Configure ACK/NACK before receiving
    if (ack) {
        I2C_CR2 |= I2C_ACK;   // Send ACK (continue reading)
    } else {
        I2C_CR2 &= ~I2C_ACK;  // Send NACK (stop reading)
    }
    
    // Wait for data reception to complete
    while (!(I2C_SR1 & I2C_BTF));
    
    // Read data from buffer
    data = I2C_DR;
    
    return data;
}

uint8_t i2c_send_address(uint8_t addr, uint8_t read)
{
    uint8_t status;
    
    // Send address with read/write direction
    i2c_write_byte((addr << 1) | read);
    
    // Wait for ADDR flag
    while (!(I2C_SR1 & I2C_ADDR));
    
    // Read SR3 to clear ADDR flag
    status = I2C_SR3;
    
    return status;
}

uint8_t i2c_is_busy(void)
{
    return (I2C_SR3 & I2C_BUSY);
}

void i2c_wait_bus_free(void)
{
    uint16_t timeout = 0;
    while (i2c_is_busy() && timeout < 10000) {
        timeout++;
        for (uint8_t i = 0; i < 10; i++) {
            __asm__("nop");
        }
    }
}

uint8_t i2c_write_data(uint8_t dev_addr, uint8_t reg_addr, uint8_t *data, uint8_t len)
{
    uint8_t i;
    
    // Start communication
    i2c_start();
    
    // Send device address (write direction)
    if (!i2c_send_address(dev_addr, 0)) {
        i2c_stop();
        return 0;
    }
    
    // Send register address
    i2c_write_byte(reg_addr);
    
    // Send data bytes
    for (i = 0; i < len; i++) {
        i2c_write_byte(data[i]);
    }
    
    // Stop communication
    i2c_stop();
    
    return 1;
}

uint8_t i2c_read_data(uint8_t dev_addr, uint8_t reg_addr, uint8_t *data, uint8_t len)
{
    uint8_t i;
    
    // Start communication
    i2c_start();
    
    // Send device address (write direction for register selection)
    if (!i2c_send_address(dev_addr, 0)) {
        i2c_stop();
        return 0;
    }
    
    // Send register address
    i2c_write_byte(reg_addr);
    
    // Generate RESTART condition
    i2c_start();
    
    // Send device address (read direction)
    if (!i2c_send_address(dev_addr, 1)) {
        i2c_stop();
        return 0;
    }
    
    // Read data bytes
    for (i = 0; i < len; i++) {
        // Send NACK for last byte, ACK for others
        data[i] = i2c_read_byte(i < (len - 1));
    }
    
    // Stop communication
    i2c_stop();
    
    return 1;
}

// ============================================
// Legacy functions for compatibility with SSD1306
// These functions use underscore naming convention
// ============================================

void i2c_start_(void)
{
    i2c_start();
}

void i2c_stop_(void)
{
    i2c_stop();
}

void i2c_write_(unsigned char ch)
{
    i2c_write_byte(ch);
}

void i2c_addr_(unsigned char addr)
{
    i2c_write_byte(addr);
    while (!(I2C_SR3 & 1));  // Check master mode
}