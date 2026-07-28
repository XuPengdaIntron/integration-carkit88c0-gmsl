#ifndef HW_DEFINITIONS_CARKIT88C0_GMSL_H
#define HW_DEFINITIONS_CARKIT88C0_GMSL_H

#include <stdint.h>

#define GPIO_CHIP_0_ID 0
#define GPIO_CHIP_1_ID 1

// gpiochip 0 registered GPIOs 348 - 511
// gpiochip 1 registered GPIOs 316 - 347
// to get the offset for gpioXXX simply calculate XXX - lower base number
// e.g. gpio444 is on gpiochip0 so calculate 444 - 348 = 96

#define GPIO_OFFSET_RES_N   1   // PP.01 (gpio441)
#define GPIO_OFFSET_RFT     2   // PBB.02 (gpio236)
#define GPIO_OFFSET_OK      3  // PAC.04 (gpio490)
#define GPIO_OFFSET_DMUX1   4  // PAC.01 (gpio487)
#define GPIO_OFFSET_DMUX2   5    // PAA.04 (gpio320)
#define GPIO_OFFSET_SPI_RO  80   // PM.04 (gpiochip0 80)
#define GPIO_OFFSET_SPI_BNE 101  // PQ.01  (gpiochip0 101)

#define GPIO_ID_RES_N   (((GPIO_CHIP_0_ID & 0xFF) << 8) | (GPIO_OFFSET_RES_N & 0xFF))
#define GPIO_ID_RFT     (((GPIO_CHIP_1_ID & 0xFF) << 8) | (GPIO_OFFSET_RFT & 0xFF))
#define GPIO_ID_OK      (((GPIO_CHIP_0_ID & 0xFF) << 8) | (GPIO_OFFSET_OK & 0xFF))
#define GPIO_ID_DMUX1   (((GPIO_CHIP_0_ID & 0xFF) << 8) | (GPIO_OFFSET_DMUX1 & 0xFF))
#define GPIO_ID_DMUX2   (((GPIO_CHIP_1_ID & 0xFF) << 8) | (GPIO_OFFSET_DMUX2 & 0xFF))
#define GPIO_ID_SPI_RO  (((GPIO_CHIP_0_ID & 0xFF) << 8) | (GPIO_OFFSET_SPI_RO & 0xFF))
#define GPIO_ID_SPI_BNE (((GPIO_CHIP_0_ID & 0xFF) << 8) | (GPIO_OFFSET_SPI_BNE & 0xFF))


#endif  // HW_DEFINITIONS_CARKIT88C0_GMSL_H