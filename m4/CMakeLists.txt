cmake_minimum_required(VERSION 3.15)

set(M4_SOURCES
    main.c
    startup_stm32h745xx.s
)

add_executable(${PROJECT_NAME} ${M4_SOURCES})
# add_executable(M4_CORE ${M4_SOURCES})

# M4 specific flags
target_compile_options(${PROJECT_NAME} PRIVATE
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv5-d16
    -mfloat-abi=hard
    -DCORE_CM4=1
    -DUSE_HAL_DRIVER
    -DSTM32H745xx
)

target_link_options(${PROJECT_NAME} PRIVATE
    -T${CMAKE_SOURCE_DIR}/linker/STM32H745XI_M4_flash.ld
    -nostartfiles
    -Wl,--gc-sections
)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}> ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.bin
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>
)