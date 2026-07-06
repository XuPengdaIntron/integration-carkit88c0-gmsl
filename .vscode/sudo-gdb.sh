#!/bin/bash
# Wrapper to run gdb with sudo for hardware access (I2C, GPIO, SPI)
exec sudo /usr/bin/gdb "$@"
