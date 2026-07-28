#!/bin/bash

I2C_BUS=${1:-0}
#init poc of the max96712 02 at the CON16000 port
i2ctransfer -y $I2C_BUS w2@0x25 0x06 0x00
i2ctransfer -y $I2C_BUS w2@0x25 0x07 0x3f
sleep 0.1
i2ctransfer -y $I2C_BUS w2@0x25 0x02 0x00
sleep 0.1
i2ctransfer -y $I2C_BUS w2@0x25 0x02 0xff

#init the pwden of the max96712 02 at the camera A
i2ctransfer -y $I2C_BUS w2@0x27 0x06 0xEE
sleep 0.1
i2ctransfer -y $I2C_BUS w2@0x27 0x02 0x00
sleep 0.1
i2ctransfer -y $I2C_BUS w2@0x27 0x02 0xff
#init the errb of the max96712 at the camera A
i2ctransfer -y $I2C_BUS w2@0x23 0x06 0xff
