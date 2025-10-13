# M7 CMake configuration

set(M7_SOURCES
    ${CMAKE_SOURCE_DIR}/m7/main.c
    ${CMAKE_SOURCE_DIR}/m7/startup_stm32h745xx.s
    ${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c
    ${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c
)

add_executable(${PROJECT_NAME} ${M7_SOURCES})

add_subdirectory(inc)

# M7 specific flags
target_compile_options(${PROJECT_NAME} PRIVATE
    -mcpu=cortex-m7
    -mthumb
    -mfpu=fpv5-d16
    -mfloat-abi=softfp
    -DCORE_CM7=1
    -DUSE_HAL_DRIVER
    -DSTM32H745xx
)

target_link_options(${PROJECT_NAME} PRIVATE
    # -T${CMAKE_SOURCE_DIR}/linker/STM32H745XI_M7_flash.ld
    -nostartfiles
    -Wl,--gc-sections
)

message("Building Binary")
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}> ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.bin
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>
)