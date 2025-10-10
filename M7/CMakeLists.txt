cmake_minimum_required(VERSION 3.15)

set(M7_SOURCES
    main.c
    startup_stm32h745xx.s
)

add_executable(M7_CORE ${M7_SOURCES})

# M7 specific flags
target_compile_options(M7_CORE PRIVATE
    -mcpu=cortex-m7
    -mthumb
    -mfpu=fpv5-d16
    -mfloat-abi=hard
    -DCORE_CM7=1
    -DUSE_HAL_DRIVER
    -DSTM32H745xx
)

target_link_options(M7_CORE PRIVATE
    -T${CMAKE_SOURCE_DIR}/linker/STM32H745XI_M7_flash.ld
    -nostartfiles
    -Wl,--gc-sections
)

add_custom_command(TARGET M7_CORE POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:M7_CORE> ${CMAKE_BINARY_DIR}/M7_CORE.bin
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:M7_CORE>
)