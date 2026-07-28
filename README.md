# Integration CAR KIT 88C0 GMSL

Jetson-based radar demo platform integrating the CTRX8188F with GMSL (Gigabit Multimedia Serial Link) deserializer/serializer chips (MAX96712 / MAX96717).

## Quick Start

```bash
./run.sh
```

## Prerequisites

- Jetson platform with custom device tree blob (DTB) for GMSL support
- MAX96712 deserializer + MAX96717 serializer configured for CTRX8188F
- `i2ctransfer` and `busybox devmem` utilities available
- Kernel module `radar.ko` built for the target kernel

## Setup StepsV

### 1. Device Tree & Pinmux

Apply the custom DTB to enable the GMSL I2C bus and SPI interfaces:

```bash
# Install DTB
sudo cp GDCU4XL/tegra234-p3701-0004-p3737-0000.dtb /boot/
```

### 2. Camera Board POC Init

Initializes the PoC (Power over Coax) and enables the power/enable signals for the MAX96712 on the camera board:

```bash
sudo ./GDCU4XL/01_camera_board_poc_init_for_con16000.sh [I2C_BUS]
```

- `I2C_BUS` defaults to `0`
- Example: `sudo ./GDCU4XL/01_camera_board_poc_init_for_con16000.sh 8`

### 3. Configure MAX96712 & MAX96717

Configures the GMSL deserializer (MAX96712) and serializer (MAX96717) for the CTRX8188F radar sensor:

```bash
sudo ./GDCU4XL/02_config_max96712_max96717_for_ctrx8188f.sh [I2C_BUS]
```

- `I2C_BUS` defaults to `8`
- Sets up: reset, 4-lane mode, 2×4 mode, RAW12 format, SPI bridge

### 4. Change Pinmux

Configures pin multiplexing for the GMSL SPI and control signals:

```bash
sudo ./GDCU4XL/03_change_pinmux.sh
```

### 5. Load Radar Kernel Module

```bash
sudo insmod GDCU4XL/radar.ko
```

### 6. Run Radar Demo

Builds and runs the CTRX8188F GMSL example application:

```bash
./GDCU4XL/04_run_radar.sh
```

## Directory Structure

```
.
├── run.sh                          # Entry point — runs all steps sequentially
├── GDCU4XL/
│   ├── 01_camera_board_poc_init_for_con16000.sh   # PoC & power init
│   ├── 02_config_max96712_max96717_for_ctrx8188f.sh # GMSL chip config
│   ├── 03_change_pinmux.sh         # Pinmux configuration
│   ├── 04_run_radar.sh            # Build & run radar demo
│   ├── radar.ko                    # Radar kernel module
│   └── tegra234-p3701-0004-p3737-0000.dtb  # Custom DTB
├── src/
│   └── demo_app/                   # Radar demo application source
├── scripts/                        # Utility scripts
├── artifacts/                      # DTB & SPI kernel module artifacts
└── documentation/                  # Troubleshooting guides
```

## Troubleshooting

See [documentation/TROUBLESHOOTING.md](documentation/TROUBLESHOOTING.md) and [documentation/TROUBLESHOOTING_GMSL.md](documentation/TROUBLESHOOTING_GMSL.md).