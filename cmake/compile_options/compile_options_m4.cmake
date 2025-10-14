
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
