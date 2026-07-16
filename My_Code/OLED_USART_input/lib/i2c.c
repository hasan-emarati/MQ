/*
 * i2c.c - I2C Library Implementation
 */

#include "stm8.h"
#include "i2c.h"

/*=============================================
                I2C Functions
===============================================*/
void i2c_init(unsigned long freq_hz, unsigned long speed_hz)
{
    unsigned short ccr_value;
    unsigned char freq_mhz = freq_hz / 1000000;
    
    // Enable I2C clock
    CLK_PCKENR1 |= (1 << 0);
    
    // Set I2C frequency
    I2C_FREQR = freq_mhz;
    
    // Calculate CCR value
    if(speed_hz <= 100000) {
        // Standard mode (100 kHz)
        ccr_value = (freq_hz / (2 * speed_hz));
        I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
        I2C_CCRH = 0x00;
    } else {
        // Fast mode (400 kHz)
        ccr_value = (freq_hz / (3 * speed_hz));
        I2C_CCRL = (unsigned char)(ccr_value & 0xFF);
        I2C_CCRH = 0x80;  // Fast mode
    }
    
    // Set rise time
    I2C_TRISER = freq_mhz + 1;
    
    // Configure I2C pins (PB4=SCL, PB5=SDA)
    PB_DDR |= (1 << 4) | (1 << 5);   // Output
    PB_CR1 |= (1 << 4) | (1 << 5);   // Pull-up enabled
    PB_CR2 &= ~((1 << 4) | (1 << 5)); // Slow speed
    
    // Enable I2C peripheral
    I2C_CR1 |= I2C_PE;
}

void i2c_start(void)
{
    I2C_CR2 |= I2C_START;
    while (!(I2C_SR1 & I2C_SB));
}

void i2c_stop(void)
{
    I2C_CR2 |= I2C_STOP;
    while (I2C_SR3 & 0x01);  // Wait for MSL bit to clear
}

void i2c_write(unsigned char data)
{
    I2C_DR = data;
    while (!(I2C_SR1 & I2C_TXE));
}

void i2c_send_addr(unsigned char addr)
{
    i2c_write(addr);
    while (!(I2C_SR3 & 0x01));  // Check master mode
}

unsigned char i2c_write_data(unsigned char addr, unsigned char* data, unsigned char len)
{
    unsigned char i;
    
    // Send start and address
    i2c_start();
    i2c_send_addr(addr);
    
    // Send data bytes
    for(i = 0; i < len; i++) {
        i2c_write(data[i]);
        while (!(I2C_SR1 & I2C_BTF));
    }
    
    // Send stop
    i2c_stop();
    
    return I2C_OK;
}

unsigned char i2c_read_data(unsigned char addr, unsigned char* buffer, unsigned char len)
{
    unsigned char i;
    
    if(len == 0) return I2C_OK;
    
    // Send start and address with read bit
    i2c_start();
    i2c_send_addr(addr | 0x01);  // Set read bit
    
    // Read data bytes
    for(i = 0; i < len; i++) {
        if(i == (len - 1)) {
            // Last byte: NACK
            I2C_CR2 &= ~I2C_ACK;
        } else {
            // Not last byte: ACK
            I2C_CR2 |= I2C_ACK;
        }
        
        while (!(I2C_SR1 & I2C_RXNE));
        buffer[i] = I2C_DR;
    }
    
    // Send stop
    i2c_stop();
    
    return I2C_OK;
}

void i2c_reset(void)
{
    // Disable I2C
    I2C_CR1 &= ~I2C_PE;
    
    // Software reset
    I2C_CR2 |= I2C_SWRST;
    unsigned int i;
    for(i = 0; i < 100; i++) nop();
    I2C_CR2 &= ~I2C_SWRST;
    
    // Re-enable I2C
    I2C_CR1 |= I2C_PE;
}