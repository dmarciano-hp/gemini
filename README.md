# Gemini - STM32H7 Dual-Core Project

A dual-core embedded project for the STM32H745 microcontroller, featuring separate firmware for both Cortex-M7 and Cortex-M4 cores.

## Overview

This project demonstrates a dual-core implementation on the STM32H745 microcontroller:
- **Cortex-M7 Core**: High-performance core for computationally intensive tasks
- **Cortex-M4 Core**: Real-time processing core with DSP capabilities

## Project Structure

```
gemini/
├── m4/                     # Cortex-M4 core firmware
│   ├── CMakeLists.txt
│   ├── main.c
│   └── startup_stm32h745xx.s
├── m7/                     # Cortex-M7 core firmware
│   ├── CMakeLists.txt
│   ├── main.c
│   └── startup_stm32h745xx.s
├── lib/                    # Shared libraries
│   ├── CMSIS/              # ARM CMSIS library
│   └── STM32H7xx_HAL_Driver/  # STM32 HAL library
├── linker/                # Linker scripts
│   ├── STM32H745XI_M4_flash.ld
│   └── STM32H745XI_M7_flash.ld
├── cmake/                 # CMake configuration
│   └── arm_gcc_toolchain.cmake
├── build/                 # Build output directory
├── CMakeLists.txt         # Main CMake configuration
├── CMakePresets.json      # CMake presets for different builds
└── build.sh               # Build script
```

## Prerequisites

- ARM GCC toolchain (arm-none-eabi-gcc)
- CMake (version 3.15 or higher)
- Make utility
- ST-Link tools (for flashing)

### Installing Prerequisites (Ubuntu/Debian)

```bash
# Install ARM GCC toolchain
sudo apt update
sudo apt install gcc-arm-none-eabi

# Install CMake
sudo apt install cmake

# Install build tools
sudo apt install build-essential

# Install ST-Link tools
sudo apt install stlink-tools
```

## Building the Project

### Quick Build

Use the provided build script:

```bash
# Build for Cortex-M4 (default)
./build.sh 1

# Build for Cortex-M7
./build.sh 2
```

### Manual Build

#### Build for Cortex-M4 Core

```bash
cmake --preset cm4_build_dev
cmake --build build/cm4_build_dev
```

#### Build for Cortex-M7 Core

```bash
cmake --preset cm7_build_dev
cmake --build build/cm7_build_dev
```

### Available Build Presets

- `cm4_build_dev`: Development build for Cortex-M4
- `cm7_build_dev`: Development build for Cortex-M7
- `debug`: Debug build configuration
- `release`: Release build configuration

## Configuration

The project uses CMake cache variables for configuration:

- `CFG_CORE`: Target core (`M4` or `M7`)
- `CFG_BUILD_TYPE`: Build type (`DEV`, `Debug`, `Release`)

## Firmware Features

### Cortex-M4 Core
- Basic loop with 1000 iterations
- Development build debug output
- Conditional compilation with `DEV_BUILD` macro

### Cortex-M7 Core
- Basic loop with 2000 iterations
- Printf output for core identification

## Hardware Support

- **Target MCU**: STM32H745XI
- **Cores**: Dual Cortex-M7 @ 480MHz + Cortex-M4 @ 240MHz
- **Flash**: 2MB
- **RAM**: 1MB

## Development

### Adding New Features

1. Choose the appropriate core (M4 for real-time tasks, M7 for performance)
2. Modify the respective `main.c` file in `M4/` or `M7/` directory
3. Update `CMakeLists.txt` if adding new source files
4. Rebuild using the build script

### Debug Configuration

The project includes development build configuration with debug symbols and additional logging. Use the `DEV_BUILD` macro for conditional debug code.

## Flashing

After building, the binaries will be located in:
- `build/cm4_build_dev/M4/` for Cortex-M4 firmware
- `build/cm7_build_dev/M7/` for Cortex-M7 firmware

Use ST-Link tools to flash the binaries to the respective cores.

## License

This project uses libraries with various licenses:
- CMSIS: See `lib/CMSIS/LICENSE.txt`
- STM32 HAL Driver: See `lib/STM32H7xx_HAL_Driver/LICENSE.txt`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on both cores if applicable
5. Submit a pull request

## Troubleshooting

### Common Issues

1. **Build fails with toolchain error**: Ensure ARM GCC toolchain is installed and in PATH
2. **CMake preset not found**: Verify CMake version is 3.15 or higher
3. **Linker errors**: Check that the correct linker script is being used for the target core

### Getting Help

- Check the build logs in the `build/` directory
- Verify all prerequisites are installed
- Ensure the correct preset is being used for your target core
