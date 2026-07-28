#!/bin/bash

if [ ! -d /proc/device-tree/i2c@31e0000/ctrx8188f_a@61/ ]; then
    echo "ERROR: /proc/device-tree/i2c@31e0000/ctrx8188f_a@61/ not found, please fix .dtb"
    exit 1
fi

sudo rmmod radar

sudo sh -c 'echo "fixed-regulators:regulator@106" > /sys/bus/platform/drivers/reg-fixed-voltage/unbind'

# sudo ./GDCU4XL/01_camera_board_poc_init_for_con16000.sh 0
sudo ./GDCU4XL/02_config_max96712_max96717_for_ctrx8188f.sh 8
sudo ./GDCU4XL/03_change_pinmux.sh

sudo insmod GDCU4XL/radar.ko

if [ ! -e /dev/video0 ]; then
    echo "ERROR: /dev/video0 not found — please fix radar.ko"
    exit 1
fi

./GDCU4XL/04_run_radar.sh
