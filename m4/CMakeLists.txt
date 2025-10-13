# M4 CMake configuration

set(M4_SOURCES
    ${CMAKE_SOURCE_DIR}/m4/main.c
    ${CMAKE_SOURCE_DIR}/m4/startup_stm32h745xx.s
    ${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c
    ${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c
)

add_executable(${PROJECT_NAME} ${M4_SOURCES})

add_subdirectory(inc)

# M4 specific flags
target_compile_options(${PROJECT_NAME} PRIVATE
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=softfp
    -DCORE_CM4=1
    -DUSE_HAL_DRIVER
    -DSTM32H745xx
)

target_link_options(${PROJECT_NAME} PRIVATE
    # -T${CMAKE_SOURCE_DIR}/linker/STM32H745XI_M4_flash.ld
    -nostartfiles
    -Wl,--gc-sections
)

message("Building Binary")
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}> ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.bin
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>
)
